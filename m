Return-Path: <linux-kernel+bounces-394937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7009BB63D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CB2B23ABC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C8C1C07E3;
	Mon,  4 Nov 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6wKdx3U"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6961C07C2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727163; cv=none; b=hmvjYqrf12+hmT/1LxFQqlOHEvRCltHeKLRcZPSYTo9gZw6ZgnIbMGKpGmHJ6JtFAofAnjgpM2Jz86bOsAmuoVluhJaMwv+hWlY3ERRl93gmvqOlhzcSSm4Xy6Uqp0YmwXPTkHX/rPNJHiLU3Zv2GKvNE4dLY2yJbJzyolpayNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727163; c=relaxed/simple;
	bh=QNK2du7NE/nakBhDA8m3plYiS7NRinYGNYXnIRmV/B4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BxaCpfBwwEZAA8Joov2UbH0w7cB3183hcQC9NtB4IToPjGxhMhhrrFhG8D6laosXLipdB40ENA43RDaEG8EY7hVZPRG9mRnQpOPNNBf3sWsGT2I0TnD0DJb3WFsgGtA1L0VmO5xgKwYulOXU9AFoYnGZoqwd6KQLBf+6J+iOxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6wKdx3U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e6101877abso79860257b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727159; x=1731331959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucFddVYYmKv6sICxH6cRQFB8Ka0EmmzO4w0j05CMWug=;
        b=o6wKdx3US04tUVHMikWSCphxL/FVRkjvyUZBi3OfChW5lIKtTkzyjJAgSWjBGPWID5
         jPABGHzJmypE2V7QBqhsq29tMATprUfU38KjJ47mOUPO9ywi0xmMonlCuxy3UlPlGqeP
         69DC4ARjLsylzy9v+vbkd0kvYE5XkJteQEt31Mz4YDZBbKFGDGDsqeIa9O62VmrX0Dj5
         27nOsbEu+QYuxTlxF/Ta4hbx0TrEcx6iKH3dxmmH2DORo3tjNfGo7trJCR7e6YIoYR54
         LeEnTCNU3yrJQa+2Y7ngm1so2RXpbD5eaId0B/pZbHOIZAOWDUuoYHzSn9B4CEqc0btC
         gbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727159; x=1731331959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucFddVYYmKv6sICxH6cRQFB8Ka0EmmzO4w0j05CMWug=;
        b=Jd4wOsZ54Xftm2Hqbkn8LDGAwUXnmJKglrbzGCNmEQKL0bY1B8PZjQe6liaAT3ulwV
         pIThuqR6pDvJ0qMBfj4+WX7dXId0FoMswPZamrhgmlwaLqJ3gIznVn2GAYF9szRLzK/N
         OjkzXnXfqzpk0w928POVV7IQUeABnntwl8EwUVBLaYzg02MyovJZUvGJ/zYAp2FozbhD
         gPKDEUDuXdzkGAax7FebCodZEdqDEJC7TR/hfygB1yOuFrYgwLWPSqPrRimQl69el0Eq
         77HJWRGXa5bjyYO5R8DEOVwkeKqLPjWUAk2w83T+g97rzTvbvin6ADMaY/jwbwrj4ucY
         C1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWSEah6vWpymYhjPFCvZj/VHPLS+nIO/RYBg1by/G6Fa27jhFKem4IaiDsc/bqldKl18NKuiHdhCteJB58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zW+9Qh8MZrt5eKx0KzYOAECHSxWGRpdKrUIrc5A4tiVXtC++
	UaZ+OpwaS03MXM+PFtUQw0mnFiwBMqm4aWXR73fejQTkexA13VuE2St+MCVxMCFgGyMJLee/Cvf
	Lx88F7A==
X-Google-Smtp-Source: AGHT+IGBa0WaXIVQ6f/knL91GvKmh8psD2Fj6oZFqWjEZD8hAxiH7KoDd3VReE3WYYM+VRLwqJwKNMXlhvth
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:690c:64c6:b0:6e3:c503:d1ec with SMTP
 id 00721157ae682-6ea64c29ea7mr1983467b3.7.1730727159727; Mon, 04 Nov 2024
 05:32:39 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:59 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-14-qperret@google.com>
Subject: [PATCH 13/18] KVM: arm64: Introduce __pkvm_host_wrprotect_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a new hypercall to remove the write permission from a
non-protected guest stage-2 mapping. This will be used for e.g. enabling
dirty logging.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 24 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 21 ++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index f528656e8359..3f1f0760c375 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -68,6 +68,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index db0dd83c2457..8658b5932473 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -42,6 +42,7 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
+int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index d3210719e247..ce33079072c0 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -284,6 +284,29 @@ static void handle___pkvm_host_relax_guest_perms(struct kvm_cpu_context *host_ct
 	cpu_reg(host_ctxt, 1) = ret;
 }
 
+static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt)
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
+	ret = __pkvm_host_wrprotect_guest(gfn, hyp_vm);
+put_hyp_vm:
+	put_pkvm_hyp_vm(hyp_vm);
+out:
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -503,6 +526,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
+	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index fc6050dcf904..3a8751175fd5 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1516,3 +1516,24 @@ int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pk
 
 	return ret;
 }
+
+int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
+{
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 phys;
+	int ret;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __check_host_unshare_guest(vm, &phys, ipa);
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, PAGE_SIZE);
+unlock:
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.163.g1226f6d8fa-goog


