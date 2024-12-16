Return-Path: <linux-kernel+bounces-447886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211DB9F3852
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926C31892CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2C20DD65;
	Mon, 16 Dec 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIy6iUwe"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527A20DD42
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371912; cv=none; b=qdM6kDNZpsjs96qa27wUJbSg3eaL3uVqj7K/yA+mRc7a8flrHD2zEi0us2phOtndvH7zAnnFWH/M0dmv12RqVV0fc2D8sqPn4dNB1jP1oACDo1gkRBWdbEzl3nvPOs3V0+pRSp6qhDIyjvu/mXfVZmrMfvkWOWQ3gof7uclew0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371912; c=relaxed/simple;
	bh=k+ngTkak7GRIfWE4ycoZPXOQuBeUPuRrK6JuE6XYOpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LXK+yqNgKHy+oi+qeSgmcU0dOx92OA3qOW6tkYrLzoZBZ3L1zy3M1NPs8vsHlPJv8yVfA+isjGxsJROeGnVBC64NArDUkrEqyNEbR7zX6yjMudL3/w8dYhXSINqBFQuxoHWGb++xBilp40Gv3YlX+Ze5cZZe+a6+W4LH4i32qNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIy6iUwe; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3d2cccbe4so3846450a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371909; x=1734976709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+LjFzCv5XYw4tM5gP6caUnlYbp8EBUjRNr5pJmRWzY=;
        b=bIy6iUwepxNjzCpHLq0NJLDxAEDR5AGtUwFLelBke3oHxJv8T1T1SKtD5TjmxpteOc
         Gg3WE170t72vi7nvKhp8FlsIoOAsdBMYK4yJ35WqiowLRMRN+n1wUJ5dwzDfWWzcdJaN
         r/Frk7HejkxSWXDg893ApYRAM0wqAW79AvfxsYpgGQ4mEThCt5QGcKXUkqM2oFtUvN/R
         9SRhLiD9Zeaiu/20c0ethwBeI5Mp32nSigOdO+G9Y6FH3aXQYI3ygTMCSFLWOW24xMgy
         +0jja6FfPxFyVjjG2sq8mz+vD17OfT1ZIsun6J9cR7Ij3P8xx1RHWRjOQY8DfDekg/zi
         hEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371909; x=1734976709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+LjFzCv5XYw4tM5gP6caUnlYbp8EBUjRNr5pJmRWzY=;
        b=RAWeY0DvmSmw0l0VA9+yy2qrkME7K3MWgL1fh7449GBF8+yZ0kkToalSrIrku/8T2O
         iKXuBqW44P9cITJhjcPnT2+pVAMwyDs/fBExS/cLknviKpBXMxC853vRU6WZsJ1uA2dx
         c97hLeZhb92tKK2kXVHJaRZ4lFrIhrPKyIYdJAOMcEr98+xz2fmGJ7xgAD5o75i1VPcP
         usz49ctqZUy1AmfRIuIIijduw2dkTav5+d3ERDwAskwtcOYEFhSrKN7Y8iq3eLZRcF+U
         UvosBxt4bjYcT1HzdyIjEbii3y//zZKt9dzDZcN2OzFlmR7dFd6i0pTHanQ1VtaAdCPQ
         ufIw==
X-Forwarded-Encrypted: i=1; AJvYcCVIwR9nJsDZoK1a/iy5nElizZ0gj9BkpWK+g3BS63iIAUDV+0i0SQtuenH8INzHbWwLV63vnL4ZzODsROo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nCabOhqXK7309Hxp1F30AjhtrkyueJ2J+zrMCLchkkQjpFbh
	yETbTRRFG4qzd+ErH1fsis5yWjAASGCiiDmaKZerF9VJpnV5TQm+XzibNubZLGOGQ3e85q6m0Q+
	k2KCLOQ==
X-Google-Smtp-Source: AGHT+IHCZhqHC8extjwLovPgFG/ljnTta5VOSeafMIM6PQ2NYnnk/wOQzU+5RyPYu2VdpKxPmvEc7HcAA2bA
X-Received: from edben9.prod.google.com ([2002:a05:6402:5289:b0:5cf:dcd3:49a1])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:13ce:b0:5d3:ba42:ea03
 with SMTP id 4fb4d7f45d1cf-5d63c30ad8emr13380104a12.8.1734371908844; Mon, 16
 Dec 2024 09:58:28 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:56 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-12-qperret@google.com>
Subject: [PATCH v3 11/18] KVM: arm64: Introduce __pkvm_host_unshare_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation for letting the host unmap pages from non-protected
guests, introduce a new hypercall implementing the host-unshare-guest
transition.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  6 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 21 ++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 67 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/pkvm.c                | 12 ++++
 6 files changed, 108 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 449337f5b2a3..0b6c4d325134 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -66,6 +66,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index a7976e50f556..e528a42ed60e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -40,6 +40,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
+int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index be52c5b15e21..0cc2a429f1fb 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -64,6 +64,11 @@ static inline bool pkvm_hyp_vcpu_is_protected(struct pkvm_hyp_vcpu *hyp_vcpu)
 	return vcpu_is_protected(&hyp_vcpu->vcpu);
 }
 
+static inline bool pkvm_hyp_vm_is_protected(struct pkvm_hyp_vm *hyp_vm)
+{
+	return kvm_vm_is_protected(&hyp_vm->kvm);
+}
+
 void pkvm_hyp_vm_table_init(void *tbl);
 
 int __pkvm_init_vm(struct kvm *host_kvm, unsigned long vm_hva,
@@ -78,6 +83,7 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
 struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void);
 
 struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
+struct pkvm_hyp_vm *get_np_pkvm_hyp_vm(pkvm_handle_t handle);
 void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm);
 
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index d659462fbf5d..3c3a27c985a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -244,6 +244,26 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) =  ret;
 }
 
+static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
+	DECLARE_REG(u64, gfn, host_ctxt, 2);
+	struct pkvm_hyp_vm *hyp_vm;
+	int ret = -EINVAL;
+
+	if (!is_protected_kvm_enabled())
+		goto out;
+
+	hyp_vm = get_np_pkvm_hyp_vm(handle);
+	if (!hyp_vm)
+		goto out;
+
+	ret = __pkvm_host_unshare_guest(gfn, hyp_vm);
+	put_pkvm_hyp_vm(hyp_vm);
+out:
+	cpu_reg(host_ctxt, 1) =  ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -454,6 +474,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__pkvm_host_share_guest),
+	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index fb9592e721cf..30243b7922f1 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1421,3 +1421,70 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
 
 	return ret;
 }
+
+static int __check_host_shared_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ipa)
+{
+	enum pkvm_page_state state;
+	struct hyp_page *page;
+	kvm_pte_t pte;
+	u64 phys;
+	s8 level;
+	int ret;
+
+	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
+	if (ret)
+		return ret;
+	if (level != KVM_PGTABLE_LAST_LEVEL)
+		return -E2BIG;
+	if (!kvm_pte_valid(pte))
+		return -ENOENT;
+
+	state = guest_get_page_state(pte, ipa);
+	if (state != PKVM_PAGE_SHARED_BORROWED)
+		return -EPERM;
+
+	phys = kvm_pte_to_phys(pte);
+	ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
+	if (WARN_ON(ret))
+		return ret;
+
+	page = hyp_phys_to_page(phys);
+	if (page->host_state != PKVM_PAGE_SHARED_OWNED)
+		return -EPERM;
+	if (WARN_ON(!page->host_share_guest_count))
+		return -EINVAL;
+
+	*__phys = phys;
+
+	return 0;
+}
+
+int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *vm)
+{
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	struct hyp_page *page;
+	u64 phys;
+	int ret;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __check_host_shared_guest(vm, &phys, ipa);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
+	if (ret)
+		goto unlock;
+
+	page = hyp_phys_to_page(phys);
+	page->host_share_guest_count--;
+	if (!page->host_share_guest_count)
+		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_OWNED));
+
+unlock:
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index f2e363fe6b84..1b0982fa5ba8 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -376,6 +376,18 @@ void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm)
 	hyp_spin_unlock(&vm_table_lock);
 }
 
+struct pkvm_hyp_vm *get_np_pkvm_hyp_vm(pkvm_handle_t handle)
+{
+	struct pkvm_hyp_vm *hyp_vm = get_pkvm_hyp_vm(handle);
+
+	if (hyp_vm && pkvm_hyp_vm_is_protected(hyp_vm)) {
+		put_pkvm_hyp_vm(hyp_vm);
+		hyp_vm = NULL;
+	}
+
+	return hyp_vm;
+}
+
 static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struct kvm *host_kvm)
 {
 	struct kvm *kvm = &hyp_vm->kvm;
-- 
2.47.1.613.gc27f4b7a9f-goog


