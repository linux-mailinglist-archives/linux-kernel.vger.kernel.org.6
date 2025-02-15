Return-Path: <linux-kernel+bounces-516114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A3A36D11
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A7C3A5187
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D91A23B8;
	Sat, 15 Feb 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRqhU7iJ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BD1A239D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612489; cv=none; b=XA9QtJq20Mpd4ktu3zId9rj2CP17agAG8i1hR92+8hRlQByPAQ641t0L+auhXV7WJsAHPu0JDZxgAq4bM7jk6DiG8189Lx56RnGasjdCd9ajYK1y1YbwEDCQBEZy5rS39MVw2T5I7L8tSAYPUNTmMpqUyowuYPkXbKCyYKP2RHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612489; c=relaxed/simple;
	bh=vbjMydOojPbZwEg4Yl/004JI6Zw+1S1y0lku0U/6zp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPfzMfd+6Gujzub4Y8o0s4bywdtR+ZZNO6vhqFPnLWC573lS/KLrOOV1T2XkMAA+gro18kxhenpgyyINHk78lSQir20qrJ1RACXYM3JdXntkrm5D7SjD6DeFAtpBd+eK0euStzdk1mp16dRp606vJZt3YEazI7qo3cr02LDNxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rRqhU7iJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439702d77f6so64395e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739612486; x=1740217286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SxoWr2vFLkloiiVYCn5S11j3T2lrQAUOXkKWdINmvg=;
        b=rRqhU7iJvsUgnJHIEbAhhABg+yOqeNB3JGQf8zjRr0cI8CLsfcAkGB+eiLRY3THhlB
         eNk37upV9IFLwlZ5PKwjcPL5/b33toNLJmZiAbPLLVkH9MvdlhsbTmgGOH3TKXfgNKHX
         rkPSXWCoHxtOU7eB1LGeOgNLa/RXcjRtCJx2dQMvZSgG4bL6SZ3BEisaBlfl4BSVyeHx
         vULRa+eGOwwLGorJggNM/KzzEGtoPHhtxohojQ5VyCMg1TJkvwrYNVeAESy7QtV8iylL
         1RzA1pymMd1V3mv+El0oxTcAtiHUL6OUUxGmiNgH/mDezI1fj/x+fcVH/ILf8dlhCrP5
         QGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612486; x=1740217286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SxoWr2vFLkloiiVYCn5S11j3T2lrQAUOXkKWdINmvg=;
        b=HN/qNutvOXCuoSHU38e3a/SPNMIDoXjK3ixmiCt8IIAI/6mkptxjqEoyACtlApVKsZ
         E4uO+kLuNZ2qi9SH+ln5k/HxbAZjYtXbo8UT5bdekB67ynHo1+/+v/FqzdEWGar7QV6X
         rrrQsvwuX+tVa/YVDwS01nMDGrdiZ20sWq703JAFvp72Zq8ZxqtheK4YaGrWb5eTJpX8
         YAuxFTbJ13L+JlqnE7NmxFJZwQFU4a/6v91A+7K1WMVIgvnl6zk7QDGpaPAgg19N4dQl
         QuFOFFS9RKtMw1cAzkOIQA1Z27tBFYs4sKJG7pN5HT6yDn1tuxSCs80kctwCn8men0Gd
         s4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUI0bD970ZsACGLKe+ic31Mi3uF1PNAWme/QtyHEPqWHt3H1sCzvpJf/0d/iOAlL8pvtR5oYP2iIyciQGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkOiTMjyqrk11qRJqW1CnlL8ZcMzNOvgxlnMTyDeCaWLPIALV
	rZVn9DQdryked75oaMrSaX1grvIF6VCJA71F23ycPHuer1ksd64mZ2JOJYCHrMo=
X-Gm-Gg: ASbGncvO18XOFU01gv+zMJ6tgIpG6tsbNgXaOc1Sd2PPxeplPjRBniGvIAtmjCOyux8
	KmwCqtoTrz4JQ1NaytIXACdUnlquURBPBRhdY7BqmmwEEqLSkf7DljmY/OwPwq01BHBwH5RPqS/
	5nkciFSWhYTRDaqYnjMQUODw6EmQ9AIehxm0VvPp6niqmWmsx88533FAb/YM1qtWdQP7gtHPJ/4
	ers17RZ+OIe8HkfHPY0H20LYHIcX0SrAxyz0G0HlY1oMLjlo84gMYrHVgIIzBO7mNQ2zDZo4puO
	B08XiTynuD5etv8779GrLGk44GJZCg==
X-Google-Smtp-Source: AGHT+IF2PoXxZGft4S7bEaK90H7os4Iev7h+v97AgdpzM5GZ1g5ZH5opiwmuf7Drdh8bXm5uHZBgtA==
X-Received: by 2002:a05:600c:3ba5:b0:439:6538:c979 with SMTP id 5b1f17b1804b1-4396e781fa7mr9169255e9.3.1739612485654;
        Sat, 15 Feb 2025 01:41:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8471sm97985345e9.37.2025.02.15.01.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:41:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] phy: exynos5-usbdrd: Fix broken USB on Exynos5422 (TYPEC dependency)
Date: Sat, 15 Feb 2025 10:41:22 +0100
Message-ID: <20250215094122.60535-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older Exynos designs, like Exynos5422, do not have USB Type-C and the
USB DRD PHY does not really depend on Type-C for these devices at all.
Incorrectly added dependency on CONFIG_TYPEC caused this driver to be
missing for exynos_defconfig and as result Exynos5422-based boards like
Hardkernel Odroid HC1 failed to probe USB.

Drop incorrect dependency and rely on module to be reachable by the
compiler.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Closes: https://krzk.eu/#/builders/21/builds/6139
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/3c0b77e6-357d-453e-8b63-4757c3231bde@samsung.com/
Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notifier if required")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch for issue in linux-next
---
 drivers/phy/samsung/Kconfig              | 1 -
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 7fba571c0e2b..e2330b0894d6 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -81,7 +81,6 @@ config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
 	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on TYPEC || (TYPEC=n && COMPILE_TEST)
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
 	select MFD_SYSCON
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index ff2436f11d68..e8a9fef22107 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1456,7 +1456,7 @@ static int exynos5_usbdrd_setup_notifiers(struct exynos5_usbdrd_phy *phy_drd)
 {
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_TYPEC))
+	if (!IS_REACHABLE(CONFIG_TYPEC))
 		return 0;
 
 	if (device_property_present(phy_drd->dev, "orientation-switch")) {
-- 
2.43.0


