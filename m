Return-Path: <linux-kernel+bounces-548787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E91A5495F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DD91896786
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F220DD7F;
	Thu,  6 Mar 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gyib3Ebt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94B20CCC8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260644; cv=none; b=to/F6e5p0y6P5L6YZgTZC7MuORU9pJ1/LxDeJyHtinDspH+wHYTIzMzGTAstu1GzknmtOIw8bZbN7d5N0Rew+lpSmAhAaPkT6K9/nZdqCcmGVEaTOnEGIxWc75VfD6gM1XMEhrq1g9pAWN64wz9aqkPkBkV5NXCSUpN3PVGUdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260644; c=relaxed/simple;
	bh=yzCgb+8exvG1QLnKJjYoUr8BJCg4DBti7sbXPOVT/90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyBrRL6gW4mnjQt9NzKmv/Q4c2R6f1SNtinGj48CS3NUHg8hHCbS3I8Pi/81jtP0VywrRVf7oPZLNEw6x8GVksUZhKGoM8ttneWAhmZNze0RZGAiVWONQsMpgsDcB4tJN5OToB5K9RWVnZPzr6nHP6pWxsZoejb8hKkNXI2f5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Gyib3Ebt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390fb1b987fso617705f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260640; x=1741865440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBVFA3tzS1bXJbCiJCU1B6IsR8mJkZI1gbjF/bIgONM=;
        b=Gyib3EbttYA5TjcFg/y33FVUM9iUm8bl7XoQRt9t25C9oSJe+g1yL94yciRbbmTwp4
         MaJWAyTxvx9Ie43CBrkeCA0TLtjHLila9gWd/xIKqKhXlB0cujA6WMCC91J1ZkGolKaL
         mzOqsdQ0SAjPXNBqwVRZfBEnvYrlT17j0sONQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260640; x=1741865440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBVFA3tzS1bXJbCiJCU1B6IsR8mJkZI1gbjF/bIgONM=;
        b=wnoLUCoDLmGBj2Ojp0y/F9unEvSAjBPkE2YgOnW0KjsQRyeqa311wBuuibu/rn08w8
         v/eiq2QdfPKtFsSMIPlUBpjCzJIcBIoyuVxz7Ydyw0WRcgMtTN8BUmcUW6HiD16o23TN
         aoJ66VVQtGL8vkfy0SAPSC44kUjU+9d3n8kCzbR+Nv0sQ4PplEM9bY9K4FDk5h9HeZr6
         Jyx/vXXxE8ndUu1ULAcYHWMSgmUDkTutdfSyQ0J/5wFPuXTVjANafL9am/sPPLR7RGKS
         M+CYuiD8rGeMTsQdWmtPSngKEIn88LcMESIWEAz9VvKAP97GxAKS4FTwI5HSHKIkTtGv
         sKRw==
X-Gm-Message-State: AOJu0YwwLr1ZynAqqYeGPRfXfgqybFDKgIvp/UtlCq+2kAzJfPpaDP9F
	L7suS8iuvbKWvKb5m4xDqZkxM/Y8BXVxbW2/aid2UabPHT9kxR2b8teQQlxAO9pXQue5RJFbnKG
	7
X-Gm-Gg: ASbGnct+4+JrXU/dQHnmGnzsOWNQCm4Cucw95+8nxy7nXBo4dIo+KFUFapcfH6/Cnuu
	STSZNJLb5O1NShPFgSHeYo+UC4gVxcxN+GQWNlZFN2zGKMBKhw9ZRK7XMsjKMdBKc+/hR6rfRpc
	N01pbU1zqC+Ssga2LxisdknpXgRzctKziCn6yuXyCJH5QhofKUwvdQ2228L78hguiE0mwsNWh3K
	kZ3Z6/E95Y3TfYIU924h5OLJ4FwArE0ux30hFIbFg1XIhlOjDv20Gm7WI9jhEYEr9ebxClAnVWP
	B5mUjJFvJFUlMIMjqkRdP7rZ33NYxuCsNq3knYOEvRPtTe9axU7hKV9y+resL4twHDr8CaagF44
	QYmOVIw==
X-Google-Smtp-Source: AGHT+IGpVVsT76W+1EcoiCEPQXg73CwNgr9po2kaTD1wnO/xk1vNXcG4V1f0Zq+F62QVV8rMq6KZyw==
X-Received: by 2002:a05:6000:1886:b0:390:e8bf:55a8 with SMTP id ffacd0b85a97d-3911f7412f1mr5706345f8f.18.1741260639893;
        Thu, 06 Mar 2025 03:30:39 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:39 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v10 05/18] dt-bindings: clock: imx8m-anatop: add oscillators and PLLs
Date: Thu,  6 Mar 2025 12:27:54 +0100
Message-ID: <20250306112959.242131-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Though adding clocks and clock-names properties will break the ABI,
it is required to accurately describe the hardware. Indeed, the anatop
module uses the input oscillators to generate various PLLs. In turn,
the Clock Control Module (CCM) receives clocks from the PLLs and
oscillators and generates clocks for on-chip peripherals.

Furthermore, as agreed in [1], this change represents the first step
toward the implementation of the anatop driver. Currently, in fact,
there is no dedicated anatop driver, but the CCM driver parses the
anatop node and registers the PLLs it produces.

[1] https://lore.kernel.org/imx/20241106090549.3684963-1-dario.binacchi@amarulasolutions.com/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v7)

Changes in v7:
- Add 'Reviewed-by' tag of Krzysztof Kozlowski

Changes in v6:
- Improve commit message
- Merge it with patch 10, 11, and 12:
  - 10/20 dt-bindings: clock: imx8mm: add binding definitions for anatop
  - 11/20 dt-bindings: clock: imx8mn: add binding definitions for anatop
  - 12/20 dt-bindings: clock: imx8mp: add binding definitions for anatop

Changes in v4:
- New

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 53 ++++++++++++++-
 include/dt-bindings/clock/imx8mm-clock.h      | 64 +++++++++++++++++
 include/dt-bindings/clock/imx8mn-clock.h      | 64 +++++++++++++++++
 include/dt-bindings/clock/imx8mp-clock.h      | 68 +++++++++++++++++++
 4 files changed, 248 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
index bbd22e95b319..f439b0a94ce2 100644
--- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -30,22 +30,73 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
   '#clock-cells':
     const: 1
 
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - '#clock-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-anatop
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 32k osc
+            - description: 25m osc
+            - description: 27m osc
+        clock-names:
+          items:
+            - const: ckil
+            - const: osc_25m
+            - const: osc_27m
+    else:
+      properties:
+        clocks:
+          items:
+            - description: 32k osc
+            - description: 24m osc
+
+        clock-names:
+          items:
+            - const: osc_32k
+            - const: osc_24m
+
 additionalProperties: false
 
 examples:
   - |
-    anatop: clock-controller@30360000 {
+    clock-controller@30360000 {
         compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
         reg = <0x30360000 0x10000>;
         #clock-cells = <1>;
+        clocks = <&osc_32k>, <&osc_24m>;
+        clock-names = "osc_32k", "osc_24m";
+    };
+
+  - |
+    clock-controller@30360000 {
+        compatible = "fsl,imx8mq-anatop";
+        reg = <0x30360000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&ckil>, <&osc_25m>, <&osc_27m>;
+        clock-names = "ckil", "osc_25m", "osc_27m";
     };
 
 ...
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
index 102d8a6cdb55..017c06e48430 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -287,4 +287,68 @@
 
 #define IMX8MM_CLK_END				258
 
+#define IMX8MM_ANATOP_CLK_DUMMY			0
+#define IMX8MM_ANATOP_CLK_32K			1
+#define IMX8MM_ANATOP_CLK_24M			2
+#define IMX8MM_ANATOP_AUDIO_PLL1_REF_SEL	3
+#define IMX8MM_ANATOP_AUDIO_PLL2_REF_SEL	4
+#define IMX8MM_ANATOP_VIDEO_PLL_REF_SEL		5
+#define IMX8MM_ANATOP_DRAM_PLL_REF_SEL		6
+#define IMX8MM_ANATOP_GPU_PLL_REF_SEL		7
+#define IMX8MM_ANATOP_VPU_PLL_REF_SEL		8
+#define IMX8MM_ANATOP_ARM_PLL_REF_SEL		9
+#define IMX8MM_ANATOP_SYS_PLL3_REF_SEL		10
+#define IMX8MM_ANATOP_AUDIO_PLL1		11
+#define IMX8MM_ANATOP_AUDIO_PLL2		12
+#define IMX8MM_ANATOP_VIDEO_PLL			13
+#define IMX8MM_ANATOP_DRAM_PLL			14
+#define IMX8MM_ANATOP_GPU_PLL			15
+#define IMX8MM_ANATOP_VPU_PLL			16
+#define IMX8MM_ANATOP_ARM_PLL			17
+#define IMX8MM_ANATOP_SYS_PLL1			18
+#define IMX8MM_ANATOP_SYS_PLL2			19
+#define IMX8MM_ANATOP_SYS_PLL3			20
+#define IMX8MM_ANATOP_AUDIO_PLL1_BYPASS		21
+#define IMX8MM_ANATOP_AUDIO_PLL2_BYPASS		22
+#define IMX8MM_ANATOP_VIDEO_PLL_BYPASS		23
+#define IMX8MM_ANATOP_DRAM_PLL_BYPASS		24
+#define IMX8MM_ANATOP_GPU_PLL_BYPASS		25
+#define IMX8MM_ANATOP_VPU_PLL_BYPASS		26
+#define IMX8MM_ANATOP_ARM_PLL_BYPASS		27
+#define IMX8MM_ANATOP_SYS_PLL3_BYPASS		28
+#define IMX8MM_ANATOP_AUDIO_PLL1_OUT		29
+#define IMX8MM_ANATOP_AUDIO_PLL2_OUT		30
+#define IMX8MM_ANATOP_VIDEO_PLL_OUT		31
+#define IMX8MM_ANATOP_DRAM_PLL_OUT		32
+#define IMX8MM_ANATOP_GPU_PLL_OUT		33
+#define IMX8MM_ANATOP_VPU_PLL_OUT		34
+#define IMX8MM_ANATOP_ARM_PLL_OUT		35
+#define IMX8MM_ANATOP_SYS_PLL3_OUT		36
+#define IMX8MM_ANATOP_SYS_PLL1_OUT		37
+#define IMX8MM_ANATOP_SYS_PLL1_40M		38
+#define IMX8MM_ANATOP_SYS_PLL1_80M		39
+#define IMX8MM_ANATOP_SYS_PLL1_100M		40
+#define IMX8MM_ANATOP_SYS_PLL1_133M		41
+#define IMX8MM_ANATOP_SYS_PLL1_160M		42
+#define IMX8MM_ANATOP_SYS_PLL1_200M		43
+#define IMX8MM_ANATOP_SYS_PLL1_266M		44
+#define IMX8MM_ANATOP_SYS_PLL1_400M		45
+#define IMX8MM_ANATOP_SYS_PLL1_800M		46
+#define IMX8MM_ANATOP_SYS_PLL2_OUT		47
+#define IMX8MM_ANATOP_SYS_PLL2_50M		48
+#define IMX8MM_ANATOP_SYS_PLL2_100M		49
+#define IMX8MM_ANATOP_SYS_PLL2_125M		50
+#define IMX8MM_ANATOP_SYS_PLL2_166M		51
+#define IMX8MM_ANATOP_SYS_PLL2_200M		52
+#define IMX8MM_ANATOP_SYS_PLL2_250M		53
+#define IMX8MM_ANATOP_SYS_PLL2_333M		54
+#define IMX8MM_ANATOP_SYS_PLL2_500M		55
+#define IMX8MM_ANATOP_SYS_PLL2_1000M		56
+#define IMX8MM_ANATOP_CLK_CLKOUT1_SEL		57
+#define IMX8MM_ANATOP_CLK_CLKOUT1_DIV		58
+#define IMX8MM_ANATOP_CLK_CLKOUT1		59
+#define IMX8MM_ANATOP_CLK_CLKOUT2_SEL		60
+#define IMX8MM_ANATOP_CLK_CLKOUT2_DIV		61
+#define IMX8MM_ANATOP_CLK_CLKOUT2		62
+
 #endif
diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
index 04809edab33c..b2fa73803d45 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -267,4 +267,68 @@
 
 #define IMX8MN_CLK_END				235
 
+#define IMX8MN_ANATOP_CLK_DUMMY			0
+#define IMX8MN_ANATOP_CLK_32K			1
+#define IMX8MN_ANATOP_CLK_24M			2
+#define IMX8MN_ANATOP_AUDIO_PLL1_REF_SEL	3
+#define IMX8MN_ANATOP_AUDIO_PLL2_REF_SEL	4
+#define IMX8MN_ANATOP_VIDEO_PLL_REF_SEL		5
+#define IMX8MN_ANATOP_DRAM_PLL_REF_SEL		6
+#define IMX8MN_ANATOP_GPU_PLL_REF_SEL		7
+#define IMX8MN_ANATOP_M7_ALT_PLL_REF_SEL	8
+#define IMX8MN_ANATOP_ARM_PLL_REF_SEL		9
+#define IMX8MN_ANATOP_SYS_PLL3_REF_SEL		10
+#define IMX8MN_ANATOP_AUDIO_PLL1		11
+#define IMX8MN_ANATOP_AUDIO_PLL2		12
+#define IMX8MN_ANATOP_VIDEO_PLL			13
+#define IMX8MN_ANATOP_DRAM_PLL			14
+#define IMX8MN_ANATOP_GPU_PLL			15
+#define IMX8MN_ANATOP_M7_ALT_PLL		16
+#define IMX8MN_ANATOP_ARM_PLL			17
+#define IMX8MN_ANATOP_SYS_PLL1			18
+#define IMX8MN_ANATOP_SYS_PLL2			19
+#define IMX8MN_ANATOP_SYS_PLL3			20
+#define IMX8MN_ANATOP_AUDIO_PLL1_BYPASS		21
+#define IMX8MN_ANATOP_AUDIO_PLL2_BYPASS		22
+#define IMX8MN_ANATOP_VIDEO_PLL_BYPASS		23
+#define IMX8MN_ANATOP_DRAM_PLL_BYPASS		24
+#define IMX8MN_ANATOP_GPU_PLL_BYPASS		25
+#define IMX8MN_ANATOP_M7_ALT_PLL_BYPASS		26
+#define IMX8MN_ANATOP_ARM_PLL_BYPASS		27
+#define IMX8MN_ANATOP_SYS_PLL3_BYPASS		28
+#define IMX8MN_ANATOP_AUDIO_PLL1_OUT		29
+#define IMX8MN_ANATOP_AUDIO_PLL2_OUT		30
+#define IMX8MN_ANATOP_VIDEO_PLL_OUT		31
+#define IMX8MN_ANATOP_DRAM_PLL_OUT		32
+#define IMX8MN_ANATOP_GPU_PLL_OUT		33
+#define IMX8MN_ANATOP_M7_ALT_PLL_OUT		34
+#define IMX8MN_ANATOP_ARM_PLL_OUT		35
+#define IMX8MN_ANATOP_SYS_PLL3_OUT		36
+#define IMX8MN_ANATOP_SYS_PLL1_OUT		37
+#define IMX8MN_ANATOP_SYS_PLL1_40M		38
+#define IMX8MN_ANATOP_SYS_PLL1_80M		39
+#define IMX8MN_ANATOP_SYS_PLL1_100M		40
+#define IMX8MN_ANATOP_SYS_PLL1_133M		41
+#define IMX8MN_ANATOP_SYS_PLL1_160M		42
+#define IMX8MN_ANATOP_SYS_PLL1_200M		43
+#define IMX8MN_ANATOP_SYS_PLL1_266M		44
+#define IMX8MN_ANATOP_SYS_PLL1_400M		45
+#define IMX8MN_ANATOP_SYS_PLL1_800M		46
+#define IMX8MN_ANATOP_SYS_PLL2_OUT		47
+#define IMX8MN_ANATOP_SYS_PLL2_50M		48
+#define IMX8MN_ANATOP_SYS_PLL2_100M		49
+#define IMX8MN_ANATOP_SYS_PLL2_125M		50
+#define IMX8MN_ANATOP_SYS_PLL2_166M		51
+#define IMX8MN_ANATOP_SYS_PLL2_200M		52
+#define IMX8MN_ANATOP_SYS_PLL2_250M		53
+#define IMX8MN_ANATOP_SYS_PLL2_333M		54
+#define IMX8MN_ANATOP_SYS_PLL2_500M		55
+#define IMX8MN_ANATOP_SYS_PLL2_1000M		56
+#define IMX8MN_ANATOP_CLK_CLKOUT1_SEL		57
+#define IMX8MN_ANATOP_CLK_CLKOUT1_DIV		58
+#define IMX8MN_ANATOP_CLK_CLKOUT1		59
+#define IMX8MN_ANATOP_CLK_CLKOUT2_SEL		60
+#define IMX8MN_ANATOP_CLK_CLKOUT2_DIV		61
+#define IMX8MN_ANATOP_CLK_CLKOUT2		62
+
 #endif
diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 3235d7de3b62..8c076225fd9e 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -402,4 +402,72 @@
 
 #define IMX8MP_CLK_AUDIOMIX_END			59
 
+#define IMX8MP_ANATOP_CLK_DUMMY			0
+#define IMX8MP_ANATOP_CLK_24M			1
+#define IMX8MP_ANATOP_CLK_32K			2
+#define IMX8MP_ANATOP_AUDIO_PLL1_REF_SEL	3
+#define IMX8MP_ANATOP_AUDIO_PLL2_REF_SEL	4
+#define IMX8MP_ANATOP_VIDEO_PLL_REF_SEL		5
+#define IMX8MP_ANATOP_DRAM_PLL_REF_SEL		6
+#define IMX8MP_ANATOP_GPU_PLL_REF_SEL		7
+#define IMX8MP_ANATOP_VPU_PLL_REF_SEL		8
+#define IMX8MP_ANATOP_ARM_PLL_REF_SEL		9
+#define IMX8MP_ANATOP_SYS_PLL1_REF_SEL		10
+#define IMX8MP_ANATOP_SYS_PLL2_REF_SEL		11
+#define IMX8MP_ANATOP_SYS_PLL3_REF_SEL		12
+#define IMX8MP_ANATOP_AUDIO_PLL1		13
+#define IMX8MP_ANATOP_AUDIO_PLL2		14
+#define IMX8MP_ANATOP_VIDEO_PLL			15
+#define IMX8MP_ANATOP_DRAM_PLL			16
+#define IMX8MP_ANATOP_GPU_PLL			17
+#define IMX8MP_ANATOP_VPU_PLL			18
+#define IMX8MP_ANATOP_ARM_PLL			19
+#define IMX8MP_ANATOP_SYS_PLL1			20
+#define IMX8MP_ANATOP_SYS_PLL2			21
+#define IMX8MP_ANATOP_SYS_PLL3			22
+#define IMX8MP_ANATOP_AUDIO_PLL1_BYPASS		23
+#define IMX8MP_ANATOP_AUDIO_PLL2_BYPASS		24
+#define IMX8MP_ANATOP_VIDEO_PLL_BYPASS		25
+#define IMX8MP_ANATOP_DRAM_PLL_BYPASS		26
+#define IMX8MP_ANATOP_GPU_PLL_BYPASS		27
+#define IMX8MP_ANATOP_VPU_PLL_BYPASS		28
+#define IMX8MP_ANATOP_ARM_PLL_BYPASS		29
+#define IMX8MP_ANATOP_SYS_PLL1_BYPASS		30
+#define IMX8MP_ANATOP_SYS_PLL2_BYPASS		31
+#define IMX8MP_ANATOP_SYS_PLL3_BYPASS		32
+#define IMX8MP_ANATOP_AUDIO_PLL1_OUT		33
+#define IMX8MP_ANATOP_AUDIO_PLL2_OUT		34
+#define IMX8MP_ANATOP_VIDEO_PLL_OUT		35
+#define IMX8MP_ANATOP_DRAM_PLL_OUT		36
+#define IMX8MP_ANATOP_GPU_PLL_OUT		37
+#define IMX8MP_ANATOP_VPU_PLL_OUT		38
+#define IMX8MP_ANATOP_ARM_PLL_OUT		39
+#define IMX8MP_ANATOP_SYS_PLL3_OUT		40
+#define IMX8MP_ANATOP_SYS_PLL1_OUT		41
+#define IMX8MP_ANATOP_SYS_PLL1_40M		42
+#define IMX8MP_ANATOP_SYS_PLL1_80M		43
+#define IMX8MP_ANATOP_SYS_PLL1_100M		44
+#define IMX8MP_ANATOP_SYS_PLL1_133M		45
+#define IMX8MP_ANATOP_SYS_PLL1_160M		46
+#define IMX8MP_ANATOP_SYS_PLL1_200M		47
+#define IMX8MP_ANATOP_SYS_PLL1_266M		48
+#define IMX8MP_ANATOP_SYS_PLL1_400M		49
+#define IMX8MP_ANATOP_SYS_PLL1_800M		50
+#define IMX8MP_ANATOP_SYS_PLL2_OUT		51
+#define IMX8MP_ANATOP_SYS_PLL2_50M		52
+#define IMX8MP_ANATOP_SYS_PLL2_100M		53
+#define IMX8MP_ANATOP_SYS_PLL2_125M		54
+#define IMX8MP_ANATOP_SYS_PLL2_166M		55
+#define IMX8MP_ANATOP_SYS_PLL2_200M		56
+#define IMX8MP_ANATOP_SYS_PLL2_250M		57
+#define IMX8MP_ANATOP_SYS_PLL2_333M		58
+#define IMX8MP_ANATOP_SYS_PLL2_500M		59
+#define IMX8MP_ANATOP_SYS_PLL2_1000M		60
+#define IMX8MP_ANATOP_CLK_CLKOUT1_SEL		61
+#define IMX8MP_ANATOP_CLK_CLKOUT1_DIV		62
+#define IMX8MP_ANATOP_CLK_CLKOUT1		63
+#define IMX8MP_ANATOP_CLK_CLKOUT2_SEL		64
+#define IMX8MP_ANATOP_CLK_CLKOUT2_DIV		65
+#define IMX8MP_ANATOP_CLK_CLKOUT2		66
+
 #endif
-- 
2.43.0


