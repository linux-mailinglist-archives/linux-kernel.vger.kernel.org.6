Return-Path: <linux-kernel+bounces-178399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5388C4D06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B162F1C2166A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F89F11C83;
	Tue, 14 May 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwVDpqbN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151E134A5
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671746; cv=none; b=YlxUEyiX1jJcBxNwX7mOaWyyN8nTg/Dr/ZEhhVs6nVGXJgwX4uK3/q4XswTKQ+e2b4q6Nb3dCy7Nm5YM2z+8oyMhXfNZAs8/Z0UM9mjGG67P6rtNZWHJj1EsmyvdcIN7hNiB8ySe5FTdYGug/RaM92mXegTzvS2YMP8N76ABoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671746; c=relaxed/simple;
	bh=SplUyiceO33acZVUSNIv+R1LEcFl7TGSw9aJpGoYgm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br++bR5R/s+FElXAfBUccXEvc2av1QVeiWUgLj/9D/0hlshweIgeVlTz6QYYnJzr6E67ffqL2bR+NxL+Ah2ZIiyBqKdmDWxDQFD8/qoHw7nf04iknxLi+Xm5wY57eeONh9pTPUcfxVp9qvfQV6BxIOfKsUhKAyb/+0QiIqR6rFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwVDpqbN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb7KafJV7I3Bq8cEiRTMNitbrzaJJX9E0+TIJqM8O5c=;
	b=ZwVDpqbNRM42gMwolQ4bN0d8K6TI6ddKG8GqFDzhofQN9RZ8v4Y/LTU0DXrXk4VTdQ8MrK
	7wA8Zf6R1iCmAw8gHOIFDOx7khb+BiVifeCH6unNcKxX2Lv0lM1uUuQw6QJeZMObQXLOlG
	s/L74ObpKDo6fqSr2jb+skY0f0Eox6Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-I5w7gbb1MDiaYX_RaI3T1Q-1; Tue, 14 May 2024 03:23:00 -0400
X-MC-Unique: I5w7gbb1MDiaYX_RaI3T1Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69b6fe789e9so45448796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671380; x=1716276180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rb7KafJV7I3Bq8cEiRTMNitbrzaJJX9E0+TIJqM8O5c=;
        b=YQKsziiGvo7Eg4Rph6aKQqkTjMtP1vBbLTrbtiHdL12BV8kMk60SKRq9VRMM0SpM6D
         nnEDvb9P+mi4/bEislmxgHiMhWXH60s2LSO3hX0wFiMH0EOR9c7YGVdlTIW+zTWx8QrL
         LwglEkDkhVxCMtZd9M3FoaCflpINqdSUQeBdxc9jB0mAEGB6jYCphladWhTMTsQesRM8
         D8e3X5KzEUfTyk3RjIAsvuk1bJ0xzEiQQBZU4rXhRpnTz8FGhaA9iLTD69fOyUZOHEkP
         zGd5PVeS9D7DzyIoNRe4bNtRdUydRzk6hJNw9jltTSP3wsKuJTeS8CuBrnmTGRPliOYe
         h2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUIqSaDTg4fwkvQPoOXC5VrlWnWYc+E6PPVbo/QudN1t/HRLnBi2R8FqA7g3P13C6GbSJ7IAn0sG/CTEP7Wn703qKuxA31MrZAbeSKs
X-Gm-Message-State: AOJu0YzcdA/L+j1gW50P0TC7U2IAkadWAerYihzow0VBWK59mWqDndFB
	BamjK8GnjE/6qoX5KIqH8783glGCNlrELucbklej/ET0femGH1CVFmMZFFgxXF5dDKiU/1UJP3t
	m9JAma09yzSUdTtVr1LFe1zHEs06aYSykIk6hx0PzNGbBXfP8lRts+O0b8Yv+1w==
X-Received: by 2002:a05:6214:5b81:b0:6a0:c151:6283 with SMTP id 6a1803df08f44-6a16838986fmr165997566d6.56.1715671379854;
        Tue, 14 May 2024 00:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdX4p3qfLGGnIV/WfSKOJPR1Byzbb/+g2h6nrg91L5/ZNPPFTPTSZHsAztlmX12uE60Uj70Q==
X-Received: by 2002:a05:6214:5b81:b0:6a0:c151:6283 with SMTP id 6a1803df08f44-6a16838986fmr165997406d6.56.1715671379502;
        Tue, 14 May 2024 00:22:59 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:22:58 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/6] KVM: arm64: unify code to prepare traps
Date: Tue, 14 May 2024 09:22:47 +0200
Message-ID: <20240514072252.5657-2-sebott@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514072252.5657-1-sebott@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 functions to calculate traps via HCR_EL2:
* kvm_init_sysreg() called via KVM_RUN (before the 1st run or when
  the pid changes)
* vcpu_reset_hcr() called via KVM_ARM_VCPU_INIT

To unify these 2 and to support traps that are dependent on the
ID register configuration, move the code from vcpu_reset_hcr()
to sys_regs.c and call it via kvm_init_sysreg().

We still have to keep the non-FWB handling stuff in vcpu_reset_hcr().
Also the initialization with HCR_GUEST_FLAGS is kept there but guarded
by !vcpu_has_run_once() to ensure that previous calculated values
don't get overwritten.

While at it rename kvm_init_sysreg() to kvm_calculate_traps() to
better reflect what it's doing.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 40 +++++++---------------------
 arch/arm64/include/asm/kvm_host.h    |  2 +-
 arch/arm64/kvm/arm.c                 |  2 +-
 arch/arm64/kvm/sys_regs.c            | 34 +++++++++++++++++++++--
 4 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 501e3e019c93..84dc3fac9711 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -69,39 +69,17 @@ static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
 
 static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
-	if (has_vhe() || has_hvhe())
-		vcpu->arch.hcr_el2 |= HCR_E2H;
-	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
-		/* route synchronous external abort exceptions to EL2 */
-		vcpu->arch.hcr_el2 |= HCR_TEA;
-		/* trap error record accesses */
-		vcpu->arch.hcr_el2 |= HCR_TERR;
-	}
+	if (!vcpu_has_run_once(vcpu))
+		vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
 
-	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB)) {
-		vcpu->arch.hcr_el2 |= HCR_FWB;
-	} else {
-		/*
-		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
-		 * get set in SCTLR_EL1 such that we can detect when the guest
-		 * MMU gets turned on and do the necessary cache maintenance
-		 * then.
-		 */
+	/*
+	 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
+	 * get set in SCTLR_EL1 such that we can detect when the guest
+	 * MMU gets turned on and do the necessary cache maintenance
+	 * then.
+	 */
+	if (!cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
 		vcpu->arch.hcr_el2 |= HCR_TVM;
-	}
-
-	if (cpus_have_final_cap(ARM64_HAS_EVT) &&
-	    !cpus_have_final_cap(ARM64_MISMATCHED_CACHE_TYPE))
-		vcpu->arch.hcr_el2 |= HCR_TID4;
-	else
-		vcpu->arch.hcr_el2 |= HCR_TID2;
-
-	if (vcpu_el1_is_32bit(vcpu))
-		vcpu->arch.hcr_el2 &= ~HCR_RW;
-
-	if (kvm_has_mte(vcpu->kvm))
-		vcpu->arch.hcr_el2 |= HCR_ATA;
 }
 
 static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8170c04fde91..212ae77eefaf 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1122,7 +1122,7 @@ int __init populate_nv_trap_config(void);
 bool lock_all_vcpus(struct kvm *kvm);
 void unlock_all_vcpus(struct kvm *kvm);
 
-void kvm_init_sysreg(struct kvm_vcpu *);
+void kvm_calculate_traps(struct kvm_vcpu *);
 
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9996a989b52e..6b217afb4e8e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -797,7 +797,7 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	 * This needs to happen after NV has imposed its own restrictions on
 	 * the feature set
 	 */
-	kvm_init_sysreg(vcpu);
+	kvm_calculate_traps(vcpu);
 
 	ret = kvm_timer_enable(vcpu);
 	if (ret)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22b45a15d068..41741bf4d2b2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4041,11 +4041,33 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 	return 0;
 }
 
-void kvm_init_sysreg(struct kvm_vcpu *vcpu)
+static void vcpu_set_hcr(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
 
-	mutex_lock(&kvm->arch.config_lock);
+	if (has_vhe() || has_hvhe())
+		vcpu->arch.hcr_el2 |= HCR_E2H;
+	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
+		/* route synchronous external abort exceptions to EL2 */
+		vcpu->arch.hcr_el2 |= HCR_TEA;
+		/* trap error record accesses */
+		vcpu->arch.hcr_el2 |= HCR_TERR;
+	}
+
+	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
+		vcpu->arch.hcr_el2 |= HCR_FWB;
+
+	if (cpus_have_final_cap(ARM64_HAS_EVT) &&
+	    !cpus_have_final_cap(ARM64_MISMATCHED_CACHE_TYPE))
+		vcpu->arch.hcr_el2 |= HCR_TID4;
+	else
+		vcpu->arch.hcr_el2 |= HCR_TID2;
+
+	if (vcpu_el1_is_32bit(vcpu))
+		vcpu->arch.hcr_el2 &= ~HCR_RW;
+
+	if (kvm_has_mte(vcpu->kvm))
+		vcpu->arch.hcr_el2 |= HCR_ATA;
 
 	/*
 	 * In the absence of FGT, we cannot independently trap TLBI
@@ -4054,6 +4076,14 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
 	 */
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		vcpu->arch.hcr_el2 |= HCR_TTLBOS;
+}
+
+void kvm_calculate_traps(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	mutex_lock(&kvm->arch.config_lock);
+	vcpu_set_hcr(vcpu);
 
 	if (cpus_have_final_cap(ARM64_HAS_HCX)) {
 		vcpu->arch.hcrx_el2 = HCRX_GUEST_FLAGS;
-- 
2.42.0


