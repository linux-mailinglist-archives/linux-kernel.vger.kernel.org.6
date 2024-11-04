Return-Path: <linux-kernel+bounces-394934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AE9BB638
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE43283C10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00E1B6D03;
	Mon,  4 Nov 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+Tu2cZX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED91B6D02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727155; cv=none; b=WAp64fUvxSUSh3gsvl59lkfCiDa8xWb0YvcekuKykkuiZGxL+QTDkGej0nc30rIsS+qSFwWJk1mapuKGNYCIGZMONfxv/a8eRYDZlCbyPchvqQ+DaTaJSOqvR+60AZmrpJrHMJYbAZFEZ7QLo8gWyLOMhRsb2PgQTB5zsBkeVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727155; c=relaxed/simple;
	bh=QC28NwNzjGezmGMC9u3tuyijG+EOmrVaqakZ6LOZvOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3VDWw+fjdkAj70bbXg03oOElWm5EK3s0eNBw0qTpesyTE0AoMTEd/xBvg/c4t3vrTfm/UalFcewMqKHFIivSrbOUbl8GFE7X6rYRl8+r98e180UOSL8KsKLBCj60eCGt+MiXUveaanrDC8T8t9RhIEYew5GIok8XZKNBUW84DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+Tu2cZX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so7410659276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727152; x=1731331952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHLE7T6E8GNWbHqOU0Z7O+qf4/rYeV+4Y5GvCCJXO4g=;
        b=n+Tu2cZX/xaz5cGnvTtvyxkhz6BW7wNKlzoqVTuRl0N2DSisX5Z9fNh5ge1TDMl5hk
         vCpg8bxxRwd2uagLj/JKw5WuKofM87RJ9HDN2CiXLMrpIjRab7VcYSyuxc131si285W8
         ChPZQE4Em9SsdHgb6fGMW7IzlnW6qYQiKOPrI4sEBXeR1PR+UkBnQqbN3BpNueh0Cfaj
         w3bM+9jJc0CIq8osRlhaJKRDfN+TlO3ilvyXiWo+FobN+rSmKeX4TYqzH7/Bv0GyDRX6
         hztV1yq5RZZkbMQFVXcQPkyU9LY1BLMXU1BmnWEs2dZuujFmZCdT8QhGH74rVsDOBeft
         Z8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727152; x=1731331952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHLE7T6E8GNWbHqOU0Z7O+qf4/rYeV+4Y5GvCCJXO4g=;
        b=RVu+HNeAvAHaKP82ifFL4fjuNDu3R0Ah+rALz8dSr9l9365cCfl9ABEHLWCcj0bgPi
         zN08OZ7CV1h/Xrx70jEw1W4y9HpIgyqnOz9+D9csA+ziRdG7i1sdb0HGulZikH34d3hZ
         EQ6Y9Gsf7zXp+ztr4ygGx0xz5qOQRCy5NOZZo884jO765UgqwXI8psMF59WBAaSS9xCT
         P+M8o+udQajy+wELztaGuaxLWrz7NIyFbMrQnaEatQSF8HZfMA290nGCNlYFd7bz8PfI
         iNQUpEiVUjTD1XKW+ck8FVHp+nrKNKbnLUBcBMe0/KpseeFuToopBNjEqlyOMJ43LdS2
         ZU9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZGJ5jSasiyFy9of3JPe5Ocx55U46Su8DUziwsMZLQ84FPLOlizMpk2aTBFFS7g8dLMPGnXFkJWAJZkiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oQGCkUtTLU/1cifSj4G6s1XUORrs04Dsmff8VfQmLxglEJsr
	RBTI+VahPzmEjchp4zqXtbJrWvkDWP7G+6l0OLvVjCh6pptjC+N4nTGskg5Ga/2gBHrApUZQsZY
	AVthE9w==
X-Google-Smtp-Source: AGHT+IGc9FWtGQmxCfj3VLTtVoyIcI2cUFtsy+Np9/YxvX43mUKUKvkiVWLEzsztKOQDv2IlUxhnn2bpES5d
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a25:9b42:0:b0:e30:c741:ab06 with SMTP id
 3f1490d57ef6-e30cf42ddb2mr12768276.5.1730727152355; Mon, 04 Nov 2024 05:32:32
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:56 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-11-qperret@google.com>
Subject: [PATCH 10/18] KVM: arm64: Introduce __pkvm_host_share_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation for handling guest stage-2 mappings at EL2, introduce a
new pKVM hypercall allowing to share pages with non-protected guests.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/include/asm/kvm_host.h             |  3 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  2 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 34 +++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 70 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/pkvm.c                |  7 ++
 7 files changed, 118 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index a1c6dbec1871..b69390108c5a 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -65,6 +65,7 @@ enum __kvm_host_smccc_func {
 	/* Hypercalls available after pKVM finalisation */
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index bf64fed9820e..4b02904ec7c0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -762,6 +762,9 @@ struct kvm_vcpu_arch {
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
+	/* Pages to be donated to pkvm/EL2 if it runs out */
+	struct kvm_hyp_memcache pkvm_memcache;
+
 	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
 	u64 vsesr_el2;
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 25038ac705d8..a7976e50f556 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -39,6 +39,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
+int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 08f3a0416d4c..457318215155 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -47,6 +47,8 @@ struct hyp_page {
 
 	/* Host (non-meta) state. Guarded by the host stage-2 lock. */
 	enum pkvm_page_state host_state : 8;
+
+	u32 host_share_guest_count;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 6bcdba4fdc76..32bdf6b27958 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -209,6 +209,39 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) =  ret;
 }
 
+static int pkvm_refill_memcache(struct pkvm_hyp_vcpu *hyp_vcpu)
+{
+	struct kvm_vcpu *host_vcpu = hyp_vcpu->host_vcpu;
+
+	return refill_memcache(&hyp_vcpu->vcpu.arch.pkvm_memcache,
+			       host_vcpu->arch.pkvm_memcache.nr_pages,
+			       &host_vcpu->arch.pkvm_memcache);
+}
+
+static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, pfn, host_ctxt, 1);
+	DECLARE_REG(u64, gfn, host_ctxt, 2);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+	int ret = -EINVAL;
+
+	if (!is_protected_kvm_enabled())
+		goto out;
+
+	hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
+	if (!hyp_vcpu || pkvm_hyp_vcpu_is_protected(hyp_vcpu))
+		goto out;
+
+	ret = pkvm_refill_memcache(hyp_vcpu);
+	if (ret)
+		goto out;
+
+	ret = __pkvm_host_share_guest(pfn, gfn, hyp_vcpu, prot);
+out:
+	cpu_reg(host_ctxt, 1) =  ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -425,6 +458,7 @@ static const hcall_t host_hcall[] = {
 
 	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
+	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1595081c4f6b..a69d7212b64c 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -861,6 +861,27 @@ static int hyp_complete_donation(u64 addr,
 	return pkvm_create_mappings_locked(start, end, prot);
 }
 
+static enum pkvm_page_state guest_get_page_state(kvm_pte_t pte, u64 addr)
+{
+	if (!kvm_pte_valid(pte))
+		return PKVM_NOPAGE;
+
+	return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
+}
+
+static int __guest_check_page_state_range(struct pkvm_hyp_vcpu *vcpu, u64 addr,
+					  u64 size, enum pkvm_page_state state)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+	struct check_walk_data d = {
+		.desired	= state,
+		.get_page_state	= guest_get_page_state,
+	};
+
+	hyp_assert_lock_held(&vm->lock);
+	return check_page_state_range(&vm->pgt, addr, size, &d);
+}
+
 static int check_share(struct pkvm_mem_share *share)
 {
 	const struct pkvm_mem_transition *tx = &share->tx;
@@ -1343,3 +1364,52 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
 
 	return ret;
 }
+
+int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
+			    enum kvm_pgtable_prot prot)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+	u64 phys = hyp_pfn_to_phys(pfn);
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	struct hyp_page *page;
+	int ret;
+
+	if (prot & ~KVM_PGTABLE_PROT_RWX)
+		return -EINVAL;
+
+	ret = range_is_allowed_memory(phys, phys + PAGE_SIZE);
+	if (ret)
+		return ret;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __guest_check_page_state_range(vcpu, ipa, PAGE_SIZE, PKVM_NOPAGE);
+	if (ret)
+		goto unlock;
+
+	page = hyp_phys_to_page(phys);
+	switch (page->host_state) {
+	case PKVM_PAGE_OWNED:
+		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_SHARED_OWNED));
+		break;
+	case PKVM_PAGE_SHARED_OWNED:
+		/* Only host to np-guest multi-sharing is tolerated */
+		WARN_ON(!page->host_share_guest_count);
+		break;
+	default:
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	WARN_ON(kvm_pgtable_stage2_map(&vm->pgt, ipa, PAGE_SIZE, phys,
+				       pkvm_mkstate(prot, PKVM_PAGE_SHARED_BORROWED),
+				       &vcpu->vcpu.arch.pkvm_memcache, 0));
+	page->host_share_guest_count++;
+
+unlock:
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index d242da1ec56a..bdcfcc20cf66 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -680,6 +680,13 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
 	/* Push the metadata pages to the teardown memcache */
 	for (idx = 0; idx < hyp_vm->nr_vcpus; ++idx) {
 		struct pkvm_hyp_vcpu *hyp_vcpu = hyp_vm->vcpus[idx];
+		struct kvm_hyp_memcache *vcpu_mc = &hyp_vcpu->vcpu.arch.pkvm_memcache;
+
+		while (vcpu_mc->nr_pages) {
+			void *addr = pop_hyp_memcache(vcpu_mc, hyp_phys_to_virt);
+			push_hyp_memcache(mc, addr, hyp_virt_to_phys);
+			unmap_donated_memory_noclear(addr, PAGE_SIZE);
+		}
 
 		teardown_donated_memory(mc, hyp_vcpu, sizeof(*hyp_vcpu));
 	}
-- 
2.47.0.163.g1226f6d8fa-goog


