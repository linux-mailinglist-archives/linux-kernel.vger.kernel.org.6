Return-Path: <linux-kernel+bounces-577617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD14A71F74
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC117C472
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B3259C88;
	Wed, 26 Mar 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQxf6/LZ"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBA2571D8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018309; cv=none; b=qzM03RTphfW+Dq1xXhO7oms6zHyhf/q6ZmNS10o1uIHQV5NhXlTaqkuv6w/tNcAf0LPbT40SRpi+O/JPP77v05mhNP16wf/gBYzgSEjScDip8Fj9UI3c9hP47vpYVuDI/si+2xGt3mb0vGDYt0OT4VCgL2l06+ZLxLIzXN8l69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018309; c=relaxed/simple;
	bh=p3QwBU+jBVDcTlSsMqq7CihkMh5Nzv5/+k/utju49uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKI+simoLSUfsJUJSVSk6D1YAzZhaNaMgHm5FZptebT83goeHGg4B8p1YOZos46T4VzdkUbG8aaYmiGXyGTghxV1x+ktDVOjL6f31DzK/9Iss3o29vlKcrMXBaGfu7dqhL9SUY8pkLPqPGYOMdnlqh2vmPUpFNrIaXVgR4Dq18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQxf6/LZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743018295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUdDAUOASl+dv9HtsY1A+uMvUg3QBNYQ0WgEzzzA9VU=;
	b=qQxf6/LZIhhOHf7RdxU5oF3iUu63ZVB4yWc04hzLaQtQup9nLw5sJmZTyAeeZiPaUgElFY
	R1Zxu5jyECSHC8uQuubeWtK5a8bT83agBGqrSQeT+B1E2C5mha8jIhpw+qaKopHI1Jm+HB
	wxdGWRG4a+TusQqr1hFYQGJ4BUA8MNg=
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
Subject: [RFC PATCH 20/24] KVM: nSVM: Do not reset TLB_CONTROL in VMCB02 on nested entry
Date: Wed, 26 Mar 2025 19:44:19 +0000
Message-ID: <20250326194423.3717668-1-yosry.ahmed@linux.dev>
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

TLB_CONTROL is reset to TLB_CONTROL_DO_NOTHING on nested transitions to
L2 in nested_vmcb02_prepare_control(). This is unnecessary because:
- TLB_CONTROL is set in vcpu_enter_guest() if needed when servicing a
  TLB flush request (by svm_flush_tlb_asid()).
- TLB_CONTROL is reset to TLB_CONTROL_DO_NOTHING after the guest is run
  in svm_cpu_run().

Hence, at the point where nested_vmcb02_prepare_control() is called,
TLB_CONTROL should have already be set to TLB_CONTROL_DO_NOTHING by
svm_cpu_run() after L1 runs.

There is a TODO in nested_svm_transition_tlb_flush() about this reset
crushing pending TLB flushes. Remove it, as the reset is not really
crushing anything as explained above.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ca8db246ac050..544913461693c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -511,12 +511,7 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 		svm->nested.last_asid = svm->nested.ctl.asid;
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
-	/*
-	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
-	 * things to fix before this can be conditional:
-	 *
-	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
-	 */
+	/* TODO: optimize unconditional TLB flush/MMU sync */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
@@ -710,9 +705,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb02->control.asid = svm_nested_asid(vcpu->kvm);
 
-	/* Also overwritten later if necessary.  */
-	vmcb_clr_flush_asid(vmcb02);
-
 	/* nested_cr3.  */
 	if (nested_npt_enabled(svm))
 		nested_svm_init_mmu_context(vcpu);
-- 
2.49.0.395.g12beb8f557-goog


