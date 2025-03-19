Return-Path: <linux-kernel+bounces-567583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2EA68821
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C82D3AF44C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C02561C5;
	Wed, 19 Mar 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE7WoUyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F26253F17
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376678; cv=none; b=hcgvjmbNnYbaxBv/sAyev1N2D4kFkc1+0My7o6JrYu3xBagUWFgF/nFAnKYBtsl21Rg6dpcgCp0d5/n8IZCs/o4tbJDQEycwVQMGoccwiQHiMt+3rLb0KBUetNZ5yOuC48Y8v6zYCUrxZx6V2q1npuWQ812NV5MP3Il9+g7fuUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376678; c=relaxed/simple;
	bh=A9JMukVn1ElZ6xIqyhzwrCcloTB2hr9Quxn11wF3+98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwweCKoRfAGEZq21ZoJC53TgNlC//BPRtd2X0VWXM5c0p0gyoL2Iz7WSTMnlVSFNWOIPC0UOdG4E5ACuYRIt8ggCJVk3c6corU2EItq7XQhQrdGDLD64CPn20LbWuS3l8xnSAcgqgLm9WKN1tRXCYTAUzTYM8JYutRGyewIsMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE7WoUyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAAFC4CEEF;
	Wed, 19 Mar 2025 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376677;
	bh=A9JMukVn1ElZ6xIqyhzwrCcloTB2hr9Quxn11wF3+98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZE7WoUywE7NIJKwxx4LNiOeGLPxxz2JC+zz6Kq8I0NxChrQ7BgODXdXQUz7KcJX16
	 bApYzZxNL9101bQbzQzG9OtZDxKIQsjquXHtftT1E1UJJzroTOJt4qTxXCo0aLMjbu
	 4SMcszopxfeauAxnWOCzF67Dhec8L6cnvPntq76ZFPOGwZMRgvazC18tRja4zRUx4a
	 3GDup4AR9XdbP1/nc7+9sBvx/y5Z993boLEa+gV8+O4gt+5/L9FLMER0PXgYk6DgYE
	 O+dboNjI8cK7Cjd5V5TXD45YP1BEkXyazvoJ3FmUxbDiX20YpsZLolQN6dGSGj6q3k
	 jAG0l1/uM5w7A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 12/57] irqdomain: Make irq_domain_create_hierarchy() an inline
Date: Wed, 19 Mar 2025 10:29:05 +0100
Message-ID: <20250319092951.37667-13-jirislaby@kernel.org>
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

There is no reason to export the function as an extra symbol. It is
simple enough and is just a wrapper to already exported functions.

Therefore, switch the exported function to an inline.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/irqdomain.h | 45 +++++++++++++++++++++++++++++++++------
 kernel/irq/irqdomain.c    | 41 -----------------------------------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5eaaf74647ed..1480951a690b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -591,12 +591,45 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 			 void *handler_data, const char *handler_name);
 void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
-					       unsigned int flags,
-					       unsigned int size,
-					       struct fwnode_handle *fwnode,
-					       const struct irq_domain_ops *ops,
-					       void *host_data);
+/**
+ * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
+ * @parent:	Parent irq domain to associate with the new domain
+ * @flags:	Irq domain flags associated to the domain
+ * @size:	Size of the domain. See below
+ * @fwnode:	Optional fwnode of the interrupt controller
+ * @ops:	Pointer to the interrupt domain callbacks
+ * @host_data:	Controller private data pointer
+ *
+ * If @size is 0 a tree domain is created, otherwise a linear domain.
+ *
+ * If successful the parent is associated to the new domain and the
+ * domain flags are set.
+ * Returns pointer to IRQ domain, or NULL on failure.
+ */
+static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
+					    unsigned int flags,
+					    unsigned int size,
+					    struct fwnode_handle *fwnode,
+					    const struct irq_domain_ops *ops,
+					    void *host_data)
+{
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= size,
+		.hwirq_max	= size,
+		.ops		= ops,
+		.host_data	= host_data,
+		.domain_flags	= flags,
+		.parent		= parent,
+	};
+	struct irq_domain *d;
+
+	if (!info.size)
+		info.hwirq_max = ~0U;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
+}
 
 static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
 					    unsigned int flags,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index abed179737c2..b5e111776285 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1252,47 +1252,6 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data)
 EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-/**
- * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
- * @parent:	Parent irq domain to associate with the new domain
- * @flags:	Irq domain flags associated to the domain
- * @size:	Size of the domain. See below
- * @fwnode:	Optional fwnode of the interrupt controller
- * @ops:	Pointer to the interrupt domain callbacks
- * @host_data:	Controller private data pointer
- *
- * If @size is 0 a tree domain is created, otherwise a linear domain.
- *
- * If successful the parent is associated to the new domain and the
- * domain flags are set.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
-					    unsigned int flags,
-					    unsigned int size,
-					    struct fwnode_handle *fwnode,
-					    const struct irq_domain_ops *ops,
-					    void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode		= fwnode,
-		.size		= size,
-		.hwirq_max	= size,
-		.ops		= ops,
-		.host_data	= host_data,
-		.domain_flags	= flags,
-		.parent		= parent,
-	};
-	struct irq_domain *d;
-
-	if (!info.size)
-		info.hwirq_max = ~0U;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-EXPORT_SYMBOL_GPL(irq_domain_create_hierarchy);
-
 static void irq_domain_insert_irq(int virq)
 {
 	struct irq_data *data;
-- 
2.49.0


