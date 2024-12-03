Return-Path: <linux-kernel+bounces-429850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3E9E27A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5561618D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276D1F8AD4;
	Tue,  3 Dec 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p3dMMQkd"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427C2BD1D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243778; cv=none; b=S1oA8Qe/r0jtx41MtyiqBvz5GP4SDDVvgSpNv1mpUGiaAfRYCCBGlQMjSDZpUCneDSGZd/rUUOrQg6B99MLb/MtuWwSnhtoeERsMGrwgSkmPxjCke10IrjC3dn7dpZL6eWufZunXcJw5DIftJK40l+n7xKgPb+dzKdrHg9iwAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243778; c=relaxed/simple;
	bh=tmo9AAA6kt3XzX9tU+vZGSa3qOh7lMibgecPzC2J+EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RgDllqJvz2wvm6h8yHqRk18DyvtxPK2ygZMDxFRHBGRCZVgvF8PToxoRNW9iodpZvoEWY3Bj6s0jfx4s/cMU8i95P5F7sU8dkkH9okQ8yfPBVKIIFIAOE4kR4fCmzHPHB3MM/GqNwQX+n7KabU3MQJh2Z+DZYxaaplpxDQWmcao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p3dMMQkd; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733243775;
	bh=tmo9AAA6kt3XzX9tU+vZGSa3qOh7lMibgecPzC2J+EE=;
	h=From:To:Cc:Subject:Date:From;
	b=p3dMMQkdsss9ny2ZTrzW815KyzQMqerq+5slZOnznX7vlWqbUF0877Yw/R0rrZuxV
	 mswNZZc8lZk2gfLAfE5b8IdC6JgfsOEEhuLaTcsHYfWtRq/Lyij27mBqlRSIOKgYr4
	 yi0IHyfasRzbIz4aY+zkRxwXHGVU2mkB8QwsocBJfTKphUqDbhCqiMyk9nl2PdppsX
	 RB8fEIyknlS0l8PEu1d9y/J2BYo23cdM50BOQ3p+piN6SEFem5Iy+6SElmY8Ud8aCt
	 pWDtcbGNI1gHUa2XR0vhUMsdhXrXMy+bOxQZUe6EaexhXtOULThRF0EBRhsewmyE7e
	 PD8goAJDw/RuA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y2mW33sGWzTbr;
	Tue,  3 Dec 2024 11:36:15 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>,
	x86@kernel.org
Subject: [RFC PATCH] smp: Evaluate local cond_func() before IPI side-effects
Date: Tue,  3 Dec 2024 11:35:58 -0500
Message-Id: <20241203163558.3455535-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In smp_call_function_many_cond(), the local cond_func() is evaluated
after triggering the remote CPU IPIs.

If cond_func() depends on loading shared state updated by other CPU's
IPI handlers func(), then triggering execution of remote CPUs IPI before
evaluating cond_func() may have unexpected consequences.

One example scenario is evaluating a jiffies delay in cond_func(), which
is updated by func() in the IPI handlers. This situation can prevent
execution of periodic cleanup code on the local CPU.

Link: https://lore.kernel.org/lkml/20241202202213.26a79ed6@fangorn/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: x86@kernel.org
---
 kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 27dc31a146a3..f104c8e83fc4 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -815,7 +815,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	WARN_ON_ONCE(!in_task());
 
 	/* Check if we need local execution. */
-	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
+	    (!cond_func || cond_func(this_cpu, info)))
 		run_local = true;
 
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
@@ -868,7 +869,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
-	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
+	if (run_local) {
 		unsigned long flags;
 
 		local_irq_save(flags);
-- 
2.39.5


