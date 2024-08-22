Return-Path: <linux-kernel+bounces-298055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA3D95C12C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B30B2432A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6A1D1F57;
	Thu, 22 Aug 2024 22:56:37 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3418308A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367396; cv=none; b=WRfidfRNdHGSBfLFj9FCgtDv2F5srS4B5ZLtAKH5Z3f23XC1xlWv8Eex3xhxIXJu/1RrY/p1E3pIE63f8avxSAwVxPSzktts2pt5qIJ/sPjj9lD4z/zC1taAlS0nqqdMxk7N/vlqhnUqcf2ZTOwqyrfFp6TkMZPykUp9n13J1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367396; c=relaxed/simple;
	bh=kydB5gAR1qt/Mq0WG6CTYE3LCD6Nj2jl2gXbb9SCuQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o60lMQWDhc1TpBtU7Mwy9qq1KgBP+B40vcpd9pjkVNyVGPqONdAo5CODj3s0fdUa7p6zyamDnx6me0VBkzLnCzvsMn1yxQEWYjP9RHeybnsKrZ7+EBSFRbs5LRCXHJ3xPTB0bAz6k9HomWiR2gUJ1KAM75cgjgrl1sno6FFGMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id c5724119-60d9-11ef-822f-005056bdfda7;
	Fri, 23 Aug 2024 01:56:31 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] gpio: uniphier: Replace of_node_to_fwnode() with more suitable API
Date: Fri, 23 Aug 2024 01:56:29 +0300
Message-ID: <20240822225629.707365-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_node_to_fwnode() is a IRQ domain specific implementation of
of_fwnode_handle(). Replace the former with more suitable API.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-uniphier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 1f440707f8f4..da99ba13e82d 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
@@ -164,7 +165,7 @@ static int uniphier_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 	if (offset < UNIPHIER_GPIO_IRQ_OFFSET)
 		return -ENXIO;
 
-	fwspec.fwnode = of_node_to_fwnode(chip->parent->of_node);
+	fwspec.fwnode = dev_fwnode(chip->parent);
 	fwspec.param_count = 2;
 	fwspec.param[0] = offset - UNIPHIER_GPIO_IRQ_OFFSET;
 	/*
@@ -404,7 +405,7 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
 	priv->domain = irq_domain_create_hierarchy(
 					parent_domain, 0,
 					UNIPHIER_GPIO_IRQ_MAX_NUM,
-					of_node_to_fwnode(dev->of_node),
+					dev_fwnode(dev),
 					&uniphier_gpio_irq_domain_ops, priv);
 	if (!priv->domain)
 		return -ENOMEM;
-- 
2.46.0


