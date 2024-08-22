Return-Path: <linux-kernel+bounces-298057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A8695C133
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B57B1F24CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4C1D1F7B;
	Thu, 22 Aug 2024 23:01:10 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934B16F0CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367670; cv=none; b=nlXzs1b1pDpFah7GYCspqBiP2o6BbPpFeEOaRFx/boCqulByd4Qzbd1MJhgoHTlEGu+H1eI0UWOatmkRkMdAjqBjheeCP0MARjxG+djo2puQPbVDJ+DwIYj4mAKklreBdJa6jqzIggieiKocgX4ZdcAv281ztsJvsieTD/sI7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367670; c=relaxed/simple;
	bh=o9eP04ppe1ps9uLIT0yPzNpf73f8VTWXxjhOmWCBkXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlFxtpU3uNpuSOi+coBxuMMEhAmwUEyDT12PBiSaO3ivMV7wNGxetV74M5FKQUDcZG58Ckd4MIvuEB2XbwTTDYXodwWRZopb0i6uIhUon4ugKQ2PZHnxn+VsyUy2nOg+g1swywrwFYj0eC8dl6qCfGeNiXpRF52lnv/m1abvAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 690741d3-60da-11ef-8e3a-005056bd6ce9;
	Fri, 23 Aug 2024 02:01:05 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] pinctrl: renesas: rzg2l: Replace of_node_to_fwnode() with more suitable API
Date: Fri, 23 Aug 2024 02:01:04 +0300
Message-ID: <20240822230104.707812-1-andy.shevchenko@gmail.com>
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
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 5e3d735a8570..73b55e096106 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
@@ -2624,7 +2625,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 
 	girq = &chip->irq;
 	gpio_irq_chip_set_chip(girq, &rzg2l_gpio_irqchip);
-	girq->fwnode = of_node_to_fwnode(np);
+	girq->fwnode = dev_fwnode(pctrl->dev);
 	girq->parent_domain = parent_domain;
 	girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
-- 
2.46.0


