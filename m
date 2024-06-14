Return-Path: <linux-kernel+bounces-215371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81C9091AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43E628C8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCC1AC447;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L3yUXNMm"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E41A38E4;
	Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386379; cv=none; b=hyMKF1leCSxSwhRrTJ5UKGhyKKF80TsGikdjc/hT9jlnfxGcmEHpTbclX/bXdKgL2LF3Omj6XtdifYEkm4iEkHiP1EAB7LTFgEmADIEljuI1HqdT2L9v86mANCqybOXV4jkh2to6WtdF9M6s8uvyw9/Y+Sji5TLsARElJHqSaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386379; c=relaxed/simple;
	bh=0iPWn752p3DNDZ7WR4ut9qgAfC5xFiEXXLLFNfT+q90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/s1JdzHn9aou2HBsBHT15/8JD4e0AF507YBfd8TxSuYuiOfRrEMJ0dJtpivJczlEKpV9vaGFHFESBtWHLKT7JjdBS2bJR/pcMqumhcfyF6kUNUT55nynpTSx3SDwkN5uMmW0mJAJGl8p0Q5a0t3c9q7xzZMOhzyV3fdA+PCW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L3yUXNMm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BD2CFFF810;
	Fri, 14 Jun 2024 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMFasbEf4choChQbQW4o5B2GzIDXCZom8Jh+XZJZcAQ=;
	b=L3yUXNMmtoZUUu0QU2ABzSlGH7KCqmQtblTAJMJ0qkuOSvfL6rmG1OI01zFrciWoPYQ26L
	MDEn87KyfQjaZCbqijbzCUElhO9yOpKhj/OAqXNUdpKufLurMnI6PgA/Ly3Zq9dkDbUKSM
	PjGgfE+KxJEmXSVzW8Q4OXKMp8huOvWSGWwyF0c1V2HAM/OA3657yRUE0pcIvEuV1O4T/Z
	Pg/0aq3G8lKpkKqkJSQVNEeBMLUsK0hWxUQWXJBO6MS2xXsI0KuVcIYCgayWU+pSH8siUn
	bXBigm/JwElpb9az7tADwJ/JGu6d4j6oi5Y3UGhVtPbOabRoJ2uAe6WcGMutYw==
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
Subject: [PATCH 11/23] irqdomain: Handle domain bus token in irq_domain_create()
Date: Fri, 14 Jun 2024 19:32:12 +0200
Message-ID: <20240614173232.1184015-12-herve.codina@bootlin.com>
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

irq_domain_update_bus_token() is the only way to set the domain bus
token. This is sub-optimal as irq_domain_update_bus_token() can be
called only once the domain is created and needs to revert some
operations, change the domain name and redo the operations.

In order to avoid this revert/change/redo sequence, take into account
the domain bus token during the domain creation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 30 ++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e52fd5e5494c..52bed23e5c61 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -265,6 +265,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  */
@@ -274,6 +275,7 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	enum irq_domain_bus_token		bus_token;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5090b1c572c6..d05aeb9c0a67 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -129,7 +129,8 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
 static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode)
+			       const struct fwnode_handle *fwnode,
+			       enum irq_domain_bus_token bus_token)
 {
 	static atomic_t unknown_domains;
 	struct irqchip_fwid *fwid;
@@ -140,13 +141,23 @@ static int irq_domain_set_name(struct irq_domain *domain,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->name = kstrdup(fwid->name, GFP_KERNEL);
+			domain->name = bus_token ?
+					kasprintf(GFP_KERNEL, "%s-%d",
+						  fwid->name, bus_token) :
+					kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name)
 				return -ENOMEM;
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
 			domain->name = fwid->name;
+			if (bus_token) {
+				domain->name = kasprintf(GFP_KERNEL, "%s-%d",
+							 fwid->name, bus_token);
+				if (!domain->name)
+					return -ENOMEM;
+				domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+			}
 			break;
 		}
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
@@ -158,7 +169,9 @@ static int irq_domain_set_name(struct irq_domain *domain,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		name = bus_token ?
+			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+			kasprintf(GFP_KERNEL, "%pfw", fwnode);
 		if (!name)
 			return -ENOMEM;
 
@@ -169,8 +182,12 @@ static int irq_domain_set_name(struct irq_domain *domain,
 	if (!domain->name) {
 		if (fwnode)
 			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
-					 atomic_inc_return(&unknown_domains));
+		domain->name = bus_token ?
+				kasprintf(GFP_KERNEL, "unknown-%d-%d",
+					  atomic_inc_return(&unknown_domains),
+					  bus_token) :
+				kasprintf(GFP_KERNEL, "unknown-%d",
+					  atomic_inc_return(&unknown_domains));
 		if (!domain->name)
 			return -ENOMEM;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
@@ -194,7 +211,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	err = irq_domain_set_name(domain, info->fwnode);
+	err = irq_domain_set_name(domain, info->fwnode, info->bus_token);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);
@@ -207,6 +224,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
 	domain->ops = info->ops;
 	domain->host_data = info->host_data;
+	domain->bus_token = info->bus_token;
 	domain->hwirq_max = info->hwirq_max;
 
 	if (info->direct_max)
-- 
2.45.0


