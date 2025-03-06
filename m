Return-Path: <linux-kernel+bounces-548762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B0A54904
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096203A945F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56720E6F8;
	Thu,  6 Mar 2025 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mYuyzyEh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4020E01C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259774; cv=none; b=S8yj9PczWp3hCtY9cJLClTUKTTyP3SEc4UBMQTYleaX0hd38L32zmKeN0wzmThHd/OB4kW6bJQNabDhUSkZcOie/gx8sRYWAvV3yNfLUaljcISI4jNj2lrSZHWNicN+unsdFoUOGpn5doIZcr8zPRpUcuCnD5i0NxEaXExlaUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259774; c=relaxed/simple;
	bh=KtTQn+xbWTvrFNJyHpQs15WQHP7pkgSdiPMOyaSYVSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DazdgmQXjldA3YgBDZ2ZS5L0DtU79Y/HRoH79pNIudQGpEAxuBVY3jeBYQNsY/92hyhsMY+p0vKI5XWLqANTo+/lhexqafQdM4DFxIJpoxqKCe5ugYYA4gO0AQnAb6FXdeOZ4VKaWv/oCOhpAXBoLGOgREiNRukQrVsaAsVbrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mYuyzyEh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf5f4e82caso104109366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259771; x=1741864571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bmPV/FRPcATpuMXYpDJkVPaXRC/87HeVbHp/xQd4iw=;
        b=mYuyzyEh/6vQBdq4OWf210WRP3yzImZsFlbmNZEx5Su6+Y2He/pVwR5dhN1gm4SDPa
         uwX/s5VEKtG86GZEelZ3jurvK6J5GZLSo9MF7nLS8r4JtAurDOHdinjKsZgyk6h/oE23
         +CSd1kdf0f51bQlPxDcUMtTAbACtQP0ng1nmS0prUGzGR3c3QWZVWiCLcln14voVzuQI
         z1vFM3Ykb9NiBdh+btaSpStxG1vDrTABtxuNKRqNfT75UWegcMuTUzOp7QFV2jAjdmvj
         xLWeBca5XKsDJev7BMWUzwdyxLc7qtnbNdLhLCtHHNtzcItmsrPtDg0SfepSJieGF6w2
         Eeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259771; x=1741864571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bmPV/FRPcATpuMXYpDJkVPaXRC/87HeVbHp/xQd4iw=;
        b=tJMH+f8Cv2sTCYPAYpLkw9Og1YERztyyNBL0JynwwG637LNEVeUkrfS9N+gcxvHXoE
         A9qdd0GYdxhWXYaJvqbqIKbxih+YLyFKYeNotnpuwRaI/fkqMcc82qeVirUsW5Dpd+px
         Yh8ot1UP6x6l9tANQoyx/HgIH2zdkIjhtQCzn1l+HXl3dpotqAjikp6tT7X5hEMLmVo2
         4/kk7y/25nApE0EgKf7GtrAsCj1C37hhkhULhvG8Ry8XYIbbzvYswcvWzuxQR+2nfDSQ
         NLwxpTIjT2dNE09f/7NV+Ax10KiGO1gUdnMallhjCKIKrrY2lfJ6GqgnRMSsc8nXZWRg
         mTXg==
X-Forwarded-Encrypted: i=1; AJvYcCUnED4+S/hVsHcRYOuJUel/pmTM+Ve+pWPKMQ6+qCSjd8MUgey8mRGJkPn1GxjWd4xd4Ej9vPcOEK7+4Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnB7B5sKRLLjNr/b7mJgBWA3E8eDgiZlAuTaBZCaoSPDtq28EZ
	CJ2TPeZ6QrZthCJ4NBrRy/p/o8h33gfbotXRlW/YnBE3rR4DwsfxFpN2Ld10VLLzoLNc/rm9SS/
	+
X-Gm-Gg: ASbGncsGK6xOkKhOPDCJQc1YJKNiVrv4RvAr0441xj/dWg95fJfNbMW4oV+JaYULvHu
	oe6PuDaXudtH3BFhDckz3dIT3sobz4q/hDwzWN3bbJVL45G4x0cP2wekHpZSKVWTputuuzlYzsr
	7WptZNsDYrr5fbjWaDaCkgZ4FBR0H2AoTYYXRYoHxk0wIfryAk/oIQHMPTPA379o5aDfODd2Itv
	DB3YbU70id5miBR8f8vvZQ+NA74jbvGbctTL8LSUZiuJ1VJ1D7Xwxsx7xZ5z2SFIn5VmpbpdEFc
	wkl5Ws/9LbgQeXrDXerrkadGQNwInqsBmPWitX81hA==
X-Google-Smtp-Source: AGHT+IHi6H4e1zM8WhPbeq3pRF6PXTRxEnL0B0tUSBxEH6HkSKEP4U/KqR0WKz1k2tj8aWfe1ssuWw==
X-Received: by 2002:a17:906:f5a9:b0:abf:4550:9764 with SMTP id a640c23a62f3a-ac20db11abemr594377066b.24.1741259771152;
        Thu, 06 Mar 2025 03:16:11 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2399d4edfsm78843866b.171.2025.03.06.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:10 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:50 +0100
Subject: [PATCH v5 12/13] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-12-f9323d3744a2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; i=msp@baylibre.com;
 h=from:subject:message-id; bh=KtTQn+xbWTvrFNJyHpQs15WQHP7pkgSdiPMOyaSYVSQ=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNj88/pN5piTHvBqxmQWKsfpTdumkPitj07ATDRYwF
 ax8UtDbUcrCIMbBICumyHL3w8J3dXLXF0Sse+QIM4eVCWQIAxenAExklRQjw5QVdh/Kq7r+WU/W
 cnrmou9X/9N89lK12n2yDzu7TnNLSTP8LzPdNbMpzuPWLhOl4InzVayfuM6t7fCd4jTJ4pjjv8e
 b+AA=
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
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 1c9d95696c839a51b607839abb9429a8de6fa620..724d9a6f3c575fe35496fdd9e17d6d8e33869f92 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -741,3 +741,79 @@ dpi1_out: endpoint {
 		};
 	};
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


