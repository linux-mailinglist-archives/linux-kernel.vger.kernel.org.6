Return-Path: <linux-kernel+bounces-537413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704BDA48B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729E716D3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F44280A42;
	Thu, 27 Feb 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PRxpsan"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA527FE90
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695061; cv=none; b=VlXAjq1DuhIr828tX42r5il1pfMDSZA4oO+I8Ke0jwVbiGwEhGuZExuSqJYC+X9zDUPRW2CSXFwhVvtNRHhEs+KzW7s8TvWOwyiONNA98MkVXcjYbb8jCvcJW0TrzYeypjhok+w2v+Ew56Mt76LJ7l54iUoMTEeBORFkQy0uytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695061; c=relaxed/simple;
	bh=pUJzhfVuP8YDCZyv6pEaIsEIbkiixYOoWJyO/nE7JWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IwEqjIY04Pjc41cu9qrjYipwnGd3qX5Fsc+3o580BAru887gP0dZZ5p0ZlLyiWf1ht6di0X9izq6Ugj4U0VWI+lqgcJEBxwgziTLj9bLOs03XMBlAhOAM9TtE1BydfV39tqN250ZEclBGCUSDWTDIw9HifY9ScFOjjPm7LFlsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PRxpsan; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso5245772a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740695059; x=1741299859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+yfVH+oFZLBrscDapM9GBCwxFCs059IFc9U134nCSeM=;
        b=2PRxpsanpkey1y2ME9wPe3pRF1Qua87RJYvMK/i6XVno/WyPO+0UyMnA63nbVpSCH4
         gdx2ZRv+d7fEZrQBQ9tQbPHni6caJ0PqqagFOhNnB+iIpv6NXT6+VWJF46Imo1M1pxd9
         nrc43kxgS3jQUOumBY+7H9NJ4G95STegElXpyAIBpNZISQKSPfrkS5LLEEu2eXkvo8L/
         TJ/X/QATPLwvC3b3Bpwvvg7Vj4lw4fnl9ZIwxbpSoZjgmAVXKlhT80CI+Oz3AyCTAkRk
         /fMxwS+8rHo1Mm0C2hJm92WOeQRbMdX9EYJCpqZxaF+TEg/7d+WsUk0Ig4qn2xyF9oJA
         oknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695059; x=1741299859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yfVH+oFZLBrscDapM9GBCwxFCs059IFc9U134nCSeM=;
        b=OKxE2/HWYXBLHVsWDUfJEsBthogtjelY7qnSjdeUb4+5tya/RVJLR1gPoZhWs5GNCC
         PPsl3gT3VPsUII66QgExGEIR8OI2iSC8tI3i6HEwcoHP1XKgW8efx2Z9TqkOHoT4ztB4
         8t6jraSmi4hCta0MofSsyJqG215JTp8wqlb1l9SqoSDJQlUoib0T7sSrcFmx+d2NK9HI
         k0JElu1YPaLgiY3AkecAHEZkAm5sJ8OaNnIZLZcjsgCAuXIV2Hnv/RSKcdKmO87iolaU
         CtfBWDhxAMOHGKoPGiWmfTYS+ILQm+qIQE1Bro13mU304w78rfWaynHLFrw/l4iu64xa
         FlDw==
X-Forwarded-Encrypted: i=1; AJvYcCXm+WPdJeJ8lPHkkM4lcdN413Aap3d+jNTy8jC9TqJ2d0NkvtQL9QWh2fhoTMIr7JglDa6PRWHjGHjLXAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEHX56Ppk1xq/GC3+/FSylxmQ42M6NCsFCQap9Qwr7GC1RhW9
	Otl2hAHlubD7TkvrgxbqOUOzQc83N16Hj5Zcy3DsJ0cW2+hb3jRky+cvP76hc1n8OVEO0hlGgS/
	4tQ==
X-Google-Smtp-Source: AGHT+IEMbPI0IcnCivmO2KjUlLnmbO74NhIVMvoAV5zc96bgDzprvjGqzWCj1/wKqim/zPzkZAzCkp0qImg=
X-Received: from pgbb23.prod.google.com ([2002:a63:1b17:0:b0:ad5:5920:367])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6141:b0:1ee:cf13:d4b5
 with SMTP id adf61e73a8af0-1f2f4e4c90amr1228447637.39.1740695059033; Thu, 27
 Feb 2025 14:24:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 14:24:08 -0800
In-Reply-To: <20250227222411.3490595-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227222411.3490595-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227222411.3490595-4-seanjc@google.com>
Subject: [PATCH v3 3/6] KVM: x86: Snapshot the host's DEBUGCTL in common x86
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


