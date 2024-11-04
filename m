Return-Path: <linux-kernel+bounces-394936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F49BB63B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66CF1F22566
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8101C07C3;
	Mon,  4 Nov 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opxGn0/4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D5770ED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727160; cv=none; b=hytt5F/7+CBYI9yDdmI94hxyLBU4DWkjyd+5zF1p6wL97q/pIdn+kqYl0pk4cYpHTp+8zqMxULyXZQO3PW0n0qmAR0ITXiWifoUB7teFtTUA03A4M+j2veMALJ67Qpv7NG0OtJbCNTD4p2tg/ZufWVlCQBu7Jf4+g5GqB7mNYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727160; c=relaxed/simple;
	bh=a+wZqkAlnXsib+Y/xL1c1/aKhBYEAk7cOc2pYkFKbPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=auD9no8u16eSBDPRss3AdKyb3eP1Vxee/zE1i0iFUbW8g/2LOs+3KGxSfNPrEnMWNVMIIQkdR2346xKKAU43GS+M2I+d24B00cR9PJim+LYJmqkAHnGSWhILyXzIXSC9DQLEu7qbRLNvwCBudMMqNKSZGhIwcvrQ534Ovf7GK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opxGn0/4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e32ff6f578eso4836111276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727157; x=1731331957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZKgkOXED2gTnPKJGzc+iVeFIN1NowIl4QRyN7m6aZA=;
        b=opxGn0/48pct8Toiuxui2bpq/hWtEz23ttQYJ9C3C/iiv9z/fjLHJZ7BOY246LnhlP
         m4VYmrWu3EDpVkvYLtl1/v9CUGLSK/mrBS8fI3moIY4X9Y7XmG3AbQ44ZfGjqOpEWUwa
         63wK2YxKDbM5l/lQ+VZpEPtXpObEsH/DAik6ngNmZWi7zeiZIsfWkYa73uoPf04BUsAo
         9DeKWi8EszKufdGASr/7P5Pqg9POohCR9lGD5dbNMRkEaJQDryB+F9Yq15cabG0T4uOz
         1IXv5ZdTpUO7vj4Hmh4tAHmrzfHFlIu7iDrDhUqOcXn2y0WuX7nhJz9syU83hOGjD+CP
         8uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727157; x=1731331957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZKgkOXED2gTnPKJGzc+iVeFIN1NowIl4QRyN7m6aZA=;
        b=sZxYzYchVsKNB7feKCKT/sfLHMEMZx5jUoj/rnLJQMQUsk+kqqt1lIZOrtqHdBV9Pz
         HGgm9ZksI6tjguHKUt8VfUcLFWnQu/KuoPNpmkB2CHAIHkBEuJLYe0WRfBK0MSnbyIkF
         onMH4L3AHwWx0vN5lKSIsNqllv0jptAdzgZn+iAz4ly0wFVIJxsInb0IOMTls7O2VEIg
         ndUr38LRo92QatfQaVrZJ8PqNv7/cFT+3YAuIY+S0D/3w9sEsQgD2PpOyPXoJOL4qDvu
         MIgtK+Vk5BMHaI6mxDwK80dcjGguwEo1KlNRz0Y46qBn84A6cmZmXHkoN93XXHS4vbnF
         sYVw==
X-Forwarded-Encrypted: i=1; AJvYcCX6jgmZJOCEPyTjnmuBpc+axoedz9yuhucIj7FzIJnW4+qt+dE9uh6hCtocE2zFxkcdn+QY+O+wR790FpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNu5n86ofdDeD3Cp3D+16GJtWFSXSBu8/YJSzt809bJTW0h/E
	c1smezt5j4134XGlShwSCB1cj4aQ2vyz/QiK084OUYRGw1dJwj4Fwt9pABe0crbk3A6DmIQ65Mb
	ZOWL1aQ==
X-Google-Smtp-Source: AGHT+IEdndu9c8L5M9LMgNH5yUWxnOXjnairdpcGEJ+HkfnHM8iJ67/17rm/DHBApYmZlQ7LHV+rdMkopkCC
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:6902:1801:b0:e30:b89f:e3d with SMTP id
 3f1490d57ef6-e3328a15f4emr19583276.1.1730727157377; Mon, 04 Nov 2024 05:32:37
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:58 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-13-qperret@google.com>
Subject: [PATCH 12/18] KVM: arm64: Introduce __pkvm_host_relax_guest_perms()
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
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 20 +++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 25 +++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index e67efee936b6..f528656e8359 100644
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
index 68bbef69d99a..d3210719e247 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -265,6 +265,25 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
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
@@ -483,6 +502,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
+	HANDLE_FUNC(__pkvm_host_relax_guest_perms),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index f7476a29e1a9..fc6050dcf904 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1491,3 +1491,28 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
 
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
+	if (ret)
+		goto unlock;
+
+	ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
+unlock:
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.0.163.g1226f6d8fa-goog


