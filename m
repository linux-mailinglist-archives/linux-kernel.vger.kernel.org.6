Return-Path: <linux-kernel+bounces-567597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6BBA6882B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068EB7A7E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F61258CE1;
	Wed, 19 Mar 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0kwKlwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A936254AF5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376724; cv=none; b=aFHXQpk1ux6kVunnC1posxYIbq6vBEKL3w2zCFFML0nbblvDrML2Av9/wpjpE1PyCt2BddwZh8H1gtbSRvvBphq0SyIR5bwI3BQWLlG9Y07/xKIcg2o0Y/+rhN98Ref/ASlvm34mE9B7QDdmyBux2jBtSJgl2Qmz7FL29RyVUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376724; c=relaxed/simple;
	bh=5VJv2nEcmxeqP/NoN8miVJO7VItSA++SbGsff9FKovQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/jQfCAeIdk98Xbhd6B9nWaooiFNktQhWNdji3bycrNDzTvjaPjFiOkw8NVkvVyqa9TXX5SkvDHbs56SS4yJaxw+g0DVPDy9SATBTUpDx4UX54Ef0lhRlZJCFmkaXVU0VrEaRpP2KwyDFzBLFkpQ1u4ItmroBXLNwl/VXpqOgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0kwKlwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C6C4CEEF;
	Wed, 19 Mar 2025 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376723;
	bh=5VJv2nEcmxeqP/NoN8miVJO7VItSA++SbGsff9FKovQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0kwKlwhAFiYp+QIzDqYKAV+zNoCzdZRKivcZr7gpckEbP6cByeoef0vgPDlrUQis
	 EzfUi6sqO1U557RqfZ8TFTKjaCTrauvYTG5ChGdQABMYX6Wjirg/ZLpbk80vtZATTJ
	 t5CvRSKhxenzo9OKjh6mQ8tRQFRzhblNYOShijdaYmtjNaiw1xhf872Vig7kcrhSdM
	 tJyVPJD5A4d8I3nzZScUeUwBKaKWc1qIUB1lDmYf4Feoi3jMBcMYO0iuxrTngOz+T1
	 utxCDQ24aRDdd6snfgMdOFF6gvZiFhrWzKO2Eljs0o3YVqCJLp2dWmQhtbxGZA2Khw
	 U+P6fUOMGus+g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 24/57] irqdomain: mfd: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:17 +0100
Message-ID: <20250319092951.37667-25-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/88pm860x-core.c   |  4 ++--
 drivers/mfd/ab8500-core.c     |  6 +++---
 drivers/mfd/arizona-irq.c     |  3 +--
 drivers/mfd/db8500-prcmu.c    |  6 +++---
 drivers/mfd/fsl-imx25-tsadc.c |  5 ++---
 drivers/mfd/lp8788-irq.c      |  2 +-
 drivers/mfd/max8925-core.c    |  4 ++--
 drivers/mfd/max8997-irq.c     |  4 ++--
 drivers/mfd/max8998-irq.c     |  2 +-
 drivers/mfd/mt6358-irq.c      |  6 +++---
 drivers/mfd/mt6397-irq.c      |  6 ++----
 drivers/mfd/qcom-pm8xxx.c     |  6 ++----
 drivers/mfd/stmfx.c           |  2 +-
 drivers/mfd/stmpe.c           |  4 ++--
 drivers/mfd/tc3589x.c         |  6 +++---
 drivers/mfd/tps65217.c        |  2 +-
 drivers/mfd/tps6586x.c        |  2 +-
 drivers/mfd/twl4030-irq.c     |  4 ++--
 drivers/mfd/twl6030-irq.c     |  5 ++---
 drivers/mfd/wm831x-irq.c      | 15 ++++++---------
 drivers/mfd/wm8994-irq.c      |  4 +---
 21 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 8e68b64bd7f8..488e346047c1 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -624,8 +624,8 @@ static int device_irq_init(struct pm860x_chip *chip,
 		ret = -EBUSY;
 		goto out;
 	}
-	irq_domain_add_legacy(node, nr_irqs, chip->irq_base, 0,
-			      &pm860x_irq_domain_ops, chip);
+	irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, chip->irq_base, 0,
+				 &pm860x_irq_domain_ops, chip);
 	chip->core_irq = i2c->irq;
 	if (!chip->core_irq)
 		goto out;
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 15c95828b09a..049abcbd71ce 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -580,9 +580,9 @@ static int ab8500_irq_init(struct ab8500 *ab8500, struct device_node *np)
 		num_irqs = AB8500_NR_IRQS;
 
 	/* If ->irq_base is zero this will give a linear mapping */
-	ab8500->domain = irq_domain_add_simple(ab8500->dev->of_node,
-					       num_irqs, 0,
-					       &ab8500_irq_ops, ab8500);
+	ab8500->domain = irq_domain_create_simple(of_fwnode_handle(ab8500->dev->of_node),
+						  num_irqs, 0,
+						  &ab8500_irq_ops, ab8500);
 
 	if (!ab8500->domain) {
 		dev_err(ab8500->dev, "Failed to create irqdomain\n");
diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
index d919ae9691e2..ac2139597fab 100644
--- a/drivers/mfd/arizona-irq.c
+++ b/drivers/mfd/arizona-irq.c
@@ -312,8 +312,7 @@ int arizona_irq_init(struct arizona *arizona)
 	flags |= arizona->pdata.irq_flags;
 
 	/* Allocate a virtual IRQ domain to distribute to the regmap domains */
-	arizona->virq = irq_domain_add_linear(NULL, 2, &arizona_domain_ops,
-					      arizona);
+	arizona->virq = irq_domain_create_linear(NULL, 2, &arizona_domain_ops, arizona);
 	if (!arizona->virq) {
 		dev_err(arizona->dev, "Failed to add core IRQ domain\n");
 		ret = -EINVAL;
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5b3e355e78f6..21e68a382b11 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2607,9 +2607,9 @@ static int db8500_irq_init(struct device_node *np)
 {
 	int i;
 
-	db8500_irq_domain = irq_domain_add_simple(
-		np, NUM_PRCMU_WAKEUPS, 0,
-		&db8500_irq_ops, NULL);
+	db8500_irq_domain = irq_domain_create_simple(of_fwnode_handle(np),
+						     NUM_PRCMU_WAKEUPS, 0,
+						     &db8500_irq_ops, NULL);
 
 	if (!db8500_irq_domain) {
 		pr_err("Failed to create irqdomain\n");
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 6fe388da6fb6..d47152467951 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -65,15 +65,14 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
 				struct mx25_tsadc *tsadc)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
-					      tsadc);
+	tsadc->domain = irq_domain_create_simple(of_fwnode_handle(dev->of_node), 2, 0,
+						 &mx25_tsadc_domain_ops, tsadc);
 	if (!tsadc->domain) {
 		dev_err(dev, "Failed to add irq domain\n");
 		return -ENOMEM;
diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
index 39006297f3d2..ea0fdf7a4b6e 100644
--- a/drivers/mfd/lp8788-irq.c
+++ b/drivers/mfd/lp8788-irq.c
@@ -161,7 +161,7 @@ int lp8788_irq_init(struct lp8788 *lp, int irq)
 		return -ENOMEM;
 
 	irqd->lp = lp;
-	irqd->domain = irq_domain_add_linear(lp->dev->of_node, LP8788_INT_MAX,
+	irqd->domain = irq_domain_create_linear(of_fwnode_handle(lp->dev->of_node), LP8788_INT_MAX,
 					&lp8788_domain_ops, irqd);
 	if (!irqd->domain) {
 		dev_err(lp->dev, "failed to add irq domain err\n");
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 105d79b91493..78b16c67a5fc 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -682,8 +682,8 @@ static int max8925_irq_init(struct max8925_chip *chip, int irq,
 		return -EBUSY;
 	}
 
-	irq_domain_add_legacy(node, MAX8925_NR_IRQS, chip->irq_base, 0,
-			      &max8925_irq_domain_ops, chip);
+	irq_domain_create_legacy(of_fwnode_handle(node), MAX8925_NR_IRQS, chip->irq_base, 0,
+				 &max8925_irq_domain_ops, chip);
 
 	/* request irq handler for pmic main irq*/
 	chip->core_irq = irq;
diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
index 92e348df03d1..cc87571c9af5 100644
--- a/drivers/mfd/max8997-irq.c
+++ b/drivers/mfd/max8997-irq.c
@@ -327,8 +327,8 @@ int max8997_irq_init(struct max8997_dev *max8997)
 					true : false;
 	}
 
-	domain = irq_domain_add_linear(NULL, MAX8997_IRQ_NR,
-					&max8997_irq_domain_ops, max8997);
+	domain = irq_domain_create_linear(NULL, MAX8997_IRQ_NR,
+					  &max8997_irq_domain_ops, max8997);
 	if (!domain) {
 		dev_err(max8997->dev, "could not create irq domain\n");
 		return -ENODEV;
diff --git a/drivers/mfd/max8998-irq.c b/drivers/mfd/max8998-irq.c
index 83b6f510bc05..b0773fa6e07f 100644
--- a/drivers/mfd/max8998-irq.c
+++ b/drivers/mfd/max8998-irq.c
@@ -230,7 +230,7 @@ int max8998_irq_init(struct max8998_dev *max8998)
 	max8998_write_reg(max8998->i2c, MAX8998_REG_STATUSM1, 0xff);
 	max8998_write_reg(max8998->i2c, MAX8998_REG_STATUSM2, 0xff);
 
-	domain = irq_domain_add_simple(NULL, MAX8998_IRQ_NR,
+	domain = irq_domain_create_simple(NULL, MAX8998_IRQ_NR,
 			max8998->irq_base, &max8998_irq_domain_ops, max8998);
 	if (!domain) {
 		dev_err(max8998->dev, "could not create irq domain\n");
diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index 49830b526ee8..9f0bcc3ad7a1 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -272,9 +272,9 @@ int mt6358_irq_init(struct mt6397_chip *chip)
 				     irqd->pmic_ints[i].en_reg_shift * j, 0);
 	}
 
-	chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
-						 irqd->num_pmic_irqs,
-						 &mt6358_irq_domain_ops, chip);
+	chip->irq_domain = irq_domain_create_linear(of_fwnode_handle(chip->dev->of_node),
+						    irqd->num_pmic_irqs,
+						    &mt6358_irq_domain_ops, chip);
 	if (!chip->irq_domain) {
 		dev_err(chip->dev, "Could not create IRQ domain\n");
 		return -ENODEV;
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 1310665200ed..badc614b4345 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -216,10 +216,8 @@ int mt6397_irq_init(struct mt6397_chip *chip)
 		regmap_write(chip->regmap, chip->int_con[2], 0x0);
 
 	chip->pm_nb.notifier_call = mt6397_irq_pm_notifier;
-	chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
-						 MT6397_IRQ_NR,
-						 &mt6397_irq_domain_ops,
-						 chip);
+	chip->irq_domain = irq_domain_create_linear(of_fwnode_handle(chip->dev->of_node),
+						    MT6397_IRQ_NR, &mt6397_irq_domain_ops, chip);
 	if (!chip->irq_domain) {
 		dev_err(chip->dev, "could not create irq domain\n");
 		return -ENOMEM;
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index f9ebdf5845b8..c96ea6fbede8 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -559,10 +559,8 @@ static int pm8xxx_probe(struct platform_device *pdev)
 	chip->pm_irq_data = data;
 	spin_lock_init(&chip->pm_irq_lock);
 
-	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
-						data->num_irqs,
-						&pm8xxx_irq_domain_ops,
-						chip);
+	chip->irqdomain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
+						   data->num_irqs, &pm8xxx_irq_domain_ops, chip);
 	if (!chip->irqdomain)
 		return -ENODEV;
 
diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index f391c2ccaa72..823b1d29389e 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -269,7 +269,7 @@ static int stmfx_irq_init(struct i2c_client *client)
 	u32 irqoutpin = 0, irqtrigger;
 	int ret;
 
-	stmfx->irq_domain = irq_domain_add_simple(stmfx->dev->of_node,
+	stmfx->irq_domain = irq_domain_create_simple(of_fwnode_handle(stmfx->dev->of_node),
 						  STMFX_REG_IRQ_SRC_MAX, 0,
 						  &stmfx_irq_ops, stmfx);
 	if (!stmfx->irq_domain) {
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 9c3cf58457a7..819d19dc9b4a 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1219,8 +1219,8 @@ static int stmpe_irq_init(struct stmpe *stmpe, struct device_node *np)
 	int base = 0;
 	int num_irqs = stmpe->variant->num_irqs;
 
-	stmpe->domain = irq_domain_add_simple(np, num_irqs, base,
-					      &stmpe_irq_ops, stmpe);
+	stmpe->domain = irq_domain_create_simple(of_fwnode_handle(np), num_irqs,
+						 base, &stmpe_irq_ops, stmpe);
 	if (!stmpe->domain) {
 		dev_err(stmpe->dev, "Failed to create irqdomain\n");
 		return -ENOSYS;
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index ef953ee73145..2d4eb771e230 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -234,9 +234,9 @@ static const struct irq_domain_ops tc3589x_irq_ops = {
 
 static int tc3589x_irq_init(struct tc3589x *tc3589x, struct device_node *np)
 {
-	tc3589x->domain = irq_domain_add_simple(
-		np, TC3589x_NR_INTERNAL_IRQS, 0,
-		&tc3589x_irq_ops, tc3589x);
+	tc3589x->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						   TC3589x_NR_INTERNAL_IRQS, 0,
+						   &tc3589x_irq_ops, tc3589x);
 
 	if (!tc3589x->domain) {
 		dev_err(tc3589x->dev, "Failed to create irqdomain\n");
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 029ecc32f078..4e9669d327b4 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -158,7 +158,7 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
 			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
 
-	tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
+	tps->irq_domain = irq_domain_create_linear(of_fwnode_handle(tps->dev->of_node),
 		TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
 	if (!tps->irq_domain) {
 		dev_err(tps->dev, "Could not create IRQ domain\n");
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 82714899efb2..853c48286071 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -363,7 +363,7 @@ static int tps6586x_irq_init(struct tps6586x *tps6586x, int irq,
 		new_irq_base = 0;
 	}
 
-	tps6586x->irq_domain = irq_domain_add_simple(tps6586x->dev->of_node,
+	tps6586x->irq_domain = irq_domain_create_simple(of_fwnode_handle(tps6586x->dev->of_node),
 				irq_num, new_irq_base, &tps6586x_domain_ops,
 				tps6586x);
 	if (!tps6586x->irq_domain) {
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 87496c1cb8bc..232c2bfe8c18 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -691,8 +691,8 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 		return irq_base;
 	}
 
-	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
-			      &irq_domain_simple_ops, NULL);
+	irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, irq_base, 0,
+				 &irq_domain_simple_ops, NULL);
 
 	irq_end = irq_base + TWL4030_CORE_NR_IRQS;
 
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 3c03681c124c..00b14cef1dfb 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -364,7 +364,6 @@ static const struct of_device_id twl6030_of_match[] __maybe_unused = {
 
 int twl6030_init_irq(struct device *dev, int irq_num)
 {
-	struct			device_node *node = dev->of_node;
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
@@ -412,8 +411,8 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	twl6030_irq->irq_mapping_tbl = of_id->data;
 
 	twl6030_irq->irq_domain =
-		irq_domain_add_linear(node, nr_irqs,
-				      &twl6030_irq_domain_ops, twl6030_irq);
+		irq_domain_create_linear(of_fwnode_handle(dev->of_node), nr_irqs,
+					 &twl6030_irq_domain_ops, twl6030_irq);
 	if (!twl6030_irq->irq_domain) {
 		dev_err(dev, "Can't add irq_domain\n");
 		return -ENOMEM;
diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index f1f58e3149ae..b3883fa5dd9f 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -587,16 +587,13 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)
 	}
 
 	if (irq_base)
-		domain = irq_domain_add_legacy(wm831x->dev->of_node,
-					       ARRAY_SIZE(wm831x_irqs),
-					       irq_base, 0,
-					       &wm831x_irq_domain_ops,
-					       wm831x);
+		domain = irq_domain_create_legacy(of_fwnode_handle(wm831x->dev->of_node),
+						  ARRAY_SIZE(wm831x_irqs), irq_base, 0,
+						  &wm831x_irq_domain_ops, wm831x);
 	else
-		domain = irq_domain_add_linear(wm831x->dev->of_node,
-					       ARRAY_SIZE(wm831x_irqs),
-					       &wm831x_irq_domain_ops,
-					       wm831x);
+		domain = irq_domain_create_linear(of_fwnode_handle(wm831x->dev->of_node),
+						  ARRAY_SIZE(wm831x_irqs), &wm831x_irq_domain_ops,
+						  wm831x);
 
 	if (!domain) {
 		dev_warn(wm831x->dev, "Failed to allocate IRQ domain\n");
diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index 651a028bc519..1475b1ac6983 100644
--- a/drivers/mfd/wm8994-irq.c
+++ b/drivers/mfd/wm8994-irq.c
@@ -213,9 +213,7 @@ int wm8994_irq_init(struct wm8994 *wm8994)
 			return ret;
 		}
 
-		wm8994->edge_irq = irq_domain_add_linear(NULL, 1,
-							 &wm8994_edge_irq_ops,
-							 wm8994);
+		wm8994->edge_irq = irq_domain_create_linear(NULL, 1, &wm8994_edge_irq_ops, wm8994);
 
 		ret = regmap_add_irq_chip(wm8994->regmap,
 					  irq_create_mapping(wm8994->edge_irq,
-- 
2.49.0


