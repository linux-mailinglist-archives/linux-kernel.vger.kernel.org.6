Return-Path: <linux-kernel+bounces-541927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A50A4C384
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CA83A5B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295832144DD;
	Mon,  3 Mar 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VK84/EVo"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B043214219
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012603; cv=none; b=PyFkPJtjkW56YlO5xD8hkhFyYzEAIQuCLVDrfAtP7RlpgoM+YjlMaj4VWWLhxKCjXtPm3c+5y97JZXXDQ0OQixPp2Wrwpbcmfp626xN2ZRyD1ifOgGz2FnrOjKEGpHRJjN2wTJKzNLyaFPGkLgiXzYPb8oLBOWnNsvO06i1GiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012603; c=relaxed/simple;
	bh=Ua215Hd9PYMD2vvrDycgehoLktDThGS6vrG2nqSqBJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=S4uXsoTJjeSyFHqnfoz0a9bMkrRCIfU4hdsxV+vtYztawxzCsIGumXK6r42lo0T7qkf6+9smtY4ppriK1B/XZ3VqkoiXqupQ9bdc+8FRcUejeLyWUXGfk4KHZI95oateLyfMdkT5FrIw7O9ZDnwENcU2YUZySqwdUw4Fed5IDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VK84/EVo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250303143638euoutp02a533a8ea9e9dfd4685f7b72fa743bfa8~pUbv9Z7jj2792727927euoutp028
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250303143638euoutp02a533a8ea9e9dfd4685f7b72fa743bfa8~pUbv9Z7jj2792727927euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741012598;
	bh=2RTzJ2qIW6QHJ1xVf28+dD25ff+FzN3lcglLvG7tFCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VK84/EVod75fecIGAtEH7MRU9tsIkWKC2Sa5zBDVnDrfCZce+tyJlPZMIv4eL3RgA
	 NtBkxZ87Z2z7w4SeoFiCSO0mYBiA+KLH0MwMN5IsR4kULPWx0wBGs4D4VBDeQSq+2o
	 sqNXUvquopdmAayA/9lN44JiAIklhTbjBqqRALeo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250303143638eucas1p1aecf386f4a92e85fcc97b3060875645f~pUbvdQSiU2631826318eucas1p1p;
	Mon,  3 Mar 2025 14:36:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id DA.3C.20821.67EB5C76; Mon,  3
	Mar 2025 14:36:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0~pUbvDLdwk0504205042eucas1p1P;
	Mon,  3 Mar 2025 14:36:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250303143637eusmtrp2a9001e7e4370175b5446fad2aa8949e6~pUbvCc2Y01887518875eusmtrp2r;
	Mon,  3 Mar 2025 14:36:37 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-60-67c5be769d64
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.C0.19920.57EB5C76; Mon,  3
	Mar 2025 14:36:37 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303143636eusmtip26d8b366318502581e33c26828353764e~pUbuKTvar2028620286eusmtip2V;
	Mon,  3 Mar 2025 14:36:36 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with CLKGEN
 reset support
Date: Mon,  3 Mar 2025 15:36:29 +0100
Message-Id: <20250303143629.400583-5-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303143629.400583-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTZxjHfe+ud1ek7qwsvEPjpMYSHaIYt7wZC2xjLDczE+f2F7pIJ5dC
	RgvrAcMfkXal2GnnFpmUVUyN02gqjNnRWgjSrZSWUSyROiEEOpgyBHEMEZ1jwGgPN//7PN/n
	+zzf90leGpdOiRLofHUxp1ErCmRkDOH0PQluLm1tV26t+0eMfh+YESHHrIVCddeCGLJ6gyIU
	7mnE0N1rOgLpfQ0kGrOESTRlCotQqLmWRM7pChLVewcp1DBjxdCNziw0GO4g0FjIhKNKy3No
	ocVFoflbVwhU4f6aeD2OnewzUOzE2BjBthkfUmy4o1rE2m2fk+wP58vZinofxn45t5WdbP2F
	ZE802gDbo++l2Gn72l2x2TGv5XIF+aWcZkt6TkxeW1e9qGh2c9m8cQZoQYf8GBDTkNkOx8+Y
	qWMghpYylwD0VJ0gheIhgFVtrbhQTAN4y+sSPR1x+S4TEZYyFwEcdEkF0wSA3lFftEEy2+DQ
	Raso0ohjWjD4+PGT6CqcsQF459EUFXGtYrLhpO776ATBbIBzxqGoLmHS4W/6m6QQ9yJ0/3Qd
	j7CYyYCeXi0heFbCn7+5E2V80aN3nI4GQKZTDKs7+5eG34ILwz2UwKvguL9xidfAhSYrJnAh
	HHI8wAU+DJtM/iVOgwPBvxf30IsBG2FD8xZBfgPevucGERkyK2Df/ZXCE1bAk04zLsgSaKyU
	Cm45PGX64r/Q4CUnJlhYaJ/48CuQaHnmFsszt1j+jz0LcBuI50p4lZLjU9Xcpym8QsWXqJUp
	+wtVdrD4KwPz/gcucGZ8KsUDMBp4AKRxWZyk/2i7UirJVRw4yGkK92lKCjjeA1bThCxecs5t
	UEoZpaKY+5jjijjN0y5GixO0mNmUVZd8dPl78eeTdeWOP9fXjNhUf2R0WZN0Ly/LD2mP/AUN
	V+RXd3y27Mi5rsoRS/zBV/O/myUPyZyxLWeTZkX7c606fy2oURef1L4Dwi+lkbsKuwZv+mJP
	9fWPZhdX/bop8Ahfe2+HynDBpwmllZV2H17Y9rwxIfCBu7v3dirzyh5jDtcsKUNXzc3l9fI1
	iQFvQlZB4gtv80UjmddzRq3rku9Cazqao93mH9O19/u3v79OPlztP+6afxPb03PakalXZNqS
	Wx0f9Y7M7ZW7WtprvlXxNxRJjbtrNzje1a8OHBqQXN7pY9uXj5qP7zVaTd0hxtBkV+TVGYcP
	ZHzCygg+T5G6Cdfwin8B+GQTcgQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7ql+46mG2z8p2Px7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	sf7rfCaLi6dcLe7eO8Fi8fJyD7NF2yx+i/97drBb/Lu2kcWiZf8UFgcRj/c3Wtk93rx8yeJx
	uOMLu8e9E9NYPTat6mTz2Lyk3qNl7TEmj/6/Bh7v911l8+jbsorR41LzdXaPz5vkAnii9GyK
	8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIOn1nLWvBb
	t+Jfx1fGBsYTal2MnBwSAiYSO46tZuli5OIQEljKKHFr5w1miISMxLXulywQtrDEn2tdbBBF
	rxgl5j74wgiSYBMwkniwfD4rSEJE4AKTxK51q5lAHGaBdYwSU7bvYAKpEhaIkHi3oA1sLIuA
	qsTfjgfsIDavgJ3Eo+YrbBAr5CX2HzwLVsMpYC9x6HoD2GohoJo9a3dC1QtKnJz5BCzODFTf
	vHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjOxtx35u3sE479VH
	vUOMTByMhxglOJiVRHhvtR9NF+JNSaysSi3Kjy8qzUktPsRoCnT3RGYp0eR8YGrJK4k3NDMw
	NTQxszQwtTQzVhLndbt8Pk1IID2xJDU7NbUgtQimj4mDU6qBiXlJysKLziEzG2MenlIKElzq
	OOXAX8bJp20+JXKf4VbcspfvZ4HafwaravVFfY8uBdv3KlwLPGKy5VdeEmtD0NKSc3sSLuZw
	1uQffzrpzTW/zllzZyXolyz+/DNvV9qWzZaOJ+f+N4r0SlR5ZjWTbeVWj2clNx2ChdTKq2ov
	tP90Y/34oJKp9rn67Jq8RYkhJ5dZPC/k+7nlIOuKn7p7ts5YINf37uneWa5HI68+CAv0n/R0
	p3x/KlON44knX34ni1zxe6lyWSJDN2NCc0yCaaSHe3h+fB3vdocrR1g6s46mdFrYyP/c++Pg
	q7ri779vvjLNqnxVqxMfbPpCPIf3qH6d0DObaxVNZfX7/oQYKrEUZyQaajEXFScCACXhFKN1
	AwAA
X-CMS-MailID: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
	<CGME20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0@eucas1p1.samsung.com>

The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
clock gate is marked as "Reserved" in hardware, while core and cfg are
configurable. In order for these clock gates to work properly, the
CLKGEN reset must be managed in a specific sequence.

Move the CLKGEN reset handling to the clock driver since it's
fundamentally a clock-related workaround [1]. This ensures that clk_enabled
GPU clocks stay physically enabled without external interference from
the reset driver.  The reset is now deasserted only when both core and
cfg clocks are enabled, and asserted when either of them is disabled.

The mem clock is configured to use nop operations since it cannot be
controlled.

Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/clk/thead/clk-th1520-ap.c | 87 ++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index ea96d007aecd..1dfcde867233 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #define TH1520_PLL_POSTDIV2	GENMASK(26, 24)
 #define TH1520_PLL_POSTDIV1	GENMASK(22, 20)
@@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
 static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
 static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
 
+static struct reset_control *gpu_reset;
+static DEFINE_SPINLOCK(gpu_reset_lock); /* protect GPU reset sequence */
+
+static void ccu_gpu_clk_disable(struct clk_hw *hw);
+static int ccu_gpu_clk_enable(struct clk_hw *hw);
+
+static const struct clk_ops ccu_gate_gpu_ops = {
+	.disable	= ccu_gpu_clk_disable,
+	.enable		= ccu_gpu_clk_enable
+};
+
 static const struct clk_ops clk_nop_ops = {};
 
 static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
 			video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
+static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
+			video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_ops);
+static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
+			video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_ops);
+
+static void ccu_gpu_clk_disable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpu_reset_lock, flags);
+
+	ccu_disable_helper(&cg->common, cg->enable);
+
+	if ((cg == &gpu_core_clk &&
+	     !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
+	    (cg == &gpu_cfg_aclk &&
+	     !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
+		reset_control_assert(gpu_reset);
+
+	spin_unlock_irqrestore(&gpu_reset_lock, flags);
+}
+
+static int ccu_gpu_clk_enable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&gpu_reset_lock, flags);
+
+	ret = ccu_enable_helper(&cg->common, cg->enable);
+	if (ret) {
+		spin_unlock_irqrestore(&gpu_reset_lock, flags);
+		return ret;
+	}
+
+	if ((cg == &gpu_core_clk &&
+	     clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
+	    (cg == &gpu_cfg_aclk && clk_hw_is_enabled(&gpu_core_clk.common.hw)))
+		ret = reset_control_deassert(gpu_reset);
+
+	spin_unlock_irqrestore(&gpu_reset_lock, flags);
+
+	return ret;
+}
 
 static CCU_GATE(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
 		video_pll_clk_pd, 0x0, BIT(0), 0);
-static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
-		0x0, BIT(3), 0);
-static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
-		video_pll_clk_pd, 0x0, BIT(4), 0);
 static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
 		video_pll_clk_pd, 0x0, BIT(5), 0);
 static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
@@ -1046,8 +1100,6 @@ static struct ccu_common *th1520_gate_clks[] = {
 
 static struct ccu_common *th1520_vo_gate_clks[] = {
 	&axi4_vo_aclk.common,
-	&gpu_core_clk.common,
-	&gpu_cfg_aclk.common,
 	&dpu0_pixelclk.common,
 	&dpu1_pixelclk.common,
 	&dpu_hclk.common,
@@ -1150,6 +1202,13 @@ static int th1520_clk_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
+	if (plat_data == &th1520_vo_platdata) {
+		gpu_reset = devm_reset_control_get_exclusive(dev, NULL);
+		if (IS_ERR(gpu_reset))
+			return dev_err_probe(dev, PTR_ERR(gpu_reset),
+					     "GPU reset is required for VO clock controller\n");
+	}
+
 	for (i = 0; i < plat_data->nr_pll_clks; i++) {
 		struct ccu_pll *cp = hw_to_ccu_pll(&plat_data->th1520_pll_clks[i]->hw);
 
@@ -1226,11 +1285,27 @@ static int th1520_clk_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	} else if (plat_data == &th1520_vo_platdata) {
+		/* GPU clocks need to be treated differently, as MEM clock
+		 * is non-configurable, and the reset needs to be de-asserted
+		 * after enabling CORE and CFG clocks.
+		 */
 		ret = devm_clk_hw_register(dev, &gpu_mem_clk.common.hw);
 		if (ret)
 			return ret;
 		gpu_mem_clk.common.map = map;
 		priv->hws[CLK_GPU_MEM] = &gpu_mem_clk.common.hw;
+
+		ret = devm_clk_hw_register(dev, &gpu_core_clk.common.hw);
+		if (ret)
+			return ret;
+		gpu_core_clk.common.map = map;
+		priv->hws[CLK_GPU_CORE] = &gpu_core_clk.common.hw;
+
+		ret = devm_clk_hw_register(dev, &gpu_cfg_aclk.common.hw);
+		if (ret)
+			return ret;
+		gpu_cfg_aclk.common.map = map;
+		priv->hws[CLK_GPU_CFG_ACLK] = &gpu_cfg_aclk.common.hw;
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, priv);
-- 
2.34.1


