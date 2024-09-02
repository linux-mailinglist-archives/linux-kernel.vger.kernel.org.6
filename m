Return-Path: <linux-kernel+bounces-311204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD56A9685F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D5284A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871318454E;
	Mon,  2 Sep 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pMnnDOoJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C317E919
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275699; cv=none; b=BMeP9UzZZDdjz5hKiwE9K2Cd2dUvapQ572jg4HyP8dDn1IqjF8DpXhUPasb+DKjq9IXoZGWaEfvnxlAAN3Hk6ny7e917C//BYcrPpE0D176f1lViWZQtrpmiDI99tQApzfsycotYOIu2vxX2YgfFlEpEad33EN+tWlUx+byh2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275699; c=relaxed/simple;
	bh=lhH4YYSEPgunHxKIiLW1SJ7dkr6qg4sQogwQcIMVLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPoQV99Kv749yrZXy33qtYWpFH5D0s1OFA/bTYrOwHJDDxd5bFjL0xH7+hMHoeFo8+LpRvE/damSkMzMOhoTrNYdKx3BJrbW0V30QH5ksvCv0QzVWgA86vzqdn9EUqfkT7NyCBwF9eJDRna3rOYuziwbj+fgufo1rjtfIR4BymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pMnnDOoJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=blcJcmJRFlktnArMO7HUJVJ7uKrIor0Dr/Fh8ej7K4w=; b=pMnnDOoJDsXh0gard1MtuS2BEc
	iqTkqnEWb2yJ5d/9n0G/0DkpQ9V6mTMvcGqDVuaed+Isow3v8zSzglvjfde2k2J/Ndu3pvTEJ3+K9
	PKP/0Ah8DjEgcdwtnznU0veM8ZEdmB0NBsP+ryrRfcfqIY/5MGhCsqNw5mrv4d8RSGSwdamQIwqd/
	xYzK2D0IOx+Kkwl6pAzVAkIvlVz9aZptVf7IHT6zsvhLG8PNEXtvXCmZRsSIZoLVRehkIpzXoIYQT
	7uP2c3o0JIeY2pTymnX8HlOtACkhlnkKMgypnktR0qcjACEUOIJOeZDNSIrfkW5ya/5ihlzeVK11Z
	ypkwkWDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sl51D-00000006WKO-3bnS;
	Mon, 02 Sep 2024 11:14:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0AA5300642; Mon,  2 Sep 2024 13:14:46 +0200 (CEST)
Date: Mon, 2 Sep 2024 13:14:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
	patches@amperecomputing.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, vineeth@bitbyteword.org,
	bristot@kernel.org, linux-kernel@vger.kernel.org,
	hongyan.xia2@arm.com
Subject: Re: [PATCH v3] sched/deadline: fix the hang in dl_task_of
Message-ID: <20240902111446.GG4723@noisy.programming.kicks-ass.net>
References: <20240829031111.12142-1-shijie@os.amperecomputing.com>
 <ZtAtymo-KB9c20Q8@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAtymo-KB9c20Q8@jlelli-thinkpadt14gen4.remote.csb>

On Thu, Aug 29, 2024 at 10:14:02AM +0200, Juri Lelli wrote:
> Hi,
> 
> On 29/08/24 11:11, Huang Shijie wrote:
> > When we enable the schedstats, we will meet an OS hang like this:
> >   --------------------------------------------------------
> > 	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
> > 	[  134.132013] ------------[ cut here ]------------
> > 	[  134.133441]  x27: 0000000000000001
> > 	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
> > 	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
> > 	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
> > 	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
> > 	[  134.162027] ------------[ cut here ]------------
> > 	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
> > 	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
> > 	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
> > 	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
> > 	[  134.192036] ------------[ cut here ]------------
> > 	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
> > 	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
> > 	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
> > 	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
> > 	[  134.229915] Call trace:
> > 	[  134.232353]  dl_task_of.part.0+0x0/0x10
> > 	[  134.236182]  dl_server_start+0x54/0x158
> > 	[  134.240013]  enqueue_task_fair+0x138/0x420
> > 	[  134.244100]  enqueue_task+0x44/0xb0
> > 	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
> > 	[  134.251584]  kernel_clone+0xe8/0x3e8
> > 	[  134.252022] ------------[ cut here ]------------
> > 	[  134.255156]  __do_sys_clone+0x70/0xa8
> > 	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
> > 	[  134.263412]  __arm64_sys_clone+0x28/0x40
> > 	[  134.272360]  invoke_syscall+0x50/0x120
> > 	[  134.276101]  el0_svc_common+0x44/0xf8
> > 	[  134.279753]  do_el0_svc+0x28/0x40
> > 	[  134.283058]  el0_svc+0x40/0x150
> > 	[  134.286195]  el0t_64_sync_handler+0x100/0x130
> > 	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
> > 	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
> > 	[  134.300283] ---[ end trace 0000000000000000 ]---
> > 	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > 	[  134.311147] SMP: stopping secondary CPUs
> > 	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
> > 	[  135.371884] Kernel Offset: disabled
> > 	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
> > 	[  135.380749] Memory Limit: none
> > 	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
> >   --------------------------------------------------------
> > 
> > In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
> > is enabled, in the following:
> >    dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
> > 	__schedstats_from_dl_se() -->dl_task_of()
> > 
> > we will meet the BUG_ON.
> > 
> > Since the fair task has already had its own schedstats, there is no need
> > to track anything for the associated dl_server.
> > 
> > So add check in:
> >             update_stats_wait_start_dl()
> > 	    update_stats_wait_end_dl()
> > 	    update_stats_enqueue_dl()
> > 	    update_stats_dequeue_dl()
> > 
> > return early for a dl_server dl_se.
> > 
> > Tested this patch with memcached in Altra.
> > 
> > Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
> > Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> > ---
> > v2 --> v3:
> >    Return early in:
> >             update_stats_wait_start_dl()
> > 	    update_stats_wait_end_dl()
> > 	    update_stats_enqueue_dl()
> > 	    update_stats_dequeue_dl()
> 
> This looks better, thanks.
> 
> Peter, what do you think?

Peter thinks that the Changelog is overly verbose, the Fixes tag is
wrong and he doesn't much like the repeated conditions. But he is very
glad this issue is found and fixed.

As such, he's rewritten things like so, does this work for people?

---
Subject: sched/deadline: Fix schedstats vs deadline servers
From: Huang Shijie <shijie@os.amperecomputing.com>
Date: Thu, 29 Aug 2024 11:11:11 +0800

From: Huang Shijie <shijie@os.amperecomputing.com>

In dl_server_start(), when schedstats is enabled, the following
happens:

  dl_server_start()
    dl_se->dl_server = 1;
    enqueue_dl_entity()
      update_stats_enqueue_dl()
        __schedstats_from_dl_se()
          dl_task_of()
            BUG_ON(dl_server(dl_se));

Since only tasks have schedstats and internal entries do not, avoid
trying to update stats in this case.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240829031111.12142-1-shijie@os.amperecomputing.com
---
 kernel/sched/deadline.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1896,46 +1896,40 @@ static inline bool __dl_less(struct rb_n
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
 
-static inline struct sched_statistics *
+static __always_inline struct sched_statistics *
 __schedstats_from_dl_se(struct sched_dl_entity *dl_se)
 {
+	if (!schedstat_enabled())
+		return NULL;
+
+	if (dl_server(dl_se))
+		return NULL;
+
 	return &dl_task_of(dl_se)->stats;
 }
 
 static inline void
 update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void

