Return-Path: <linux-kernel+bounces-538337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D56A49741
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0300316AF77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8822A25DD12;
	Fri, 28 Feb 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5FqZ/t9"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD218266EEB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738377; cv=none; b=BLRNIpAinzO2TgZAkQq1sgiID7Y1QBOBjezCx2t+KOGQ/D2Rl2FcuZptxsBvC3ScR6xHqdcRN66J4qk3tSZ2j1BezNs20GbZD7kSdUdHLXn4JZrt6d6MITsSx0aKp+S00ab2MCegOCN3XSk0DjzTjSuhtNpQJXlF+ChRH9Sa0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738377; c=relaxed/simple;
	bh=MXYeISpx/aDlsUDzteiJDvn0e6kbJkkOswtFGqClK/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glmvtUtGVCe5oc11pmDwLMlaNc4px9hL9FjDh33uin9OzIaL1lS0T/XpKlfqZYVoHOwIEi6ETyStRLDOV3Ze3uSCNy57smO5LSwVG2bkach7lMYj7HVgIlpaqN8Q9HfUcVck6E9NmhrISTYesctNVNMcU5UUOGlLptRhLrn8VDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5FqZ/t9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so8258595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738374; x=1741343174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=okFrKrhPumydq8rLHSqC6+IdPsjGdyC8aVxeiqDQVLo=;
        b=c5FqZ/t9MMenJXtx9Wsdg+ZJSTW4FQFl15vINoQ5hC18nyQzElvP2/WJqtKIkPhLKL
         OkIpS1tE/1A71JnG4+KQ5+QRCpd+D4JKk01rPY35ll98wufgu7ZQP1d9VXAyxHctq3a4
         1MS+LC/yqRLs5gKvFDS7Ym9jPahAqeYlTj9fhnk6zIFOI0k9on8Llz6CEHathFLA4Leg
         3aqeDu4lJFu1FToKE7fNEq3szv+AfLsvYVhBLlNYxKvmwzmLOgB6cXUEwXoL/fRKGHuL
         +QJ8REwBRmqCW5NdJAzKkJXXKZySNPYwJGUdg48yC3rMXVbwQNkhURvBvuw7r173RFsE
         t8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738374; x=1741343174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okFrKrhPumydq8rLHSqC6+IdPsjGdyC8aVxeiqDQVLo=;
        b=YXOJTdxnqLGrvrjrfAFD5kL+ZjSIBYLL059XZD35M0MgP9NdipDz0DervBIo/02h3D
         YFv1gqDBvxsTQK1F1CkCgOS4snpBCSW+pxtWh5ieSbPOKKPyvy3OYggQy2kbaquI0mwk
         9Pnk50P+qWz5RfdwsggL0zkJHaoU8H/II6QjuUtFeWN30VM6qB6K0l+O1LxoMnFlA1HW
         P9wXg4XgLlcd9BGzYfG9DLa4BNtjD+nVILrS6IKadhFwGjqphTucZRBTJmRVBuY3eIDG
         7EmJSpiF/FXYjiWHfSQ4PeWXdL2dfh5K124FU/387+prlb+v4pnv4fW2Dsc9gL8HAMqj
         6F7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNe2Q5pDTNbOgTWo2PgXw3mTWAPEdR1FcHgXXCPFkugQRKyGu6Fgk6QGcrRmE/8uWJvLtn7NeV3LpUCLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmpEnxjKseo0uKmCgWjZmCmLZj+vkvk3lu9P7wTjDSc9pQOc1
	LUj9LXdlegxJaz91CzqM12mLvZlaccg2cFdcxhH0Xdf7Y+IX9NbzAE5bqkKCMNDPHz+TeOf2hKY
	QSSSvzYEBMXfMCGdzhA==
X-Google-Smtp-Source: AGHT+IHw8E3se+rg2k3z4uSikRRjQKSYo2S3MZjJ8Y0FSN5936j7LMJM+12PR3REuojrFW4s9g1hMmiAVM7Iz4UL
X-Received: from wmbfm6.prod.google.com ([2002:a05:600c:c06:b0:439:9601:298d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f0d:b0:439:9828:c450 with SMTP id 5b1f17b1804b1-43ba67082e6mr22770435e9.15.1740738374284;
 Fri, 28 Feb 2025 02:26:14 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:30 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-15-vdonnefort@google.com>
Subject: [PATCH 9/9] KVM: arm64: np-guest CMOs with PMD_SIZE fixmap
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

With the introduction of stage-2 huge mappings in the pKVM hypervisor,
guest pages CMO is needed for PMD_SIZE size. Fixmap only supports
PAGE_SIZE and iterating over the huge-page is time consuming (mostly due
to TLBI on hyp_fixmap_unmap) which is a problem for EL2 latency.

Introduce a shared PMD_SIZE fixmap (hyp_fixblock_map/hyp_fixblock_unmap)
to improve guest page CMOs when stage-2 huge mappings are installed.

On a Pixel6, the iterative solution resulted in a latency of ~700us,
while the PMD_SIZE fixmap reduces it to ~100us.

Because of the horrendous private range allocation that would be
necessary, this is disabled for 64KiB pages systems.

Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 1b43bcd2a679..2888b5d03757 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -59,6 +59,11 @@ typedef u64 kvm_pte_t;
 
 #define KVM_PHYS_INVALID		(-1ULL)
 
+#define KVM_PTE_TYPE			BIT(1)
+#define KVM_PTE_TYPE_BLOCK		0
+#define KVM_PTE_TYPE_PAGE		1
+#define KVM_PTE_TYPE_TABLE		1
+
 #define KVM_PTE_LEAF_ATTR_LO		GENMASK(11, 2)
 
 #define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX	GENMASK(4, 2)
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 230e4f2527de..b0c72bc2d5ba 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -13,9 +13,11 @@
 extern struct kvm_pgtable pkvm_pgtable;
 extern hyp_spinlock_t pkvm_pgd_lock;
 
-int hyp_create_pcpu_fixmap(void);
+int hyp_create_fixmap(void);
 void *hyp_fixmap_map(phys_addr_t phys);
 void hyp_fixmap_unmap(void);
+void *hyp_fixblock_map(phys_addr_t phys);
+void hyp_fixblock_unmap(void);
 
 int hyp_create_idmap(u32 hyp_va_bits);
 int hyp_map_vectors(void);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 271893eff021..d27ce31370aa 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -220,25 +220,64 @@ static void guest_s2_put_page(void *addr)
 	hyp_put_page(&current_vm->pool, addr);
 }
 
+static void *__fixmap_guest_page(void *va, size_t *size)
+{
+	if (IS_ALIGNED(*size, PMD_SIZE)) {
+		void *addr = hyp_fixblock_map(__hyp_pa(va));
+
+		if (addr)
+			return addr;
+
+		*size = PAGE_SIZE;
+	}
+
+	if (IS_ALIGNED(*size, PAGE_SIZE))
+		return hyp_fixmap_map(__hyp_pa(va));
+
+	WARN_ON(1);
+
+	return NULL;
+}
+
+static void __fixunmap_guest_page(size_t size)
+{
+	switch (size) {
+	case PAGE_SIZE:
+		hyp_fixmap_unmap();
+		break;
+	case PMD_SIZE:
+		hyp_fixblock_unmap();
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
 static void clean_dcache_guest_page(void *va, size_t size)
 {
 	while (size) {
-		__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
-					  PAGE_SIZE);
-		hyp_fixmap_unmap();
-		va += PAGE_SIZE;
-		size -= PAGE_SIZE;
+		size_t fixmap_size = size == PMD_SIZE ? size : PAGE_SIZE;
+		void *addr = __fixmap_guest_page(va, &fixmap_size);
+
+		__clean_dcache_guest_page(addr, fixmap_size);
+		__fixunmap_guest_page(fixmap_size);
+
+		size -= fixmap_size;
+		va += fixmap_size;
 	}
 }
 
 static void invalidate_icache_guest_page(void *va, size_t size)
 {
 	while (size) {
-		__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
-					       PAGE_SIZE);
-		hyp_fixmap_unmap();
-		va += PAGE_SIZE;
-		size -= PAGE_SIZE;
+		size_t fixmap_size = size == PMD_SIZE ? size : PAGE_SIZE;
+		void *addr = __fixmap_guest_page(va, &fixmap_size);
+
+		__invalidate_icache_guest_page(addr, fixmap_size);
+		__fixunmap_guest_page(fixmap_size);
+
+		size -= fixmap_size;
+		va += fixmap_size;
 	}
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index f41c7440b34b..e3b1bece8504 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -229,9 +229,8 @@ int hyp_map_vectors(void)
 	return 0;
 }
 
-void *hyp_fixmap_map(phys_addr_t phys)
+static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
 {
-	struct hyp_fixmap_slot *slot = this_cpu_ptr(&fixmap_slots);
 	kvm_pte_t pte, *ptep = slot->ptep;
 
 	pte = *ptep;
@@ -243,10 +242,21 @@ void *hyp_fixmap_map(phys_addr_t phys)
 	return (void *)slot->addr;
 }
 
+void *hyp_fixmap_map(phys_addr_t phys)
+{
+	return fixmap_map_slot(this_cpu_ptr(&fixmap_slots), phys);
+}
+
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
 {
 	kvm_pte_t *ptep = slot->ptep;
 	u64 addr = slot->addr;
+	u32 level;
+
+	if (FIELD_GET(KVM_PTE_TYPE, *ptep) == KVM_PTE_TYPE_PAGE)
+		level = KVM_PGTABLE_LAST_LEVEL;
+	else
+		level = KVM_PGTABLE_LAST_LEVEL - 1; /* create_fixblock() guarantees PMD level */
 
 	WRITE_ONCE(*ptep, *ptep & ~KVM_PTE_VALID);
 
@@ -260,7 +270,7 @@ static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
 	 * https://lore.kernel.org/kvm/20221017115209.2099-1-will@kernel.org/T/#mf10dfbaf1eaef9274c581b81c53758918c1d0f03
 	 */
 	dsb(ishst);
-	__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), KVM_PGTABLE_LAST_LEVEL);
+	__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), level);
 	dsb(ish);
 	isb();
 }
@@ -273,9 +283,9 @@ void hyp_fixmap_unmap(void)
 static int __create_fixmap_slot_cb(const struct kvm_pgtable_visit_ctx *ctx,
 				   enum kvm_pgtable_walk_flags visit)
 {
-	struct hyp_fixmap_slot *slot = per_cpu_ptr(&fixmap_slots, (u64)ctx->arg);
+	struct hyp_fixmap_slot *slot = (struct hyp_fixmap_slot *)ctx->arg;
 
-	if (!kvm_pte_valid(ctx->old) || ctx->level != KVM_PGTABLE_LAST_LEVEL)
+	if (!kvm_pte_valid(ctx->old) || (ctx->end - ctx->start) != kvm_granule_size(ctx->level))
 		return -EINVAL;
 
 	slot->addr = ctx->addr;
@@ -296,13 +306,73 @@ static int create_fixmap_slot(u64 addr, u64 cpu)
 	struct kvm_pgtable_walker walker = {
 		.cb	= __create_fixmap_slot_cb,
 		.flags	= KVM_PGTABLE_WALK_LEAF,
-		.arg = (void *)cpu,
+		.arg = (void *)per_cpu_ptr(&fixmap_slots, cpu),
 	};
 
 	return kvm_pgtable_walk(&pkvm_pgtable, addr, PAGE_SIZE, &walker);
 }
 
-int hyp_create_pcpu_fixmap(void)
+#ifndef CONFIG_ARM64_64K_PAGES
+static struct hyp_fixmap_slot hyp_fixblock_slot;
+static DEFINE_HYP_SPINLOCK(hyp_fixblock_lock);
+
+void *hyp_fixblock_map(phys_addr_t phys)
+{
+	hyp_spin_lock(&hyp_fixblock_lock);
+	return fixmap_map_slot(&hyp_fixblock_slot, phys);
+}
+
+void hyp_fixblock_unmap(void)
+{
+	fixmap_clear_slot(&hyp_fixblock_slot);
+	hyp_spin_unlock(&hyp_fixblock_lock);
+}
+
+static int create_fixblock(void)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= __create_fixmap_slot_cb,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.arg = (void *)&hyp_fixblock_slot,
+	};
+	unsigned long addr;
+	phys_addr_t phys;
+	int ret, i;
+
+	/* Find a RAM phys address, PMD aligned */
+	for (i = 0; i < hyp_memblock_nr; i++) {
+		phys = ALIGN(hyp_memory[i].base, PMD_SIZE);
+		if (phys + PMD_SIZE < (hyp_memory[i].base + hyp_memory[i].size))
+			break;
+	}
+
+	if (i >= hyp_memblock_nr)
+		return -EINVAL;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+	addr = ALIGN(__io_map_base, PMD_SIZE);
+	ret = __pkvm_alloc_private_va_range(addr, PMD_SIZE);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, PMD_SIZE, phys, PAGE_HYP);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_walk(&pkvm_pgtable, addr, PMD_SIZE, &walker);
+
+unlock:
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return ret;
+}
+#else
+void hyp_fixblock_unmap(void) { WARN_ON(1); }
+void *hyp_fixblock_map(phys_addr_t phys) { return NULL; }
+static int create_fixblock(void) { return 0; }
+#endif
+
+int hyp_create_fixmap(void)
 {
 	unsigned long addr, i;
 	int ret;
@@ -322,7 +392,7 @@ int hyp_create_pcpu_fixmap(void)
 			return ret;
 	}
 
-	return 0;
+	return create_fixblock();
 }
 
 int hyp_create_idmap(u32 hyp_va_bits)
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index d62bcb5634a2..fb69cf5e6ea8 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -295,7 +295,7 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = hyp_create_pcpu_fixmap();
+	ret = hyp_create_fixmap();
 	if (ret)
 		goto out;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index df5cc74a7dd0..c351b4abd5db 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -11,12 +11,6 @@
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
-
-#define KVM_PTE_TYPE			BIT(1)
-#define KVM_PTE_TYPE_BLOCK		0
-#define KVM_PTE_TYPE_PAGE		1
-#define KVM_PTE_TYPE_TABLE		1
-
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable_walker	*walker;
 
-- 
2.48.1.711.g2feabab25a-goog


