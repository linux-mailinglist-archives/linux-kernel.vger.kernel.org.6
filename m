Return-Path: <linux-kernel+bounces-548722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA580A5489E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F4A18960BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A1819067C;
	Thu,  6 Mar 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eMkGtTq"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECC205513
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258853; cv=none; b=mG8ArVbk6kg6KMdhCBEndl7Z8bJ/Lk9jQkUOnZBy2DGJTt5nvwzYHGOlMa7bvy41qnTIKr8E4jdRgVwtmFcQ19A1SchwFLJl64zdmeeHr7rXtcEEuLgLR4J8Jkejut2psGbFe9nb/bhbU85eDzScE07qEantShupRz6yOVJ27+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258853; c=relaxed/simple;
	bh=df8Zf3EXEpi2tBRmItYx1wvCPm/Ks729ingfWdHDQ38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRBrgAu5KISEb5000Ct+NyCmmGXxhatR/v7MEB0sKhgX6Z5GNwZz26EkqzSpDKyoQqIt+zRRteyaNfvVLmAwfcbf8Co96Hq7f/KckWr8QmSxN2cLLb1pD/VbQbi02JRzm18+na+DMZklq/ZnMmzemOfdIzQTokK8NYFONSY+mKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eMkGtTq; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0257945so2294255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258849; x=1741863649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Nk4OPygl6hlYnOAq4z2AVFwBU0df555iSROa6vHa3A=;
        b=1eMkGtTq+UfQB15PmuJa2AoHfteLdmib7j/2+A/dXhS+OPZC+dM799RLsMbYH0sdo4
         DG82k/Xu0cxQwdv/lYWmsW8hG8KGRnyt7MQGb2Bl1RVsn43D7liQqVz8Z49Ftnh2lslx
         1N5wpVTD9ZK4k7quoNGDXxQR7bqolen416hEMIeclA0mLPufzlWc2/ddEAOvjosb2cad
         kL0hTTWGXa8WWJOMN+0Gx+3wAxYqm9hVnmXHbTX7qA4XHkWwE3nr7MMpxDjY8cmARyN0
         ImYlzaOrP4g2TIdp9CW7uXjCdfRjIfTrjNi7N9/lyfq7Mduy8NIehBdi4IvbLxYFuT1D
         V6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258849; x=1741863649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Nk4OPygl6hlYnOAq4z2AVFwBU0df555iSROa6vHa3A=;
        b=Y6jXXKAt/MDw0QWnx7699ir3fL2o1sj9WdxdP9ls95x8+m15DUcL32/W3F9OTWG9UO
         MXabBvBm9WyaOSr7Pd76FY426lYe3thQWR9YG2MO6EdzW7q0/kvHR+IyiuMpotFm8X2n
         czUwM29DUk3yXjQtucdByQvWvtGjhm76s9h+MOHjoqEVH3AtHgEvg0jKh8KBOIIOflii
         GDw5w+PtT5walmtCPbgt7vV2STxdhjSwOrGGl7vPwR/Pk4e/OF4Q6RwkY6srADXVItB1
         M3++H5f2xKos7VGn7Hq6fs5jDvMP1JhegBlTGp0YgMG2DMDbCTyPjHtNJpchlNdvk/z0
         CPjA==
X-Forwarded-Encrypted: i=1; AJvYcCXL16M0Bk+xOCJTSKkf06bftzeTNa5PVMkmf46eT/qltDKVraVlju6lfpJHtFSq2XYcu+GVcN7zJVCzOb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbk+lxSoRx7a5qZX4a9Wy+6GtfotPsEfkeNN9bY3ZtuP6JW+84
	jQCZ9+gqPtydcRqvEApxuBshHg6vcbRc+1/vlC1MJNAUF7LuBe07KXfKeAM6tanZXuYUDe+uH0A
	Svm2crnScWk9Q+3DZLA==
X-Google-Smtp-Source: AGHT+IHG431C9Dkqi/qIYLv2PsF4AG9wTnpdTRpS5AhCVpzGRU9pbxvoEXa2dp5chGFByPGXrjbUxl1WoPU70v1o
X-Received: from wmbfj12.prod.google.com ([2002:a05:600c:c8c:b0:43b:cdf0:8c03])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1988:b0:439:a1c7:7b2d with SMTP id 5b1f17b1804b1-43bd29272a3mr53453075e9.4.1741258849608;
 Thu, 06 Mar 2025 03:00:49 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:31 +0000
In-Reply-To: <20250306110038.3733649-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250306110038.3733649-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-3-vdonnefort@google.com>
Subject: [PATCH v2 2/9] KVM: arm64: Add a range to __pkvm_host_share_guest()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for supporting stage-2 huge mappings for np-guest. Add a
nr_pages argument to the __pkvm_host_share_guest hypercall. This range
supports only two values: 1 or PMD_SIZE / PAGE_SIZE (that is 512 on a
4K-pages system).

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
index 63968c7740c3..7e3a249149a0 100644
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
@@ -509,10 +512,25 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
 
 static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
 {
-	phys_addr_t end = addr + size;
+	struct hyp_page *page;
 
-	for (; addr < end; addr += PAGE_SIZE)
-		hyp_phys_to_page(addr)->host_state = state;
+	for_each_hyp_page(addr, size, page)
+		page->host_state = state;
+}
+
+static void __host_update_share_guest_count(u64 phys, u64 size, bool inc)
+{
+	struct hyp_page *page;
+
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
@@ -627,16 +645,16 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
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
 
@@ -686,10 +704,9 @@ static enum pkvm_page_state guest_get_page_state(kvm_pte_t pte, u64 addr)
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
@@ -896,49 +913,83 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
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
+	enum pkvm_page_state state;
 	struct hyp_page *page;
+	u64 size;
 	int ret;
 
 	if (prot & ~KVM_PGTABLE_PROT_RWX)
 		return -EINVAL;
 
-	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
+	ret = __guest_check_transition_size(phys, ipa, nr_pages, &size);
+	if (ret)
+		return ret;
+
+	ret = check_range_allowed_memory(phys, phys + size);
 	if (ret)
 		return ret;
 
 	host_lock_component();
 	guest_lock_component(vm);
 
-	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
+	ret = __guest_check_page_state_range(vm, ipa, size, PKVM_NOPAGE);
 	if (ret)
 		goto unlock;
 
-	page = hyp_phys_to_page(phys);
-	switch (page->host_state) {
+	state = hyp_phys_to_page(phys)->host_state;
+	for_each_hyp_page(phys, size, page) {
+		if (page->host_state != state) {
+			ret = -EPERM;
+			goto unlock;
+		}
+	}
+
+	switch (state) {
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


