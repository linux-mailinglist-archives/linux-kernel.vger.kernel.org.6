Return-Path: <linux-kernel+bounces-577609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D255EA71F62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D1B17B632
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4311255E20;
	Wed, 26 Mar 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+4K+pVS"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CA255E27
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018110; cv=none; b=dmaQUE186LCdjNv2nDCdNoRh1utmBTT67XHIMfRY7Ntabc70k4Xf2VWSF/uRfQ79DNVEURA6HwAq4UtAYPLsaz4rBhdB2ljigdT0FHTgXBwkK6L3FYIhD5XmsFu6Is6RBSJxOFKbboM87lsbDi68cZJYNmkvPU5ouK+wjuJ84v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018110; c=relaxed/simple;
	bh=26c7vE29FalJEZbJzRa4JFb2D258/+DcHVHnVQSaMMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRNTQjQuYLAdtlPPCIHFpohXAoz7yqDQUNOCEmbax3nfzHpQ2A8KbXrP/j1GHqUqprgGo3IeqQd5tm/BvwUPY3oG53hvTO476p9CnJVwasfU8J9+h7Y7bn7u0oKdyvr8Vz+NmEzbM/imqEAVfGXCPBy/tfmXA1Xxz2Im8jD+rss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+4K+pVS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743018094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nStgpckOCyIVJLMtLPn1APYAP4kRt8zxexxAPbNJmS0=;
	b=S+4K+pVSVIe9fvzRh6nrlsJm8GTn1Yd+xsll8RdogRg6edXu0bBkf9x/wudfYYJ8tgrHJh
	4kqn/TqY9KQLJwkL+TQBK1otDf3d9P6yiOGSLqzUVxpE/Q0cYwNqoHIKv8X0jna2izBbJ4
	hXWd+9PHjDW9Cg3anoTxYxSdo9cRQ+E=
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
Subject: [RFC PATCH 18/24] KVM: nSVM: Handle nested TLB flush requests through TLB_CONTROL
Date: Wed, 26 Mar 2025 19:41:14 +0000
Message-ID: <20250326194114.3716618-1-yosry.ahmed@linux.dev>
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

Handle L1's requests to flush L2's TLB through the TLB_CONTROL field of
VMCB12. This is currently redundant because a full flush is executed on
every nested transition, but is a step towards removing that.

TLB_CONTROL_FLUSH_ALL_ASID flushes all ASIDs from L1's perspective,
including its own, so do a guest TLB flush on both transitions. Never
propagate TLB_CONTROL_FLUSH_ALL_ASID from the guest to the actual VMCB,
as this gives the guest the power to flush the entire physical TLB
(including translations for the host and other VMs).

For ASID flushes, the TLB flush is only done when entering L2. The
nested NPT MMU is also sync'd because TLB_CONTROL also flushes NPT
guest-physical mappings.

All TLB_CONTROL values can be handled by KVM regardless of FLUSHBYASID
support on the underlying CPU, so keep advertising FLUSHBYASID to the
guest unconditionally.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 31 ++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c    |  5 ++---
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 56a4ff480bb3d..ffe01c2ae7db5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -484,19 +484,35 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 
 static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	/*
+	 * If L1 requested a TLB flush for L2, flush L2's TLB on nested entry
+	 * and sync the nested NPT MMU, as TLB_CONTROL also flushes NPT
+	 * guest-physical mappings. We technically only need to flush guest_mode
+	 * page tables.
+	 *
+	 * If L1 requested a full TLB flush for all ASIDs, L1's own ASID is also
+	 * flushed in nested_svm_exit_tlb_flush() before running L1.
+	 *
+	 * Note that TLB_CONTROL_FLUSH_ASID_LOCAL is handled exactly like
+	 * TLB_CONTROL_FLUSH_ASID. We can technically flush less TLB entries,
+	 * but this would require significantly more complexity.
+	 */
+	if (svm->nested.ctl.tlb_ctl != TLB_CONTROL_DO_NOTHING) {
+		if (nested_npt_enabled(svm))
+			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+	}
+
 	/*
 	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
 	 * things to fix before this can be conditional:
 	 *
-	 *  - Honor L1's request to flush an ASID on nested VMRUN
-	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 *
-	 * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
-	 *     NPT guest-physical mappings on VMRUN.
 	 */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
@@ -505,8 +521,13 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 /* See nested_svm_entry_tlb_flush() */
 static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
 
+	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4cad1085936bb..3e33ac876eb32 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5332,9 +5332,8 @@ static __init void svm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN);
 
 		/*
-		 * KVM currently flushes TLBs on *every* nested SVM transition,
-		 * and so for all intents and purposes KVM supports flushing by
-		 * ASID, i.e. KVM is guaranteed to honor every L1 ASID flush.
+		 * KVM handles all TLB_CONTROL values set by L1, even if the
+		 * underlying CPU does not. See nested_svm_entry_tlb_flush().
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
-- 
2.49.0.395.g12beb8f557-goog


