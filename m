Return-Path: <linux-kernel+bounces-298056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837295C12E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36D61F25197
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A51D1F58;
	Thu, 22 Aug 2024 22:58:24 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324B18308A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367504; cv=none; b=SIHx9o3VAxQkfX5yXe4moAGHzrPxv/XWC5OWDGZwhjYVD45uzvvYD1NqJd7vdgHUOqzbwzsBpBZP4tjXw1hjNRjuwdtnxaWFl3GyPal3f/9BTRjJZTeiocaYMA3qLitldFvodeziiSuT9hcA4BymU4YPv5IVMPkm9AzH+0Djhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367504; c=relaxed/simple;
	bh=XP59DpnvPpz3OTugVZRRK2XvnbQkKUHgfixv7fVy6R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbPlL/mo107IJYbYtYuC1XFxgipS9n2Hx5p7rlKUIO/wovMRb2wi8gVdvkrxkd55PT7QluFBB6Dea5+DWcPHBhufJlfunhRi1iMoxiVxPj9Uv4GyFMYLWivn64Y/W939npfN60JbYBW/an21Rh1ou6vj5nykYoPqeWRvLJbstoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 0605c0c0-60da-11ef-822f-005056bdfda7;
	Fri, 23 Aug 2024 01:58:19 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v1 1/1] gpio: visconti: Replace of_node_to_fwnode() with more suitable API
Date: Fri, 23 Aug 2024 01:58:18 +0300
Message-ID: <20240822225818.707550-1-andy.shevchenko@gmail.com>
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
 drivers/gpio/gpio-visconti.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index 6734e7e1e2a4..ebc71ecdb6cf 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -8,6 +8,7 @@
  * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
  */
 
+#include <linux/bitops.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -15,8 +16,8 @@
 #include <linux/io.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
-#include <linux/bitops.h>
 
 /* register offset */
 #define GPIO_DIR	0x00
@@ -202,7 +203,7 @@ static int visconti_gpio_probe(struct platform_device *pdev)
 
 	girq = &priv->gpio_chip.irq;
 	gpio_irq_chip_set_chip(girq, &visconti_gpio_irq_chip);
-	girq->fwnode = of_node_to_fwnode(dev->of_node);
+	girq->fwnode = dev_fwnode(dev);
 	girq->parent_domain = parent;
 	girq->child_to_parent_hwirq = visconti_gpio_child_to_parent_hwirq;
 	girq->populate_parent_alloc_arg = visconti_gpio_populate_parent_fwspec;
-- 
2.46.0


