Return-Path: <linux-kernel+bounces-535707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5DA47642
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C5B1700B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411221D580;
	Thu, 27 Feb 2025 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zF+wVd2F"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1121B9CB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639925; cv=none; b=Qm78FBp/CvX31dqzlUJWtfL3NT16pkZOG0qtJ3I9BpFGLJfODaFg94XOtW1DlpJki0JNcevaq0sWddFuorV/EWuEPYmT/f2OvDTjfzSbs3uBbfMEy10BPAglmcrR2U2Y6Eb1wJOhtJJKQjonQx+5x/GDjMZ5hI36D2zgFwMWXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639925; c=relaxed/simple;
	bh=L+iJkJIkmYjSM4Y6ZIIPrVBO0d8d5G3GzcyimiGIB4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O/Rte+5cLTpG4No4WFthpwwOEY0xmoAnSqhzk8albpHfELEXS8+kwGwFRdQ3XH8M739qfwMs7dmg55MgMcEUafwB8/Eg4eaa0dxU2lI83FnChU+TEfh2Nwmf02UY55h+HAQqkXws+pH5gqsPJG9hhM1FYPO3C5BWd4UfsqF7KwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zF+wVd2F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7f9f57192so8499366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740639922; x=1741244722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0apQcE6PfzPMLUzCFy/8QBbVfjes8kdxgXVKnN/YLIM=;
        b=zF+wVd2FPIcn3zLRu3X3qSKRHSzFMzRbKTrpsjQ0dFnoiUQ5NtOmEMn6M2yJYqJ6Az
         fbOOgjJMp40SnxQy6XR1lj/DQG08TDL4vfSIEnw4Ic4CTaz4Bajlx4vvZ99PeeD1lAJx
         jIW7V//AKGJCT9Z9ikOVoXscvPub1t3L7Mowv9K44IG5+FIyA4a0aYGTtdO1f3T0vcod
         jCS8rH+K1xLH3aTsTlip20fjZsMgPQeXcY47+/76z+w73TBvPl2NIg/S1OOgMhmG11uA
         JZNbDf7VvOUN8XxS+3G0HGyf71JYiqucdC2POG8KTRCpLvnqu8V2UdGOCfC+js7zbA9J
         ke2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639922; x=1741244722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0apQcE6PfzPMLUzCFy/8QBbVfjes8kdxgXVKnN/YLIM=;
        b=DIAufSswCV1gaN7TzwXdLm+suC6nNrsCYa5m5KZhD0kPP373+G31CiCK0C9KzLW1B1
         pcAeD5ldm5of73GRtjhqp6koQKaRpHvVjFe6hNHknE7LqVpaU6hC23jOdWa6fq92pgmF
         HGiDa5hkrJkodBUn1ODCpnu8ICwvyAecHw1nhv5b8AHP3PLaP2Hvsd4amitlUsO+4ntx
         F/lfi0bxZYOH2yEvNUR0q05qkOJKv7XXnfwYw6ms+SaLrColW0yQ/mDRnhJuqSRBAm2K
         thv34YjhKeOM3TCqdQLQ668B4pHP8CcnodldjGqSwkcx/kWJwflFbAxRN5sQZ3smdoQt
         Pz2w==
X-Forwarded-Encrypted: i=1; AJvYcCXxTtXRQM+9sWLO7LoeX0bEbPgjkQmTrOhjHabtNhUKwad1a6eGHC5XnJsktpk0Cry1oe5eoaf3aljHEi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fDviYSVpvPT/gkAua3+kh/uSDPqe9CG5TeC2gI47AHuMK3Qh
	RGKvQSPk62fMv6dUjcadyRW/nJGwSfdOpwJw+9FYHSUrM5mRWOCoJYC7+TnPKWs=
X-Gm-Gg: ASbGnct6ITp22x/HbhXm80r4aLWGbO/TevHmt8jkb5GBLNkPqTszf4UUMWbsns7IC94
	ddpFeQ1aD2o9YPY1ncgbYi6apqbnajanPtj8B134Jfm94NJalE+o7cDSy0NsFsFpMIPsptfmJFF
	ykXq/Xv8nswNiS48jBvGzwfsi746DOivNUz6I1JFm3q/q6EjHGVTu41/fWz0ECrMMYMjTagRqpH
	k6+teXfA8kO3myvbJU6yXXRLOA7bQ84ibm9XFLzNxSg8Csf+qpVInSxhZ4zjIvhX0cd+3Sx74yT
	EqQzAqHBhDdFq+TcatXMXY0N/AsixDc36qjQvcPj
X-Google-Smtp-Source: AGHT+IHXy5tCZaZz6X3dSvzvQm4bdYcI3qekmMWxV+GvUxiLx80Fzbswu9wY9k8MAxpjFX7Ux9LlHA==
X-Received: by 2002:a17:907:74a:b0:abb:e5ac:28b2 with SMTP id a640c23a62f3a-abc09c24732mr949678066b.13.1740639921638;
        Wed, 26 Feb 2025 23:05:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6e9c25sm74556466b.108.2025.02.26.23.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:05:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] phy: exynos5-usbdrd: Do not depend on Type-C
Date: Thu, 27 Feb 2025 08:05:18 +0100
Message-ID: <20250227070518.5468-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Older Exynos designs, like Exynos5422, do not have USB Type-C and the
USB DRD PHY does not really need CONFIG_TYPEC for these devices at all.
Incorrectly added optional dependency on CONFIG_TYPEC caused this driver
to be missing for exynos_defconfig and as result Exynos5422-based boards
like Hardkernel Odroid HC1 failed to probe USB.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Closes: https://krzk.eu/#/builders/21/builds/6139
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/3c0b77e6-357d-453e-8b63-4757c3231bde@samsung.com/
Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notifier if required")
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch for issue in linux-next

Changes in v4:
1. Change subject (Vinod)
2. Add Marek's and Andre's tags.

Changes in v3:
1. Simplify and go back to standard optional dependency without
   intermediate symbol

Changes in v2:
1. Add PHY_EXYNOS5_USBDRD_TYPEC, so arm64 defconfig will have both
   symbols in-sync
---
 drivers/phy/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 7fba571c0e2b..6566100441d6 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -81,7 +81,7 @@ config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
 	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on TYPEC || (TYPEC=n && COMPILE_TEST)
+	depends on TYPEC || !TYPEC
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
 	select MFD_SYSCON
-- 
2.43.0


