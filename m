Return-Path: <linux-kernel+bounces-394928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F19BB632
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F2B2318C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68213BC0C;
	Mon,  4 Nov 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgeAEV3i"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125E139D19
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727140; cv=none; b=TSWtzhNKZAo+PXxRLRDr/w7uSk6RFPFzGhGPwnMn7M4HQbE1iAka5m5tKb8RYvdklFGv4c7PuGfl3rlpAinrpSBEasMO4ThOipFy2SKJDJgbilsN+deX8tfIhERZIExL29QkJGTqQ54zm9ucToHnFE0g1xNMVdZpMFPoGuTe4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727140; c=relaxed/simple;
	bh=ZboWPmVmaGlL28LYfBhIUz5qUZOJXRUDz6PhLEdQK4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PwWgxCC/YzvOffvo052xsv9BBhILM8op91ZZdY4dIB6V+tH16dXOsPjtd3Adced3QyCZY70v4Zfvw4Kg9DhYD048bmbwQPwG4EcbriLowwXWBBQWt1cpQsXEJeTDw5Wnwwg1a9jqN3+lEdhma3xgLDfXR3BBYyq0ZPUzll3yQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgeAEV3i; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e86e9so24241277b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727138; x=1731331938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ2UfOd5hZAeaPLHJ1vPNSgFOo3Tgpu5wQh3N2q+oTo=;
        b=DgeAEV3iTf/KB8FRQgT/aL0dWLlI6p5t6IoJeLjWyyofDeLnyUtX8k0y8ExI7PXfbC
         i+awMi2LatLft+qLaGMSGJN8doDxtBfxAuAl78mr61APxLw4KDOoWNDoQIlR6ZAkahgV
         1UKZ98CtgpxBoWEYiCqXIOV8jwRZ0ocdQf26L1BDs8N6iCXStpCKCvsKVAX4TyC75jeB
         uz1sMdaWTbh5AB9BNEvPgIPAVFpDqZnlFwv8HBf5KujBfTQDysIQkJeuAE10zvWoA3KA
         vNkfii1Cky57mzB3zvWby40YOvtf/JZLR17jhgRoXbITr1+5zwn5FVBSkT+9NPMXRSXe
         XUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727138; x=1731331938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ2UfOd5hZAeaPLHJ1vPNSgFOo3Tgpu5wQh3N2q+oTo=;
        b=erBjQGC5P5Pe8jHPmXKbGiD4D3Y9kt/SsFcKvEPlEHBDyXuaiXT5TgubQjonPaPgh7
         gZEakhgMIDW4hqwk1vrRtg8w1Q5Jf30GjauTEEAZK/kMPRbt0Hz6xGDfKc+65vvboWI4
         d7fn6JbLm6tCDxwVV6Y3RDjKOFHVPWuvx5QA7f//nnMDttWbxfoZ1C0P5KbnhgzLxNvz
         gqBAM1MTy+Ahs5d9Ba4xUUgvlbntCG/EqwkVAAivS5KpJL1GS7pZMnJz4/luRQLvrI5I
         gAywdBUNVzsRx54fr5+4S8jU99Lgs1pI1AwdaWYvFJiKJIDNJDh1GpCnIeaH4dqVfLgs
         D/4A==
X-Forwarded-Encrypted: i=1; AJvYcCXm+VgU6N7FELk/PufNKkTFrbQtKjaz8T/e+yEFWf9qiTwhek9cJO0BlPTCA8bM3SiAA1bTI0AzAzkKQeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWs7QIQOs4U/srMtzEl0kjW91X6W4FXcZtXYfJM40HdT9yMdin
	w6agUfp198sZzK4mlbfcPl350L77wjGv12ulq6TiG2l1aTTUm87W58e/7eRRY+ntg7YPZM+Xpoc
	G6Zgq+Q==
X-Google-Smtp-Source: AGHT+IF49UTXAe8MpaL0rEMeOO4EMZEqcc7t401Y5lsJ/es+OKsAWaYirm7qQpvT/q6K58FZd8rxMOICH29X
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:690c:9a0e:b0:6ea:70f7:2c38 with SMTP
 id 00721157ae682-6ea70f733ddmr1082897b3.4.1730727137419; Mon, 04 Nov 2024
 05:32:17 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:50 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-5-qperret@google.com>
Subject: [PATCH 04/18] KVM: arm64: Move host page ownership tracking to the
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
index 174007f3fadd..c315710f57ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -198,7 +198,6 @@ static void hpool_put_page(void *addr)
 static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
 				     enum kvm_pgtable_walk_flags visit)
 {
-	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
 	phys_addr_t phys;
 
@@ -221,16 +220,16 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
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
2.47.0.163.g1226f6d8fa-goog


