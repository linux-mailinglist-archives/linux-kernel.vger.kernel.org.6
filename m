Return-Path: <linux-kernel+bounces-215373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6989091AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CBB28CDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C31AD9E1;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lKjvYVPR"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04D1AB8E1;
	Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386380; cv=none; b=YHjsdDXya0YexV/fESHeB/osYm9/s+/VhvWCGO5KysaliHNME+MU911LADHhBdOwAdU6BGYjZOazxRdU9CabXQJmzuWLXAqOEgxD1I75cXpmkznX6uo1gVt4sJTQjblO4Ii3lP5+pCa1ihOrrorKY3kdm1LC73kay3z503+P5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386380; c=relaxed/simple;
	bh=3/cVlx907MzcG9vrQ3DE0pKe7Qu2ZlekB/sarfJHvP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ard8EhuXeZAT80Syc27U5u34DV8CMIc/LgpQnBYpDgnXQOpVwgOiggNhY4CZX4IJJ3t73Ioq+Jvi8iTbJ7ZQh7fR4lVEbnhO7rAiIYbNdXtaO2XKjPkalbaYP6IKEYONnyVBxhpg90i8vkqXFOuMzu0oyuPz/S68CPDC6/2r/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lKjvYVPR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 97823FF805;
	Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCrIqBOqgd8IhI1XvRqpnH65nvLXt6DnzPIXbQl0ooU=;
	b=lKjvYVPRbwgWGiXtVyYKgzayJgQnlEq99TCZ2S90A2zRcZKPLUMG57o2C+Bqs3YVLxQ75b
	v+mbvSRxvEw60jOeDANphC7wTr/NggD0ZQaLgOdLB7V2PRg4OoueEPT44gRJ4xpam0WoP6
	BzIuaxb8+IZ0T4rV4St3oiO1tpkW8YbOH+if7Jrj0qK3AgM7PeU76pb9Tz44jySjHBnBbp
	Ew+xB06m7amr/lpmIqo4yWNv/TLS+T4ru/C1bPNW0mEPdslWQFgO1IDzmruDmQ0BeSeu9i
	/a3z35N9d0ECq9wDzBOBAWMtVxq7jI0cx/nLbt9Zd7LBHpejcrS3PdBgZ+4vEA==
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
Subject: [PATCH 12/23] irqdomain: Introduce init() and exit() hooks
Date: Fri, 14 Jun 2024 19:32:13 +0200
Message-ID: <20240614173232.1184015-13-herve.codina@bootlin.com>
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

The current API does not allow additional initialization before the
domain is published. This can lead to a race condition between consumers
and supplier as a domain can be available for consumers before being
fully ready.

Introduce the init() hook to allow additional initialization before
plublishing the domain. Also introduce the exit() hook to revert
operations done in init() on domain removal.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  8 ++++++++
 kernel/irq/irqdomain.c    | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 52bed23e5c61..2c927edc4d43 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -141,6 +141,7 @@ struct irq_domain_chip_generic;
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  * @msi_parent_ops: Pointer to MSI parent domain methods for per device domain init
+ * @exit:	Function called when the domain is destroyed
  *
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
@@ -169,6 +170,7 @@ struct irq_domain {
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	const struct msi_parent_ops	*msi_parent_ops;
 #endif
+	void				(*exit)(struct irq_domain *d);
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
@@ -268,6 +270,10 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @init:		Function called when the domain is created.
+ *			Allow to do some additional domain initialisation.
+ * @exit:		Function called when the domain is destroyed.
+ *			Allow to do some additional cleanup operation.
  */
 struct irq_domain_info {
 	struct fwnode_handle			*fwnode;
@@ -284,6 +290,8 @@ struct irq_domain_info {
 	 */
 	struct irq_domain			*parent;
 #endif
+	int					(*init)(struct irq_domain *d);
+	void					(*exit)(struct irq_domain *d);
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d05aeb9c0a67..9efc9f180308 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -276,12 +276,14 @@ static void irq_domain_free(struct irq_domain *domain)
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
+	int err;
 
 	domain = __irq_domain_create(info);
 	if (IS_ERR(domain))
 		return ERR_CAST(domain);
 
 	domain->flags |= info->domain_flags;
+	domain->exit = info->exit;
 
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (info->parent) {
@@ -290,9 +292,19 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	}
 #endif
 
+	if (info->init) {
+		err = info->init(domain);
+		if (err)
+			goto err_domain_free;
+	}
+
 	__irq_domain_publish(domain);
 
 	return domain;
+
+err_domain_free:
+	irq_domain_free(domain);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
@@ -339,6 +351,9 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
+	if (domain->exit)
+		domain->exit(domain);
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_remove_domain_dir(domain);
 
-- 
2.45.0


