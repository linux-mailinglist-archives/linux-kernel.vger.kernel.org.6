Return-Path: <linux-kernel+bounces-293472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE299958036
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C01C20D72
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68E18B461;
	Tue, 20 Aug 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CU+5qJOQ"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0918A6BE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139929; cv=none; b=hSuKjlNk3Q6aYD9ZBshMvkLOxHTf/Bjp5HpZNuEv+znwTwK9GgXZzftoaTjha0eA+e0KWBiBSjcKPId3uy6c0wM3+nrYQffvKacpdXyMrUJf0QnoO3V8/4QZcV06u3Xi4H/vRiA9CYsEXb5/kr7KCtLb37DXDotEvtbvlLyQhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139929; c=relaxed/simple;
	bh=mdT74uWZcfUu4GPTkmW9ZHBUjG9QUtFQr1iiK5QoGAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=t0eoy99/zT1cpsfKDuRLd7nKo/XmE8+Qh4ObNBSrdr7EpsIWIN2IXG2UWCOnwXWLoRYpfxdWh0zE3D0Cc0yZMOgWVAVvTdjKMU0doH+jU7P0KQ0lWrvT41NhVBmeoSm6tw2DEWdQuxrsp8aT9cNd/W85vKKomMwZOl9nnym3Lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CU+5qJOQ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240820074521epoutp02cdb46cde0705f388bb09bfc5c4acf464~tYB_1gsPE0877908779epoutp02L
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:45:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240820074521epoutp02cdb46cde0705f388bb09bfc5c4acf464~tYB_1gsPE0877908779epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724139921;
	bh=y6t2Nq+1oZ2dvDig3RarcDu1Ow/JdAknngYrTFVUuSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CU+5qJOQfHMmH8x76qfgSG71GwzeIDZQIVWQBo/ZUKfLP5Rd4UDaxBTKIVIpypjI8
	 7rnYbNerwwPM3hQZ8Fn7eMpO5szKvo8nUaUIVx/373/T3kVro/dOqMb14gRfSIxrCd
	 UzAAvfKYtmFYAtOc1QE+KjBLCYOCXpZOifJiqtXw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240820074521epcas2p193e66d6c065c05194bebed3d9cdd7f53~tYB_X8FEj2005420054epcas2p1S;
	Tue, 20 Aug 2024 07:45:21 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wp1hw3YGyz4x9QL; Tue, 20 Aug
	2024 07:45:20 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.75.10066.09944C66; Tue, 20 Aug 2024 16:45:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240820074519epcas2p2d44214309359b0b1927947f7d52d4f89~tYB9QhzU53099630996epcas2p2B;
	Tue, 20 Aug 2024 07:45:19 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240820074519epsmtrp109c466e23d06699e560958364d3bad59~tYB9POw-E0720407204epsmtrp1_;
	Tue, 20 Aug 2024 07:45:19 +0000 (GMT)
X-AuditID: b6c32a46-24fff70000002752-4a-66c449903ba9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.C4.07567.F8944C66; Tue, 20 Aug 2024 16:45:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.60]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240820074519epsmtip2998f6a5e587f2df75fe2e00c4ed3a526~tYB8_eQ-K2524825248epsmtip2K;
	Tue, 20 Aug 2024 07:45:19 +0000 (GMT)
From: Sunyeal Hong <sunyeal.hong@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Kwanghoon Son <k.son@samsung.com>, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] clk: samsung: exynosautov9: add dpum clock support
Date: Tue, 20 Aug 2024 16:45:10 +0900
Message-ID: <20240820074514.3123767-2-sunyeal.hong@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820074514.3123767-1-sunyeal.hong@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmue4EzyNpBhs/C1s8mLeNzWLN3nNM
	Fte/PGe1mH/kHKtF75qrTBbnz29gt9j7eiu7xabH11gtPvbcY7W4vGsOm8WM8/uYLC6ecrX4
	v2cHu8XhN+2sFv+ubWRx4Pd4f6OV3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgFsUdk2GamJ
	KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
	EouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM95cfM1W
	sEmz4v+cDewNjL+Uuxg5OSQETCTWP1vF1sXIxSEksINR4uPky6wQzidGiReNC9ghnG+MEm+e
	/2SCaVm+aj2YLSSwl1Gi64IsRNFHRonHP5eydDFycLAJ6Er8+ecAEhcR2MMkseX8EiYQh1ng
	P9CkZTvYQbqFBbwk1l7dxwxiswioSjTvOMkK0swrYC8x+0k0xDJ5iYtrnrOB2JwCDhIzOo+w
	gti8AoISJ2c+YQGxmYFqmrfOZgaZLyGwlkNi9rJFUJe6SJy+uBnKFpZ4dXwLO4QtJfGyvw3K
	zpeYfP0tE0RzA6PEtX/dzBAJe4lFZ36ygxzELKApsX6XPogpIaAsceQW1F4+iY7Df9khwrwS
	HW1CEI1qEp+uXIYaIiNx7MQzKNtD4ty8O9AAncwo8fv9bNYJjAqzkLwzC8k7sxAWL2BkXsUo
	llpQnJueWmxUYASP4eT83E2M4BSs5baDccrbD3qHGJk4GA8xSnAwK4nwdr88mCbEm5JYWZVa
	lB9fVJqTWnyI0RQY1hOZpUST84FZIK8k3tDE0sDEzMzQ3MjUwFxJnPde69wUIYH0xJLU7NTU
	gtQimD4mDk6pBqbo1Yf2ZrSuOTrR4+iXK+zzKv2v/C30z+Jfo6EvbSDVsKHvj4+h/KwNT0ql
	z3de7Ixx0XUp/d3eZScts2npU5eyTVyr4zc906wyU/994UvO2/c7VsxX28x1WPt5g/j2/yfY
	+7su32Ja7nRxX0sVu4G+Vdjx0xfOHT7+5BzfHe2JHDe6w1Xvv/7uxfvyyvNlVkzbhbt8f6nM
	2/nopwcr56wFdVIKTvN4Em/FLPvTeMn6XV3V7/tdqguS5t098Oe7e+UrXkbnuFAbi2Xy8/L+
	FKosmngy8ZA9+2LFQzNvqn9veh12Zn7ddPVVgQtFbrg/3uTXoe1nvDPxxinnYOlcxethp9jk
	/ghdNci12vHD3k1EiaU4I9FQi7moOBEA4SuXR0oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvG6/55E0gxszDSwezNvGZrFm7zkm
	i+tfnrNazD9yjtWid81VJovz5zewW+x9vZXdYtPja6wWH3vusVpc3jWHzWLG+X1MFhdPuVr8
	37OD3eLwm3ZWi3/XNrI48Hu8v9HK7rFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2KC6blNSc
	zLLUIn27BK6MNxdfsxVs0qz4P2cDewPjL+UuRk4OCQETieWr1jN1MXJxCAnsZpR4t2wBE0RC
	RmJjw392CFtY4n7LEVaIoveMErOWPAVKcHCwCehK/PnnABIXETjEJDHx81MWkAZmgVYmiX3P
	rEFsYQEvibVX9zGD2CwCqhLNO06ygvTyCthLzH4SDTFfXuLimudsIDangIPEjM4jYCVCQCWP
	lxqDhHkFBCVOznwCNV1eonnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm56bbFhgmJdarlecmFtc
	mpeul5yfu4kRHClaGjsY783/p3eIkYmD8RCjBAezkghv98uDaUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5DWfMThESSE8sSc1OTS1ILYLJMnFwSjUwyeW+3mTVEKGz1Ld6f5bI5C1by1iXrCrN
	Dlp7zsXmSHJpXsL3SSKcL4y2V7zLqn0gNDE61Dyx5KlVj83x7t0Brau3s+2tf8q9eZPCl+SC
	73n/THd/P3Sbb2tx52uRt8d+Se2+qKHLrpDIe3UK1/wtNrPD7lo/nZXC7Ju86ti6cslftqs2
	yPrdeNgWJflq4dO7upntTw4cVvwxOXnay3kPb3+RP6V6IOeb0obY7/ekX1r22k3ImWb/KaVA
	dN2jeXwB3oY8QTKmTA+/2i9hvvbr/s7zq+fpmvRtXy0XfGfaV7mP9WnL37ZOa/U8HRnN+Hfy
	kQStrWvag1cZazvcnTgv4euL9s8rw4V3hp9h+9Q0LV+JpTgj0VCLuag4EQAem2OFAwMAAA==
X-CMS-MailID: 20240820074519epcas2p2d44214309359b0b1927947f7d52d4f89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240820074519epcas2p2d44214309359b0b1927947f7d52d4f89
References: <20240820074514.3123767-1-sunyeal.hong@samsung.com>
	<CGME20240820074519epcas2p2d44214309359b0b1927947f7d52d4f89@epcas2p2.samsung.com>

From: Kwanghoon Son <k.son@samsung.com>

Add dpum clock for exynosautov9.

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
Link: https://lore.kernel.org/r/20240809-clk_dpum-v3-3-359decc30fe2@samsung.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/samsung/clk-exynosautov9.c | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
index f04bacacab2c..5971e680e566 100644
--- a/drivers/clk/samsung/clk-exynosautov9.c
+++ b/drivers/clk/samsung/clk-exynosautov9.c
@@ -20,6 +20,7 @@
 #define CLKS_NR_TOP			(GOUT_CLKCMU_PERIS_BUS + 1)
 #define CLKS_NR_BUSMC			(CLK_GOUT_BUSMC_SPDMA_PCLK + 1)
 #define CLKS_NR_CORE			(CLK_GOUT_CORE_CMU_CORE_PCLK + 1)
+#define CLKS_NR_DPUM			(CLK_GOUT_DPUM_SYSMMU_D3_CLK + 1)
 #define CLKS_NR_FSYS0			(CLK_GOUT_FSYS0_PCIE_GEN3B_4L_CLK + 1)
 #define CLKS_NR_FSYS1			(CLK_GOUT_FSYS1_USB30_1_ACLK + 1)
 #define CLKS_NR_FSYS2			(CLK_GOUT_FSYS2_UFS_EMBD1_UNIPRO + 1)
@@ -1076,6 +1077,85 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
 	.clk_name		= "dout_clkcmu_core_bus",
 };
 
+/* ---- CMU_DPUM ---------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_DPUM (0x18c00000) */
+#define PLL_CON0_MUX_CLKCMU_DPUM_BUS_USER				0x0600
+#define CLK_CON_DIV_DIV_CLK_DPUM_BUSP					0x1800
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DECON		0x202c
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DMA		0x2030
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DPP		0x2034
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D0_DPUM_IPCLKPORT_CLK_S1	0x207c
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D1_DPUM_IPCLKPORT_CLK_S1	0x2084
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D2_DPUM_IPCLKPORT_CLK_S1	0x208c
+#define CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D3_DPUM_IPCLKPORT_CLK_S1	0x2094
+
+static const unsigned long dpum_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_DPUM_BUS_USER,
+	CLK_CON_DIV_DIV_CLK_DPUM_BUSP,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DECON,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DMA,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DPP,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D0_DPUM_IPCLKPORT_CLK_S1,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D1_DPUM_IPCLKPORT_CLK_S1,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D2_DPUM_IPCLKPORT_CLK_S1,
+	CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D3_DPUM_IPCLKPORT_CLK_S1,
+};
+
+PNAME(mout_dpum_bus_user_p) = { "oscclk", "dout_clkcmu_dpum_bus" };
+
+static const struct samsung_mux_clock dpum_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_DPUM_BUS_USER, "mout_dpum_bus_user",
+	    mout_dpum_bus_user_p, PLL_CON0_MUX_CLKCMU_DPUM_BUS_USER, 4, 1),
+};
+
+static const struct samsung_div_clock dpum_div_clks[] __initconst = {
+	DIV(CLK_DOUT_DPUM_BUSP, "dout_dpum_busp", "mout_dpum_bus_user",
+	    CLK_CON_DIV_DIV_CLK_DPUM_BUSP, 0, 3),
+};
+
+static const struct samsung_gate_clock dpum_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_DPUM_ACLK_DECON, "gout_dpum_decon_aclk",
+	     "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DECON, 21,
+	     0, 0),
+	GATE(CLK_GOUT_DPUM_ACLK_DMA, "gout_dpum_dma_aclk", "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DMA, 21,
+	     0, 0),
+	GATE(CLK_GOUT_DPUM_ACLK_DPP, "gout_dpum_dpp_aclk", "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_DPUM_IPCLKPORT_ACLK_DPP, 21,
+	     0, 0),
+	GATE(CLK_GOUT_DPUM_SYSMMU_D0_CLK, "gout_dpum_sysmmu_d0_clk",
+	     "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D0_DPUM_IPCLKPORT_CLK_S1, 21,
+	     0, 0),
+	GATE(CLK_GOUT_DPUM_SYSMMU_D1_CLK, "gout_dpum_sysmmu_d1_clk",
+	     "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D1_DPUM_IPCLKPORT_CLK_S1, 21,
+	     0, 0),
+	GATE(CLK_GOUT_DPUM_SYSMMU_D2_CLK, "gout_dpum_sysmmu_d2_clk",
+	     "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D2_DPUM_IPCLKPORT_CLK_S1, 21,
+	     0, 0),
+	GATE(CLK_GOUT_DPUM_SYSMMU_D3_CLK, "gout_dpum_sysmmu_d3_clk",
+	     "mout_dpum_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_DPUM_UID_SYSMMU_D3_DPUM_IPCLKPORT_CLK_S1, 21,
+	     0, 0),
+};
+
+static const struct samsung_cmu_info dpum_cmu_info __initconst = {
+	.mux_clks		= dpum_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(dpum_mux_clks),
+	.div_clks		= dpum_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(dpum_div_clks),
+	.gate_clks		= dpum_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(dpum_gate_clks),
+	.nr_clk_ids		= CLKS_NR_DPUM,
+	.clk_regs		= dpum_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(dpum_clk_regs),
+	.clk_name		= "bus",
+};
+
 /* ---- CMU_FSYS0 ---------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_FSYS2 (0x17700000) */
@@ -2085,6 +2165,9 @@ static const struct of_device_id exynosautov9_cmu_of_match[] = {
 	}, {
 		.compatible = "samsung,exynosautov9-cmu-core",
 		.data = &core_cmu_info,
+	}, {
+		.compatible = "samsung,exynosautov9-cmu-dpum",
+		.data = &dpum_cmu_info,
 	}, {
 		.compatible = "samsung,exynosautov9-cmu-fsys0",
 		.data = &fsys0_cmu_info,
-- 
2.45.2


