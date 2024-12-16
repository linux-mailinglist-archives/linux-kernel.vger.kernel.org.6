Return-Path: <linux-kernel+bounces-447892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CE9F385C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2511893E45
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C286210187;
	Mon, 16 Dec 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBNw0rfn"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4020E338
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371920; cv=none; b=oSGGyKVs62Z1iMXTbUvnN2aDYVKIIalsjaQsZblcu5CgxjZISaRBOtRzI2NYJwwidJhgsZpxrR7nOtvU8vj7+pIDB+a4j+/wsuNooxH7UnxDFtY+KAePodzc+bNjUoGA9Qwp8CvwL1QVwEZwdPAYlmz+6P4GXN45XWRrukCT28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371920; c=relaxed/simple;
	bh=QvqoA8z+hgn6vgBY6ti5ESeXdlRlORzN/4hSA1c2Xrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYcnAFvLZd95bijUBede72mnnz2gCtVtdECYL2Ur0Jcv/bv1snfnTHnJ4cWupobCdq9q8Z1NrpDFNIUeXzLks24aSxCAjnnm2M228oI90TeNJynvojKBhNI3etqEp4zf98b6qLaESg9krPZRCkGoYwL0EBDBSANChC8uGkU6l4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBNw0rfn; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa69e84128aso377610966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371917; x=1734976717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YOHiNJrZBpE7+WMk67gEyR4d7/2QuIAsHv8fTvzpm8=;
        b=WBNw0rfnjs1ObZO7bvFMm/o6cSJwYr34HJG6bzv9Om4Gr0axnJZgW7haC3n15VBeeh
         lOb2cZN3Zwo2659H+7KcKgqt/b0bhv6gE6ak8UZKRC0l83WqyMrnboRbWFhUuw8gL40T
         c1WlCGMW8ORDf11gNoDjJGibPJLsmdRF6Dkl68hS0+SwZt5VnlaDUaCmRvoG+Lfpv7iN
         o+NacYoY7UeEgDjQ8jEvfzgkdJjJLKv+536kcHKnlxsbHM1BJrWlewDulL9phlcnQ/CI
         2SYxXVAMhfXXBJ2qbgIpfl/MwRFo48Uv8rZTZl5HJ1zZS8O7hXCXuzylBkeulQXUNISJ
         ZsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371917; x=1734976717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YOHiNJrZBpE7+WMk67gEyR4d7/2QuIAsHv8fTvzpm8=;
        b=BykTHIC1s+K7iAPbYgA3rZO1AeD8k1LDcyY1hqlN76434AR43TKMrFk7RZpYpB1lIW
         PFcJavfEwayRpCzcqFGHzZ9xr8I6kr+CCv0efZzJnI8PCbGqdaPPe4sstGZZ8ho5bfxR
         xB3OLkM9BE4qzru0vjfqceEOrJU/YWwJLmMu4lU1FxPSOZWnJ+9QtxRT6s+QqTA6h1F8
         1qRavi/63GW+OhbZlCusUkSx45J2338O6MNwZO08z+lqsZ8Z0+ocN3szX9a43Mu0rodP
         zm3UsC++KEWIIwBA/iKqTZOtGY8yXuUVQaVbmX7S3pzKkA6js4WqEMXRexL3eCqf+sT5
         9Fow==
X-Forwarded-Encrypted: i=1; AJvYcCXBuJ2Ixgx1X/1oQ0nQUcDY/ZN8k+mNAMzWKPHglAQ9KPfeL6rZnBOV04ka4vSmQsf0mlE0cyuXe3CgLPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5iQ9s2ji8DFU/uwwrnR15JZWEIahlXSKXlJ8gYbpYjZdXDLGv
	cKLCapGyjyf0FFh9h9PTu5l13qxBzN+WYk91RZ7Qf1Z8z5PFr3pGwjsMzQ1cvFoTx9vH852gCFr
	uiKN4tA==
X-Google-Smtp-Source: AGHT+IGwqENMAGZonee0eKfEqVGzhNKsT5jXcNwjSd/KRUBOe/TazOnE3jhEec1mHF2pcCq0KmtgL72Jbhuo
X-Received: from edyd3.prod.google.com ([2002:a05:6402:783:b0:5d1:f6fd:8acc])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:60d6:b0:aa6:730c:acd
 with SMTP id a640c23a62f3a-aab7792c704mr1428447066b.16.1734371917086; Mon, 16
 Dec 2024 09:58:37 -0800 (PST)
Date: Mon, 16 Dec 2024 17:58:00 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-16-qperret@google.com>
Subject: [PATCH v3 15/18] KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Plumb the kvm_pgtable_stage2_mkyoung() callback into pKVM for
non-protected guests. It will be called later from the fault handling
path.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 19 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 20 +++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 4f97155d6323..a3b07db2776c 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -70,6 +70,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_mkyoung_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index b3aaad150b3e..65c34753d86c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -44,6 +44,7 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
+int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 616e172a9c48..32c4627b5b5b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -324,6 +324,24 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
 	cpu_reg(host_ctxt, 1) = ret;
 }
 
+static void handle___pkvm_host_mkyoung_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, gfn, host_ctxt, 1);
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
+	ret = __pkvm_host_mkyoung_guest(gfn, hyp_vcpu);
+out:
+	cpu_reg(host_ctxt, 1) =  ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -538,6 +556,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_relax_perms_guest),
 	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
 	HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
+	HANDLE_FUNC(__pkvm_host_mkyoung_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 0e42c3baaf4b..eae03509d371 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1549,3 +1549,23 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *
 
 	return ret;
 }
+
+int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 phys;
+	int ret;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __check_host_shared_guest(vm, &phys, ipa);
+	if (!ret)
+		kvm_pgtable_stage2_mkyoung(&vm->pgt, ipa, 0);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


