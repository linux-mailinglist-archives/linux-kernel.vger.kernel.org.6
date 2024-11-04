Return-Path: <linux-kernel+bounces-394939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA96A9BB63F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED471C21EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165422611;
	Mon,  4 Nov 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmYYGmNC"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1F1CAB8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727167; cv=none; b=nSzW2U7odd+7G2qU9juJnpstJRjbEvKI74JQMm5wVUWit4DVn0zgcjxBArvM3k2UEmyjzRrmgrWFBKslq9U2VTu0fvCTOsO8OBKkGcA/FNQk3SGCXk9hJ/46aFmoL8s+PP+BM81KNNfLys4DZdJld38FtfEVZvtwZ/Jw/KblagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727167; c=relaxed/simple;
	bh=YF61Zz8W/fAcQVVljHeekQ+P84vuNKPylXeZYVhXxSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YyvnMkqNsW+UjlwxPasuXXEOR5vhWYrtQHbEQgDNd2qMtRPOmak8H3xpurYZGYcQoHkpmakJ2vI16LeUmCqdoudYLhvehLWiJ38j3gX0tUCCCsh6n9SrsJPP0puxh6l+e9x0+rRCexX3bVOWL4UgBKEIbL8snc7iygeNDFzuBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmYYGmNC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so3386367276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727164; x=1731331964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0O9w3V8+9zARf3Lj4YZXmAy+l2Op+F1G9lpGS1sACo4=;
        b=nmYYGmNCKFSYHPrXuK42RKV65qA5UknogUsgO9w/QHSqG/qmU8xtCGbm8MwoKqH5WP
         nOXz2goIIvqA6yDVZHrVlnLyGFwjdYV42BMNsGuh/LUYSXOEdUt4mV0rmYRXcc8ZiBsS
         P22i4aZhaxwzNX9coYEq1aPXdn7rE+LdJdao8/I9jzAS31TCGNzqmHaASV+KYbMvA4nt
         08bsbtUoBwhf+ZIrShDcr/SW/Ru1xidCSH0e9BMaAhexm79j2zNQqT9Mc0k+Jtwsl0Sm
         b26LR1qYbwNjMzqHAayMMPZRqKk4CZu9AYnE6XB1gmXmDfAjIu6hg3KtgWeaye8+es5D
         XLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727164; x=1731331964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O9w3V8+9zARf3Lj4YZXmAy+l2Op+F1G9lpGS1sACo4=;
        b=D3jPA7n61vV8cHImweklghy17iGGsuDDjCVR0QtzKIKgHa0cZoruMZCPuZg+7Dli2i
         B6NwVpjO61y3f9iw6tjN25GjIMGrWprMPV3iM5zvzHQRqY+FHuAMRjJDwTP9LsAZp8cB
         iIHeVnN4+bwxR6S/6NUZUF7hcZJOwUbdFjVcCAs3Gp/YULoOEWY8pqdNKlO/GJpz6Iif
         B5RedCHeJU/6Uw4E3l9vqsPady7tEyWmPaMTYxAdFSjw2EFV98YyrQpFc1TJvTx7j7Wy
         ejshFYgok5/JXbzULAo1ZmKEPuXSsd0m1NNng81+ml40z/Z2JNxcIpyVw2gDBq0KtIuz
         HM6w==
X-Forwarded-Encrypted: i=1; AJvYcCWSTPvWqxr1INg2SO4SfePoKoQ13YoAmvwfKvzvBbvxSbs87EKf4GjzmzHZOTqG4wZCb6ZJ7o7SoRg2DkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4rCYL8TbTyDn17Owy9qwVDZF5Bew1r9UaEC2m6ebb/A6Q/RD
	RpbTTGI3Ww9hX9OLKvMQX+EG9bPsrl1HH+onogJQFTOYjccbTrhId2tnIOObPXmYVRjCvMU11MU
	0O/BGsg==
X-Google-Smtp-Source: AGHT+IEDxrAcP3xldoLSP2+yxUBuV6Ttuyw9HdeltMFShnVNq/HJr7ENXf3J/L5hnJ5D4xci+Np8Djaz59df
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a5b:24f:0:b0:e0b:f6aa:8088 with SMTP id
 3f1490d57ef6-e30e8d353edmr30619276.1.1730727164243; Mon, 04 Nov 2024 05:32:44
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:32:01 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-16-qperret@google.com>
Subject: [PATCH 15/18] KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
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
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 19 +++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 24 +++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index acb36762e15f..4b93fb3a9a96 100644
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
index 554ce31882e6..6ec64f1fee3e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -44,6 +44,7 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
 int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
+kvm_pte_t __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 21c8a5e74d14..904f6b1edced 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -331,6 +331,24 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
 	cpu_reg(host_ctxt, 1) = ret;
 }
 
+static void handle___pkvm_host_mkyoung_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, gfn, host_ctxt, 1);
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+	kvm_pte_t ret = 0;
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
@@ -552,6 +570,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
 	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
 	HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
+	HANDLE_FUNC(__pkvm_host_mkyoung_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 7c2aca459deb..a6a47383135b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1558,3 +1558,27 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *
 
 	return ret;
 }
+
+kvm_pte_t __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	kvm_pte_t pte = 0;
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
+	pte = kvm_pgtable_stage2_mkyoung(&vm->pgt, ipa, 0);
+unlock:
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return pte;
+
+}
-- 
2.47.0.163.g1226f6d8fa-goog


