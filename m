Return-Path: <linux-kernel+bounces-215372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDC9091AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2661C21183
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADE1AD9D0;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IW4unxYu"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795A1A3BDF;
	Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386379; cv=none; b=O7a2J16i4uPnzpw7QHUtViyZivuCcI2UJkeBokJ79yAcQRQEVXnRfdiCIK2Gqg5h9aw4iVj0sG5MwhzUwfOJsM15TEC7A7h4oaqYOeJIQaSV9RpCRo1POgOsUTMV8dFyHe9j1+ZC2DqSB+1+z19B2kSVIamAjJanUS5TIZd5K6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386379; c=relaxed/simple;
	bh=dDchFYVE/ZhAseqVgo+pqTonqZkZ9MeBcfs48Q1L85M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp6FyvTt6QhBF1OwRTUoInn0E08HPFJfUmWzWXaNe/6w+EK2M8iDIWBy9rLHmSsO51ollPEdsIvrUnYeiqmMVDAcG3ho8k+aY+su9fQ2Sgq1vD56/Dhm77eNQf8swQt48M/JFnrIbMwE8fn1CrGKHiYEwgxptmGOT/fD0A4RJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IW4unxYu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 833BBFF808;
	Fri, 14 Jun 2024 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Jt3G+9U0q6RfDTk1HQe6Yj9ZdV0UvVAc1UYDI9SykA=;
	b=IW4unxYuqtWHfPp6kOACcF+GTsjKd+633XLLo7q/KXWgkKzYwKxUNP7306nv+MKpXCv7ep
	3avTOY9QqnTWu0HfU8z1riCevl523+xTxPphjVWuQmxAhDKN1PksnhyZdK/ycF61le6Cjb
	uL6Ji+ySOoE0R72ETvPWJwyOMwZYqM3dXXrO2lpOzAzeYkCMLdB/lv0vQqOESkRrkAl9tg
	3QdJHvYg3eNUuceduXBoqgOwQKWpU/y98TOk2IP9bhnkFgRXXsoXT5BNwMvUityp7a8TMJ
	AM9AdBgu1DJcC0sCUJ6AUM2216FG+6GQxIF6DSklMjUBlkKr8j/4HnRBhI9ong==
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
Subject: [PATCH 05/23] irqdomain: Use a dedicated function to set the domain name
Date: Fri, 14 Jun 2024 19:32:06 +0200
Message-ID: <20240614173232.1184015-6-herve.codina@bootlin.com>
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

The irq domain name computation and setting is directly done in
__irq_domain_create(). This leads to a quite long __irq_domain_create()
function.

In order to simplify __irq_domain_create() and isolate the domain name
computation and setting, move the related operations to a dedicated
function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 69 +++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 31277488ed42..0b152061e63a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -128,27 +128,11 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
-static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
-					      unsigned int size,
-					      irq_hw_number_t hwirq_max,
-					      int direct_max,
-					      const struct irq_domain_ops *ops,
-					      void *host_data)
+static int irq_domain_set_name(struct irq_domain *domain,
+			       const struct fwnode_handle *fwnode)
 {
-	struct irqchip_fwid *fwid;
-	struct irq_domain *domain;
-
 	static atomic_t unknown_domains;
-
-	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
-		    (direct_max && (direct_max != hwirq_max))))
-		return NULL;
-
-	domain = kzalloc_node(struct_size(domain, revmap, size),
-			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
-	if (!domain)
-		return NULL;
+	struct irqchip_fwid *fwid;
 
 	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
@@ -157,10 +141,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name) {
-				kfree(domain);
-				return NULL;
-			}
+			if (!domain->name)
+				return -ENOMEM;
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
@@ -177,10 +159,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		 * the trick and is not as offensive as '\'...
 		 */
 		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name) {
-			kfree(domain);
-			return NULL;
-		}
+		if (!name)
+			return -ENOMEM;
 
 		domain->name = strreplace(name, '/', ':');
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
@@ -191,13 +171,40 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			pr_err("Invalid fwnode type for irqdomain\n");
 		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
 					 atomic_inc_return(&unknown_domains));
-		if (!domain->name) {
-			kfree(domain);
-			return NULL;
-		}
+		if (!domain->name)
+			return -ENOMEM;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
+	return 0;
+}
+
+static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
+					      unsigned int size,
+					      irq_hw_number_t hwirq_max,
+					      int direct_max,
+					      const struct irq_domain_ops *ops,
+					      void *host_data)
+{
+	struct irq_domain *domain;
+	int err;
+
+	if (WARN_ON((size && direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
+		    (direct_max && direct_max != hwirq_max)))
+		return NULL;
+
+	domain = kzalloc_node(struct_size(domain, revmap, size),
+			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
+	if (!domain)
+		return NULL;
+
+	err = irq_domain_set_name(domain, fwnode);
+	if (err) {
+		kfree(domain);
+		return NULL;
+	}
+
 	domain->fwnode = fwnode_handle_get(fwnode);
 	fwnode_dev_initialized(domain->fwnode, true);
 
-- 
2.45.0


