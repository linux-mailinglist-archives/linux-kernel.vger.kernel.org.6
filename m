Return-Path: <linux-kernel+bounces-560415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DDA603C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345F6420C55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631941FBE8F;
	Thu, 13 Mar 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lICVW+tK"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BBA1F63C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902970; cv=none; b=H8461Jcm8aUebdEJf3SOay6J9sFbFwV5eClDNmpbSLKyzrA7llplqo6DSJQM39Wqr8e/dHqVRUDRpRH6TJ6oVQFGlOsubtDrT2a1rA1Ot/o75QGcDBReXcEGvs6WGAER+MOdRS3iCPipnNrdoLovbghmA9uDG9WGgu4IW7Xu+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902970; c=relaxed/simple;
	bh=0t+zX0HpA8zT88d4wD6BeZXcNvONGsx3iB3nDx8sBHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MATEBibhJIcDnBzgHZHoI8/HzWzXfcbjREqWMfQJPaNxvdF8BJSQIrFy2MukMgrzw3LDMNyH9EaQgyUslTCK3sZHlDzjPfpijTqlcHfQV3lSncu4wjD7c4SWET/7ikfmEA04ndZgxZ0cGh/jTMNefqTECitY3CM+gmqvSSmGD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lICVW+tK; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741902966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02QFPfOHKNlwJVYXcIvUHxvnbWRxOfELTFB2ejfTyvY=;
	b=lICVW+tKNQLbo3DdJ0O57TAfgeNd/mBKvfCyhNmUiNES939D0kwmknmM43I4U+lf/tMKmN
	00FzrxMSQeYM1O4syIWifBj1t4Bi3Db0C9Qzfm5TcUacoXiKRuWK/Rt3i5eUX3lU+38070
	1Awydq35vC+xqGC/YiX/Ur5aM4wtzpg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 7/7] KVM: SVM: Share more code between pre_sev_run() and pre_svm_run()
Date: Thu, 13 Mar 2025 21:55:40 +0000
Message-ID: <20250313215540.4171762-8-yosry.ahmed@linux.dev>
In-Reply-To: <20250313215540.4171762-1-yosry.ahmed@linux.dev>
References: <20250313215540.4171762-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pre_svm_run() and pre_sev_run() now do some redundant work, and the
control flow is not super clear. Specifically:
- Both functions check if the ASID in the VMCB is the expected one.
- Both functions check if the vCPU moved to a different physical CPU.
- Both functions issue an ASID TLB flush if needed.

Pass the ASID and whether or not SEV requires a TLB flush from
pre_sev_run() to pre_svm_run(), and use the logic there instead.
pre_sev_run() now only performs SEV-specific checks.

Note that pre_sev_run() used svm->vcpu.arch.last_vmentry_cpu to check if
the vCPU moved to a different physical CPU, while pre_svm_run uses
svm->current_vmcb->cpu. The former tracks the CPU per vCPU, while the
latter tracks it per VMCB. For SEV, they both should be equivalent since
there is a single VMCB per-vCPU (nested is not supported).

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/sev.c | 27 ++++++++++-----------------
 arch/x86/kvm/svm/svm.c | 10 ++++++----
 arch/x86/kvm/svm/svm.h |  2 +-
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1ee04d6b9356b..607139757f8ff 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3451,11 +3451,11 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
-int pre_sev_run(struct vcpu_svm *svm, int cpu)
+int pre_sev_run(struct vcpu_svm *svm, unsigned int *asid, bool *need_flush)
 {
+	int cpu = svm->vcpu.cpu;
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
 	struct kvm *kvm = svm->vcpu.kvm;
-	unsigned int asid = sev_get_asid(kvm);
 
 	/*
 	 * Reject KVM_RUN if userspace attempts to run the vCPU with an invalid
@@ -3465,24 +3465,17 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	if (sev_es_guest(kvm) && !VALID_PAGE(svm->vmcb->control.vmsa_pa))
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(svm->vmcb->control.asid != asid)) {
-		svm->vmcb->control.asid = asid;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
-
 	/*
-	 * Flush guest TLB:
-	 *
-	 * 1) when different VMCB for the same ASID is to be run on the same host CPU.
-	 * 2) or this VMCB was executed on different host CPU in previous VMRUNs.
+	 * Flush the guest TLB when a difference VMCB for the same ASID is to be
+	 * run on the same host CPU. The caller will also flush the TLB if the
+	 * VMCB was executed on a different host CPU in previous VMRUNs.
 	 */
-	if (sd->sev_vmcbs[asid] == svm->vmcb &&
-	    svm->vcpu.arch.last_vmentry_cpu == cpu)
-		return 0;
+	*asid = sev_get_asid(kvm);
+	if (sd->sev_vmcbs[*asid] != svm->vmcb) {
+		sd->sev_vmcbs[*asid] = svm->vmcb;
+		*need_flush = true;
+	}
 
-	sd->sev_vmcbs[asid] = svm->vmcb;
-	svm_vmcb_set_flush_asid(svm->vmcb);
-	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c5e2733fb856d..6b338d84e7b93 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3615,21 +3615,23 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
+	unsigned int asid = kvm_svm->asid;
+	bool sev_need_flush = false;
+
+	if (sev_guest(vcpu->kvm) && pre_sev_run(svm, &asid, &sev_need_flush))
+		return -1;
 
 	/*
 	 * If the previous VMRUN of the VMCB occurred on a different physical
 	 * CPU, then mark the VMCB dirty and flush the ASID.  Hardware's
 	 * VMCB clean bits are per logical CPU, as are KVM's ASID assignments.
 	 */
-	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
+	if (unlikely(sev_need_flush || svm->current_vmcb->cpu != vcpu->cpu)) {
 		svm_vmcb_set_flush_asid(svm->vmcb);
 		vmcb_mark_all_dirty(svm->vmcb);
 		svm->current_vmcb->cpu = vcpu->cpu;
         }
 
-	if (sev_guest(vcpu->kvm))
-		return pre_sev_run(svm, vcpu->cpu);
-
 	/* Flush the ASID on every VMRUN if kvm_svm->asid allocation failed */
 	if (unlikely(!kvm_svm->asid))
 		svm_vmcb_set_flush_asid(svm->vmcb);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 4c6664ba4048d..f25e99c79d07d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -754,7 +754,7 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu);
 
 /* sev.c */
 
-int pre_sev_run(struct vcpu_svm *svm, int cpu);
+int pre_sev_run(struct vcpu_svm *svm, unsigned int *asid, bool *need_flush);
 void sev_init_vmcb(struct vcpu_svm *svm);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
-- 
2.49.0.rc1.451.g8f38331e32-goog


