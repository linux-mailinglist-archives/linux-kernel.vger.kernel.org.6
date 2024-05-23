Return-Path: <linux-kernel+bounces-187840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B38CD93C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C6EB2147A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C607D417;
	Thu, 23 May 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjR0JJum"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703112746F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486083; cv=none; b=qFIPz84OAFURVDji+0cnqdpb67pyc07LmGW6aKX9YPAfPj5OxUQsemC91UdKdgkffwac+Ft1jjuIvCCX3pfQp3uF4RhX4802wqlts/StIP8kiobMEWD88vbdjtLPhDOB7nCGANv7QyyIAxJQo93Wt6Ak7sSzQaW7MN4sfwbwvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486083; c=relaxed/simple;
	bh=mgcCj63r/rqJ9WAumHxvSQWYHZYpsmagWDbi6uVpq30=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dz8hKQe4F5mBTmureBi/a43C2+6dD4avc4W/3g3f07PE5acQvr5MNB95zFtNf1b8Lgy70J3H7WfeaDhm1sX5eDL0ZewMdAt1Wc+7WbWm7njWiVpLM6JG9RTQQtBllfS7aAUj6rgZCLEG1iCpuXsLf9geLAzod7u3Q8KFn0yk9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjR0JJum; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7713034bfso57073276.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716486080; x=1717090880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Uryc1Ca/yfNSkrAtNfcb1TkId2P2HjsoQz4zGkthUc=;
        b=qjR0JJumKNrZ7UwcPP3s3GetHd8W89GLTthgINDn8zXK2tp9xfYk8qBTbgZRmXoCFA
         HLWfW0D2IZLwnnxs/HNLrQtkKFPdtoBv403UP4UnO1x0PCYvZEqokaSbQHvWzK7dxdjh
         VJWXHVWdel+9kBDAo3bZyrjsyCZcwZORpeNixhRcrpf9aYANwwBUsj04IU5+pbmo3d5/
         3EjHCeejdhp6Vy299A2P9ykhic6fVG5SGahZo3Vsa/zu8HrZiE1caS7chZYloNqedDIW
         NL7m7UM5ROyaRVefbX/e+lPwVaB+AdPC/JsPu06JWh67JbJ+XyCsHjwfdvbMGwEO/9og
         buOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486080; x=1717090880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Uryc1Ca/yfNSkrAtNfcb1TkId2P2HjsoQz4zGkthUc=;
        b=kKSYV8SVYySP/uXae6+2jr7X6YmjK+BTr6fT46d86Nh3sPd4ONaYFzzx8+U0PaRqSP
         Wd168VoavNb7mR0T1E623/S4dJViIo7WIUBupOgQYS31npK3oCtHopmVYhyobslb8llx
         hCuzDoHIud59Tomn1OqpM+wjn1pMclJSsJjpIWkYyiG8MgIn8oCq/uI29t+k7HE/XPgc
         8nhUMEnRE2GmmXtxW+R3nPylw68TVhycS07qaCofegajG5VQkcc9/Dp0Uu/5Tgu5dzSy
         iPRIhp+nK6g8Qpo75u+bCwlsTSpJ3NhVg0mXUbC9tl9tGgQxAxNdEGubPbdkrbGm3EK5
         zXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXAeQKS7OkQ70keEAMW3XIp3j2TM4kDnrJYk78B/rz97iK1nHsgOr8o/04dZWd/DTgrzMxMK/K70VcfF6y3tAyjbQR4iKlXI08FWxP0
X-Gm-Message-State: AOJu0Yy58BE0FHWtnjzO/vzwlYpTYmJs+nILhxJEEKmk+Pwuj6i043gJ
	3OOO3tjDI84ivQP8v3vT43YxufnBY0gmDTPGhLPp2BH4+d78XXAfLqrQufe6LwI9GT3p+olbTcH
	9t7n54rdRmxa7ZTw8RpqMmA==
X-Google-Smtp-Source: AGHT+IFlRiZywpr57pi877qryPKiafj4uJohWbfZpe5cezs8n2FI0sD1i4QJM+bXmI8glD4J/d2mQ77lr+EZuSzvnQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:100a:b0:df7:66dd:5fbd with
 SMTP id 3f1490d57ef6-df766dd6536mr116228276.3.1716486080473; Thu, 23 May 2024
 10:41:20 -0700 (PDT)
Date: Thu, 23 May 2024 17:40:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523174056.1565133-1-coltonlewis@google.com>
Subject: [PATCH v6] KVM: arm64: Add early_param to control WFx trapping
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an early_params to control WFI and WFE trapping. This is to
control the degree guests can wait for interrupts on their own without
being trapped by KVM. Options for each param are trap and notrap. trap
enables the trap. notrap disables the trap. Note that when enabled,
traps are allowed but not guaranteed by the CPU architecture. Absent
an explicitly set policy, default to current behavior: disabling the
trap if only a single task is running and enabling otherwise.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
v6:
 * Rebase to v6.9.1
 * Move decision to enable WFx traps back to vcpu load time
 * Move policy enum to arm.c and mark variable as __read_mostly
 * Add explicit disclaimer traps are not guaranteed even when setting enabled
 * Remove explicit "default" case from early param handling as it is not needed

v5:
https://lore.kernel.org/kvmarm/20240430181444.670773-1-coltonlewis@google.com/

v4:
https://lore.kernel.org/kvmarm/20240422181716.237284-1-coltonlewis@google.com/

v3:
https://lore.kernel.org/kvmarm/20240410175437.793508-1-coltonlewis@google.com/

v2:
https://lore.kernel.org/kvmarm/20240319164341.1674863-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvmarm/20240129213918.3124494-1-coltonlewis@google.com/

 .../admin-guide/kernel-parameters.txt         | 18 +++++
 arch/arm64/include/asm/kvm_emulate.h          | 16 -----
 arch/arm64/kvm/arm.c                          | 68 ++++++++++++++++++-
 3 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 396137ee018d..f334265a9cfa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2693,6 +2693,24 @@
 			[KVM,ARM,EARLY] Allow use of GICv4 for direct
 			injection of LPIs.

+	kvm-arm.wfe_trap_policy=
+			[KVM,ARM] Control when to set WFE instruction trap for
+			KVM VMs. Traps are allowed but not guaranteed by the
+			CPU architecture.
+
+			trap: set WFE instruction trap
+
+			notrap: clear WFE instruction trap
+
+	kvm-arm.wfi_trap_policy=
+			[KVM,ARM] Control when to set WFI instruction trap for
+			KVM VMs. Traps are allowed but not guaranteed by the
+			CPU architecture.
+
+			trap: set WFI instruction trap
+
+			notrap: clear WFI instruction trap
+
 	kvm_cma_resv_ratio=n [PPC,EARLY]
 			Reserves given percentage from system memory area for
 			contiguous memory allocation for KVM hash pagetable
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 975af30af31f..68c4a170b871 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -109,22 +109,6 @@ static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
 	return (unsigned long *)&vcpu->arch.hcr_el2;
 }

-static inline void vcpu_clear_wfx_traps(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.hcr_el2 &= ~HCR_TWE;
-	if (atomic_read(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count) ||
-	    vcpu->kvm->arch.vgic.nassgireq)
-		vcpu->arch.hcr_el2 &= ~HCR_TWI;
-	else
-		vcpu->arch.hcr_el2 |= HCR_TWI;
-}
-
-static inline void vcpu_set_wfx_traps(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.hcr_el2 |= HCR_TWE;
-	vcpu->arch.hcr_el2 |= HCR_TWI;
-}
-
 static inline void vcpu_ptrauth_enable(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcr_el2 |= (HCR_API | HCR_APK);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c4a0a35e02c7..1cd58ca5d410 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,15 @@

 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;

+enum kvm_wfx_trap_policy {
+	KVM_WFX_NOTRAP_SINGLE_TASK, /* Default option */
+	KVM_WFX_NOTRAP,
+	KVM_WFX_TRAP,
+};
+
+static enum kvm_wfx_trap_policy kvm_wfi_trap_policy __read_mostly = KVM_WFX_NOTRAP_SINGLE_TASK;
+static enum kvm_wfx_trap_policy kvm_wfe_trap_policy __read_mostly = KVM_WFX_NOTRAP_SINGLE_TASK;
+
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);

 DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
@@ -428,6 +437,24 @@ void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)

 }

+static bool kvm_vcpu_should_clear_twi(struct kvm_vcpu *vcpu)
+{
+	if (likely(kvm_wfi_trap_policy == KVM_WFX_NOTRAP_SINGLE_TASK))
+		return single_task_running() &&
+			(atomic_read(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count) ||
+			 vcpu->kvm->arch.vgic.nassgireq);
+
+	return kvm_wfi_trap_policy == KVM_WFX_NOTRAP;
+}
+
+static bool kvm_vcpu_should_clear_twe(struct kvm_vcpu *vcpu)
+{
+	if (likely(kvm_wfe_trap_policy == KVM_WFX_NOTRAP_SINGLE_TASK))
+		return single_task_running();
+
+	return kvm_wfe_trap_policy == KVM_WFX_NOTRAP;
+}
+
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_s2_mmu *mmu;
@@ -461,10 +488,15 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);

-	if (single_task_running())
-		vcpu_clear_wfx_traps(vcpu);
+	if (kvm_vcpu_should_clear_twe(vcpu))
+		vcpu->arch.hcr_el2 &= ~HCR_TWE;
+	else
+		vcpu->arch.hcr_el2 |= HCR_TWE;
+
+	if (kvm_vcpu_should_clear_twi(vcpu))
+		vcpu->arch.hcr_el2 &= ~HCR_TWI;
 	else
-		vcpu_set_wfx_traps(vcpu);
+		vcpu->arch.hcr_el2 |= HCR_TWI;

 	if (vcpu_has_ptrauth(vcpu))
 		vcpu_ptrauth_disable(vcpu);
@@ -2663,6 +2695,36 @@ static int __init early_kvm_mode_cfg(char *arg)
 }
 early_param("kvm-arm.mode", early_kvm_mode_cfg);

+static int __init early_kvm_wfx_trap_policy_cfg(char *arg, enum kvm_wfx_trap_policy *p)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "trap") == 0) {
+		*p = KVM_WFX_TRAP;
+		return 0;
+	}
+
+	if (strcmp(arg, "notrap") == 0) {
+		*p = KVM_WFX_NOTRAP;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int __init early_kvm_wfi_trap_policy_cfg(char *arg)
+{
+	return early_kvm_wfx_trap_policy_cfg(arg, &kvm_wfi_trap_policy);
+}
+early_param("kvm-arm.wfi_trap_policy", early_kvm_wfi_trap_policy_cfg);
+
+static int __init early_kvm_wfe_trap_policy_cfg(char *arg)
+{
+	return early_kvm_wfx_trap_policy_cfg(arg, &kvm_wfe_trap_policy);
+}
+early_param("kvm-arm.wfe_trap_policy", early_kvm_wfe_trap_policy_cfg);
+
 enum kvm_mode kvm_get_mode(void)
 {
 	return kvm_mode;
--
2.45.1.288.g0e0cd299f1-goog

