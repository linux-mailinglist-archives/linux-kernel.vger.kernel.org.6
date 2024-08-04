Return-Path: <linux-kernel+bounces-273859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA67946EEF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6997F282B6A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA113D8A8;
	Sun,  4 Aug 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3gZt7hb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCOoIC96"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43513AA2E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776578; cv=none; b=AOrSD8hi+pt3gONeVBHjde53kGAdYcU6XEBdPpLzeYnmqdBGo3dCZh9CrI2MmEDE7fnKR/XKUZrd5CG4MzC/Annao0xVzLMPjzrAYbsjQw/CFSoCprN7RWS3n+wZuSDfbJTjqX7/iwJvP1S89muTh54qdVqrEsMRLpGpcgl4MU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776578; c=relaxed/simple;
	bh=gHG10I8zKreTAcB2e/uRgGTxbI5Wrnxr8fxXFbzLO/o=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=P2TfH8q0S2Uao8SqwgG3Zqsi1m3YmwcTO9zHlC6Xe/XtKdVXqL8V3xDknKqhsbVYOFzyDQ1Gs3AD+HBj5cTPC1dp42bqEBRi3G/yXWQ5vPgQAjp9ur5irIs/b5dhPbQRdXoe3ASNGvSfUSadbQ7LE9A1d1NRe/9WuNfgiHl+Tv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3gZt7hb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCOoIC96; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722776575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=+ETfA6dh8/hzq9D7GebayTQQrsptcC897WcO54Z3/vU=;
	b=u3gZt7hb/3mfUiWDtJxCtnJxTdDjtdXZLe4dWOY3MUX3qGhwD2SgsPS7lDPA9P/tRnELfN
	Isq/KnKxj2Cd8Aae+3NrEZAZzNp7sZOjLYITbH36VeCZP9/KQ5rjBe3pmuf3fIEX06vJhk
	9LaViMlAEFVbnNrPZXP0SjnNp/Fe6e8cJp0Mt7wNCBSKP0jMIKPR6s+bQUo00e2v5ftuU2
	SOQqlbpwBZq++eeJlmlWCjMuiiYZrbAk8Av15SveZafX9jmj5UjN2RyTKL9NBoXnTvsS2m
	xcw1D9eBuVX8Vgie4ayw1dOfG+Cvz7UFfaCRuxaGIH55dxiuopgOV5isV9qtrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722776575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=+ETfA6dh8/hzq9D7GebayTQQrsptcC897WcO54Z3/vU=;
	b=CCOoIC96asomUQMr4gpNNzRnMIhyfSf+4aQHD5QAI6C0jM/v0uORRD3snDky1CHx68JfDa
	rkAojOhPHGvsTKCw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v6.11-rc2
References: <172277654174.866296.10517632866315552419.tglx@xen13>
Message-ID: <172277654480.866296.3637204430767314679.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  4 Aug 2024 15:02:55 +0200 (CEST)

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024=
-08-04

up to:  f73cefa3b72e: perf/x86: Fix smp_processor_id()-in-preemptible warnings


perf/x86 subsystem fixes:

     - Move the smp_processor_id() invocation back into the non-preemtible
       region, so that the result is valid to use.

     - Add the missing package C2 residency counters for Sierra Forest CPUs
       to make the newly added support actually useful

Thanks,

	tglx

------------------>
Li Huafei (1):
      perf/x86: Fix smp_processor_id()-in-preemptible warnings

Zhenyu Wang (1):
      perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest


 arch/x86/events/core.c         | 22 ++++++++++++----------
 arch/x86/events/intel/cstate.c |  5 +++--
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 12f2a0c14d33..be01823b1bb4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1520,20 +1520,23 @@ static void x86_pmu_start(struct perf_event *event, i=
nt flags)
 void perf_event_print_debug(void)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
+	unsigned long *cntr_mask, *fixed_cntr_mask;
+	struct event_constraint *pebs_constraints;
+	struct cpu_hw_events *cpuc;
 	u64 pebs, debugctl;
-	int cpu =3D smp_processor_id();
-	struct cpu_hw_events *cpuc =3D &per_cpu(cpu_hw_events, cpu);
-	unsigned long *cntr_mask =3D hybrid(cpuc->pmu, cntr_mask);
-	unsigned long *fixed_cntr_mask =3D hybrid(cpuc->pmu, fixed_cntr_mask);
-	struct event_constraint *pebs_constraints =3D hybrid(cpuc->pmu, pebs_constr=
aints);
-	unsigned long flags;
-	int idx;
+	int cpu, idx;
+
+	guard(irqsave)();
+
+	cpu =3D smp_processor_id();
+	cpuc =3D &per_cpu(cpu_hw_events, cpu);
+	cntr_mask =3D hybrid(cpuc->pmu, cntr_mask);
+	fixed_cntr_mask =3D hybrid(cpuc->pmu, fixed_cntr_mask);
+	pebs_constraints =3D hybrid(cpuc->pmu, pebs_constraints);
=20
 	if (!*(u64 *)cntr_mask)
 		return;
=20
-	local_irq_save(flags);
-
 	if (x86_pmu.version >=3D 2) {
 		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
@@ -1577,7 +1580,6 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
 	}
-	local_irq_restore(flags);
 }
=20
 void x86_pmu_stop(struct perf_event *event, int flags)
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index be58cfb012dd..9f116dfc4728 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -64,7 +64,7 @@
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL
+ *						RPL,SPR,MTL,ARL,LNL,SRF
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -693,7 +693,8 @@ static const struct cstate_model srf_cstates __initconst =
=3D {
 	.core_events		=3D BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
=20
-	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
=20
 	.module_events		=3D BIT(PERF_CSTATE_MODULE_C6_RES),
 };


