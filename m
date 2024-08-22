Return-Path: <linux-kernel+bounces-296724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1895AE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E880D1F235B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA0114D42C;
	Thu, 22 Aug 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j1QKaXk7"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADC13C67A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309771; cv=none; b=uQHJ1PYekssAO3z7V+HfC4woc0BeCWISA4ndyQ5P4+xkpVClypBIfMRwYFmhD7tfkJGeI7DVzPoCFavIx7P7bG02MN4K6GYaRk+Mzp+c2J0TpcRXyL2YskNTHxxV5U2IuTAvwHhottHYdJEjXPGRZWOPRVfh0Sh5IOyj8onZLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309771; c=relaxed/simple;
	bh=zmY296PjwQeTukeX232uZ4N2lzN/Qy5XgkMD4XdJ/uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kkEtof7OAAqa8qqmt2y7KDx+8QCoMjb2tU8vcDlmf2luE34Scs9Un4V4hekRk6QOd1+G9z1tAtMt2+2vPpwKWE5QdRr//ga3/b1N1y1RzGhcmi+iCIWrQ6VnKSddxMS5F/J0xKmXkfNg/aDLXmvt0SlAirb4iZb+Z8EPlMzhxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j1QKaXk7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db16b2c1d2so297435b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724309767; x=1724914567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFDydfkG+agaOlsuZHWg20v17CYJb4VeMMP0Wqz7Dj4=;
        b=j1QKaXk73RK8u+hpUc8AqvDgGW8liQrcMOdufAnO1hV0Tdh/PmKAsLRlkL3WN3FgXy
         0bqxMF6v/VZvChFirImtfbboQXWysLL41qZPKCgVrC921Xn05sGD1o90pxh+04OoVfGu
         Djw3ksfXPPZoVbuG1Alj1lyVu6LZudzjsAY84GMFAS/27BK9HFTokPYvAShbI4yjhOkq
         UR9tZjAyR/v+7aXIiQ7UAFDXsk+jmyj2BFf5eGjkX6yOleaz+kcGfljhJFrjs+On6gyx
         t5rxesM+PBigYJBk0dQx/sbGXjAIj4BInUoxeetg/1oqwieEye86fs1XXUjEmNY6+25M
         2MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309767; x=1724914567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFDydfkG+agaOlsuZHWg20v17CYJb4VeMMP0Wqz7Dj4=;
        b=iXfYU6ZTrxE34S+qznQE2SC8w2ASeqlbbtOeOANUpTerf4DvrMMUOBQbkmvcu/MHqQ
         tMdjzItmK7fqYBn8cLgZvEtxMVrF14hd5l5wX9ni57PRD/vnXr91EkziPS3vDpsYS/oN
         0FjBEVBHwWTFRnbvW6JSAALChtE+GM151i9qtpnuXMmOBM02UFKXlPf9ygFKg9FJySx7
         iWYM3+UUPpM5BYjiV95wxV+xnDJWsyeVkwgF+rs0UsYgUqWCRc3E05o25m2o54gO6qSD
         0HRSpoL3csLewgeZKtjyQUK+gGO48772Qr7Q5P98muJvhsPtWaH1Xa33QWcPUBCiO1la
         p2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCilrybYWQtFjOoWeqkA343/cPJ1dcYy3KV0dClRQOKJK4/J4r1fXDSnw6nC2o+c6tHZyCTMSaftR5qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAPSGMXpgPpoWdTEkzqXFJaHUb/940I39ksiwl/MWt9Httd4o
	0Ke/UBtsSIFe1pmNH3onh+ZzltCIUuH0dFZgltgAuKOa//XERbFNr6xLbN6hiEw=
X-Google-Smtp-Source: AGHT+IFd6nbupeMmch8HYUZLo+nAXaiqmJ1Be/VEMkfQZfY19PJSES7bmK/eG3ZZDnQLO9L42i7OCw==
X-Received: by 2002:a05:6808:3185:b0:3d9:3649:906f with SMTP id 5614622812f47-3de2332620bmr1021309b6e.37.1724309767610;
        Wed, 21 Aug 2024 23:56:07 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acbfc09sm678733a12.37.2024.08.21.23.56.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Aug 2024 23:56:07 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: pbonzini@redhat.com,
	chao.p.peng@linux.intel.com,
	seanjc@google.com,
	Liam.Howlett@oracle.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH RFC] KVM: Use maple tree to manage memory attributes.
Date: Thu, 22 Aug 2024 14:55:44 +0800
Message-Id: <20240822065544.65013-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, xarray is used to manage memory attributes. The memory
attributes management here is an interval problem. However, xarray is
not suitable for handling interval problems. It may cause memory waste
and is not efficient. Switching it to maple tree is more elegant. Using
maple tree here has the following three advantages:
1. Less memory overhead.
2. More efficient interval operations.
3. Simpler code.

This is the first user of the maple tree interface mas_find_range(),
and it does not have any test cases yet, so its stability is unclear.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/kvm_host.h |  5 +++--
 virt/kvm/kvm_main.c      | 47 ++++++++++++++--------------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

I haven't tested this code yet, and I'm not very familiar with kvm, so I'd
be happy if someone could help test it. This is just an RFC now. Any comments
are welcome.

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 79a6b1a63027..9b3351d88d64 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -35,6 +35,7 @@
 #include <linux/interval_tree.h>
 #include <linux/rbtree.h>
 #include <linux/xarray.h>
+#include <linux/maple_tree.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -839,7 +840,7 @@ struct kvm {
 #endif
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	/* Protected by slots_locks (for writes) and RCU (for reads) */
-	struct xarray mem_attr_array;
+	struct maple_tree mem_attr_mtree;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -2410,7 +2411,7 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return xa_to_value(mtree_load(&kvm->mem_attr_mtree, gfn));
 }
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 92901656a0d4..9a99c334f4af 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -10,6 +10,7 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
 
+#include "linux/maple_tree.h"
 #include <kvm/iodev.h>
 
 #include <linux/kvm_host.h>
@@ -1159,7 +1160,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	xa_init(&kvm->mem_attr_array);
+	mt_init_flags(&kvm->mem_attr_mtree, MT_FLAGS_LOCK_EXTERN);
+	mt_set_external_lock(&kvm->mem_attr_mtree, &kvm->slots_lock);
 #endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
@@ -1356,7 +1358,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	cleanup_srcu_struct(&kvm->srcu);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	xa_destroy(&kvm->mem_attr_array);
+	mutex_lock(&kvm->slots_lock);
+	__mt_destroy(&kvm->mem_attr_mtree);
+	mutex_unlock(&kvm->slots_lock);
 #endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
@@ -2413,30 +2417,20 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs)
 {
-	XA_STATE(xas, &kvm->mem_attr_array, start);
-	unsigned long index;
+	MA_STATE(mas, &kvm->mem_attr_mtree, start, start);
 	void *entry;
 
 	mask &= kvm_supported_mem_attributes(kvm);
 	if (attrs & ~mask)
 		return false;
 
-	if (end == start + 1)
-		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
-
 	guard(rcu)();
-	if (!attrs)
-		return !xas_find(&xas, end - 1);
-
-	for (index = start; index < end; index++) {
-		do {
-			entry = xas_next(&xas);
-		} while (xas_retry(&xas, entry));
 
-		if (xas.xa_index != index ||
-		    (xa_to_value(entry) & mask) != attrs)
+	do {
+		entry = mas_find_range(&mas, end - 1);
+		if ((xa_to_value(entry) & mask) != attrs)
 			return false;
-	}
+	} while (mas.last < end - 1);
 
 	return true;
 }
@@ -2524,9 +2518,9 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		.on_lock = kvm_mmu_invalidate_end,
 		.may_block = true,
 	};
-	unsigned long i;
 	void *entry;
 	int r = 0;
+	MA_STATE(mas, &kvm->mem_attr_mtree, start, end - 1);
 
 	entry = attributes ? xa_mk_value(attributes) : NULL;
 
@@ -2540,20 +2534,11 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * Reserve memory ahead of time to avoid having to deal with failures
 	 * partway through setting the new attributes.
 	 */
-	for (i = start; i < end; i++) {
-		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
-		if (r)
-			goto out_unlock;
-	}
-
+	r = mas_preallocate(&mas, entry, GFP_KERNEL_ACCOUNT);
+	if (r)
+		goto out_unlock;
 	kvm_handle_gfn_range(kvm, &pre_set_range);
-
-	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
-				    GFP_KERNEL_ACCOUNT));
-		KVM_BUG_ON(r, kvm);
-	}
-
+	mas_store_prealloc(&mas, entry);
 	kvm_handle_gfn_range(kvm, &post_set_range);
 
 out_unlock:
-- 
2.20.1


