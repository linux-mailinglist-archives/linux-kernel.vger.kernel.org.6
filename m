Return-Path: <linux-kernel+bounces-293037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2395788E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0780B2161D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B0F1E2100;
	Mon, 19 Aug 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPfNkS/S"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069483C6BA;
	Mon, 19 Aug 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109506; cv=none; b=peCxV0j9mRKOX0nsKSsUACrNXjTASGR/JWcuVJqrAaODCyq8pAq/CibIDQf1iMA+kN/fIvn7/gmJF5V8k4U03M6UCdu9L+7UkDc9sMVTIr4Kuu9rcDUw8LlPEbSgMFAzbwdbXe7tjtu026ih3MSTGZ8KvjQijpCL3BofskQU3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109506; c=relaxed/simple;
	bh=nDkB+Ww4MYVoZoirlDdkfzPsZQSkzci2SQlq2oXxB/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RchZ2BIVzf7xEFISKC2fD6eJGdbf/v7Ie0RxTT516DLGPP3gM6Vtz4uaTW/AAkpXLKYdxqdJiyhKo8DodHrq1Qus8ZS0grY1tRlACAMH4Scc+l0bwMihenN610xwzrkaxE7HfFdSngCei2Q5eAv+mxcofDtxKPG2x7ZJnro7lgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPfNkS/S; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf6606363fso28628716d6.3;
        Mon, 19 Aug 2024 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724109504; x=1724714304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiFnHmrt0EWkf3S/OpgimW69Fg3R9RUUTwktkVeZhYQ=;
        b=gPfNkS/SCcAbt/pexWIO1gp6loqapbPQMCEzlIwfzYFqoT5XPiLF+cgwdMUx2k1BHx
         cXFOTSDrt9wwsX1KnWEmbyUKv8CmTG4pqZEqKdbsMVAu7T/VJlHGS/A5jvPFLGrPHndf
         wyE7DTaa3U2F6AJWxfX4LdCg0V1+sQin9VVrTelqI3kKQk9gRxyWc+3yv8QYjl0aqDnO
         a6ItOhV2n4tEmx61Ox2FZyQy4kW4YFMxy21XU1Oppse6gkpA5n4OAa/9tIZzv7FYc2Lb
         TGWNr1X2hEkisDpA6atDk2oRThSB1plRU63q3In8SF0sZA/azzMZKVQ8tF1GiHiOdDdM
         ZuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724109504; x=1724714304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiFnHmrt0EWkf3S/OpgimW69Fg3R9RUUTwktkVeZhYQ=;
        b=ab3l8dZ99HRlkvGproOzgF4P6yVIOyhTK8IqadrYV2MmnhqR6bcFbU6LqLLOdQYNJ2
         jJMWaFDoW2hOX9nvwzTD+nN4N8usYJg3JmuX/8InjrOCQSzV5YsdeZWWXBAf4i1sCN0x
         b5CP/IJJC6J4GtXJy7QpP4p7CVnLhd8Bc0IR6Hz/zFF5v74eXFDm4MxjhXOaKr0kf8Rk
         O6wlhcwoKI4fDXix6MoGS2/gJLoqwYFm/KpNglPFY4gdkU8mgA/fL0XGkt/4EiKB+fGW
         cFm/HU8JN/sc5dLeQ9VA3buWsWL4VI+tWYNowSfrGZqTd0d35uzOS0lzFMsuqRhH1m6q
         balA==
X-Forwarded-Encrypted: i=1; AJvYcCVuhodBfVrgOzuIEIJnFYwvkipVS767WdQnmlX2zJ/KWg3yCGOL4TqA6c/nNYbx9tnwUjJc/8NCWDQF@vger.kernel.org, AJvYcCXw+p1vJQfHqVupN7HXCEUr0Egxyw2ESrCZxpx65saja6DcdDW3/bb83YrQSZZ0zMWknS1Unaryd6LUr5Zm@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCINUjzAIq5qlrnp4RujsxGnlL7cLVkGhAsomlr1wt2yMw21A
	OpZuacqlijzhCO0mvUIX9DtuCjChGPKR0cttks212bBcestIP+0e
X-Google-Smtp-Source: AGHT+IHywoFpr673NReZLMMHP5xFVSycDI4yD/ui5qJSteVY+UBAFV3a3GqYKs/VWSTsB49RwMrAiw==
X-Received: by 2002:a05:6214:3c9c:b0:6b7:a6eb:c343 with SMTP id 6a1803df08f44-6bf7ce9648fmr134090106d6.51.1724109503783;
        Mon, 19 Aug 2024 16:18:23 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:ea5e:cd26:a652:264d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef0267sm47063786d6.113.2024.08.19.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:18:23 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts: imx8mp-beacon: Enable DW HDMI Bridge
Date: Mon, 19 Aug 2024 18:18:14 -0500
Message-ID: <20240819231814.120053-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a second HDMI connector on the baseboard which is routed
to the DW HDMI bridge through the PVI to the LCDIF3 and requires the
HDMI PHY to be enabled too.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Fix Missing reg on hdmi_tx port@1 node.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index cc9b81d46188..31c33acb560c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -105,6 +105,17 @@ hdmi_con: endpoint {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector: endpoint {
+				remote-endpoint = <&hdmi_to_connector>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -282,6 +293,26 @@ usb-mux-hog {
 	};
 };
 
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			hdmi_to_connector:endpoint {
+				remote-endpoint = <&hdmi_connector>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <384000>;
 	pinctrl-names = "default";
@@ -344,6 +375,10 @@ pcieclk: clock-generator@68 {
 	};
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
 &i2c3 {
 	/* Connected to USB Hub */
 	usb-typec@52 {
@@ -464,6 +499,10 @@ &lcdif1 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &micfil {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pdm>;
@@ -646,6 +685,15 @@ MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x140
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c2
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c2
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x40000010
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL	0x400001c2
-- 
2.43.0


