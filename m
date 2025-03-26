Return-Path: <linux-kernel+bounces-577602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD5A71F61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E16F3BE5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C2266B52;
	Wed, 26 Mar 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DXTin4Ml"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26791257ACF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017842; cv=none; b=t2skSpWRUHkyYfububBWmrK82FDsZ8l8Pw9+Hn9Ni7dpjI9iO7ZbC9qO75EmAZr0qcgIbdAP/WIATffQPJ1PsPkKVjxHPsWmsfm6/rqrBuXfBIl4dsKIfn4yNnqnaSHxxSqKItMRWiIkcSlUae+f7F0jkqXOZzkJjUwbAKDujvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017842; c=relaxed/simple;
	bh=N1SR/O0juec+LA4AGNQfGdvk7sgOosLJLsnUdg5ghds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BceQU4PTGfnujK9Wy97VYaIe/2sMpYJ9f4cqjTIXs33bRmZs42A56Hb4UM7kzoVVZT/LpsUuvATaOd5Uzeju80Aa+3dMj6hiEIHbQzfVuyc9Pc5p0G52hzyZt4FgnnQtivSMnuQ2xU7Q4eFgSDiuBpJSJmWTQci7iiNBUMpj/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DXTin4Ml; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743017838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoNp7kmVdwK8yTlNXCvBPTSHQNO1V8a1BcDnEEpH62c=;
	b=DXTin4Mlo4kKMoOwu95WDpnMFCVeKvvwnPwlTRAncfCc/9aG43z+1teuljhDTwV2uaDp05
	3M1rfWv+8DSgPji4M2GceN/7IvVni7LWf/AvmlLTNQppi9UyZcH50PNTm0t/3/bWjyDR26
	r/b9fNC8ZQZlq6IUx7k73eWdGI8WLhk=
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
Subject: [RFC PATCH 14/24] KVM: nSVM: Split nested_svm_transition_tlb_flush() into entry/exit fns
Date: Wed, 26 Mar 2025 19:36:09 +0000
Message-ID: <20250326193619.3714986-15-yosry.ahmed@linux.dev>
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

The handling for the entry and exit TLB flushes will diverge
significantly in the following changes. Instead of adding an 'is_vmenter'
argument like nested_vmx_transition_tlb_flush(), just split the function
into two variants for 'entry' and 'exit'.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 75223869aa8c6..c336ab63c6da3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -482,7 +482,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
 	vmcb12->control.exit_int_info = exit_int_info;
 }
 
-static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
+static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	/* Handle pending Hyper-V TLB flush requests */
 	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
@@ -503,6 +503,15 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
+/* See nested_svm_entry_tlb_flush() */
+static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
+{
+	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
+
+	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+}
+
 /*
  * Load guest's/host's cr3 on nested vmentry or vmexit. @nested_npt is true
  * if we are emulating VM-Entry into a guest with NPT enabled.
@@ -645,7 +654,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	u32 pause_count12;
 	u32 pause_thresh12;
 
-	nested_svm_transition_tlb_flush(vcpu);
+	nested_svm_entry_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(vcpu);
@@ -1130,7 +1139,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	kvm_vcpu_unmap(vcpu, &map);
 
-	nested_svm_transition_tlb_flush(vcpu);
+	nested_svm_exit_tlb_flush(vcpu);
 
 	nested_svm_uninit_mmu_context(vcpu);
 
-- 
2.49.0.395.g12beb8f557-goog


