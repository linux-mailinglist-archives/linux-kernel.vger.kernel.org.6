Return-Path: <linux-kernel+bounces-577341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC8DA71BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6085617051A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9491FBCA9;
	Wed, 26 Mar 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="jDNjIUar"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D51F8922
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006238; cv=none; b=Y9BZUlMcv46upNEX+cXmb0/B/ZsvuClCcsAWHmrgGLtFwJ+wUXAxktKQFYvPu4rusophRuJVIrtL/Y+t1t/XsijYCExWDYNp/UsjNtc/lc60BfREs7krg87CDAoUcgyOjCYO8Jwcgm1MgKp6pwdGJOY52SM/V6z5ULh5druIiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006238; c=relaxed/simple;
	bh=Grwt7YtWLNjsqzrKfnGrX2o+xxC08oKmj2pdJH3EBws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7+tiDQMmowRNQWkWV3Zim46EuQwV9yjBXtxhaLBRwFIpgApuje7rfSXoQznwM4YJP3jIXSyDns0NHaOxX2w8SpGbomOMSuEfFYo6d/T9iu4ea4j3CqPILejG72raojKk39JVRLJT3hhVqqGepQ5zeY0x2RMAT2IcU4232cvSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=jDNjIUar; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac339f53df9so299924366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006234; x=1743611034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDm6vwX/7MhCy38Oh0zCGpwppmmiRhE1IJH2tHqDN4w=;
        b=jDNjIUarMLMw2GSrmWZH7FiiRCngOP7ppmDqjZgYqt8Sq+kGperT4MXftWz+JJmrx5
         V6vaoIMmC6QSZuofFFwVLvlN7kC7wrZQTyJS/XBByqToMrk2UUcgFX9LOi8RvOTWzgLk
         SJPcAMaiZC127Fp3VFckSq63Y321c30TcnBSFsn67PEaKTPBStQvaem2h49Wkic2Tg1k
         EpHhVxouNCM+F61SwuBW3DYvum+7I11sHsCzk0fuzobTj48z00hXZhblKs9+vbp8ppiu
         44p42S12RzHtQxZdNZ3WSjINIW7WXUqIX0ojnexsDXvNA5supYiYGTz+gMBOwYfGUEZu
         9ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006234; x=1743611034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDm6vwX/7MhCy38Oh0zCGpwppmmiRhE1IJH2tHqDN4w=;
        b=SWa2DKP9Xr1jhc86BYFAQBWfTc11MvmmYBsfrE4YmH1EkbeKLuLdaWlIYQhLjku0y8
         aI6N0YokOS74uSk9NcX7MHr4RoTosQH4lKjMOJPpjQbBOp6kEAkqFP8dTq/F+FjvKBlw
         bT4ei25pDBVeHGcxCUJ0agq/09/dFK2tRVjI1HzhUavMQ6FJVbtoPRChc1qbGLHocexT
         D0ZoxL3nPq/Rh7Hkwwe/66rlTlrg37EahYJVY6s0do1gYoC2zNen42cR5gdK8ZReJcFy
         1BCYXSjVZFX6VRWNQ5VOCQTMvnx7kHlS9IqQfcOJXa+Vbn+BOBTg1zXYUTui7JBOlIoU
         L/XA==
X-Forwarded-Encrypted: i=1; AJvYcCW+eVEEWfVeDin/cq5KjeXy3ZOgaInqFY7R4xrHBU/M9FMqCSFKR0TW2dEvaNMcFRDTCdpa8z1brAYGeKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuOi4nbrhvmAmO3xT2jcnAIY7NXYBnDi2ZNWAnYLsu1E9LFnI
	rHeOu92cDUSN5VflTDtJaYsJbvj9SLEbciFUVW2mNDkBJ5aQSLG7mOGhvRuhMc8=
X-Gm-Gg: ASbGncvOHCTiWw0dbylcR0B7rZ79vJlCszjJFPm6S+eyTg/FGI+Er7iwLupFKPw5jV3
	rk3Y3dPgDVCOxjMphXFKSdtM1Jkq8mo3pIIsQkaY8YdPoos6VkMmVtUDw0CypFlfvwOasVoT6Mm
	9QbpwIYjcrrV3c+17qm7NtN4rSFGZ7UatfcJ36CKJnjOU0O7yTJW0dyacQQVcBD3xlKfHeJU3RB
	V5to0I2Yip2hZ8/wmcj9Xot+b0Ejq3JDPzt9PlwbKawsUHivDLvc4LIunkRzOY6aa8fdzBtqt60
	Hh9A9oUidj9WYsT7pOpKVGgaRKp0yEKNxClNWCj4+ibj8YxuIw29u/mpjg==
X-Google-Smtp-Source: AGHT+IGQDtjWme6NCVpAtHSgi92qK4szwj72LFKXUSvl2zwfLCr6eOS0xs1KhoWnEmaFlvUG1YBTXQ==
X-Received: by 2002:a17:907:2ce6:b0:ac3:446f:20cb with SMTP id a640c23a62f3a-ac6fb14f3f5mr1655966b.43.1743006233972;
        Wed, 26 Mar 2025 09:23:53 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:53 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Wed, 26 Mar 2025 17:23:00 +0100
Subject: [PATCH 5/5] arm64: dts: rockchip: disable unrouted USB controllers
 and PHY on RK3399 Puma with Haikou
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-onboard_usb_dev-v1-5-a4b0a5d1b32c@thaumatec.com>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
In-Reply-To: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de
X-Mailer: b4 0.13.0

From: Quentin Schulz <quentin.schulz@cherry.de>

The u2phy0_host port is the part of the USB PHY0 (namely the
HOST0_DP/DM lanes) which routes directly to the USB2.0 HOST
controller[1]. The other lanes of the PHY are routed to the USB3.0 OTG
controller (dwc3), which we do use.

The HOST0_DP/DM lanes aren't routed on RK3399 Puma so let's simply
disable the USB2.0 controllers.

USB3 OTG has been known to be unstable on RK3399 Puma Haikou for a
while, one of the recurring issues being that only USB2 is detected and
not USB3 in host mode. Reading the justification above and seeing that
we are keeping u2phy0_host in the Haikou carrierboard DTS probably may
have bothered you since it should be changed to u2phy0_otg. The issue is
that if it's switched to that, USB OTG on Haikou is entirely broken. I
have checked the routing in the Gerber file, the lanes are going to the
expected ball pins (that is, NOT HOST0_DP/DM).
u2phy0_host is for sure the wrong part of the PHY to use, but it's the
only one that works at the moment for that board so keep it until we
figure out what exactly is broken.

No intended functional change.

[1] https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf
    Chapter 2 USB2.0 PHY
Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 947bbd62a6b0..93cefacc7a01 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -292,14 +292,6 @@ &uart2 {
 	status = "okay";
 };
 
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
 &vopb {
 	status = "okay";
 };

-- 
2.43.0


