Return-Path: <linux-kernel+bounces-170666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6208BDA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815691C23B37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B56E5EC;
	Tue,  7 May 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="flA8Kn5+"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5876BB4A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057855; cv=none; b=tp2WBn0A5j+r4VwSo8fEmI4+eOe8lMqD+yvBewwX1qKCKqOlq0Fwe99byg/IlgXLFt4yuW4ZX20jOT0C2zmRsne3PDSp3raohOqQup70iCHA/oqnOc4Oa4ySxfuZXEOzqAsTPuR+qsmgOeBtFhb4HnZA1qv7BpEQICrF9gcFjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057855; c=relaxed/simple;
	bh=kl9L43yr08kOkqrR3WA1I5DaIGyMSq6kKegAe4KxtIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AX1vitHjkbduQCbPcQ1SK2rfOEtLdfyEZmjw1fQnRzl8CQtQTD35fRppbI+v+Ld8FICcXHOQjQvwLUlCH+rZiQ8E9rgABbY3bMDdK44N5WQOeip19IX8l+GLY8GTV5Gw2GqJ4kVtC9mHlthSbv+dw8HA/mX6+y9eM7YcltvJ4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=flA8Kn5+; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f09ed75e4cso51268a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1715057852; x=1715662652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+wugaHanEGkc+bwlkiugtOaCjbfBNOZDr8erEgY2Ao=;
        b=flA8Kn5+6H/bZjLxYPRXSINIgVU1jTREr0KFl6Bspa08RhDp8oGvpUbrdgOcLxubr6
         eJvyD4Q9BYhDj4atfdLdFFAUljTPAhD2i44t3Yjq2mQdqthGGX+7fjJ54mXVFnf32raE
         efj5tu0mWtCdbhOiKQI/YhAf68/ratOamcM6EW76rv1C3cXerjSNFmzvcktGjjuA5Jit
         Q2hBi2+NcDZgVGoDdS9XxBGOUertuf5nDF3rtc4MKpbqtYM/KlEiWQA4Ivh9S187qGvV
         O+CvH1UB9S118rGfvjdlduafm5ESBiLZNA9yxNlYEOehu6x73oESI1SeMjlroAG0hg7e
         UkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057852; x=1715662652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+wugaHanEGkc+bwlkiugtOaCjbfBNOZDr8erEgY2Ao=;
        b=Kdtaz9OoUy2C9paTacMhbdYU6v8QUt0hAs8WgwWoPd8Tf8CzPLmHLMW+ncDBPOmpgd
         jE6hC8KAgeFcEWpF6IGanXLs1lsXYXjNadePLqHTs+C/TfnDYYyZqh3DfBbiA96Gfji0
         0c3b+n8Y8fQuMtgro1NPiIoWlQiKb2BPj2x4J2WNpxfovCQie+8iX8la3xXGoemWoyhJ
         YJy/g3CAxSrvYHTSxJEvk5IHKohbwQY81mdB4/vg3weo0T/G8kAM0ndECVN6Klk7pcNF
         2GKWqAiteP5tkjPWEn/RDRcvwjuLf9WPgatf+yIRH6UIWUiELJB7WNiCkL63haX3lXUl
         /aLg==
X-Forwarded-Encrypted: i=1; AJvYcCV97o4DtbMZWvCPu2hkwKf1tE49f0wfOdPqLsB5gfetQop2vsonJLJQ8dvOhnhxPmS/CtKvzxvMp4365R5h7ox+Q8fjYx9Adh2/fcuV
X-Gm-Message-State: AOJu0YwLdslRmI234oP0CjVk6QcMzLja5rJgQh2aCchpno1v/19z6anJ
	0N11g9Q5CAKOPyI521uDFHNnoYlP0nTFULcnz0pcLSiqAgwBW0W0DqlCOLDgC/M=
X-Google-Smtp-Source: AGHT+IHIlrKs2ekmKEyBbToJ0bPSfqdwse1g5jUcWgGzB4UqnMnPPlPjkxqrKLk7yC/SGkCWlV+X/g==
X-Received: by 2002:a05:6808:10ca:b0:3c9:6e70:cf84 with SMTP id s10-20020a05680810ca00b003c96e70cf84mr5510789ois.28.1715057852188;
        Mon, 06 May 2024 21:57:32 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:6870:7119:e255:c3a0])
        by smtp.gmail.com with ESMTPSA id o14-20020a637e4e000000b005f80aced5f3sm8987249pgn.0.2024.05.06.21.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 21:57:31 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 06 May 2024 21:55:15 -0700
Subject: [PATCH RFC v3 2/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-th1520-clk-v3-2-085a18a23a7f@tenstorrent.com>
References: <20240506-th1520-clk-v3-0-085a18a23a7f@tenstorrent.com>
In-Reply-To: <20240506-th1520-clk-v3-0-085a18a23a7f@tenstorrent.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715057849; l=5687;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=kl9L43yr08kOkqrR3WA1I5DaIGyMSq6kKegAe4KxtIQ=;
 b=ZwyHSQdIrl8IJFyLF+oLhRR1A3uZLQPDiw7rlBbOvni+A5lnCwun8M8Oxl9gt+oHHWMIEFY3Z
 nS+FT7hnN3wBYV944608yeE9BZ8IBDcTaZ2KEUiOhlRDdmJptXbecxu
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Document bindings for the T-Head TH1520 AP sub-system clock controller.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml        | 64 +++++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/clock/thead,th1520-clk-ap.h    | 96 ++++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
new file mode 100644
index 000000000000..d7e665c1534a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -0,0 +1,64 @@
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
+  clock-names:
+    items:
+      - const: osc
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
+  - clock-names
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
+        clock-names = "osc";
+        #clock-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ec0284125e8f..2b4fa9a81a01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19014,7 +19014,9 @@ M:	Guo Ren <guoren@kernel.org>
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
index 000000000000..d0d1ab1e672a
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
+#define CLK_PERI_APB1_HCLK	22
+#define CLK_PERI_APB2_HCLK	23
+#define CLK_PERI_APB3_HCLK	24
+#define CLK_PERI_APB4_HCLK	25
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
2.34.1


