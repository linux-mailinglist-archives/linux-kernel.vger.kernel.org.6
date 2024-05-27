Return-Path: <linux-kernel+bounces-190534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DD8CFF98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011351F215FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B315E5C2;
	Mon, 27 May 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPr2yflF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1F15E5A1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811662; cv=none; b=WGrkARdPQtIeRnRwERsIukPbOoM3m2XEcnKr9sCDl2NmCZe6I2Y6sk1ef3l7UjVc2U99Yp3tXGJGPFewGwOSRsAzqEqdGtroRC6tiJqW3MdQGzYTOEy/CWSoHb+aHHhsAc/vPPIRM/EuPXuTWgCUapJy+MsHhZGhoPSFw6ICxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811662; c=relaxed/simple;
	bh=NDyaoW3Q0zMLZglcicXIeo2NJZBNXM84ySYhq0BL5yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3MdB9+PE3umBVfxCBJfZo1vSyCFHNtkGi4xPG6gXHybx0lT2mJLucMKpYRFu7QOSgcZ3KWnGpkNH9J8yTKx3oQ5cXnIf8U5YMTPhOBqyyjHFydse8Xg6ZQddjhUttJXn/U9I4QFO4hrhV77D/A0g695OVwAOvOw+tWh8zXc42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPr2yflF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87F4C32789;
	Mon, 27 May 2024 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811662;
	bh=NDyaoW3Q0zMLZglcicXIeo2NJZBNXM84ySYhq0BL5yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPr2yflFqRxoc2GaYKemAj+WW3w2guVJfzqE48MR3fXAcEl1cJ2+30qlA7ZuKuZgV
	 PxRayVXh1XMqTyg65D9nZ7YfbICGl1+Ez29gjR5icOTLg077RVhuepX0IOEiWCQv6N
	 5fYySXbJtFcZ9wZWgQ51h5reHWplz11AYcMp0fSHZWrph12GjOGTUUNxLlrGiWBXM+
	 hoje3t+pzPuFqlgDOKJnDsgN5aIkRWoR2y6jdxq+VdIsbdKS7grvfNaL5XZH6sUdQq
	 Dka+SLuJicCz6ncXVz0P2FCypn3eYIWI+w0criGF/ogt2DOohHf3BBdV6YSXllDm/R
	 a9fIvwV6ockcQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V7 7/9] sched/core: Fix priority checking for DL server picks
Date: Mon, 27 May 2024 14:06:53 +0200
Message-ID: <48b78521d86f3b33c24994d843c1aad6b987dda9.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In core scheduling, a DL server pick (which is CFS task) should be
given higher priority than tasks in other classes.

Not doing so causes CFS starvation. A kselftest is added later to
demonstrate this.  A CFS task that is competing with RT tasks can
be completely starved without this and the DL server's boosting
completely ignored.

Fix these problems.

Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 53f0470a1d0a..01336277eac9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -162,6 +162,9 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
 
+	if (p->dl_server)
+		return -1; /* deadline */
+
 	if (rt_prio(p->prio)) /* includes deadline */
 		return p->prio; /* [-1, 99] */
 
@@ -191,8 +194,24 @@ static inline bool prio_less(const struct task_struct *a,
 	if (-pb < -pa)
 		return false;
 
-	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
-		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+	if (pa == -1) { /* dl_prio() doesn't work because of stop_class above */
+		const struct sched_dl_entity *a_dl, *b_dl;
+
+		a_dl = &a->dl;
+		/*
+		 * Since,'a' and 'b' can be CFS tasks served by DL server,
+		 * __task_prio() can return -1 (for DL) even for those. In that
+		 * case, get to the dl_server's DL entity.
+		 */
+		if (a->dl_server)
+			a_dl = a->dl_server;
+
+		b_dl = &b->dl;
+		if (b->dl_server)
+			b_dl = b->dl_server;
+
+		return !dl_time_before(a_dl->deadline, b_dl->deadline);
+	}
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
 		return cfs_prio_less(a, b, in_fi);
-- 
2.45.1


