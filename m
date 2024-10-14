Return-Path: <linux-kernel+bounces-364544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6B99D5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51261C2263C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B81C7B6F;
	Mon, 14 Oct 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Ag+xPWAn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EE1CC16F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928484; cv=none; b=mReyjA2eaR/Xr4UynuS5OGaLcvOrqAx27dXE9uwE++89o69yCAFFX11klwl57P8uTFShZHj1hVI2RQuXGZ2nOJXUdBhP2tHDusOqnDWcAmFRmWLwjTdzCtsutChAR9R6EPbkPLmf2qnql5GTWJd37Ae4GRBZg+++/FLlCIaCCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928484; c=relaxed/simple;
	bh=3zHP+Ar3McnixX54GRR+K+Zs2F8kNEFHuYU0RaYEfUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMkkq3YtK4OUdsMj3FfNcTIk1/fFq9HPYyLqXlBNukbZ6S9b933FI8NOd+wtbzcalo6hFz5MoT/RM3jshbnLavz+rMYo7gAx1ceZPSd/E/MeaADjW9EAKFHtw496Ic7XzyBmxGWuCoY82XW0vqNdbquKKpIaYjkcP25sUrRVm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Ag+xPWAn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e427e29c7so1735722b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728928482; x=1729533282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8k+Ak70OWe9Icimvivr1l9WRiR6s756j4FbBxJKO5A=;
        b=Ag+xPWAnvyTuP/eJLfG7P1mlXOIko0nS+SnUSUsTTZMEG7569kTCjMCj9KiO45EgHy
         8hEW1R2WfRFeEritfrh4GJ8mYX+bojmg14aPWLRgYC9I9WAMAwAqRG9POGkRTAUBzR/z
         66yeXc9NPN4OnYJK5p9tNaw7x9dlKFe4GSv0linQMfwWYssgfSGLTB7rjX6qvRZVvwt4
         3gD/daCuw9Oql6qsDkk7/QzHEPoJFIp4AA5CqWogRY93pwvV3v9sThWrOBAgmYeTidiJ
         /6IhvyJPWvImKVniKJ+/h2xRUEXEXlbB+7Zk5D7mpw4cUDct32LSzunNGETSPUuEo6h2
         UEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928482; x=1729533282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8k+Ak70OWe9Icimvivr1l9WRiR6s756j4FbBxJKO5A=;
        b=GpQbnERDyu9Ts5xOU7P70AZEyV2VDBMF/v1wFA/ehRIIFdWErvHgl1O/oIwM+2m03v
         ugT5SmQB1NYafMfDV6GX1/7tMLz8s9466grNArKYLmCEZ7304Vtj5AibMErIFgi32+vs
         ESYUwMdFDBiwy/4ipPRKFj865V2VAvAlcpeOO0AHxPmPS6ce4RHNHQHd2ec/YNHRCJPs
         r7WlDp8MKCPq/tojJwPRh5YJjuuSikbsD6kA1107/g/D1iGh/bYyPV6dyF7FQTWBmosi
         2p5nF92j/LQoLbbAqN2nTDxZsiF8qu/NTn574WUEU9HEfGrXBIUwPCzZv0tlxck6y6jf
         jrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCViBN/xrvzFabZ9d6ziSd9Q7Vn46a9ouPODgWvnAJ0XqL+Hr1XP/Tyw9W5bNvxljxN5zoLmCOgBjlRmX2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9avptBBrVRhLm9cSc3HMcmseid4oDvytt39U+SiLprNPka4vc
	DRv9UUeRw3ChVc5wvnngieQG53iMViiE6a9WBpnEmQZKR5MG4GfV3I8DQZolYrw=
X-Google-Smtp-Source: AGHT+IHqJLvucWLAGZ5AzhHinp9PbSR2cpVHqdqttcjIU+06NfsllWY/kPZKL7TywtCJgFpTSeOOxg==
X-Received: by 2002:aa7:8890:0:b0:71d:e93e:f542 with SMTP id d2e1a72fcca58-71e4c1cfdffmr15523167b3a.21.1728928482095;
        Mon, 14 Oct 2024 10:54:42 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e49a7e5e7sm5611109b3a.179.2024.10.14.10.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:54:41 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 14 Oct 2024 10:54:23 -0700
Subject: [PATCH 6/8] riscv: dtb: thead: Add BeagleV Ahead LEDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-th1520-pinctrl-dts-v1-6-268592ca786e@tenstorrent.com>
References: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
In-Reply-To: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add nodes for the 5 user controllable LEDs on the BeagleV Ahead board.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 0484fb390be4..c0cf9b086f81 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -7,6 +7,8 @@
 /dts-v1/;
 
 #include "th1520.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "BeagleV Ahead";
@@ -35,7 +37,42 @@ chosen {
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0  0x00000000  0x1 0x00000000>;
+	};
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led4";
+		};
 
+		led-5 {
+			gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led5";
+		};
 	};
 };
 
@@ -61,6 +98,23 @@ &emmc {
 	status = "okay";
 };
 
+&padctrl_aosys {
+	led_pins: led-0 {
+		led-pins {
+			pins = "AUDIO_PA8",  /* GPIO4_8 */
+			       "AUDIO_PA9",  /* GPIO4_9 */
+			       "AUDIO_PA10", /* GPIO4_10 */
+			       "AUDIO_PA11", /* GPIO4_11 */
+			       "AUDIO_PA12"; /* GPIO4_12 */
+			bias-disable;
+			drive-strength = <3>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &padctrl0_apsys {
 	uart0_pins: uart0-0 {
 		tx-pins {

-- 
2.34.1


