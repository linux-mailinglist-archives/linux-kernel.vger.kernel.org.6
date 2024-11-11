Return-Path: <linux-kernel+bounces-404372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03259C42F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15E2284196
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629A1A4E98;
	Mon, 11 Nov 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keEFLBGe"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44D1A2C32;
	Mon, 11 Nov 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343848; cv=none; b=ofRGG7h0y764DG5AI9lCEwJF79PQL3CuIKtrWa+Y+fxO3qjwbgIcBfSugkkTxufGOOlxemqJfgdJ6messGd93BK4lJKVCeOrxfdb1SYWXSKan7MmTMfQ51ojT++wIOINR0Mou/UQXgFTSpd6ffYWzJr+9wlMV2QPl9Tby6DM76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343848; c=relaxed/simple;
	bh=1AcAq6VVQ5FXFDqAdIQfK4N4RrtrGvvbw8Z4my+WasA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYqWSwebzboenEEdWnGu7DrAgYe6LGHVU2odWihCnmnZpYPYe6+voZFNdx6letS495TUQBc4nPIbfYuCtPtdqIyA7W0Z4Mmp8GQcpYvPaT0ji8E3SEaAFRQvdTKB/R49HYs29iyrYsH4YosQQKJJam7eWp5urzoeB1rV55If+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keEFLBGe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e4c2e36d5so128266b3a.2;
        Mon, 11 Nov 2024 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343845; x=1731948645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuwG52/VBZoIAELJNnOz0xD1tNHC8lVIM/18UIXkAKA=;
        b=keEFLBGeywZIWjwNHzdlGHOeTY2wxvrl5dGrjp+331S+jJM4LEZ9uKhwM0u71Ey8nq
         9xAmogAmHmM9Rm0X6NmhHnB+DQUzQznv9ZTGSU5g80hfOMh/0t+dWqU1KR025bp29m6V
         A0bkvNtMnjRLQ1aro+xH84EeUxSQ6gxLgeRuNwqnTvqgegqCebeKa6mdidqod+1XmZKe
         u8vzDijLAAc9xejZV+nHcBfiIGMz/ZuD3xx8H7ejyiPpkSX7+TuYxuyLCO3nK5Svgvlj
         p0dsK+9A7rOCHkItKLszaZrnLqXOH+3cFMzL+27oI0eGpi5ohGS2wj2YoEckfeoYhM59
         zwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343845; x=1731948645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuwG52/VBZoIAELJNnOz0xD1tNHC8lVIM/18UIXkAKA=;
        b=AKsrbgcn5J2un/z+5zBzvLgPft4igxruqEQaDzskFsOP0iEZP99Tgkt5tZgC0CL2Qz
         /7czrejs5GRGONJ2ivuoIiJbiv5sWiVNePx0Ki0wxf6+zzGjm4Qhcg6E9o9zvxoTOeXO
         b6hKqO1clw473DHfQ/nwGyzkJEtNg1dCC6fKJZ5O0EN3ZWC4czBRMH7IpyKUoXqRW9/M
         4Y9s6tIiQrRs26lEHXhv90rkqlPOSFvcYt3geIV3nOz60Ig1ptP9ZxBgjstNfiszNxAQ
         8fBZYa/7K3daLPhnpcIcjBI5vJEc3qCUbHCQDn9V1K3KcoDRfDI+9jnZj7TRGB+a95xh
         q+vg==
X-Forwarded-Encrypted: i=1; AJvYcCX5XN7aYWAPW1v8IfLZlkXi9wPe9klljRW2hVLLnEJ5yMp+aDMEhbEYIhUt2uPoqYR8q5x3AFi+ijEX@vger.kernel.org, AJvYcCXFSsTDY+GIYFjfbSFQgXc32idy1fFcygPne/N9SfQY0BBpYf9cYdeAj/wb+s4l7tjsepQ03i7Qyr/JEaiS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+NSWtGJ0MN4+qfYtZK+kidZ7zhC+8/aFaFPHfAePmMY/L8z0r
	JWybTbbMPPlB/U/l5TSZYUj0lvrUkpRO9RliJg/7fGBQJyF/Ds8k
X-Google-Smtp-Source: AGHT+IE47aehOo9+5XJxP7J3fFZt4ohbuOovj+8Ybp+54UpV5R+tuCYOcLUSE+OW5HQpnHd5TS+I5Q==
X-Received: by 2002:a05:6a00:1828:b0:71e:66ed:7bd4 with SMTP id d2e1a72fcca58-72413263f12mr7087915b3a.1.1731343845448;
        Mon, 11 Nov 2024 08:50:45 -0800 (PST)
Received: from rock-5b.. ([221.220.134.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a19dd8sm9401955b3a.157.2024.11.11.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:50:44 -0800 (PST)
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
Subject: [PATCH 1/2] arm64: dts: rockchip: Enable HDMI0 on armsom-sige7
Date: Tue, 12 Nov 2024 00:50:03 +0800
Message-ID: <20241111165026.60805-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111165026.60805-1-liujianfeng1994@gmail.com>
References: <20241111165026.60805-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary DT changes to enable HDMI0 on ArmSoM Sige7.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index 08f09053a06..b3e9ffe5234 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588.dtsi"
 
 / {
@@ -33,6 +34,17 @@ analog-sound {
 			  "Headphone", "Headphones";
 	};
 
+	hdmi0-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi0_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -164,6 +176,26 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi0 {
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&hdmi0_out {
+	hdmi0_out_con: endpoint {
+		remote-endpoint = <&hdmi0_con_in>;
+	};
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
@@ -723,3 +755,18 @@ &usb_host1_xhci {
 	dr_mode = "host";
 	status = "okay";
 };
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
-- 
2.43.0


