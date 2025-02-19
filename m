Return-Path: <linux-kernel+bounces-520762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44CA3AEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6734D7A440E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278918DB24;
	Wed, 19 Feb 2025 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PHPU+A7"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36AF16BE3A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928435; cv=none; b=tX36rLHRZEy5dEh/I3vhF47WgEQhyoEmnwEt4X7qAjgQAaatermsB+F8B4MSKURZkfmXzBFwR1dQxzio/XnvqDjRTUkL/gjwzri9YYbVwVeIBcVUfXM/y35k36C7yHo4vcohcwJ856ZxQ8w+KEz0GSz08h0XntfwCioxy6Fx4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928435; c=relaxed/simple;
	bh=4OEAxR3s/43AnR+PMZMEbjBraLCzIO0pgoEeiAIRlxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NU7Dz9OO+KAnudFI6MqBR9NKPASUCVphth2AdxlNL86pfuoFH2txHz4zXmkJiNIoxaTZ/TDAMuKugR20GHRokVb+zLffF4jqBVp5LOK3stjFgQGz8rEXa0EVRruVtbWpnPd3Rt/nku7ZYk030Xs66rP/eIZnwQGNHayMdoxnVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PHPU+A7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a70935fso11496482a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739928433; x=1740533233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iJszCJZKg8PtQ/Ae3yHsiUpwJbfr+WbepFVlWSrNVFQ=;
        b=2PHPU+A7OTyW6f2S/FBFXH+LNbW35p0du2527SFP1kalIrPg3kMYRsQ/ftfha4eaaS
         0OsvR825o/YlJtxHqsY6+yynwMZuh+dD+zZXQlPdYNWedszlirFC0KlP0SmAqgxqDNYj
         YXy6JZAf6La0SDY5jXs6ybgXp2h31mVl/icoLKmX6cc/hgS0dIZYL2+MFJg+FoopNFVs
         N5ZX0VIcH8kC/fncerZMosudrWki0d8MEDoRUjJJzyOJWtlM2JcIMt/nhSDJjxCC4d18
         +8jj1R8ABPWMFokJ7AoE32zWhG5bcJm0nmZ8O6hS8+T0ASDLQDVdv/06JttpTwJ9qXhg
         sY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928433; x=1740533233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJszCJZKg8PtQ/Ae3yHsiUpwJbfr+WbepFVlWSrNVFQ=;
        b=xVXvIfPF6TfgJNzT9oNFdRiwqB0ooJK6dXSWBIasp+d8mNxOQ0aAI0g2h0tvQsGBKO
         zii3AL0TCwxHAAbfQpDYd23dsP4d0ohAOkdQaRwA/UIT+6cuIN10uMRfqQLE4b0HwgKn
         aJlnYdY5xkXrI8Pu7BM0eCqDHfuf/HbXu6cCD64ND3OZI/mwXuSNxAmJDq0B7GgH4907
         +lz+oujFqqvYLpS4kzrjeRQCsZ1cY5+rsT+q834bmWcMVNnnpIDwPS+0E+UfMsPBXlYy
         w4xEPOT4Sa3Mu7KKwFGjnKmY42DJGjJpWMeoPRJbyNqfLqkmukmkycwWKUNiRgJtqqDM
         ddzw==
X-Forwarded-Encrypted: i=1; AJvYcCXVK1SUMAJ33UMlOenKwtqRJ45a9jaBvOGmhN8Ylgfl8wk9BW+pGQlvvBQihXIyEASmFAtDvlWyFXA5oqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9oX2v1MXtmRlJsYKumeGSiRn0+zcvI7pHTdrAArlWNxPf5GE
	w96yNC0/j/1wpjjQY1BKxXMxVCbnis8DxzO9KExtXm9SiXXtXPd3agt71SS41JAy3wSt0GH84Tv
	Obw==
X-Google-Smtp-Source: AGHT+IHqxHNQUm/C6lVCMrwMQ8rlL2tdxOfbL2NQq3+nc7UKt3qAAgkQUvPBwgR+3sGE47UNfucABBsGQKA=
X-Received: from pjj5.prod.google.com ([2002:a17:90b:5545:b0:2f7:ff61:48e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f06:b0:2ee:c91a:ad05
 with SMTP id 98e67ed59e1d1-2fc40d14c84mr23967842a91.3.1739928433321; Tue, 18
 Feb 2025 17:27:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Feb 2025 17:26:58 -0800
In-Reply-To: <20250219012705.1495231-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219012705.1495231-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219012705.1495231-4-seanjc@google.com>
Subject: [PATCH 03/10] KVM: SVM: Terminate the VM if a SEV-ES+ guest is run
 with an invalid VMSA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

Terminate the VM if userspace attempts to run an SEV-SNP (or -ES) vCPU
that has an invalid VMSA.  With SNP's AP Create/Destroy hypercalls, it's
possible for an SNP vCPU to end up with an invalid VMSA, e.g. through a
deliberate Destroy or a failed Create event.  KVM marks the vCPU HALTED so
that *KVM* doesn't run the vCPU, but nothing prevents a misbehaving VMM
from manually making the vCPU RUNNABLE via KVM_SET_MP_STATE.

Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 18 +++++++++++++++---
 arch/x86/kvm/svm/svm.c |  7 +++++--
 arch/x86/kvm/svm/svm.h |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6d45e13858..e14a37dbc6ea 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3452,10 +3452,21 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
-void pre_sev_run(struct vcpu_svm *svm, int cpu)
+int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-	unsigned int asid = sev_get_asid(svm->vcpu.kvm);
+	struct kvm *kvm = svm->vcpu.kvm;
+	unsigned int asid = sev_get_asid(kvm);
+
+	/*
+	 * Terminate the VM if userspace attempts to run the vCPU with an
+	 * invalid VMSA, e.g. if userspace forces the vCPU to be RUNNABLE after
+	 * an SNP AP Destroy event.
+	 */
+	if (sev_es_guest(kvm) && !VALID_PAGE(svm->vmcb->control.vmsa_pa)) {
+		kvm_vm_dead(kvm);
+		return -EIO;
+	}
 
 	/* Assign the asid allocated with this SEV guest */
 	svm->asid = asid;
@@ -3468,11 +3479,12 @@ void pre_sev_run(struct vcpu_svm *svm, int cpu)
 	 */
 	if (sd->sev_vmcbs[asid] == svm->vmcb &&
 	    svm->vcpu.arch.last_vmentry_cpu == cpu)
-		return;
+		return 0;
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
 	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	return 0;
 }
 
 #define GHCB_SCRATCH_AREA_LIMIT		(16ULL * PAGE_SIZE)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b8aa0f36850f..46e0b65a9fec 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3587,7 +3587,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	return svm_invoke_exit_handler(vcpu, exit_code);
 }
 
-static void pre_svm_run(struct kvm_vcpu *vcpu)
+static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3609,6 +3609,8 @@ static void pre_svm_run(struct kvm_vcpu *vcpu)
 	/* FIXME: handle wraparound of asid_generation */
 	if (svm->current_vmcb->asid_generation != sd->asid_generation)
 		new_asid(svm, sd);
+
+	return 0;
 }
 
 static void svm_inject_nmi(struct kvm_vcpu *vcpu)
@@ -4231,7 +4233,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	if (force_immediate_exit)
 		smp_send_reschedule(vcpu->cpu);
 
-	pre_svm_run(vcpu);
+	if (pre_svm_run(vcpu))
+		return EXIT_FASTPATH_EXIT_USERSPACE;
 
 	sync_lapic_to_cr8(vcpu);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5b159f017055..e51852977b70 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -713,7 +713,7 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu);
 
 /* sev.c */
 
-void pre_sev_run(struct vcpu_svm *svm, int cpu);
+int pre_sev_run(struct vcpu_svm *svm, int cpu);
 void sev_init_vmcb(struct vcpu_svm *svm);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
-- 
2.48.1.601.g30ceb7b040-goog


