Return-Path: <linux-kernel+bounces-397885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5379BE1E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6E7B216F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94241DEFC3;
	Wed,  6 Nov 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HZ+6uSnw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88D1DDC0B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883974; cv=none; b=LxF7JXeK+0pdO5p/V8ScFvuD7H7ZGSUrGrY9cewznzkWwszOtikxXm+j4BJvvzq9mbi0mgePPbYPyPsK5EeCfWhh2rd/ZcDjaFjcMf4nkYBFxtYztiHDtA226eh8sSpLR0xD6srSa5GoKSCAbrYzZsCWioh15m+zqddi0SJBk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883974; c=relaxed/simple;
	bh=E0EjKgETzClg56TW652fR74rlWW9Werxa1mPaPNQNVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpofvr8xd5BA0VxWFw2auH8RXZMvdco4FwwZkgLbedek0BdMP6OTH38dtX3IhiE5rEBzmMkjMiv2eapy3aS/TkrtFPB2nfOz/wqYMUl1DvYAp1MJzxWL2hoN+WENsDD4nb/tq2MmPQGc/QIWDhRW4Y44PMZX5ZnpruZ4n0LmM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HZ+6uSnw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a850270e2so1072549266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730883971; x=1731488771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYFE+8+xJyXnOIazKfuEkYOBmIG07KamRjf0rhIE9ik=;
        b=HZ+6uSnwI2u3GPhgA01Ioy95+UfuNNL0MdcgUPN7EqWZjA8nYYsAGF66UGpizmcNXk
         vRBRt3fqpYVKSd0Ly8Am/sGLuH23Gppvfajroct2RUE93kN0EH3Sq/6DPbtxcHTxrUxa
         D3V3NYQV/87CC7dS0zxmOAFOtbwwGdJYWyL3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883971; x=1731488771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYFE+8+xJyXnOIazKfuEkYOBmIG07KamRjf0rhIE9ik=;
        b=llZrNoyu1NwEao1RwuYVqv9AS77tiKxvPHwJicN/b2h1yEXeB1qpd+xYif8JNIfY4N
         KPhtutluOMsvcXujZxbAzVjU8JtlJZ3Dt+NJFJ1GuF5T9NMt0T3M9RuaIOFHZQx3T4Hx
         OlwH2zcuYSDY4lyJx/fnZv1z7CasooreqsvvIt9EVDovfmEjvOerwEQagz9nsXbLRyRx
         T8cAwWAEr9Li12cOhg7p9nJlSLpxARyFmAs9SxwRcXogm8ndrLcEe9G17lbA7ESKFa0P
         AhP6OKZXNFzGXLpM7f2xq/uwRkCr/FhKqbchHRh4K8I7O9UTbsL3dWLQZ54zxfOJ6XKz
         IcBQ==
X-Gm-Message-State: AOJu0YxlfZpx4234nS2P1rw9+A2NTnwiRXZNH2IU1aO8OUtZdGhLAHQO
	a7UF1/I+WT73H6G5AXZwK8T4BEL9aR2KAcMlS/lwK+bRVQ3VflflKUp8ApK3mUJsWpfH88yweoE
	6
X-Google-Smtp-Source: AGHT+IHyTHyqf3Jta1X+os2BTNrPt/oVIIBiJeTcaNSfus01zxd7SAbBcJC86RW3jCnUhJeo0hXBbg==
X-Received: by 2002:a17:907:3f05:b0:a99:375f:4523 with SMTP id a640c23a62f3a-a9e6587e27dmr1945150966b.44.1730883970924;
        Wed, 06 Nov 2024 01:06:10 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:afb5:f524:6416:8e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9422sm247781366b.139.2024.11.06.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:06:10 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v3 2/8] clk: imx: pll14xx: support spread spectrum clock generation
Date: Wed,  6 Nov 2024 09:57:58 +0100
Message-ID: <20241106090549.3684963-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for spread spectrum clock (SSC) generation for
the pll14xxx. The addition of the "imx_clk_hw_pll14xx_ssc" macro has
minimized the number of changes required to avoid compilation errors
following the addition of the SSC setup parameter to the
"imx_dev_clk_hw_pll14xx" macro used in the files clk-imx8m{m,n,p}.c.
The change to the clk-imx8mp-audiomix.c file prevents the patch from
causing a compilation error.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mp-audiomix.c |   2 +-
 drivers/clk/imx/clk-pll14xx.c         | 102 +++++++++++++++++++++++++-
 drivers/clk/imx/clk.h                 |  24 +++++-
 3 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b2cb157703c5..bfcf2975c217 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -365,7 +365,7 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_REF_SEL] = hw;
 
 	hw = imx_dev_clk_hw_pll14xx(dev, "sai_pll", "sai_pll_ref_sel",
-				    base + 0x400, &imx_1443x_pll);
+				    base + 0x400, &imx_1443x_pll, NULL);
 	if (IS_ERR(hw)) {
 		ret = PTR_ERR(hw);
 		goto err_clk_register;
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index d63564dbb12c..76014e243a57 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -20,6 +20,8 @@
 #define GNRL_CTL	0x0
 #define DIV_CTL0	0x4
 #define DIV_CTL1	0x8
+#define SSCG_CTRL	0xc
+
 #define LOCK_STATUS	BIT(31)
 #define LOCK_SEL_MASK	BIT(29)
 #define CLKE_MASK	BIT(11)
@@ -31,6 +33,10 @@
 #define KDIV_MASK	GENMASK(15, 0)
 #define KDIV_MIN	SHRT_MIN
 #define KDIV_MAX	SHRT_MAX
+#define SSCG_ENABLE	BIT(31)
+#define MFREQ_CTL_MASK	GENMASK(19, 12)
+#define MRAT_CTL_MASK	GENMASK(9, 4)
+#define SEL_PF_MASK	GENMASK(1, 0)
 
 #define LOCK_TIMEOUT_US		10000
 
@@ -40,6 +46,7 @@ struct clk_pll14xx {
 	enum imx_pll14xx_type		type;
 	const struct imx_pll14xx_rate_table *rate_table;
 	int rate_count;
+	struct imx_pll14xx_ssc		ssc;
 };
 
 #define to_clk_pll14xx(_hw) container_of(_hw, struct clk_pll14xx, hw)
@@ -347,6 +354,27 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
+static void clk_pll1443x_set_sscg(struct clk_hw *hw, unsigned long parent_rate,
+				  unsigned int pdiv, unsigned int mdiv)
+{
+	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
+	struct imx_pll14xx_ssc *ssc = &pll->ssc;
+	u32 sscg_ctrl = readl_relaxed(pll->base + SSCG_CTRL);
+
+	sscg_ctrl &=
+		~(SSCG_ENABLE | MFREQ_CTL_MASK | MRAT_CTL_MASK | SEL_PF_MASK);
+	if (ssc->enable) {
+		u32 mfr = parent_rate / (ssc->mod_freq * pdiv * (1 << 5));
+		u32 mrr = (ssc->mod_rate * mdiv * (1 << 6)) / (100 * mfr);
+
+		sscg_ctrl |= SSCG_ENABLE | FIELD_PREP(MFREQ_CTL_MASK, mfr) |
+			     FIELD_PREP(MRAT_CTL_MASK, mrr) |
+			     FIELD_PREP(SEL_PF_MASK, ssc->mod_type);
+	}
+
+	writel_relaxed(sscg_ctrl, pll->base + SSCG_CTRL);
+}
+
 static int clk_pll1443x_set_rate(struct clk_hw *hw, unsigned long drate,
 				 unsigned long prate)
 {
@@ -368,6 +396,9 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, unsigned long drate,
 		writel_relaxed(FIELD_PREP(KDIV_MASK, rate.kdiv),
 			       pll->base + DIV_CTL1);
 
+		if (pll->ssc.enable)
+			clk_pll1443x_set_sscg(hw, prate, rate.pdiv, rate.mdiv);
+
 		return 0;
 	}
 
@@ -408,6 +439,9 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, unsigned long drate,
 	gnrl_ctl &= ~BYPASS_MASK;
 	writel_relaxed(gnrl_ctl, pll->base + GNRL_CTL);
 
+	if (pll->ssc.enable)
+		clk_pll1443x_set_sscg(hw, prate, rate.pdiv, rate.mdiv);
+
 	return 0;
 }
 
@@ -487,7 +521,8 @@ static const struct clk_ops clk_pll1443x_ops = {
 
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
-				const struct imx_pll14xx_clk *pll_clk)
+				const struct imx_pll14xx_clk *pll_clk,
+				const struct imx_pll14xx_ssc *ssc)
 {
 	struct clk_pll14xx *pll;
 	struct clk_hw *hw;
@@ -525,6 +560,8 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 	pll->type = pll_clk->type;
 	pll->rate_table = pll_clk->rate_table;
 	pll->rate_count = pll_clk->rate_count;
+	if (ssc)
+		memcpy(&pll->ssc, ssc, sizeof(pll->ssc));
 
 	val = readl_relaxed(pll->base + GNRL_CTL);
 	val &= ~BYPASS_MASK;
@@ -542,3 +579,66 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(imx_dev_clk_hw_pll14xx);
+
+static enum imx_pll14xx_ssc_mod_type clk_pll14xx_ssc_mode(const char *name,
+							  enum imx_pll14xx_ssc_mod_type def)
+{
+	int i;
+	struct {
+		const char *name;
+		enum imx_pll14xx_ssc_mod_type id;
+	} mod_methods[] = {
+		{ .name = "down-spread", .id = IMX_PLL14XX_SSC_DOWN_SPREAD },
+		{ .name = "up-spread", .id = IMX_PLL14XX_SSC_UP_SPREAD },
+		{ .name = "center-spread", .id = IMX_PLL14XX_SSC_CENTER_SPREAD }
+	};
+
+	for (i = 0; i < ARRAY_SIZE(mod_methods); i++) {
+		if (!strcmp(name, mod_methods[i].name))
+			return mod_methods[i].id;
+	}
+
+	return def;
+}
+
+void imx_clk_pll14xx_get_ssc_conf(struct device_node *np, int pll_id,
+				  struct imx_pll14xx_ssc *ssc)
+{
+	int i, ret, offset, num_clks;
+	u32 clk_id, clk_cell_size;
+	const char *s;
+
+	if (!ssc)
+		return;
+
+	memset(ssc, 0, sizeof(*ssc));
+
+	num_clks = of_count_phandle_with_args(np, "fsl,ssc-clocks",
+					      "#clock-cells");
+	if (num_clks <= 0)
+		return;
+
+	ret = of_property_read_u32(np, "#clock-cells", &clk_cell_size);
+	if (ret)
+		return;
+
+	for (i = 0; i < num_clks; i++) {
+		offset = i * clk_cell_size + 1;
+		of_property_read_u32_index(np, "fsl,ssc-clocks", offset,
+					   &clk_id);
+		if (clk_id != pll_id)
+			continue;
+
+		of_property_read_u32_index(np, "fsl,ssc-modfreq-hz", i,
+					   &ssc->mod_freq);
+		of_property_read_u32_index(np, "fsl,ssc-modrate-percent", i,
+					   &ssc->mod_rate);
+		if (!of_property_read_string(np, "fsl,ssc-modmethod", &s))
+			ssc->mod_type = clk_pll14xx_ssc_mode(
+				s, IMX_PLL14XX_SSC_DOWN_SPREAD);
+
+		ssc->enable = true;
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(imx_clk_pll14xx_get_ssc_conf);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index aa5202f284f3..8cbc75480569 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -62,6 +62,19 @@ struct imx_pll14xx_rate_table {
 	unsigned int kdiv;
 };
 
+enum imx_pll14xx_ssc_mod_type {
+	IMX_PLL14XX_SSC_DOWN_SPREAD,
+	IMX_PLL14XX_SSC_UP_SPREAD,
+	IMX_PLL14XX_SSC_CENTER_SPREAD,
+};
+
+struct imx_pll14xx_ssc {
+	bool enable;
+	unsigned int mod_freq;
+	unsigned int mod_rate;
+	enum imx_pll14xx_ssc_mod_type mod_type;
+};
+
 struct imx_pll14xx_clk {
 	enum imx_pll14xx_type type;
 	const struct imx_pll14xx_rate_table *rate_table;
@@ -222,11 +235,18 @@ extern struct imx_fracn_gppll_clk imx_fracn_gppll_integer;
 	__imx_clk_hw_divider(name, parent, reg, shift, width, flags)
 
 #define imx_clk_hw_pll14xx(name, parent_name, base, pll_clk) \
-	imx_dev_clk_hw_pll14xx(NULL, name, parent_name, base, pll_clk)
+	imx_dev_clk_hw_pll14xx(NULL, name, parent_name, base, pll_clk, NULL)
+
+#define imx_clk_hw_pll14xx_ssc(name, parent_name, base, pll_clk, ssc)	\
+	imx_dev_clk_hw_pll14xx(NULL, name, parent_name, base, pll_clk, ssc)
 
 struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 				const char *parent_name, void __iomem *base,
-				const struct imx_pll14xx_clk *pll_clk);
+				const struct imx_pll14xx_clk *pll_clk,
+				const struct imx_pll14xx_ssc *ssc);
+
+void imx_clk_pll14xx_get_ssc_conf(struct device_node *np, int pll_id,
+				  struct imx_pll14xx_ssc *ssc);
 
 struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
-- 
2.43.0


