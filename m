Return-Path: <linux-kernel+bounces-538333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A075FA49737
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C8818893E4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEA4262D1C;
	Fri, 28 Feb 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OruM/TR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13872620EA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738369; cv=none; b=B60gtgkMdBDePW8z0M+VyelOipx0fbIlREnH1neEp8X54r6WiJNzCrqcKutuXMaSaeb5CvnvYHKQGYLHowBfyYzDcPzl3nzgTHI39D3bOCgEdyd7EpJqYeDVz/enKfL8Vyfic9NuwZA3ZTLzs1tQrf1PMbZVUewzATggQw+kFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738369; c=relaxed/simple;
	bh=0xiZbkVb4PxTBW8naW/8DcTbK2Rc6mIZinJTDH02mGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tPoRHMtNjb6fCmMXhY0L+4BTzQXBaUDxdmet8dgH8wsSYiVjhQQTFoSDV/uZrN6AnUhLO+9AXAsemUGEuWSr96f/gKfNP8jcDuQYiUC/6AvdsUEsLxy0ICA880CSkqcdn1NljhqZKTCrAGowCZrK+dleMz1gHSFcEzIh95lqMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OruM/TR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43995bff469so12445025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738366; x=1741343166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTPitoEhlDo5P7Fhw0/so0kkZd/7LTKjAqNYGdJzP/Q=;
        b=0OruM/TRzGJWJsMB+NoVfpGq9htiKj1C7fjkXfDeRYGmtOvKKbu5ZR2Zlxu8CwZPLo
         cb0Vj32Q8y7tb2zD9GvA8z9jmUGoc1j1tiaugrLtpi2rO1OUfHTPAeM54Lnf7WRY3kJC
         xglGsOx8qzB9wQ0j01ybzv+SFMAKDPCgJG2/YkH6+vdoNHCvchuvzF31XZUdvO6mFJYd
         ztS15VvEW+vSI+jeiNTX5jIWFwRasgAa4/qK7UsUzksPnw8wMJMMgOZtNiMVe5m4Ny+e
         ZC0e4Gp/MCbglDtdEy4LfsVPzDJJkOEz/c9QQXliX6tHZ/ZRuN7rJlL0rnaVeLGdlFw8
         VG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738366; x=1741343166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTPitoEhlDo5P7Fhw0/so0kkZd/7LTKjAqNYGdJzP/Q=;
        b=dbxntmfbqb6va4hGzfVopUVxfqwXBG4AuO5Qp8tX1q59g7gTrDT6PStoVzKQGrlMpD
         g10nu7W44EYdi6FRd1hpL43KJvPNookR3cueqW2YomTNqMINeBCEbB2AXb6fRxC/+N5C
         6LXYmQ+N57r9bHkozXrfPsxP9IVAfTKJ58MnQ/ISapmClUkNUKoy2dRhkO4pfaf2PJ0d
         r4qTgGAmUfXbpM4zwemEtmJFniQLXMPaXkRkD6AxDI4SgtW357pN7tK7ht1DewuMSZn4
         RFsJUCErEXHA3qk7B1YX3xnpaiRcN6U6UelXKSU07e437faVryC2hkc3UCFFO6ZPHPuj
         sl1w==
X-Forwarded-Encrypted: i=1; AJvYcCX3go1dwycpE5Fwp9RbvI52GVL2qrZdDbp1bcGHyucWdmf/uAQSJD6xnA7vvzJoi5MnmkVhVPPy+EphkL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQqZSjHT/uPIEpLx3O90Kpvu4EJj+GQjG0rK4jGkuGoXDhqq1
	tPowOvhILy/gXRIs2u9c+12O4FCKocoWDU/qmYz0skg1apD6zvIXU8WlY+YpyLxeJ6Yi3KzzAkw
	82ht8h3KlxxOaRqwKBg==
X-Google-Smtp-Source: AGHT+IEZhgA3sjj9bqeEk1zidbn1TNaulw5oerE9lhwnrZnuvWYyl5QCNJRYqFMrruyHX5mq6Mbs76MBS6SDWMEK
X-Received: from wmbfj14.prod.google.com ([2002:a05:600c:c8e:b0:439:86cb:c729])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5489:b0:439:9543:9491 with SMTP id 5b1f17b1804b1-43ba676062dmr18262165e9.25.1740738366120;
 Fri, 28 Feb 2025 02:26:06 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:26 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-11-vdonnefort@google.com>
Subject: [PATCH 6/9] KVM: arm64: Convert pkvm_mappings to interval tree
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Quentin Perret <qperret@google.com>

In preparation for supporting stage-2 huge mappings for np-guest, let's
convert pgt.pkvm_mappings to an interval tree.

No functional change intended.

Suggested-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 6b9d274052c7..1b43bcd2a679 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -413,7 +413,7 @@ static inline bool kvm_pgtable_walk_lock_held(void)
  */
 struct kvm_pgtable {
 	union {
-		struct rb_root					pkvm_mappings;
+		struct rb_root_cached				pkvm_mappings;
 		struct {
 			u32					ia_bits;
 			s8					start_level;
diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index eb65f12e81d9..f0d52efb858e 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -166,6 +166,7 @@ struct pkvm_mapping {
 	struct rb_node node;
 	u64 gfn;
 	u64 pfn;
+	u64 __subtree_last;	/* Internal member for interval tree */
 };
 
 int pkvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 2eb1cc30124e..da637c565ac9 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/interval_tree_generic.h>
 #include <linux/kmemleak.h>
 #include <linux/kvm_host.h>
 #include <asm/kvm_mmu.h>
@@ -270,80 +271,63 @@ static int __init finalize_pkvm(void)
 }
 device_initcall_sync(finalize_pkvm);
 
-static int cmp_mappings(struct rb_node *node, const struct rb_node *parent)
+static u64 __pkvm_mapping_start(struct pkvm_mapping *m)
 {
-	struct pkvm_mapping *a = rb_entry(node, struct pkvm_mapping, node);
-	struct pkvm_mapping *b = rb_entry(parent, struct pkvm_mapping, node);
-
-	if (a->gfn < b->gfn)
-		return -1;
-	if (a->gfn > b->gfn)
-		return 1;
-	return 0;
+	return m->gfn * PAGE_SIZE;
 }
 
-static struct rb_node *find_first_mapping_node(struct rb_root *root, u64 gfn)
+static u64 __pkvm_mapping_end(struct pkvm_mapping *m)
 {
-	struct rb_node *node = root->rb_node, *prev = NULL;
-	struct pkvm_mapping *mapping;
-
-	while (node) {
-		mapping = rb_entry(node, struct pkvm_mapping, node);
-		if (mapping->gfn == gfn)
-			return node;
-		prev = node;
-		node = (gfn < mapping->gfn) ? node->rb_left : node->rb_right;
-	}
-
-	return prev;
+	return (m->gfn + 1) * PAGE_SIZE - 1;
 }
 
-/*
- * __tmp is updated to rb_next(__tmp) *before* entering the body of the loop to allow freeing
- * of __map inline.
- */
+INTERVAL_TREE_DEFINE(struct pkvm_mapping, node, u64, __subtree_last,
+		     __pkvm_mapping_start, __pkvm_mapping_end, static,
+		     pkvm_mapping);
+
 #define for_each_mapping_in_range_safe(__pgt, __start, __end, __map)				\
-	for (struct rb_node *__tmp = find_first_mapping_node(&(__pgt)->pkvm_mappings,		\
-							     ((__start) >> PAGE_SHIFT));	\
+	for (struct pkvm_mapping *__tmp = pkvm_mapping_iter_first(&(__pgt)->pkvm_mappings,	\
+								  __start, __end - 1);		\
 	     __tmp && ({									\
-				__map = rb_entry(__tmp, struct pkvm_mapping, node);		\
-				__tmp = rb_next(__tmp);						\
+				__map = __tmp;							\
+				__tmp = pkvm_mapping_iter_next(__map, __start, __end - 1);	\
 				true;								\
 		       });									\
-	    )											\
-		if (__map->gfn < ((__start) >> PAGE_SHIFT))					\
-			continue;								\
-		else if (__map->gfn >= ((__end) >> PAGE_SHIFT))					\
-			break;									\
-		else
+	    )
 
 int pkvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			     struct kvm_pgtable_mm_ops *mm_ops)
 {
-	pgt->pkvm_mappings	= RB_ROOT;
+	pgt->pkvm_mappings	= RB_ROOT_CACHED;
 	pgt->mmu		= mmu;
 
 	return 0;
 }
 
-void pkvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
+static int __pkvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 start, u64 end)
 {
 	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
 	pkvm_handle_t handle = kvm->arch.pkvm.handle;
 	struct pkvm_mapping *mapping;
-	struct rb_node *node;
+	int ret;
 
 	if (!handle)
-		return;
+		return 0;
 
-	node = rb_first(&pgt->pkvm_mappings);
-	while (node) {
-		mapping = rb_entry(node, struct pkvm_mapping, node);
-		kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn);
-		node = rb_next(node);
-		rb_erase(&mapping->node, &pgt->pkvm_mappings);
+	for_each_mapping_in_range_safe(pgt, start, end, mapping) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn, 1);
+		if (WARN_ON(ret))
+			return ret;
+		pkvm_mapping_remove(mapping, &pgt->pkvm_mappings);
 		kfree(mapping);
 	}
+
+	return 0;
+}
+
+void pkvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
+{
+	__pkvm_pgtable_stage2_unmap(pgt, 0, ~(0ULL));
 }
 
 int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
@@ -371,28 +355,16 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	swap(mapping, cache->mapping);
 	mapping->gfn = gfn;
 	mapping->pfn = pfn;
-	WARN_ON(rb_find_add(&mapping->node, &pgt->pkvm_mappings, cmp_mappings));
+	pkvm_mapping_insert(mapping, &pgt->pkvm_mappings);
 
 	return ret;
 }
 
 int pkvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
-	struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
-	pkvm_handle_t handle = kvm->arch.pkvm.handle;
-	struct pkvm_mapping *mapping;
-	int ret = 0;
+	lockdep_assert_held_write(&kvm_s2_mmu_to_kvm(pgt->mmu)->mmu_lock);
 
-	lockdep_assert_held_write(&kvm->mmu_lock);
-	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping) {
-		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn, 1);
-		if (WARN_ON(ret))
-			break;
-		rb_erase(&mapping->node, &pgt->pkvm_mappings);
-		kfree(mapping);
-	}
-
-	return ret;
+	return __pkvm_pgtable_stage2_unmap(pgt, addr, addr + size);
 }
 
 int pkvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
-- 
2.48.1.711.g2feabab25a-goog


