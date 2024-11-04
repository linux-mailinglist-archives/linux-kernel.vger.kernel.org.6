Return-Path: <linux-kernel+bounces-394935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873B9BB639
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF945B22076
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1DB1BD4E4;
	Mon,  4 Nov 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yN73upSI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF71BC065
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727157; cv=none; b=NIulq1Id/RmsbMQrTZ0kU79i1KMaO9LYLx4FljGkwvm+eh0R52bgvbzlVTTBo9nyjRpfK7OXYW+1HvwX86z8GznNPDoI6g2+U4GUELq0M1UZSnnJfWco16pbdhHQis3SwfundyJibWWKOGnmql8weA379vc8RlEz9wDKgW5PxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727157; c=relaxed/simple;
	bh=yxI6nOj/2BlS35z5zeuNbWN5QGACUR0d82SG3HMgbro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A13iCmC1OecA+qhUSl+3/QS3lkKI6NTgTEGugVhL5G3zI3Hn7lPs5UFxOkFrx/WXFATnvCioQ3VN+GLZMYGELzKxIsdNqKFJbRe/TgLGROIHAg0BPAPAEa9wXObwtA9dXL4vSn0+ozB61yqYbK9Evto3pa8Akb5De6qPDsR7rCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yN73upSI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30df8dbfd4so8366774276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727155; x=1731331955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRegJK0d/KTMFa1b8xxTA9sCjP756MDWGX2tZ8RiT/M=;
        b=yN73upSIgTgDUFMM5CEZmjSDzDq3YPCyeYNx/wZXLjNKS8kdQH0fV2mN0He00vDoFo
         iXkXxzZPjzKDA1kipS5lcKIjfLAV9cdt8r2SSVhCCQHDmTu7Un/RkRAuzEec2iUJwzsh
         3VxBy9vqZU6l33ft2MrJHbFAUbsRXvKsfwYbL3901oYMLWn94xYmuyPN2OfIFAxNTrhf
         FVcd5vN99dGJDzp09YOoEayshPgV2GigCqNKfrL1Qa5pdxJ7b6YC0g0SwxJQMV6WjnO7
         av1VtmS3w+uCD/a+srgATY1Ea7Ihg4mafiDs8GUXVKM+GwwuIfOHA2dq5MZWEMqelhS+
         /uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727155; x=1731331955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRegJK0d/KTMFa1b8xxTA9sCjP756MDWGX2tZ8RiT/M=;
        b=Ki2fVHwzYDCdsz4UR+AqMXfSaj51h8Qu6Yo5P31q+1VchuWDnE5GUR8MDP4X7YXkzp
         /eLTw9h4pIFeACovvl5CEzVGfvqbm5qbm/NAQgBxJFTiT8xRhpYsWugxYcrw2pAmGMrD
         tLVTsgUXQmbdfV4/rS0Pd4DuTF2ssJNKGLcMSOtY/NkYLmY2ioPXsYpR0D6eaNmEBybl
         9dYL4/92wuck7fao7usw57A1gkhd5hGk0O6NjVZioBqZpRrsdn4n6AK98D8BoF9fVJ4O
         LKoExItluVuMMTKczPA+SKfjXJ/caEzwkxLkSkPK9Gw7+7rg9Kt905TzSE+yJmQZmJdj
         wZYg==
X-Forwarded-Encrypted: i=1; AJvYcCWFnD+S+uZZxznSUek4nrlfHINMO3PTMo0yz7y7aaOvkzZ4WptiZiUtfJ/Etp/Ffz6lybh87ujwwsg3Drs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIftAT9ZJOhbd8s94J2ZrbJvi15Qh8RXW7UVxhmJ6qOT/BgIy
	6/DaHsXv5+uaFq2h4LKsmqxcemd334WhhhW/Zttgzz85EUaeogpwLQmUqllraHo8Eks2phZhklu
	foVRpOw==
X-Google-Smtp-Source: AGHT+IGR8bsfJ02p9vHy+seXY+BmxTKO7YUK2HiE8eFkkm9wUjhjecldaQfmnnOt9C+IS5sr/2xmgAJlbcZ8
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a25:c710:0:b0:e30:d61e:b110 with SMTP id
 3f1490d57ef6-e33025662cdmr10816276.5.1730727154895; Mon, 04 Nov 2024 05:32:34
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:57 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-12-qperret@google.com>
Subject: [PATCH 11/18] KVM: arm64: Introduce __pkvm_host_unshare_guest()
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
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  5 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 24 ++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 78 +++++++++++++++++++
 5 files changed, 109 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b69390108c5a..e67efee936b6 100644
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
index be52c5b15e21..5dfc9ece9aa5 100644
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
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 32bdf6b27958..68bbef69d99a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -242,6 +242,29 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
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
+	hyp_vm = get_pkvm_hyp_vm(handle);
+	if (!hyp_vm)
+		goto out;
+	if (pkvm_hyp_vm_is_protected(hyp_vm))
+		goto put_hyp_vm;
+
+	ret = __pkvm_host_unshare_guest(gfn, hyp_vm);
+put_hyp_vm:
+	put_pkvm_hyp_vm(hyp_vm);
+out:
+	cpu_reg(host_ctxt, 1) =  ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -459,6 +482,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__pkvm_host_share_guest),
+	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a69d7212b64c..f7476a29e1a9 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1413,3 +1413,81 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
 
 	return ret;
 }
+
+static int guest_get_valid_pte(struct pkvm_hyp_vm *vm, u64 *phys, u64 ipa, u8 order, kvm_pte_t *pte)
+{
+	size_t size = PAGE_SIZE << order;
+	s8 level;
+
+	if (order && size != PMD_SIZE)
+		return -EINVAL;
+
+	WARN_ON(kvm_pgtable_get_leaf(&vm->pgt, ipa, pte, &level));
+
+	if (kvm_granule_size(level) != size)
+		return -E2BIG;
+
+	if (!kvm_pte_valid(*pte))
+		return -ENOENT;
+
+	*phys = kvm_pte_to_phys(*pte);
+
+	return 0;
+}
+
+static int __check_host_unshare_guest(struct pkvm_hyp_vm *vm, u64 *phys, u64 ipa)
+{
+	enum pkvm_page_state state;
+	struct hyp_page *page;
+	kvm_pte_t pte;
+	int ret;
+
+	ret = guest_get_valid_pte(vm, phys, ipa, 0, &pte);
+	if (ret)
+		return ret;
+
+	state = guest_get_page_state(pte, ipa);
+	if (state != PKVM_PAGE_SHARED_BORROWED)
+		return -EPERM;
+
+	ret = range_is_allowed_memory(*phys, *phys + PAGE_SIZE);
+	if (ret)
+		return ret;
+
+	page = hyp_phys_to_page(*phys);
+	if (page->host_state != PKVM_PAGE_SHARED_OWNED)
+		return -EPERM;
+	WARN_ON(!page->host_share_guest_count);
+
+	return 0;
+}
+
+int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
+{
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	struct hyp_page *page;
+	u64 phys;
+	int ret;
+
+	host_lock_component();
+	guest_lock_component(hyp_vm);
+
+	ret = __check_host_unshare_guest(hyp_vm, &phys, ipa);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_stage2_unmap(&hyp_vm->pgt, ipa, PAGE_SIZE);
+	if (ret)
+		goto unlock;
+
+	page = hyp_phys_to_page(phys);
+	page->host_share_guest_count--;
+	if (!page->host_share_guest_count)
+		WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_OWNED));
+
+unlock:
+	guest_unlock_component(hyp_vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.163.g1226f6d8fa-goog


