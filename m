Return-Path: <linux-kernel+bounces-519867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D60A3A2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE4B3ABB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336C826F443;
	Tue, 18 Feb 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGVc6TJY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E824336D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896492; cv=none; b=NJ1wKDYGaKin8yIMmUGA/3jp0rIpDpkwloLHPKY4pHBNiFJyAHP4A0xUE6j90Kq+ddNzY55mFG1p5JCfA1a1np69iT3fSNpErnm/BXYdGi4oQlEeJINXu/K3Ded+03nojutiZ2hTVNlr4YrUT1EABSSu4WZdo0SJlCY/EkolX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896492; c=relaxed/simple;
	bh=HDIro145JF8qLhcr+46jJCYyEkbhSTfDHCqE/GyK3Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoOnvOkpNqU2wKjiAJBazHvBO2Qk+DpapTIw4wCyXOaGXpgQDp9egEHtLROeIPaXeH69ITouugLD+AuVpuEjZzPLxU5mOZ0oTAVuRMI0Bo/sAlB9P1igMgeYgZteDTGatMp7suJ1HprERt/XSiFsEmPq4hcZkUR8RCfvILTAa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGVc6TJY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBAJYqM7ldZvJEhXpvC4FzpZR8Z/lsR/9f9gWywL5Lk=;
	b=eGVc6TJYfN6Oo3uQ/aqlkBIScXDUCnOLgo+6eTl5jFncOplaiCyFGjj+A5zK+htgMBKqEc
	FWJyo2jxku592Dxtvg240HFZrBEPZiV+ztqFvuAlGHWvxZYddPXdwWrB51M+eqNPWTCo4i
	wqQMzCFShhiX2R0LeCeki6omNSezxo8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-4q-jDF79Mrm5wWC-pILGlg-1; Tue, 18 Feb 2025 11:34:48 -0500
X-MC-Unique: 4q-jDF79Mrm5wWC-pILGlg-1
X-Mimecast-MFC-AGG-ID: 4q-jDF79Mrm5wWC-pILGlg_1739896487
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f42f21f54so1286624f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896487; x=1740501287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBAJYqM7ldZvJEhXpvC4FzpZR8Z/lsR/9f9gWywL5Lk=;
        b=iK+gns254Uwy1wjww5ePhLPAeJF6Xld/feaRWvzZ6XLYY68fUtfSLozWh7BohxHpaQ
         GHkSId2b5CTseZqYa+wOp3FuLy2bqegTBJR3tJolh10BUKpekQ31RKonY+Pb6K4BuBQS
         DRGs07Z+y+1kaFlTp/07Ip/pmbdaUYUXnA5qXxS0/HCdmBgr8Wz62DyHVjd/+25LQ+yr
         Gh6ywkVn2iriwoeAS2oOD+re4Xs6lLZHsIcwloQ1g7ljBDUWzxmYxQ7Ezf+pz7aPMA8f
         RmkCsSElxJHBCxtX3k1L9EGYDWouP/zkt+P2ER/8xuCXhjo8YQUN71NvMsvxQyw5wvCE
         T9YA==
X-Forwarded-Encrypted: i=1; AJvYcCVrXlDQGILx2JgejKMAAGeGftLN1lJq9f7eONqfQngT67TN4yx6XwHhVDw24ZgMLvwA4CDxmJtSBzOz88M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dAgZB8x2B9859Z/sI5IGs9jkt1ynYUNAJ6cmZ+gikx01OcFc
	yS0LpFz/Zv0bwp2T+bCyLCyZIIqEpLy6eAzl9YNPMEpgMyG3rqKib//DZlmEJonjWsLFt+agZFU
	GaCDTBLZHGw6nQzOzt26csClKWXKk1TvVVlmmxPuZp6U7VHEv5OXtqZR6+aJqpw==
X-Gm-Gg: ASbGncsJoY525QhcPhCq7ewLklrn4qK6x1UrLSUR5JcZEe7D7MbHbQN9bPC9nyHPCEv
	VJEToVBwxb6GobBRBXmGjkC0XJ7nfrJTRMy4U45u9isxT7TxkAIpitXA8VdEAssou44amBqVCdh
	0mjv3gHmZmeC0rbiAaj682UqxcY1An7gx2n4Ej8T4brZsh5txyia0MSJK1+YwcVOXyFbw9SxOxA
	ymrO7MPXsG153OvcDTrUT6e0KQfjF8SWvXmQrxd8TfXY/o8twiIC6ojZKVUyQUDc8W9eXjOR/lN
	U7g+2ePhdnILXOgpKGrkiHI0e0l4LAGfes5cVyS1qpt1fxDqtdI/BgJ5vbXJVV4jTZ6M
X-Received: by 2002:a5d:6da4:0:b0:38f:451b:653c with SMTP id ffacd0b85a97d-38f451b663emr6976524f8f.7.1739896486739;
        Tue, 18 Feb 2025 08:34:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsArJCvYl0ZKZFFHRbr5Xj8NRWFPVPzZuhGHIdrmzHwJLirylNpc8AXsKQt8ODWlx1pdqlzg==
X-Received: by 2002:a5d:6da4:0:b0:38f:451b:653c with SMTP id ffacd0b85a97d-38f451b663emr6976491f8f.7.1739896486212;
        Tue, 18 Feb 2025 08:34:46 -0800 (PST)
Received: from rh.redhat.com (p200300f6af0e4d00dda53016e366575f.dip0.t-ipconnect.de. [2003:f6:af0e:4d00:dda5:3016:e366:575f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm85091845e9.0.2025.02.18.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:34:45 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] KVM: arm64: Allow userspace to change MIDR_EL1
Date: Tue, 18 Feb 2025 17:34:40 +0100
Message-ID: <20250218163443.32836-2-sebott@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218163443.32836-1-sebott@redhat.com>
References: <20250218163443.32836-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable VMMs to write MIDR_EL1 by treating it as a VM ID register.
Since MIDR_EL1 is not handled as a proper arm64_ftr_reg apply only
a sanity check against the writable mask to ensure the reserved
bits are 0.

Set up VPIDR_EL2 to hold the MIDR_EL1 value for the guest.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h          |  3 ++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |  5 +--
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c        | 10 +++++-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c         | 28 ++++++---------
 arch/arm64/kvm/sys_regs.c                  | 42 ++++++++++++++++++++--
 5 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cfa024de4e3..3db8c773339e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -373,6 +373,7 @@ struct kvm_arch {
 #define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
 	u64 id_regs[KVM_ARM_ID_REG_NUM];
 
+	u64 midr_el1;
 	u64 ctr_el0;
 
 	/* Masks for VNCR-backed and general EL2 sysregs */
@@ -1469,6 +1470,8 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
 	switch (reg) {
 	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
 		return &ka->id_regs[IDREG_IDX(reg)];
+	case SYS_MIDR_EL1:
+		return &ka->midr_el1;
 	case SYS_CTR_EL0:
 		return &ka->ctr_el0;
 	default:
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 76ff095c6b6e..c8f37e702724 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -168,9 +168,10 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
-					      u64 mpidr)
+					      u64 midr, u64 mpidr)
 {
-	write_sysreg(mpidr,				vmpidr_el2);
+	write_sysreg(midr, vpidr_el2);
+	write_sysreg(mpidr, vmpidr_el2);
 
 	if (has_vhe() ||
 	    !cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
diff --git a/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c b/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
index dba101565de3..a01be1add5ad 100644
--- a/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
@@ -28,7 +28,15 @@ void __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt)
 
 void __sysreg_restore_state_nvhe(struct kvm_cpu_context *ctxt)
 {
-	__sysreg_restore_el1_state(ctxt, ctxt_sys_reg(ctxt, MPIDR_EL1));
+	u64 midr;
+
+	if (ctxt_is_guest(ctxt))
+		midr = kvm_read_vm_id_reg(kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm),
+					  SYS_MIDR_EL1);
+	else
+		midr = read_cpuid_id();
+
+	__sysreg_restore_el1_state(ctxt, midr, ctxt_sys_reg(ctxt, MPIDR_EL1));
 	__sysreg_restore_common_state(ctxt);
 	__sysreg_restore_user_state(ctxt);
 	__sysreg_restore_el2_return_state(ctxt);
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 90b018e06f2c..a57a771e9be6 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -87,11 +87,12 @@ static void __sysreg_restore_vel2_state(struct kvm_vcpu *vcpu)
 	write_sysreg(__vcpu_sys_reg(vcpu, PAR_EL1),	par_el1);
 	write_sysreg(__vcpu_sys_reg(vcpu, TPIDR_EL1),	tpidr_el1);
 
-	write_sysreg(__vcpu_sys_reg(vcpu, MPIDR_EL1),		vmpidr_el2);
-	write_sysreg_el1(__vcpu_sys_reg(vcpu, MAIR_EL2),	SYS_MAIR);
-	write_sysreg_el1(__vcpu_sys_reg(vcpu, VBAR_EL2),	SYS_VBAR);
-	write_sysreg_el1(__vcpu_sys_reg(vcpu, CONTEXTIDR_EL2),	SYS_CONTEXTIDR);
-	write_sysreg_el1(__vcpu_sys_reg(vcpu, AMAIR_EL2),	SYS_AMAIR);
+	write_sysreg(kvm_read_vm_id_reg(vcpu->kvm, SYS_MIDR_EL1),	vpidr_el2);
+	write_sysreg(__vcpu_sys_reg(vcpu, MPIDR_EL1),			vmpidr_el2);
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, MAIR_EL2),		SYS_MAIR);
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, VBAR_EL2),		SYS_VBAR);
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, CONTEXTIDR_EL2),		SYS_CONTEXTIDR);
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, AMAIR_EL2),		SYS_AMAIR);
 
 	if (vcpu_el2_e2h_is_set(vcpu)) {
 		/*
@@ -191,7 +192,7 @@ void __vcpu_load_switch_sysregs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
-	u64 mpidr;
+	u64 midr, mpidr;
 
 	host_ctxt = host_data_ptr(host_ctxt);
 	__sysreg_save_user_state(host_ctxt);
@@ -220,23 +221,18 @@ void __vcpu_load_switch_sysregs(struct kvm_vcpu *vcpu)
 		__sysreg_restore_vel2_state(vcpu);
 	} else {
 		if (vcpu_has_nv(vcpu)) {
-			/*
-			 * Use the guest hypervisor's VPIDR_EL2 when in a
-			 * nested state. The hardware value of MIDR_EL1 gets
-			 * restored on put.
-			 */
-			write_sysreg(ctxt_sys_reg(guest_ctxt, VPIDR_EL2), vpidr_el2);
-
 			/*
 			 * As we're restoring a nested guest, set the value
 			 * provided by the guest hypervisor.
 			 */
+			midr = ctxt_sys_reg(guest_ctxt, VPIDR_EL2);
 			mpidr = ctxt_sys_reg(guest_ctxt, VMPIDR_EL2);
 		} else {
+			midr = kvm_read_vm_id_reg(vcpu->kvm, SYS_MIDR_EL1);
 			mpidr = ctxt_sys_reg(guest_ctxt, MPIDR_EL1);
 		}
 
-		__sysreg_restore_el1_state(guest_ctxt, mpidr);
+		__sysreg_restore_el1_state(guest_ctxt, midr, mpidr);
 	}
 
 	vcpu_set_flag(vcpu, SYSREGS_ON_CPU);
@@ -271,9 +267,5 @@ void __vcpu_put_switch_sysregs(struct kvm_vcpu *vcpu)
 	/* Restore host user state */
 	__sysreg_restore_user_state(host_ctxt);
 
-	/* If leaving a nesting guest, restore MIDR_EL1 default view */
-	if (vcpu_has_nv(vcpu))
-		write_sysreg(read_cpuid_id(),	vpidr_el2);
-
 	vcpu_clear_flag(vcpu, SYSREGS_ON_CPU);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82430c1e1dd0..3cd4dfdd287a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1666,7 +1666,7 @@ static bool is_feature_id_reg(u32 encoding)
  */
 static inline bool is_vm_ftr_id_reg(u32 id)
 {
-	if (id == SYS_CTR_EL0)
+	if (id == SYS_CTR_EL0 || id == SYS_MIDR_EL1)
 		return true;
 
 	return (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
@@ -1999,6 +1999,33 @@ static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	return 0;
 }
 
+static int set_id_reg_non_ftr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			      u64 val)
+{
+	u32 id = reg_to_encoding(rd);
+
+	guard(mutex)(&vcpu->kvm->arch.config_lock);
+	/*
+	 * Once the VM has started the ID registers are immutable. Reject any
+	 * write that does not match the final register value.
+	 */
+	if (kvm_vm_has_ran_once(vcpu->kvm)) {
+		if (val != read_id_reg(vcpu, rd))
+			return -EBUSY;
+
+		return 0;
+	}
+
+	/*
+	 * For non ftr regs do a limited test against the writable mask only.
+	 */
+	if ((rd->val & val) != val)
+		return -EINVAL;
+
+	kvm_set_vm_id_reg(vcpu->kvm, id, val);
+	return 0;
+}
+
 static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      u64 val)
 {
@@ -2493,6 +2520,15 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+#define FUNCTION_RESET(reg)						\
+	static u64 reset_##reg(struct kvm_vcpu *v,			\
+			       const struct sys_reg_desc *r)		\
+	{								\
+		return read_sysreg(reg);				\
+	}
+
+FUNCTION_RESET(midr_el1)
+
 
 /*
  * Architected system registers.
@@ -2542,6 +2578,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_DBGVCR32_EL2), undef_access, reset_val, DBGVCR32_EL2, 0 },
 
+	{ ID_DESC(MIDR_EL1), .set_user = set_id_reg_non_ftr, .visibility = id_visibility,
+	  .reset = reset_midr_el1, .val = GENMASK_ULL(31, 0) },
 	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
 
 	/*
@@ -4594,13 +4632,11 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
 		return ((struct sys_reg_desc *)r)->val;			\
 	}
 
-FUNCTION_INVARIANT(midr_el1)
 FUNCTION_INVARIANT(revidr_el1)
 FUNCTION_INVARIANT(aidr_el1)
 
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
-	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr_el1 },
 	{ SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
 	{ SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
 };
-- 
2.42.0


