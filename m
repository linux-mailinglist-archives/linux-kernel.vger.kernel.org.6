Return-Path: <linux-kernel+bounces-577596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E9A71F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101BC178482
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D3255E40;
	Wed, 26 Mar 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jVnkqZES"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9B2627E3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017827; cv=none; b=N9rt+jpqgyDdEakBO4n7WtZawF8mNyE4goayAxoWuAuchBT/U8XSstgxnGbTwPbaHjaBn01FdWXYPcLt+NkNCK+HvF3KG50ZJSip/3isvWQFmvsz8O/j/ZfvmQUIdmD+bNEexvztcd5XBtc3Ql2lxX/5JscYz2g1CAMwvx/JZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017827; c=relaxed/simple;
	bh=p53mmTCgdcPvvdoDnMLPS5gz9OL2PI3yDhVWC4nQAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7YuyU0p1B+AtB/iS2F8M0IFSQTMl9cT+tWBejxdQfqYWyTXoH/21NyCBja5WQCMSgdRVGGNmKDgNmhD1d0idFZxV4fjeavaAuDnUxxdCvF7Op0S0UzEoh01URpI7a1LBxJhzFqZ+lDvX1JvJ9hwK1n+Xyk6oVgewjcrV7FTZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jVnkqZES; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743017822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TThJOcuWvmoxNh535GWTGqeFLWF7zWdthwH3YvfXf/M=;
	b=jVnkqZESpYJWwdnN5LlhOLcDSZjn3X4dziq3+YnJTCdcfREfpS81fBLuW54I0eCRbkSam5
	MH4lWPgm9csIXAujDoWgon1CqvybXO6DkFmNJrMKKRSQ/U/w7vHyE0AvYURSjftTTXNQ0b
	4/VE0Dxwn7vtgTInrwQ9DkolpckrgFs=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [RFC PATCH 08/24] KVM: SEV: Drop pre_sev_run()
Date: Wed, 26 Mar 2025 19:36:03 +0000
Message-ID: <20250326193619.3714986-9-yosry.ahmed@linux.dev>
In-Reply-To: <20250326193619.3714986-1-yosry.ahmed@linux.dev>
References: <20250326193619.3714986-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that the ASID to vCPU/VMCB tracking was moved out of pre_sev_run(),
the only remaining pieces are:
(a) Checking for valid VMSA.
(b) Assigning svm->asid.
(c) Flush the ASID if the VMCB is run on a different physical CPU.

The check in (c) is already being done in pre_svm_run(), and so is
redundant. (a) and (b) are small enough and probably do not warrant a
separate helper (and (b) will be going way soon), so open-code the
function into pre_svm_run() and remove it.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/sev.c | 28 ----------------------------
 arch/x86/kvm/svm/svm.c | 16 ++++++++++++++--
 arch/x86/kvm/svm/svm.h |  1 -
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3ef0dfdbb34d2..1742f51d4c194 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3451,34 +3451,6 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
-int pre_sev_run(struct vcpu_svm *svm, int cpu)
-{
-	struct kvm *kvm = svm->vcpu.kvm;
-	unsigned int asid = sev_get_asid(kvm);
-
-	/*
-	 * Reject KVM_RUN if userspace attempts to run the vCPU with an invalid
-	 * VMSA, e.g. if userspace forces the vCPU to be RUNNABLE after an SNP
-	 * AP Destroy event.
-	 */
-	if (sev_es_guest(kvm) && !VALID_PAGE(svm->vmcb->control.vmsa_pa))
-		return -EINVAL;
-
-	/* Assign the asid allocated with this SEV guest */
-	svm->asid = asid;
-
-	/*
-	 * Flush guest TLB if the VMCB was executed on a differet host CPU in
-	 * previous VMRUNs.
-	 */
-	if (svm->vcpu.arch.last_vmentry_cpu == cpu)
-		return 0;
-
-	vmcb_set_flush_asid(svm->vmcb);
-	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	return 0;
-}
-
 #define GHCB_SCRATCH_AREA_LIMIT		(16ULL * PAGE_SIZE)
 static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6e380411fbec..ce67112732e8c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3649,8 +3649,20 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 		svm->current_vmcb->cpu = vcpu->cpu;
         }
 
-	if (sev_guest(vcpu->kvm))
-		return pre_sev_run(svm, vcpu->cpu);
+	if (sev_guest(vcpu->kvm)) {
+		/* Assign the asid allocated with this SEV guest */
+		svm->asid = sev_get_asid(vcpu->kvm);
+
+		/*
+		 * Reject KVM_RUN if userspace attempts to run the vCPU with an invalid
+		 * VMSA, e.g. if userspace forces the vCPU to be RUNNABLE after an SNP
+		 * AP Destroy event.
+		 */
+		if (sev_es_guest(vcpu->kvm) &&
+		    !VALID_PAGE(svm->vmcb->control.vmsa_pa))
+			return -EINVAL;
+		return 0;
+	}
 
 	/* FIXME: handle wraparound of asid_generation */
 	if (svm->current_vmcb->asid_generation != sd->asid_generation)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ca38a233fa24c..3ab2a424992c1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -760,7 +760,6 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu);
 
 /* sev.c */
 
-int pre_sev_run(struct vcpu_svm *svm, int cpu);
 void sev_init_vmcb(struct vcpu_svm *svm);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
 int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
-- 
2.49.0.395.g12beb8f557-goog


