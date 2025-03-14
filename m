Return-Path: <linux-kernel+bounces-561040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DFA60CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6176461198
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6B1DED5F;
	Fri, 14 Mar 2025 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZDuXA9o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E0153800
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943497; cv=none; b=oNjALjJCAMVN1rTakeUYyaFKOe+3ujvjIP7XESpY5lRyOYrCAfdGcFX/VRO4C8DezVmUwoyEpVRp5LZWilARFv8WmpjdQgU6udQcB0bYzn7S3fRoleBzttBEx0gTeXM2NuJltrMP80wUzxSw5Ebb/HdwwgmQoAaZNfSn5b35hTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943497; c=relaxed/simple;
	bh=251YdycQE9QPD4V2cRjplpjUAxhUeuJ0447uo32SLHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QieRx4+DvjU/E0rPfZffbmVrsE7dfVSq+uvvFkRvIGPr81/hBVxwR28PI1cRrRhzKRGeqxH0kgCsif9UfJx7bTv0TUkgtbrsAphJmxqGP1Roulj1Q+X/Ujx/HpOoTAXJvUdGJTaMRfRj+aDScYmO1gM9O0uFYesbD0PSylE8NJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZDuXA9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF929C4CEE3;
	Fri, 14 Mar 2025 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741943497;
	bh=251YdycQE9QPD4V2cRjplpjUAxhUeuJ0447uo32SLHM=;
	h=Date:From:To:Cc:Subject:From;
	b=PZDuXA9oyJSEOEzvxc9mS6GQYuRrEs9JFB2Jw9637rKbI37KDMyKnWvZ8nA+m450a
	 HhZkXVrPqF9KioaYt6diHyhr7hOQZ+sS7aJbIUXKh29V1sWYvvzSItjw5lkM4LckB/
	 E0cWtpCrwkvMozY7uf7Yliiwktj8RiX3bM+VmGFyTK2DlqRrwHpAiEK8f6o2Yx1W4Y
	 EECtpkPH2n0+JA2HscL0dfK5xCb0LVEC0K3+CWBU9gj0Pl6cFH7IF73bkWbe7vuSUw
	 eAuuZML1zOrEgibHlYczQw2HPEhr735LhnLsNsTPSQpHJNo6cQoLacYXynLJIeBtPj
	 rZ8ULL/V769ig==
Date: Fri, 14 Mar 2025 10:11:30 +0100
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
Message-ID: <Z9PywlnGNS7ctnh_@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-03-14

   # HEAD: f3fa0e40df175acd60b71036b9a1fd62310aec03 sched/clock: Don't define sched_clock_irqtime as static key

Fix a sleeping-while-atomic bug caused by a recent optimization
utilizing static keys that didn't consider that the
static_key_disable() call could be triggered in atomic context.

Revert the optimization.

 Thanks,

	Ingo

------------------>
Yafang Shao (1):
      sched/clock: Don't define sched_clock_irqtime as static key


 kernel/sched/cputime.c | 8 ++++----
 kernel/sched/sched.h   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5d9143dd0879..6dab4854c6c0 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -9,8 +9,6 @@
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
-DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
-
 /*
  * There are no locks covering percpu hardirq/softirq time.
  * They are only modified in vtime_account, on corresponding CPU
@@ -24,14 +22,16 @@ DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
+int sched_clock_irqtime;
+
 void enable_sched_clock_irqtime(void)
 {
-	static_branch_enable(&sched_clock_irqtime);
+	sched_clock_irqtime = 1;
 }
 
 void disable_sched_clock_irqtime(void)
 {
-	static_branch_disable(&sched_clock_irqtime);
+	sched_clock_irqtime = 0;
 }
 
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..023b844159c9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3259,11 +3259,11 @@ struct irqtime {
 };
 
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
-DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
+extern int sched_clock_irqtime;
 
 static inline int irqtime_enabled(void)
 {
-	return static_branch_likely(&sched_clock_irqtime);
+	return sched_clock_irqtime;
 }
 
 /*

