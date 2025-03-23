Return-Path: <linux-kernel+bounces-572916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E9A6D06B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9FC188F036
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C518FDBD;
	Sun, 23 Mar 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jx5J+rCi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wn0pd63F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911318DF8D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752298; cv=none; b=N95//GkGjhGb3qerSstbg45tKF+Ts9Jhcg0ElO88qsMGNwOu68kd+/hXt+2ipJjliGG6cyra+lECQ3r/uxIWQpS75WSjpdqOZE7XPvpN7ClNdvMxuPcXfLFnOtc3YYdBQsJ5z7bTumr3s3gu5avNDKAQ8T4hbS9BAaZscE+WfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752298; c=relaxed/simple;
	bh=bgqPLKf8bBysRBQ14NuD0ta4ECPOTBBQXGTuQPpZWAE=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=Pq8aeuqr25THnkX7Jk5Pk8q8dWUpm0uSLHZ7D7VOdaFpY2wkOItdwyZ0Y6KAqVVKTVQMdsb4i6xOi2CGjzQ2XlT8M5HIGEIDworO3kLSEcvmmOUd9Lpijs6z4Q0UImqDnOqFq6QlBVYPZbgb6LX7GDSvDOr3yKrA7QazOSt8H94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jx5J+rCi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wn0pd63F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hrLS7Qtd/Sm79bbGg8yl8cfgBnd/gzzWpXci/QD2pgs=;
	b=jx5J+rCiXs1WYgTB9xlbvH7zW4rdloub6pDUx1il+eKB7Jjo/BfUtaWzQ7SWrQxgXNTTXZ
	c3Gl/EZGCgP6XCums9rpgixrwe+c/HUOg24hupp+JHaMF+QHnxYSF/rGRXseKaua26CAn6
	0hOgCB4Z5JV64si8mXWliGAt3DvFqTX1xv++a7zGWR4t6+etvSz7s6Cf6viDCS8nmzRml6
	9sR4+pTbuDiX+O4CHQ4Str9elGt4GW8AUQ5DqWSCvcs8pok24JqvHafTUqBoo58dJbzEbY
	5XD1IJI1SwfGKDZmMy/s1aH17SXx7X75IwoCd7NL4XGE7HZwFIbv7LTY2qcHsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hrLS7Qtd/Sm79bbGg8yl8cfgBnd/gzzWpXci/QD2pgs=;
	b=Wn0pd63FpyFzwEZqzqOPIQRMcrpo1qytaEiEZYpoarufSGAjqiVb0lfC9P/nAB1gxhM8kv
	6DDGZh+59un4fUBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.15-rc1
Message-ID: <174275225552.1561082.4969731002775597670.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:32 +0100 (CET)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2025-03=
-23

up to:  827bafd527dd: genirq: Make a few functions static


A small set of core changes for the interrupt subsystem:

  - Expose the MSI message in the existing debug filesystem dump. That's
    useful for validation and debugging.

  - Small cleanups

Thanks,

	tglx

------------------>
Hans Zhang (1):
      genirq/msi: Expose MSI message data in debugfs

Jiri Slaby (SUSE) (1):
      irqdomain: Remove extern from function declarations

Thomas Gleixner (1):
      genirq: Make a few functions static


 include/linux/irqdomain.h | 137 +++++++++++++++++++++++---------------------=
--
 kernel/irq/chip.c         |  30 +++++-----
 kernel/irq/internals.h    |   9 ---
 kernel/irq/irqdesc.c      |   2 +-
 kernel/irq/irqdomain.c    |   5 +-
 kernel/irq/manage.c       |   7 ++-
 kernel/irq/msi.c          |  19 +++++++
 7 files changed, 109 insertions(+), 100 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e432b6a12a32..33ff41eef8f7 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -350,13 +350,13 @@ struct irq_domain *irq_domain_create_legacy(struct fwno=
de_handle *fwnode,
 					    irq_hw_number_t first_hwirq,
 					    const struct irq_domain_ops *ops,
 					    void *host_data);
-extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
-						   enum irq_domain_bus_token bus_token);
-extern void irq_set_default_host(struct irq_domain *host);
-extern struct irq_domain *irq_get_default_host(void);
-extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
-				  irq_hw_number_t hwirq, int node,
-				  const struct irq_affinity_desc *affinity);
+struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
+					    enum irq_domain_bus_token bus_token);
+void irq_set_default_host(struct irq_domain *host);
+struct irq_domain *irq_get_default_host(void);
+int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
+			   irq_hw_number_t hwirq, int node,
+			   const struct irq_affinity_desc *affinity);
=20
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *no=
de)
 {
@@ -370,8 +370,8 @@ static inline bool is_fwnode_irqchip(const struct fwnode_=
handle *fwnode)
 	return fwnode && fwnode->ops =3D=3D &irqchip_fwnode_ops;
 }
=20
-extern void irq_domain_update_bus_token(struct irq_domain *domain,
-					enum irq_domain_bus_token bus_token);
+void irq_domain_update_bus_token(struct irq_domain *domain,
+				 enum irq_domain_bus_token bus_token);
=20
 static inline
 struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
@@ -454,7 +454,7 @@ static inline struct irq_domain *irq_domain_add_nomap(str=
uct device_node *of_nod
 	return IS_ERR(d) ? NULL : d;
 }
=20
-extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
+unsigned int irq_create_direct_mapping(struct irq_domain *host);
 #endif
=20
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_=
node,
@@ -507,19 +507,19 @@ static inline struct irq_domain *irq_domain_create_tree=
(struct fwnode_handle *fw
 	return IS_ERR(d) ? NULL : d;
 }
=20
-extern void irq_domain_remove(struct irq_domain *host);
+void irq_domain_remove(struct irq_domain *host);
=20
-extern int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
-					irq_hw_number_t hwirq);
-extern void irq_domain_associate_many(struct irq_domain *domain,
-				      unsigned int irq_base,
-				      irq_hw_number_t hwirq_base, int count);
+int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
+			 irq_hw_number_t hwirq);
+void irq_domain_associate_many(struct irq_domain *domain,
+			       unsigned int irq_base,
+			       irq_hw_number_t hwirq_base, int count);
=20
-extern unsigned int irq_create_mapping_affinity(struct irq_domain *host,
-				      irq_hw_number_t hwirq,
-				      const struct irq_affinity_desc *affinity);
-extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
-extern void irq_dispose_mapping(unsigned int virq);
+unsigned int irq_create_mapping_affinity(struct irq_domain *host,
+					 irq_hw_number_t hwirq,
+					 const struct irq_affinity_desc *affinity);
+unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
+void irq_dispose_mapping(unsigned int virq);
=20
 static inline unsigned int irq_create_mapping(struct irq_domain *host,
 					      irq_hw_number_t hwirq)
@@ -527,9 +527,9 @@ static inline unsigned int irq_create_mapping(struct irq_=
domain *host,
 	return irq_create_mapping_affinity(host, hwirq, NULL);
 }
=20
-extern struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
-					      irq_hw_number_t hwirq,
-					      unsigned int *irq);
+struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
+				       irq_hw_number_t hwirq,
+				       unsigned int *irq);
=20
 static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
 						   irq_hw_number_t hwirq)
@@ -587,19 +587,21 @@ int irq_reserve_ipi(struct irq_domain *domain, const st=
ruct cpumask *dest);
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
=20
 /* V2 interfaces to support hierarchy IRQ domains. */
-extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
-						unsigned int virq);
-extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-				irq_hw_number_t hwirq,
-				const struct irq_chip *chip,
-				void *chip_data, irq_flow_handler_t handler,
-				void *handler_data, const char *handler_name);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
+struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
+					 unsigned int virq);
+void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq,
+			 const struct irq_chip *chip,
+			 void *chip_data, irq_flow_handler_t handler,
+			 void *handler_data, const char *handler_name);
+void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *par=
ent,
-			unsigned int flags, unsigned int size,
-			struct fwnode_handle *fwnode,
-			const struct irq_domain_ops *ops, void *host_data);
+struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
+					       unsigned int flags,
+					       unsigned int size,
+					       struct fwnode_handle *fwnode,
+					       const struct irq_domain_ops *ops,
+					       void *host_data);
=20
 static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain =
*parent,
 					    unsigned int flags,
@@ -613,13 +615,13 @@ static inline struct irq_domain *irq_domain_add_hierarc=
hy(struct irq_domain *par
 					   ops, host_data);
 }
=20
-extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
-				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc,
-				   const struct irq_affinity_desc *affinity);
-extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
-extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
-extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
+int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
+			    unsigned int nr_irqs, int node, void *arg,
+			    bool realloc,
+			    const struct irq_affinity_desc *affinity);
+void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
+int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
+void irq_domain_deactivate_irq(struct irq_data *irq_data);
=20
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -628,32 +630,29 @@ static inline int irq_domain_alloc_irqs(struct irq_doma=
in *domain,
 				       NULL);
 }
=20
-extern int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-					   unsigned int irq_base,
-					   unsigned int nr_irqs, void *arg);
-extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
-					 unsigned int virq,
-					 irq_hw_number_t hwirq,
-					 const struct irq_chip *chip,
-					 void *chip_data);
-extern void irq_domain_free_irqs_common(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs);
-extern void irq_domain_free_irqs_top(struct irq_domain *domain,
-				     unsigned int virq, unsigned int nr_irqs);
-
-extern int irq_domain_push_irq(struct irq_domain *domain, int virq, void *ar=
g);
-extern int irq_domain_pop_irq(struct irq_domain *domain, int virq);
-
-extern int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
-					unsigned int irq_base,
-					unsigned int nr_irqs, void *arg);
-
-extern void irq_domain_free_irqs_parent(struct irq_domain *domain,
-					unsigned int irq_base,
-					unsigned int nr_irqs);
-
-extern int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
+int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
+				  unsigned int virq,
+				  irq_hw_number_t hwirq,
+				  const struct irq_chip *chip,
+				  void *chip_data);
+void irq_domain_free_irqs_common(struct irq_domain *domain,
+				 unsigned int virq,
+				 unsigned int nr_irqs);
+void irq_domain_free_irqs_top(struct irq_domain *domain,
+			      unsigned int virq, unsigned int nr_irqs);
+
+int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg);
+int irq_domain_pop_irq(struct irq_domain *domain, int virq);
+
+int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
+				 unsigned int irq_base,
+				 unsigned int nr_irqs, void *arg);
+
+void irq_domain_free_irqs_parent(struct irq_domain *domain,
+				 unsigned int irq_base,
+				 unsigned int nr_irqs);
+
+int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
 					   unsigned int virq);
=20
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c901436ebd9f..0ff987d3a799 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -232,6 +232,21 @@ __irq_startup_managed(struct irq_desc *desc, const struc=
t cpumask *aff,
 }
 #endif
=20
+static void irq_enable(struct irq_desc *desc)
+{
+	if (!irqd_irq_disabled(&desc->irq_data)) {
+		unmask_irq(desc);
+	} else {
+		irq_state_clr_disabled(desc);
+		if (desc->irq_data.chip->irq_enable) {
+			desc->irq_data.chip->irq_enable(&desc->irq_data);
+			irq_state_clr_masked(desc);
+		} else {
+			unmask_irq(desc);
+		}
+	}
+}
+
 static int __irq_startup(struct irq_desc *desc)
 {
 	struct irq_data *d =3D irq_desc_get_irq_data(desc);
@@ -332,21 +347,6 @@ void irq_shutdown_and_deactivate(struct irq_desc *desc)
 	irq_domain_deactivate_irq(&desc->irq_data);
 }
=20
-void irq_enable(struct irq_desc *desc)
-{
-	if (!irqd_irq_disabled(&desc->irq_data)) {
-		unmask_irq(desc);
-	} else {
-		irq_state_clr_disabled(desc);
-		if (desc->irq_data.chip->irq_enable) {
-			desc->irq_data.chip->irq_enable(&desc->irq_data);
-			irq_state_clr_masked(desc);
-		} else {
-			unmask_irq(desc);
-		}
-	}
-}
-
 static void __irq_disable(struct irq_desc *desc, bool mask)
 {
 	if (irqd_irq_disabled(&desc->irq_data)) {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a979523640d0..556b7132f831 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -90,7 +90,6 @@ extern int irq_startup(struct irq_desc *desc, bool resend, =
bool force);
=20
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
-extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
@@ -98,18 +97,12 @@ extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
=20
-extern unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpum=
ask *cpumask);
-
 #ifdef CONFIG_SPARSE_IRQ
 static inline void irq_mark_irq(unsigned int irq) { }
 #else
 extern void irq_mark_irq(unsigned int irq);
 #endif
=20
-extern int __irq_get_irqchip_state(struct irq_data *data,
-				   enum irqchip_irq_state which,
-				   bool *state);
-
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
@@ -139,8 +132,6 @@ static inline void unregister_handler_proc(unsigned int i=
rq,
=20
 extern bool irq_can_set_affinity_usr(unsigned int irq);
=20
-extern void irq_set_thread_affinity(struct irq_desc *desc);
-
 extern int irq_do_set_affinity(struct irq_data *data,
 			       const struct cpumask *dest, bool force);
=20
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 287830739783..4258cd6bd3b4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -991,7 +991,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
=20
-unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cp=
umask)
+static unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpum=
ask *cpumask)
 {
 	unsigned int sum =3D 0;
 	int cpu;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ec6d8e72d980..2861f89880af 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1589,9 +1589,8 @@ static void irq_domain_free_irqs_hierarchy(struct irq_d=
omain *domain,
 	}
 }
=20
-int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-				    unsigned int irq_base,
-				    unsigned int nr_irqs, void *arg)
+static int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain, unsign=
ed int irq_base,
+					   unsigned int nr_irqs, void *arg)
 {
 	if (!domain->ops->alloc) {
 		pr_debug("domain->ops->alloc() is NULL\n");
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f300bb6be3bd..753eef8e041c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,8 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
=20
+static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_stat=
e which, bool *state);
+
 static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
 	struct irq_data *irqd =3D irq_desc_get_irq_data(desc);
@@ -187,7 +189,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
  *	set_cpus_allowed_ptr() here as we hold desc->lock and this
  *	code can be called from hard interrupt context.
  */
-void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_set_thread_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
=20
@@ -2789,8 +2791,7 @@ void teardown_percpu_nmi(unsigned int irq)
 	irq_put_desc_unlock(desc, flags);
 }
=20
-int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state wh=
ich,
-			    bool *state)
+static int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_s=
tate which, bool *state)
 {
 	struct irq_chip *chip;
 	int err =3D -EINVAL;
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..fa92882efdb1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -756,12 +757,30 @@ static int msi_domain_translate(struct irq_domain *doma=
in, struct irq_fwspec *fw
 	return info->ops->msi_translate(domain, fwspec, hwirq, type);
 }
=20
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
+				  struct irq_data *irqd, int ind)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(irqd);
+
+	if (!desc)
+		return;
+
+	seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "", desc->msg.address_hi);
+	seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "", desc->msg.address_lo);
+	seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "", desc->msg.data);
+}
+#endif
+
 static const struct irq_domain_ops msi_domain_ops =3D {
 	.alloc		=3D msi_domain_alloc,
 	.free		=3D msi_domain_free,
 	.activate	=3D msi_domain_activate,
 	.deactivate	=3D msi_domain_deactivate,
 	.translate	=3D msi_domain_translate,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show     =3D msi_domain_debug_show,
+#endif
 };
=20
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,


