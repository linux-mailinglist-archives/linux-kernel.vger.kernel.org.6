Return-Path: <linux-kernel+bounces-429256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3969E1986
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C497282098
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC631E47B2;
	Tue,  3 Dec 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ru6oStcX"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E11E3DFD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222286; cv=none; b=RcoN/iDe2O/0CzhqmQSFuizKMezpvRg9O5oghHW2VDosDpu2nKHLFoP0Xy8+VsIt+1km9OzBp+PsgVb5Kv3WNgPrH0nxfIeJL8CAHpLs2pqk5Z8Tr3XDI86f/5MGbHZkVu9U/qujoRSpZgGQS+67aoB3yeJwPdfK9QXjxOghzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222286; c=relaxed/simple;
	bh=EqJLY+xY9R6IH3FW+VrFa/RkKZhBKvD7VF85QtvFOHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S4cn+PIAJDoOKqCh/MJYXKCzmUPrCqKd7bsNgkemfm5xgq3BNTM/lBFIE+Ai2kpGV9yWrqHRQ9eNCbMONNNhheyK6HoRPIWebcBtdGL7C0dyHG3VrUE2f3taGj3x3XR9yNVBMoUH08sy3oVX1TWA7/5Rf+R/eHQU8WFNKBeY3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ru6oStcX; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-53de479ec3cso3469277e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222283; x=1733827083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s38xN9T/XvfaM/79S4sHcPd1Nmgpw0fQ7Wk8TWQP3tM=;
        b=Ru6oStcX8QBWs0Fr7de9n4WglJXkAGEHPgd4X+h+WqTsNEUeLblvyHiZwnSs0uK555
         xrWTG1SZZF4NvRWOWhZMp0rlCxOx5T+LPGbxWxijwSrKbKa2Em3uGHh3pCz1TZwF6d65
         vVIYU/3L9SHIHCV7RTN31TyQYZwAmGuq3xAk+njzVlANKQ/F7kLAYjZBubSwCd81ORSP
         6ioP5bqdXm3UjhsRtRgbhpdvhzEOLXbajWc1DY3o7/vFMPXGDEwfYxEdYvY+u1u5MvXd
         aEGlM87EDRrCfvr1NdjW8RmB6xQqELBBstN295ruvFoPEe5NE135wykZJDaXu+V6K7+B
         QC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222283; x=1733827083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s38xN9T/XvfaM/79S4sHcPd1Nmgpw0fQ7Wk8TWQP3tM=;
        b=GtL71aMlyUAuhPQAFvkqcW5mQsnVt78pcMDtFh5UJRXHiCfLGDUQ+mlmfJddEG5jwz
         fiXq+1oSFilw1hrI/pyfa3V2UBMGn0GbK0PdMldg1wXEsSt/gZE7YzcUqlCdDtx35yDm
         eNmJqsl63p01Y/LS0oXGvG0jTXJsGSrzpY61lFcKAqyZsv5+u16pleWq5FA6WMsjocZZ
         nfW4kpxKAGoJgM4hsDECoG2ZcsPySu4YIwQfzVSG/v3Inh8Qd/Sqv1p5bFm0inuGNHfh
         vfjs/MHero5fQEmTUu3DTUSzk1VT+XNXJkUDGsr260LEwXGc0UUWnHinxWAgKbt7661r
         KBZw==
X-Forwarded-Encrypted: i=1; AJvYcCUn/ebqIeRLiQ5kGWsui78B0niHnM1xbfJ6gHeanBw8pJwml4aStmaeEAmowM0JEOsnxiJlFMvu71jDHik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYqSpDZlfWf2/ZMjdLF6LFiU52Ge8U81FpfIDSK/op6/8/J5s
	jvkcjdaVzvF6fLyz0AoIiPL7beEL9pNpvE5VbU8F7IomfWNd6lNcqGtFCLpEZQk6VFUzWNZ0b6i
	QYD5Buw==
X-Google-Smtp-Source: AGHT+IFntBO/LOmyiPo2CB6E6Ns8WVjgPpUfexcNVdqJeQs2dulJCxuyV2C/KpfJwaEPASs3j3n/XtaL2mEj
X-Received: from edbin8.prod.google.com ([2002:a05:6402:2088:b0:5d0:83a0:b479])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:3181:b0:53d:ab12:fbbd
 with SMTP id 2adb3069b0e04-53e12a2e966mr1206040e87.51.1733222282794; Tue, 03
 Dec 2024 02:38:02 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:29 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-13-qperret@google.com>
Subject: [PATCH v2 12/18] KVM: arm64: Introduce __pkvm_host_relax_guest_perms()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a new hypercall allowing the host to relax the stage-2
permissions of mappings in a non-protected guest page-table. It will be
used later once we start allowing RO memslots and dirty logging.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 20 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 23 +++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 0b6c4d325134..5d51933e44fb 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -67,6 +67,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index e528a42ed60e..db0dd83c2457 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -41,6 +41,7 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
+int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 04a9053ae1d5..60dd56bbd743 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -267,6 +267,25 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) =  ret;
 }
 
+static void handle___pkvm_host_relax_guest_perms(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, gfn, host_ctxt, 1);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 2);
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
+	ret = __pkvm_host_relax_guest_perms(gfn, prot, hyp_vcpu);
+out:
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -478,6 +497,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
+	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index aa27a3e42e5e..d4b28e93e790 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1480,3 +1480,26 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
 
 	return ret;
 }
+
+int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 phys;
+	int ret;
+
+	if ((prot & KVM_PGTABLE_PROT_RWX) != prot)
+		return -EPERM;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __check_host_unshare_guest(vm, &phys, ipa);
+	if (!ret)
+		ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.338.g60cca15819-goog


