Return-Path: <linux-kernel+bounces-323452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C9973D67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AAC1C24570
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E01A2564;
	Tue, 10 Sep 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MpW76hMd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222F16C684
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985987; cv=none; b=oO1WXVcDae6Hopk06Wp5XHJ4iikC+hYt+/0arb0+Jj6NYPE7l9ITRQy/W47GYpUxzmsx/aXjKXyqZnxTe9g+m3BnRMZJDtlcwTKzyzmRmG541Hw33cunY6L1QGghZMs0le8BmkhqgVQcMq7Q4vdry/o6aoV4n3ajFtDLLOxzA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985987; c=relaxed/simple;
	bh=pDGy9FTtIgMzLOt/7iSJ+WMuYgXATN9TotjMM+SoczQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZOXYlhJM+PI88bps9LAh+lxD6CfifrM4DOgnl+BEJ4VbrYZ889jqc946HkKEUgFvfyd+lZloT8/yeU3+l0DhoW5zpK1cxtqkZCpzKmXvyF4BRE93pBJgojByGnATzS6x0rlTephlvdqx97OAS66gIlqk51rXpKBcWS2TMnmnTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MpW76hMd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so9925865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985982; x=1726590782; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rF4WxN3Aj+tIaFqCtKKzlber4t4h2cbw8FO6Wko2I8=;
        b=MpW76hMdI57nxPL1VCzntJfjf7ZcOaXdWLg0EPh+/f4oI2lsWB8cAHOyMmmTR/jR2C
         kAnfod8tXqfH8mgUIWO1/eGMU7TSU1HCfBB8pHY37oo5iNjtFSrb71j0WBHB+Lf30Z9J
         hpulCUV4DWeqrWxi58dKGaWhWT8C9MCKMoY6e4U3IJpKk34Edj997ICB9jwjS+aaHbUj
         WEdBOo9cYW/N1THwZUktpP1x5ASvUxCC5W1RUuD3Q8RSUcPEnlKuDzFj7ySW1qbbNUIT
         2W3sy3S96wHvmL48cmXBl/HM1Is/fRRBFPb06//45PlWg19yZ/7kb/ct3+vaL9hBqdi/
         LRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985982; x=1726590782;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rF4WxN3Aj+tIaFqCtKKzlber4t4h2cbw8FO6Wko2I8=;
        b=idK0m9W+rAjPLD2A74U2PgZrwCmsmydIkt9OsYBj7jNUKD67X++SS2o8vOIVv5mrq0
         tzqG5LnpGN2+WGzOJY3LWui1nQutWqNdRC5MphUREc+1NknHt+v/JX1zMFyNIBxsWbU4
         Ei/8qu7CRApqKq5yp9qqU5keDxVrxsO3UipsTDKt4mDK3CgefTicfpoHzeHYQfXcgqNO
         Mhcd0yNWAxV+iORpvjHwfm5WirHs8Nj6RYqr42G6tU7HyawInVCb3fFQRYNNXdzTyAXv
         pB0+UPVSE7ma6U45Z3JJQdPKE/Q2sATnsPQ5nhs+r4TyDSGBFJ/ZtxU7FhnUiItXNNKo
         nDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDJRFnnXtNtkECpXp/Y3pkauVtQIWLLsnhHyfFhRiqIo7iy2Qo0c9ge2AaTRx4If9BCK3Rtm/jYhzr9kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSEXWVjE8nspvek/MW+SEIx1NEodEM8VNmpcaGAHf1XQGFvKF
	VI/aXTtB/wd/ZuoeI0VwTnk/FM4dcrO0VoRk9EvH9nVbwlQSsPplvnVBrRdlYIY=
X-Google-Smtp-Source: AGHT+IHA4mhUQ8IpGyrkqlJwG0IpNcAqkgqpxSzPNFkQXfsP6ffvp11Br7N7eiwP2ee1qbWlfvpNAw==
X-Received: by 2002:a05:600c:1d98:b0:42c:b995:20c8 with SMTP id 5b1f17b1804b1-42cb9952455mr51372865e9.24.1725985982016;
        Tue, 10 Sep 2024 09:33:02 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:01 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v5 0/9] reset: amlogic: move audio reset drivers out of CCF
Date: Tue, 10 Sep 2024 18:32:42 +0200
Message-Id: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKp04GYC/3XOOw7CMBBF0a0g1wwaGwOGin2gFP4MxIjEaJxEi
 aLsHUODKChv8Y7eLDJxpCxOq1kwDTHH1JbYrVfC17a9EcRQWihUGo+4h4ZyaoFzB7YfwR6UCx6
 lC5JE2TyZrnH8eJeq9JVTA13NZL+KQSNRHbTaFHF3RA0S7o77lrqzs9MjOqaNT83bq2PuEk+fe
 4N+q/+eDBoQ0Bil/TZINO7XqpZleQHTgucD7QAAAA==
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3472; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=pDGy9FTtIgMzLOt/7iSJ+WMuYgXATN9TotjMM+SoczQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS0l+uBsef6GERcGgsGTiooyNalHzzeKeU1U
 VUTeD6RExuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0tAAKCRDm/A8cN/La
 hcgQD/0ZFct4s24VVIibOhf9mve52LEKUN0GKdDsj+wh58sMXsuxU5tWPbvzigeRVfaFvrcK2ne
 UlFjKluD0T88NknnfW2Af9rO+qdDldt4lwJNJUBePQtyVJc/Qsg7iOqRfTH+SCwUNb8vpak+Dhv
 fgE4BNi4EDEYlWSvgtAFTgzTm0RAd7DFl0uFNCHXEw1/8qqGbpk096+2GLPPsuo+xKcTgL6kScz
 xbGiP+enom6O9WvkBLiYXOdxag+YWaM2/wIoYqqXKHVPlKsxmlif6MdGGHtTVr7mYnTFcfQ2fFd
 9klTTaGBl7RNq4YVHqE8vDnYPBAQ9fxBkkkSPLvyLkLI3DW/HidUEinXhjVg60MthFzEFvsal1d
 nAyE5sNxjxLgpciZCPMFxsbcxhESBplrqh/dKWu/S7S2TrkX/sYR9qJlVMwy95HIv/UoV1xfdAb
 KrwK8VV9O9Ov5neBb4JRbWwMQqbSs0gOFXn2TTBaU382dvU3tIR8iZF6zIHw36CYBMsvnfxhNsM
 0YdLjNeAolanAayxyYIGSMlTgvQwM2PoPmBxkhRWiJWV752URGJuckEqPpuV0H3RUIeSwBceinp
 OChgzUyCTK2LtBMnn1ZeRDdzPvTXcm7T4WHv14Jja4YIZf6+y7XvmC6bhIE3N09OyoTrJKE97Q/
 jHg5RqjMdDXpWlQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset follows the discussion about having reset driver in the
clock tree [1]. Ideally those should reside in the reset part of tree.

Also the code of the amlogic reset driver is very similar between the 2
trees and could use the same driver code.

This patcheset alignes the reset drivers present in the reset and clock
then adds support for the reset driver of audio clock controller found in
the g12 and sm1 SoC family to the reset tree, using the auxiliary bus.

The infrastructure put in place is meant to be generic enough so we may
eventually also move the reset drivers in the meson8b and aoclk clock
controllers.

This was tested on sm1 vim3l and gxl aml-s905x-cc.

Changes since v4 [6]:
 * Fix Kconfig depends and select as reported by Philipp and
   and 0-day robot.

Changes since v3 [5]:
 * Drop pltf/platform as suggested

Changes since v2 [4]:
 * Fix undefined read access of the reset register
 * Fix Kconfig symbol description

Changes since v1 [3]:
 * Fixes formatting errors reported by Stephen.
 * Changed parameters type to unsigned
 * Fix usage of ops passed as parameters, previously ignored.
 * Return 0 instead of an error if reset support is absent
   to properly decouple from the clock and have a weak
   dependency
 * Split the platform and auxiliary modules in 2 distinct modules
   to fix the COMPILE_TEST error reported by ktest robot.

Change since RFC [2]:
 * Move the aux registration helper out of clock too.

[1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
[2] https://lore.kernel.org/linux-clk/20240516150842.705844-1-jbrunet@baylibre.com
[3] https://lore.kernel.org/linux-clk/20240710162526.2341399-1-jbrunet@baylibre.com
[4] https://lore.kernel.org/linux-clk/20240718095755.3511992-1-jbrunet@baylibre.com
[5] https://lore.kernel.org/linux-clk/20240808102742.4095904-1-jbrunet@baylibre.com
[6] https://lore.kernel.org/r/20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com

---
Jerome Brunet (9):
      reset: amlogic: convert driver to regmap
      reset: amlogic: use generic data matching function
      reset: amlogic: make parameters unsigned
      reset: amlogic: add driver parameters
      reset: amlogic: use reset number instead of register count
      reset: amlogic: add reset status support
      reset: amlogic: move drivers to a dedicated directory
      reset: amlogic: split the device core and platform probe
      reset: amlogic: add auxiliary reset driver support

 drivers/reset/Kconfig                              |  15 +-
 drivers/reset/Makefile                             |   3 +-
 drivers/reset/amlogic/Kconfig                      |  27 ++++
 drivers/reset/amlogic/Makefile                     |   4 +
 .../reset/{ => amlogic}/reset-meson-audio-arb.c    |   0
 drivers/reset/amlogic/reset-meson-aux.c            | 136 ++++++++++++++++++
 drivers/reset/amlogic/reset-meson-common.c         | 142 ++++++++++++++++++
 drivers/reset/amlogic/reset-meson.c                | 105 ++++++++++++++
 drivers/reset/amlogic/reset-meson.h                |  28 ++++
 drivers/reset/reset-meson.c                        | 159 ---------------------
 include/soc/amlogic/reset-meson-aux.h              |  23 +++
 11 files changed, 467 insertions(+), 175 deletions(-)
---
base-commit: 487b1b32e317b85c2948eb4013f3e089a0433d49
change-id: 20240906-meson-rst-aux-a72bdc01bd1e

Best regards,
-- 
Jerome


