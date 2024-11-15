Return-Path: <linux-kernel+bounces-410740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED89CE064
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419821F28234
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC61CEAAF;
	Fri, 15 Nov 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG2ZUAjk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E181CDFCE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677892; cv=none; b=tGZQLc00g/XEJJkmANxe8VKS11y5+Nz+7eoEK5gEHo685qhAE54DENzc91KIjeF0XFzcmhpSN3s3Yq6QtxpE0UUA3V+WECQ8Z9HpYPpzZ2F0BcBGzwfatocd8la6rm7i8KRSJ9uAQkXG/eNFayEsbU2hpo5MKPT94zLkp92JtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677892; c=relaxed/simple;
	bh=SaCvmvm1dX7B3GgbWp5rq3frToIghtvV1+crqdVMNyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrK9ZzUk/l2W01sFTaF7WUr+mSoY1/40TLcBiy4KNje1uiAnwEH+o71ag0atVz+2Rv7ObfXmyCs3ysaywTrIG2yQPrJH2ZrnST1X0Tj/hxG+LomSsqLoDcXAZmb1eJClvF6FylN0yv2lW5txUn9VlYkhgVNd29/c+n1movCml8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG2ZUAjk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731677890; x=1763213890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SaCvmvm1dX7B3GgbWp5rq3frToIghtvV1+crqdVMNyw=;
  b=MG2ZUAjkrSbe5OMgC0eQWDUZJ9H33ih1cfIgF+VvgdmdV9Fjc/Nmi/0j
   GGNxm408YHQsSeHvambtBb4VW6QOIs36u/ZRTor9aZVezE2e8CMQwitQs
   J9v/7qYr3FuMMNSYtD6LWPy3gsWDJ8kp/glFygKx5xp35bqip9kHO5v2u
   ponF6DC7R9lEK5FgfY0ovZ5XA5t8fPDduTtui2TaFKjqW5eTMosZxAARQ
   XcCbKlpxW0kIubOTxIaL4J0HyKcSGtjtiUKp5zoZ8l9lc/xs+MMInz7uc
   CYZ1SeERCIeJOjTI/DmG5qJGPDTL5r+R/8M6PwLOAcrOw1e2/DwwXJWWd
   Q==;
X-CSE-ConnectionGUID: naYY/QGVQamiZfpcI+6VkA==
X-CSE-MsgGUID: re2557uYSvGrnmuF6kqT6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49113662"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="49113662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 05:38:08 -0800
X-CSE-ConnectionGUID: 8SgzhYtBSae0467tKzjbaQ==
X-CSE-MsgGUID: nfMsRzJrQGGphTo5MDVWvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="89319831"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 15 Nov 2024 05:38:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8A7F21AC; Fri, 15 Nov 2024 15:38:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v1 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
Date: Fri, 15 Nov 2024 15:38:02 +0200
Message-ID: <20241115133802.3919003-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove legacy-of-mm-gpiochip.h header file, replace of_* functions
and structs with appropriate alternatives.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/8xx/cpm1.c | 119 +++++++++++++++---------------
 1 file changed, 60 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index b24d4102fbf6..1262bff5ba2e 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -45,7 +45,7 @@
 #include <sysdev/fsl_soc.h>
 
 #ifdef CONFIG_8xx_GPIO
-#include <linux/gpio/legacy-of-mm-gpiochip.h>
+#include <linux/gpio/driver.h>
 #endif
 
 #define CPM_MAP_SIZE    (0x4000)
@@ -376,7 +376,8 @@ int __init cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 #ifdef CONFIG_8xx_GPIO
 
 struct cpm1_gpio16_chip {
-	struct of_mm_gpio_chip mm_gc;
+	struct gpio_chip gc;
+	void __iomem *regs;
 	spinlock_t lock;
 
 	/* shadowed data register to clear/set bits safely */
@@ -386,19 +387,17 @@ struct cpm1_gpio16_chip {
 	int irq[16];
 };
 
-static void cpm1_gpio16_save_regs(struct of_mm_gpio_chip *mm_gc)
+static void cpm1_gpio16_save_regs(struct cpm1_gpio16_chip *cpm1_gc)
 {
-	struct cpm1_gpio16_chip *cpm1_gc =
-		container_of(mm_gc, struct cpm1_gpio16_chip, mm_gc);
-	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
 
 	cpm1_gc->cpdata = in_be16(&iop->dat);
 }
 
 static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
 	u16 pin_mask;
 
 	pin_mask = 1 << (15 - gpio);
@@ -406,11 +405,9 @@ static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
 	return !!(in_be16(&iop->dat) & pin_mask);
 }
 
-static void __cpm1_gpio16_set(struct of_mm_gpio_chip *mm_gc, u16 pin_mask,
-	int value)
+static void __cpm1_gpio16_set(struct cpm1_gpio16_chip *cpm1_gc, u16 pin_mask, int value)
 {
-	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
-	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
 
 	if (value)
 		cpm1_gc->cpdata |= pin_mask;
@@ -422,38 +419,35 @@ static void __cpm1_gpio16_set(struct of_mm_gpio_chip *mm_gc, u16 pin_mask,
 
 static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
 	unsigned long flags;
 	u16 pin_mask = 1 << (15 - gpio);
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
-	__cpm1_gpio16_set(mm_gc, pin_mask, value);
+	__cpm1_gpio16_set(cpm1_gc, pin_mask, value);
 
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 }
 
 static int cpm1_gpio16_to_irq(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
 
 	return cpm1_gc->irq[gpio] ? : -ENXIO;
 }
 
 static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
-	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
 	unsigned long flags;
 	u16 pin_mask = 1 << (15 - gpio);
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
 	setbits16(&iop->dir, pin_mask);
-	__cpm1_gpio16_set(mm_gc, pin_mask, val);
+	__cpm1_gpio16_set(cpm1_gc, pin_mask, val);
 
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 
@@ -462,9 +456,8 @@ static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
-	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
+	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
 	unsigned long flags;
 	u16 pin_mask = 1 << (15 - gpio);
 
@@ -481,11 +474,10 @@ int cpm1_gpiochip_add16(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct cpm1_gpio16_chip *cpm1_gc;
-	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
 	u16 mask;
 
-	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
+	cpm1_gc = devm_kzalloc(dev, sizeof(*cpm1_gc), GFP_KERNEL);
 	if (!cpm1_gc)
 		return -ENOMEM;
 
@@ -499,10 +491,8 @@ int cpm1_gpiochip_add16(struct device *dev)
 				cpm1_gc->irq[i] = irq_of_parse_and_map(np, j++);
 	}
 
-	mm_gc = &cpm1_gc->mm_gc;
-	gc = &mm_gc->gc;
-
-	mm_gc->save_regs = cpm1_gpio16_save_regs;
+	gc = &cpm1_gc->gc;
+	gc->base = -1;
 	gc->ngpio = 16;
 	gc->direction_input = cpm1_gpio16_dir_in;
 	gc->direction_output = cpm1_gpio16_dir_out;
@@ -512,30 +502,39 @@ int cpm1_gpiochip_add16(struct device *dev)
 	gc->parent = dev;
 	gc->owner = THIS_MODULE;
 
-	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
+	g->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
+	if (!gc->label)
+		return -ENOMEM;
+
+	cpm1_gc->regs = devm_of_iomap(dev, np, 0);
+	if (IS_ERR(cpm1_gc->regs))
+		return PTR_ERR(cpm1_gc->regs);
+
+	cpm1_gpio16_save_regs(cpm1_gc);
+
+	return devm_gpiochip_add_data(dev, gc, cpm1_gc);
 }
 
 struct cpm1_gpio32_chip {
-	struct of_mm_gpio_chip mm_gc;
+	struct gpio_chip gc;
+	void __iomem *regs;
 	spinlock_t lock;
 
 	/* shadowed data register to clear/set bits safely */
 	u32 cpdata;
 };
 
-static void cpm1_gpio32_save_regs(struct of_mm_gpio_chip *mm_gc)
+static void cpm1_gpio32_save_regs(struct cpm1_gpio32_chip *cpm1_gc)
 {
-	struct cpm1_gpio32_chip *cpm1_gc =
-		container_of(mm_gc, struct cpm1_gpio32_chip, mm_gc);
-	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
 
 	cpm1_gc->cpdata = in_be32(&iop->dat);
 }
 
 static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
 	u32 pin_mask;
 
 	pin_mask = 1 << (31 - gpio);
@@ -543,11 +542,9 @@ static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
 	return !!(in_be32(&iop->dat) & pin_mask);
 }
 
-static void __cpm1_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
-	int value)
+static void __cpm1_gpio32_set(cpm1_gpio32_chip *cpm1_gc, u32 pin_mask, int value)
 {
-	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
-	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
 
 	if (value)
 		cpm1_gc->cpdata |= pin_mask;
@@ -559,30 +556,28 @@ static void __cpm1_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
 
 static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
+	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
 	unsigned long flags;
 	u32 pin_mask = 1 << (31 - gpio);
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
-	__cpm1_gpio32_set(mm_gc, pin_mask, value);
+	__cpm1_gpio32_set(cpm1_gc, pin_mask, value);
 
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 }
 
 static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
-	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
 	unsigned long flags;
 	u32 pin_mask = 1 << (31 - gpio);
 
 	spin_lock_irqsave(&cpm1_gc->lock, flags);
 
 	setbits32(&iop->dir, pin_mask);
-	__cpm1_gpio32_set(mm_gc, pin_mask, val);
+	__cpm1_gpio32_set(cpm1_gc, pin_mask, val);
 
 	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
 
@@ -591,9 +586,8 @@ static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
-	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
+	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
+	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
 	unsigned long flags;
 	u32 pin_mask = 1 << (31 - gpio);
 
@@ -610,19 +604,16 @@ int cpm1_gpiochip_add32(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct cpm1_gpio32_chip *cpm1_gc;
-	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
 
-	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
+	cpm1_gc = devm_kzalloc(dev, sizeof(*cpm1_gc), GFP_KERNEL);
 	if (!cpm1_gc)
 		return -ENOMEM;
 
 	spin_lock_init(&cpm1_gc->lock);
 
-	mm_gc = &cpm1_gc->mm_gc;
-	gc = &mm_gc->gc;
-
-	mm_gc->save_regs = cpm1_gpio32_save_regs;
+	gc = &cpm1_gc->gc;
+	gc->base = -1;
 	gc->ngpio = 32;
 	gc->direction_input = cpm1_gpio32_dir_in;
 	gc->direction_output = cpm1_gpio32_dir_out;
@@ -631,7 +622,17 @@ int cpm1_gpiochip_add32(struct device *dev)
 	gc->parent = dev;
 	gc->owner = THIS_MODULE;
 
-	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
+	g->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
+	if (!gc->label)
+		return -ENOMEM;
+
+	cpm1_gc->regs = devm_of_iomap(dev, np, 0);
+	if (IS_ERR(cpm1_gc->regs))
+		return PTR_ERR(cpm1_gc->regs);
+
+	cpm1_gpio32_save_regs(cpm1_gc);
+
+	return devm_gpiochip_add_data(dev, gc, cpm1_gc);
 }
 
 #endif /* CONFIG_8xx_GPIO */
-- 
2.43.0.rc1.1336.g36b5255a03ac


