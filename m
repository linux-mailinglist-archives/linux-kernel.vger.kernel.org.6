Return-Path: <linux-kernel+bounces-226558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378ED914054
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ECB1F22B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E26FD0;
	Mon, 24 Jun 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="F0JNitK8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA346B5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719195347; cv=none; b=R2H7kk91YAbkCCll8/QoxeZ15kLeoHYO1tklrx+/CHqqtp+RAVqw7Yb6P71nBEJXlUUXsGzCfsRdV8bu2R4AL/hx485p8hT7+SPzX3djZErHVZG3/lNw+sA8KJYWmwKKyx7ThaSoAQpt9c3n6YQyQjUb0pTM4vHnA3GOeQtSei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719195347; c=relaxed/simple;
	bh=N5edY6UhoTVg/tv2RPnMUCdUcddT79O4AMJWRMmP6w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSWWVim40VVv40HEUXLBqjCySUtEwxUc/tR0p07//9FjDo1sjY30fEX26Jvyj+H5evIia0JOM+jV90tKrMd+NvtV6ho/lTahDCMT0u6QCYfEMsP3A4lhz4yHiWs5+Pr9KSKUR483jmC/9JPGXnNYumF4eystUoc70sCZR6k5qcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=F0JNitK8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70666aceb5bso1134986b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1719195345; x=1719800145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7pIRzhb6R+ZpWhizkJ4QSMsLwuggk2yq9lspseByNQ=;
        b=F0JNitK8qf1FGNF19wMUE0lVSelZa2YimnLwZgzpK+zOOBXGE52J8Sn1ozPRkgGObe
         e9QLGQvcfza89cwZeVWpdTcu/3+CN0nMf7Z6pahjnWEt7izq7xxuZCjP2q5xHcOsOYfa
         spXsMPi30Zw5WOFbZ5DasHHRemgp2pDuXAHWKy/JpLL1kvpKmOeKMzbVI3ISglir+kNr
         4RgR/SShKLiMTUwX5ZkMIJ3jSg6las5t7HQikHAzPieXGg5hEkJOfdazQvp25pyYpLe/
         hrindFwAtYhEzVjiOa53LZfe9hE881f8tDtv0nXN66+c+FzxGbg73L+JQn/+WDE/Gwp4
         45xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719195345; x=1719800145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7pIRzhb6R+ZpWhizkJ4QSMsLwuggk2yq9lspseByNQ=;
        b=DsVfDK/3Cg942/LmsZddBxtp/MeswnxDJj3ZqN1Jrkwxfi8BUEVRlnHh3RlLKvyZpg
         VwQtCtSoPf2D7d9gv+5SM7jC/4SynChJGNHcGb2c2/GHFMPVgFLXNn4nnkKIZXSXEC7A
         0NoUVIqGhdT6eJz/PIhtJXtVl+Jq8CdG5SLvpgVwvvYfPSX3jhDEt4Y994HZSTAFtEVV
         FpYNDgIBQwguROAJn8nJ/tO2f3I/BBO/MNz+QFLob7Kstvm7THa016HBjiY8fmOM5qyk
         znzBqWAmZdu711p2neBd2266KDyq6xWRJAL9VpHEkIV3MaLEYIl8ruxDt17Z/LwNLu/b
         w9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXlzk+SttrPYdd4IcDbLhen6r9Y0waLFNZ6dEr3PcVOp1Uup3IPg0DSsTbFuEjkC1wvp/N+xFMZO6xyC83Y90stdP2ZyPfnw8ZrY2m+
X-Gm-Message-State: AOJu0Yx7ijXO+VkIIA9OFQ467zmMoHB17V8kmJ5UyKIHCv/msPKhOWw4
	4M7o2sg6Yw4FpPxUcY9t1edxDJtXIr276ChotPLWzBsVj8wMOfTHYVE2Mobu2Jg=
X-Google-Smtp-Source: AGHT+IHGnle2l4t/N+t7q35aYf3cvm4IbU1OoYFJDMJfHke3H8gMrd4noC1FwevHfTcb32CBoju6cA==
X-Received: by 2002:aa7:9f45:0:b0:706:384f:3e49 with SMTP id d2e1a72fcca58-70674593815mr3511288b3a.1.1719195345388;
        Sun, 23 Jun 2024 19:15:45 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1584:936e:5eb0:fab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511b137csm5071770b3a.86.2024.06.23.19.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 19:15:45 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 23 Jun 2024 19:12:31 -0700
Subject: [PATCH v2 1/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
In-Reply-To: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
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
 Drew Fustini <dfustini@tenstorrent.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719195343; l=5553;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=N5edY6UhoTVg/tv2RPnMUCdUcddT79O4AMJWRMmP6w4=;
 b=K5JM6awYX+m3HA/VKe8t3EXTys9lTO5SMbn8NZDPKyNOxOr5TJorhjl2A/xe1d9ez4s77yLot
 758n+ENvO61AfgRRtXF1o7wuAk/GO5WdAlXi2JbCbF4Cg53ceetVzDD
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Document bindings for the T-Head TH1520 AP sub-system clock controller.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml        | 53 ++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/clock/thead,th1520-clk-ap.h    | 96 ++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
new file mode 100644
index 000000000000..0129bd0ba4b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -0,0 +1,53 @@
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
+    clock-controller@ef010000 {
+        compatible = "thead,th1520-clk-ap";
+        reg = <0xef010000 0x1000>;
+        clocks = <&osc>;
+        #clock-cells = <1>;
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
2.34.1


