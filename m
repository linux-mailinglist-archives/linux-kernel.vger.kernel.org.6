Return-Path: <linux-kernel+bounces-429259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC29E1989
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487B72822B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE091E501C;
	Tue,  3 Dec 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ellP6YHE"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7901E47D7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222292; cv=none; b=RndQavDsJrp/Tie+ulhqDOQ/KjfWV8GA/CSC20D5U9MXBQ+rMVbZnE07EU/AIva77xvSZfHno59KU4YcU5dCTRQaQvyG5MuLk7ab7MIm+mNV6njsEhAGTSNI96Ycgs+8BWmkbfeC2cym3LNKHY0L+AO/+9jRUVEw9BM1YFXq1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222292; c=relaxed/simple;
	bh=6OXhtXz+jkyWJorAsOieiOmrQijISKvstuW/2+G4Ad4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8PBbXOp3wFygAfWRIJeenX2bZxNLg9XI2ocsjtv7AWDhmG8jCHbrtG7BVMilqK09QKtldgQUwalbOVj64t2etg9yX+UmBar6tnJgjBPqzZqdaAukxrxOS0brCyvP1EVFgkvtm3QeJJRG/W6XmfAKTyHZeiljBXJsNXwqZIKMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ellP6YHE; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0d7b5c86cso716132a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222289; x=1733827089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgRs0HkjSCh59IZhf7+TrvM3b16VAv7mDc29HHStdgo=;
        b=ellP6YHENixhxT6cYzpAnE7Qsmc77ELZl4WDD061ZI3VglIU1mHR8QLwf6PG8yh79b
         2T6Cz9tTHgZge1vuigEbQW3lqNk6LewzEti7pL0nM+8J0IPyRzJovMzWyDXoj9E3Ysu+
         i+AGLo3XbYv1glA0YB/5MHyDMrm1tPVM7v/3yiXmgXMjAINnHPVmDSaRYKhBNJkTmyw4
         s3ubqRv5zEaxQtaDlVI5upIqiqUXstkBQYlwMFPChGtuWLAT3uUS2Qp5otosQFtKg0ZU
         gNS9AkRGiqpWeNRgnTlXgqjOCvMXDDd5JegDhUrLZ3EZs+9Noi9cb5Qo5D0vbmWqqdAT
         ZVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222289; x=1733827089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgRs0HkjSCh59IZhf7+TrvM3b16VAv7mDc29HHStdgo=;
        b=SZhq2maY8hyNwy8xAe3BmcEtD5qQOe0tj0n0i+rZxToX6xk0HMgC8ylZNmowEjLX6i
         6O3d1FkL1vwhBZPXmN+d1U/d3khRyvV9++tyspXZey9v3MQemyeP6uEoepdpqTSxEjro
         JNkefPblDam1PYdQGr2CHoIwQ05dVUZjw4WrUcKyt3Po8CxEmmUbeqaSJNd+N77eWQyI
         1vlIgwBMVrgb0lAPw7dnKjMen7jkZDpkkK6j4LR5nb0kr/FVuYFiO7EF0QKwxSZJ+tC5
         v955qYt0uH0byMZ7WYBhniKUEL5VNJgzqqQD2sKQEqphrKoC0/9deHgqGIZZIjMrLOPG
         PZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXQUbrqnHuGP+BJIZ+/5EJ3QWwhzvY0VSqk9Do9raX9MFT+j4kPS7zTL74qOzHVnygR3hkj2U7SI2WjOBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeljwa36QFfh5+VkNgkNgngyDRyW9JJZgQeFMlVXB1B+HjwA1h
	8BvLsMI/ItT9CqwcspZT/aDMPtERCBQIbz9Pq1Chci+Tr44HQxfuYpzBSJyCtjEeHTwBlRrMhI2
	b+YT9Hw==
X-Google-Smtp-Source: AGHT+IGowzrGpSC0FLSlw3WKUPPBp1evDjYqr9UC0mO5wZAxbWJofoXIaJzqMrV6fp0J8VpSR7nkc7pw29FT
X-Received: from edql9.prod.google.com ([2002:aa7:c309:0:b0:5cf:ad96:abb])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5243:b0:5d0:bf5e:eb8
 with SMTP id 4fb4d7f45d1cf-5d10cb800fcmr1839841a12.23.1733222289249; Tue, 03
 Dec 2024 02:38:09 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:32 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-16-qperret@google.com>
Subject: [PATCH v2 15/18] KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
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
index cb676017d591..6178e12a0dbc 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -70,6 +70,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_mkyoung_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 554ce31882e6..3ae0c3ecff48 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -44,6 +44,7 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
 int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
+int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 67cb6e284180..de0012a75827 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -333,6 +333,24 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
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
@@ -547,6 +565,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
 	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
 	HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
+	HANDLE_FUNC(__pkvm_host_mkyoung_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 0e064a7ed7c4..7605bd7f80b5 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1541,3 +1541,23 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *
 
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
+	ret = __check_host_unshare_guest(vm, &phys, ipa);
+	if (!ret)
+		kvm_pgtable_stage2_mkyoung(&vm->pgt, ipa, 0);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.338.g60cca15819-goog


