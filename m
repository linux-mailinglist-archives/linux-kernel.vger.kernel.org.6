Return-Path: <linux-kernel+bounces-577593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F7A71F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336003BB015
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431625D551;
	Wed, 26 Mar 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FANQpr2s"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF0256C79
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017818; cv=none; b=AqvCbqqHiCKMdDROxjlEwyVgQ+xHGLxIKHiDnN5aOtwqi70MtnfUegGlS9Q3CP+IqpWecVxmXmYgjy3vzoji1y3gqeCf5HRzerFfPb417TbC6iunko2ku1uFwukPdNeQgFkEq0M+Ff/rKVOvAMtIY+7zzZOCjKuPNsOGi67CLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017818; c=relaxed/simple;
	bh=lwnpTnjH7HDR9s2KRUhqQ9hpNhZuqXNPwSRAlMUb/iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdcm9AyxS721+Eq5vJ9IzWgRLoCr/msv9TJRwf1QpFKGoB7FLQRtfYHWyIIwLzdoCwdxLhQy2PpbTg+Jzb/kRwAqhE77rDmJ+euH7R3xMxBz09Fi7GNof7CKx1plwoPGhxTzr+WxaRcR3zXUvguxvC11oaUHuyzW2s9mlpXWIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FANQpr2s; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743017815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtnw3c6HR+DaeYYq7dwPaYRs+yENUTrzqKSlzXknNFc=;
	b=FANQpr2szsiJtnqxZi13oEmR5wTGHRfvLGgIgR4xiDpn/kp+/Lkjaj2kjpO0K+pRMA3gSk
	UF/n2wo9/jbECS0fP5y7b9drd3p+adZWSmARKbm0S4M58HApWDOaGoufVVnMGMRFoP1FaE
	eR1FUwKZadA0unhODSPiw+4glRY7hqs=
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
Subject: [RFC PATCH 05/24] KVM: SVM: Flush the ASID when running on a new CPU
Date: Wed, 26 Mar 2025 19:36:00 +0000
Message-ID: <20250326193619.3714986-6-yosry.ahmed@linux.dev>
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

Currently, when a vCPU is migrated to a new physical CPU, the ASID
generation is reset to trigger allocating a new ASID. In preparation for
using a static ASID per VM, just flush the ASID in this case (falling
back to flushing everything if FLUSBYASID is not available).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5f71b125010d9..18bfc3d3f9ba1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3626,12 +3626,12 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
-	 * If the previous vmrun of the vmcb occurred on a different physical
-	 * cpu, then mark the vmcb dirty and assign a new asid.  Hardware's
-	 * vmcb clean bits are per logical CPU, as are KVM's asid assignments.
+	 * If the previous VMRUN of the VMCB occurred on a different physical
+	 * CPU, then mark the VMCB dirty and flush the ASID.  Hardware's
+	 * VMCB clean bits are per logical CPU, as are KVM's ASID assignments.
 	 */
 	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
-		svm->current_vmcb->asid_generation = 0;
+		vmcb_set_flush_asid(svm->vmcb);
 		vmcb_mark_all_dirty(svm->vmcb);
 		svm->current_vmcb->cpu = vcpu->cpu;
         }
-- 
2.49.0.395.g12beb8f557-goog


