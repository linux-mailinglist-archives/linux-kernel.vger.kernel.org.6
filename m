Return-Path: <linux-kernel+bounces-248625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4197292DFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC57C1F22F66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412112C554;
	Thu, 11 Jul 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpeeg29y"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496884DFF;
	Thu, 11 Jul 2024 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678201; cv=none; b=R1SxVN9YTfF8hocV2UtMcSIBvgdKC//mGRGmCgAMfsVRf6oSJsaWnA0A+hrNkMdetGC07mwfj06qMmfaTJHLqnVt7fiwdfqddopHbYM2+Xc+A4c+iSQ6es4Q+vrmph59qUO9DgIwO/8Grhl6ZMGlL7QGljmIldzJjHwhxyr23wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678201; c=relaxed/simple;
	bh=Jtad3SbGErvDHkwgM6uh1x4KS5053h9Vfx/xHaVDGQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoVw2o+2wgngXTIRWfysFWzFRJ46PwkQj2Dun8Vq0tr8v7Wz/shuwUgFKKHfMJvwuwiNZD4cbTv/kBNrq5ecUC5uvDB4valFJB9ILkjmojirUSb7bDVhrTiaQzWK669q3ozYzpLUDpxsfovP/PsKWNEGe6IReaArlsIHuSD9rTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpeeg29y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb05ac6b77so3297785ad.0;
        Wed, 10 Jul 2024 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720678200; x=1721283000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amL0i3U0AlpayuDFzxy6krwzUQYPva5CT6eMHJ9zRTU=;
        b=Rpeeg29yG5TycvUzdl5LB+JFZyNmj3Dt/zxUV4A0yDt2JDOaxlzzIQLHhUP/c4TnDW
         MK8DwRxpKzrsW7xKJdRg0mpf95dWmNcMRpoqE4mshSsPe5LoOkf+T0qZJ3iW7d8wyZkv
         epAs8otVTt+cZCOX9V3LggKXE92phe6kfogjV2oMutAgcjgyWBjx0Jxll/9L9jD7HzXN
         iDZLm32WAxt6t0kTEa5GpnXvmTaUYs58WNue9CrRIf84mK6yYzQ+U9HEdKLJ3rGxQyoX
         /myGgdfBBp4tsANa077Q0NQSR1bYec8FqrJ2kxh71kZgQXx5lA5yRp8Zv+j9geKIlqgG
         /mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678200; x=1721283000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amL0i3U0AlpayuDFzxy6krwzUQYPva5CT6eMHJ9zRTU=;
        b=wlwh5Mdgl+yDajbytyHhZ0KgS8aEhY4FUDw9jlTrb8312uYSCrKzXXHDVq+TrCfpDU
         Csd/AioQKqpPgb7GEc3YgrabR8lBUT3SbE/pUoQwxUvM4mx79LGK5XhdXZFEERZ31RqY
         7MU1GkAo4RGtrD7snboc5Qz0o7G1q89YdLuzDRKhdEIG28SEOGucct75hDp/zYGN1MT6
         nGuHUDdcNVQpUDEAyENNWjBtATl3B9T0DEmxD0LrIAPwexBEPtAnhPGypDVND/kECMRY
         qeLZTutNHrGwPyg+Q74aJnR2iWEHQZe7KX83v1Y58dUw7ri4hWjjZqhCD3orxwnmtNlH
         PAeg==
X-Forwarded-Encrypted: i=1; AJvYcCWXI9RS2uVTCK7lVOSO9pKGLR6QkHQJkld9G9gnNIjBL0P7ipOKf6l0CtT/7awdjbYudhfJS9PYEoFvenwf/1L2e85XVle8yQodruLLjTkOuYLa4UloNb2x4M3n/xMu8L3IowzzuD/wnA==
X-Gm-Message-State: AOJu0Yy4OxZsWTbsNFTHlBq0CKJc6ozgBRc/1DvnLo8mTGi5eADwYERZ
	RsHRt9O1swa+tSvdw+/W+a/KgCt0OGC1Qfp8Ch+INlrobOfWf6V/
X-Google-Smtp-Source: AGHT+IHNgkIOVxrxv50voAuFb/D8XfO6THqHTM2xrFSPja8CeSVW1OiVWX4BVgbQ7OUzpTaC3rvmOw==
X-Received: by 2002:a17:902:e30a:b0:1fb:76d9:fe84 with SMTP id d9443c01a7336-1fbb6f0ce0bmr44688475ad.65.1720678199544;
        Wed, 10 Jul 2024 23:09:59 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf681sm42710165ad.267.2024.07.10.23.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:09:59 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
Date: Thu, 11 Jul 2024 11:39:34 +0530
Message-ID: <20240711060939.1128-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
signals.Each component of PCIe communication have the following control
signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
high-speed signals and communicate with other PCIe devices.
Used by root complex to endpoint depending on the power state.

PERST is referred to as a fundamental reset. PERST should be held low
until all the power rails in the system and the reference clock are stable.
A transition from low to high in this signal usually indicates the
beginning of link initialization.

WAKE signal is an active-low signal that is used to return the PCIe
interface to an active state when in a low-power state.

CLKREQ signal is also an active-low signal and is used to request the
reference clock.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: Update the commit messge to describe the changs.
    use pinctl group as its pre define in pinctl dtsi
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 2e7512676b7e..ab3a20986c6a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -301,7 +301,7 @@ &pcie30phy {
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
+	pinctrl-0 = <&pcie30x4m1_pins>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
@@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
 	};
 
 	pcie3 {
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
 		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};

base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
-- 
2.44.0


