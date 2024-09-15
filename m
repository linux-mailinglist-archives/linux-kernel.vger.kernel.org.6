Return-Path: <linux-kernel+bounces-329671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A1979481
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34D51C21731
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7EF10A0C;
	Sun, 15 Sep 2024 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="RuuzTrnD"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD62CA6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726368260; cv=none; b=TS9+mMvQl8ozvN9knb/8g9RhSRL7fdRj4gHQ+hBTaoCTrrFQh418oXsjkTUVsHLX/YvdehlQ6c5AVMvdX5Od2NGCx/DMIoVMLZprq62mxWASGwwzHYgeZiZzfm+ieS4c6OL22LdPX0lVVJr+JmtzkrblEPRL3T9SmhP7hNnm/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726368260; c=relaxed/simple;
	bh=RHt/CuEImmNnG/8VOU+K/H1jEiWMV+ZSHNrD1hvj2cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bF8gX15iL9hSKpPvt5uM8pXwTYWEmSzG+R3NSoH6xRIv64pT/pIJULBhOdBWolu0I/0sOtCSxOabxK23aYegvMMX0DdHLMba3Z56hK2qJQmQfwsZV46KSQFfPU6yYsruS1f8kED9Eyk7fY+z/iCJ+qesFZbH3xNNzo2P7a1c8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=RuuzTrnD; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1da3677ca7so2664429276.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1726368257; x=1726973057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nq2qwoQ8fGvyakSE32KyqUjWPDGD9IAug2eijzHwHho=;
        b=RuuzTrnDv57rErXTLd25zDpe4fCV1bQMJiux+7rjrbeO9G8VOjOTGuoaDGEZ+x06ub
         m3peAX7XBU84EKfBnJQ9A7cyQg59sZ6viy0ggrbVw8GCUTy/iDNb2/q1WZhAdTiBGTQ4
         n8MMhtA/fy2zYQzRiRAZvtAfcV4LE7W+YM1w5NF7+KOHWzFZZ27RiLVi5erip3uoD0Ks
         GAY33hhUcYPUqfWlV9YSGPvyn9i+uA3ljZVNuqOJx1M6PhNEFoVIbeMa8LSb1OwVdiTk
         gNgU8bAxYzGEe0AHPz+cQ4Y16vgfXfp+sjZTGDd6++/Ys9WdKWxoj7GFlkqu0uWQRLj+
         KCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726368257; x=1726973057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq2qwoQ8fGvyakSE32KyqUjWPDGD9IAug2eijzHwHho=;
        b=BckBNWV2QrRNVFNw6VHvNsYvuGZfdXy+fE/eCZuR4qyIuxWo7PE+wesicvZ1i72g7/
         IQz7NlgUyPmBZWXnIk9xry88/lY7pVgBeNZr6DwkTgRs4QmjT5xO/bv42ZU8KIRHCAuT
         3RirYamGy0CUF57GR4lBgOzl0HJMfsdBtkg2aO89XQo3mBZ3c+ptUEw+1gmpNgRk+njA
         rOX0hMqNnU9Q49ed27rr6DCj8Va9PHztr2beRyeMcjNnp8brPQIwhX6Tnjj2zuGJPm/1
         xqWdr+YifF+qkbiuuWAKqZWaPNRUfkj5ba+T9eRVPMBx4AlvXT8rzg52+takwR2OPG89
         bxnw==
X-Forwarded-Encrypted: i=1; AJvYcCUwhtFKCOqX4J0KPvgn9bI9WMwj9Iv8Su8jdaQmXnHxIvfYC0g80m8Zwi+vzJLwauwust9t9A6VeYjzFOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQY481oaIhY4R78WrlYnCZgX1DJny15R6VRixV5AVu1nEjtah
	3wTOV4lfE4n1CNbCSC5tmLa4coteQJiBb1sdCVyKDiON9xUo6vxOZAELmkMtVPo=
X-Google-Smtp-Source: AGHT+IEClZ21Xn2I0tdDO6eQz5l4CSj9mqsoGgEda3xSmNTjGf1KEuzvGBfrhopXDCp2Yb4bN/rIaQ==
X-Received: by 2002:a05:6902:1881:b0:e0b:e47d:ccc9 with SMTP id 3f1490d57ef6-e1d9db98c66mr11206546276.8.1726368256818;
        Sat, 14 Sep 2024 19:44:16 -0700 (PDT)
Received: from [127.0.1.1] ([216.139.163.245])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2e0d924sm4129097b3.41.2024.09.14.19.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 19:44:16 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sat, 14 Sep 2024 19:40:56 -0700
Subject: [PATCH v2 8/8] riscv: dtb: thead: Add BeagleV Ahead LEDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-th1520-pinctrl-v2-8-3ba67dde882c@tenstorrent.com>
References: <20240914-th1520-pinctrl-v2-0-3ba67dde882c@tenstorrent.com>
In-Reply-To: <20240914-th1520-pinctrl-v2-0-3ba67dde882c@tenstorrent.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add nodes for the 5 user controllable LEDs on the BeagleV Ahead board.

Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index c5356f674f85..823aa5b44efb 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -7,6 +7,8 @@
 /dts-v1/;
 
 #include "th1520.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "BeagleV Ahead";
@@ -34,7 +36,42 @@ chosen {
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
+			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led4";
+		};
 
+		led-5 {
+			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "led5";
+		};
 	};
 };
 
@@ -82,6 +119,24 @@ &sdio0 {
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
+			function = "gpio";
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


