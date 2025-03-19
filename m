Return-Path: <linux-kernel+bounces-567616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E2A6885D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A22884ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13A25524C;
	Wed, 19 Mar 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4apbBLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75125D207;
	Wed, 19 Mar 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376772; cv=none; b=OIi2yiSxsXtwYd3E0+vuiYYOxDyI61kiR7FnPfQXw22/m+7WqoU1YYRv2V9CAleGWxTg9EVhliMnhBNoHMWUKP/RNoRDBf6SITTY5p8HlM6Jx4MkvTDUcgK7E/4Ij75ZfqUEY3tL2LB2RUQtrFciBJxXDCZp90qfUc1wVpH4Vn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376772; c=relaxed/simple;
	bh=K/R8g9zziIqCOE4/MMgWNVtoTA9qMBHKAn0Fn7NrtC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrzD9KtxFcOPyFiLmmR+XIoakXeWvCKRp5B0lugKKy+t1lf5baM/Lq6aeYPJbNipKFjZzQSeLtdv/KJYQ/YrDsuto61LwqiMExpH8C0fSw1d8nFBnZ3++SEPj+smA02nkmoUdCPbUGnWHRkUqB8WTmUUDzufI1vyfxyzDR3fxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4apbBLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE62C4CEE9;
	Wed, 19 Mar 2025 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376772;
	bh=K/R8g9zziIqCOE4/MMgWNVtoTA9qMBHKAn0Fn7NrtC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4apbBLGGm5DKjd+jiJh4zvU0miW5I2qnUr6l3TNOFZLKGxpTvu5FB+VOSK191CW7
	 BrAK8ZC7t0L1qtfPNOExO9bVkDG9wOvgD1LlJHf5uHsiNU7OZb05mvusU8reXaOb01
	 iInuXXvVF0IfDso4YI78Sv5IiyaTW9dT3nE1jHwK1VLBXoxZNkodWv5l4lzVLzXpIo
	 lAYvoKkkwbmPLl1Igrz6HgsFRPkCmi5cZoKVcaypTxDgBv7rjTuZvT6t/13R9D7eiG
	 u608rY57uEhzTZOzBBB/ZCpB5hszN9q+B0RMB2+z/D9jHZ+EGxN0TUDzhUSwJ/t1ST
	 KtYAQ9ovSzM2A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 40/57] irqdomain: Drop irq_domain_add_*() functions
Date: Wed, 19 Mar 2025 10:29:33 +0100
Message-ID: <20250319092951.37667-41-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_add_*() functions are unused now, so drop them.

Note: The Chinese docs are touched but unfinished. I cannot parse those.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/core-api/irq/irq-domain.rst     | 34 ++--------
 .../zh_CN/core-api/irq/irq-domain.rst         |  4 --
 include/linux/irqdomain.h                     | 68 -------------------
 kernel/irq/irqdomain.c                        | 27 --------
 4 files changed, 7 insertions(+), 126 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 44f4ba5480df..e26ed303819d 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -92,7 +92,6 @@ Linear
 
 ::
 
-	irq_domain_add_linear()
 	irq_domain_create_linear()
 
 The linear reverse map maintains a fixed size table indexed by the
@@ -105,11 +104,6 @@ map are fixed time lookup for IRQ numbers, and irq_descs are only
 allocated for in-use IRQs.  The disadvantage is that the table must be
 as large as the largest possible hwirq number.
 
-irq_domain_add_linear() and irq_domain_create_linear() are functionally
-equivalent, except for the first argument is different - the former
-accepts an Open Firmware specific 'struct device_node', while the latter
-accepts a more general abstraction 'struct fwnode_handle'.
-
 The majority of drivers should use the linear map.
 
 Tree
@@ -117,7 +111,6 @@ Tree
 
 ::
 
-	irq_domain_add_tree()
 	irq_domain_create_tree()
 
 The irq_domain maintains a radix tree map from hwirq numbers to Linux
@@ -129,11 +122,6 @@ since it doesn't need to allocate a table as large as the largest
 hwirq number.  The disadvantage is that hwirq to IRQ number lookup is
 dependent on how many entries are in the table.
 
-irq_domain_add_tree() and irq_domain_create_tree() are functionally
-equivalent, except for the first argument is different - the former
-accepts an Open Firmware specific 'struct device_node', while the latter
-accepts a more general abstraction 'struct fwnode_handle'.
-
 Very few drivers should need this mapping.
 
 No Map
@@ -159,8 +147,6 @@ Legacy
 
 ::
 
-	irq_domain_add_simple()
-	irq_domain_add_legacy()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
 
@@ -189,13 +175,13 @@ supported.  For example, ISA controllers would use the legacy map for
 mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
 numbers.
 
-Most users of legacy mappings should use irq_domain_add_simple() or
-irq_domain_create_simple() which will use a legacy domain only if an IRQ range
-is supplied by the system and will otherwise use a linear domain mapping.
-The semantics of this call are such that if an IRQ range is specified then
-descriptors will be allocated on-the-fly for it, and if no range is
-specified it will fall through to irq_domain_add_linear() or
-irq_domain_create_linear() which means *no* irq descriptors will be allocated.
+Most users of legacy mappings should use irq_domain_create_simple()
+which will use a legacy domain only if an IRQ range is supplied by the
+system and will otherwise use a linear domain mapping. The semantics of
+this call are such that if an IRQ range is specified then descriptors
+will be allocated on-the-fly for it, and if no range is specified it
+will fall through to irq_domain_create_linear() which means *no* irq
+descriptors will be allocated.
 
 A typical use case for simple domains is where an irqchip provider
 is supporting both dynamic and static IRQ assignments.
@@ -206,12 +192,6 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
-irq_domain_add_simple() and irq_domain_create_simple() as well as
-irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
-equivalent, except for the first argument is different - the former
-accepts an Open Firmware specific 'struct device_node', while the latter
-accepts a more general abstraction 'struct fwnode_handle'.
-
 Hierarchy IRQ domain
 --------------------
 
diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
index ecb23cfbc9fc..913c3eda3f74 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -83,7 +83,6 @@ irq_domain映射的类型
 
 ::
 
-	irq_domain_add_linear()
 	irq_domain_create_linear()
 
 线性反向映射维护了一个固定大小的表，该表以hwirq号为索引。 当一个hwirq被映射
@@ -104,7 +103,6 @@ irq_domain_add_linear()和irq_domain_create_linear()在功能上是等价的，
 
 ::
 
-	irq_domain_add_tree()
 	irq_domain_create_tree()
 
 irq_domain维护着从hwirq号到Linux IRQ的radix的树状映射。 当一个hwirq被映射时，
@@ -138,8 +136,6 @@ Linux IRQ号编入硬件本身，这样就不需要映射了。 调用irq_create
 
 ::
 
-	irq_domain_add_simple()
-	irq_domain_add_legacy()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 984d0188f9ec..bd02550df6e6 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -338,12 +338,6 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    unsigned int first_irq,
 					    const struct irq_domain_ops *ops,
 					    void *host_data);
-struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
-					 unsigned int size,
-					 unsigned int first_irq,
-					 irq_hw_number_t first_hwirq,
-					 const struct irq_domain_ops *ops,
-					 void *host_data);
 struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
@@ -396,40 +390,6 @@ static inline struct irq_domain *irq_find_host(struct device_node *node)
 	return d;
 }
 
-static inline struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
-						       unsigned int size,
-						       unsigned int first_irq,
-						       const struct irq_domain_ops *ops,
-						       void *host_data)
-{
-	return irq_domain_create_simple(of_fwnode_handle(of_node), size, first_irq, ops, host_data);
-}
-
-/**
- * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
- * @of_node: pointer to interrupt controller's device tree node.
- * @size: Number of interrupts in the domain.
- * @ops: map/unmap domain callbacks
- * @host_data: Controller private data pointer
- */
-static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_node,
-					 unsigned int size,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode		= of_fwnode_handle(of_node),
-		.size		= size,
-		.hwirq_max	= size,
-		.ops		= ops,
-		.host_data	= host_data,
-	};
-	struct irq_domain *d;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
 static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *fwnode,
 					 unsigned int max_irq,
@@ -452,22 +412,6 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 unsigned int irq_create_direct_mapping(struct irq_domain *domain);
 #endif
 
-static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode		= of_fwnode_handle(of_node),
-		.hwirq_max	= ~0U,
-		.ops		= ops,
-		.host_data	= host_data,
-	};
-	struct irq_domain *d;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
 					 unsigned int size,
 					 const struct irq_domain_ops *ops,
@@ -631,18 +575,6 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 	return IS_ERR(d) ? NULL : d;
 }
 
-static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
-					    unsigned int flags,
-					    unsigned int size,
-					    struct device_node *node,
-					    const struct irq_domain_ops *ops,
-					    void *host_data)
-{
-	return irq_domain_create_hierarchy(parent, flags, size,
-					   of_fwnode_handle(node),
-					   ops, host_data);
-}
-
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
 			    bool realloc,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index b5e111776285..5bb3d2bbe229 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -480,33 +480,6 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_simple);
 
-/**
- * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domain.
- * @of_node: pointer to interrupt controller's device tree node.
- * @size: total number of irqs in legacy mapping
- * @first_irq: first number of irq block assigned to the domain
- * @first_hwirq: first hwirq number to use for the translation. Should normally
- *               be '0', but a positive integer can be used if the effective
- *               hwirqs numbering does not begin at zero.
- * @ops: map/unmap domain callbacks
- * @host_data: Controller private data pointer
- *
- * Note: the map() callback will be called before this function returns
- * for all legacy interrupts except 0 (which is always the invalid irq for
- * a legacy controller).
- */
-struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
-					 unsigned int size,
-					 unsigned int first_irq,
-					 irq_hw_number_t first_hwirq,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
-{
-	return irq_domain_create_legacy(of_fwnode_handle(of_node), size,
-					first_irq, first_hwirq, ops, host_data);
-}
-EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
-
 struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					 unsigned int size,
 					 unsigned int first_irq,
-- 
2.49.0


