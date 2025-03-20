Return-Path: <linux-kernel+bounces-569040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4FA69DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BF11899689
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E51EA7FF;
	Thu, 20 Mar 2025 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHGWI+Nt"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424501E8333
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435774; cv=none; b=nJi3wbfeVzF6z0LFxpxfTULNNilXGe1iQ8imkHCFHi7R+xdkE4ezoX3mfFf18WuSjq6pY5BEHIGgR3dQG+HNs6ixWYy7u0COMNrOAO1ij3VFN78ilyqBSeLzlS7wXJnROBNIFtzmF/MfsjN3sL9s7oLKxGRYVnwfENZfFfrfIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435774; c=relaxed/simple;
	bh=k7RDAx3xoI4pqGJXQp68W490a+QzrtAcauNfkoY0EjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GFrf+5RcUM3SJXejeHOoawTbuacmoGRq7f0Yxzaq5DAZY1J3svy3+eGtE4mb+8HDslAKRQmSczNUQw5SChcgsu0L6ty5HEckrPiok2z0tEUGVRInpVIymGebOXneQ9D6PUv7xhxL8fhIgtyAmlj3sXtyznftkJGUoEWnQVrS0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHGWI+Nt; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-223f3357064so2460425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435771; x=1743040571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfibToy0nGoCGguqNLW86QgSIt/epNH6HRSzzhgRgfw=;
        b=MHGWI+Ntp/O0cwKtnqUeC+O20IcYDk1rUqvgBVCL2pNPGUk94PGXBMfqFV0WOOo0E8
         c0kZ6upDwCVUqTiGG0/BE8feHFSqybmHFOxQtA+IS6aw4wuFlCkgCs1TIttrKkRpFn1k
         ZgLcHVQ624U7aUgmqDulGNtrdn9BqmqSpRUUX2/t3/JFOvdklPuY8X0CWZx+dAL5XOh7
         9kDn0a6BrN7ZnEOkR/c94rN7jECbUxA7n33cVqbd1lK7ten6LV4W2YrofY4E9J9HN18t
         N2hIuQUu/FpTtvsk2pxW8JWlAHrPxOhaDvWHYCga6xbFiJ9R54PeDiQf7X2mJO9nGiAO
         80Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435771; x=1743040571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfibToy0nGoCGguqNLW86QgSIt/epNH6HRSzzhgRgfw=;
        b=cwrylFWYXOk8Ni/lz7beX/2Rwbv+tZoKd/zjuIEToYX9oeKqrYFGtofJVR6vskurDg
         Te0i6Tbaj2y6MQ/abvA0W+nvKnnK2FlZYqFJFsiSbsHkIo0HsBF9qf0SpajPiI6mDTCL
         XCNEa5+OwyLiL39wNWmgx4s+dtqUS7NtKeqoDIw3S/y8hEyD+AKV+qJ0hTBCLzjQJQqF
         cGxufqaJFgTp01WfZ07ySpraqpVc356uhKGRI7OBxQuqhy++CL+mwJfVmx40C/G/ffLs
         jhBYyXaebY+cmKQFFTEAzXUqV4ueQucUQ8N6FgGdZR+UWMreJxUXq1lp4tvlxPw/4Aq8
         +JqQ==
X-Gm-Message-State: AOJu0Ywy36IdnV/a8GumR9p1N81StJdsHyLPdIZCMvqWnnIz8TU3Lj43
	NggqxF3GXUuY7GEGdxxWSMuiHNUQ8om5dtJmFqC1qAo8CoXqpIWu9w3L9ZSMrOH804nFkipSHlq
	HL5sFFFLlHBdYYP7yKQOaEwUC56SkPuqoA8hknqXX0qzarOxG8aySAVPKe7b+BO3RpmGVgOmI34
	u6yFUsR4JshfylWNL6li61m02Oc/wCNYbO0MTgYKelgmvEDrLZIHvXXiv42bdpXw==
X-Google-Smtp-Source: AGHT+IHonsyQBMv9RBxtQtceR/ApPbVZwOG1MadGL1Le7a4EopOnz4DX+w8JLu4FBcso+eobsS8t+IumlBcRGPW6
X-Received: from plbi21.prod.google.com ([2002:a17:903:20d5:b0:223:5c58:1855])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c8:b0:224:1294:1d26 with SMTP id d9443c01a7336-2265edbf303mr23035225ad.13.1742435771495;
 Wed, 19 Mar 2025 18:56:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:42 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-8-changyuanl@google.com>
Subject: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexander Graf <graf@amazon.com>

Add the core infrastructure to generate Kexec HandOver metadata. Kexec
HandOver is a mechanism that allows Linux to preserve state - arbitrary
properties as well as memory locations - across kexec.

It does so using 2 concepts:

  1) State Tree - Every KHO kexec carries a state tree that describes the
     state of the system. The state tree is represented as hash-tables.
     Device drivers can add/remove their data into/from the state tree at
     system runtime. On kexec, the tree is converted to FDT (flattened
     device tree).

  2) Scratch Regions - CMA regions that we allocate in the first kernel.
     CMA gives us the guarantee that no handover pages land in those
     regions, because handover pages must be at a static physical memory
     location. We use these regions as the place to load future kexec
     images so that they won't collide with any handover data.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 MAINTAINERS                    |   2 +-
 include/linux/kexec_handover.h | 109 +++++
 kernel/Makefile                |   1 +
 kernel/kexec_handover.c        | 865 +++++++++++++++++++++++++++++++++
 mm/mm_init.c                   |   8 +
 5 files changed, 984 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kexec_handover.h
 create mode 100644 kernel/kexec_handover.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 12852355bd66..a000a277ccf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12828,7 +12828,7 @@ F:	include/linux/kernfs.h
 KEXEC
 L:	kexec@lists.infradead.org
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
-F:	include/linux/kexec.h
+F:	include/linux/kexec*.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
 
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
new file mode 100644
index 000000000000..9cd9ad31e2d1
--- /dev/null
+++ b/include/linux/kexec_handover.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_H
+#define LINUX_KEXEC_HANDOVER_H
+
+#include <linux/types.h>
+#include <linux/hashtable.h>
+#include <linux/notifier.h>
+
+struct kho_scratch {
+	phys_addr_t addr;
+	phys_addr_t size;
+};
+
+/* KHO Notifier index */
+enum kho_event {
+	KEXEC_KHO_FINALIZE = 0,
+	KEXEC_KHO_UNFREEZE = 1,
+};
+
+#define KHO_HASHTABLE_BITS 3
+#define KHO_NODE_INIT                                        \
+	{                                                    \
+		.props = HASHTABLE_INIT(KHO_HASHTABLE_BITS), \
+		.nodes = HASHTABLE_INIT(KHO_HASHTABLE_BITS), \
+	}
+
+struct kho_node {
+	struct hlist_node hlist;
+
+	const char *name;
+	DECLARE_HASHTABLE(props, KHO_HASHTABLE_BITS);
+	DECLARE_HASHTABLE(nodes, KHO_HASHTABLE_BITS);
+
+	struct list_head list;
+	bool visited;
+};
+
+#ifdef CONFIG_KEXEC_HANDOVER
+bool kho_is_enabled(void);
+void kho_init_node(struct kho_node *node);
+int kho_add_node(struct kho_node *parent, const char *name,
+		 struct kho_node *child);
+struct kho_node *kho_remove_node(struct kho_node *parent, const char *name);
+int kho_add_prop(struct kho_node *node, const char *key, const void *val,
+		 u32 size);
+void *kho_remove_prop(struct kho_node *node, const char *key, u32 *size);
+int kho_add_string_prop(struct kho_node *node, const char *key,
+			const char *val);
+
+int register_kho_notifier(struct notifier_block *nb);
+int unregister_kho_notifier(struct notifier_block *nb);
+
+void kho_memory_init(void);
+#else
+static inline bool kho_is_enabled(void)
+{
+	return false;
+}
+
+static inline void kho_init_node(struct kho_node *node)
+{
+}
+
+static inline int kho_add_node(struct kho_node *parent, const char *name,
+			       struct kho_node *child)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct kho_node *kho_remove_node(struct kho_node *parent,
+					       const char *name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int kho_add_prop(struct kho_node *node, const char *key,
+			       const void *val, u32 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void *kho_remove_prop(struct kho_node *node, const char *key,
+				    u32 *size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int kho_add_string_prop(struct kho_node *node, const char *key,
+				      const char *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int register_kho_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void kho_memory_init(void)
+{
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
+#endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..cef5377c25cd 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
new file mode 100644
index 000000000000..df0d9debbb64
--- /dev/null
+++ b/kernel/kexec_handover.c
@@ -0,0 +1,865 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover.c - kexec handover metadata processing
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2024 Google LLC
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include <linux/cma.h>
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/debugfs.h>
+#include <linux/memblock.h>
+#include <linux/notifier.h>
+#include <linux/kexec_handover.h>
+#include <linux/page-isolation.h>
+#include <linux/rwsem.h>
+#include <linux/xxhash.h>
+/*
+ * KHO is tightly coupled with mm init and needs access to some of mm
+ * internal APIs.
+ */
+#include "../mm/internal.h"
+#include "kexec_internal.h"
+
+static bool kho_enable __ro_after_init;
+
+bool kho_is_enabled(void)
+{
+	return kho_enable;
+}
+EXPORT_SYMBOL_GPL(kho_is_enabled);
+
+static int __init kho_parse_enable(char *p)
+{
+	return kstrtobool(p, &kho_enable);
+}
+early_param("kho", kho_parse_enable);
+
+/*
+ * With KHO enabled, memory can become fragmented because KHO regions may
+ * be anywhere in physical address space. The scratch regions give us a
+ * safe zones that we will never see KHO allocations from. This is where we
+ * can later safely load our new kexec images into and then use the scratch
+ * area for early allocations that happen before page allocator is
+ * initialized.
+ */
+static struct kho_scratch *kho_scratch;
+static unsigned int kho_scratch_cnt;
+
+static struct dentry *debugfs_root;
+
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+
+	struct debugfs_blob_wrapper fdt_wrapper;
+	struct dentry *fdt_file;
+	struct dentry *dir;
+
+	struct rw_semaphore tree_lock;
+	struct kho_node root;
+
+	void *fdt;
+	u64 fdt_max;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.tree_lock = __RWSEM_INITIALIZER(kho_out.tree_lock),
+	.root = KHO_NODE_INIT,
+	.fdt_max = 10 * SZ_1M,
+};
+
+int register_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_kho_notifier);
+
+int unregister_kho_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&kho_out.chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_kho_notifier);
+
+/* Helper functions for KHO state tree */
+
+struct kho_prop {
+	struct hlist_node hlist;
+
+	const char *key;
+	const void *val;
+	u32 size;
+};
+
+static unsigned long strhash(const char *s)
+{
+	return xxhash(s, strlen(s), 1120);
+}
+
+void kho_init_node(struct kho_node *node)
+{
+	hash_init(node->props);
+	hash_init(node->nodes);
+}
+EXPORT_SYMBOL_GPL(kho_init_node);
+
+/**
+ * kho_add_node - add a child node to a parent node.
+ * @parent: parent node to add to.
+ * @name: name of the child node.
+ * @child: child node to be added to @parent with @name.
+ *
+ * If @parent is NULL, @child is added to KHO state tree root node.
+ *
+ * @child must be a valid pointer through KHO FDT finalization.
+ * @name is duplicated and thus can have a short lifetime.
+ *
+ * Callers must use their own locking if there are concurrent accesses to
+ * @parent or @child.
+ *
+ * Return: 0 on success, 1 if @child is already in @parent with @name, or
+ *   - -EOPNOTSUPP: KHO is not enabled in the kernel command line,
+ *   - -ENOMEM: failed to duplicate @name,
+ *   - -EBUSY: KHO state tree has been converted to FDT,
+ *   - -EEXIST: another node of the same name has been added to the parent.
+ */
+int kho_add_node(struct kho_node *parent, const char *name,
+		 struct kho_node *child)
+{
+	unsigned long name_hash;
+	int ret = 0;
+	struct kho_node *node;
+	char *child_name;
+
+	if (!kho_enable)
+		return -EOPNOTSUPP;
+
+	if (!parent)
+		parent = &kho_out.root;
+
+	child_name = kstrdup(name, GFP_KERNEL);
+	if (!child_name)
+		return -ENOMEM;
+
+	name_hash = strhash(child_name);
+
+	if (parent == &kho_out.root)
+		down_write(&kho_out.tree_lock);
+	else
+		down_read(&kho_out.tree_lock);
+
+	if (kho_out.fdt) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	hash_for_each_possible(parent->nodes, node, hlist, name_hash) {
+		if (!strcmp(node->name, child_name)) {
+			ret = node == child ? 1 : -EEXIST;
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		child->name = child_name;
+		hash_add(parent->nodes, &child->hlist, name_hash);
+	}
+
+out:
+	if (parent == &kho_out.root)
+		up_write(&kho_out.tree_lock);
+	else
+		up_read(&kho_out.tree_lock);
+
+	if (ret)
+		kfree(child_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kho_add_node);
+
+/**
+ * kho_remove_node - remove a child node from a parent node.
+ * @parent: parent node to look up for.
+ * @name: name of the child node.
+ *
+ * If @parent is NULL, KHO state tree root node is looked up.
+ *
+ * Callers must use their own locking if there are concurrent accesses to
+ * @parent or @child.
+ *
+ * Return: the pointer to the child node on success, or an error pointer,
+ *   - -EOPNOTSUPP: KHO is not enabled in the kernel command line,
+ *   - -ENOENT: no node named @name is found.
+ *   - -EBUSY: KHO state tree has been converted to FDT.
+ */
+struct kho_node *kho_remove_node(struct kho_node *parent, const char *name)
+{
+	struct kho_node *child, *ret = ERR_PTR(-ENOENT);
+	unsigned long name_hash;
+
+	if (!kho_enable)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!parent)
+		parent = &kho_out.root;
+
+	name_hash = strhash(name);
+
+	if (parent == &kho_out.root)
+		down_write(&kho_out.tree_lock);
+	else
+		down_read(&kho_out.tree_lock);
+
+	if (kho_out.fdt) {
+		ret = ERR_PTR(-EBUSY);
+		goto out;
+	}
+
+	hash_for_each_possible(parent->nodes, child, hlist, name_hash) {
+		if (!strcmp(child->name, name)) {
+			ret = child;
+			break;
+		}
+	}
+
+	if (!IS_ERR(ret)) {
+		hash_del(&ret->hlist);
+		kfree(ret->name);
+		ret->name = NULL;
+	}
+
+out:
+	if (parent == &kho_out.root)
+		up_write(&kho_out.tree_lock);
+	else
+		up_read(&kho_out.tree_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kho_remove_node);
+
+/**
+ * kho_add_prop - add a property to a node.
+ * @node: KHO node to add the property to.
+ * @key: key of the property.
+ * @val: pointer to the property value.
+ * @size: size of the property value in bytes.
+ *
+ * @val and @key must be valid pointers through KHO FDT finalization.
+ * Generally @key is a string literal with static lifetime.
+ *
+ * Callers must use their own locking if there are concurrent accesses to @node.
+ *
+ * Return: 0 on success, 1 if the value is already added with @key, or
+ *   - -ENOMEM: failed to allocate memory,
+ *   - -EBUSY: KHO state tree has been converted to FDT,
+ *   - -EEXIST: another property of the same key exists.
+ */
+int kho_add_prop(struct kho_node *node, const char *key, const void *val,
+		 u32 size)
+{
+	unsigned long key_hash;
+	int ret = 0;
+	struct kho_prop *prop, *p;
+
+	key_hash = strhash(key);
+	prop = kmalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	prop->key = key;
+	prop->val = val;
+	prop->size = size;
+
+	down_read(&kho_out.tree_lock);
+	if (kho_out.fdt) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	hash_for_each_possible(node->props, p, hlist, key_hash) {
+		if (!strcmp(p->key, key)) {
+			ret = (p->val == val && p->size == size) ? 1 : -EEXIST;
+			break;
+		}
+	}
+
+	if (!ret)
+		hash_add(node->props, &prop->hlist, key_hash);
+
+out:
+	up_read(&kho_out.tree_lock);
+
+	if (ret)
+		kfree(prop);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kho_add_prop);
+
+/**
+ * kho_add_string_prop - add a string property to a node.
+ *
+ * See kho_add_prop() for details.
+ */
+int kho_add_string_prop(struct kho_node *node, const char *key, const char *val)
+{
+	return kho_add_prop(node, key, val, strlen(val) + 1);
+}
+EXPORT_SYMBOL_GPL(kho_add_string_prop);
+
+/**
+ * kho_remove_prop - remove a property from a node.
+ * @node: KHO node to remove the property from.
+ * @key: key of the property.
+ * @size: if non-NULL, the property size is stored in it on success.
+ *
+ * Callers must use their own locking if there are concurrent accesses to @node.
+ *
+ * Return: the pointer to the property value, or
+ *   - -EBUSY: KHO state tree has been converted to FDT,
+ *   - -ENOENT: no property with @key is found.
+ */
+void *kho_remove_prop(struct kho_node *node, const char *key, u32 *size)
+{
+	struct kho_prop *p, *prop = NULL;
+	unsigned long key_hash;
+	void *ret = ERR_PTR(-ENOENT);
+
+	key_hash = strhash(key);
+
+	down_read(&kho_out.tree_lock);
+
+	if (kho_out.fdt) {
+		ret = ERR_PTR(-EBUSY);
+		goto out;
+	}
+
+	hash_for_each_possible(node->props, p, hlist, key_hash) {
+		if (!strcmp(p->key, key)) {
+			prop = p;
+			break;
+		}
+	}
+
+	if (prop) {
+		ret = (void *)prop->val;
+		if (size)
+			*size = prop->size;
+		hash_del(&prop->hlist);
+		kfree(prop);
+	}
+
+out:
+	up_read(&kho_out.tree_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kho_remove_prop);
+
+static int kho_out_update_debugfs_fdt(void)
+{
+	int err = 0;
+
+	if (kho_out.fdt) {
+		kho_out.fdt_wrapper.data = kho_out.fdt;
+		kho_out.fdt_wrapper.size = fdt_totalsize(kho_out.fdt);
+		kho_out.fdt_file = debugfs_create_blob("fdt", 0400, kho_out.dir,
+						       &kho_out.fdt_wrapper);
+		if (IS_ERR(kho_out.fdt_file))
+			err = -ENOENT;
+	} else {
+		debugfs_remove(kho_out.fdt_file);
+	}
+
+	return err;
+}
+
+static int kho_unfreeze(void)
+{
+	int err;
+	void *fdt;
+
+	down_write(&kho_out.tree_lock);
+	fdt = kho_out.fdt;
+	kho_out.fdt = NULL;
+	up_write(&kho_out.tree_lock);
+
+	if (fdt)
+		kvfree(fdt);
+
+	err = blocking_notifier_call_chain(&kho_out.chain_head,
+					   KEXEC_KHO_UNFREEZE, NULL);
+	err = notifier_to_errno(err);
+
+	return notifier_to_errno(err);
+}
+
+static int kho_flatten_tree(void *fdt)
+{
+	int iter, err = 0;
+	struct kho_node *node, *sub_node;
+	struct list_head *ele;
+	struct kho_prop *prop;
+	LIST_HEAD(stack);
+
+	kho_out.root.visited = false;
+	list_add(&kho_out.root.list, &stack);
+
+	for (ele = stack.next; !list_is_head(ele, &stack); ele = stack.next) {
+		node = list_entry(ele, struct kho_node, list);
+
+		if (node->visited) {
+			err = fdt_end_node(fdt);
+			if (err)
+				return err;
+			list_del_init(ele);
+			continue;
+		}
+
+		err = fdt_begin_node(fdt, node->name);
+		if (err)
+			return err;
+
+		hash_for_each(node->props, iter, prop, hlist) {
+			err = fdt_property(fdt, prop->key, prop->val,
+					   prop->size);
+			if (err)
+				return err;
+		}
+
+		hash_for_each(node->nodes, iter, sub_node, hlist) {
+			sub_node->visited = false;
+			list_add(&sub_node->list, &stack);
+		}
+
+		node->visited = true;
+	}
+
+	return 0;
+}
+
+static int kho_convert_tree(void *buffer, int size)
+{
+	void *fdt = buffer;
+	int err = 0;
+
+	err = fdt_create(fdt, size);
+	if (err)
+		goto out;
+
+	err = fdt_finish_reservemap(fdt);
+	if (err)
+		goto out;
+
+	err = kho_flatten_tree(fdt);
+	if (err)
+		goto out;
+
+	err = fdt_finish(fdt);
+	if (err)
+		goto out;
+
+	err = fdt_check_header(fdt);
+	if (err)
+		goto out;
+
+out:
+	if (err) {
+		pr_err("failed to flatten state tree: %d\n", err);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int kho_finalize(void)
+{
+	int err = 0;
+	void *fdt;
+
+	fdt = kvmalloc(kho_out.fdt_max, GFP_KERNEL);
+	if (!fdt)
+		return -ENOMEM;
+
+	err = blocking_notifier_call_chain(&kho_out.chain_head,
+					   KEXEC_KHO_FINALIZE, NULL);
+	err = notifier_to_errno(err);
+	if (err)
+		goto unfreeze;
+
+	down_write(&kho_out.tree_lock);
+	kho_out.fdt = fdt;
+	up_write(&kho_out.tree_lock);
+
+	err = kho_convert_tree(fdt, kho_out.fdt_max);
+
+unfreeze:
+	if (err) {
+		int abort_err;
+
+		pr_err("Failed to convert KHO state tree: %d\n", err);
+
+		abort_err = kho_unfreeze();
+		if (abort_err)
+			pr_err("Failed to abort KHO state tree: %d\n",
+			       abort_err);
+	}
+
+	return err;
+}
+
+/* Handling for debug/kho/out */
+static int kho_out_finalize_get(void *data, u64 *val)
+{
+	*val = !!kho_out.fdt;
+
+	return 0;
+}
+
+static int kho_out_finalize_set(void *data, u64 _val)
+{
+	int ret = 0;
+	bool val = !!_val;
+
+	if (!kexec_trylock())
+		return -EBUSY;
+
+	if (val == !!kho_out.fdt) {
+		if (kho_out.fdt)
+			ret = -EEXIST;
+		else
+			ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (val)
+		ret = kho_finalize();
+	else
+		ret = kho_unfreeze();
+
+	if (ret)
+		goto unlock;
+
+	ret = kho_out_update_debugfs_fdt();
+
+unlock:
+	kexec_unlock();
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_finalize, kho_out_finalize_get,
+			 kho_out_finalize_set, "%llu\n");
+
+static int kho_out_fdt_max_get(void *data, u64 *val)
+{
+	*val = kho_out.fdt_max;
+
+	return 0;
+}
+
+static int kho_out_fdt_max_set(void *data, u64 val)
+{
+	int ret = 0;
+
+	if (!kexec_trylock()) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	/* FDT already exists, it's too late to change fdt_max */
+	if (kho_out.fdt) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	kho_out.fdt_max = val;
+
+unlock:
+	kexec_unlock();
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_kho_out_fdt_max, kho_out_fdt_max_get,
+			 kho_out_fdt_max_set, "%llu\n");
+
+static int scratch_phys_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].addr);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_phys);
+
+static int scratch_len_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < kho_scratch_cnt; i++)
+		seq_printf(m, "0x%llx\n", kho_scratch[i].size);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(scratch_len);
+
+static __init int kho_out_debugfs_init(void)
+{
+	struct dentry *dir, *f;
+
+	dir = debugfs_create_dir("out", debugfs_root);
+	if (IS_ERR(dir))
+		return -ENOMEM;
+
+	f = debugfs_create_file("scratch_phys", 0400, dir, NULL,
+				&scratch_phys_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("scratch_len", 0400, dir, NULL,
+				&scratch_len_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("fdt_max", 0600, dir, NULL,
+				&fops_kho_out_fdt_max);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	f = debugfs_create_file("finalize", 0600, dir, NULL,
+				&fops_kho_out_finalize);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
+	kho_out.dir = dir;
+	return 0;
+
+err_rmdir:
+	debugfs_remove_recursive(dir);
+	return -ENOENT;
+}
+
+static __init int kho_init(void)
+{
+	int err;
+
+	if (!kho_enable)
+		return 0;
+
+	kho_out.root.name = "";
+	err = kho_add_string_prop(&kho_out.root, "compatible", "kho-v1");
+	if (err)
+		goto err_free_scratch;
+
+	debugfs_root = debugfs_create_dir("kho", NULL);
+	if (IS_ERR(debugfs_root)) {
+		err = -ENOENT;
+		goto err_free_scratch;
+	}
+
+	err = kho_out_debugfs_init();
+	if (err)
+		goto err_free_scratch;
+
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
+		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
+		unsigned long pfn;
+
+		for (pfn = base_pfn; pfn < base_pfn + count;
+		     pfn += pageblock_nr_pages)
+			init_cma_reserved_pageblock(pfn_to_page(pfn));
+	}
+
+	return 0;
+
+err_free_scratch:
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		void *start = __va(kho_scratch[i].addr);
+		void *end = start + kho_scratch[i].size;
+
+		free_reserved_area(start, end, -1, "");
+	}
+	kho_enable = false;
+	return err;
+}
+late_initcall(kho_init);
+
+/*
+ * The scratch areas are scaled by default as percent of memory allocated from
+ * memblock. A user can override the scale with command line parameter:
+ *
+ * kho_scratch=N%
+ *
+ * It is also possible to explicitly define size for a lowmem, a global and
+ * per-node scratch areas:
+ *
+ * kho_scratch=l[KMG],n[KMG],m[KMG]
+ *
+ * The explicit size definition takes precedence over scale definition.
+ */
+static unsigned int scratch_scale __initdata = 200;
+static phys_addr_t scratch_size_global __initdata;
+static phys_addr_t scratch_size_pernode __initdata;
+static phys_addr_t scratch_size_lowmem __initdata;
+
+static int __init kho_parse_scratch_size(char *p)
+{
+	unsigned long size, size_pernode, size_global;
+	char *endptr, *oldp = p;
+
+	if (!p)
+		return -EINVAL;
+
+	size = simple_strtoul(p, &endptr, 0);
+	if (*endptr == '%') {
+		scratch_scale = size;
+		pr_notice("scratch scale is %d percent\n", scratch_scale);
+	} else {
+		size = memparse(p, &p);
+		if (!size || p == oldp)
+			return -EINVAL;
+
+		if (*p != ',')
+			return -EINVAL;
+
+		oldp = p;
+		size_global = memparse(p + 1, &p);
+		if (!size_global || p == oldp)
+			return -EINVAL;
+
+		if (*p != ',')
+			return -EINVAL;
+
+		size_pernode = memparse(p + 1, &p);
+		if (!size_pernode)
+			return -EINVAL;
+
+		scratch_size_lowmem = size;
+		scratch_size_global = size_global;
+		scratch_size_pernode = size_pernode;
+		scratch_scale = 0;
+
+		pr_notice("scratch areas: lowmem: %lluMB global: %lluMB pernode: %lldMB\n",
+			  (u64)(scratch_size_lowmem >> 20),
+			  (u64)(scratch_size_global >> 20),
+			  (u64)(scratch_size_pernode >> 20));
+	}
+
+	return 0;
+}
+early_param("kho_scratch", kho_parse_scratch_size);
+
+static void __init scratch_size_update(void)
+{
+	phys_addr_t size;
+
+	if (!scratch_scale)
+		return;
+
+	size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
+					   NUMA_NO_NODE);
+	size = size * scratch_scale / 100;
+	scratch_size_lowmem = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+
+	size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+					   NUMA_NO_NODE);
+	size = size * scratch_scale / 100 - scratch_size_lowmem;
+	scratch_size_global = round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+}
+
+static phys_addr_t __init scratch_size_node(int nid)
+{
+	phys_addr_t size;
+
+	if (scratch_scale) {
+		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
+						   nid);
+		size = size * scratch_scale / 100;
+	} else {
+		size = scratch_size_pernode;
+	}
+
+	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
+}
+
+/**
+ * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
+ *
+ * With KHO we can preserve arbitrary pages in the system. To ensure we still
+ * have a large contiguous region of memory when we search the physical address
+ * space for target memory, let's make sure we always have a large CMA region
+ * active. This CMA region will only be used for movable pages which are not a
+ * problem for us during KHO because we can just move them somewhere else.
+ */
+static void __init kho_reserve_scratch(void)
+{
+	phys_addr_t addr, size;
+	int nid, i = 0;
+
+	if (!kho_enable)
+		return;
+
+	scratch_size_update();
+
+	/* FIXME: deal with node hot-plug/remove */
+	kho_scratch_cnt = num_online_nodes() + 2;
+	size = kho_scratch_cnt * sizeof(*kho_scratch);
+	kho_scratch = memblock_alloc(size, PAGE_SIZE);
+	if (!kho_scratch)
+		goto err_disable_kho;
+
+	/*
+	 * reserve scratch area in low memory for lowmem allocations in the
+	 * next kernel
+	 */
+	size = scratch_size_lowmem;
+	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
+					 ARCH_LOW_ADDRESS_LIMIT);
+	if (!addr)
+		goto err_free_scratch_desc;
+
+	kho_scratch[i].addr = addr;
+	kho_scratch[i].size = size;
+	i++;
+
+	/* reserve large contiguous area for allocations without nid */
+	size = scratch_size_global;
+	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
+	if (!addr)
+		goto err_free_scratch_areas;
+
+	kho_scratch[i].addr = addr;
+	kho_scratch[i].size = size;
+	i++;
+
+	for_each_online_node(nid) {
+		size = scratch_size_node(nid);
+		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
+						0, MEMBLOCK_ALLOC_ACCESSIBLE,
+						nid, true);
+		if (!addr)
+			goto err_free_scratch_areas;
+
+		kho_scratch[i].addr = addr;
+		kho_scratch[i].size = size;
+		i++;
+	}
+
+	return;
+
+err_free_scratch_areas:
+	for (i--; i >= 0; i--)
+		memblock_phys_free(kho_scratch[i].addr, kho_scratch[i].size);
+err_free_scratch_desc:
+	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
+err_disable_kho:
+	kho_enable = false;
+}
+
+void __init kho_memory_init(void)
+{
+	kho_reserve_scratch();
+}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 04441c258b05..757659b7a26b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -30,6 +30,7 @@
 #include <linux/crash_dump.h>
 #include <linux/execmem.h>
 #include <linux/vmstat.h>
+#include <linux/kexec_handover.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -2661,6 +2662,13 @@ void __init mm_core_init(void)
 	report_meminit();
 	kmsan_init_shadow();
 	stack_depot_early_init();
+
+	/*
+	 * KHO memory setup must happen while memblock is still active, but
+	 * as close as possible to buddy initialization
+	 */
+	kho_memory_init();
+
 	mem_init();
 	kmem_cache_init();
 	/*
-- 
2.48.1.711.g2feabab25a-goog


