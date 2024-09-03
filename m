Return-Path: <linux-kernel+bounces-312149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD219692B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EBC284812
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4831CE6F4;
	Tue,  3 Sep 2024 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="UShPw1KQ"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE11CDFAC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336535; cv=none; b=NcxSI0OJARI1LqF0llz2MdfndD2NPDlSS9B6FDvjvDjQ1eFreedRCz68EnP9awBIHmoRFP/U2uMZuLEUAM9Eyx5s+XX7QXUtXrOfP6/6o/dplhgycHKozfXQ+GkVBGRuaAdn03a1sMoXtFq4Xxhw219WmX1QdB9UXIJTasaz9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336535; c=relaxed/simple;
	bh=NPQZAEUiwMifLsQkJHzScxo0bd7Xpz6Wh5rkQuqJZoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJJL6k/fjkwfZsxl8Smg7kbD5n5JCCuNIxVcFQmhQuzSiIM4w+eN4dVJtVzYhlY5WSXe0YMIIqqblkerEoXx+iEL8a2WKcmy40c70HZiRgauJsCIkiW1JtuI8loMBcM8e5fxrbvLmNP6MJCyLGSDEfHQtgD6FgPYKOp6z6dX/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=UShPw1KQ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5dfb53d4b13so2022394eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1725336533; x=1725941333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQeWC4esiWQu66sp58Ti2PlUMH3QkENQQzReu8XsD5I=;
        b=UShPw1KQolzAE4HxKa7JGaoyvIQqO9GchwSAAaufxAYfDAkGweuDh87h+xQHOrTZiY
         OGp5xzvsDYuBsOnNRFV+/sSCRDrhuAhGk/IiW67VG2fuYttbh3fCea1hxZBxDHVMSznb
         q9zwi0akwVONHfzLlq1HYGIJNjkliUOk2DkriKJtCj6SLAGwx9ec6fE3TV+tdhvvcmt9
         0CUJxUy40SQNP3BdINSJYLLRUzL8VHz9nmh2ycMXQwQzb1TtrOoe5lUXh/3Gt6h3GRpe
         XSTtA6HIUNbo64Ai+9X8LnlYS4IGb3NFCtnH/UcDk9FfDtl7+x4+63Hlyi0yzrj7IHCQ
         qGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336533; x=1725941333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQeWC4esiWQu66sp58Ti2PlUMH3QkENQQzReu8XsD5I=;
        b=ZYcAydexnNjVb8i2WD7w48zRT/jxWmlVOethgF/0u51I7/WRI5/RdrhKORdtO9BWRr
         55Yvp6cTOaFVxWGylyajb+VqdMHmO48YPMpWOUKe1lTRqyPeYMkMUTmjX7Ot80iw5eOR
         BIM8PdbxyTr1z/VA6CjaZbuleriaApYlEnM4b7AWnoBBKwO18F/vG5N3SItPZ8Wn8RIo
         mRlZ4CSEjCHx1fOw15f/ZHdFbGZhk7lgRyWNkNALsjiB+/js722BgzPTbkpLkJ9x8Xoz
         2tUi8h8T/QEhiFdxOu67f2az5HfkQBof7beMkSvUC7cmJx/CBEvjM0ZEgUA0nD4ze8la
         m0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoLaz6+MQ9q8eAoASjlm1h7fd8dbNHuueOm5Bbvyu8bv9baCcyifMzeuKk0cwPlU0Wcl4F3wloozvdvEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLp2inhbfA2QuKGKqym5LyUQZRvY5W3yhCfSI6+HTVn12TRPBF
	TWjF2U0cqvk6/ZGNy/HQUOLixLkOs3h+OiBvcMSjrLWDuJrtijYpGDZ8HWy5zPw=
X-Google-Smtp-Source: AGHT+IGZsVVofu2/84YfJAfWiuIMKDFVPUHS/Q38VYNegZ3WnElEbZyyB2BraUzn5Hqai839ktDPdA==
X-Received: by 2002:a05:6358:9391:b0:1b5:fb48:e588 with SMTP id e5c5f4694b2df-1b7f1b1b8acmr1121494755d.23.1725336532888;
        Mon, 02 Sep 2024 21:08:52 -0700 (PDT)
Received: from [127.0.1.1] (75-164-215-68.ptld.qwest.net. [75.164.215.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef39sm7532701b3a.122.2024.09.02.21.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:08:52 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 02 Sep 2024 21:06:54 -0700
Subject: [PATCH 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-th1520-pinctrl-v1-1-639bf83ef50a@tenstorrent.com>
References: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
In-Reply-To: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
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

Add bindings for the pin controllers on the T-Head TH1520 RISC-V SoC.

Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[dfustini: use a single compatible for all pin controller instances]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../bindings/pinctrl/thead,th1520-pinctrl.yaml     | 165 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 166 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
new file mode 100644
index 000000000000..429cc0bc1100
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/thead,th1520-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-Head TH1520 SoC pin controller
+
+maintainers:
+  - Emil Renner Berthing <emil.renner.berthing@canonical.com>
+
+description: |
+  Pinmux and pinconf controller in the T-Head TH1520 RISC-V SoC.
+
+  The TH1520 has 3 groups of pads each controlled from different memory ranges.
+  Confusingly the memory ranges are named
+    PADCTRL_AOSYS  -> PAD Group 1
+    PADCTRL1_APSYS -> PAD Group 2
+    PADCTRL0_APSYS -> PAD Group 3
+
+  Each pad can be muxed individually to up to 6 different functions. For most
+  pads only a few of those 6 configurations are valid though, and a few pads in
+  group 1 does not support muxing at all.
+
+  Pinconf is fairly regular except for a few pads in group 1 that either can't
+  be configured or has some special functions. The rest have configurable drive
+  strength, input enable, schmitt trigger, slew rate, pull-up and pull-down in
+  addition to a special strong pull up.
+
+  Certain pads in group 1 can be muxed to AUDIO_PA0 - AUDIO_PA30 functions and
+  are then meant to be used by the audio co-processor. Each such pad can then
+  be further muxed to either audio GPIO or one of 4 functions such as UART, I2C
+  and I2S. If the audio pad is muxed to one of the 4 functions then pinconf is
+  also configured in different registers. All of this is done from a different
+  AUDIO_IOCTRL memory range and is left to the audio co-processor for now.
+
+properties:
+  compatible:
+    enum:
+      - thead,th1520-pinctrl
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+
+    additionalProperties: false
+
+    patternProperties:
+      '-pins$':
+        type: object
+        $ref: /schemas/pinctrl/pincfg-node.yaml
+
+        additionalProperties: false
+
+        description:
+          A pinctrl node should contain at least one subnode describing one
+          or more pads and their associated pinmux and pinconf settings.
+
+        properties:
+          pins:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
+            description: List of pads that properties in the node apply to.
+
+          function:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/function
+            enum: [ gpio, pwm, uart, ir, i2c, spi, qspi, sdio, audio, i2s,
+                    gmac0, gmac1, dpu0, dpu1, isp, hdmi, bootsel, debug,
+                    clock, jtag, iso7816, efuse, reset ]
+            description: The mux function to select for the given pins.
+
+          bias-disable: true
+
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+                description: Enable the regular 48kOhm pull-up
+              - enum: [ 2100, 48000 ]
+                description: Enable the strong 2.1kOhm pull-up or regular 48kOhm pull-up
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - const: 44000
+            description: Enable the regular 44kOhm pull-down
+
+          drive-strength:
+            enum: [ 1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23, 25 ]
+            description: Drive strength in mA
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            maximum: 1
+
+        required:
+          - pins
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+
+examples:
+  - |
+    padctrl0_apsys: pinctrl@ec007000 {
+        compatible = "thead,th1520-pinctrl";
+        reg = <0xec007000 0x1000>;
+        clocks = <&apb_clk>;
+
+        uart0_pins: uart0-0 {
+            tx-pins {
+                pins = "UART0_TXD";
+                function = "uart";
+                bias-disable;
+                drive-strength = <3>;
+                input-disable;
+                input-schmitt-disable;
+                slew-rate = <0>;
+            };
+
+            rx-pins {
+                pins = "UART0_RXD";
+                function = "uart";
+                bias-disable;
+                drive-strength = <1>;
+                input-enable;
+                input-schmitt-enable;
+                slew-rate = <0>;
+            };
+        };
+    };
+
+    padctrl1_apsys: pinctrl@e7f3c000 {
+        compatible = "thead,th1520-pinctrl";
+        reg = <0xe7f3c000 0x1000>;
+        clocks = <&apb_clk>;
+
+        i2c5_pins: i2c5-0 {
+            i2c-pins {
+                pins = "QSPI1_CSN0",    /* I2C5_SCL */
+                       "QSPI1_D0_MOSI"; /* I2C5_SDA */
+                function = "i2c";
+                bias-pull-up = <2100>;
+                drive-strength = <7>;
+                input-enable;
+                input-schmitt-enable;
+                slew-rate = <0>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 878dcd23b331..a73953c0f080 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19700,6 +19700,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h

-- 
2.34.1


