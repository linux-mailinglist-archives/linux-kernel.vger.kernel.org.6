Return-Path: <linux-kernel+bounces-215382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA19091C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E61C25EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B131B29AE;
	Fri, 14 Jun 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JwwhzYuM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB81B1401;
	Fri, 14 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386386; cv=none; b=USb3Lp11R2rF0Q+ZcLxYPffUiUNo/FvN4VlFJo2o6aor6TxR0f+thCePbQwi6TEhv/JDAYbTE0iWclCkQpqKZKJU+WNzmrVmz1yqqsof1HzaMOBBoFyp/dghLY8mDpSYyPvdgEud0puvQHPSnqBgXeEtG5IpdgD4PtxOz/t+q+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386386; c=relaxed/simple;
	bh=ibBd7ERnfqbQWTRVTjNpVFAoM7EyN189jsy3QZ3LOgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNSVXhchbTRrd82k7nRloGCz/IxZSqLnzKU2NFFCJCV805Y2s2LIH6Nsla5JHpk9caAvxttdG2Sbo8bl6Vtb6k65YSdyT6CEOYwsW/G7+M8pPluTCfVvDyWxK44canoujNZ2jWD9tYfrrVgwiuprE8ltxxxy4UHHQT9LqA/CiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JwwhzYuM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7DC07FF80A;
	Fri, 14 Jun 2024 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4UTRwPoFTKHJqdbzIHC3NBEYq/X/HYViIjDNKKF0PI=;
	b=JwwhzYuMC8Ol30/NGIcS3ArYrXZ4xbLT093w7YISLo/DU4gvnghJ+scUFMWBB5DlfW+9ke
	SwSo9g14jsySVjdYBqOqF/fJhd5GQHzTOpc2QQVIET9bKEPya7d7dmevq/G2adZhDUWqTc
	OUZrpK2Xp7l8ABxLrenaUHRuEO8ykLlMMepEGUhoigjQMcQKHMTSY0YzzdL0BlKuQIjYUy
	18CPFExQFfRu9GWxlCn0OTU8tp17qyWGPY3i0CC1aTKc99JCAG+WcACcuhZCGTXgUcKH+J
	rGOGUdk9uPI4n1rwhiccdOm4XYj7EbTOPtBsAessVOqc37LtNU9Lc96wqJbN0g==
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
Subject: [PATCH 20/23] irqdomain: Remove __irq_domain_add()
Date: Fri, 14 Jun 2024 19:32:21 +0200
Message-ID: <20240614173232.1184015-21-herve.codina@bootlin.com>
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

__irq_domain_add() has been replaced by irq_domain_instanciate() and so,
it is no more used.

Simply remove it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  6 +-----
 kernel/irq/irqdomain.c    | 33 ---------------------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1cd1cbf57736..401dca796633 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -184,7 +184,7 @@ enum {
 	/* Irq domain is hierarchical */
 	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
 
-	/* Irq domain name was allocated in __irq_domain_add() */
+	/* Irq domain name was allocated internally */
 	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
 
 	/* Irq domain is an IPI domain with virq per cpu */
@@ -307,10 +307,6 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
 struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
 					       const struct irq_domain_info *info);
 
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
 struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e1ceb2ba2699..53c38f951348 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -317,39 +317,6 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
-/**
- * __irq_domain_add() - Allocate a new irq_domain data structure
- * @fwnode: firmware node for the interrupt controller
- * @size: Size of linear map; 0 for radix mapping only
- * @hwirq_max: Maximum number of interrupts supported by controller
- * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
- *              direct mapping
- * @ops: domain callbacks
- * @host_data: Controller private data pointer
- *
- * Allocates and initializes an irq_domain structure.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode = fwnode,
-		.size = size,
-		.hwirq_max = hwirq_max,
-		.direct_max = direct_max,
-		.ops = ops,
-		.host_data = host_data,
-	};
-	struct irq_domain *d;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-EXPORT_SYMBOL_GPL(__irq_domain_add);
-
 /**
  * irq_domain_remove() - Remove an irq domain.
  * @domain: domain to remove
-- 
2.45.0


