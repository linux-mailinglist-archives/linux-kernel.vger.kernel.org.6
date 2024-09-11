Return-Path: <linux-kernel+bounces-325127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDCC975552
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE0289462
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A11A302A;
	Wed, 11 Sep 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="vn0v9lkK"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60C19F104
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064906; cv=none; b=p6wAuTJ4co0wU5cohbreynWIjkzw7qUf/SWXalRlKpWAUx/yGwEQ/uH9DJ0VJ3etsmjVTC+OV/brn9C0Vopel9xaXAux/OeRlbmtNZxYwYw7QROJLcSd0rERxCCobonddbh1M9PZjV9EX/xxt4/OSKDsnxEKC4mmyHrr7lsKhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064906; c=relaxed/simple;
	bh=HWiHF2WJQe2aKVEi4bYz2zUblPTZngMcMUJTSZsaE0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mub7IlRMtEtYhNHgAVN/B52jT0ej7HcRZli0WSS2K4yn4TZrzXmHCi3eLF+rwyhUEgmIhj/v5B0a8PWNAMoqY2XEzSi5KTv/76woD2sY1jlw5jP1xC2pzr6DAuUJobC2twSIVgUYzTnKW4zy9+DrWwsPk5qAhfONjoV5sN4SFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=vn0v9lkK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6bce380eb96so4178525a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726064904; x=1726669704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/s/yZ/fu2RctQDsUCSBTBJSbx0ktmemPNhPcRZ3o84=;
        b=vn0v9lkKxmnPgdwpQBYwQXDtO8Vk54POEe75A0+cDkVKqpdDLSGjSVq5IfC/5OeRga
         5arMILcAp7xZcO7dZ+kPyNS/mqz6ShmzqXUcZIU7bEF6b/LCLrQNcO6xaN9BeGPLtS/S
         VU3Ny/ojEvBIO7/1UQgehK9A7h5+KsLAtNlJc8RLHslIEZmVjY0hSLDFb5XWYQ2pfTPC
         HGfaJz4Vo3SnAoR1mQwgU/Kslr6yC6AeBoJvndvBotV78cO82QoTMnYOK3Evy1TFDPZ8
         koJQFv/XiQ0IcA+CDgIEZiadepThPP/94hPaFC+GSsrgVQAEBC/5eI7Ol6qCvIUoPwkA
         hNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064904; x=1726669704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/s/yZ/fu2RctQDsUCSBTBJSbx0ktmemPNhPcRZ3o84=;
        b=gTOx1VUjrys7WEc64RDRKhMtmHf1cyjujMux9vMSs3wwt9giDee2dPwqZWgujEJqwG
         2w4G3UB0/z+NusKgdOriL2jJdFiD0AME8YuqHEtWzUskPe/WTykaLGmNhAOAogl8BJNO
         pc4LrHx69pGOdr/PUIJa9Fqe37VH9ugoXSp3vmZpBv7MvoeT5q/rN6n8evO+7hGzERMG
         djcwbCA4isUVr4BuJ9Do9BjpUIj2mSKA0nc/okPa3nvgvQhJ5QfSK/PUsKqW3sheBE2c
         XWDUTS7m/Cf+lDNMht9rBJFCX/VXRSlnIqGfQaTB8zD/1pGRQOWgY/cQ7Sdm8XY1+BkL
         /HCA==
X-Gm-Message-State: AOJu0YwqvKeukCAm2F9tFgIEaz8Wvk1pMGPBEwMBadh+f50NDR6HPdQB
	BWiUim9FO8QVGW5SIVYM4Reys3v1H61/OE30x83iPSrY0QWemX9IpedRc3pp4nSiIpnPK6TKjoG
	VOA==
X-Google-Smtp-Source: AGHT+IHqbcVmiVTlA06ObWdR+F5XvbTWf7muQ3N8Ww5HkEnHAHU/xiG/nzHYw5l3NU9MDeCyRLMFog==
X-Received: by 2002:a05:6a21:392:b0:1cf:5b31:313a with SMTP id adf61e73a8af0-1cf5e0307abmr6964576637.1.1726064903886;
        Wed, 11 Sep 2024 07:28:23 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46c9sm10639116a91.11.2024.09.11.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:28:23 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 11 Sep 2024 19:57:21 +0530
Subject: [PATCH 4/8] dts: ti: k3-am625-beagleplay: Enable mikroBUS
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-mikrobus-dt-v1-4-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3276; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=HWiHF2WJQe2aKVEi4bYz2zUblPTZngMcMUJTSZsaE0Q=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm4ajWkpgjyK7LlSpg2LopLy7iLx8obVKJNlLKZ
 dqK5lpf5bCJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZuGo1gAKCRAFzvXHieVa
 dArQD/0cse1NKul+tL5kOruOFAWZtNGBnbuu+u6HIMhf3idPcHz4n+624u4dth5lMwH+LVbonM9
 MKxD0IofozpkpcwyrQc4DZmNfBChTUC+jZnLLX/x2o7exEzKztzjdRQjsgZ4IyRcQWjQgPs2NSY
 zCKDpadPvWuglY0yebGCXcbnKOw7K8wA2wdYRkCW+NpD9CVakgLJM/NUg05GEpf7or5Ib7iUyf5
 KCO+F68jDmUydpfuHgBV1+KfQFWITIHGIXjZcFTGvbA9jUDZ5A7m+kGian3NjLe26nydRlEVz1t
 pRwNNiS2ntjL5KkUsEYixV0njFr+Fw//KUifbsahi+pqTd4lekZUgJd9P9zep1oWJuDJwERr+zJ
 5iSMCIPd0JE/eW95LMlv3FFxuKae+ve4E2yvNQnV9i0MJNWCzrZ8fmXjRxDyImBN8xPo2SvUNzi
 bIEhmNg45+aepELQJlpPFV91NebGxPhRDmJLyYL/OqtqHySSIC7RWuToNfwQgr51YtwIyooPi8e
 4ZLXaoTyc6OLH0qExlcQtKV4i7CdchkszcBpe2vLSHksT80h+kqYQFNoEvbMFzL1WMcK5Q52XQs
 uM/dUEsgIojcEUmRYvxV2xDd43+qrG3coLEITTl8zM3Xrcx5lMqijI5WU/God4DqY4Oy6t7mfkw
 fZS+H0hdlS2SjJg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add mikroBUS connector support for Beagleplay. Acts as a nexus node for
gpios. Allows defining GPIOS relative to the connector. The pin
numbering is as follows:
  0: PWM
  1: INT
  2: RX
  3: TX
  4: SCL
  5: SDA
  6: MOSI
  7: MISO
  8: SCK
  9: CS
  10: RST
  11: AN

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 53 +++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 70de288d728e..628bcfcc4651 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -227,6 +227,21 @@ simple-audio-card,codec {
 		};
 	};
 
+	mikrobus_connector0: mikrobus-connector0 {
+		status = "disabled";
+		compatible = "mikrobus-connector";
+
+		#gpio-cells = <2>;
+		gpio-map =
+		<0 0 &main_gpio1 11 0>, <1 0 &main_gpio1 9 0>,
+		<2 0 &main_gpio1 24 0>, <3 0 &main_gpio1 25 0>,
+		<4 0 &main_gpio1 22 0>, <5 0 &main_gpio1 23 0>,
+		<6 0 &main_gpio1 7 0>, <7 0 &main_gpio1 8 0>,
+		<8 0 &main_gpio1 14 0>, <9 0 &main_gpio1 13 0>,
+		<10 0 &main_gpio1 12 0>, <11 0 &main_gpio1 10 0>;
+		gpio-map-mask = <0xf 0x0>;
+		gpio-map-pass-thru = <0x0 0x1>;
+	};
 };
 
 &main_pmx0 {
@@ -394,6 +409,25 @@ AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */
 		>;
 	};
 
+	mikrobus_i2c_pins_gpio: mikrobus-i2c-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d0, PIN_INPUT, 7) /* (A15) UART0_CTSn.GPIO1_22 */
+			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
+
+	mikrobus_pwm_pins_default: mikrobus-pwm-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01a4, PIN_INPUT, 2) /* (B20) MCASP0_ACLKX.ECAP2_IN_APWM_OUT */
+		>;
+	};
+
+	mikrobus_pwm_pins_gpio: mikrobus-pwm-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01a4, PIN_INPUT, 7) /* (B20) MCASP0_ACLKX.GPIO1_11 */
+		>;
+	};
+
 	mikrobus_uart_pins_default: mikrobus-uart-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d8, PIN_INPUT, 1) /* (C15) MCAN0_TX.UART5_RXD */
@@ -401,6 +435,13 @@ AM62X_IOPAD(0x01dc, PIN_OUTPUT, 1) /* (E15) MCAN0_RX.UART5_TXD */
 		>;
 	};
 
+	mikrobus_uart_pins_gpio: mikrobus-uart-gpio-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d8, PIN_INPUT, 7) /* (C15) MCAN0_TX.GPIO1_24 */
+			AM62X_IOPAD(0x01dc, PIN_INPUT, 7) /* (E15) MCAN0_RX.GPIO1_25 */
+		>;
+	};
+
 	mikrobus_spi_pins_default: mikrobus-spi-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01b0, PIN_INPUT, 1) /* (A20) MCASP0_ACLKR.SPI2_CLK */
@@ -804,10 +845,8 @@ it66121_out: endpoint {
 };
 
 &main_i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_i2c_pins_default>;
 	clock-frequency = <400000>;
-	status = "okay";
+	status = "disabled";
 };
 
 &main_spi2 {
@@ -876,9 +915,7 @@ &main_uart1 {
 };
 
 &main_uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mikrobus_uart_pins_default>;
-	status = "okay";
+	status = "disabled";
 };
 
 &main_uart6 {
@@ -925,3 +962,7 @@ &mcasp1 {
 	       0 0 0 0
 	>;
 };
+
+&ecap2 {
+	status = "okay";
+};

-- 
2.46.0


