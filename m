Return-Path: <linux-kernel+bounces-530382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC5A432B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAEE3B6B96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1BF14BFA2;
	Tue, 25 Feb 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j51rNMMs"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282D133987
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448422; cv=none; b=XYwFXCVbP4t3gcUpYSk6Fe05JCPHxHGYDSPgM8C/mUQUJ7GA6pvKa9a7IhPMShhHvvhqot8B0EnjxxwWRNnggr/lJdc4HnyNRswtr0MgmIZZJnZ0/nk9HtPFkK9iZS8+VLTeQvzbXLbtDELgVOgy2uQXVl92SNg+Cvjw8qrNJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448422; c=relaxed/simple;
	bh=G4kbwapJ8xN308f+p/Fax6Gc5PoYYSkhHYuE1MyjKho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uFVtKwwOYhJUyrp0SIINkSrU4iwg0b9Fw36+4qXNGYP0/hpyMv9xGjMAXZGN/hjRYU45jdBz+fVLhqvFeLaRJkMV47GvmfXnCT4WpJCc6eNoMK34s3T8vEY56N3ldRnhjGjAiG5ZdJZiinbPjZQvIl5T1tUPFmXUEvlbPj2wWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j51rNMMs; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e067bbd3baso4523518a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740448418; x=1741053218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7dZmTdaF5BfvE12HLbTKAM/qU/qgzQacpIdfJS89lM=;
        b=j51rNMMsNMAtNbOBSD+BpEUjTo4gMFQ4lZYYK/Mb0zVC7av5B0GXT/+a71XIu8A0d1
         bBXthYSJFqpGuzjONa6UowjVlCsgQeNzKZjaVkkaIJmYStliLP24V86R6MmIoE09USiI
         +NxvF17xLfbumnImEzVAXSRYceyAKIZn1Va/h4kdEfsLA80bHgAcoFBPkUaAr4BsnMCy
         7cSv6PL7Rt8uPKk46qAswllaqz3RXgaUKQ58REnudPodpbMMQQiA5Emm/nSav3K4d4zk
         1UR4lVqpXBncTFOyTJBlrztHBJ7CNjUufcNnhh7x3XnTLDv70blAOmg5DfZjCU9xr23J
         wvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448418; x=1741053218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7dZmTdaF5BfvE12HLbTKAM/qU/qgzQacpIdfJS89lM=;
        b=PCSeOeEpnqDn9nMj6OG/JUJgGKppGbE8Slzp+4UTBVHb5mm2rhLINDO/5PGFzrAIgT
         M/jVi2rICorgY8hojmwZAi5BiuGsWrQPOUMC88rXbMZgyEMVxpiXwc0tY3xNqophMVbn
         A3xnxSMGzMRsSHBiH6nwrkDr33AWOqg2EHUBPyJzbLZgcm6n+9CUXaNsA83VgGdlrF56
         EP2quDU7SjzBy/4XMVxu67RNsx4Xsxy2l3LeR24eIvr+EuNdnBUTxp2IMq4Y3Eps/Qud
         +XFAz9DqKTKXFaNtaOlkn96xin3Vj67OSyeTSTKgAArBNjiN01SwEQRZZpcjm7xx9yC0
         Qb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBhu6L4fY8mPrYK2h18zoMzt7j+uJ8l6nLFC6rQWU3zoLf1r0WJ+C0G8I22EUEpqMoKygwaMXZJRRf77E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQO9y1BMQUcUf4M7roke7x/RDN+XRuWuNZodr0p2/Yz1iPz2G
	DemTOAZeTHE9FWup5cGTsZiuRvrx9tC2z0rPQeELuhNYg/pgcJat85De2IBw/YJqPnLyONcwgXq
	RYVTMYg==
X-Google-Smtp-Source: AGHT+IGwggas76Qq6nVnBY8hQptDHcF9hAdQuXod8zicSSA+dENSbfVyJVzhiJxQLNjNL2CSji69tgz9i4oD
X-Received: from edbig12.prod.google.com ([2002:a05:6402:458c:b0:5de:6e72:c13b])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42c5:b0:5e0:87fb:72fb
 with SMTP id 4fb4d7f45d1cf-5e0b70b707dmr17770196a12.6.1740448418641; Mon, 24
 Feb 2025 17:53:38 -0800 (PST)
Date: Tue, 25 Feb 2025 01:53:27 +0000
In-Reply-To: <20250225015327.3708420-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225015327.3708420-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225015327.3708420-5-qperret@google.com>
Subject: [PATCH v2 4/4] KVM: arm64: Extend pKVM selftest for np-guests
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"

The pKVM selftest intends to test as many memory 'transitions' as
possible, so extend it to cover sharing pages with non-protected guests,
including in the case of multi-sharing.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pkvm.h             |  6 ++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  4 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 90 ++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c               |  8 +-
 arch/arm64/kvm/pkvm.c                         |  1 +
 5 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index eb65f12e81d9..104b6b5ab6f5 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -134,6 +134,12 @@ static inline unsigned long host_s2_pgtable_pages(void)
 	return res;
 }
 
+#ifdef CONFIG_PKVM_SELFTESTS
+static inline unsigned long pkvm_selftest_pages(void) { return 32; }
+#else
+static inline unsigned long pkvm_selftest_pages(void) { return 0; }
+#endif
+
 #define KVM_FFA_MBOX_NR_PAGES	1
 
 static inline unsigned long hyp_ffa_proxy_pages(void)
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 31a3f2cdf242..dd53af947a58 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -69,8 +69,8 @@ static __always_inline void __load_host_stage2(void)
 }
 
 #ifdef CONFIG_PKVM_SELFTESTS
-void pkvm_ownership_selftest(void);
+void pkvm_ownership_selftest(void *base);
 #else
-static inline void pkvm_ownership_selftest(void) { }
+static inline void pkvm_ownership_selftest(void *base) { }
 #endif
 #endif /* __KVM_NVHE_MEM_PROTECT__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 46f3f4aeecc5..a03a2665e234 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1088,16 +1088,60 @@ int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
 struct pkvm_expected_state {
 	enum pkvm_page_state host;
 	enum pkvm_page_state hyp;
+	enum pkvm_page_state guest[2]; /* [ gfn, gfn + 1 ] */
 };
 
 static struct pkvm_expected_state selftest_state;
 static struct hyp_page *selftest_page;
 
+static struct pkvm_hyp_vm selftest_vm = {
+	.kvm = {
+		.arch = {
+			.mmu = {
+				.arch = &selftest_vm.kvm.arch,
+				.pgt = &selftest_vm.pgt,
+			},
+		},
+	},
+};
+
+static struct pkvm_hyp_vcpu selftest_vcpu = {
+	.vcpu = {
+		.arch = {
+			.hw_mmu = &selftest_vm.kvm.arch.mmu,
+		},
+		.kvm = &selftest_vm.kvm,
+	},
+};
+
+static void init_selftest_vm(void *virt)
+{
+	struct hyp_page *p = hyp_virt_to_page(virt);
+	int i;
+
+	selftest_vm.kvm.arch.mmu.vtcr = host_mmu.arch.mmu.vtcr;
+	WARN_ON(kvm_guest_prepare_stage2(&selftest_vm, virt));
+
+	for (i = 0; i < pkvm_selftest_pages(); i++) {
+		if (p[i].refcount)
+			continue;
+		p[i].refcount = 1;
+		hyp_put_page(&selftest_vm.pool, hyp_page_to_virt(&p[i]));
+	}
+}
+
+static u64 selftest_ipa(void)
+{
+	return BIT(selftest_vm.pgt.ia_bits - 1);
+}
+
 static void assert_page_state(void)
 {
 	void *virt = hyp_page_to_virt(selftest_page);
 	u64 size = PAGE_SIZE << selftest_page->order;
+	struct pkvm_hyp_vcpu *vcpu = &selftest_vcpu;
 	u64 phys = hyp_virt_to_phys(virt);
+	u64 ipa[2] = { selftest_ipa(), selftest_ipa() + PAGE_SIZE };
 
 	host_lock_component();
 	WARN_ON(__host_check_page_state_range(phys, size, selftest_state.host));
@@ -1106,6 +1150,11 @@ static void assert_page_state(void)
 	hyp_lock_component();
 	WARN_ON(__hyp_check_page_state_range((u64)virt, size, selftest_state.hyp));
 	hyp_unlock_component();
+
+	guest_lock_component(&selftest_vm);
+	WARN_ON(__guest_check_page_state_range(vcpu, ipa[0], size, selftest_state.guest[0]));
+	WARN_ON(__guest_check_page_state_range(vcpu, ipa[1], size, selftest_state.guest[1]));
+	guest_unlock_component(&selftest_vm);
 }
 
 #define assert_transition_res(res, fn, ...)		\
@@ -1114,21 +1163,27 @@ static void assert_page_state(void)
 		assert_page_state();			\
 	} while (0)
 
-void pkvm_ownership_selftest(void)
+void pkvm_ownership_selftest(void *base)
 {
+	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RWX;
 	void *virt = hyp_alloc_pages(&host_s2_pool, 0);
-	u64 phys, size, pfn;
+	struct pkvm_hyp_vcpu *vcpu = &selftest_vcpu;
+	struct pkvm_hyp_vm *vm = &selftest_vm;
+	u64 phys, size, pfn, gfn;
 
 	WARN_ON(!virt);
 	selftest_page = hyp_virt_to_page(virt);
 	selftest_page->refcount = 0;
+	init_selftest_vm(base);
 
 	size = PAGE_SIZE << selftest_page->order;
 	phys = hyp_virt_to_phys(virt);
 	pfn = hyp_phys_to_pfn(phys);
+	gfn = hyp_phys_to_pfn(selftest_ipa());
 
 	selftest_state.host = PKVM_NOPAGE;
 	selftest_state.hyp = PKVM_PAGE_OWNED;
+	selftest_state.guest[0] = selftest_state.guest[1] = PKVM_NOPAGE;
 	assert_page_state();
 	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
@@ -1136,6 +1191,8 @@ void pkvm_ownership_selftest(void)
 	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_host_unshare_ffa, pfn, 1);
 	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
+	assert_transition_res(-EPERM,	__pkvm_host_share_guest, pfn, gfn, vcpu, prot);
+	assert_transition_res(-ENOENT,	__pkvm_host_unshare_guest, gfn, vm);
 
 	selftest_state.host = PKVM_PAGE_OWNED;
 	selftest_state.hyp = PKVM_NOPAGE;
@@ -1143,6 +1200,7 @@ void pkvm_ownership_selftest(void)
 	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_host_unshare_hyp, pfn);
 	assert_transition_res(-EPERM,	__pkvm_host_unshare_ffa, pfn, 1);
+	assert_transition_res(-ENOENT,	__pkvm_host_unshare_guest, gfn, vm);
 	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
 
 	selftest_state.host = PKVM_PAGE_SHARED_OWNED;
@@ -1152,6 +1210,8 @@ void pkvm_ownership_selftest(void)
 	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_guest, pfn, gfn, vcpu, prot);
+	assert_transition_res(-ENOENT,	__pkvm_host_unshare_guest, gfn, vm);
 
 	assert_transition_res(0,	hyp_pin_shared_mem, virt, virt + size);
 	assert_transition_res(0,	hyp_pin_shared_mem, virt, virt + size);
@@ -1162,6 +1222,8 @@ void pkvm_ownership_selftest(void)
 	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_guest, pfn, gfn, vcpu, prot);
+	assert_transition_res(-ENOENT,	__pkvm_host_unshare_guest, gfn, vm);
 
 	hyp_unpin_shared_mem(virt, virt + size);
 	assert_page_state();
@@ -1179,6 +1241,8 @@ void pkvm_ownership_selftest(void)
 	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
 	assert_transition_res(-EPERM,	__pkvm_host_unshare_hyp, pfn);
 	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_guest, pfn, gfn, vcpu, prot);
+	assert_transition_res(-ENOENT,	__pkvm_host_unshare_guest, gfn, vm);
 	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
 
 	selftest_state.host = PKVM_PAGE_OWNED;
@@ -1186,6 +1250,28 @@ void pkvm_ownership_selftest(void)
 	assert_transition_res(0,	__pkvm_host_unshare_ffa, pfn, 1);
 	assert_transition_res(-EPERM,	__pkvm_host_unshare_ffa, pfn, 1);
 
+	selftest_state.host = PKVM_PAGE_SHARED_OWNED;
+	selftest_state.guest[0] = PKVM_PAGE_SHARED_BORROWED;
+	assert_transition_res(0,	__pkvm_host_share_guest, pfn, gfn, vcpu, prot);
+	assert_transition_res(-EPERM,	__pkvm_host_share_guest, pfn, gfn, vcpu, prot);
+	assert_transition_res(-EPERM,	__pkvm_host_share_ffa, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_donate_hyp, pfn, 1);
+	assert_transition_res(-EPERM,	__pkvm_host_share_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_host_unshare_hyp, pfn);
+	assert_transition_res(-EPERM,	__pkvm_hyp_donate_host, pfn, 1);
+	assert_transition_res(-EPERM,	hyp_pin_shared_mem, virt, virt + size);
+
+	selftest_state.guest[1] = PKVM_PAGE_SHARED_BORROWED;
+	assert_transition_res(0,	__pkvm_host_share_guest, pfn, gfn + 1, vcpu, prot);
+	WARN_ON(hyp_virt_to_page(virt)->host_share_guest_count != 2);
+
+	selftest_state.guest[0] = PKVM_NOPAGE;
+	assert_transition_res(0,	__pkvm_host_unshare_guest, gfn, vm);
+
+	selftest_state.guest[1] = PKVM_NOPAGE;
+	selftest_state.host = PKVM_PAGE_OWNED;
+	assert_transition_res(0,	__pkvm_host_unshare_guest, gfn + 1, vm);
+
 	selftest_state.host = PKVM_NOPAGE;
 	selftest_state.hyp = PKVM_PAGE_OWNED;
 	assert_transition_res(0,	__pkvm_host_donate_hyp, pfn, 1);
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 54006f959e1b..814548134a83 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -28,6 +28,7 @@ static void *vmemmap_base;
 static void *vm_table_base;
 static void *hyp_pgt_base;
 static void *host_s2_pgt_base;
+static void *selftest_base;
 static void *ffa_proxy_pages;
 static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
 static struct hyp_pool hpool;
@@ -38,6 +39,11 @@ static int divide_memory_pool(void *virt, unsigned long size)
 
 	hyp_early_alloc_init(virt, size);
 
+	nr_pages = pkvm_selftest_pages();
+	selftest_base = hyp_early_alloc_contig(nr_pages);
+	if (nr_pages && !selftest_base)
+		return -ENOMEM;
+
 	nr_pages = hyp_vmemmap_pages(sizeof(struct hyp_page));
 	vmemmap_base = hyp_early_alloc_contig(nr_pages);
 	if (!vmemmap_base)
@@ -309,7 +315,7 @@ void __noreturn __pkvm_init_finalise(void)
 
 	pkvm_hyp_vm_table_init(vm_table_base);
 
-	pkvm_ownership_selftest();
+	pkvm_ownership_selftest(selftest_base);
 out:
 	/*
 	 * We tail-called to here from handle___pkvm_init() and will not return,
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 5a75f9554e57..728ae5f44da3 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -79,6 +79,7 @@ void __init kvm_hyp_reserve(void)
 	hyp_mem_pages += host_s2_pgtable_pages();
 	hyp_mem_pages += hyp_vm_table_pages();
 	hyp_mem_pages += hyp_vmemmap_pages(STRUCT_HYP_PAGE_SIZE);
+	hyp_mem_pages += pkvm_selftest_pages();
 	hyp_mem_pages += hyp_ffa_proxy_pages();
 
 	/*
-- 
2.48.1.658.g4767266eb4-goog


