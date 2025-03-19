Return-Path: <linux-kernel+bounces-567584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3785BA6881C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE900189B0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF372561C3;
	Wed, 19 Mar 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvi+Ey6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8D253F1E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376678; cv=none; b=ZtarLosuzVTwiSnl7xBGNhNSxaR6pXfyJeR7cPgWEcSJe1Wo6pF33En4cgtJGcg9e7VUFZqbk5PZJIqRgUlKfr84iJ6sjsteM60L632SQzX118bZkeI8RPTTTc78zYaNtfL9Tmv++n3djEPHvems34ioi79RSYu0VKPxd4Evvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376678; c=relaxed/simple;
	bh=5X/2KZBe0rTzqTYeY+UtAe+OLiGg47tjFCLWPcVkPKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcjyy5F1/R3fxneO+jM4vS48cNDKKxN2tR+5lPcv/nwpQWAF2R6BP4R0iojwC/QG1xFlMISUZy6ywIOGbNV02oW1wQYsqm/cSesD/b6g6TMSMaU4aIL1NtiF4n2348DTAV6imzCAjZsMxquzs0Yj1YhS4Qrh6fEdQkvG1qbvCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvi+Ey6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2288CC4CEE9;
	Wed, 19 Mar 2025 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376676;
	bh=5X/2KZBe0rTzqTYeY+UtAe+OLiGg47tjFCLWPcVkPKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvi+Ey6Ap7q3t1h90SNBYQiWfxRBI4WpOQ27WwhyZ6nsbQjadFSYG+ClF0NsfiTTi
	 nXU3tW5XPs7+hULnW5u2Q3PgDIuh814QaVAY04YQDQqLsk54bP2BSUshYBdsoHclwd
	 1Fue+Nxwv7qfxI+dUV57EZ45ZUdXrZiJBvUsjvpixdL9EzLyMnYKSFPJX/sMzSEsG5
	 tYpX7kMkf2dHLYlV65Hm3QZq6hExsTUH3ye0SKZ245vEyhCOMJvzEoY/MnaG9dTaeK
	 JAR7T1oVvFMufFSarmlD+djKczI+hP5lVRviFJCbfeULcSLytlcVuh5bNsbIWKUGFX
	 NiJcf96zy8rCQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 11/57] irqdomain: Drop of_node_to_fwnode()
Date: Wed, 19 Mar 2025 10:29:04 +0100
Message-ID: <20250319092951.37667-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All uses of of_node_to_fwnode() in non-irqdomain code were changed to
"officially" defined of_fwnode_handle(). Therefore, the former can be
dropped along with the last uses in the irqdomain code.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/irqdomain.h | 17 ++++++-----------
 kernel/irq/irqdomain.c    |  4 ++--
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bb7111105296..5eaaf74647ed 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -358,11 +358,6 @@ int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 			   irq_hw_number_t hwirq, int node,
 			   const struct irq_affinity_desc *affinity);
 
-static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
-{
-	return node ? &node->fwnode : NULL;
-}
-
 extern const struct fwnode_operations irqchip_fwnode_ops;
 
 static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
@@ -387,7 +382,7 @@ struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
 static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
 							enum irq_domain_bus_token bus_token)
 {
-	return irq_find_matching_fwnode(of_node_to_fwnode(node), bus_token);
+	return irq_find_matching_fwnode(of_fwnode_handle(node), bus_token);
 }
 
 static inline struct irq_domain *irq_find_host(struct device_node *node)
@@ -407,7 +402,7 @@ static inline struct irq_domain *irq_domain_add_simple(struct device_node *of_no
 						       const struct irq_domain_ops *ops,
 						       void *host_data)
 {
-	return irq_domain_create_simple(of_node_to_fwnode(of_node), size, first_irq, ops, host_data);
+	return irq_domain_create_simple(of_fwnode_handle(of_node), size, first_irq, ops, host_data);
 }
 
 /**
@@ -423,7 +418,7 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_node_to_fwnode(of_node),
+		.fwnode		= of_fwnode_handle(of_node),
 		.size		= size,
 		.hwirq_max	= size,
 		.ops		= ops,
@@ -442,7 +437,7 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_node_to_fwnode(of_node),
+		.fwnode		= of_fwnode_handle(of_node),
 		.hwirq_max	= max_irq,
 		.direct_max	= max_irq,
 		.ops		= ops,
@@ -462,7 +457,7 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_node_to_fwnode(of_node),
+		.fwnode		= of_fwnode_handle(of_node),
 		.hwirq_max	= ~0U,
 		.ops		= ops,
 		.host_data	= host_data,
@@ -611,7 +606,7 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 					    void *host_data)
 {
 	return irq_domain_create_hierarchy(parent, flags, size,
-					   of_node_to_fwnode(node),
+					   of_fwnode_handle(node),
 					   ops, host_data);
 }
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9d5c8651492d..abed179737c2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -502,7 +502,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return irq_domain_create_legacy(of_node_to_fwnode(of_node), size,
+	return irq_domain_create_legacy(of_fwnode_handle(of_node), size,
 					first_irq, first_hwirq, ops, host_data);
 }
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
@@ -885,7 +885,7 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 {
 	int i;
 
-	fwspec->fwnode = of_node_to_fwnode(np);
+	fwspec->fwnode = of_fwnode_handle(np);
 	fwspec->param_count = count;
 
 	for (i = 0; i < count; i++)
-- 
2.49.0


