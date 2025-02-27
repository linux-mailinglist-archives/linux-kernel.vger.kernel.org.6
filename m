Return-Path: <linux-kernel+bounces-535341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018DA4717D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B87416766D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81223233D97;
	Thu, 27 Feb 2025 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dleod8m2"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34D23313E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619671; cv=none; b=sKUyW4NWnX9dUFqSNaauoKbAlI5YgkJZEZGDB70PuKJn+298e9M1oJQ3SXdoqRP6Qa24rpngr4iXV1JKu114zAUA40FjX4SafInfvDBmO8zUWrzL070G+NCrRRzsyMf8vOhoE7T1aL5Rvg7Bnc5LmA0K3oMaWQxdPb1HSWg3Nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619671; c=relaxed/simple;
	bh=QUgGWqklPPosGsyZ3Z7EXMRiIvGCTPkrFA3wnDmEsLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkwHr8jYM6mpNNDwElVPRiqjd+uuT/hR/RPNdVHEIXia7nZFAaKKU/Pn/9/TJT47wPipalJdSNU7xQloZo5E2f3krlmG3txMi8txrt6Oeos2zQMCBYIZUM/+qxnbtzDxrRLaG6IaYJ+ccY43xSqQpFrd6p/iopNmpx8+Gx6tx4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dleod8m2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740619667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty8akjPjzreCygqHdAJtAp6Bdr+8wKY9U5PWbWuBGmQ=;
	b=dleod8m2cczArYaABu+5pJLQHAUA7zeXWbXUbqEKn21Gpi7il9G8M3i/H8pv/+AuKRz1WU
	4myNSwPgg9QdKVkHpZ475BnX+7fmNAHslL/j2untrpYpNPJeqnpfPXlKndh2k8QM68Ya0P
	t6JFiFUAlTTgyPueDjIfd/HClVK5DjY=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: x86@kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 6/6] x86/bugs: Remove X86_FEATURE_USE_IBPB
Date: Thu, 27 Feb 2025 01:27:12 +0000
Message-ID: <20250227012712.3193063-7-yosry.ahmed@linux.dev>
In-Reply-To: <20250227012712.3193063-1-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

X86_FEATURE_USE_IBPB was introduced in commit 2961298efe1e
("x86/cpufeatures: Clean up Spectre v2 related CPUID flags") to have
separate flags for when the CPU supports IBPB (i.e. X86_FEATURE_IBPB)
and when an IBPB is actually used to mitigate Spectre v2.

Ever since then, the uses of IBPB expanded. The name became confusing
because it does not control all IBPB executions in the kernel.
Furthermore, because its name is generic and it's buried within
indirect_branch_prediction_barrier(), it's easy to use it not knowing
that it is specific to Spectre v2.

X86_FEATURE_USE_IBPB is no longer needed because all the IBPB executions
it used to control are now controlled through other means (e.g.
switch_mm_*_ibpb static branches). Remove the unused feature bit.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h       | 1 -
 arch/x86/kernel/cpu/bugs.c               | 1 -
 tools/arch/x86/include/asm/cpufeatures.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 43653f2704c93..c8701abb77524 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -210,7 +210,6 @@
 #define X86_FEATURE_MBA			( 7*32+18) /* "mba" Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
 #define X86_FEATURE_PERFMON_V2		( 7*32+20) /* "perfmon_v2" AMD Performance Monitoring Version 2 */
-#define X86_FEATURE_USE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation via LS_CFG MSR */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7f904d0b0b04f..5397d0afac089 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1368,7 +1368,6 @@ spectre_v2_user_select_mitigation(void)
 
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		static_branch_enable(&switch_vcpu_ibpb);
 
 		spectre_v2_user_ibpb = mode;
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 17b6590748c00..ec9911379c617 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -210,7 +210,6 @@
 #define X86_FEATURE_MBA			( 7*32+18) /* "mba" Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
 #define X86_FEATURE_PERFMON_V2		( 7*32+20) /* "perfmon_v2" AMD Performance Monitoring Version 2 */
-#define X86_FEATURE_USE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Speculative Store Bypass. */
 #define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation via LS_CFG MSR */
-- 
2.48.1.658.g4767266eb4-goog


