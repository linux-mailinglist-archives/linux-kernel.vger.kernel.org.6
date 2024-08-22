Return-Path: <linux-kernel+bounces-298031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46695C0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFC028433E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976671D1F50;
	Thu, 22 Aug 2024 22:38:51 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D711D0DF2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366331; cv=none; b=nfJNKGxnfumKdXo1A2JbGEWlKrjuqHI2arf1JaE4UJvCH9e52BH2t6BG/n9Ci1/rcviOpkGo2DzSmYymeLmZYpamUjRn+o6ML3CkIwTziHt2U6woYGUdPsFbYldJ2n3dejjHl12bY237VRjsG9lzg5wGCXt0kYw/0d5CIVXc84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366331; c=relaxed/simple;
	bh=e2wtUFAtUu+mNt6Y1Gr4ICp3bhuWwA2uBnfNyg3Li5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALuq1dNiKcZDFoUtr+8w0Hjska6VB/83OkVuKsuQBLyU7ctWgwxLDvK0NoRMRg261baArtmOioAqAc+c/SSIJrEubRwcw7/0xNYCB4FsiGyjkFPXYNQAFWJDGQywRttRs4pd/jjXoKIaN6F90ZhXSN0/zBssWFvTEF/InVjIPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 4b1900e7-60d7-11ef-822f-005056bdfda7;
	Fri, 23 Aug 2024 01:38:46 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] gpio: tegra: Replace of_node_to_fwnode() with more suitable API
Date: Fri, 23 Aug 2024 01:38:45 +0300
Message-ID: <20240822223845.706346-1-andy.shevchenko@gmail.com>
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
 drivers/gpio/gpio-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ea5f9cc14bc4..6d3a39a03f58 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -18,11 +18,12 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/seq_file.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/seq_file.h>
 
 #define GPIO_BANK(x)		((x) >> 5)
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
@@ -755,7 +756,7 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	}
 
 	irq = &tgi->gc.irq;
-	irq->fwnode = of_node_to_fwnode(pdev->dev.of_node);
+	irq->fwnode = dev_fwnode(&pdev->dev);
 	irq->child_to_parent_hwirq = tegra_gpio_child_to_parent_hwirq;
 	irq->populate_parent_alloc_arg = tegra_gpio_populate_parent_fwspec;
 	irq->handler = handle_simple_irq;
-- 
2.46.0


