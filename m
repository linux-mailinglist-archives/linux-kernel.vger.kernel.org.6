Return-Path: <linux-kernel+bounces-516278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D1A36F16
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788A81893A36
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194151DF27F;
	Sat, 15 Feb 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg4CEu3q"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA142AA5;
	Sat, 15 Feb 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739633161; cv=none; b=aAcVfrIDTN+FgRj94XOon+MLagbIYoDgmFKk1C80rAXa3Zx3mklD7sQHwYwiKutXlo7h8BBGsNnkxrEdEM23gldHb7AAvyFCKLz4MLIgGIdbnjYIa7JHfcHEVKOvNRBf6AFgXSA2mNSBQ4Hiz2m5D2TKY9bPVgQ78VXRpBMK5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739633161; c=relaxed/simple;
	bh=VKiPCA3U8w5R2pN4nCBlxafMtaiXT9qyhy/60Fz0+O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sn38H6+bZJPalsWPsbtXzUu6lBJKmq3SKJbluteMEl/0AJS43yYLaUuEsBgpW5fVR5IP56BLU3vPKyDzqVNhHLapsHC4Kp9vMe8kIlYDZReBUtLSYwBvBR0Rf6TMb69a33dlvXsVT496jRHN74LDX5ZimykTb6dfrqVtWBLNzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg4CEu3q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d27fcdaaso7386945ad.0;
        Sat, 15 Feb 2025 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739633159; x=1740237959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbZtBYfPPawE8o+lOlR32EHg0wh4Zt+mD8hZTHKftD0=;
        b=lg4CEu3q6kVhNWFfmYFdXum4AYrrM/xJ2mH+V6Gl8B+n1piZU/Vb7l/FLbTfJEmmHe
         EVEbazX6PA2gAOiz5/9VLhjWaGoWQ8Vf8aF6RX7Jpndq7KTh7QUeIva+3B7xCyPTrgzv
         yvMmJM4yjhyQ/zeiErl3DwUK/u3gu5QxmhQWcuLaAWs3z5+n3Yhfd3ibzlvhZpzehxBb
         rQIuOQ0hmVQwGnWi8dQtLofpwD8FKKpC9a75sVGrJdPwG9f/3MdpZUcfTlVKvMHM+esr
         KF984frp34u8ramf5vjsG+GltPrhZP8Jx5WrgsqwqiCoyo00ZMYuEB0cO7CcHBrBar3k
         qUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739633159; x=1740237959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbZtBYfPPawE8o+lOlR32EHg0wh4Zt+mD8hZTHKftD0=;
        b=mgdPkWSas/80N9YTcoooM/kW/o74VZgoiGbTrVqZk63jAc9AYv/kUsGx8rKiBt6dmd
         Bou8jQJR2u+DA6yyIYMLsAHAnt5CUSunMOsFjAdofM2NLcBcWyu4uVSitDX9WXUhZ4GL
         X0ZkTZH3B5avCO9iNi6/tNx32MbKJqrwBcv+Hj5Z+f9N/8E2wr+LgSpcf8+3Ub/QTBAV
         1ZDsvHv7WYQox/KT7roJcq61Oa6lAZMMYjxaesgHTuPu/VWDjcANOdIiHE7PKVnjbIAb
         Q6D79uCMp8VdSzhtMqDD8ZWZoLq0U3FTek0aLpmANoAeA3zGBTXyCAvAmPY0gFy9jPa9
         gzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCgwDajFK4df3n1mD/DtLFZVMHiL+gi0+0XBdnWVr6iFja1UbyzqywRHNSyMjxqbCwjSWf8zV1DnEe@vger.kernel.org, AJvYcCWSocR+5ISCvb2BgYWN7hvvIP01f9ZPdr+qJTfg4APy/4p0bmEsQp8Clspi7d8hVqy2jKiOIEV+bVV3VKGD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbo/ApvZFxeiqthvTbkaCY/3H/w/aFmIE2gJ+D9bHXoOa7t5ix
	rbuvNmA8i39wiomz0F4UthD8pPbLguL2KP6szTNRzncFOGrfuOPjVrdBIHLc
X-Gm-Gg: ASbGncvHLhoZGbizKZZtCvvjFAPHiiOHTAp3GqvyuJNyna8Y0WZOa0kt5Dl+T+emvrP
	Vd5chpcGBNTrDKlYO8toD1/GXZZKiVbm+kzkMZ/eOHkypQmrKjfHcz7wViow5d/O9OitriSjBy+
	6ssppiYO2rPfQyYfWtDjME9s8uE0Szm5jTdW3jzbq4wTpXvVYXxkDYK1kw67Kdo/OE5kRd+BBbT
	AvY9TL0RaJaWhLuXr21vRHWcIhHdT/Ln5FlxQm/0U12RcJG0hQKb3dGOhZmxrMpDXVZPL79KFkb
	de8fn2IWk2MyIdZfudCS
X-Google-Smtp-Source: AGHT+IEvXhWy6/gs2I2nQXXUem/BKTSxc+vCPMgz6fxtKjGYy29KOuDEBVg/Uyb7DlOuXSsE0vui7Q==
X-Received: by 2002:a17:902:da8c:b0:220:dae5:34b5 with SMTP id d9443c01a7336-22104042218mr19131705ad.7.1739633159298;
        Sat, 15 Feb 2025 07:25:59 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558fe3asm44747405ad.234.2025.02.15.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:25:58 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Sat, 15 Feb 2025 23:25:45 +0800
Message-ID: <20250215152550.3975614-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HDMI port next to ethernet port.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index 6d68f70284e..a4fdced052c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "dt-bindings/usb/pd.h"
 #include "rk3588.dtsi"
 
@@ -89,6 +90,17 @@ fan0: pwm-fan {
 		pwms = <&pwm14 0 10000 0>;
 	};
 
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
 	/* M.2 E-KEY */
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
@@ -261,6 +273,32 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi1 {
+	pinctrl-0 = <&hdmim0_tx1_cec &hdmim0_tx1_hpd
+		     &hdmim1_tx1_scl &hdmim1_tx1_sda>;
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
+&hdptxphy1 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -1209,3 +1247,18 @@ &usbdp_phy1 {
 	rockchip,dp-lane-mux = <2 3>;
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};
-- 
2.43.0


