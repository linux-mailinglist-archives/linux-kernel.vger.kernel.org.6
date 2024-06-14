Return-Path: <linux-kernel+bounces-215378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E59091BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EC41F24EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB211B1408;
	Fri, 14 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aP3N0jiR"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4D1AED33;
	Fri, 14 Jun 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386384; cv=none; b=Bh7Mn7dGARNY27HGcfnT3QWb3/eBwUkb8Imo8OJorxvHqsaoukJQFo99GCr5ezbWgdSp2L3D5b4XpFvD8Q678mF+6ijlLTfR8WSO3YXTP6W62DjQKYuNVmZ/DTPMyM/Fm3VYt2QTYYGUss//XWHw93sJqksazDo7guFxA4R/0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386384; c=relaxed/simple;
	bh=7z89Bg/HvIwaBDXEsHwRmRRcszz8hpFc/huwhFys+EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+rII/J9TlopOrvcTGqNWuYVT614gK3f7NwT5dbKt6GnU+JwbmAs4jcONgCez5q7JzqS0CzkQ5hNlkv0dHm+2iZNJQRePkXFGLQC4GSaBjUe30iWCOpMnhS493kBZsZc0ouB6ItO5CzQnvjzGQGym3olcC2RKmNFGbeoTKMy3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aP3N0jiR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DA020FF807;
	Fri, 14 Jun 2024 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrO21D/F1M18TMwOh5nDZl9q9v++C9Qwkdmyr7nENho=;
	b=aP3N0jiRHNCo/PI9Tmqi+m5BiLjCBPomS0d3Lp7pX3CPht3E5bXpuBNeafgNXjcQLIIejB
	x6LmGLn8nncQ6TZnXR42IpSud3pbCGNMnyrm6XUayFplZ3syjkO6Lfu9VfxpcE2ZZcp1L9
	RkeQ+nFgaN3u6Ev22GPXJpznyhr7TTsaDTSAG8ZOeIn7owqypv+Y0fhHuXbKFoxlia3Hag
	JmBynUt4HWat6VA6ZRUZjcELmcRxX1in1l9+XaLY7C6PFRSMdkEuVH+J4pJRkwjoF+exb8
	vpa0LYbN1O3E9GQvGkQHhJM0mTyTIZOf7MUQYnFlBOPkCN5t1koRO/SSX17FnA==
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
Subject: [PATCH 17/23] irqdomain: Convert __irq_domain_add() wrappers to irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:18 +0200
Message-ID: <20240614173232.1184015-18-herve.codina@bootlin.com>
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

__irq_domain_add() wrappers use directly __irq_domain_add(). With the
introduction of irq_domain_instantiate(), __irq_domain_add() becomes
obsolete.

In order to fully remove __irq_domain_add(), convert wrappers to
irq_domain_instantiate()

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 58 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8820317582c4..1cd1cbf57736 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -400,7 +400,17 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = of_node_to_fwnode(of_node),
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
@@ -409,7 +419,17 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = of_node_to_fwnode(of_node),
+		.hwirq_max = max_irq,
+		.direct_max = max_irq,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
@@ -419,7 +439,16 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = of_node_to_fwnode(of_node),
+		.hwirq_max = ~0U,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
@@ -427,14 +456,33 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.hwirq_max = ~0,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 extern void irq_domain_remove(struct irq_domain *host);
-- 
2.45.0


