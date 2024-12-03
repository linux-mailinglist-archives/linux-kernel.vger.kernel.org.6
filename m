Return-Path: <linux-kernel+bounces-429257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62C9E1987
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E61280F85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6B1E230D;
	Tue,  3 Dec 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKhU8sh4"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1C1E47B9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222289; cv=none; b=o5228VrgaR3YfccFyznuf+klnAm+vIDFJCo1WV/skqX/N9O3vL/j/ynPQKnYZfV0ShAfXl7rOyc/1NqkhNfIZ9BXvdjsCXdEohhGGsVifvUfWAdcUH4HErCNrVJPTBnQK7QJ5gBKwq9RBvsMK0cL19UwJ3A1le6hHO2ziSmMaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222289; c=relaxed/simple;
	bh=ICUHvSlEArw0Fh0+CZv2ENH+bewidwtFvTEiJ0+7xHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oF5o1TYsPUtd+pvPSKSn1LCBcjdzh1sjXNt1h9FtjJonx3V1GnLrMb7Y3LT07aWUxP70dEHowh7gpQ8JZb0OlAYN89JeCB+aTzpYpMShx7hnYTK0MycPSjANGc/1eR7OtyMprRM9veYykRweqws2CzmDWvpEhgZOzVP7+HzFS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKhU8sh4; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0cdd92f1fso2325300a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222285; x=1733827085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yheeE+t2hfFO7oe3GWstJ0qpUPIfuz1IZC6MMTVFSoE=;
        b=sKhU8sh4pOY4v1Y6It6eiqTSBrF+vLQGPQ361srKyXEP+wfRnV00cS0tjY5fL7t0hK
         PnjZsYh+h66croP94xBp0apgnN91J4AZZ4Ujdx2NTd+lV9axCO9xw3E6da61OeQMkB5+
         HZHJLqGbXkFk+osrFkpLwMB4NwYSqDovU4AFgIfL9Dwkfmb6iqaUuurohHAPeLGYm9ey
         7RumLf5Wo4Gi5Dw81RcCkmLXe2kR2yBSDOp5hl0KNvdmHmm1sEbVFZK/tcU/wlPbIHmK
         T8Z0QkqrK4DR53pVSbFseAgEUyG0xx6Nt8ds6lLa/31c45oTmClnyaUbv9OiYIguPPD6
         TPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222285; x=1733827085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yheeE+t2hfFO7oe3GWstJ0qpUPIfuz1IZC6MMTVFSoE=;
        b=UtGlX/4tTZt6hze+GmZ9ctlDLQOhhMHza5hqKF3jBi/40cxVJUqFCBDO3EPFQwDNSL
         HDVtVxDs6h9gQe9+7LWo8kaG9coqVfaXXfJmhR/b76AF9JuoApMNc7Y+pkR8dD/yA4z+
         w87TpBcTN18NA3e0vLi9r5If5NZPHTkTM9rYN7m2+eB6WbGv5eXmqRyfU8IVQ1d5N9t9
         PSJnX77Qmsr72u3Dxy/gJnhO3/QqXl7EIyc8nbmbVXm0TiLHpbb/dsoNVgNF9yxsR3BE
         czvvSRjhO4/vxQd8u6ZN4WwoxekDfzumOdKkvOeNxETfVEHlfXoNkKF0K0IggMZfY9r0
         QDSw==
X-Forwarded-Encrypted: i=1; AJvYcCX53z7HHcEwEq+BWSPeoFQflgQza691hJCMNjdeajE359gwbMwMAx3RKsTzCDoUSocFleBG7NDiJ6CmZC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQc2eGGmb2mGjdSNj23SvQ/+Q3cmr9adLsPN8qTGnxA2VINvK
	GSPrCb2EiWSQ3R6St6TwEvOo4ohfyn7ERkw+Jtw7E7rbfohS+Zd1iD1Ie4waOnbz3U9QctLDh0C
	S2NXzuw==
X-Google-Smtp-Source: AGHT+IExVeQtcYGpfAepPbJDg3yiYredE0DKYzNxlYui1UocLOJSueSs8b8zmvT5eRKNrveJMBgk42mIYHn3
X-Received: from edyp8.prod.google.com ([2002:a05:6402:748:b0:5cf:bcbb:8179])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3456:b0:5d1:1064:3274
 with SMTP id 4fb4d7f45d1cf-5d11064369fmr408490a12.16.1733222285093; Tue, 03
 Dec 2024 02:38:05 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:30 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-14-qperret@google.com>
Subject: [PATCH v2 13/18] KVM: arm64: Introduce __pkvm_host_wrprotect_guest()
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
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 +++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 5d51933e44fb..4d7d20ea03df 100644
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
index 60dd56bbd743..3feaf2119e51 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -286,6 +286,29 @@ static void handle___pkvm_host_relax_guest_perms(struct kvm_cpu_context *host_ct
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
@@ -498,6 +521,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
+	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d4b28e93e790..89312d7cde2a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1503,3 +1503,22 @@ int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pk
 
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
+	if (!ret)
+		ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, PAGE_SIZE);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.338.g60cca15819-goog


