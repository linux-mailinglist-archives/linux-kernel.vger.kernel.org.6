Return-Path: <linux-kernel+bounces-216083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E46909B25
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2F91C215C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91967163A97;
	Sun, 16 Jun 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Zx8YZv8e"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130F2A1A6
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718502924; cv=none; b=pBOgGifqwjomCoCBwQ2UTBse8S0t8C23Cp/lSmhYRlO/rAm09JzvdPCi57M6KEVGBgkpyOAqUw4CWbN5irXYZeVzX6+GZNP2WIFoJcS0HOsTY1pgS7QQKvVv0xNuvtTGptL0B9Ip6yKiRT/xk9o7DW0OyM3UbLze1+0ljFISBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718502924; c=relaxed/simple;
	bh=gToYcgEXPl8RMOBRGH1O5IX4HgOMTtUquue4ZNNOFI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gRiYOWFqsSHABDqstx3Euvs/8INOvPbIEWTrBLFnLbDl6vI9kl51ZX3PwObMxcZmsTQy3mPbnWgwoxGX+1pjPGTDSrblp96f2W/e83cvHpPn7MrwS+zMrOTwJ786y5Tnr8YgO4gWaywAy7wNHDhmHgJndDM1pl61nL4oFt06/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Zx8YZv8e; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso2626275a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718502921; x=1719107721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6/TFQb8ZgC49V/e8JMLt5R3HuWqpyZHKZc6KnVuH0c=;
        b=Zx8YZv8egurwOu/Gu3b7IFhtv1HIEhGiJwg7DIOVuGBQbrqREO/DyoOXzIytaz2v2m
         FsFGRkfWbQn6M/jYg937bNoheu6xOjxPcpMczIqS0T6cHBOeD3tkZdCOZY+1UT82De8C
         hdD7Na9pUzZtaHTSb2jeZyNY3Tz2aK7FPyPqJMni/5RZKkWwSW15Mm9QmI/1HzCj44qB
         wSOE3P+8BSnj7adbYsiaqvEeI8GGULsGOoclrTiVkizscuxczQ7U86raK6i9UIuFbrrE
         2T09dRYRpaGImlBpkuB8YaLvAI9DIliluLvnP7f4i+/awq7XyI/M8WH4HrWlnmMshMSM
         YsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718502921; x=1719107721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6/TFQb8ZgC49V/e8JMLt5R3HuWqpyZHKZc6KnVuH0c=;
        b=WZNs4CayTB0frls2A5GEkdDS873xFTfT1lPcmhNi+LIjw3pNYCIWFZCzBqOHbV2LRi
         eTzCM30w6+wuXXn0B41HzuD8KYjZ25Y8fv9UxARLF5dyfx3/QxMGg+qypcHomaoNqDJh
         1jIB3KA5punLK57lqtCtJ3OOwzkHEQOsa+puOCxQNd3ltx4otNK6354ac7RG+yF0Ec8X
         r/g3iWTwKYryMpKgg3OnwiSMoOG2E9YvXqwvkPI5PCqpjTdOG8mWLEtWMweHrCluqS59
         49zFdnpSEFj6Jyn5VHqZ3lh3cSaX+BefJifIRufhJlfpPRHCGmMnodB4Hfz2C+AE2brz
         GGwA==
X-Forwarded-Encrypted: i=1; AJvYcCWU3y0kVzuZqmoauu7/Ctb/URm2RqhQpF5yKfD5+NvE/TaGW6AEzCcWsfac+LoSgtwNyuFbXnMoYrlBIRV8lCdzguZzscaJL24TDr5Q
X-Gm-Message-State: AOJu0YyWhc2QDFEcqkVJe9Lnn7igLfyTnPRoqccxS0RqcAWTH61CWz9V
	rNXHAKSJ/7a33TnDtA7K8xFTcUjiK76eTavJGuX5nKp6CQOgMdJ4WUFUmX16Nos=
X-Google-Smtp-Source: AGHT+IH82iPNF8qXNXUTrf3U/q2udG9cxwLwHm7cOupfogf2spUfAnxOiJnMle1wfsEKeQ7cXXamzg==
X-Received: by 2002:a05:6a20:cf8b:b0:1b8:b2cf:bd8b with SMTP id adf61e73a8af0-1bae823dcc7mr6192244637.47.1718502921136;
        Sat, 15 Jun 2024 18:55:21 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1cea:28dd:2ee0:e8e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769aedbsm8751201a91.43.2024.06.15.18.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:55:20 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sat, 15 Jun 2024 18:54:30 -0700
Subject: [PATCH 1/6] dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240615-th1520-clk-v1-1-3ba4978c4d6b@tenstorrent.com>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
In-Reply-To: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.12.3

Document bindings for the T-Head TH1520 AP sub-system clock controller.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml        | 58 +++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/clock/thead,th1520-clk-ap.h    | 96 ++++++++++++++++++++++
 3 files changed, 156 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
new file mode 100644
index 000000000000..461abe62626d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/thead,th1520-clk-ap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 AP sub-system clock controller
+
+description: |
+  The T-HEAD TH1520 AP sub-system clock controller configures the
+  CPU, DPU, GMAC and TEE PLLs.
+
+  SoC reference manual
+  https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+  - Wei Fu <wefu@redhat.com>
+  - Drew Fustini <dfustini@tenstorrent.com>
+
+properties:
+  compatible:
+    const: thead,th1520-clk-ap
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: main oscillator (24MHz)
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/thead,th1520-clk-ap.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      clock-controller@ffef010000 {
+        compatible = "thead,th1520-clk-ap";
+        reg = <0xff 0xef010000 0x0 0x1000>;
+        clocks = <&osc>;
+        #clock-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..761fcbddc8d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19320,7 +19320,9 @@ M:	Guo Ren <guoren@kernel.org>
 M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	arch/riscv/boot/dts/thead/
+F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/include/dt-bindings/clock/thead,th1520-clk-ap.h b/include/dt-bindings/clock/thead,th1520-clk-ap.h
new file mode 100644
index 000000000000..a199784b3512
--- /dev/null
+++ b/include/dt-bindings/clock/thead,th1520-clk-ap.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ * Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_TH1520_H_
+#define _DT_BINDINGS_CLK_TH1520_H_
+
+#define CLK_CPU_PLL0		0
+#define CLK_CPU_PLL1		1
+#define CLK_GMAC_PLL		2
+#define CLK_VIDEO_PLL		3
+#define CLK_DPU0_PLL		4
+#define CLK_DPU1_PLL		5
+#define CLK_TEE_PLL		6
+#define CLK_C910_I0		7
+#define CLK_C910		8
+#define CLK_BROM		9
+#define CLK_BMU			10
+#define CLK_AHB2_CPUSYS_HCLK	11
+#define CLK_APB3_CPUSYS_PCLK	12
+#define CLK_AXI4_CPUSYS2_ACLK	13
+#define CLK_AON2CPU_A2X		14
+#define CLK_X2X_CPUSYS		15
+#define CLK_AXI_ACLK		16
+#define CLK_CPU2AON_X2H		17
+#define CLK_PERI_AHB_HCLK	18
+#define CLK_CPU2PERI_X2H	19
+#define CLK_PERI_APB_PCLK	20
+#define CLK_PERI2APB_PCLK	21
+#define CLK_PERISYS_APB1_HCLK	22
+#define CLK_PERISYS_APB2_HCLK	23
+#define CLK_PERISYS_APB3_HCLK	24
+#define CLK_PERISYS_APB4_HCLK	25
+#define CLK_OSC12M		26
+#define CLK_OUT1		27
+#define CLK_OUT2		28
+#define CLK_OUT3		29
+#define CLK_OUT4		30
+#define CLK_APB_PCLK		31
+#define CLK_NPU			32
+#define CLK_NPU_AXI		33
+#define CLK_VI			34
+#define CLK_VI_AHB		35
+#define CLK_VO_AXI		36
+#define CLK_VP_APB		37
+#define CLK_VP_AXI		38
+#define CLK_CPU2VP		39
+#define CLK_VENC		40
+#define CLK_DPU0		41
+#define CLK_DPU1		42
+#define CLK_EMMC_SDIO		43
+#define CLK_GMAC1		44
+#define CLK_PADCTRL1		45
+#define CLK_DSMART		46
+#define CLK_PADCTRL0		47
+#define CLK_GMAC_AXI		48
+#define CLK_GPIO3		49
+#define CLK_GMAC0		50
+#define CLK_PWM			51
+#define CLK_QSPI0		52
+#define CLK_QSPI1		53
+#define CLK_SPI			54
+#define CLK_UART0_PCLK		55
+#define CLK_UART1_PCLK		56
+#define CLK_UART2_PCLK		57
+#define CLK_UART3_PCLK		58
+#define CLK_UART4_PCLK		59
+#define CLK_UART5_PCLK		60
+#define CLK_GPIO0		61
+#define CLK_GPIO1		62
+#define CLK_GPIO2		63
+#define CLK_I2C0		64
+#define CLK_I2C1		65
+#define CLK_I2C2		66
+#define CLK_I2C3		67
+#define CLK_I2C4		68
+#define CLK_I2C5		69
+#define CLK_SPINLOCK		70
+#define CLK_DMA			71
+#define CLK_MBOX0		72
+#define CLK_MBOX1		73
+#define CLK_MBOX2		74
+#define CLK_MBOX3		75
+#define CLK_WDT0		76
+#define CLK_WDT1		77
+#define CLK_TIMER0		78
+#define CLK_TIMER1		79
+#define CLK_SRAM0		80
+#define CLK_SRAM1		81
+#define CLK_SRAM2		82
+#define CLK_SRAM3		83
+#define CLK_PLL_GMAC_100M	84
+#define CLK_UART_SCLK		85
+#endif

-- 
2.40.1


