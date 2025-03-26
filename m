Return-Path: <linux-kernel+bounces-577604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF7A71F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68A4189E431
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDE266B67;
	Wed, 26 Mar 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opK+3mJE"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C5266EE6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017846; cv=none; b=ksKOGYVM0WHFYxoQyD/ypeu2DUhYsAVVkKDSly352yyFq8jn7HR0ZuYOZCFdtMhNHjxA3B3z10fzMyUPeP028wxJazE7UwDF1MzBX5KwV8ATuG4l3wNPspedOBA74+a+pZClcMiwO1gpi6AD12Fo7LgOwk/k5Z4epJ1Un+Mrom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017846; c=relaxed/simple;
	bh=3Ye1q7YXzWoF7O3oHOkWLZxhE5yQL9AFie+PfckvtmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esCpZ85aoIHrjz/EUl/gsIYlgQCOM0mLda1AtVFg+eRWkizzyG+NgVkfayiB8iDJD4nV0n6U2HPpKukme8ZOhqUJ6W1xUxdaHbxQqZgq0sH0qlbPtUVM+O8efYMdY+kS/jKTmEKIgjuZY2Up0v8HHZUbpadac/R6l+NKLSoYSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opK+3mJE; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743017843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/LsgZIA22WkXYrCYCVpKZhtRhnxjqvdS7qU44Fmjps=;
	b=opK+3mJE1ZGDfvX+MwBDXgRgp8ecNzDd5EEzTLb6Ha49rhEhfGmfOPUM1QAfTiFA3NYAhP
	k181UbE8UbS925MKFmnls0mnOvcYpD/PB8fMgIXWGVBmxkGKui/92Q1QvfQpvNw3xG1YBK
	qVVuITgMIrHocGog332HPuzWGNBXt70=
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
Subject: [RFC PATCH 16/24] KVM: x86/mmu: Allow skipping the gva flush in kvm_mmu_invalidate_addr()
Date: Wed, 26 Mar 2025 19:36:11 +0000
Message-ID: <20250326193619.3714986-17-yosry.ahmed@linux.dev>
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

Refactor a helper out of kvm_mmu_invalidate_addr() that allows skipping
the gva flush. This will be used when an invalidation is needed but the
GVA TLB translations that require invalidation are not of the current
context (e.g. when emulating INVLPGA for L1 to flush L2's translations).

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/mmu/mmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4a72ada0a7585..e2b1994f12753 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6355,15 +6355,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			     u64 addr, unsigned long roots)
+static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+				      u64 addr, unsigned long roots, bool gva_flush)
 {
 	int i;
 
 	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
 
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (mmu != &vcpu->arch.guest_mmu) {
+	if (gva_flush && mmu != &vcpu->arch.guest_mmu) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
@@ -6382,6 +6382,12 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
+
+void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			     u64 addr, unsigned long roots)
+{
+	__kvm_mmu_invalidate_addr(vcpu, mmu, addr, roots, true);
+}
 EXPORT_SYMBOL_GPL(kvm_mmu_invalidate_addr);
 
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
-- 
2.49.0.395.g12beb8f557-goog


