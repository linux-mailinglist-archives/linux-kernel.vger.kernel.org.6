Return-Path: <linux-kernel+bounces-318940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDF96F57A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56D8283253
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895831CEAA2;
	Fri,  6 Sep 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SFrKvuBO"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D41CCB34
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629723; cv=none; b=KmFJvA1ZUEx5wnPd0Ln2XKrw/LWoxJ9zYn5ZbRchILCFaMz9CAjSWQ2Q50NaZmL+jDon2+lX35+ttwUJKDK7lGg2MWf6CHZbZOFKTPsZNTc+0bzaFPRO/TM3vt9A1UkOHxA7JV07Cl5l2w2zH8K9N24x8O8HJKuuA6EBe+o/fWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629723; c=relaxed/simple;
	bh=Zy8XGx7Pz9xI8ihyiXuhQRn7J6bXXBkEnZLes9E9AaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=coTJwHBcqrfbxYD4rEuvMskA5UrHpsAuqnJFMPkLzDC0jyszai7i9uoyz/glJbLG8R0kDN3gNOBXwIRFx+cmtnHwg6oKYq22g48Lz3ihY8jVrf4SayhV6uNLjOPdm/vIaQvZ+OLiLfGWP2czz/ZJCZm8F0e2o0esQAtiGI3ivfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SFrKvuBO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c7e64b60so1118404f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629720; x=1726234520; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqsINef6QfApstNyiYZ/qe6fj6A2ZIDvZyFkLMashjw=;
        b=SFrKvuBOn/G1H5TM7JN8B+7K+XJaWmz4tt2m7cDKfQ+5KxSPd9r2NbshU3o/mJ3j2z
         4FPBa6yvKp814LBM551b+PlfXnkGF6qEw0Ksk5cz/zC8LwmjphEN4apRlYJV4Z11xBYU
         nmvp+DhOzSrSmU1hz2ZxRgCadV8Inz+sFfHhllYMW1c7ygctXxmmb/SS32bPfvI5T3yf
         PMv8h1XloVBy69FezR+7fkU/RoAHjXJuI5CPkV934r1p+9qqraNpSYjFP2VMIxJZnV+x
         LRpYc5x6OohM55SliJFOR+oMJpqQywKvpHrUApR+szhyABXn7Oo2WMNB8ydpqsKQHSun
         FszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629720; x=1726234520;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqsINef6QfApstNyiYZ/qe6fj6A2ZIDvZyFkLMashjw=;
        b=adAoLWKrr1XoMCMHRVfxKKu2BKpTNzvJHq2jg8Gv4Eaa2HkMVRD2VbskhYiMAgOTeG
         ACfyLztasLckS6rizoy2leNS761nztfVixjbN5Sxmpi3DvgOL0gc9vLDduxudj5ZzVHx
         u9i8/xM3t8GUhiC7Jo4Xi39R4x2AnMAmJhxHhbf1jZSCI4O2DX9MJWq1kpTmk8vGj3Ix
         1xGVLIVA0QccZyOd8ExPzawSu1iJW45S6NWhZQXoGby9wypuuwWXlopt1HRLY6N0CCsl
         8CuuTSD0LPPB68zUfc/gD6QZRJZVELynDYDmt6ifXBUYLUbzUXnubNM575dvVumHYffR
         g6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiKX5EO9UQ4o2MtAxfjTR9wN+3rh4AVdVkBit3nJyHiHyirj5TKQPZ0JNPyR5DO0pbN+ykXB7bIyjGlmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnzuVczCkBl02Zq7S2XNq4g1vSnUYhEh2QYb5NfAi6h+JwBdU
	FusdizWwpyWZjP/3WunLJmvSVsBMB6cDOXxXVjylWbd1TpVlqHnh/nMZWn/OP8Csqqa5/T1Y2rN
	7
X-Google-Smtp-Source: AGHT+IFehkkKna75GAh88+0SyunaTdQfdtNnUax09bgaJD7vSsHcPJcX0846piZ3PpY8OCSraqbCZQ==
X-Received: by 2002:a5d:62c3:0:b0:374:c407:4e07 with SMTP id ffacd0b85a97d-378896a5b83mr1942649f8f.46.1725629719363;
        Fri, 06 Sep 2024 06:35:19 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:18 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v4 0/9] reset: amlogic: move audio reset drivers out of CCF
Date: Fri, 06 Sep 2024 15:34:45 +0200
Message-Id: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPUE22YC/0XMQQ6CMBBA0auQWTtk2lQBV97DuGjLIDXSmikYD
 OHuNm5cvsX/G2SWwBnO1QbC75BDigXmUIEfbbwzhr4YNGlDHZ1w4pwiSp7RLivaRrvek3K9Yij
 NS3gI6+93vRUPkiacR2H7v7TUKtKN0XU5HjsyqPDhZIk8X5z9PIMTrn2aYN+/b3cqhp8AAAA=
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Zy8XGx7Pz9xI8ihyiXuhQRn7J6bXXBkEnZLes9E9AaI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUNU+ER2XIrHr1uWuBlyVb11DIqM0PpyYs/n
 0w+pNJrhAqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFDQAKCRDm/A8cN/La
 hXgcD/4vY+/TwpUv2d9iGss5Ei5ETLzTZzezXR9fchb5UUOFfAkie9ZJ1MQ/49sa0M39yQnRIYm
 D8yRpxeCpQoTxo1xcsOkwZ2s4PNflZoNQ1YvaBi+lqtrfmWuHpZ4jwa/5SsbSaGkxX0fzJspCbX
 1Zfry90XLPq1iNQnq4HIPyACarXbeb9uGhKWHSVPjHI9hnWVre1CLr3fyVEnWmwB2GfCqjAJ0bH
 5BKimN+rh9AuSU9M0MnmhSp676j5yYNzi7KoPTGb+vpjXIOSIKtv9MZVoMrISkJ0/9M6OHHUge7
 nbd1QPEqOu007ywWJSwy5+e77z2EBNexJPaWBj2ldAuuHUfIuCl85XpSGB6ju1Vyq+FDPo4Bukk
 jTcN0nvIshXFFlBOKjwJPWwvdGcHbaYfww2Y7xJjN0XQCEhUE9jb6dE6dFxYPOOewKBBmXRUQaR
 aKs+xm/F10oxmakiYSz8lTwHcmpXmPSDy1Tl8tIWmpeQerkhQ2lAVmttNp/50M3o3VGe3/3paCy
 FVq4JwmsmmVKgVtTBbDu4UdYbBJGb3YhHzz5Cwxhev93e6Luu2HpF9AuOikX0E9wiFyq0m0BcXs
 6lHvjmwSXEFYnaI9iej1Yblnikoi/F+bqGVhK+56DLny3X9gA952P3six43XzxEa20RKyqj4QEn
 mKFNt5M+Wv3mt2A==
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


