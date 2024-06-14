Return-Path: <linux-kernel+bounces-215376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACE9091B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F12885CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A761B0110;
	Fri, 14 Jun 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ez3HgDN5"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F671AC45F;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386382; cv=none; b=i8Py4Q9ZZHmPRp2yAh7k/zw91Oy5AXH71HM86ECMYRjHRoiW1CAaAwydye+5imGQLv21cosNTF6SMlM3XoDsTlni9RPnCWgA6tCH72x/TyGcyVUSkLayR9F/svhsNzcKF+aWK0HKoBynWqXBAZgEwk08swR8SewNiANouKTReng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386382; c=relaxed/simple;
	bh=VlvGKRRpo5xWBJoejsLyt7nigRzK4ZhbFT7a46KLwNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTv40NsPOWe3N4xuSikWYIkN4hMA8B8355qMORoMsI7maziLKFwyUsjHQPCNdIi3QRuztedly2CvN3SX6o4J5/etvgHr9PTsdCzdAzXyFbeQnLl8iPNjXRH8eko8Vc+hOfuoivav6HiWxM40tog6NH6ow+eFR8zPe3xxoKvMGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ez3HgDN5; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4869DFF803;
	Fri, 14 Jun 2024 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYNoEWBZlzduIVJgCOvsuNgUKgrmtRin0j3Jv9ZGB0c=;
	b=ez3HgDN5+vlxZQZG+rEbv4mPtd20Jh6XPRZ9uxw3I8+BErytIt+OAYVo4zhZLQ0vAfKpUO
	b0Xlm6nC17l5QUZMzNACZuWBjiaK26labQ9G7oornNfGsCCHESnlxBH7Z9AfcBDzI1AzeF
	xQTdnTGeLhJYqUFpmInrsyvocUdKtPnWoyN8ddQiM4jn+xh/+ob1D3vHJQQTM9Va8v/VsG
	HNLZ3o4f8kuYi5+ZIYEMDBIlH0IQUjM/Scvuzz1mFOdWWQ9oLCHSH8dxIoBBJ9tv5bFs1u
	Iiu5rzH9AWc35IVwQj19e+3qWiMS9j+lx3rMhfwQODHD4PdR9DLVA3PEdypJGw==
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
Subject: [PATCH 15/23] irqdomain: Add support for generic irq chips creation before publishing a domain
Date: Fri, 14 Jun 2024 19:32:16 +0200
Message-ID: <20240614173232.1184015-16-herve.codina@bootlin.com>
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

The current API functions create an irq_domain and also publish this
newly created to domain. Once an irq_domain is published, consumers can
request IRQ in order to use them.

Some interrupt controller drivers have to perform some more operations
with the created irq_domain in order to have it ready to be used.
For instance:
   - Allocate generic irq chips with irq_alloc_domain_generic_chips()
   - Retrieve the generic irq chips with irq_get_domain_generic_chip()
   - Initialize retrieved chips: set register base address and offsets,
     set several hooks such as irq_mask, irq_unmask, ...

With the newly introduced irq_domain_alloc_generic_chips(), an interrupt
controller driver can use the irq_domain_chip_generic_info structure and
set the init() hook to perform its generic chips initialization.

In order to avoid a window where the domain is published but not yet
ready to be used, handle the generic chip creation (i.e the
irq_domain_alloc_generic_chips() call) before the domain is published.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  9 +++++++++
 kernel/irq/irqdomain.c    | 14 +++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2c927edc4d43..5540b22a755c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -210,6 +210,9 @@ enum {
 	/* Irq domain is a MSI device domain */
 	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
 
+	/* Irq domain must destroy generic chips when removed */
+	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -259,6 +262,9 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+
+struct irq_domain_chip_generic_info;
+
 /**
  * struct irq_domain_info - Domain information structure
  * @fwnode:		firmware node for the interrupt controller
@@ -270,6 +276,8 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @dgc_info:		Geneneric chip information structure pointer used to
+ *			create generic chips for the domain if not NULL.
  * @init:		Function called when the domain is created.
  *			Allow to do some additional domain initialisation.
  * @exit:		Function called when the domain is destroyed.
@@ -290,6 +298,7 @@ struct irq_domain_info {
 	 */
 	struct irq_domain			*parent;
 #endif
+	struct irq_domain_chip_generic_info	*dgc_info;
 	int					(*init)(struct irq_domain *d);
 	void					(*exit)(struct irq_domain *d);
 };
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9efc9f180308..d95ca575a108 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -292,16 +292,25 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	}
 #endif
 
+	if (info->dgc_info) {
+		err = irq_domain_alloc_generic_chips(domain, info->dgc_info);
+		if (err)
+			goto err_domain_free;
+	}
+
 	if (info->init) {
 		err = info->init(domain);
 		if (err)
-			goto err_domain_free;
+			goto err_domain_gc_remove;
 	}
 
 	__irq_domain_publish(domain);
 
 	return domain;
 
+err_domain_gc_remove:
+	if (info->dgc_info)
+		irq_domain_remove_generic_chips(domain);
 err_domain_free:
 	irq_domain_free(domain);
 	return ERR_PTR(err);
@@ -369,6 +378,9 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	mutex_unlock(&irq_domain_mutex);
 
+	if (domain->flags & IRQ_DOMAIN_FLAG_DESTROY_GC)
+		irq_domain_remove_generic_chips(domain);
+
 	pr_debug("Removed domain %s\n", domain->name);
 	irq_domain_free(domain);
 }
-- 
2.45.0


