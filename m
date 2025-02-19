Return-Path: <linux-kernel+bounces-522584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4FA3CC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4379D3BAACE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57F625B674;
	Wed, 19 Feb 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmEHxQaT"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952AD25A652
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002933; cv=none; b=o/AhaZrNokKggrUMblzED1VXjUM8vDQcX3af9U83XZHbo59+q/4MwW/4UPpoD09BVfZwnefAv4cCvgn4CHoPIeShUH26PKdfgjyL6sQNp8umNvtqwHNImLeuzgW8+T4dGGdwOPKrNY5+ecb8FfmWnEGtxqTuk6X+lOxHSzutZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002933; c=relaxed/simple;
	bh=Tvvlv0fBss0n/7WshdYff71YrhqCSuM9kQf9UHtSJaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTw4JKWlu3uil85k/cBqyUGCoS68XikY2uDX2Xy2ZClwdBem/FZeTIE4IcfDwkqK8hvvJtS/I2+082JwZXithjO/N9wCIwLBgDYlp9tK1O4pQUkfpLIfpFYwj1e1/vKwIwSshXp5APQZfWFoxmjerPApXBSFuIbeRll8ABzBg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmEHxQaT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740002929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0chv4eAnCkbf8CES9xeSsfOnjF0UDfASNc6X5dzU5dU=;
	b=PmEHxQaTgS8aqPGjUYy9s3MztNDeg5CrNWu8Ek5B/MD4JkHk+tY0kjQeneYzvPbveoEPTH
	ykpVmSx1U0AOmPwZuvBKgdMTKzA2lSQLhtUyi53sq7q0Su9YLRG1MvgGWA8xJyyMl1tEPp
	VezyzMF0M+nS10G+S0cQroxwU/2HAB8=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] x86/bugs: Use a static branch to guard IBPB on vCPU load
Date: Wed, 19 Feb 2025 22:08:24 +0000
Message-ID: <20250219220826.2453186-5-yosry.ahmed@linux.dev>
In-Reply-To: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Instead of using X86_FEATURE_USE_IBPB to guard the IBPB execution in the
vCPU load path, introduce a static branch, similar to switch_mm_*_ibpb.

This makes it obvious in spectre_v2_user_select_mitigation() what
exactly is being toggled, instead of the unclear X86_FEATURE_USE_IBPB
(which will be shortly removed). It also provides more fine-grained
control, making it simpler to change/add paths that control the IBPB in
the vCPU load path without affecting other IBPBs.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/include/asm/nospec-branch.h | 2 ++
 arch/x86/kernel/cpu/bugs.c           | 5 +++++
 arch/x86/kvm/svm/svm.c               | 2 +-
 arch/x86/kvm/vmx/vmx.c               | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7cbb76a2434b9..a22836c5fb338 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -552,6 +552,8 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
+DECLARE_STATIC_KEY_FALSE(vcpu_load_ibpb);
+
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a5d0998d76049..685a6f97fea8f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -113,6 +113,10 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
+/* Control IBPB on vCPU load */
+DEFINE_STATIC_KEY_FALSE(vcpu_load_ibpb);
+EXPORT_SYMBOL_GPL(vcpu_load_ibpb);
+
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
@@ -1365,6 +1369,7 @@ spectre_v2_user_select_mitigation(void)
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
+		static_branch_enable(&vcpu_load_ibpb);
 
 		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a4ba5b4e3d682..043d56d276ad6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1560,7 +1560,7 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		sd->current_vmcb = svm->vmcb;
 
 		if (!cpu_feature_enabled(X86_FEATURE_IBPB_ON_VMEXIT) &&
-		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		    static_branch_likely(&vcpu_load_ibpb))
 			indirect_branch_prediction_barrier();
 	}
 	if (kvm_vcpu_apicv_active(vcpu))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 729a8ee24037b..7f950d0b50757 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1478,7 +1478,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 		 * may switch the active VMCS multiple times).
 		 */
 		if (!buddy || WARN_ON_ONCE(buddy->vmcs != prev))
-			if (cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+			if (static_branch_likely(&vcpu_load_ibpb))
 				indirect_branch_prediction_barrier();
 	}
 
-- 
2.48.1.601.g30ceb7b040-goog


