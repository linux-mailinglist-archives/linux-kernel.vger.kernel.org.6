Return-Path: <linux-kernel+bounces-560411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D1A603BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFFF7AE7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A51F892D;
	Thu, 13 Mar 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jEz08PGp"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AA1F76A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902963; cv=none; b=mHYDNkbVqbabC4UXsAvTuVySzpXI3fTrTLFWKCrnFB7XmV5uxGq8eEOXtY33Srw2cUgvtxNpe3cvYZBLPM1WpaAq6Zfd5amLD8WN2ym8P85dD39UPk115ELt4wGbgHBEVJoRytRiHuEXQd5YgbCHf3MHxwqCf5i8FnyVDrkaNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902963; c=relaxed/simple;
	bh=ruNjn6oY85pkiEVb/IVF7lfpeCNMLMhOSDdgsEu/JqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvnflhcyFiiglvVkDmdpnSzgiJ/QHvszrPQjlXwyfJa8hFMbK27A7pwvV2kTGWwOtMBcR/QDcavhZY/HZXIbEzFNW+Nvyc3QGXDW6Yy71rIam3iuuguGZZxi1G/duRtmobxRgab0D4hDu9JV0BT27cJuELdX+G7ktKuY0MRvKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jEz08PGp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741902959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISe8UFhYqt/XjX+dSaNqs8ihA9A8NUS4NuxdyQBmcGk=;
	b=jEz08PGpQ3m38FQK7n04+AT+KP6BbAucMht7gxSkgH/xEU7OrkH15dOc0F+ithY1mftfI2
	Y5qLrBeC6Yh6cjSFH2fO+h1A14blFGYv8YTIc/DkcBIXn1O46lPlbjLNQYRYGQy0RM4HgS
	jGeb+mtiyB6LyVsvsuuMMJ8wEU5M0eg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 3/7] KVM: SVM: Add helpers to set/clear ASID flush
Date: Thu, 13 Mar 2025 21:55:36 +0000
Message-ID: <20250313215540.4171762-4-yosry.ahmed@linux.dev>
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

Incoming changes will add more code paths that set tlb_ctl to
TLB_CONTROL_FLUSH_ASID, and will eliminate the use of
TLB_CONTROL_FLUSH_ALL_ASID except as fallback when FLUSHBYASID is not
available. Introduce set/clear helpers to set tlb_ctl to
TLB_CONTROL_FLUSH_ASID or TLB_CONTROL_DO_NOTHING.

Opportunistically move the TLB_CONTROL_* definitions to
arch/x86/kvm/svm/svm.h as they are not used outside of arch/x86/kvm/svm/.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/include/asm/svm.h |  5 -----
 arch/x86/kvm/svm/nested.c  |  2 +-
 arch/x86/kvm/svm/sev.c     |  2 +-
 arch/x86/kvm/svm/svm.c     |  4 ++--
 arch/x86/kvm/svm/svm.h     | 15 +++++++++++++++
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 9b7fa99ae9513..a97da63562eb3 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -171,11 +171,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 };
 
 
-#define TLB_CONTROL_DO_NOTHING 0
-#define TLB_CONTROL_FLUSH_ALL_ASID 1
-#define TLB_CONTROL_FLUSH_ASID 3
-#define TLB_CONTROL_FLUSH_ASID_LOCAL 7
-
 #define V_TPR_MASK 0x0f
 
 #define V_IRQ_SHIFT 8
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 834b67672d50f..3bff948bc5752 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -681,7 +681,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
-	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	svm_vmcb_clear_flush_asid(vmcb02);
 
 	/* nested_cr3.  */
 	if (nested_npt_enabled(svm))
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0bc708ee27887..b393674733969 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3479,7 +3479,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 		return 0;
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	svm_vmcb_set_flush_asid(svm->vmcb);
 	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 28a6d2c0f250f..8c90686a33f44 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4006,7 +4006,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
 	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+		svm_vmcb_set_flush_asid(svm->vmcb);
 	else
 		svm->current_vmcb->asid_generation--;
 }
@@ -4373,7 +4373,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 		svm->nested.nested_run_pending = 0;
 	}
 
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	svm_vmcb_clear_flush_asid(svm->vmcb);
 	vmcb_mark_all_clean(svm->vmcb);
 
 	/* if exit due to PF check for async PF */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d4490eaed55dd..9fd5b249b9c19 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -638,6 +638,21 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool disable);
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
 				     int trig_mode, int vec);
 
+#define TLB_CONTROL_DO_NOTHING 0
+#define TLB_CONTROL_FLUSH_ALL_ASID 1
+#define TLB_CONTROL_FLUSH_ASID 3
+#define TLB_CONTROL_FLUSH_ASID_LOCAL 7
+
+static inline void svm_vmcb_set_flush_asid(struct vmcb *vmcb)
+{
+	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+}
+
+static inline void svm_vmcb_clear_flush_asid(struct vmcb *vmcb)
+{
+	vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+}
+
 /* nested.c */
 
 #define NESTED_EXIT_HOST	0	/* Exit handled on host level */
-- 
2.49.0.rc1.451.g8f38331e32-goog


