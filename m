Return-Path: <linux-kernel+bounces-215375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165419091B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9412D28489D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CE19FA97;
	Fri, 14 Jun 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aspKBPe6"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FA1AC428;
	Fri, 14 Jun 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386381; cv=none; b=k7Byte/PfpeFAMN5i5XUKap14Y55el8269vvd1uQ4GHUYmkfDHBqEUcDq9uSYUzCBbaPBJPQ1NXdKY546JCzLrSkImBf4C9YEVzitmjcioKpzTOMJXf/2ELBagSdyIlwnrQWCgOe9WjV/9c65rGd3z2UuI6e6CeMSiM9dUtb6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386381; c=relaxed/simple;
	bh=POM7os4HoVZHRg5XSLcg+COGEEvpKUYrm59+XwBZGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbhhzilRB47H18bVVCw2i4UUTjxCEpBjjRZZqoG19A7oKj/03RYXAiyb/+W3zgXrLDO8oDY2Tnpei/b8VZUbfhRM6HmmaqNCiHIkKhHWa5uwCa4phrFt4hBy3KFyWR/78hj4KaaLwgDEiCRueSSLjlQxICm2mYRgBpOElskJHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aspKBPe6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 64542FF804;
	Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbvgscye7X8+RemWHl+jq7TxdKmm/D41gcDp9jZK0oo=;
	b=aspKBPe6SV6vCwYniMfxh+fFuWqoqZcKl9dbM11gV0d4QwGndS1/VUvkhAsDIADTanaOnS
	B77RKSGsYZxRjpWRNVNBO6eEmVrXySk47PSkxOOrB0AbGOe2u5a2/SEzWi4Q/876Rb2fzb
	oOeSsFi4g3L1RyEwJBBxPUzUyuZFGIrJLSGx+d37v7NYP0KjEKX8qFtmbMWsfmszg5ULob
	6dnFyDwcB2qWRMJptXwnt+ly0z7QUPz1Ix49vdBomtfgXMwPA3bptSTVyw39aBYqbT0ZRN
	R06P9ogRgs/BNs2OznRo71+RFdwcf6ReaRgUw+Onog+8tI8im+ODYwEH7hTRjg==
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
Subject: [PATCH 14/23] genirq/generic_chip: Introduce init() and exit() hooks
Date: Fri, 14 Jun 2024 19:32:15 +0200
Message-ID: <20240614173232.1184015-15-herve.codina@bootlin.com>
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

Most of generic chip drivers need to perform some more additional
initializations on the generic chips allocated before they can be fully
ready.

These additional initializations need to be performed before the IRQ
domain is published to avoid a race condition between IRQ consumers and
suppliers.

Introduce the init() hook to perform these initializations at the right
place just after the generic chip creation. Also introduce the exit()
hook to allow reververting operations done by the init() hook just
before the generic chip is destroyed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irq.h       |  8 ++++++++
 kernel/irq/generic-chip.c | 24 ++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 58264b236cbf..712bcee56efc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1106,6 +1106,7 @@ enum irq_gc_flags {
  * @irq_flags_to_set:	IRQ* flags to set on irq setup
  * @irq_flags_to_clear:	IRQ* flags to clear on irq setup
  * @gc_flags:		Generic chip specific setup flags
+ * @exit:		Function called on each chip when they are destroyed.
  * @gc:			Array of pointers to generic interrupt chips
  */
 struct irq_domain_chip_generic {
@@ -1114,6 +1115,7 @@ struct irq_domain_chip_generic {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	void			(*exit)(struct irq_chip_generic *gc);
 	struct irq_chip_generic	*gc[];
 };
 
@@ -1127,6 +1129,10 @@ struct irq_domain_chip_generic {
  * @irq_flags_to_clear:	IRQ_* bits to clear in the mapping function
  * @irq_flags_to_set:	IRQ_* bits to set in the mapping function
  * @gc_flags:		Generic chip specific setup flags
+ * @init:		Function called on each chip when they are created.
+ *			Allow to do some additional chip initialisation.
+ * @exit:		Function called on each chip when they are destroyed.
+ *			Allow to do some chip cleanup operation.
  */
 struct irq_domain_chip_generic_info {
 	const char		*name;
@@ -1136,6 +1142,8 @@ struct irq_domain_chip_generic_info {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	int			(*init)(struct irq_chip_generic *gc);
+	void			(*exit)(struct irq_chip_generic *gc);
 };
 
 /* Generic chip callback functions */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index d9696f5dcc38..32ffcbb87fa1 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -293,6 +293,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 	size_t gc_sz;
 	size_t sz;
 	void *tmp;
+	int ret;
 
 	if (d->gc)
 		return -EBUSY;
@@ -314,6 +315,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 	dgc->irq_flags_to_set = info->irq_flags_to_set;
 	dgc->irq_flags_to_clear = info->irq_flags_to_clear;
 	dgc->gc_flags = info->gc_flags;
+	dgc->exit = info->exit;
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
@@ -331,6 +333,12 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 			gc->reg_writel = &irq_writel_be;
 		}
 
+		if (info->init) {
+			ret = info->init(gc);
+			if (ret)
+				goto err;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
@@ -338,6 +346,16 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 		tmp += gc_sz;
 	}
 	return 0;
+
+err:
+	while (i--) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+	}
+	d->gc = NULL;
+	kfree(dgc);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_domain_alloc_generic_chips);
 
@@ -353,9 +371,11 @@ void irq_domain_remove_generic_chips(struct irq_domain *d)
 	if (!dgc)
 		return;
 
-	for (i = 0; i < dgc->num_chips; i++)
+	for (i = 0; i < dgc->num_chips; i++) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
 		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
-
+	}
 	d->gc = NULL;
 	kfree(dgc);
 }
-- 
2.45.0


