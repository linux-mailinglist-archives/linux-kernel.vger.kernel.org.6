Return-Path: <linux-kernel+bounces-541926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6CBA4C380
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D5B1893925
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663542144C5;
	Mon,  3 Mar 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WiZ2owxQ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7B214202
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012602; cv=none; b=sUuEeV2MOPtBQ633vtg6foFwaFLGRjbkx+ZoTqXQY3yU6/WwokI9ps5L6evVEWAEvqZ5cN/xLfkLwcnq+mtiAtwBlyvkH6yH4frqFsB+CMU2CgYV0V0GxWYkEwbH+zcIj/c/S/zOhxbh5Gaoh/BJD7AEgaYY/jtfszpPvWK9B9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012602; c=relaxed/simple;
	bh=IWGXuffalkQUnXAiLADUGfTCXoWyGC8Nua9zNIZpmIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=oCixqmDcsN86mrDW0OVuGHqVKMSAU3uXmKwCX70TPAYoUFatn5ZwVnUhV3Pn8app6D3HGxOnvZYy7b1ZZvDQPdvgYgHqFdPrMKLbvyJwZM2vUL3TPRSEkF60KIpNtTL54lXTl/Eptt/I/G6As5u1Pp4+0Ul+noDmcn33ckZwM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WiZ2owxQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250303143638euoutp0128cc6200215eac245627f937604d3910~pUbvQ-zJw0989509895euoutp013
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250303143638euoutp0128cc6200215eac245627f937604d3910~pUbvQ-zJw0989509895euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741012598;
	bh=VhIBCc+eKDxBLZw1Fq8aGXRrjbktqWvu0yroBIpoWCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WiZ2owxQSA1rsQhpbgxgXwFZeL1lEumlj5VzzG2Fdpzy5GA0WRTDMjG5RldlDTrK9
	 EqnT1qka/LXvfOsoezCITrOC6R82s6Gr4OMC/+Yx2D+1OrIp862J0S1qhH6iB53d5W
	 cq3ZmBSne72b+2aheVj2IpfKCPgaQqbBJHJsXyZE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303143637eucas1p21703598f0358ec92ef55e2789b87bc78~pUbu2tg0n2665426654eucas1p23;
	Mon,  3 Mar 2025 14:36:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 1F.8D.20409.57EB5C76; Mon,  3
	Mar 2025 14:36:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303143636eucas1p1c3ca1df44b86efff959c1d5ec016c8ae~pUbuOxDju1621416214eucas1p19;
	Mon,  3 Mar 2025 14:36:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303143636eusmtrp140dd095e5b9115ee1e760911e56b4c0a~pUbuOFROt0893008930eusmtrp1c;
	Mon,  3 Mar 2025 14:36:36 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-a7-67c5be75bd0c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.89.19654.47EB5C76; Mon,  3
	Mar 2025 14:36:36 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303143635eusmtip2111d49015de186ff013ab1487cc7515c~pUbtRgu4p2137621376eusmtip2U;
	Mon,  3 Mar 2025 14:36:35 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 3/4] clk: thead: Add support for custom ops in
 CCU_GATE_CLK_OPS macro
Date: Mon,  3 Mar 2025 15:36:28 +0100
Message-Id: <20250303143629.400583-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303143629.400583-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7djPc7ql+46mG/ycJGvx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	sf7rfCaLi6dcLe7eO8Fi8fJyD7NF2yx+i/97drBb/Lu2kcWiZf8UFgcRj/c3Wtk93rx8yeJx
	uOMLu8e9E9NYPTat6mTz2Lyk3qNl7TEmj/6/Bh7v911l8+jbsorR41LzdXaPz5vkAniiuGxS
	UnMyy1KL9O0SuDIOnlnNXLBCtGLZtUUsDYzrBbsYOTkkBEwkHr1fzNbFyMUhJLCCUaL9ajuU
	84VR4kVTBxNIlZDAZ0aJlS+TYDruPf3FAlG0nFFi77M5TBDOG0aJGYfvgnWwCRhJPFg+nxUk
	ISKwh0ni+/efzCAOs8AqRokn3z6yg1QJC0RJvP9/HcxmEVCVWLTvDFg3r4CdxLLGt4wQ++Ql
	9h88ywxicwrYSxy63sACUSMocXLmEzCbGaimeetssAUSAuc4JU4s+MEG0ewicXnjbSYIW1ji
	1fEt7BC2jMTpyT0sEHa+xIOtn5gh7BqJnT3HoWxriTvnfgHN4QBaoCmxfpc+RNhRomnJaVaQ
	sIQAn8SNt4IQJ/BJTNo2nRkizCvR0SYEUa0mMbWnF27puRXbmCBKPCR2dupMYFScheSXWUh+
	mYWwdgEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzAVHn63/EvOxiXv/qod4iRiYPx
	EKMEB7OSCO+t9qPpQrwpiZVVqUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgtgsky
	cXBKNTDN3cM960P0FskZaWrVjjFbfhy5f+KW4d4Ji8qWZu13r6lJ/xUotOhm9d1Fa/YLbUns
	7AmIMr23kLU59mYEh+ni15uf6dQ/1Zv3/ufvlZvuGy/dEXOXN+HnMull366uNVsam2Btse/S
	z9CMHc8n/wptVnfZqaMUc/ZOzLLVJac5L2xTkVqwKsopp/ZDx2Kf4w/OffF2+OjFP0Hl9dkZ
	05s3r+OY8157/85PTZXrhQ6XGF+4tuuW368VdkFH92SVMVkvWHy0rO6b+1nPLUfLFOzvN69T
	ZlLMsKi7qNO447TtOftn7VvEH982MmJ/NsVde5PVfbED98RUuj79ZNG0Lb/w9MYibj2JvIfS
	p5/lLg5KPqXEUpyRaKjFXFScCACvHrjQBAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7ol+46mGxxbY2Lx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	sf7rfCaLi6dcLe7eO8Fi8fJyD7NF2yx+i/97drBb/Lu2kcWiZf8UFgcRj/c3Wtk93rx8yeJx
	uOMLu8e9E9NYPTat6mTz2Lyk3qNl7TEmj/6/Bh7v911l8+jbsorR41LzdXaPz5vkAnii9GyK
	8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIOnlnNXLBC
	tGLZtUUsDYzrBbsYOTkkBEwk7j39xdLFyMUhJLCUUeLEipNMEAkZiWvdL1kgbGGJP9e62CCK
	XjFKdC5YwAiSYBMwkniwfD4rSEJE4AKTxK51q5lAHGaBdYwSU7bvABslLBAh0Xf8EDOIzSKg
	KrFo3xmwOK+AncSyxreMECvkJfYfPAtWwylgL3HoegPYaiGgmj1rd7JD1AtKnJz5BCzODFTf
	vHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjOxtx35u2cG48tVH
	vUOMTByMhxglOJiVRHhvtR9NF+JNSaysSi3Kjy8qzUktPsRoCnT3RGYp0eR8YGrJK4k3NDMw
	NTQxszQwtTQzVhLnZbtyPk1IID2xJDU7NbUgtQimj4mDU6qBaeoOhpUbK+88vV/OuUBAcN/f
	BI9j+xoPC0uEx3vqWZ3nyirumjDt6co2NvbtZUeXZcd3G1t8Dm/da7d0N2+CT6nky0d71y/4
	HS0pUHn++b3F7tm7HntfXiy99Ma/BI0/L86eCEk+e+vCsa3bojdfsjyZFxOSMXOTyXupIywh
	Bx9IF/9cum/OzL8bIid/7N0SfPtCqOaZqAqj2MmPPvyU1Du2JdngWOCn/y951UO/BBnecmnm
	b736TevA1blGsx99UPLS8pn6bcGsg9PCTH/leMwJ2mc36fHLSex5Umd5Nn0Qi2MrvXe4xnvR
	ycY5E1c9F+KK3ir6KrW712dt2u23t7XbEszjZ0yJbRA99beLLYFbiaU4I9FQi7moOBEAbWgs
	dnUDAAA=
X-CMS-MailID: 20250303143636eucas1p1c3ca1df44b86efff959c1d5ec016c8ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143636eucas1p1c3ca1df44b86efff959c1d5ec016c8ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143636eucas1p1c3ca1df44b86efff959c1d5ec016c8ae
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
	<CGME20250303143636eucas1p1c3ca1df44b86efff959c1d5ec016c8ae@eucas1p1.samsung.com>

The IMG Rogue GPU requires three clocks: core, sys, and mem [1]. On the
T-HEAD TH1520 SoC, the mem clock gate is marked as "Reserved" in the
hardware manual (section 4.4.2.6.1) [2] and cannot be configured.

Add a new CCU_GATE_CLK_OPS macro that allows specifying custom clock
operations. This enables us to use nop operations for the mem clock,
preventing the driver from attempting to enable/disable this reserved
clock gate.

Link: https://lore.kernel.org/all/2fe3d93f-62ac-4439-ac17-d81137f6410a@imgtec.com [1]
Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [2]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/clk-th1520-ap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 57972589f120..ea96d007aecd 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -89,6 +89,21 @@ struct ccu_pll {
 		}							\
 	}
 
+#define CCU_GATE_CLK_OPS(_clkid, _struct, _name, _parent, _reg, _gate, _flags,	\
+			 _clk_ops)						\
+	struct ccu_gate _struct = {						\
+		.enable	= _gate,						\
+		.common	= {							\
+			.clkid		= _clkid,				\
+			.cfg0		= _reg,					\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(		\
+						_name,				\
+						_parent,			\
+						&_clk_ops,			\
+						_flags),			\
+		}								\
+	}
+
 static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
 {
 	return container_of(hw, struct ccu_common, hw);
@@ -847,6 +862,11 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
 static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
 static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
 
+static const struct clk_ops clk_nop_ops = {};
+
+static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
+			video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
+
 static CCU_GATE(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
 		video_pll_clk_pd, 0x0, BIT(0), 0);
 static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
@@ -1205,6 +1225,12 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		ret = devm_clk_hw_register(dev, &emmc_sdio_ref_clk.hw);
 		if (ret)
 			return ret;
+	} else if (plat_data == &th1520_vo_platdata) {
+		ret = devm_clk_hw_register(dev, &gpu_mem_clk.common.hw);
+		if (ret)
+			return ret;
+		gpu_mem_clk.common.map = map;
+		priv->hws[CLK_GPU_MEM] = &gpu_mem_clk.common.hw;
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
-- 
2.34.1


