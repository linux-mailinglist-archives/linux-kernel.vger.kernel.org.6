Return-Path: <linux-kernel+bounces-429248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24AA9E197D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FADF281D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246791E32A5;
	Tue,  3 Dec 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyFVReiK"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516011E2848
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222269; cv=none; b=bE3/0iZwa4zT+F8LD5Tt73f0cDLr3Hi3Vf2N+wpi0S92REgGcFn1cDUOOJZxzbZH1v8+6tVwJq7pnaOCViGA2eoHAKXEpJiGJ6qerOGfWP71njy+j3YE+/8D7q8g8jg37lycVjZxOKaTlfsO+G/o05bm7e1IZpo6C/TMkDGF1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222269; c=relaxed/simple;
	bh=5nEyKVJ+bMqamDzzNOs7eRyJl/ripKTQPgRdRRykfjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YxyqwmTsU+7+VZj2YL1iO7wcBfMz/kjUFdXJMQxJ9H7HrKHz4JW/ZFCQT9cI1mtdAQKJFZaKWxJ7OEaca1evw6f1uWPiOwHdyRS5mBMT6DVIKNy4074HVH5UbsyWc5sKhqKrCM1KiNIZCZTSubKvOjMr9+NUI1waavZnnwynlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyFVReiK; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5cfdcbd3a03so3305246a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222266; x=1733827066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vL8QoyqDJGJKSzujql+FnjFwnxiows6yfxggRDFLqII=;
        b=hyFVReiKq7K9DMEbU8OGEogqwp59iXsa3Q+ChHkm9t3IRL3xaKY5EFtuRjRUVN8Jo0
         uJ9/fIVTbfA+u/yPMSULQyEt2h9diNeSpkHIW9R1I+Y07tglAbONjM55uXZBnikutnCU
         +vOibkDijw6t58I3qk0R1iwFKQexAYrwDZS9FBURytRCySxQb0fCTI5x7L0EobfwCUyX
         8trWWwdV5tQ0kyzc/Uxez8ZvnMHQtb/vRprU+aJEJ+sZ2UbCJuWsITiAn8ikxwLTnhX4
         KMkZ6H9m7hhIS0vZYa+s1Gcdg9HNt3AQ7rJGkJPvFP+swpNoSxJ3xvazo7X8fNl5TTM2
         QjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222266; x=1733827066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vL8QoyqDJGJKSzujql+FnjFwnxiows6yfxggRDFLqII=;
        b=g/tS24Vzu3au0XxrYZWe5thwM2FepYKKy97ZoLo04+0+5/n7JyJqRT4847tB1rDI9F
         i6ubnP1JTzP/thoDPQGmbVzDjww+oVWvHvg4UjzX5hBCyrpJxWr2th9dJNYCC8SACitS
         cttirXZ/xEgrxjG/d1mnx7Y0q1m/ZnyPyMt/YjVKIrZmKz3wQzkqO3yen+cr/er6DHpF
         qh77IaMDrLYHyfNH7u0L3I4NbbefAPsbRBgJ19c8th1pcSESe79qavG5wVrjpzcvnsuB
         RZBLU83MwAS07pPj4wEDUqIMRVBmSxeImEPkwHef1mLu9SOnMt5ROrV+MEyMrekJgLQE
         pTRw==
X-Forwarded-Encrypted: i=1; AJvYcCUsO584jSw/k/6+dcpuS3sG541g5Yh08lSaDFzWDqHmjaG1fW3vTB0Grkb+HnNYNUMJRaBAW97okzSSmWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6O6He0dGD/HoYSFe9dgld6m1w5NFAyWDBqmwesIqpFI5wwdLt
	g2iUdzyEkXDgdsr0edMeiMd390SVgzCisXshhkI/xcwzyiPvsRzO1MItMa1DB5LZPubaahU25FM
	xH0zhZw==
X-Google-Smtp-Source: AGHT+IHgN8lC9yyvpZDMorRNkMfBYB5LlKIEA9og279boNeGpPGd3SF8ruNhrF2CXXgsPlBBwGvBFPbPD090
X-Received: from edcl4.prod.google.com ([2002:a05:6402:3444:b0:5cf:d076:a5f2])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5216:b0:5d0:cf88:fc63
 with SMTP id 4fb4d7f45d1cf-5d10cb5574dmr1733387a12.10.1733222265956; Tue, 03
 Dec 2024 02:37:45 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:21 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-5-qperret@google.com>
Subject: [PATCH v2 04/18] KVM: arm64: Move host page ownership tracking to the
 hyp vmemmap
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We currently store part of the page-tracking state in PTE software bits
for the host, guests and the hypervisor. This is sub-optimal when e.g.
sharing pages as this forces to break block mappings purely to support
this software tracking. This causes an unnecessarily fragmented stage-2
page-table for the host in particular when it shares pages with Secure,
which can lead to measurable regressions. Moreover, having this state
stored in the page-table forces us to do multiple costly walks on the
page transition path, hence causing overhead.

In order to work around these problems, move the host-side page-tracking
logic from SW bits in its stage-2 PTEs to the hypervisor's vmemmap.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  6 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 94 ++++++++++++++++--------
 arch/arm64/kvm/hyp/nvhe/setup.c          |  7 +-
 3 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 88cb8ff9e769..08f3a0416d4c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 /*
- * SW bits 0-1 are reserved to track the memory ownership state of each page:
+ * Bits 0-1 are reserved to track the memory ownership state of each page:
  *   00: The page is owned exclusively by the page-table owner.
  *   01: The page is owned by the page-table owner, but is shared
  *       with another entity.
@@ -44,7 +44,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
 struct hyp_page {
 	u16 refcount;
 	u8 order;
-	u8 reserved;
+
+	/* Host (non-meta) state. Guarded by the host stage-2 lock. */
+	enum pkvm_page_state host_state : 8;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index caba3e4bd09e..1595081c4f6b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -201,8 +201,8 @@ static void *guest_s2_zalloc_page(void *mc)
 
 	memset(addr, 0, PAGE_SIZE);
 	p = hyp_virt_to_page(addr);
-	memset(p, 0, sizeof(*p));
 	p->refcount = 1;
+	p->order = 0;
 
 	return addr;
 }
@@ -268,6 +268,7 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
 
 void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
 {
+	struct hyp_page *page;
 	void *addr;
 
 	/* Dump all pgtable pages in the hyp_pool */
@@ -279,7 +280,9 @@ void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
 	/* Drain the hyp_pool into the memcache */
 	addr = hyp_alloc_pages(&vm->pool, 0);
 	while (addr) {
-		memset(hyp_virt_to_page(addr), 0, sizeof(struct hyp_page));
+		page = hyp_virt_to_page(addr);
+		page->refcount = 0;
+		page->order = 0;
 		push_hyp_memcache(mc, addr, hyp_virt_to_phys);
 		WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(addr), 1));
 		addr = hyp_alloc_pages(&vm->pool, 0);
@@ -382,19 +385,25 @@ bool addr_is_memory(phys_addr_t phys)
 	return !!find_mem_range(phys, &range);
 }
 
-static bool addr_is_allowed_memory(phys_addr_t phys)
+static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
+{
+	return range->start <= addr && addr < range->end;
+}
+
+static int range_is_allowed_memory(u64 start, u64 end)
 {
 	struct memblock_region *reg;
 	struct kvm_mem_range range;
 
-	reg = find_mem_range(phys, &range);
+	/* Can't check the state of both MMIO and memory regions at once */
+	reg = find_mem_range(start, &range);
+	if (!is_in_mem_range(end - 1, &range))
+		return -EINVAL;
 
-	return reg && !(reg->flags & MEMBLOCK_NOMAP);
-}
+	if (!reg || reg->flags & MEMBLOCK_NOMAP)
+		return -EPERM;
 
-static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
-{
-	return range->start <= addr && addr < range->end;
+	return 0;
 }
 
 static bool range_is_memory(u64 start, u64 end)
@@ -454,8 +463,11 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
 	if (kvm_pte_valid(pte))
 		return -EAGAIN;
 
-	if (pte)
+	if (pte) {
+		WARN_ON(addr_is_memory(addr) &&
+			!(hyp_phys_to_page(addr)->host_state & PKVM_NOPAGE));
 		return -EPERM;
+	}
 
 	do {
 		u64 granule = kvm_granule_size(level);
@@ -477,10 +489,29 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
 	return host_stage2_try(__host_stage2_idmap, addr, addr + size, prot);
 }
 
+static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
+{
+	phys_addr_t end = addr + size;
+	for (; addr < end; addr += PAGE_SIZE)
+		hyp_phys_to_page(addr)->host_state = state;
+}
+
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
 {
-	return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
-			       addr, size, &host_s2_pool, owner_id);
+	int ret;
+
+	ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
+			      addr, size, &host_s2_pool, owner_id);
+	if (ret || !addr_is_memory(addr))
+		return ret;
+
+	/* Don't forget to update the vmemmap tracking for the host */
+	if (owner_id == PKVM_ID_HOST)
+		__host_update_page_state(addr, size, PKVM_PAGE_OWNED);
+	else
+		__host_update_page_state(addr, size, PKVM_NOPAGE);
+
+	return 0;
 }
 
 static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
@@ -604,35 +635,38 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-static enum pkvm_page_state host_get_page_state(kvm_pte_t pte, u64 addr)
-{
-	if (!addr_is_allowed_memory(addr))
-		return PKVM_NOPAGE;
-
-	if (!kvm_pte_valid(pte) && pte)
-		return PKVM_NOPAGE;
-
-	return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
-}
-
 static int __host_check_page_state_range(u64 addr, u64 size,
 					 enum pkvm_page_state state)
 {
-	struct check_walk_data d = {
-		.desired	= state,
-		.get_page_state	= host_get_page_state,
-	};
+	u64 end = addr + size;
+	int ret;
+
+	ret = range_is_allowed_memory(addr, end);
+	if (ret)
+		return ret;
 
 	hyp_assert_lock_held(&host_mmu.lock);
-	return check_page_state_range(&host_mmu.pgt, addr, size, &d);
+	for (; addr < end; addr += PAGE_SIZE) {
+		if (hyp_phys_to_page(addr)->host_state != state)
+			return -EPERM;
+	}
+
+	return 0;
 }
 
 static int __host_set_page_state_range(u64 addr, u64 size,
 				       enum pkvm_page_state state)
 {
-	enum kvm_pgtable_prot prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, state);
+	if (hyp_phys_to_page(addr)->host_state & PKVM_NOPAGE) {
+		int ret = host_stage2_idmap_locked(addr, size, PKVM_HOST_MEM_PROT);
 
-	return host_stage2_idmap_locked(addr, size, prot);
+		if (ret)
+			return ret;
+	}
+
+	__host_update_page_state(addr, size, state);
+
+	return 0;
 }
 
 static int host_request_owned_transition(u64 *completer_addr,
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index cbdd18cd3f98..7e04d1c2a03d 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -180,7 +180,6 @@ static void hpool_put_page(void *addr)
 static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 				     enum kvm_pgtable_walk_flags visit)
 {
-	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
 	phys_addr_t phys;
 
@@ -203,16 +202,16 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	case PKVM_PAGE_OWNED:
 		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
 	case PKVM_PAGE_SHARED_OWNED:
-		prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_BORROWED);
+		hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_BORROWED;
 		break;
 	case PKVM_PAGE_SHARED_BORROWED:
-		prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
+		hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_OWNED;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return host_stage2_idmap_locked(phys, PAGE_SIZE, prot);
+	return 0;
 }
 
 static int fix_hyp_pgtable_refcnt_walker(const struct kvm_pgtable_visit_ctx *ctx,
-- 
2.47.0.338.g60cca15819-goog


