Return-Path: <linux-kernel+bounces-404040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D59C3E64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113732843C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08519C552;
	Mon, 11 Nov 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ab9uIKXg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCB14A62B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327866; cv=none; b=eyZHfaZUajZ3mfVjTvGlfXGt7IkkbKYV24YcQiygjrvfVJJQPHe8lHX1y2cte49OMxlMAMgwRbtYntoP4gIIgg2LloId/k4TFNr1/itUO3FPXdWbhEtp43Vpv02tyKdUyUzd0oa9SaHSNslAcQXX/UZh7C/yMn6Swe4lI0ql7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327866; c=relaxed/simple;
	bh=7Qx244RkJfpct+iDhyblUu5w7Wwjav9Xa0gB7q+wPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIL+zTmEy1154KGvmay5h4k85nYnn7bzVW6tPyQlYHJEoQXYzc7wxS1ttUBCJtv0/I87JaTgPQ9g3wzfxUM/V6wSzLP3nhhQx7XYOwrtRwjpxRwahVxRm6o0hjh5T7bgNQNAI1gxcws2hFhB4ozkk4aYWIrckO4dOIacp8389OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ab9uIKXg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731327862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96Tx7GQb6OowHUd+XMSxcdpDcjTMNFIIjOayaiyM0KA=;
	b=Ab9uIKXgQf7ygsXAMS21LM7ryvpml9SK4b5KbwhpIhlkJogqOvoAiNUQi09fcfL/FqHVPA
	BJ2AVe88VFuQ06XjraQ4hAf7xRSwW3QUXj+wINGnGSmW+EHGbKrlRfpFOEnstMylq3Zfi3
	MzkvuJQvMzKk9Sq9TnUPATtVWunmCnQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ZN2ThX9ENJKlZ-erHrNbwA-1; Mon, 11 Nov 2024 07:24:10 -0500
X-MC-Unique: ZN2ThX9ENJKlZ-erHrNbwA-1
X-Mimecast-MFC-AGG-ID: ZN2ThX9ENJKlZ-erHrNbwA
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d38310949cso81977446d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731327850; x=1731932650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96Tx7GQb6OowHUd+XMSxcdpDcjTMNFIIjOayaiyM0KA=;
        b=DRtqjoGZZgVCTrw8rjzfPfxNvTN6AyllLMGQK5Fvy9WQeBsvzHqF1OyW/MG1gvRK8C
         cc0jCcx/4vC556wsjcLRX1RpmtlzjMVSMP2y+2W3m3sZCG+PDEo9bLfKg7Zvx0usfzZM
         1PGj/bDuXRntGwzL2R7RQEp0iShsQvCS5nrxbNf6doJzMyxqySfK4KXqqja38Mnwn6Ss
         U9ANP4ri2SHt+4J6uhzlrtbwRg0Byo8qKLmbs8sTNUlvLuk3QGFuZZnE6UJlJc+CbI8v
         twTrR6hpPPHgPZovfQEiRy+QNYHkCqaATTA6zZKuJmf+tepynSvBWKPBk048S86YYXUs
         i5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVShAA8ETacWF7qhwO6FXrskn2un/MrnzeCTPuUKLCoj3qz5bjsq5KMRta8dRgMgeglmOcGnaY0RPUUR4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiLWey9KrEVb0BHbrRoNIIp1PaUqn9REu2Smw2ab4a2zb+e+E
	UNg5eSWsGvuL5OraJyYxcgI+0RAyDAwz3eXkXr1LSHHqUCRS7lSFRr0mP1d7UvWFlfhRItzF8dk
	fXaAvXgI77ICU4vFLQKICludUB8/aOPwNXqrNBogwVtc84XROgacwp+fAeC7CRA==
X-Received: by 2002:a05:6214:4807:b0:6d3:5ca6:b3e6 with SMTP id 6a1803df08f44-6d39e12b69cmr173161396d6.19.1731327850297;
        Mon, 11 Nov 2024 04:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa5fOCLPeW4GzDkhpydH5s/w4wb4k9err0t1zeN6PgvIck1vHEuiMWLQHHnFMgPsKYBqnFYA==
X-Received: by 2002:a05:6214:4807:b0:6d3:5ca6:b3e6 with SMTP id 6a1803df08f44-6d39e12b69cmr173161016d6.19.1731327849922;
        Mon, 11 Nov 2024 04:24:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-250.as13285.net. [89.240.117.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df9f1sm59082346d6.23.2024.11.11.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:24:08 -0800 (PST)
Date: Mon, 11 Nov 2024 12:24:03 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <ZzH3Y-1xzTsfmln1@jlelli-thinkpadt14gen4.remote.csb>
References: <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
 <20241104174109.GA1044726@google.com>
 <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
 <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
 <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
 <5259772c-527b-4ab2-9606-2d1f0d93862a@redhat.com>
 <a8e3dfbd-0efa-4b4e-bc18-d00abaa79f14@redhat.com>
 <ZzHQcQ4nBYdcbZJ_@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzHQcQ4nBYdcbZJ_@jlelli-thinkpadt14gen4.remote.csb>

On 11/11/24 09:37, Juri Lelli wrote:
> On 09/11/24 13:18, Waiman Long wrote:
> > On 11/8/24 10:30 PM, Waiman Long wrote:
> > > I have the patchset to enforce that rebuild_sched_domains_locked() will
> > > only be called at most once per cpuset operation.
> > > 
> > > By adding some debug code to further study the null total_bw issue when
> > > cpuset.cpus.partition is being changed, I found that eliminating the
> > > redundant rebuild_sched_domains_locked() reduced the chance of hitting
> > > null total_bw, it did not eliminate it. By running my cpuset test
> > > script, I hit 250 cases of null total_bw with the v6.12-rc6 kernel. With
> > > my new cpuset patch applied, it reduces it to 120 cases of null
> > > total_bw.
> > > 
> > > I will try to look further for the exact condition that triggers null
> > > total_bw generation.
> > 
> > After further testing, the 120 cases of null total_bw can be classified into
> > the following 3 categories.
> > 
> > 1) 51 cases when an isolated partition with isolated CPUs is created.
> > Isolated CPU is not subjected to scheduling and so a total_bw of 0 is fine
> > and not really a problem.
> > 
> > 2) 67 cases when a nested partitions are being removed (A1 - A2). There is
> > probably caused by some kind of race condtion. If I insert an artifical
> > delay between the removal of A2 and A1, total_bw is fine. If there is no
> > delay, I can see a null total_bw. That shouldn't really a problem in
> > practice, though we may still need to figure out why.
> > 
> > 2) Two cases where null total_bw is seen when a new partition is created by
> > moving all the CPUs in the parent cgroup into its partition and the parent
> > becomes a null partition with no CPU. The following example illustrates the
> > steps.
> > 
> > #!/bin/bash
> > CGRP=/sys/fs/cgroup
> > cd $CGRP
> > echo +cpuset > cgroup.subtree_control
> > mkdir A1
> > cd A1
> > echo 0-1 > cpuset.cpus
> > echo root > cpuset.cpus.partition
> > echo "A1 partition"
> > echo +cpuset > cgroup.subtree_control
> > mkdir A2
> > cd A2
> > echo 0-1 > cpuset.cpus
> > echo root > cpuset.cpus.partition
> > echo "A2 partition"
> > cd ..
> > echo "Remove A2"
> > rmdir A2
> > cd ..
> > echo "Remove A1"
> > rmdir A1
> > 
> > In this corner case, there is actually no change in the set of sched
> > domains. In this case, the sched domain set of CPUs 0-1 is being moved from
> > partition A1 to A2 and vice versa in the removal of A2. This is similar to
> > calling rebuild_sched_domains_locked() twice with the same input. I believe
> > that is the condition that causes null total_bw.
> > 
> > Now the question is why the deadline code behaves this way. It is probably a
> > bug that needs to be addressed.
> 
> Thanks for the analysis (and the patches). Will take a look, but I
> suspect it might be because in case domains are not destroyed, we clear
> them up (total_bw set to 0), but we don't add fair server contribution
> back because rqs are not attached to domains (as there have been alredy
> attached when such domains were created).

OK, I'm thinking maybe something like the below might help. It seems to
do well with your test above, does it maybe fix the other cases you
mentioned as well?

---
 include/linux/sched/deadline.h |  1 +
 kernel/sched/deadline.c        | 12 ++++++++++++
 kernel/sched/topology.c        |  9 ++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 3a912ab42bb5..a74fb0da0fa3 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,7 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_restore_server_root_domain(struct root_domain *rd);
 
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7884e566557c..acbd3039215f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2981,6 +2981,18 @@ void dl_add_task_root_domain(struct task_struct *p)
 	task_rq_unlock(rq, p, &rf);
 }
 
+void dl_restore_server_root_domain(struct root_domain *rd) {
+	int i;
+
+	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
+	for_each_cpu(i, rd->span) {
+		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
+
+		if (dl_server(dl_se))
+			rd->dl_bw.total_bw += dl_se->dl_bw;
+	}
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	unsigned long flags;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..a0fcae07585e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2721,12 +2721,15 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 				/*
 				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.  It
-				 * will be recomputed in function
-				 * update_tasks_root_domain().
+				 * its dl_bw->total_bw needs to be cleared.
+				 * Tasks contribution will be then recomputed
+				 * in function dl_update_tasks_root_domain(),
+				 * dl_servers contribution in function
+				 * dl_restore_server_root_domain().
 				 */
 				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
 				dl_clear_root_domain(rd);
+				dl_restore_server_root_domain(rd);
 				goto match1;
 			}
 		}


