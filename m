Return-Path: <linux-kernel+bounces-362495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE499B59A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9684283AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDFC19DF7A;
	Sat, 12 Oct 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yXzgcKWY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656ED19CC0C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744030; cv=none; b=dFPlRyWze8XvFOzDqDKWZZuqO6ugsKSInJ2umfSUlXQtZTfGSgEqlQAYzQuTOfFvaR/4IliMoEgS8XKftrpPpCUxyOwKBEVBGJRaEKtYys6bYk119Etq1RWV35SOTObBtZktP8s9Y+YueBjNRi8xx9jDN9kxA+0fq959U9+HlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744030; c=relaxed/simple;
	bh=3rhP+Zbms4CJO3Z/gy2uQZJnt81xMUEEDV0P1R+LUzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rex3wquh6LilsffNq93q/hqRTTqYRRoGOkQC8wyGSB0dHswq7cp74Poukz7P1mlnsv/toQITtNabFZfCYm8yyaXJuflqUzj9uHg0ttkJlvN4cT6Oo9Qll0FWpXGfxHxHtwEXtYzLzA/BjvfTRvXw5FjaKYotFaCa9h1A8pryIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yXzgcKWY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99fa009adcso12240766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728744027; x=1729348827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3xZ4a5awHPcdMjSyXUFYiKUuBlpPlAJT3mA8niN3dM=;
        b=yXzgcKWYO7D8xiztM+BrKd0ZNBHkso66Zmm21UNEQuHMx5AF/6rk+OdiptQ35aT8S5
         cFrkLXT4lffQ2iZXpy8SPAD1W9J02Yk7SjpGANDgCcWDqfdZSHo7t5H0OVJQbuTKjvXk
         26oIqn9/hLCZPSfGgSlUd9xcS/Pm4gl+n/ynIRSwexO+IpHBtIkW2Xwib0eqcQKDn5mq
         Vivf0EOcQOlPBhOyxs0jsbJh11CJtuJ+g2hwHj6gYx/03yoS4xZUcL3lEn23LldbXhW+
         6m7aPr4aoFHhgtfsy7tcZkc9PSgnuuMmdY5f1+7/ZMJl3BOb4BpHXAthwKLsf3Jz56UL
         koFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744027; x=1729348827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3xZ4a5awHPcdMjSyXUFYiKUuBlpPlAJT3mA8niN3dM=;
        b=quA0rjOqksgX2k3MTSeo7/O7FivbMfeaIH2n+ZuTKJTpsNEqKCH024R5xYq14eRaO0
         VW/Hv2TWZIOoTVoyBqxhSZlVAM/AiVoapt9oqklogu86d1AuOkckuQggjkARtPp4mlWK
         QKYsu1M58SYEimrTU/Z57wYWAfXc3BbN7iFcK0C3JQ6lZ6gjJl9ID1whj/47RA9y4/E+
         ghyVfUr0rAUH0vS/PPVVV5pUoPJ9F6xm9b9r66MADFPZxADbzoZgNSQk7wG0nKFf5R6v
         gwX8KNxBTssxPN0qQOChGpYjHrw/H0bHR3kpDaixA7U8cbVJeXa5Pcl6QqPe+3VAGukl
         QlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDZ4U/Snn8biWXz93gKIAAhCN8I11QelnlvARM2NhPejk1I4KPZPCdr8KAbzBu+c9Oq7awFKivkgX/VoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmzwrKP+47Um4ppV2b8NAUW5Nf4728Xt6qRLl0WlBdqx6Dwru
	9ArzrkCVFDLXhZFJvt5TiEBWOvWsJQ86fktttxoWoCMA6bAMcz+VFGhykikeBSw=
X-Google-Smtp-Source: AGHT+IG9ioLyyHl/HtWV0pbHTj1ySQ8SJ6REFjcmSOPMoXc68Zmr1Vs+Sj6fLUwZqHEWKbuYJDCdLw==
X-Received: by 2002:a05:6402:8c3:b0:5c9:55aa:4285 with SMTP id 4fb4d7f45d1cf-5c95ac63c95mr3728863a12.34.1728744026673;
        Sat, 12 Oct 2024 07:40:26 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5cea5sm328289766b.96.2024.10.12.07.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:40:26 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Sat, 12 Oct 2024 16:39:32 +0200
Subject: [PATCH v3 6/6] arm64: dts: ti: am62-lp-sk: Add wakeup mcu_mcan0/1
 pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-topic-am62-partialio-v6-12-b4-v3-6-f7c6c2739681@baylibre.com>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
In-Reply-To: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=msp@baylibre.com;
 h=from:subject:message-id; bh=3rhP+Zbms4CJO3Z/gy2uQZJnt81xMUEEDV0P1R+LUzc=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNK5uryjmTWWb2ScNI+J177mJLPVcVufx39rP8U8/ffy2
 lFRF6WgjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAif5sZ/pmfLkpexfrk3hnz
 LCnZGC/jTpNLzfWrH/118Fl72pzTlZmR4bDFj0v5R2OuN/vczf5im75M4A3LhAWuHK7v1t1KVND
 V5AAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 783ad65e6165ea74010c3240069fc6d99a0cd035..de3c9abe39ad35cbab9e480d76e7161bd46af46a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -255,9 +255,55 @@ &gpmc0 {
 };
 
 &mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
 	vio-supply = <&vddshv_canuart>;
+	status = "okay";
 };
 
 &mcu_mcan1 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
 	vio-supply = <&vddshv_canuart>;
+	status = "okay";
+};
+
+&mcu_pmx0 {
+	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-pins-wakeup {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-pins-wakeup {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT | WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
 };

-- 
2.45.2


