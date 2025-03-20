Return-Path: <linux-kernel+bounces-569048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5CFA69DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BAC19C2604
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC021ABBF;
	Thu, 20 Mar 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQMinOJ9"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73201DF985
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435787; cv=none; b=tvbHELfuy0s4VuEPgvG98thq47eiQcrESPcpOdMRQ5C0bvXslCgikAR1pjDa6u0H1kBy0KKf+r9+Z5x5C0604cL8kWq8wNLJN1WdsWPqawbsIwnE+t95xWgT1Js0bb9f0bU3PgHUCeuRZ7TRRner2wng1KfG+K9KDgoq/JA0MuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435787; c=relaxed/simple;
	bh=qaXI3W/fquZKoC2tWGhwR7n7UZjktLGpU7tPd9W5uhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SG80qv73bi1S7OD0DigT5zGeR50IPpHfj2HJAckZ88pklkm9Kh9n6ofj8qRq018sbBDLqR778i/KAWw2cxdPtmh+a4Ky06l6xfxssnhUHlybKrAv3kay9nu+RmaBlN5sJe0SbngJyBVcY1XsYJUbAr2s+vpxdB73QNnGXdA7Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQMinOJ9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso2236871a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435785; x=1743040585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uiHbtbR2+LTCG9tPghyUo9+PEq69RRB7eOXIX8kmmQ=;
        b=FQMinOJ92HTP6aCjRy2WyvO2U6rhaCkM+a65x+31b8h1H+DE8m5Cdkym1yVdLYd61V
         Kj+x8serh2W8mTvimc+4dREv6cUL+6xjzvB+5qXngvCNtEG6AZ7LDthPtJTuBU5I+FEq
         ZMFnw6VDTQtIY76z9fzME37F60OVyUH/Z96X0F5LDUeNeWzY5feQA9Sdo/6yckfPKiz5
         AYX8YMMvU99Ffoxds2tN0TA9bgYDMlskXY4hloPpEe9zpNQ1O6ttB1gpFtXMzyASZ+I1
         g5QmgQOCq8Qyl588kWn9grnBZm42A54JL1b2YjlXVm0IOyOK2Z9Sg4ETxGW4S9nLxLtx
         VHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435785; x=1743040585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uiHbtbR2+LTCG9tPghyUo9+PEq69RRB7eOXIX8kmmQ=;
        b=lMKDgvUmvQbAKUwLI3Qnr73qP7RNdhmAGdn+hK13K3gF2y1gCJ5LWFfbj4Y/k8gbou
         x0zPcJYjZaRDaAL96pjQvRCzZka5mdbStOU6A7cQR9jWImAXh7qDK2z87i5mYLTh93qG
         MzMx+wSShjOx8M/Sz+K+Xx8hqx6EYSWiWr5Z4/npsL4f0ecUER6oLBa7X7jRkr3fYVnG
         IVhmf7kePhTCMlsGWva1208ARzrYH21f+pLttVLiAQofsav3mku+C6qtvubMZRlO8yjx
         muDwXbeG+Xryrrceyvs05u+xHXQo2jsTTKsWYX0DZWn+DJhRP8rMTHzlkflohsXjMfAJ
         0rLw==
X-Gm-Message-State: AOJu0Yzie8tHEyiifNkKzJqqipG+DIwX+Y05qanEeAq5S8/JFigpTqip
	jvZco4Vx68pYyOKF4viyucVbyzbY2Fg8iRAqpku1qiXvu82lpO7rL+OhGG0dixMwuio/O5QdC7N
	nBiQJWqnfiyEsf8960O0JBaM2wrgA3/xK2FGRLwgsXNkOCzy+el02izlj65vE8KklwPK1fpLEix
	1mnOqSKar8vc9NVCcj2M3uLJLbz3bPqw/7Na0gYlfRKJmtf2aDTMBal3anWFdH2A==
X-Google-Smtp-Source: AGHT+IGco0TbFvrpWaz7RU09LVDLIbrwQOB0hzzeh7i66UCW7yrWSDQtXXKFJgzbGrQWcK/LzqGUCqggvCd+K/bd
X-Received: from pgvr15.prod.google.com ([2002:a65:60cf:0:b0:ad8:bdc2:8a33])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:69c:b0:1f5:8bf4:fde0 with SMTP id adf61e73a8af0-1fd0904c18cmr2493103637.9.1742435784427;
 Wed, 19 Mar 2025 18:56:24 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:50 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-16-changyuanl@google.com>
Subject: [PATCH v5 15/16] memblock: add KHO support for reserve_mem
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

Linux has recently gained support for "reserve_mem": A mechanism to
allocate a region of memory early enough in boot that we can cross our
fingers and hope it stays at the same location during most boots, so we
can store for example ftrace buffers into it.

Thanks to KASLR, we can never be really sure that "reserve_mem"
allocations are static across kexec. Let's teach it KHO awareness so
that it serializes its reservations on kexec exit and deserializes them
again on boot, preserving the exact same mapping across kexec.

This is an example user for KHO in the KHO patch set to ensure we have
at least one (not very controversial) user in the tree before extending
KHO's use to more subsystems.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 mm/memblock.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index d28abf3def1c..dd698c55b87e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -17,6 +17,10 @@
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/kexec_handover.h>
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 #include <asm/sections.h>
 #include <linux/io.h>
 
@@ -2431,6 +2435,176 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
 }
 EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#define MEMBLOCK_KHO_NODE "memblock"
+#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
+#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
+
+static struct kho_node memblock_kho_node = KHO_NODE_INIT;
+
+static void reserve_mem_kho_reset(void)
+{
+	int i;
+	struct kho_node *node;
+
+	kho_remove_node(NULL, MEMBLOCK_KHO_NODE);
+	kho_remove_prop(&memblock_kho_node, "compatible", NULL);
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		node = kho_remove_node(&memblock_kho_node, map->name);
+		if (IS_ERR(node))
+			continue;
+
+		kho_unpreserve_phys(map->start, map->size);
+
+		kho_remove_prop(node, "compatible", NULL);
+		kho_remove_prop(node, "start", NULL);
+		kho_remove_prop(node, "size", NULL);
+
+		kfree(node);
+	}
+}
+
+static int reserve_mem_kho_finalize(void)
+{
+	int i, err = 0;
+	struct kho_node *node;
+
+	if (!reserved_mem_count)
+		return NOTIFY_DONE;
+
+	err = kho_add_node(NULL, MEMBLOCK_KHO_NODE, &memblock_kho_node);
+	if (err == 1)
+		return NOTIFY_DONE;
+
+	err |= kho_add_string_prop(&memblock_kho_node, "compatible",
+				   MEMBLOCK_KHO_NODE_COMPATIBLE);
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		node = kmalloc(sizeof(*node), GFP_KERNEL);
+		if (!node) {
+			err = -ENOMEM;
+			break;
+		}
+
+		err |= kho_preserve_phys(map->start, map->size);
+
+		kho_init_node(node);
+		err |= kho_add_string_prop(node, "compatible",
+					   RESERVE_MEM_KHO_NODE_COMPATIBLE);
+		err |= kho_add_prop(node, "start", &map->start,
+				    sizeof(map->start));
+		err |= kho_add_prop(node, "size", &map->size,
+				    sizeof(map->size));
+		err |= kho_add_node(&memblock_kho_node, map->name, node);
+
+		if (err)
+			break;
+	}
+
+	if (err) {
+		pr_err("failed to save reserve_mem to KHO: %d\n", err);
+		reserve_mem_kho_reset();
+		return NOTIFY_STOP;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int reserve_mem_kho_notifier(struct notifier_block *self,
+				    unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case KEXEC_KHO_FINALIZE:
+		return reserve_mem_kho_finalize();
+	case KEXEC_KHO_UNFREEZE:
+		return NOTIFY_DONE;
+	default:
+		return NOTIFY_BAD;
+	}
+}
+
+static struct notifier_block reserve_mem_kho_nb = {
+	.notifier_call = reserve_mem_kho_notifier,
+};
+
+static int __init reserve_mem_init(void)
+{
+	if (!kho_is_enabled())
+		return 0;
+
+	return register_kho_notifier(&reserve_mem_kho_nb);
+}
+core_initcall(reserve_mem_init);
+
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	int err, len_start, len_size;
+	struct kho_in_node node, child;
+	const phys_addr_t *p_start, *p_size;
+
+	err = kho_get_node(NULL, MEMBLOCK_KHO_NODE, &node);
+	if (err)
+		return false;
+
+	err = kho_node_check_compatible(&node, MEMBLOCK_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("Node '%s' is incompatible with %s: %d\n",
+			MEMBLOCK_KHO_NODE, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
+		return false;
+	}
+
+	err = kho_get_node(&node, name, &child);
+	if (err) {
+		pr_warn("Node '%s' has no child '%s': %d\n",
+			MEMBLOCK_KHO_NODE, name, err);
+		return false;
+	}
+	err = kho_node_check_compatible(&child, RESERVE_MEM_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("Node '%s/%s' is incompatible with %s: %d\n",
+			MEMBLOCK_KHO_NODE, name,
+			RESERVE_MEM_KHO_NODE_COMPATIBLE, err);
+		return false;
+	}
+
+	p_start = kho_get_prop(&child, "start", &len_start);
+	p_size = kho_get_prop(&child, "size", &len_size);
+	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
+	    len_size != sizeof(*p_size)) {
+		return false;
+	}
+
+	if (*p_start & (align - 1)) {
+		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%lx, 0x%lx)\n",
+			name, (long)align, (long)*p_start);
+		return false;
+	}
+
+	if (*p_size != size) {
+		pr_warn("KHO reserve-mem '%s' has wrong size (0x%lx != 0x%lx)\n",
+			name, (long)*p_size, (long)size);
+		return false;
+	}
+
+	reserved_mem_add(*p_start, size, name);
+	pr_info("Revived memory reservation '%s' from KHO\n", name);
+
+	return true;
+}
+#else
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 /*
  * Parse reserve_mem=nn:align:name
  */
@@ -2486,6 +2660,11 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_find_by_name(name, &start, &tmp))
 		return -EBUSY;
 
+	/* Pick previous allocations up from KHO if available */
+	if (reserve_mem_kho_revive(name, size, align))
+		return 1;
+
+	/* TODO: Allocation must be outside of scratch region */
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
-- 
2.48.1.711.g2feabab25a-goog


