Return-Path: <linux-kernel+bounces-437977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9810A9E9B31
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DCB1886B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF313A87C;
	Mon,  9 Dec 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XcmXHumA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E7481D1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760307; cv=none; b=qZVBg+0GdBg2YV3kwbqHwxgdyJlvaeH5nuXCleI4BFX/lwQwlfSOkUZct96U8IrsHWBpxW4wLnRwO1J7malxEyR6So9HoO8UwbCiGCT6DvOQVfzW3wd1m4130GzqGxtqjFc8ihg/qTlJXd7dBTP7U1yjj2B4tqdgeg1ItbOE6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760307; c=relaxed/simple;
	bh=evbbOU+lk70bFQXkzUYim69wTqMh7DKLswkpygTzlc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OnZeS83EPgsA7mB/fwreF4h4PkIOYUbKF1hOShjlRylUPI3pZiRMqbMRejwJX9yoSH6554gFIncjG1JdCqYqlQ4QhoPAmZRq6lVslQLmfcleXM6xs8MuO0aFgzQDTFrDzrWj6q6uWhznmVfP+wP7R2Zjic/JYGWcKfno77ViJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XcmXHumA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434f094c636so11153675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733760302; x=1734365102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZV6/jGEGN0ycOt9l71mDvvXlfIgyAlXjHfNlD6BSSA=;
        b=XcmXHumAKhIUjcn02oj4SbmwwNi5zMClJ+N9tRKGSi/rQhkGLFE44XL3aS8QNVDb1S
         maKDFFuCM/QtTraADlFqLHPgXQT7EVnU/lJH1B0wgMNvYDx2D8rMuvkRchnR9XzCukKQ
         Vw84Pd9FT1cCZ2Y0cxPHSW+9qp9S3gOhW1BwV7zTnvof17ddOsROnvki1SgunL2HUjg7
         4uWqj7scSJhZLeDGJMLUI5Os6xnQI6f5e/ZfWbJMuz5daYq6f1MkDiUdrAZ4jrkNVYjt
         X3I+d0YD1+3fmcGqY/ypu+IlAxDs+hIxYdS5sGM4sEcsXzj3VfyYRgTXBaHHrC5zqsX9
         /gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760302; x=1734365102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZV6/jGEGN0ycOt9l71mDvvXlfIgyAlXjHfNlD6BSSA=;
        b=Xvo6BkcqjzaUKOjak50fvRHWi3dxtmdjO9zXE+sH2LQSJ09vZSamKVyicKhO/QcWW7
         MEobqbbyTmO9rvN13n60c+5oGONRMfBY7nucLq+jBV+NGZHVzDrd/HFit1vjdJ9G4Ofj
         1scAluJ1bMSJQ6vKdEVf/gLAkAeF5PGRX8mzhmWc2O3IL7HT4N50GRcj1tcwIWZPKL5E
         JzNcBsdcAFNCmbbKOVtst2SFQ/5Nu/qNhHpSFeQNNw5gv8DSrtAmt28scUNjH4KWuxFU
         eTGtJTOYFbtAQ/ntwiwJFcrf97MFvgwM6Sky01vE6gG+IkxkJtf9L1C7h+pKlHjJmMMW
         ldew==
X-Forwarded-Encrypted: i=1; AJvYcCULpnHelsmai996iuBLE2OWoTJk+kRLnHpk4T5ebcTYaik2zt6r882nftLKkkTFPObv3V1i9LdeyW2TID0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1qldmrKXkP9E9mtcEwOCuWqEoXmvkbTxXYSWEhm87zRGERon
	j+enLrUbyzIaUWrc9EaSCKoQKjs/3Hk5hZEaSTyUGfVcJVtSBgxtOk9bBmDcAuU=
X-Gm-Gg: ASbGncuU2EzHH+DBD50zM4lhLThgSSD6WFkAGgLt99q9TxeqqG4bNoSJHRCK9pIwk6S
	a9RgL3Zxj8ZmE8tJ0408fFp1o3aJydxWtCIkpvfy3mjtlidB1pVcQoABbjRgkRK1gmSvBsm+8TU
	7HOzaNizw4H+sC6tRnAgSM2MRkr/ruRclcoH6n5O+JBzwTTyYb/Wvx+uwU32Ec+MOrODzO42Prg
	gKl0JdM18K9vaIKUxIv4y73kbqUNOAm9rXmL2P+EH3Jx3QUDlsQLxTYudhWRXAV
X-Google-Smtp-Source: AGHT+IF5I9z/yJYWju5kftjmnEGFEfuICa8J5jFX6BR1vJ1MZdpvs0pvrcqwWB9585oM8D3NR9VuUQ==
X-Received: by 2002:a05:600c:21d4:b0:434:fbda:1f36 with SMTP id 5b1f17b1804b1-434fbda20a1mr19800685e9.20.1733760302154;
        Mon, 09 Dec 2024 08:05:02 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:432b:3c3e:b17a:687a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f3d89b75sm61459015e9.15.2024.12.09.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:05:01 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] reset: amlogic: rework auxiliary reset support
Date: Mon, 09 Dec 2024 17:04:33 +0100
Message-Id: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEVV2cC/0WNyw6CMBBFf4V07SRtwcLwK4ZFH1OdKFRbfCTGf
 7fBhctzk3vOWxTKTEWMzVtkenDhtFRQu0b4k12OBBwqCy11p7REmKmkBXJZwd5fkOmZ8hlIG98
 r401vtKjXa6bIr017mH6c6Xav9vU3/uVjs6mV7sFfzlUaOEE9b4mZS+HlCNIN0ughYNu58bEln
 C0EPs0zr2PTBsSIulWOgo9ofXRo9hZ70+3tQD5abG0ng5g+ny9hJWmz8wAAAA==
X-Change-ID: 20241209-meson-rst-aux-rework-e26c716c6762
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>, Stephen Boyd <sboyd@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=evbbOU+lk70bFQXkzUYim69wTqMh7DKLswkpygTzlc4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnVxUqbrpv5I8zC+5JUxaNorAp8JMBdDpjGJU6s
 h/37CR27LKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ1cVKgAKCRDm/A8cN/La
 heyaEACGUxT73ntzD/EA0m+VipsjkIaKfxH8c9z+qs54HllPKjYPuai4DkVv4BVNp4AoLnpFiOQ
 1WtD65Z8lheHQ+XI50SAi/kEIPd3lPs/but/mmmSpgkkeiif8mNJ6ktANXJDb4O5VoqS+1vaDlR
 uFSx3xKZNSnXjR1zoR1slF6sD9iOBHt4qKLTez8sLBoklq5Ajvfu7QIACvyS/oBuhrQ3UY2nk0z
 /8VlCuRWu2MiGTE9Ke3b2x4hZ+5UVzK6JNhnCHNCxDUu137ri5jByI4NAr//GkuoROMEuumq3js
 SJvMD/ImZ0alJIEmluL9UGj85MOglaJaorvA4UQNeiwSrPhkIidf3iQijIn4vQaYGccdRegmIdT
 lgXuptIF9aRRomeK3vXERe2qO857BVnyDpFQtiLfQnkDQQo/LkMshfRLULiU1D8Fw+gMc3KH82w
 +4nqUxHPaoHuDH8LBeusfv/AGFUU+EWpvIZF/EfTWY11mlQI6gIWZNfxgh4p8L0hNTDvZiPjXb6
 /q2g8+i/j4SNuDRENAFNI9wV3FJm4+WkEBC4iP5HYujfc55M//CI19HIHyCCCIKImfKudHGymMJ
 UBRaa6sDAX5O7Y1KKhsuEBXtwSPfGzk0cN6jo6zgDhiZN3Los4nT8WlJgvsU7AE0JbkRs19eOfw
 99E6tb2SzePIY4A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The current implementation of auxiliary reset controller, with the
registration helper in the same module as the driver code, does not
allow to properly decouple the registered auxiliary driver from
the registering one.

This patchset removes the registration helper from the auxiliary reset
driver and changes how regmap is passed, to simplify the interface a bit.

This patcheset depends on:
commit 5ae1a43486fb ("clk: amlogic: axg-audio: revert reset implementation")

The above removes the only user of the auxiliary reset controller, restoring
old implementation as a temporary solution, while it is reworked.

The commit has been applied to clock fixes [1] branch and will eventually
make its way to an rc release.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-fixes&id=5ae1a43486fb3febd5ce78da13eb354f16d049e0

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      reset: amlogic: aux: get regmap through parent device
      reset: amlogic: aux: drop aux registration helper

 drivers/reset/amlogic/reset-meson-aux.c | 85 +++------------------------------
 include/soc/amlogic/reset-meson-aux.h   | 23 ---------
 2 files changed, 6 insertions(+), 102 deletions(-)
---
base-commit: 3d99f9231bedcf9acfb965a97645a8ecfa93a40d
change-id: 20241209-meson-rst-aux-rework-e26c716c6762
prerequisite-change-id: 20241127-clk-audio-fix-rst-missing-0b80628d934b:v2
prerequisite-patch-id: 8bf55ab8ba9db1abea5df2554864a2f4f9c72e77

Best regards,
-- 
Jerome


