Return-Path: <linux-kernel+bounces-263538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C993D76A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC22284370
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51A17D354;
	Fri, 26 Jul 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1jur6xx"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC917D34A;
	Fri, 26 Jul 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014105; cv=none; b=geqJK+LIrrinG6EVJjAaq+kmkdfh8LyTGMY97FFX2HRO1FdkOI/8gda1SC3QE8ccOmbr+7qfCPThe7hVRMrZ1YidfEk5r6wDtMA761qu5iicmRiq3vjth5LDj6ruoD/jzEEwrmzSUT5FZLB9i3ma+pX6BQEANWgiRGXQtGF4+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014105; c=relaxed/simple;
	bh=hkYdR080n/XRokmoi3t+Uz32CmcJh/YBY/kIe2+O1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNC+8pSJIPeEFIhDW1ipWsoJ4BGluvuNEY4rGYZ730S9IXItgfKDZPY+JKFxDLjhCVPqb8Yqj9iX7+QEMgNaAE6aNiQwxpGwWvBD6i7STWg1OpytTz9XxRzW0WugSMOn9/ZXf9/k0+v7OTG4y0fJOJ8ERtQmueGUHY9PM2M/Fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1jur6xx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2b921c48so1060508b3a.1;
        Fri, 26 Jul 2024 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722014103; x=1722618903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hG+eB5Tfylkp1eYxbyQ+cx5mDv2otnbkmfTzAe9Peb8=;
        b=Q1jur6xxdpny/Qu6lBMkYBNg64WGycV4ZJz+7zsg5MS3wMSj/XDhTPqXOEoJHqk6cO
         K8gNj019biYB0n3kRuJLZWOA4oGv4bSzgMf020bsQWesKeAwIamcJMuGz7AmNhbvx10C
         l9bGoOMvUtkxOglf2oJcXFZcAtGYzzM8TXGIq+6QOVv8/ZlkLk7XnE+TbYtDywclgWh5
         YiFGticM1NcvDIv3Znt03lu+2Zv+LW5A40id7eiCnb4e0cRkVsJOvrf+lBila6lDFl1Z
         a39ENhrxGfXxf+ZSgwZ8t+kA5cBPoeNfkBiF92/w3aQTeitkuAW4UEijYuLTWsYiUUjx
         u1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014103; x=1722618903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG+eB5Tfylkp1eYxbyQ+cx5mDv2otnbkmfTzAe9Peb8=;
        b=LmkF6Jzp9bStj+zlnQ9LGKr3CUFPp+GJ5L//RsLFwzXzc2WWW7ZHOfQNtfzALFTruq
         lT48mLv4/5RwEsGiaW8zdFFvgIA/gi7KjCZ/vLNYVbEtIoVwCLscs4b3mCumZJRTp+OR
         CDw2g3xt76br4HXDcEyYxNh9iarAvrD7a2g4Z53SK5dwdtXjBD0GkMFEnZe8FrDBv75F
         j+UaA46hBXqtNW4+f+pu0X/QGCwfDYJbTGI17mRgWBSTCDRv2NmGW16FrA5rlepD7J2t
         j7bLltwh6IGqJ9zhkiO8lekTtYYkYt0b7VAO5ttCaKcfjXlPAiPPTcYUzJ9fabOYjKYe
         MceA==
X-Forwarded-Encrypted: i=1; AJvYcCVhvQX7kbrmzTF3Y60wJEmOdnS6qsG9UZ1Nj1DE3JMI03TBejTmKkUK2D8j1RJ31p636PF+3JwaiiYy048hzDJBFxVkT1uJ+Z96DYeqFFjsWJstlCtkLerexdT87ASvLsLp7a8Sz5XfEA==
X-Gm-Message-State: AOJu0YxoNMJrkFDHiYEaakMi4YUe0/7cKFadmhmFesrYcohm4b8oOGs9
	ijt/eGm+VJAQzuGakDvkY1FLRpo+kstJMQJ2aK+EccKsSBy5ZPk+
X-Google-Smtp-Source: AGHT+IFOFTaHck9MrdAuCfkbyfhyFt1R2cNP/jjGLOySlT+KGHPdNpj2HnEBVu6jb7djXFd9HeK9zA==
X-Received: by 2002:a05:6a20:7495:b0:1c2:94ad:1c6a with SMTP id adf61e73a8af0-1c4a13a356emr200628637.37.1722014103343;
        Fri, 26 Jul 2024 10:15:03 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73ededcsm5718855a91.31.2024.07.26.10.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:15:03 -0700 (PDT)
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
Subject: [PATCH v4 1/3] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
Date: Fri, 26 Jul 2024 16:30:44 +0530
Message-ID: <20240726110050.3664-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
signals. Each component of PCIe communication have the following control
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

Rename node from 'pcie3' to 'pcie30x4' to align with schematic
nomenclature.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: rebase on master, used RK_FUNC_GPIO GPIO function instead of PIN
number.
V3: use pinctrl local to board
V2: Update the commit messge to describe the changs.
    use pinctl group as its pre define in pinctrl dtsi
---
 .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 966bbc582d89..1c7080cca11f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -338,7 +338,7 @@ &pcie30phy {
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
+	pinctrl-0 = <&pcie30x4_pins>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
@@ -377,14 +377,20 @@ pcie2_2_rst: pcie2-2-rst {
 		};
 	};
 
-	pcie3 {
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
+	pcie30x4 {
 		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie30x4_pins: pcie30x4-pins {
+			rockchip,pins =
+				/* PCIE30X4_CLKREQn_M1_L */
+				<4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* PCIE30X4_PERSTn_M1_L */
+				<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30X4_WAKEn_M1_L */
+				<4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
 	};
 
 	usb {

base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
-- 
2.44.0


