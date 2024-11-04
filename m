Return-Path: <linux-kernel+bounces-394932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC6C9BB636
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4148D1C21EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B21B5823;
	Mon,  4 Nov 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Lm1klL0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95D1B21A1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727151; cv=none; b=PCqCViJaaANpOmHMFzvygUR8WThlUv55K7l6zW9Cbuj16lZK9bzrH4Vev8yw40thqWS6o1xCPl9IagFQxpoMZSRnnuGoAXpAaaK9lxcHFmoixp7yD/82B2QtJDO3G8v1Qmpln7XHqEYSjMl2cB/l9jsyb1WQhhCmDiBvGo4Nnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727151; c=relaxed/simple;
	bh=ffOLwbKQb8kwQMl491ZENBc/qOOoZ9iUG3V85WaSIts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLm+Msxk/1GNGkBWyb8Oboo35duyifYmTAWymokpb9IJw2qGnxJ4PUOYjser/EeEiBlyLA1vZpFNjcASOzpqETl2XaQU6J4ULWEaW7OqkzjzWwt+wUtice1MINoJD2DT/De3XQY/K+nPGkBOZ4uJjomr8kKW5+b48bR2n8tdoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Lm1klL0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea86f1df79so29579007b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727147; x=1731331947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWbtmcYWRp1R8Byo4NXAA6u9713XSDAlNYmvHQ2XPgU=;
        b=0Lm1klL0LepgH3JWy+h4g4volpUguvubqih7ePEfBh+PH2rUiM4Q3dvvT7HDWoFHxo
         UNVJDX2BnRZzP4Or4l1G1MP4MHAeLDIHigim8zbF88zFrYqc49QhsjNcVD+cwkU28wA2
         +We5qKeTpG8vI/o9bCCrh0YpYP9mRP7/PwIXaE6lMVaeCO/k6q9yFakhmnS1ozQhu1ts
         BD8DGmUUhoXVaeMHr+b2562HS4f2rzslzkTsT+biuwbkjIJjdXUIDISTFUxHbdxx6N7T
         T1d38v/fahMqL3hIiLHbkff4r2TEHg/nUnpI9DScbDIhkatLZZSetHUmbpcxi74ecZAf
         4KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727147; x=1731331947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWbtmcYWRp1R8Byo4NXAA6u9713XSDAlNYmvHQ2XPgU=;
        b=uG0yXQJfjZlOKxN7zqCd88qwBB175fgz06Gdo8/s5D2LWmAltA1K5WGPLrsT+r5Qet
         FTCivU9BIBAK5CB0axyvTN5ghld+PMy54Xf9lDE4Vj+NJZwG4wL34CWeEICEdLZt3CbL
         0+2em5ENkZ1a7LGZhunk9CzhO0FxbceR9BpEoxK5UFgQms/YJ0Ntt0KSDK4jTmCPtGjW
         VvNic09f4p8TZBW6v2xbRTA2Gwmk0Sj/LTRz+87iJtTjcgg/HkvpYgtwM2nzQ7zWcV6G
         lbsIsYnqYq9/FtgyBZu5X2IqHSj0TkrcDBlxs2KJsWW0f1ZdnhdH6lyzm+irqmI0vm98
         8c2A==
X-Forwarded-Encrypted: i=1; AJvYcCUb5Dk8KQ6xTf3WaePV0IRGBfKZXqwvnJce4aIz9NNQstXxUs64WDrvjfSds/cn3xzfDfKff14nOTdeJzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ULBMZPF3D3cp0AxJ7csz7p0ScAX6sMzvPSUO30ocdRMv3m8D
	plZ3DMhLzPcVX1usH422EThB8Fib6l2hW8ZBnUB1ejCRRhvuzrxwoSRZr91ISHec3HnHhfX9vyZ
	LWTC7SA==
X-Google-Smtp-Source: AGHT+IERD2fe/MuO+b+uqGh1AqVUFKurSVSZTroF+QuBipkZRMH9HgRguuT3lLzoarC3p1VSq8xD3yXmKNOM
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a81:a8c3:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6e9d8aada53mr4236897b3.3.1730727147304; Mon, 04 Nov 2024
 05:32:27 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:54 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-9-qperret@google.com>
Subject: [PATCH 08/18] KVM: arm64: Introduce pkvm_vcpu_{load,put}()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

Rather than look-up the hyp vCPU on every run hypercall at EL2,
introduce a per-CPU 'loaded_hyp_vcpu' tracking variable which is updated
by a pair of load/put hypercalls called directly from
kvm_arch_vcpu_{load,put}() when pKVM is enabled.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_asm.h       |  2 ++
 arch/arm64/kvm/arm.c                   | 14 ++++++++
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  7 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c     | 47 ++++++++++++++++++++------
 arch/arm64/kvm/hyp/nvhe/pkvm.c         | 28 +++++++++++++++
 arch/arm64/kvm/vgic/vgic-v3.c          |  6 ++--
 6 files changed, 92 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 67afac659231..a1c6dbec1871 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -80,6 +80,8 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_init_vm,
 	__KVM_HOST_SMCCC_FUNC___pkvm_init_vcpu,
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
+	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
+	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 48cafb65d6ac..2bf168b17a77 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -623,12 +623,26 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	kvm_arch_vcpu_load_debug_state_flags(vcpu);
 
+	if (is_protected_kvm_enabled()) {
+		kvm_call_hyp_nvhe(__pkvm_vcpu_load,
+				  vcpu->kvm->arch.pkvm.handle,
+				  vcpu->vcpu_idx, vcpu->arch.hcr_el2);
+		kvm_call_hyp(__vgic_v3_restore_vmcr_aprs,
+			     &vcpu->arch.vgic_cpu.vgic_v3);
+	}
+
 	if (!cpumask_test_cpu(cpu, vcpu->kvm->arch.supported_cpus))
 		vcpu_set_on_unsupported_cpu(vcpu);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	if (is_protected_kvm_enabled()) {
+		kvm_call_hyp(__vgic_v3_save_vmcr_aprs,
+			     &vcpu->arch.vgic_cpu.vgic_v3);
+		kvm_call_hyp_nvhe(__pkvm_vcpu_put);
+	}
+
 	kvm_arch_vcpu_put_debug_state_flags(vcpu);
 	kvm_arch_vcpu_put_fp(vcpu);
 	if (has_vhe())
diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index 24a9a8330d19..6940eb171a52 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -20,6 +20,12 @@ struct pkvm_hyp_vcpu {
 
 	/* Backpointer to the host's (untrusted) vCPU instance. */
 	struct kvm_vcpu *host_vcpu;
+
+	/*
+	 * If this hyp vCPU is loaded, then this is a backpointer to the
+	 * per-cpu pointer tracking us. Otherwise, NULL if not loaded.
+	 */
+	struct pkvm_hyp_vcpu **loaded_hyp_vcpu;
 };
 
 /*
@@ -69,5 +75,6 @@ int __pkvm_teardown_vm(pkvm_handle_t handle);
 struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 					 unsigned int vcpu_idx);
 void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
+struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void);
 
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index fefc89209f9e..6bcdba4fdc76 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -139,16 +139,46 @@ static void sync_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 		host_cpu_if->vgic_lr[i] = hyp_cpu_if->vgic_lr[i];
 }
 
+static void handle___pkvm_vcpu_load(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
+	DECLARE_REG(unsigned int, vcpu_idx, host_ctxt, 2);
+	DECLARE_REG(u64, hcr_el2, host_ctxt, 3);
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+
+	if (!is_protected_kvm_enabled())
+		return;
+
+	hyp_vcpu = pkvm_load_hyp_vcpu(handle, vcpu_idx);
+	if (!hyp_vcpu)
+		return;
+
+	if (pkvm_hyp_vcpu_is_protected(hyp_vcpu)) {
+		/* Propagate WFx trapping flags */
+		hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWE | HCR_TWI);
+		hyp_vcpu->vcpu.arch.hcr_el2 |= hcr_el2 & (HCR_TWE | HCR_TWI);
+	}
+}
+
+static void handle___pkvm_vcpu_put(struct kvm_cpu_context *host_ctxt)
+{
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+
+	if (!is_protected_kvm_enabled())
+		return;
+
+	hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
+	if (hyp_vcpu)
+		pkvm_put_hyp_vcpu(hyp_vcpu);
+}
+
 static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, host_vcpu, host_ctxt, 1);
 	int ret;
 
-	host_vcpu = kern_hyp_va(host_vcpu);
-
 	if (unlikely(is_protected_kvm_enabled())) {
-		struct pkvm_hyp_vcpu *hyp_vcpu;
-		struct kvm *host_kvm;
+		struct pkvm_hyp_vcpu *hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
 
 		/*
 		 * KVM (and pKVM) doesn't support SME guests for now, and
@@ -161,9 +191,6 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 			goto out;
 		}
 
-		host_kvm = kern_hyp_va(host_vcpu->kvm);
-		hyp_vcpu = pkvm_load_hyp_vcpu(host_kvm->arch.pkvm.handle,
-					      host_vcpu->vcpu_idx);
 		if (!hyp_vcpu) {
 			ret = -EINVAL;
 			goto out;
@@ -174,12 +201,10 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 		ret = __kvm_vcpu_run(&hyp_vcpu->vcpu);
 
 		sync_hyp_vcpu(hyp_vcpu);
-		pkvm_put_hyp_vcpu(hyp_vcpu);
 	} else {
 		/* The host is fully trusted, run its vCPU directly. */
-		ret = __kvm_vcpu_run(host_vcpu);
+		ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));
 	}
-
 out:
 	cpu_reg(host_ctxt, 1) =  ret;
 }
@@ -415,6 +440,8 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_init_vm),
 	HANDLE_FUNC(__pkvm_init_vcpu),
 	HANDLE_FUNC(__pkvm_teardown_vm),
+	HANDLE_FUNC(__pkvm_vcpu_load),
+	HANDLE_FUNC(__pkvm_vcpu_put),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 077d4098548d..9ed2b8a63371 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -20,6 +20,12 @@ unsigned int kvm_arm_vmid_bits;
 
 unsigned int kvm_host_sve_max_vl;
 
+/*
+ * The currently loaded hyp vCPU for each physical CPU. Used only when
+ * protected KVM is enabled, but for both protected and non-protected VMs.
+ */
+static DEFINE_PER_CPU(struct pkvm_hyp_vcpu *, loaded_hyp_vcpu);
+
 /*
  * Set trap register values based on features in ID_AA64PFR0.
  */
@@ -268,15 +274,30 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
 	struct pkvm_hyp_vcpu *hyp_vcpu = NULL;
 	struct pkvm_hyp_vm *hyp_vm;
 
+	/* Cannot load a new vcpu without putting the old one first. */
+	if (__this_cpu_read(loaded_hyp_vcpu))
+		return NULL;
+
 	hyp_spin_lock(&vm_table_lock);
 	hyp_vm = get_vm_by_handle(handle);
 	if (!hyp_vm || hyp_vm->nr_vcpus <= vcpu_idx)
 		goto unlock;
 
 	hyp_vcpu = hyp_vm->vcpus[vcpu_idx];
+
+	/* Ensure vcpu isn't loaded on more than one cpu simultaneously. */
+	if (unlikely(hyp_vcpu->loaded_hyp_vcpu)) {
+		hyp_vcpu = NULL;
+		goto unlock;
+	}
+
+	hyp_vcpu->loaded_hyp_vcpu = this_cpu_ptr(&loaded_hyp_vcpu);
 	hyp_page_ref_inc(hyp_virt_to_page(hyp_vm));
 unlock:
 	hyp_spin_unlock(&vm_table_lock);
+
+	if (hyp_vcpu)
+		__this_cpu_write(loaded_hyp_vcpu, hyp_vcpu);
 	return hyp_vcpu;
 }
 
@@ -285,10 +306,17 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	struct pkvm_hyp_vm *hyp_vm = pkvm_hyp_vcpu_to_hyp_vm(hyp_vcpu);
 
 	hyp_spin_lock(&vm_table_lock);
+	hyp_vcpu->loaded_hyp_vcpu = NULL;
+	__this_cpu_write(loaded_hyp_vcpu, NULL);
 	hyp_page_ref_dec(hyp_virt_to_page(hyp_vm));
 	hyp_spin_unlock(&vm_table_lock);
 }
 
+struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void)
+{
+	return __this_cpu_read(loaded_hyp_vcpu);
+}
+
 static void unpin_host_vcpu(struct kvm_vcpu *host_vcpu)
 {
 	if (host_vcpu)
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index b217b256853c..e43a8bb3e6b0 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -734,7 +734,8 @@ void vgic_v3_load(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	kvm_call_hyp(__vgic_v3_restore_vmcr_aprs, cpu_if);
+	if (likely(!is_protected_kvm_enabled()))
+		kvm_call_hyp(__vgic_v3_restore_vmcr_aprs, cpu_if);
 
 	if (has_vhe())
 		__vgic_v3_activate_traps(cpu_if);
@@ -746,7 +747,8 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	kvm_call_hyp(__vgic_v3_save_vmcr_aprs, cpu_if);
+	if (likely(!is_protected_kvm_enabled()))
+		kvm_call_hyp(__vgic_v3_save_vmcr_aprs, cpu_if);
 	WARN_ON(vgic_v4_put(vcpu));
 
 	if (has_vhe())
-- 
2.47.0.163.g1226f6d8fa-goog


