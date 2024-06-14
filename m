Return-Path: <linux-kernel+bounces-215362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01D909196
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E845828D82F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DFC19EEBF;
	Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QOXUQncZ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157E19DF58;
	Fri, 14 Jun 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386374; cv=none; b=rEG2/9TIzHlv7fvPo5fGZXJ/YMLLfzTQoqX9/VuqbZRiPzsyA3erEFbDl8m4Zx5S3SC48OTPqQl7ch3q83WFYPsRD94xeogJmwx2TLt+iFYJcV2jgIQetxCPPtTxzGdAFqi09hclrUi57ms+ZHgXz1d3axErzjb3pMhwadJF2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386374; c=relaxed/simple;
	bh=yb2LMuPsZMTzsBXPHdT8is7Lp6RxhR9frz8vdpQRO2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY7DaxTqGNiYrggwCzBLsHrb/Ya8uzsJaRK/3m+dMUyKb2C7x5GzFZNHRg6alP9zloSXBM1sr5rEbFv/dYmah2KM0tvjqf2zm7BdMPF8k3NMKHWLjdDdzkbOPFc0h3tDdwH5nYoq/68Ll8gfg5D8WbCvC5ErpLoryLqh11FZyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QOXUQncZ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 683FFFF80A;
	Fri, 14 Jun 2024 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDaB47WOjYw+Y1hfwmwgGI9KoC30S0XrnbD9FfSrUiI=;
	b=QOXUQncZrkWjeNSF9gf5Fnuw/j8AWhnmkrsiFgkvnP7X3OzKRFVvwohRTG8VQbtlTTyHLP
	gqWrZsvRkJsbmQ9krt7jebcRv7rCIOkQGRlAKUUMqft2AfTdBNrEb/8hvxhHNErdPT5uyY
	V0fqpn8SyxlUtx+U8hNftQ+GYxD8HQY6r44o2eHwDBRDvEZG2UXD9ky3mwpxkC9GpKuJ2E
	ytoXUH8DPFBPuWz081iPhs7oFYzIVYe60z2UA+4LKnSHzTeSXVBCds9LznQWFFp5JRyPnE
	8fejBsGIUB9lVcmXwNzpp+ugxNR+CRNLSevuRTsh3eSoTG3i1NK0452fTBpUpA==
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
Subject: [PATCH 06/23] irqdomain: Convert __irq_domain_create() to use struct irq_domain_info
Date: Fri, 14 Jun 2024 19:32:07 +0200
Message-ID: <20240614173232.1184015-7-herve.codina@bootlin.com>
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

The existing __irq_domain_create() use a bunch of parameters to create
an irq domain.

With the introduction of irq_domain_info structure, these parameters are
available in the information structure itself.
Using directly this information structure allows future flexibility to
add other parameters in a simple way without the need to change the
__irq_domain_create() prototype.

Convert __irq_domain_create() to use the information structure.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0b152061e63a..28a463e25d99 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -179,45 +179,40 @@ static int irq_domain_set_name(struct irq_domain *domain,
 	return 0;
 }
 
-static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
-					      unsigned int size,
-					      irq_hw_number_t hwirq_max,
-					      int direct_max,
-					      const struct irq_domain_ops *ops,
-					      void *host_data)
+static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
 	int err;
 
-	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
-		    (direct_max && direct_max != hwirq_max)))
+	if (WARN_ON((info->size && info->direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
+		    (info->direct_max && info->direct_max != info->hwirq_max)))
 		return NULL;
 
-	domain = kzalloc_node(struct_size(domain, revmap, size),
-			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
+	domain = kzalloc_node(struct_size(domain, revmap, info->size),
+			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
 	if (!domain)
 		return NULL;
 
-	err = irq_domain_set_name(domain, fwnode);
+	err = irq_domain_set_name(domain, info->fwnode);
 	if (err) {
 		kfree(domain);
 		return NULL;
 	}
 
-	domain->fwnode = fwnode_handle_get(fwnode);
+	domain->fwnode = fwnode_handle_get(info->fwnode);
 	fwnode_dev_initialized(domain->fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	domain->ops = ops;
-	domain->host_data = host_data;
-	domain->hwirq_max = hwirq_max;
+	domain->ops = info->ops;
+	domain->host_data = info->host_data;
+	domain->hwirq_max = info->hwirq_max;
 
-	if (direct_max)
+	if (info->direct_max)
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
 
-	domain->revmap_size = size;
+	domain->revmap_size = info->size;
 
 	/*
 	 * Hierarchical domains use the domain lock of the root domain
@@ -264,8 +259,7 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_create(info->fwnode, info->size, info->hwirq_max,
-				     info->direct_max, info->ops, info->host_data);
+	domain = __irq_domain_create(info);
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
@@ -1204,13 +1198,19 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
 	struct irq_domain *domain;
 
-	if (size)
-		domain = __irq_domain_create(fwnode, size, size, 0, ops, host_data);
-	else
-		domain = __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
+	if (!info.size)
+		info.hwirq_max = ~0U;
 
+	domain = __irq_domain_create(&info);
 	if (domain) {
 		if (parent)
 			domain->root = parent->root;
-- 
2.45.0


