Return-Path: <linux-kernel+bounces-215365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0237D9091E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96CFB2CC39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F01A3BAA;
	Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cRIZAOXg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B59441;
	Fri, 14 Jun 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386376; cv=none; b=bExMprCb+M5yKDGF074d/1+3sDVr/Brd/a4al2fNeLv+gAMzN74UeWxM2FHXtZLfIKtDgLCgms8k6nnOtaKvb2LFVqeczvsH2YsXngi8DIjXYokjt7Ri/zGVWYCxRfS2s9ddTcPgEjMF5/Ef1qv6kfhfHq6cvh73jvgS1tCEibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386376; c=relaxed/simple;
	bh=/ER7RFnsECePgycnpBvxgQSi9xp5nquXO0VPYvWjKBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuZdP0I9jnNkvkczv9pUP8m0MnnY4Ue3Uw12wnFQiBqLXomvoL3JeaeepqOCV9O8XTK0CoGs5Id73xSRwlA/LvUpNk4UffJPu2QAJT5+y34eGF4tjZZPMq80rXGm67QrlQNdhqoNUtOTojfONkJRidFNKmKx6fRDJT435Jx4OZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cRIZAOXg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 9BC49FF804;
	Fri, 14 Jun 2024 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ca0pykPy27OXtm3bTG0aktosDK2ivFUX0Gy7JXRbMjQ=;
	b=cRIZAOXg+a9QOqYi/VkNDf12QOxTHNPKQl2zgBXY2dknlLg+ibAI5834xtU9Ypmi7kPyyc
	2XcfKB5c+IT1gz/ZF6vsZh2IMwyk8YTJhC79FMG6wVh6/AVFC8nsWqlbB7pZhcAgvIH/cY
	+4DZvDgoFN5qI7eHFqIHWoDgwjkiegBCYaM6kasGVP5nI/HmKvJklqn6EoZxzZCUQb42gB
	c8PJNtw4RZ64ff0j/x42FguU7YEEBOcG2I4jzjavfC/hrSzK2oxwmbCUM2dvAkkZjHniNw
	8q9tYcirf0px5FiQWUpnvJ2CA8GEj+A24yzvLI01OXJG+RWxRdSRJ0UvDvb5Ng==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 02/23] irqdomain: Introduce irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:03 +0200
Message-ID: <20240614173232.1184015-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The existing irq_domain_add_*() functions used to instantiate an IRQ
domain are wrappers built on top of __irq_domain_add() and describes the
domain properties using a bunch of parameters.

Adding more parameters and wrappers to hide new parameters in the
existing code lead to more and more code without any relevant values and
without any flexibility.

Introduce irq_domain_instantiate() where the IRQ domain properties are
given using the irq_domain_info structure instead of the bunch of
parameters to allow flexibility and easy evolution.

This new irq_domain_instantiate() perform the same operation as the one
done by __irq_domain_add(). For compatibility reason with existing code,
keep __irq_domain_add() but convert it to irq_domain_instantiate().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 21 +++++++++++++++++++++
 kernel/irq/irqdomain.c    | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 21ecf582a0fe..ab8939c8724d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -257,6 +257,27 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+/**
+ * struct irq_domain_info - Domain information structure
+ * @fwnode:		firmware node for the interrupt controller
+ * @size:		Size of linear map; 0 for radix mapping only
+ * @hwirq_max:		Maximum number of interrupts supported by controller
+ * @direct_max:		Maximum value of direct maps;
+ *			Use ~0 for no limit; 0 for no direct mapping
+ * @ops:		Domain operation callbacks
+ * @host_data:		Controller private data pointer
+ */
+struct irq_domain_info {
+	struct fwnode_handle			*fwnode;
+	unsigned int				size;
+	irq_hw_number_t				hwirq_max;
+	int					direct_max;
+	const struct irq_domain_ops		*ops;
+	void					*host_data;
+};
+
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
+
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 95eda206367f..012ada09b419 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -250,6 +250,27 @@ static void irq_domain_free(struct irq_domain *domain)
 	kfree(domain);
 }
 
+/**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+
+	domain = __irq_domain_create(info->fwnode, info->size, info->hwirq_max,
+				     info->direct_max, info->ops, info->host_data);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	__irq_domain_publish(domain);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(irq_domain_instantiate);
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
@@ -268,14 +289,18 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
-	struct irq_domain *domain;
-
-	domain = __irq_domain_create(fwnode, size, hwirq_max, direct_max,
-				     ops, host_data);
-	if (domain)
-		__irq_domain_publish(domain);
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = hwirq_max,
+		.direct_max = direct_max,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
 
-	return domain;
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 EXPORT_SYMBOL_GPL(__irq_domain_add);
 
-- 
2.45.0


