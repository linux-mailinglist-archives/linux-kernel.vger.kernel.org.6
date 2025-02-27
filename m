Return-Path: <linux-kernel+bounces-535266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F7A470BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34B43AFB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E3146A66;
	Thu, 27 Feb 2025 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9+TXgZi"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09341839F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618812; cv=none; b=YAwuf0vodhbdwEUeInbTxViObVspJC93MByzEqLfSOvpECZ9JT01nAzAGpg/ZvIJe6uhJmghQEGihZUhK/9HVRrCp8QDYkKsc24FuLLOvK3P9NC+Cgx7s3tgnOQ54OaBIXyHHrM1uDHj4yMCfpSi4eUj4dKRkNoVLqB2cZVv5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618812; c=relaxed/simple;
	bh=pUJzhfVuP8YDCZyv6pEaIsEIbkiixYOoWJyO/nE7JWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iy7VcZX9ndGkN9mcv3V4C1troPSr4FP4pgEJ5dQyfK+BvmGAOa/+h3XxLUh0ZuDOtt6T8zWWtFGYJ0U6xHPNk0bhvsEm2vjQDHHaEw09aZ/lVUGnaViQAJ+TaRwdDpHvs0e8TBXBvdYlh77h/QMHqLL0fYFr4eepAg3lAtETWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9+TXgZi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc5a9f18afso964002a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740618810; x=1741223610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+yfVH+oFZLBrscDapM9GBCwxFCs059IFc9U134nCSeM=;
        b=P9+TXgZi1sFwGrOiH/dORnFGIlTY+X5YO/fpt208HM2yW+OGi9hL7Th8rgH1Dps+DU
         +K2Lg1jZjQyWgDnnVAL6bJP18d92noYJavyDot2jBICtZbgC9forZR4Z2Nr6P+4UqBQ3
         RU8p50wtcgmpgsQbV1WUW8jOZcBffmIyfokkVDl0ZJgkB14C/1gnfqThPON9cBm5naH3
         Io8Y7AF2gxd0IezHjqQ1GZpr63qnARHEiuq0HrKig8rnEItgWGdorboA1AM4pps0QXgT
         dYRKnvH4XalhSJyJt6olkxi6B0FC+r/3LKOW5A+qfEbErTUBgBHVV/uNoejrmHx7UVIN
         qQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618810; x=1741223610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yfVH+oFZLBrscDapM9GBCwxFCs059IFc9U134nCSeM=;
        b=ZOwQGNV7gI42c4fyDbD/TFKTs8y+xJ1gq3yegQn9dqmChfUEZewk/b80w6CObZ9G5X
         prfUupQg/plPgi54SqBVjz8aiT2j3xIAb9FX3dlJPJ7l04mRU6BLK82W1vu87z9h3olq
         Sb/KXp+hvsR+inlPr62Yb3ROtnqsNnVPq1kGXph7mZpkKRHCgD9f80EwAXPZFc5qeZZr
         EV5DV0yG7cK2YVhkzSKJJLO5z75h+J5frIg/Bfraug5lb3Jz+yKNiNRrjRK1fjYqrQyV
         vk5eQhtCkBdGXE32xUmCUzzfN5JS4VigfujXZJX2M4h7j/S/vR+lqKMHX5VGMXuMFHO0
         YsXw==
X-Forwarded-Encrypted: i=1; AJvYcCX2sp2v6BvieRYRqKn4s8V7/qVhXSpGt9I82uv1JByJjCEEE/Y268gfco/at8vYUEZOHn2LmyKot4yIc9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLQeRvDqaia2R+gg9yjwLCJkeLG+5qU+6hZLmJqty+4gJjXRV
	PgGhcWt0XRkP8kcSrsL8rAyyiPskhbzMluSpUxUIay5uDWKb7bNNXdm2wEsOyzTK+zzi6+80vzt
	xPw==
X-Google-Smtp-Source: AGHT+IFS1eRlzm3hq046PPD2WG2HjjXP83OKFYPo9hMvfvu9vxphjIku4C28xVyGJKIdNWVM8z7mqhFV90Q=
X-Received: from pgbbk13.prod.google.com ([2002:a05:6a02:28d:b0:add:b2fa:214d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a5:b0:1ee:d17a:d632
 with SMTP id adf61e73a8af0-1f10acd89d8mr9599012637.9.1740618810345; Wed, 26
 Feb 2025 17:13:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:13:18 -0800
In-Reply-To: <20250227011321.3229622-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227011321.3229622-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227011321.3229622-3-seanjc@google.com>
Subject: [PATCH v2 2/5] KVM: x86: Snapshot the host's DEBUGCTL in common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="UTF-8"

Move KVM's snapshot of DEBUGCTL to kvm_vcpu_arch and take the snapshot in
common x86, so that SVM can also use the snapshot.

Opportunistically change the field to a u64.  While bits 63:32 are reserved
on AMD, not mentioned at all in Intel's SDM, and managed as an "unsigned
long" by the kernel, DEBUGCTL is an MSR and therefore a 64-bit value.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 8 ++------
 arch/x86/kvm/vmx/vmx.h          | 2 --
 arch/x86/kvm/x86.c              | 1 +
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3506f497741b..02bffe6b54c8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -781,6 +781,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b71392989609..729c224b72dd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1514,16 +1514,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  */
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	if (vcpu->scheduled_out && !kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 
 	vmx_vcpu_load_vmcs(vcpu, cpu, NULL);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
-
-	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
 void vmx_vcpu_put(struct kvm_vcpu *vcpu)
@@ -7458,8 +7454,8 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 8b111ce1087c..951e44dc9d0e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -340,8 +340,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58b82d6fd77c..09c3d27cc01a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4991,6 +4991,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
+	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
-- 
2.48.1.711.g2feabab25a-goog


