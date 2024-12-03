Return-Path: <linux-kernel+bounces-430019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826099E2D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C437B27B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3290A1FCD17;
	Tue,  3 Dec 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n5VYppJV"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DE1EF081
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251167; cv=none; b=j048RJP+h5HF3GbLPbJbNjHPbx4giQn2OUcNAjZF6wwoVcjvFfe3wpLBOlrihAGZzBrOaSD7rrTYS0ehK5DKM4yadN9iIz7Jth8oA5Nht3vGJf/7SUHrvscbs1ATEY35gI1F6KrCjr4V6vvDSJOUkA3kxvpFMHFQCvrC26ts3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251167; c=relaxed/simple;
	bh=sWmIJrqn0OBYYML5VSkb6b/Lu8XSYr3nV1enIntYB7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MnyUK9vW+NAgnwD1MLe+MLopOJn9SiM3dVxla0i/NDDdOz8RvSa2/hEcSLab78YXo4N+i1gf0E9KUMxwb59NTpIT1odJbZjhvX+8ZvS0XaaxbeXlcefkYxWZczwUy7HwYsfGZx88d8exsOSh/MzmOl5eBqAlmjDcFc3ZdeotyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=n5VYppJV; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1733251164;
	bh=sWmIJrqn0OBYYML5VSkb6b/Lu8XSYr3nV1enIntYB7U=;
	h=From:To:Cc:Subject:Date:From;
	b=n5VYppJVpYPQq42ZK2ADtoyRYfZgzDVh2IWzf0NPrhtIKLP08g8/V1oqtf8WJGuPf
	 ya6GkozAlwt3y9rFFvAyootTQw5CpX1aD6voRaL0h4JGl3d9X4OLQwS7rI7c2RwY0l
	 ihR5U7r0tpPDvlm+GppbmBlDNrDiiHhQF/BtIPE9JRdHDQDKARZeaSIJQSFqjEcnBY
	 Ar+ShG95BkCL57+KalioZK+AecPcfva+ytKRnSWIL5d7AutuI6kJ6Eo5BORL+pg8qr
	 aG+KLQNj1eAT/Aatmeu/k21pK9DUWP+NKXtT7jgEtIjnKmgsC7jX01tv3ITFTInSkA
	 9AjLQ+PIi5PWw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y2qF833nMzTLv;
	Tue,  3 Dec 2024 13:39:24 -0500 (EST)
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
Subject: [PATCH] smp: Evaluate local cond_func() before IPI side-effects
Date: Tue,  3 Dec 2024 13:39:05 -0500
Message-Id: <20241203183905.3477210-1-mathieu.desnoyers@efficios.com>
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
Reviewed-by: Rik van Riel <riel@surriel.com>
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


