Return-Path: <linux-kernel+bounces-548763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6FA54909
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102BA17343E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1F20F06E;
	Thu,  6 Mar 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2xWofVtj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBA20E334
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259776; cv=none; b=CxB2vOjBzBJswqK+N/siW9frTTf2CTosGdUN1iH0XO8WPDUcgKuyyWs4Ct4zp6ShS7KbYEtqFJ4hbgQenK0qxU3sImH2IYFnNKZtZTYRZ2H8FQ5psFVoYW0KjnCCmUlclcdw/IHMOP1OX+tkCp1GWZ+3Ez/Q1capk/3GJDjvX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259776; c=relaxed/simple;
	bh=VbF63lIgRDIHEDh0j1eHwrNJ7kNRLfR5v3SvlStjSYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhpWKeUz6tz6jtTcaoQYJpTZBweJswDqsuTiAn5eBG3gIoQ/mRfZrtzFcBgXNLwmYM2MeCc6y7rrA28LMX3KoN89PY12XlPeR5RIDiGi52ZRFBWTlKHRuZNIKUJBIDLLP8GWJwLgLfOPQYjitapOEGrMhvSrbGKNEbRlR0NCsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2xWofVtj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso80578066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259772; x=1741864572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjgCrc1CiYSLXkKYjoDdBunkgeyK0ACopuUn/gOO93Y=;
        b=2xWofVtjDHUJsmETawKlomhzAs/1tMm/8vITkiR8JMtOOrpqF5dChrzWrZVbMUPPKj
         zB/p23ne5O1Y0F4r3xx7/3Fw2iOvavxISFIrXwiokIHg96HgaAj/t23oYPHdtbkMzlMI
         k2f97dEF7pcd1fJsapOcEfWE4aiQiplYr7KauCoOCRtvnORqLBl97LC/Xer0Z8mAHqlY
         +fPmRnUefAvjbwL0DMvNq3d2Ozr4h+S8VTyu+2wO6fLseWsp0s3IsjMlw3WP5jwYrrit
         nykkJoG5qmpJV0WEvl8z2uzBVMz2RO6VVSgaPliQ+46v3S67cLHw4rVPvOKo2irU4vvN
         3mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259772; x=1741864572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjgCrc1CiYSLXkKYjoDdBunkgeyK0ACopuUn/gOO93Y=;
        b=jkRlVdjXrdkcRKcG6IXi/HJAc/+wWrfuwOyPV8oHBxIeCbVBlm5rhUqg5nT9J95IZX
         EomTzDQyDIZrEpgNx4PogqNMqn2s6ruMx6whtqgt56zhaoArxGfgMIXKEjyHd7RfTFf6
         2unM3zpSTxaZi32OlHwi+9UYi+LCOXT/VpPCVC258mA9yJaU3MqE1fubhLHnjWpCQ6H0
         nXOfWJEA8yp6mUmnKAbrii9Qpx6O+4b0A+RkEzA/TRCR2eQEWcb3QPxJKwJ7FAmzVb6H
         o4lVABCjGr1Yx+CzsVQqZYfHQ0UMTAXb2zYESQPfDc0f8J2/OZ5LwSkStKVYOHoNGYNi
         UFXg==
X-Forwarded-Encrypted: i=1; AJvYcCU9skO5atp7k9LXcEsIkd9/nhgTj99QEpETsvlCdGEBTzuYxmxCs7nPEQfcwBZSkrQstjYSOSo54B/+Mkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDExLSGW0VJ3/7q+bblKKYe4GJ0zqqVtcggfQRt+Lnv2X8km7k
	A3dFJp7k5EygUFohpoQSKp+mZOVRpi7ILuc380V1X7o350YefIkqI9Jul1xMAvk=
X-Gm-Gg: ASbGncszXci3TWPTR4A2Lp5aZ7f2Qz3Ir70cN87FJwz8XOOLM2LZanhxcBKQwm1aFT6
	wrQ4u6spGGUqApKts/g/Pk5H+y+bG0E3+gjt71gFQw60S3VMJhPSIc4T9k3sJm5da1BvodhamRf
	EzbqvpxzBtm2iEYPZ8sm0rVrGe+lLDCqP0usQx+leJ/SypatIrcZ39ZqczJFFoSM+XYKFozEGPl
	+HxFbctPPQLQEJJ0kKyRrvGM1CmEkvJfLuLW/Nwvx0ccVeF9cXS9LDXVCBIrh7c7R95nYdPQkOE
	ScZsAQRb8t61MaGggLif1G1Th0Lp8fnvntVMcgj8eg==
X-Google-Smtp-Source: AGHT+IG97CEorYWv8MdBxdHawoR/D/CVLaTZdfILEdkNvt1Fn2+vDxmsARxSKsCxTfLEbIgksTW74Q==
X-Received: by 2002:a17:906:d54c:b0:abf:6f37:57df with SMTP id a640c23a62f3a-ac20e03ab40mr745282466b.51.1741259772562;
        Thu, 06 Mar 2025 03:16:12 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac23973a981sm77339566b.120.2025.03.06.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:12 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:51 +0100
Subject: [PATCH v5 13/13] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-13-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3129; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VbF63lIgRDIHEDh0j1eHwrNJ7kNRLfR5v3SvlStjSYs=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNj9bP3Om+c6c/W0NXvezuVwKil+enfVcUPiCfG3TX
 sFdPzilOkpZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJGGQz/BXwPWbXHCl3t6Ds
 ou+51SzTF11Ycez5J8vUJ6WGSXOvZnoyMpw4YGVWf+qQtSDHnA0qLGVPzNYuj9ggMoP3gjirztz
 UfmYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and IO+DDR and are capable of waking up the
system in these states. Specify the states in which these units can do a
wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index d29f524600af017af607e2cb6122d3a581575ffc..35b950e444353c416e33344dfff42e2edeab3aba 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -683,3 +683,79 @@ &mcu_gpio0 {
 &mcu_gpio_intr {
 	status = "reserved";
 };
+
+&mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_uart0 {
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};
+
+&wkup_uart0 {
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};
+
+&mcu_pmx0 {
+	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT | WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+};

-- 
2.47.2


