Return-Path: <linux-kernel+bounces-577605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17AEA71F67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1F73BF7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D633F2673A1;
	Wed, 26 Mar 2025 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="StOcjs8Q"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AC266F1B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017849; cv=none; b=eDH1+xjNSEk1AVpVGW/ZTQ24wlWUUJwTLufJ2HFbB7bGUcdrYK5dGTa3pIzQeSSgr0nW3UHBQo1UqpzNBAiBrsQfDeKFprQYqUSi6HFeDe0yxjd+gHXYe8LHdCWuG7lOVp0+2i0oEF0i3zhVxogV4UoDkvC4YYZ5dQrG8hoZB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017849; c=relaxed/simple;
	bh=loAUSq0Aq87olV/rGnT8LR/81Gpuj4/ZkhLvLAh+RMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7soHL3HIAiv+yS5NWSb8B/aftbmQziMj9+2LqmguF/FsP3G1VSMam8+0rD629975SzbFm6t7r9pTiCTrm1IeU9jT429x/T24XUxyJROn4FRW+8X1HJpzj/4DXaqsyq+zLitZRjLWmbKcqsoCJ+wfzAkGtdTkBlVg3Jgs9BFd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=StOcjs8Q; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743017845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtfzDuEN4GEuy4ZNyh+58E8l9WpCgtIrX1y6M8KtoeE=;
	b=StOcjs8Q3VKA37jffPg31SfE3GDTKGPe1ycDSwv1dyFxjECD5bSrPQmIniYPtyAmzxcWjz
	7IhRb4J5Dih85rdnW7dPkbHVz/e7/uvB1p0WuKJnt+hkApJ/wZ8XoHQsQcQ/tFySWIZkNM
	kfQ60onkTb2usnIbFdx2b4zcayC8bxU=
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
Subject: [RFC PATCH 17/24] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
Date: Wed, 26 Mar 2025 19:36:12 +0000
Message-ID: <20250326193619.3714986-18-yosry.ahmed@linux.dev>
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

KVM_REQ_TLB_FLUSH is used to flush all TLB entries for all contexts
(e.g. in kvm_flush_remote_tlbs()). Flush both L1 and L2 ASIDs in
svm_flush_tlb_all() to handle it appropriately.

This is currently not required as nested transitions do unconditional
TLB flushes, but this is a step toward eliminating that.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c |  1 -
 arch/x86/kvm/svm/svm.c    | 10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c336ab63c6da3..56a4ff480bb3d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -491,7 +491,6 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
 	 * things to fix before this can be conditional:
 	 *
-	 *  - Flush TLBs for both L1 and L2 remote TLB flush
 	 *  - Honor L1's request to flush an ASID on nested VMRUN
 	 *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
 	 *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fb6b9f88a1504..4cad1085936bb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4064,14 +4064,8 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
 		hv_flush_remote_tlbs(vcpu->kvm);
 
-	/*
-	 * Flush only the current ASID even if the TLB flush was invoked via
-	 * kvm_flush_remote_tlbs().  Although flushing remote TLBs requires all
-	 * ASIDs to be flushed, KVM uses a single ASID for L1 and L2, and
-	 * unconditionally does a TLB flush on both nested VM-Enter and nested
-	 * VM-Exit (via kvm_mmu_reset_context()).
-	 */
-	svm_flush_tlb_asid(vcpu, is_guest_mode(vcpu));
+	svm_flush_tlb_asid(vcpu, false);
+	svm_flush_tlb_asid(vcpu, true);
 }
 
 static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
-- 
2.49.0.395.g12beb8f557-goog


