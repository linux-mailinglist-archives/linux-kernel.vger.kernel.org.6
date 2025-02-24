Return-Path: <linux-kernel+bounces-529780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C583A42ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350CB7A5E64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B5265CD4;
	Mon, 24 Feb 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1yCJ+DW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9A264FA6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420802; cv=none; b=TOv4XIbpo4Ltxq6K51ZLX99vabthUnp6ykNoDN55gikt60K44DAnipg4Zi/R8jeyIfM7BzN/6f2UVwz0abAPq9vtdCN+cWck3zNYC71GrBEeSarV8J8J0XDBdcU53RDCiX+LKM/F4xn7qP7Z0ijcaR55pfa4o9Th1HV5pRwTAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420802; c=relaxed/simple;
	bh=vN/eNE88oaBJnDBhwlNFxVO+p0HRkL3z/lFmoE6TLSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVkU9HVwVdWvx24IAO/B8huoGBPEkDE9fgleC/Owrl/n+ByWtE8pUUuCuyxK6NAWnud4c3bj2CzDilSJun4k2f/UCiAHf7YjJ7SCmOOUV4KMGd394f0eW22dZPWv1+iYvDpL7zQOw/VIA7c49MLiH7tbs1vJV4AMISaJsu3oc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1yCJ+DW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so10202947a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740420800; x=1741025600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F4R7WnGFsL3kL6doD4mCTe3Xz6e56UmxS2U2ziKjVXs=;
        b=Y1yCJ+DWiwQ+P2ChUleodDW+jSTAZ3fwOOuUBqk01lWNF/NZNEbdGbPVQhiSWoZy5c
         V01qcDuJHeLQD5/2fT/aPya0vqEYkkHDjWxP2+A1nEYFcolNqgbHQhJ0/sNviyBHavGZ
         9f0bzHica1pD6BRfoX0jYAD5FnwVcPyRdWJ5ZFB6zMt6qKo+m6vj6hQxUxEmtN8p/a7H
         Zhzv630LcEoR1yV+MniClWEiKtSD+/3B9aCXspjp1BfuPV+9nDyXma+GHRFJIZ55bo6i
         DqMEF5PLyTzLK5vXd44Nvr/7x6ih8xfllJQKIbp+skeaoqigveqeh4u53KTBQzHeG7C9
         nAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420800; x=1741025600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4R7WnGFsL3kL6doD4mCTe3Xz6e56UmxS2U2ziKjVXs=;
        b=i82J6Hzb5/VR/GhVtm2Z5c/DZkzepsl2+aijxj0mxh3isvmWQI4IDgw5LFCnxctCN9
         tCs41HNG/1Wu0G8NAfnwXFFeAHbYs+EipWjLINV3kCmVwG/aAwqy/fD7Llt7kREV2crx
         HIJOAwaoBfML7Rgev5oKY+uPK8nJMMs/kJ30C/P3scFwdiSOo0mLLOfIxQtWTE5GCp6O
         tJSFFrRddh0X+IcLtmrRuGFfvwOnaItgWmIoLBiHNTo6I3P7UquJILebKYo03FzQ5A32
         FZ7ze/zGhNatanBh/5iYs/Mjl3OShqWZzTqLnNMZ0hk68sn7gyb04bxw7YXa7X09Bz6q
         npwA==
X-Forwarded-Encrypted: i=1; AJvYcCUR9VPuYMrRyrauTuxmWyWD7U1o5I4uPw5iu7ju6FCbxFbzEIY1n50XVodnKijO9Rzwwp0JVb7mrRkoKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXlPPtmkRyLH+RmGWJcVypvObUwYPO2sQ727CkwHfSlkIxZSz
	oSIQAx7eN8bTMZdQMCytB56f0Ib1MHSVSsTwrUwPcmI8kCG2JxGayfZWoVMowOycZyvESM3IKqr
	A5w==
X-Google-Smtp-Source: AGHT+IEkWjLWqfrHGmJqcmECY42kHu9FpsyZxRZXM9MU8IhIeRa/Mtd1C3xZad6PO0xUWbPxHDpEpPRuIRo=
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:2fc:d2ac:1724])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180d:b0:2f7:e201:a8cc
 with SMTP id 98e67ed59e1d1-2fce78ad6e0mr27310678a91.18.1740420800405; Mon, 24
 Feb 2025 10:13:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 10:13:13 -0800
In-Reply-To: <20250224181315.2376869-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224181315.2376869-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224181315.2376869-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: x86: Snapshot the host's DEBUGCTL in common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rangemachine@gmail.com, 
	whanos@sergal.fun, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Move KVM's snapshot of DEBUGCTL to kvm_vcpu_arch and take the snapshot in
common x86, so that SVM can also use the snapshot.

Opportunistically change the field to a u64.  While bits 63:32 are reserved
on AMD, not mentioned at all in Intel's SDM, and managed as an "unsigned
long" by the kernel, DEBUGCTL is an MSR and therefore a 64-bit value.

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
2.48.1.658.g4767266eb4-goog


