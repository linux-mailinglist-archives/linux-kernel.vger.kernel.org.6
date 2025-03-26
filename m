Return-Path: <linux-kernel+bounces-577600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A01A71F55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F0A1895BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049426563D;
	Wed, 26 Mar 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="plC0CXSP"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FA264FA2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017836; cv=none; b=ua7Q6KWLPBRJP98OlB8Vay+FU+uzJFRndgrBh2emUkJEUumBy2Lf6LtB8jQergOh54Lm7qS4BJaX5DJ6sOATnCgKw0X/MbNzNv4L/mCXFn/6cizFMc5OnPUT9GEGrAUTSiduaMhp8825DMCEfIgW0f3MQTp6kvLiaeqfDxm3gK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017836; c=relaxed/simple;
	bh=SNlGfOlmT0Nbk2eVp5pfC34DGqtLN2buTW2ZGWeYC90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdKtLJXLRvj4lfLkKpT249SkQC2RQ7RRjl+1cilyi/psf8mSLKdM2ods+wFLzJ44mHAn6/3mz3vvv2atR1CoVt7zMpz7y4rdkD6pguTGRdbPoouEXH+dhG+q6i535yrLdrsbX/Kti6wfXG1NwNHSEn3nDC9yLQsfrQNir8kipMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=plC0CXSP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743017833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3ZtK3C7hcG8VBa+3J86AOH6HCNRDt3Nw0pXDBnhw+c=;
	b=plC0CXSPWL/z9yytx7ucGuf3qjy5bZxk+2QnQxH0J5E/wgWAsLPO1V+tvbI8VP75HgCado
	XDrI4U2Hbn5lr0DLOQPzI8wU/zBhACW3NuaVcJumoUjsb2juXCOe7QASeY72diQkRFqrX8
	kmldVI1/NoqGwDcLsFNwUPssB68C5Q4=
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
Subject: [RFC PATCH 12/24] KVM: x86: hyper-v: Pass is_guest_mode to kvm_hv_vcpu_purge_flush_tlb()
Date: Wed, 26 Mar 2025 19:36:07 +0000
Message-ID: <20250326193619.3714986-13-yosry.ahmed@linux.dev>
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

Instead of calling is_guest_mode() inside kvm_hv_vcpu_purge_flush_tlb()
pass the value from the caller. Future changes will pass different
values than is_guest_mode(vcpu).

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/hyperv.h  | 8 +++++---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/x86.c     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 913bfc96959cb..be715deaeb003 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -203,14 +203,15 @@ static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struc
 	return &hv_vcpu->tlb_flush_fifo[i];
 }
 
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
+static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu,
+					       bool is_guest_mode)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
 
 	if (!to_hv_vcpu(vcpu) || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
-	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
+	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode);
 
 	kfifo_reset_out(&tlb_flush_fifo->entries);
 }
@@ -285,7 +286,8 @@ static inline int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	return HV_STATUS_ACCESS_DENIED;
 }
-static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu) {}
+static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu,
+					       bool is_guest_mode) {}
 static inline bool kvm_hv_synic_has_vector(struct kvm_vcpu *vcpu, int vector)
 {
 	return false;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e664d8428c792..865c5ce4fa473 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4025,7 +4025,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
 	 * entries, and thus is a superset of Hyper-V's fine grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_vcpu_purge_flush_tlb(vcpu, is_guest_mode(vcpu));
 
 	/*
 	 * Flush only the current ASID even if the TLB flush was invoked via
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 182f18ebc62f3..469a8e5526902 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3615,7 +3615,7 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	 * Flushing all "guest" TLB is always a superset of Hyper-V's fine
 	 * grained flushing.
 	 */
-	kvm_hv_vcpu_purge_flush_tlb(vcpu);
+	kvm_hv_vcpu_purge_flush_tlb(vcpu, is_guest_mode(vcpu));
 }
 
 
-- 
2.49.0.395.g12beb8f557-goog


