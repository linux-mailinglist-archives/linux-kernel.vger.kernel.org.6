Return-Path: <linux-kernel+bounces-429258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C69E1988
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5495162FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED851E47DD;
	Tue,  3 Dec 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2BUCCNp"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EF1E47C9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222290; cv=none; b=CTJNKKUv7aiTw23Qip7VVj0zLWuSUTcqfp32/liUMk8Q9Ia1Vky8IlO2phSP4hvLMjEEBGkal3IJWwaGxywkhy86Ch2G/vD4ltOevLFFy6+q3Rv4kkL55znJxOFoOUwFgVvzGi56ZOpfjXlss+PcXQywbSVZiRzXXTUCmtdIYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222290; c=relaxed/simple;
	bh=v51mhVbTFIEkY4CoyYzRXFRDHL8biEV8+73kWC1df90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pK+0Xjo5Uu1G8vqvQC1T/8flyeRDFME3Bpc67JjKsGbpL8SrueCD66F47sSnxAEz9IQ/W/JCkokLQrb/6CpX4znNSJpeTcEPB8tvoB5LwxGSTxrLNl/S7yz+5RkIiAP48YjezleP/bKMofWV4RDvzpHxU0l3gqsX/DJEv5NSOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2BUCCNp; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0c9bbc6ceso3127606a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222287; x=1733827087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9JsvIEZXCS7Jr+kmsJzau1fLfSngv5TQOi1bKyxyJ0=;
        b=a2BUCCNpe7knVh5kRpFCaPx/SyZ0xX+yUX382o/rpyWvW9Shv1Ncown0aYmoFPG1/B
         f2Zn+cMLE1WMvyeyF7RgRkBK1SirA97SiQemIVniaZQwVrOuHDHnnKmzRJszGdLibrSS
         7Wf8U5DnePaKtCWSElplhDpEU9xBiuRse1gijhguqzj9+7INqEXuZ+wKRvbsoiUQ6iNN
         WI3CyzWFkXhf4ubdckckGXo2tcqvq8R7wkLe48K57hZQ5tVtssGQK3/dU0Ci/UIWtvRc
         7f+k0Fc3H86a4U+UJR2asdKcWaM3WAad7bIjznEMciIeM6y2mz8wj6YktsFwBelN6v7J
         u7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222287; x=1733827087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9JsvIEZXCS7Jr+kmsJzau1fLfSngv5TQOi1bKyxyJ0=;
        b=Ak/bzsyxARqZnBlEHl+J9PQ3zGdBiTZKeNlvPr149zP/cfZ4VkZqVMwQbCKRFhZOTl
         RTu0ecrHEUw0xlb7JHoICDU7gN3btcY3LOaFK/6q5kDsDxbAjJwSbn1BH9lOAnsORnfk
         LmgnhJMHH0BdyLDoOZLR9itziWZgmkNDx0Z79ZOGNyzAmDoFP38jekf8mkuJw2aTEOFV
         DzGihUJs0RGY2kqD9KfKY3BlwkXmtJwGF2cSxep3KsMDziR9lTV5M1h9JoOSKKL1YUU1
         NuV2y8C2MhIjK3QJ5f4joPUFg+zHO/o1pwYQ7fBsyrUa4rorfXdIUmLFb724fuiZ13D3
         SiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu8zqg8eLuOLnMZ9Jwn/H8vBglEQw95KEgLpzH2wchCmTrCWYLPQRSn487i22uNK3CS6yzLRsDfM3Inw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZ5ZTa13UMCyDoi59KnRlq8JhCdvUZWUiw3Jabkz0ZbldY8/Q
	z23PH2CKHnG8w0xfVi/H5W6VtIPnuCa9ygNb3m728c5cARRHjUG02/wPCETHnbD4FFm1i2ERy5O
	jEDyzGA==
X-Google-Smtp-Source: AGHT+IFdWegGcOuq4VNlCrIIkQlpyo4Z++Lp+kcClHAhjJ/QKpJll2AcCbmRcGxxqa+FPKwZaF2FsSqM5zPQ
X-Received: from edsw18.prod.google.com ([2002:aa7:da52:0:b0:5d0:6d5c:d4e4])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1ecf:b0:5d0:b4ea:9743
 with SMTP id 4fb4d7f45d1cf-5d10cb57048mr1964875a12.8.1733222287044; Tue, 03
 Dec 2024 02:38:07 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:31 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-15-qperret@google.com>
Subject: [PATCH v2 14/18] KVM: arm64: Introduce __pkvm_host_test_clear_young_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Plumb the kvm_stage2_test_clear_young() callback into pKVM for
non-protected guest. It will be later be called from MMU notifiers.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 25 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 ++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 4d7d20ea03df..cb676017d591 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -69,6 +69,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 8658b5932473..554ce31882e6 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -43,6 +43,7 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum k
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
 int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
+int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3feaf2119e51..67cb6e284180 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -309,6 +309,30 @@ static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt
 	cpu_reg(host_ctxt, 1) = ret;
 }
 
+static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
+	DECLARE_REG(u64, gfn, host_ctxt, 2);
+	DECLARE_REG(bool, mkold, host_ctxt, 3);
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
+	ret = __pkvm_host_test_clear_young_guest(gfn, mkold, hyp_vm);
+put_hyp_vm:
+	put_pkvm_hyp_vm(hyp_vm);
+out:
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -522,6 +546,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
 	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
+	HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 89312d7cde2a..0e064a7ed7c4 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1522,3 +1522,22 @@ int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
 
 	return ret;
 }
+
+int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm)
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
+		ret = kvm_pgtable_stage2_test_clear_young(&vm->pgt, ipa, PAGE_SIZE, mkold);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.338.g60cca15819-goog


