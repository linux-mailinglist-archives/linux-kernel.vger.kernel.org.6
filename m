Return-Path: <linux-kernel+bounces-541924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6393A4C377
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4D616C654
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CF213E8B;
	Mon,  3 Mar 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="luOrMImI"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541B211A1E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012599; cv=none; b=iTlOJFT3+Im0v0l+k+CNGFCH21+vhkido2v7L/0s7hMvakkI8+lypNRIN9UuLk82cs5l0+iwBEn0YotfHLDQJGRLa3P50KWwMowDFycNp29NLiLqUVayZIkEgLWtD+s/PZY1aNefPGCKN4N8FdeC+wVXeXqi8wKExZeHBqz8MKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012599; c=relaxed/simple;
	bh=uZj7UpxrErums0MvNmMX0ugyJz+aQK8+Zc/XSskkF+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=hnEgKl5+QCFt2NfRvz+bHuPGrSwMW/r+IrKmeac+4dXd7QgEG9jniNF0SHAQFakyFOlhmLwHQeS96dW0VS6s11C9HM6k5/Pe8Qc96WmTRJkbaah0sgK27rPX8dSzRcT2PwSxOor8dJuT3E/j2THN/CbyuQcEP+ksEJMldCSgxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=luOrMImI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250303143636euoutp011409d5941ce8ac1b63221669dc7c6b36~pUbtZv1Oi0981709817euoutp01_
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250303143636euoutp011409d5941ce8ac1b63221669dc7c6b36~pUbtZv1Oi0981709817euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741012596;
	bh=FQj8R4vXlWuDHUDhzpkp2tDoipHrvOLRL6Hj2/KxtKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luOrMImIhIGyOuPADVQxovpzItPWAEuPUmQbRrP6vFLq+vSPgLytgVV+mn+iDknLq
	 7f20Mb5T6PJZ7J1M/GuWgZkTi/YBU2XLy/MzOJ8uxM/MIXL7a2wWeTGAlHZdnu7bZA
	 FFZ1/AMPlXOmusOyCC15INk8FuTbkwzuVUDsEKvc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303143635eucas1p2afc8d0e3bb655deae193d5d636bb5ef2~pUbs-AULg2682126821eucas1p2u;
	Mon,  3 Mar 2025 14:36:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0C.8D.20409.37EB5C76; Mon,  3
	Mar 2025 14:36:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf~pUbsiDB5v0504205042eucas1p1I;
	Mon,  3 Mar 2025 14:36:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250303143635eusmtrp2e1abc780f3982bbe24c4887ec03d920c~pUbshPPtu1887518875eusmtrp2o;
	Mon,  3 Mar 2025 14:36:35 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-9f-67c5be738c5d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.B0.19920.27EB5C76; Mon,  3
	Mar 2025 14:36:34 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303143634eusmtip26cc4ad15e7f62616c4f3ed35c439d379~pUbrjH7532028620286eusmtip2U;
	Mon,  3 Mar 2025 14:36:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 1/4] dt-bindings: clock: thead: Add TH1520 VO clock
 controller
Date: Mon,  3 Mar 2025 15:36:26 +0100
Message-Id: <20250303143629.400583-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303143629.400583-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7djPc7rF+46mGyxZKW/x7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	sf7rfCaLi6dcLe7eO8Fi8fJyD7NF2yx+i/97drBb/Lu2kcWiZf8UFgcRj/c3Wtk93rx8yeJx
	uOMLu8e9E9NYPTat6mTz2Lyk3qNl7TEmj/6/Bh7v911l8+jbsorR41LzdXaPz5vkAniiuGxS
	UnMyy1KL9O0SuDJ2dnxlKliqUtG1bgFbA+M3mS5GTg4JAROJ1SdnM3YxcnEICaxglNhz+Qor
	hPOFUeLy6fXsEM5nRon7v26ywLRM+jcLzBYSWM4o8fSpD0TRG0aJ6R/OMoIk2ASMJB4snw82
	SkRgD5PE9+8/mUEcZoFVjBJPvn0EmsvBISwQLPGmPQvEZBFQleg9UgzSyytgJ/H39Q5GiGXy
	EvsPnmUGsTkF7CUOXW9ggagRlDg58wmYzQxU07x1Nth4CYFLnBIXD8xlBZkpIeAi8WpZBcQc
	YYlXx7ewQ9gyEv93zmeCsPMlHmz9xAxh10js7DkOZVtL3Dn3iw1kDLOApsT6XfoQYUeJvacn
	MUFM55O48VYQ4gI+iUnbpjNDhHklOtqEIKrVJKb29MItPbdiG9RSD4mpi3YwT2BUnIXkl1lI
	fpmFsHcBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwDR5+t/xLzsYl7/6qHeIkYmD
	8RCjBAezkgjvrfaj6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5F+1vTRcSSE8sSc1OTS1ILYLJ
	MnFwSjUwRTHNEdl/4aKp34PUT1P8jPZeu3H+G5cUn/7vR4c+HIlWO5AvO/mr9MpGCX+HFitG
	rYKysqQPyj6/7x40m9T/rW5CS/D7TVP4rq3Zefldo1Dm5tvLCp/8NeZUC3/Cee6Ho8u/p+yy
	Fvyeq93/7ymM+/FmwuPVUyaz1xVVFFfv/ip+K3nrdRZGbosHm01cxVa9eH1Oqp5Nd03c46vR
	ef6+5Qs/fFs1syS8gmn67MKnH3skPPPUWXIOztma3CuRlj3119uHIcLLFBR2K1fPWeJ0zcAk
	IHR98u1LhzxrK4Tlzyl0PPibs65BpnzapMajn+Ya7N0aWJXXM23OMXWh6Ukr1Nfc3vNx5hLD
	5K+N5torw5RYijMSDbWYi4oTAU3733YCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7pF+46mGzw4ZGPx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	sf7rfCaLi6dcLe7eO8Fi8fJyD7NF2yx+i/97drBb/Lu2kcWiZf8UFgcRj/c3Wtk93rx8yeJx
	uOMLu8e9E9NYPTat6mTz2Lyk3qNl7TEmj/6/Bh7v911l8+jbsorR41LzdXaPz5vkAnii9GyK
	8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ2dnxlKliq
	UtG1bgFbA+M3mS5GTg4JAROJSf9msXQxcnEICSxllLhwfBYbREJG4lr3SxYIW1jiz7UusLiQ
	wCtGid5XwiA2m4CRxIPl81lBmkUELjBJ7Fq3mgnEYRZYxygxZfsOJpAqYYFAiUt9c9i7GDk4
	WARUJXqPFIOEeQXsJP6+3sEIsUBeYv/Bs8wgNqeAvcSh6w0sEMvsJPas3ckOUS8ocXLmE7A4
	M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMKq3Hfu5eQfj
	vFcf9Q4xMnEwHmKU4GBWEuG91X40XYg3JbGyKrUoP76oNCe1+BCjKdDZE5mlRJPzgWklryTe
	0MzA1NDEzNLA1NLMWEmc1+3y+TQhgfTEktTs1NSC1CKYPiYOTqkGJrlJFlVfA7ZK71XpVBRf
	u32rwkfFSZ4mr2ZfeDlB8t8j8+/6v2N8m+pXM+eu2jM1M7wmTX3G5In3U5c/iQu94vXqXNbV
	dcpxp9Jt8iXY/pYdefX2d5iw2oc+tW1fnCs+8grUhyh4KC66NzXCbVp0mVj3mmmPN05dpyF4
	7bMx65o1c1gW2MmLrS8x1D5q7HDdhOs3b2hqcfK/nY0XTi5mzxfvWL/+5uonrBKTrCOyZi9a
	dUBCXaj58dV41qA9rHqGG71v2+f7VV1b9nKX8zfjiKRJbA7xlSvuN58+vKnnsUncHe+dy07c
	feZ9c/vluFMHGXIi3/Xtrel6ExO4U+yx2dbdwtvX1vAGNKjabbqm8UCJpTgj0VCLuag4EQDL
	IBdUcwMAAA==
X-CMS-MailID: 20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
	<CGME20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf@eucas1p1.samsung.com>

Add device tree bindings for the TH1520 Video Output (VO) subsystem
clock controller. The VO sub-system manages clock gates for multimedia
components including HDMI, MIPI, and GPU.

Document the VIDEO_PLL requirements for the VO clock controller, which
receives its input from the AP clock controller. The VIDEO_PLL is a
Silicon Creations Sigma-Delta (integer) PLL typically running at 792 MHz
with maximum FOUTVCO of 2376 MHz.

Add a mandatory reset property for the TH1520 VO clock controller that
handles the GPU clocks. This reset line controls the GPU CLKGEN reset,
which is required for proper GPU clock operation.

The reset property is only required for the "thead,th1520-clk-vo"
compatible, as it specifically handles the GPU-related clocks.

This binding complements the existing AP sub-system clock controller
which manages CPU, DPU, GMAC and TEE PLLs.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/clock/thead,th1520-clk-ap.yaml   | 33 ++++++++++++++++--
 .../dt-bindings/clock/thead,th1520-clk-ap.h   | 34 +++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
index 0129bd0ba4b3..6ea8202718d0 100644
--- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
@@ -8,7 +8,8 @@ title: T-HEAD TH1520 AP sub-system clock controller
 
 description: |
   The T-HEAD TH1520 AP sub-system clock controller configures the
-  CPU, DPU, GMAC and TEE PLLs.
+  CPU, DPU, GMAC and TEE PLLs. Additionally the VO subsystem configures
+  the clock gates for the HDMI, MIPI and the GPU.
 
   SoC reference manual
   https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
@@ -20,14 +21,30 @@ maintainers:
 
 properties:
   compatible:
-    const: thead,th1520-clk-ap
+    enum:
+      - thead,th1520-clk-ap
+      - thead,th1520-clk-vo
 
   reg:
     maxItems: 1
 
   clocks:
     items:
-      - description: main oscillator (24MHz)
+      - description: |
+          One input clock:
+          - For "thead,th1520-clk-ap": the clock input must be the 24 MHz
+            main oscillator.
+          - For "thead,th1520-clk-vo": the clock input must be the VIDEO_PLL,
+            which is configured by the AP clock controller. According to the
+            TH1520 manual, VIDEO_PLL is a Silicon Creations Sigma-Delta PLL
+            (integer PLL) typically running at 792 MHz (FOUTPOSTDIV), with
+            a maximum FOUTVCO of 2376 MHz.
+
+  resets:
+    maxItems: 1
+    description:
+      Required for "thead,th1520-clk-vo". This reset line controls the
+      GPU CLKGEN reset which is required for proper GPU clock operation.
 
   "#clock-cells":
     const: 1
@@ -40,6 +57,16 @@ required:
   - clocks
   - "#clock-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: thead,th1520-clk-vo
+    then:
+      required:
+        - resets
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/clock/thead,th1520-clk-ap.h b/include/dt-bindings/clock/thead,th1520-clk-ap.h
index a199784b3512..09a9aa7b3ab1 100644
--- a/include/dt-bindings/clock/thead,th1520-clk-ap.h
+++ b/include/dt-bindings/clock/thead,th1520-clk-ap.h
@@ -93,4 +93,38 @@
 #define CLK_SRAM3		83
 #define CLK_PLL_GMAC_100M	84
 #define CLK_UART_SCLK		85
+
+/* VO clocks */
+#define CLK_AXI4_VO_ACLK		0
+#define CLK_GPU_MEM			1
+#define CLK_GPU_CORE			2
+#define CLK_GPU_CFG_ACLK		3
+#define CLK_DPU_PIXELCLK0		4
+#define CLK_DPU_PIXELCLK1		5
+#define CLK_DPU_HCLK			6
+#define CLK_DPU_ACLK			7
+#define CLK_DPU_CCLK			8
+#define CLK_HDMI_SFR			9
+#define CLK_HDMI_PCLK			10
+#define CLK_HDMI_CEC			11
+#define CLK_MIPI_DSI0_PCLK		12
+#define CLK_MIPI_DSI1_PCLK		13
+#define CLK_MIPI_DSI0_CFG		14
+#define CLK_MIPI_DSI1_CFG		15
+#define CLK_MIPI_DSI0_REFCLK		16
+#define CLK_MIPI_DSI1_REFCLK		17
+#define CLK_HDMI_I2S			18
+#define CLK_X2H_DPU1_ACLK		19
+#define CLK_X2H_DPU_ACLK		20
+#define CLK_AXI4_VO_PCLK		21
+#define CLK_IOPMP_VOSYS_DPU_PCLK	22
+#define CLK_IOPMP_VOSYS_DPU1_PCLK	23
+#define CLK_IOPMP_VOSYS_GPU_PCLK	24
+#define CLK_IOPMP_DPU1_ACLK		25
+#define CLK_IOPMP_DPU_ACLK		26
+#define CLK_IOPMP_GPU_ACLK		27
+#define CLK_MIPIDSI0_PIXCLK		28
+#define CLK_MIPIDSI1_PIXCLK		29
+#define CLK_HDMI_PIXCLK			30
+
 #endif
-- 
2.34.1


