Return-Path: <linux-kernel+bounces-553135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6DA58459
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC873AC284
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA61813AD05;
	Sun,  9 Mar 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzVRr44W"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDF1DDC01;
	Sun,  9 Mar 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527044; cv=none; b=O/szP0JVc9v21mhrHERDFIdxK8awLy+wFnv282+gNaxK9LfIloFuGeyRNUPAUwlHYGJ2GYz9Q4bf2lk/hrMeZEVeJc9tGFyo8JRIt3sJeKd1JjaJ71XzIrrWWeMF/gwrYRlo0BIJ7W+Inf9MMA7laDBJvZuV0OZhreJL/7zqw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527044; c=relaxed/simple;
	bh=Vf4IvpSQePggWg4vxSZCOAh0dp5rJpQ5R2PqA5vbKGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEMKLlzj2h7LMBfk+w04KYXWdrCkntCQHcX4JoW5j3r27TgnwfzEoFOmuCj0fzh/NtF53pJt6EviHfFrSgBSAi1znsWigBTl8/sjDIkfJjbYl/iq+IGoiXwkuhgbCs0EBFF+7A3JJDIgE7crGVtFzjxASu/gqPUNyZr80C7acJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzVRr44W; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1547307f8f.3;
        Sun, 09 Mar 2025 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527041; x=1742131841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYnsaKwLQcaTkvM+4ffTJRr6nfs/V7lVq/qqbRtol90=;
        b=NzVRr44WGN3d7jcpv4bRk2JpZAxk2n7MmZ/vNodPB9YMzdxysSBxeP0ApT832BVtDj
         shVW+vpS/+6QZxKq7gXy4AG5IbWDWyZMbbSfeYp7naoYIYXEimyfL8N71ZDSaOKkNM/T
         CS0jKk18urgsVoLKz1IfFqHIyDymm6AgEzm8GMvyp126Feos1JFniy0Z1cUs8C4xoNro
         INH6pRABgzK9SkpZUBCWQVpGmQCIEjV4PEsWmJxSrTPJscsS+3cVKVaWtK68vMv/rSPd
         Go7TcZlAqRYpLIswyce9qiw+TsN8qUH1idf7txB6Nn0itbRR4bYVk+mqZs8vXEBg3d9n
         McVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527041; x=1742131841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYnsaKwLQcaTkvM+4ffTJRr6nfs/V7lVq/qqbRtol90=;
        b=c+vAu8zHSpEzZID/jzT+1X+7AkBgEy5MCXE7ZcWV5N/FXPK9IoKd9tW/DN1/orHO6+
         fe7rDVbNjqXPu10ViiHbhilbFJmDkeFlSlCd3x0y8mkYiHTqHTbM/5bnOboL5q3QtDp6
         hdW2kjB18BzO3ywYPbgYl3UCNRNey2WM8Waomoj9jVXTYgodEV4uNh3SDMu5Sle73OtT
         HVzkIDSvRgqIMjZfU2G3QkDofUbdNrouP+Rm0mCOk46/F88V6krokTVnlZKbDebiRkWz
         ZcldbbYCDsdfqQs/4heTPW20LSXiB5hVbG3nFK/jBv2bpCwEdZP/wMqhS4Kzfdp2hMjT
         cwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0AnG9sVKqLnncOCe1wAS3pj59w6Mx3cm3BbNuE77mbch79DklJg47zLN9FKjjxB/tXKnRzerKQqsI@vger.kernel.org, AJvYcCV00ONIKrWPmFF3W3F8sXyxmz82o/T+sDr7udCSksYgOn18qb8QikmTxhrjyz4DkdxS9FOdBQPLS9lh@vger.kernel.org, AJvYcCWp5NIQmzKmEWoi/UCgCLbblFyhJ1daTkGCfD4HjW4bu7usKm8Qv3VT7G0AzADGLTgByWt6YAWonXuV@vger.kernel.org, AJvYcCXMLmp+Fi0I+w5KtQBbrzU4kbS3lZ+H7l9yRkRv0XgYc8Odvbs9rbqbgKrwQcD3zFYS8662hwM3aVx/4Vd0@vger.kernel.org
X-Gm-Message-State: AOJu0YyoP2Zug0IuhXPV9wPqV3pVCt+eGTWThj31e2fP+G0C8QHQGsej
	Pqqhgae4kPzUa8DbGyNUx+lZ9fb8ZdK+YFQ3ixb5Or+KNT2Ys9e1
X-Gm-Gg: ASbGncseJufdNgDoMk3zlm8FEWbySJljsHpMXDo5G1dzCNm3XpzfMkNAkPhU/kqDB+9
	H8kK+9+IfWWGFa5ReD6Sy6LiyspWDZABlZJA5ZimsDX37d4pK3SCFcFu9NT0N9t7UqXBz4WzgP3
	86tkXfO+ZmkYlkroBXWJTTlhirY53otC5G7nU+edI2MRA+tlejAlOfoG1LxQa5QU5iD8vshN0it
	se7vGExcoV/iOOYLELUE6Xp48hy+CVPzNdlATSfEb0s6QndH9aKttRFpWQj8nosHigIqnHZX7vk
	SemhRdV14km6oiRwhWFaHJb6KB+FAsLJWEjPN+XOi9iRAxeS+eP42qqQw4WR7Wu/AkAhQ+x7gy/
	eE1bcgoidKLMfWQ==
X-Google-Smtp-Source: AGHT+IE2QvS+0eDHndAT3qcDfoC0/LVSHDMWAcyRXoT3PVXbEboSiYXTv6Ae8nQJLJ1UY4iDMoIU2Q==
X-Received: by 2002:a05:6000:1fa9:b0:390:fc83:a070 with SMTP id ffacd0b85a97d-39132b64eadmr7308843f8f.0.1741527041191;
        Sun, 09 Mar 2025 06:30:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 02/13] clk: en7523: generalize register clocks function
Date: Sun,  9 Mar 2025 14:29:33 +0100
Message-ID: <20250309132959.19045-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize register clocks function for Airoha EN7523 and EN7581 clocks
driver. The same logic is applied for both clock hence code can be
reduced and simplified by putting the base_clocks struct in the soc_data
and passing that to a generic register clocks function.

There is always the pattern where the last clock is always the PCIe one.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 130 ++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 77 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 314e7450313f..2a74bc8fed24 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -78,8 +78,10 @@ struct en_rst_data {
 
 struct en_clk_soc_data {
 	u32 num_clocks;
+	const struct en_clk_desc *base_clks;
 	const struct clk_ops pcie_ops;
 	int (*hw_init)(struct platform_device *pdev,
+		       const struct en_clk_soc_data *soc_data,
 		       struct clk_hw_onecell_data *clk_data);
 };
 
@@ -467,6 +469,50 @@ static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
 	return &cg->hw;
 }
 
+static void en75xx_register_clocks(struct device *dev,
+				   const struct en_clk_soc_data *soc_data,
+				   struct clk_hw_onecell_data *clk_data,
+				   struct regmap *map, struct regmap *clk_map)
+{
+	struct clk_hw *hw;
+	u32 rate;
+	int i;
+
+	for (i = 0; i < soc_data->num_clocks - 1; i++) {
+		const struct en_clk_desc *desc = &soc_data->base_clks[i];
+		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
+		int err;
+
+		err = regmap_read(map, desc->base_reg, &val);
+		if (err) {
+			pr_err("Failed reading fixed clk rate %s: %d\n",
+			       desc->name, err);
+			continue;
+		}
+		rate = en7523_get_base_rate(desc, val);
+
+		err = regmap_read(map, reg, &val);
+		if (err) {
+			pr_err("Failed reading fixed clk div %s: %d\n",
+			       desc->name, err);
+			continue;
+		}
+		rate /= en7523_get_div(desc, val);
+
+		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %ld\n",
+			       desc->name, PTR_ERR(hw));
+			continue;
+		}
+
+		clk_data->hws[desc->id] = hw;
+	}
+
+	hw = en7523_register_pcie_clk(dev, clk_map);
+	clk_data->hws[soc_data->num_clocks] = hw;
+}
+
 static int en7581_pci_is_enabled(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
@@ -504,38 +550,6 @@ static void en7581_pci_disable(struct clk_hw *hw)
 	usleep_range(1000, 2000);
 }
 
-static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, struct regmap *clk_map)
-{
-	struct clk_hw *hw;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
-		const struct en_clk_desc *desc = &en7523_base_clks[i];
-		u32 reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		u32 val;
-
-		regmap_read(map, desc->base_reg, &val);
-
-		rate = en7523_get_base_rate(desc, val);
-		regmap_read(map, reg, &val);
-		rate /= en7523_get_div(desc, val);
-
-		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       desc->name, PTR_ERR(hw));
-			continue;
-		}
-
-		clk_data->hws[desc->id] = hw;
-	}
-
-	hw = en7523_register_pcie_clk(dev, clk_map);
-	clk_data->hws[EN7523_CLK_PCIE] = hw;
-}
-
 static const struct regmap_config en7523_clk_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -543,6 +557,7 @@ static const struct regmap_config en7523_clk_regmap_config = {
 };
 
 static int en7523_clk_hw_init(struct platform_device *pdev,
+			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	void __iomem *base, *np_base;
@@ -566,53 +581,11 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(clk_map))
 		return PTR_ERR(clk_map);
 
-	en7523_register_clocks(&pdev->dev, clk_data, map, clk_map);
+	en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
 
 	return 0;
 }
 
-static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, struct regmap *clk_map)
-{
-	struct clk_hw *hw;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(en7581_base_clks); i++) {
-		const struct en_clk_desc *desc = &en7581_base_clks[i];
-		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		int err;
-
-		err = regmap_read(map, desc->base_reg, &val);
-		if (err) {
-			pr_err("Failed reading fixed clk rate %s: %d\n",
-			       desc->name, err);
-			continue;
-		}
-		rate = en7523_get_base_rate(desc, val);
-
-		err = regmap_read(map, reg, &val);
-		if (err) {
-			pr_err("Failed reading fixed clk div %s: %d\n",
-			       desc->name, err);
-			continue;
-		}
-		rate /= en7523_get_div(desc, val);
-
-		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       desc->name, PTR_ERR(hw));
-			continue;
-		}
-
-		clk_data->hws[desc->id] = hw;
-	}
-
-	hw = en7523_register_pcie_clk(dev, clk_map);
-	clk_data->hws[EN7523_CLK_PCIE] = hw;
-}
-
 static int en7523_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
@@ -689,6 +662,7 @@ static int en7581_reset_register(struct device *dev, struct regmap *map)
 }
 
 static int en7581_clk_hw_init(struct platform_device *pdev,
+			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *map, *clk_map;
@@ -706,7 +680,7 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(clk_map))
 		return PTR_ERR(clk_map);
 
-	en7581_register_clocks(&pdev->dev, clk_data, map, clk_map);
+	en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
 
 	regmap_clear_bits(clk_map, REG_NP_SCU_SSTR,
 			  REG_PCIE_XSI0_SEL_MASK | REG_PCIE_XSI1_SEL_MASK);
@@ -732,7 +706,7 @@ static int en7523_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk_data->num = soc_data->num_clocks;
-	r = soc_data->hw_init(pdev, clk_data);
+	r = soc_data->hw_init(pdev, soc_data, clk_data);
 	if (r)
 		return r;
 
@@ -740,6 +714,7 @@ static int en7523_clk_probe(struct platform_device *pdev)
 }
 
 static const struct en_clk_soc_data en7523_data = {
+	.base_clks = en7523_base_clks,
 	.num_clocks = ARRAY_SIZE(en7523_base_clks) + 1,
 	.pcie_ops = {
 		.is_enabled = en7523_pci_is_enabled,
@@ -750,6 +725,7 @@ static const struct en_clk_soc_data en7523_data = {
 };
 
 static const struct en_clk_soc_data en7581_data = {
+	.base_clks = en7581_base_clks,
 	/* We increment num_clocks by 1 to account for additional PCIe clock */
 	.num_clocks = ARRAY_SIZE(en7581_base_clks) + 1,
 	.pcie_ops = {
-- 
2.48.1


