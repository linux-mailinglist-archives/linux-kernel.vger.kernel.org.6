Return-Path: <linux-kernel+bounces-272971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553809462F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1BF1F21CF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B9175D33;
	Fri,  2 Aug 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItA1+hrQ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777F166F3D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622787; cv=none; b=ubZMkMolunJU/ZgD6wR+MM/oqlD+H1h9Pzzqk0T8wljxrHmjKrkQ8D/erAEkkvbK03xJp5lCc6liGjKgqWST+zheN58ebuI4KuqHCuONMvI3CCw3H2j5SIaZorgJXrylXp3O30j7M0avzV1K3im4qLCEXEsg3DN8DF/qNbSCDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622787; c=relaxed/simple;
	bh=o0OvfNa5TpmsX8GVsOCn2kcjYNVuMe77RFBY2fipKjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nznXKo5TDt5UsEOYx/bJq8BO+jkWD+/zMR3KOGyhxhiFd2fHqUgLuKehREvXqgp76vZ/ic6K1OZrND86spqY75l5K7fR+f0yerd6aSCcjGRAwHeSjlpxa2esAU19n2gnF39zXM9tpBtIRd8T/uqEnyk8wAzi8T9kuI2B8WJgHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItA1+hrQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3436855a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622785; x=1723227585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3y7jhtRlBTUq2gZloEWogl61U5BQZHywuh8wmJ36c2A=;
        b=ItA1+hrQfOj8ahl0x1LEoApTdaOmkWUxzAFL7dC4P3Wodi4TC+dZghMWvIltivRop3
         bLlcPHKpFzAAWNjrxb/FfiOiHMOmnxyIcLJTHKVA+u11zQHVv+Yaah5PRAoIcUJfFWio
         XFXEgm2AC78b0tcgDE5ZK8qxJlti5J2nNi77fzIbyXCoijKww7mXE5jOoAHR+gBSMWad
         LftwIEZXrob8vsQAxKPGJCNXHdW/ft5y0ik5FO79CcbhsWeDEZOfqnZkwG2xvmrtGJof
         LO+/3ZlG+cYEPRVAUNR/Wml4jvo94pK1BrQ/nYmmASK0Dfd6DiuQVBmDB0JgEeNQnuJO
         3J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622785; x=1723227585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y7jhtRlBTUq2gZloEWogl61U5BQZHywuh8wmJ36c2A=;
        b=JZtxfNkornY9qf14H5KBMGmIS5EujXOK8rdLL3ShHS9p7ie91TTwTxmXOvlV9hoxhE
         lBUBccCTuE/9XaMK5e7TulYY2/bCd6CtY8FKR/aVf5lO4k2MLV1/Pwn91r91UXdB01nB
         ErJ/q96SvuiIznfXaV6KjmM6qInCd5NTiwoCYURw5tmzZ57nKaYs2tjy+toJKPA5RYZe
         FI1qEANizQw7KaZ/L9vox65BRdoui3E4MrkFioKQVEGAZS67kApIlvovuZD19PSRlz3S
         VTxSG0Vo+AzOxcSdR22HBOTWiYrFXUXDeHFrLo8yrvMOZHOSEaX+Bt0ThgP160HSkc5T
         nZmw==
X-Forwarded-Encrypted: i=1; AJvYcCXFSv4LgGgnNm1Wa16OovP/kE1btaDFKj3RNIOZCE4KJZK6Er+Wfth6RHz1k5LNzQzOMKO4hvwEZlcbi4qGSs/vbdPGXDMHlh5i7yMB
X-Gm-Message-State: AOJu0YwFQSVLTuMfJ7/+ibHVm2VQv9yw0PNVmQy3ooOFKl074zq1M0Ae
	O7qV8gL//2dCPf/oig/Y50NVXqv3GWMYzR2Fc+4ixG1UZfaAKBYNd5Fd/lwuIA+U2vq4W5HCv2L
	jLA==
X-Google-Smtp-Source: AGHT+IEnR7i5h9GNP0b4HLxTbsab2+f+GhoQsBoGgFUbEDCtwj1dHd6r6rZ8ZUS1NBOf3ABpFabYiQn18+A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6704:0:b0:7b8:b174:3200 with SMTP id
 41be03b00d2f7-7b8b1743d58mr1457a12.5.1722622785368; Fri, 02 Aug 2024 11:19:45
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:29 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-5-seanjc@google.com>
Subject: [PATCH v2 04/10] KVM: x86: Refactor kvm_x86_ops.get_msr_feature() to
 avoid kvm_msr_entry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Refactor get_msr_feature() to take the index and data pointer as distinct
parameters in anticipation of eliminating "struct kvm_msr_entry" usage
further up the primary callchain.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/svm/svm.c          | 16 +++++++---------
 arch/x86/kvm/vmx/vmx.c          |  6 +++---
 arch/x86/kvm/vmx/x86_ops.h      |  2 +-
 arch/x86/kvm/x86.c              |  2 +-
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 950a03e0181e..ac7a1387a9a0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1805,7 +1805,7 @@ struct kvm_x86_ops {
 	int (*vm_move_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
 	void (*guest_memory_reclaimed)(struct kvm *kvm);
 
-	int (*get_msr_feature)(struct kvm_msr_entry *entry);
+	int (*get_msr_feature)(u32 msr, u64 *data);
 
 	int (*check_emulate_instruction)(struct kvm_vcpu *vcpu, int emul_type,
 					 void *insn, int insn_len);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 909ba79067f8..c22e2b235882 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2825,14 +2825,14 @@ static int efer_trap(struct kvm_vcpu *vcpu)
 	return kvm_complete_insn_gp(vcpu, ret);
 }
 
-static int svm_get_msr_feature(struct kvm_msr_entry *msr)
+static int svm_get_msr_feature(u32 msr, u64 *data)
 {
-	msr->data = 0;
+	*data = 0;
 
-	switch (msr->index) {
+	switch (msr) {
 	case MSR_AMD64_DE_CFG:
 		if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
-			msr->data |= MSR_AMD64_DE_CFG_LFENCE_SERIALIZE;
+			*data |= MSR_AMD64_DE_CFG_LFENCE_SERIALIZE;
 		break;
 	default:
 		return KVM_MSR_RET_UNSUPPORTED;
@@ -3179,14 +3179,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 		break;
 	case MSR_AMD64_DE_CFG: {
-		struct kvm_msr_entry msr_entry;
+		u64 supported_de_cfg;
 
-		msr_entry.index = msr->index;
-		if (svm_get_msr_feature(&msr_entry))
+		if (svm_get_msr_feature(ecx, &supported_de_cfg))
 			return 1;
 
-		/* Check the supported bits */
-		if (data & ~msr_entry.data)
+		if (data & ~supported_de_cfg)
 			return 1;
 
 		/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e5b253e4d421..3d24eb4aeca2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1998,13 +1998,13 @@ static inline bool is_vmx_feature_control_msr_valid(struct vcpu_vmx *vmx,
 	return !(msr->data & ~valid_bits);
 }
 
-int vmx_get_msr_feature(struct kvm_msr_entry *msr)
+int vmx_get_msr_feature(u32 msr, u64 *data)
 {
-	switch (msr->index) {
+	switch (msr) {
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!nested)
 			return 1;
-		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
+		return vmx_get_vmx_msr(&vmcs_config.nested, msr, data);
 	default:
 		return KVM_MSR_RET_UNSUPPORTED;
 	}
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index ce3221cd1d01..9a0304eb847b 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -56,7 +56,7 @@ bool vmx_has_emulated_msr(struct kvm *kvm, u32 index);
 void vmx_msr_filter_changed(struct kvm_vcpu *vcpu);
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
-int vmx_get_msr_feature(struct kvm_msr_entry *msr);
+int vmx_get_msr_feature(u32 msr, u64 *data);
 int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 u64 vmx_get_segment_base(struct kvm_vcpu *vcpu, int seg);
 void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a55f73ce7b2e..e64aba978380 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1675,7 +1675,7 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
-		return kvm_x86_call(get_msr_feature)(msr);
+		return kvm_x86_call(get_msr_feature)(msr->index, &msr->data);
 	}
 	return 0;
 }
-- 
2.46.0.rc2.264.g509ed76dc8-goog


