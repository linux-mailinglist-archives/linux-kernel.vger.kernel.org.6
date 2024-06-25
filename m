Return-Path: <linux-kernel+bounces-228983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2891695D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50A4B22AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1E1607BA;
	Tue, 25 Jun 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Bru4McZa"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7217C98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323413; cv=none; b=kIHGaVdimgJKEICvxDssQYLpyfwogurnVkLrgrJwIppKbbRJ/UgC12rB5kfl3bssR9l1FVM58PzwuLGEHH+0JZ9RYaBer+pK45nko1CHkfbvcTOooBxcxN267zUKaPRhL+a9yFgQ4xgcuFrDQRtOv5qJUton5pglz0Sazwv+TNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323413; c=relaxed/simple;
	bh=/vgfsVSXsUeooRDQqFzdn01I0SPuNp7cJKAagnrnRGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7phRKCsIBojbyeCwyLuWro70D2j/ZxCBeeMw9G6iIl2xD9x5YVqBrzGhuwp7lKRay14H7Xv05hTvWmzvXFsmpo6+R/jD4cTLG445dJMtok9ueRPjbiHTwdCzWSR1IzJZUPpGjvdvM2MTmNzJjQakVB7ga44/fWPfc33LfV6nt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Bru4McZa; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+g0/VIAchowkI6/gXl8+z3FOyGKb1rgXoxY7nw4JH8E=; b=Bru4McZa68HebPVmA75iiAVwOh
	bTTshgAd0xCiVnBndueh3nfTQqolYqHUCO8OQeO3R1IJeuLmlqcgffcgS/FSRJS/R7dHG9hNdeael
	qRpsaPC/JSI0CYWbz4YjNbpMaTrsDvF0egRHBcwxZ+dZRRNP/+EpSfonJnZP0bk+XeawbGZxNcng4
	medsfwy4CPYoxonHFE3goVv74lLYS/vkMXPGwTS2c35KHEphjVDOF/Tl1ENtaZZDd4V7l32jocCUg
	XXFloM6wT5zF45CbwTqc6VaKJEiDorz8mYJaBHZ+Jc4iuHd+y7U8nUUhqRIIdQJKqD1ewej1wyVJO
	j6owT9kQ==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sM6Yd-007Jwz-5h; Tue, 25 Jun 2024 15:50:03 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Ziljstra <peterz@infradead.org>,
	kernel-dev@igalia.com,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH] sched/psi: Optimise psi_group_change a bit
Date: Tue, 25 Jun 2024 14:50:00 +0100
Message-ID: <20240625135000.38652-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tursulin@ursulin.net>

The current code loops over the psi_states only to call a helper which
then resolves back to the action needed for each state using a switch
statement. That is effectively creating a double indirection of a kind
which, given how all the states need to be explicitly listed and handled
anyway, we can simply remove. Both the for loop and the switch statement
that is.

The benefit is both in the code size and CPU time spent in this function.
YMMV but on my Steam Deck, while in a game, the patch makes the CPU usage
go from ~2.4% down to ~1.2%. Text size at the same time went from 0x323 to
0x2c1.

Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 kernel/sched/psi.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa5809c0f..55720ecf420e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -218,28 +218,32 @@ void __init psi_init(void)
 	group_init(&psi_system);
 }
 
-static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
+static u32 test_states(unsigned int *tasks, u32 state_mask)
 {
-	switch (state) {
-	case PSI_IO_SOME:
-		return unlikely(tasks[NR_IOWAIT]);
-	case PSI_IO_FULL:
-		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
-	case PSI_MEM_SOME:
-		return unlikely(tasks[NR_MEMSTALL]);
-	case PSI_MEM_FULL:
-		return unlikely(tasks[NR_MEMSTALL] &&
-			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
-	case PSI_CPU_SOME:
-		return unlikely(tasks[NR_RUNNING] > oncpu);
-	case PSI_CPU_FULL:
-		return unlikely(tasks[NR_RUNNING] && !oncpu);
-	case PSI_NONIDLE:
-		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
-			tasks[NR_RUNNING];
-	default:
-		return false;
+	const bool oncpu = state_mask & PSI_ONCPU;
+
+	if (tasks[NR_IOWAIT]) {
+		state_mask |= BIT(PSI_IO_SOME);
+		if (!tasks[NR_RUNNING])
+			state_mask |= BIT(PSI_IO_FULL);
 	}
+
+	if (tasks[NR_MEMSTALL]) {
+		state_mask |= BIT(PSI_MEM_SOME);
+		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
+			state_mask |= BIT(PSI_MEM_FULL);
+	}
+
+	if (tasks[NR_RUNNING] > oncpu)
+		state_mask |= BIT(PSI_CPU_SOME);
+
+	if (tasks[NR_RUNNING] && !oncpu)
+		state_mask |= BIT(PSI_CPU_FULL);
+
+	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
+		state_mask |= BIT(PSI_NONIDLE);
+
+	return state_mask;
 }
 
 static void get_recent_times(struct psi_group *group, int cpu,
@@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
-	enum psi_states s;
 	u32 state_mask;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		return;
 	}
 
-	for (s = 0; s < NR_PSI_STATES; s++) {
-		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
-			state_mask |= (1 << s);
-	}
+	state_mask = test_states(groupc->tasks, state_mask);
 
 	/*
 	 * Since we care about lost potential, a memstall is FULL
@@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
 	/*
 	 * After we disable psi_group->enabled, we don't actually
 	 * stop percpu tasks accounting in each psi_group_cpu,
-	 * instead only stop test_state() loop, record_times()
+	 * instead only stop test_states() loop, record_times()
 	 * and averaging worker, see psi_group_change() for details.
 	 *
 	 * When disable cgroup PSI, this function has nothing to sync
@@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
 	 * would see !psi_group->enabled and only do task accounting.
 	 *
 	 * When re-enable cgroup PSI, this function use psi_group_change()
-	 * to get correct state mask from test_state() loop on tasks[],
+	 * to get correct state mask from test_states() loop on tasks[],
 	 * and restart groupc->state_start from now, use .clear = .set = 0
 	 * here since no task status really changed.
 	 */
-- 
2.44.0


