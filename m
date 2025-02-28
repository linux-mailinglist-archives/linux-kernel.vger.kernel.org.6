Return-Path: <linux-kernel+bounces-539262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AAA4A298
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E247189A54A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F61C4A13;
	Fri, 28 Feb 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBDc8Q4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C011C3BEB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770446; cv=none; b=sVjKxZ9vuqL9WBk/Gf5upZjK9WWy8kJ0mYQjgHsSOQ/LWg7XYCLKA92c6tm8zLHul8l0KqjcoJik822ZVwhBQzqVmdNZEn5yu8WE8Fe+9aIEteXynx5xNxlI5FFJ+1Z6Lj29xw7gN23E2+ybEl8sMlsa9fZssYs8x337wUd1D14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770446; c=relaxed/simple;
	bh=ZhBghVANMapaOzi5HQx1hoQpWLvF+HdFjqSM2XWTZpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q+JxZLIg8j6vkVfHqTt0E8xP7ozBFWqUlg4F6+Xf9gqHoy8r1PHXtaFhEXEnVosg99qXmUOyC9dYrfzkyS6CSA4DFrrB89pQJFjiHyE4F5oHgm5oKPAV5HuBI0pH7mCjISVHm/E3c4bLPXcUrNpoTwaLIeOGtWt4+F3y0iO9IWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBDc8Q4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7DBC4CED6;
	Fri, 28 Feb 2025 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740770446;
	bh=ZhBghVANMapaOzi5HQx1hoQpWLvF+HdFjqSM2XWTZpg=;
	h=Date:From:To:Cc:Subject:From;
	b=CBDc8Q4X6VU+qVcYv1Y/nLekvrSqEQEfQc9VH7JVU8dB/AotsETegoNP26WDkoo++
	 bdL5bxnd2dQDWlUBdHRUyje38EqSgDQyfLIZgCrUA6HiVTbaYmsmlHRfmN3tVG0Dkx
	 lrDVZ4TCLbyv/6VCP3opqMmWDpg1/WT9J4pSH0RavhL2b5YSm8+fj75si/6DtAeyXg
	 n6ih085aami8Inaj5wXtiN16Cwq7aWGZhdbZqp/X0R3C70+LehIXiOGIsQoYyfyZJn
	 p2LLmv2C7sxchlw/vvbkxGM7G6m+PJiRm772x/BG2LgyvCQRV9HeMXB/3OO0W8Zztl
	 21s+aMOd9x+Dg==
Date: Fri, 28 Feb 2025 20:20:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] scheduler fix
Message-ID: <Z8IMgei8ctaN_H3R@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-02-28

   # HEAD: 82c387ef7568c0d96a918a5a78d9cad6256cfa15 sched/core: Prevent rescheduling when interrupts are disabled

Prevent cond_resched() based preemption when interrupts are disabled,
on PREEMPT_NONE and PREEMPT_VOLUNTARY kernels.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      sched/core: Prevent rescheduling when interrupts are disabled


 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..67189907214d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7285,7 +7285,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && !irqs_disabled()) {
 		preempt_schedule_common();
 		return 1;
 	}

