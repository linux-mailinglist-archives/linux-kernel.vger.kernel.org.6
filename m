Return-Path: <linux-kernel+bounces-538325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E105A4972C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C1F168FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38625F787;
	Fri, 28 Feb 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcstE+8p"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353C25EF86
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738354; cv=none; b=qwGDxk5tfuqUUKVaJtwR+vA9OrSarDBfavwZstd0Qyr8/qExzMWjXAV8s/twuG2eXUiOmBsRj0j1KL2088vzHLtxlo2et9swqaV4HL4pWxiEwRRx8sRuRsWWWPXnn6mOP4hf/Wsot98JM51vvf/doWXIcJBVpaiaCrGMFDGXATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738354; c=relaxed/simple;
	bh=uLROo1wcyOnNFi0pyMSVqV6JKBZtaWvrYzPQupAqXtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ce/P+SCcgGVVIgwiWjpRSF3G5XNQaR9bT3QKi8RarHHmSkfrwpPjHeSTHrIlQ4tSYqLvm9+6gLmd3irmwvMS1EYhe6gjqI9nrtWyk/+ZyKBf4FTjvYa+dSrCSS7uLT9zBncS4UontluBI23MRV2mz4zr3fv8yKSKgtJcbveTr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lcstE+8p; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43943bd1409so14153075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738350; x=1741343150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNjZen1QQXUUeBW1RgZ/1gOb9pJh3jnMuCmkQ3aRRLI=;
        b=lcstE+8phDxQsVWSJoBSQ+12HHx4baBfCFx0TznEgr7sVLiAViC18hcjHKTZxgxXff
         EWAV1/HRo5LNfKyVSSX3mBNMscZ2N2Gx8BPex8mVzWoY1fT6Y+DY7dHzy7HVreticKw2
         M8hCcKFX68AMDDSzJeY0x2Gxowua8HFtR6il0aFft1tiXS955gg+VZNl68myRhcjrPp7
         nMLSZz/fHkwjEqq8o6aAjDFoIng6WuEHI5CVPYlpXEVCIHdQXcINJ2E29zfEH6jL4Vhw
         pSa8Jv8c0M3N0ZaTXlOO01yq4is7WpUhPe8JfSexuifqk7Ig6bpIZU5WDKMPPWCzGTOl
         lJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738350; x=1741343150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNjZen1QQXUUeBW1RgZ/1gOb9pJh3jnMuCmkQ3aRRLI=;
        b=f6ba3CvF+KtS8VRsxTNncHx8SydwZY2DDtZnY+Po8A8B+S15Uy5923wZj62IxJLR/K
         rZmCeyHMVdzJGaaSFtEgJ2QK74tV263Rr4tCsR/s3e71uJFmMYoFZVGx57R+LbegsPre
         49tGHIMRwL/3bWlupbMLaOEwbS7Bc/lvlX+nbqU4iTcvkb4wh/UsA2X2yap2NpaK8STZ
         Y5JBKwpJgPklsw1aZsF22WLuAj050SD06TdGY7a+mFlIEucftJYBdN2dCFR/ZzH5hAjF
         8iGHa1Mg0llAM1rZ6qxQ+Veu8oasgfO1QHBeQw9XATEC5p4I+CLpGRX8M8p+8LJB4ZyA
         q8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlSYGFV2MeVCEM1p6vRReNFrp52sqPjLj/AZ+gBFBbqcQULwxJ0ETtRJbka1vNmcSCgyeXZWrdi5f2N7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEsKsi5H/lZwihmuA91GOmUZtGsS3hQP1849NrlUfBPpEQivW
	9KU1TgqSHNaQhU5/FeZB1i1OwRxTYVmnJcBV5hqZOF9ARgMEyf5PcylxKSjWb//rJmfNPK24zlh
	iQSWQAiHA4maUyU7lpw==
X-Google-Smtp-Source: AGHT+IF0kAKi15pqdhtBbCFw0IonwK7YIZ+9sqAU9W19r6arIA4DAzoRfW7wEDRfU4OM6g8jOwfkTj3WyP80npYl
X-Received: from wmbfp18.prod.google.com ([2002:a05:600c:6992:b0:439:98a4:d14])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5248:b0:439:84f8:60d7 with SMTP id 5b1f17b1804b1-43bac7a3101mr2277785e9.10.1740738350591;
 Fri, 28 Feb 2025 02:25:50 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:19 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-4-vdonnefort@google.com>
Subject: [PATCH 2/9] KVM: arm64: Add range to __pkvm_host_share_guest()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for supporting stage-2 huge mappings for np-guest. Add a
nr_pages argument to the __pkvm_host_share_guest hypercall.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 978f38c386ee..1abbab5e2ff8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -39,7 +39,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
-int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
+int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu *vcpu,
 			    enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2c37680d954c..e71601746935 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -249,7 +249,8 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(u64, pfn, host_ctxt, 1);
 	DECLARE_REG(u64, gfn, host_ctxt, 2);
-	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
+	DECLARE_REG(u64, nr_pages, host_ctxt, 3);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
 	struct pkvm_hyp_vcpu *hyp_vcpu;
 	int ret = -EINVAL;
 
@@ -264,7 +265,7 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
 	if (ret)
 		goto out;
 
-	ret = __pkvm_host_share_guest(pfn, gfn, hyp_vcpu, prot);
+	ret = __pkvm_host_share_guest(pfn, gfn, nr_pages, hyp_vcpu, prot);
 out:
 	cpu_reg(host_ctxt, 1) =  ret;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a796e257c41f..2e49bd6e4ae8 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -60,6 +60,9 @@ static void hyp_unlock_component(void)
 	hyp_spin_unlock(&pkvm_pgd_lock);
 }
 
+#define for_each_hyp_page(start, size, page)	\
+	for (page = hyp_phys_to_page(start); page < hyp_phys_to_page((start) + (size)); page++)
+
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
 	void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
@@ -503,10 +506,25 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
 
 static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
 {
-	phys_addr_t end = addr + size;
+	struct hyp_page *page;
+
+	for_each_hyp_page(addr, size, page)
+		page->host_state = state;
+}
+
+static void __host_update_share_guest_count(u64 phys, u64 size, bool inc)
+{
+	struct hyp_page *page;
 
-	for (; addr < end; addr += PAGE_SIZE)
-		hyp_phys_to_page(addr)->host_state = state;
+	for_each_hyp_page(phys, size, page) {
+		if (inc) {
+			WARN_ON(page->host_share_guest_count++ == U32_MAX);
+		} else {
+			WARN_ON(!page->host_share_guest_count--);
+			if (!page->host_share_guest_count)
+				page->host_state = PKVM_PAGE_OWNED;
+		}
+	}
 }
 
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
@@ -621,16 +639,16 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
 static int __host_check_page_state_range(u64 addr, u64 size,
 					 enum pkvm_page_state state)
 {
-	u64 end = addr + size;
+	struct hyp_page *page;
 	int ret;
 
-	ret = check_range_allowed_memory(addr, end);
+	ret = check_range_allowed_memory(addr, addr + size);
 	if (ret)
 		return ret;
 
 	hyp_assert_lock_held(&host_mmu.lock);
-	for (; addr < end; addr += PAGE_SIZE) {
-		if (hyp_phys_to_page(addr)->host_state != state)
+	for_each_hyp_page(addr, size, page) {
+		if (page->host_state != state)
 			return -EPERM;
 	}
 
@@ -680,10 +698,9 @@ static enum pkvm_page_state guest_get_page_state(kvm_pte_t pte, u64 addr)
 	return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
 }
 
-static int __guest_check_page_state_range(struct pkvm_hyp_vcpu *vcpu, u64 addr,
+static int __guest_check_page_state_range(struct pkvm_hyp_vm *vm, u64 addr,
 					  u64 size, enum pkvm_page_state state)
 {
-	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
 	struct check_walk_data d = {
 		.desired	= state,
 		.get_page_state	= guest_get_page_state,
@@ -890,49 +907,75 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
 	return ret;
 }
 
-int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
+static int __guest_check_transition_size(u64 phys, u64 ipa, u64 nr_pages, u64 *size)
+{
+	if (nr_pages == 1) {
+		*size = PAGE_SIZE;
+		return 0;
+	}
+
+	/* We solely support PMD_SIZE huge-pages */
+	if (nr_pages != (1 << (PMD_SHIFT - PAGE_SHIFT)))
+		return -EINVAL;
+
+	if (!IS_ALIGNED(phys | ipa, PMD_SIZE))
+		return -EINVAL;
+
+	*size = PMD_SIZE;
+	return 0;
+}
+
+int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu *vcpu,
 			    enum kvm_pgtable_prot prot)
 {
 	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
 	u64 phys = hyp_pfn_to_phys(pfn);
 	u64 ipa = hyp_pfn_to_phys(gfn);
 	struct hyp_page *page;
+	u64 size;
 	int ret;
 
 	if (prot & ~KVM_PGTABLE_PROT_RWX)
 		return -EINVAL;
 
-	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
+	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
 	if (ret)
 		return ret;
 
 	host_lock_component();
 	guest_lock_component(vm);
 
-	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
+	ret = __guest_check_page_state_range(vm, ipa, size, PKVM_NOPAGE);
 	if (ret)
 		goto unlock;
 
 	page = hyp_phys_to_page(phys);
+	ret = __host_check_page_state_range(phys, size, page->host_state);
+	if (ret)
+		goto unlock;
+
 	switch (page->host_state) {
 	case PKVM_PAGE_OWNED:
-		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
+		WARN_ON(__host_set_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED));
 		break;
 	case PKVM_PAGE_SHARED_OWNED:
-		if (page->host_share_guest_count)
-			break;
-		/* Only host to np-guest multi-sharing is tolerated */
-		WARN_ON(1);
-		fallthrough;
+		for_each_hyp_page(phys, size, page) {
+			/* Only host to np-guest multi-sharing is tolerated */
+			if (WARN_ON(!page->host_share_guest_count)) {
+				ret = -EPERM;
+				goto unlock;
+			}
+		}
+		break;
 	default:
 		ret = -EPERM;
 		goto unlock;
 	}
 
-	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
+	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, size, phys,
 				       pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
 				       &vcpu->vcpu.arch.pkvm_memcache, 0));
-	page->host_share_guest_count++;
+	__host_update_share_guest_count(phys, size, true);
 
 unlock:
 	guest_unlock_component(vm);
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 930b677eb9b0..00fd9a524bf7 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -361,7 +361,7 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		return -EINVAL;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
-	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, prot);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, 1, prot);
 	if (ret) {
 		/* Is the gfn already mapped due to a racing vCPU? */
 		if (ret == -EPERM)
-- 
2.48.1.711.g2feabab25a-goog


