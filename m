Return-Path: <linux-kernel+bounces-199175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029CD8D8370
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0AD1F23CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0E12C552;
	Mon,  3 Jun 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKkM+ZIX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA912C559
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419921; cv=none; b=RkuLczoUbRcGgpYdISL6wWuD3wJ5aiaeYXQOmw9Dzyn5WvBemCt0s3vuQG578DdnClaJPAoDRwL7pl4wOLApYb6TziywW9DBcLy5mjxk3FsHB/mMu+T+AQcvNWfIDAqOm7h/T1fnzjDF6qwYF2rmRX7DNddU5a8iQ+AanZBiUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419921; c=relaxed/simple;
	bh=8SPmrbCgB8ffhbpcTosp/2w3lrXnHnex8/YXpXM64iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdJMBUlEzrAh7zCOWtha4Bfy+flEfrHv+2bCz1SFqxlLR0/PstaH6QNYVCcxXOHEu4hIDUAshcaP9/SK5/4pUS8y4ILaXQGyMPzgaHuGiSSPR9xq4nVEEEd1P92um2ooef3RqWpQlwgcTmC8tO54jlBKDhF3P2qEslBzTZofLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKkM+ZIX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717419918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzuFjVFAR3AFumTLFNlRVUsdOEKIeucLZ/6oKz87YtI=;
	b=GKkM+ZIX7O8mlDzqCg5RIcB3hvMrRTuzHGJaJWkMhVT8kvvTYWYAzjm74s+BgQ1Mc3p1GA
	JD8OHoaKefhT/5XM50/sqXNsvX6jitnVo6bbq6jgyybI4Zm9WPXM/iZDWKZxSmobdu4VNZ
	zeB03jvl6v466ftqjSH3ghZbyxD7xas=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-OhGMKHllPDW0RxDuG636Rg-1; Mon, 03 Jun 2024 09:05:17 -0400
X-MC-Unique: OhGMKHllPDW0RxDuG636Rg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6aed5dcc5fdso37323446d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419916; x=1718024716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzuFjVFAR3AFumTLFNlRVUsdOEKIeucLZ/6oKz87YtI=;
        b=VD1jdAE1XW6JH/i1WIZUoStaewIapY+SficwdSyE3Vu+VcZugqNWD/fM2prrjsRCoL
         TODJIiEdQYpVHokOZzGT35/MYpnfVPkdzPFlJ/grdTM3ZP1yOfRFn28eFqdRlCJ7XBAz
         Rh8BoRV6i368LBwou/KS+gEP0krVNNRDN1rmRXCLRT0jW8EwxvmAccVN4T969t1np4Ay
         +aoru4e9EcFKNnLzwUofSGTsmD3viCOkysrBCvH0jXtJWlh0YpNWaj81GxWdELPnoAdD
         p6ZoQWacT58CSTqEHZyPx5vo4A4xlMOoVBXzhpsA5dSwb+1+IyJHMOSByW/h+UzsoAj2
         E5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUklsFCDviRl7uBACkRffeLrNg9+Yx0AcJz+WTChu5OrXNfDhEfIqIHvxkFWzGt6YMrCAfu6F8Drlk4XzZOhGvm2xnj8Orc52qKY529
X-Gm-Message-State: AOJu0YyZgigiz+zm0TQL9ccYPP/IF0mydRcjU12WMn4g6XYBZ8b3Y+GO
	13eh/U1Pl2wEm7xJ4/8M3CUZ0C9mZO6A9blpeKFwydEA/qIvSg9TagezFPJWuFfF8zNM7HDXw+O
	h14XKKl4qnOGFnAFrqk0SlYtChPwckGgYlfoHKksgyCvgF8/gPicM3XBlixgYuQ==
X-Received: by 2002:a05:6214:33c1:b0:6ae:33db:60f2 with SMTP id 6a1803df08f44-6aecd6f015bmr103753296d6.60.1717419916048;
        Mon, 03 Jun 2024 06:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiLf1N29Uz9zD+BrBPZa+eNtVqOIBAZXmAmNXOxr343MDnKfcRlKB8TqTcwvt5BPAjR6KaVw==
X-Received: by 2002:a05:6214:33c1:b0:6ae:33db:60f2 with SMTP id 6a1803df08f44-6aecd6f015bmr103752936d6.60.1717419915596;
        Mon, 03 Jun 2024 06:05:15 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm30558826d6.113.2024.06.03.06.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:15 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 1/6] KVM: arm64: unify code to prepare traps
Date: Mon,  3 Jun 2024 15:05:02 +0200
Message-ID: <20240603130507.17597-2-sebott@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603130507.17597-1-sebott@redhat.com>
References: <20240603130507.17597-1-sebott@redhat.com>
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


