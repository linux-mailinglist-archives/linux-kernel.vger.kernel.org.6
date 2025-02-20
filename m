Return-Path: <linux-kernel+bounces-524051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB56A3DE70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BE171728
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC91FDE3B;
	Thu, 20 Feb 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUrRHrM0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F51FDA94
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065160; cv=none; b=jJApf6NYtKfGF7cz9YKdoy50n27gHcGbH3xU8R2zKHdKqksi74CsW5MziCaz0kBrP92bhLjOKv3MB/DHJvqq/NeaYBqBP4D90oJFjBz3ehU6YIvFtMlYt2+1nyDfBpQxof7QxaPMZdCW32sQD8S0r5vriy16qnZqTnphbtnPmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065160; c=relaxed/simple;
	bh=BxyksjnVBxS5f6pgAQEVB2aqaDm/wu22jdIya9tj2BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWvIWI+blilc+YJVzCrzAKF7Bl3hcq0zTN5GVrsaWfI/vqpr5N/g6FgriNqDCKM3Jw4WJ0LCLCpbZOzgqywhEYOGsXdBuf1Rzivlnl/qSg4qHMZOmB3kkLL2ZSfjWPv96f3rTY9sDb+yg+pczBJcP5IX5eTO8PkVYc8KCI2FQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUrRHrM0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740065157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wuTV6mP01rxN+f4H8bWXYcVacuTnGTYaBSQNRccUQnM=;
	b=IUrRHrM0cCywGC2pVLSWVZE23rDjnRMMNkst/L0Az6WcDIgVpmNCHgMG0lctW75vYAqT6P
	xVsY18HsgKGUkLEaKTI1YqDA85dEn75WH0F1SmMaDo1BC29FIHuL4gppsROt1+8IV9ngIi
	3y2HrB+fa5mUoMtfo9E/+Ung8WOO5Nk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-fECR20eDNeuwqkHXH1lptw-1; Thu, 20 Feb 2025 10:25:56 -0500
X-MC-Unique: fECR20eDNeuwqkHXH1lptw-1
X-Mimecast-MFC-AGG-ID: fECR20eDNeuwqkHXH1lptw_1740065155
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43942e82719so7142335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065153; x=1740669953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuTV6mP01rxN+f4H8bWXYcVacuTnGTYaBSQNRccUQnM=;
        b=ovycR0AmsLC8Siihx/8EItYrMr4nZPUjuJn6AL6uRa+CpelkmbQiy1Hpp5ctUH5AOu
         Ac3/R6/g6Z8t4wC6XUi6k3w2x7kIK4gNbe4B4HifhkfYm4aBxPXSQSur+8/9mbbCEfUa
         SAtv9idQZw+HM9Z27PtutElkwC8o7mN7QxDB1mCIGBkDuRuManWIX3y7+swWtAhu6D3U
         xlae37jblksytVGgfLavf3+DipuKTEYgoV0DvGC0Q5IRyH2EN/jYXCHhcnmfIU3+t7u4
         N51lrevf8ukAcMtPaPpiFK2czd2zgONfwiyWF7QsdxO3LNP7aSaEZ4FGvJDjbRFhyaiF
         ZRMw==
X-Forwarded-Encrypted: i=1; AJvYcCWPbgzCPgPgqvvi3uyH8Od9om1ZYUgMIDkIOGkwF0K1hjhYg/Mu4fjRnfI+1TkDUwa3Z3KebKn57E5Tamg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Tfs3SnyDByo6XpcTc6VuNiqchpzlTllXKpXAsGotAINHqxUq
	lb89dbCdX33JdKiDl4zWICjeTdx7LGyQNiruoIFLWOBt2p1kGvX8YqUQo4cvLPyv0oj2Z58iIW5
	qLVdVEsghN5MnivHPiCbRAIFSA3+VS4g7TgRzgKpQNpaN9abKI37o11R3K7QaBA==
X-Gm-Gg: ASbGncva3EHnW0uhOnaqFuJAiUkEy08Vx5cDor+CbvrT2hRNdxW2BqPTmFihygcwWOF
	x51FqfqSvxOTLJPBHrZ1FIWEjWuveX92iPvGAyinSlA4R1KGb4SEfCoV6EtFYkWIWgjbjODx5ht
	DSymISgXZ/L7DvXjGjw1AmCiqjy3kx9+fWyvRxdnYj8JAWqIkAtuGLKyRltu8HESm609RLrmRI5
	CN4P7M0T9K5Xk8r/+kY8tCeh0H97eD9Nr2AsMPUIQAq6oLBaSa6o70H2/r6/e4HB3w4O4CiHRf1
	C6fd+NHDsSeQfaw0nSlsS1tHXH1h5bwIPA==
X-Received: by 2002:a05:600c:4691:b0:439:88bb:d02f with SMTP id 5b1f17b1804b1-43999d7563emr93406505e9.5.1740065152633;
        Thu, 20 Feb 2025 07:25:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa5YMsmCmOZzVxQ6vaznN0QlVkW/DH9INFlWqmg3o/zovbuIfJB/FVL5h8TnkgWoo3nPQuIA==
X-Received: by 2002:a05:600c:4691:b0:439:88bb:d02f with SMTP id 5b1f17b1804b1-43999d7563emr93406135e9.5.1740065152200;
        Thu, 20 Feb 2025 07:25:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c41022csm49874695e9.40.2025.02.20.07.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:25:50 -0800 (PST)
Date: Thu, 20 Feb 2025 16:25:47 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7dJe7XfG0e6ECwr@jlelli-thinkpadt14gen4.remote.csb>
References: <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
 <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
 <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7cGrlXp97y_OOfY@jlelli-thinkpadt14gen4.remote.csb>

On 20/02/25 11:40, Juri Lelli wrote:
> On 19/02/25 19:14, Dietmar Eggemann wrote:

...

> OK. CPU3 + CPU4 (CPU5 offline).
> 
> > [  171.003085] __dl_update() (3) cpu=2 rq->dl.extra_bw=1122848
> > [  171.003091] __dl_update() (3) cpu=3 rq->dl.extra_bw=1022361
> > [  171.003096] __dl_update() (3) cpu=4 rq->dl.extra_bw=1035468
> > [  171.003103] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DYN
> > [  171.003113] __dl_server_attach_root() called cpu=2
> > [  171.003118] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DYN
> > [  171.003127] __dl_add() tsk_bw=52428 dl_b->total_bw=157284 type=DYN rd->span=0-2
> > [  171.003136] __dl_update() (3) cpu=0 rq->dl.extra_bw=477111
> > [  171.003141] __dl_update() (3) cpu=1 rq->dl.extra_bw=851970
> > [  171.003147] __dl_update() (3) cpu=2 rq->dl.extra_bw=1105372
> > [  171.003188] root domain span: 0-2
> > [  171.003194] default domain span: 3-5
> > [  171.003220] rd 0-2: Checking EAS, schedutil is mandatory
> > [  171.005840] psci: CPU5 killed (polled 0 ms)
> 
> OK. DYN has (CPU0,1,2) 157284 and DEF (CPU3,4) 104856.
> 
> CPU4 going offline (it's isolated on DEF).
> 
> > [  171.006436] dl_bw_deactivate() called cpu=4
> > [  171.006446] __dl_bw_capacity() mask=3-5 cap=892
> > [  171.006454] dl_bw_cpus() cpu=4 rd->span=3-5 cpu_active_mask=0-4 cpus=2 type=DEF
> > [  171.006464] dl_bw_manage: cpu=4 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DEF span=3-5
> > [  171.006475] dl_bw_cpus() cpu=4 rd->span=3-5 cpu_active_mask=0-4 cpus=2 type=DEF
> > [  171.006485] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
> > [  171.006495] Hardware name: ARM Juno development board (r0) (DT)
> > [  171.006499] Call trace:
> > [  171.006502]  show_stack+0x18/0x24 (C)
> > [  171.006514]  dump_stack_lvl+0x74/0x8c
> > [  171.006528]  dump_stack+0x18/0x24
> > [  171.006541]  dl_bw_manage+0x3a0/0x500
> > [  171.006554]  dl_bw_deactivate+0x40/0x50
> > [  171.006564]  sched_cpu_deactivate+0x34/0x24c
> > [  171.006579]  cpuhp_invoke_callback+0x138/0x694
> > [  171.006591]  cpuhp_thread_fun+0xb0/0x198
> > [  171.006604]  smpboot_thread_fn+0x200/0x224
> > [  171.006616]  kthread+0x12c/0x204
> > [  171.006627]  ret_from_fork+0x10/0x20
> > [  171.006639] __dl_overflow() dl_b->bw=996147 cap=446 cap_scale(dl_b->bw, cap)=433868 dl_b->total_bw=104856 old_bw=52428 new_bw=0 type=DEF rd->span=3-5
> > [  171.006652] dl_bw_manage() cpu=4 cap=446 overflow=0 req=0 return=0 type=DEF
> > [  171.006706] partition_sched_domains() called
> > [  171.006713] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
> > [  171.006722] Hardware name: ARM Juno development board (r0) (DT)
> > [  171.006727] Call trace:
> > [  171.006730]  show_stack+0x18/0x24 (C)
> > [  171.006740]  dump_stack_lvl+0x74/0x8c
> > [  171.006754]  dump_stack+0x18/0x24
> > [  171.006767]  partition_sched_domains+0x48/0x7c
> > [  171.006778]  sched_cpu_deactivate+0x1a8/0x24c
> > [  171.006792]  cpuhp_invoke_callback+0x138/0x694
> > [  171.006805]  cpuhp_thread_fun+0xb0/0x198
> > [  171.006817]  smpboot_thread_fn+0x200/0x224
> > [  171.006829]  kthread+0x12c/0x204
> > [  171.006840]  ret_from_fork+0x10/0x20
> > [  171.006852] partition_sched_domains_locked() ndoms_new=1
> > [  171.006861] partition_sched_domains_locked() goto match2
> > [  171.006867] rd 0-2: Checking EAS, schedutil is mandatory
> > [  171.007774] psci: CPU4 killed (polled 4 ms)
> 
> As I guess you were saying above, CPU4 contribution is not removed from
> DEF.
> 
> > [  171.007971] dl_bw_deactivate() called cpu=3
> > [  171.007981] __dl_bw_capacity() mask=3-5 cap=446
> > [  171.007989] dl_bw_cpus() cpu=3 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
> > [  171.007999] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
>                                                                           ^^^^
> And this is now wrong. :/

So, CPU4 was still on DEF and we don't go through any of the accouting
functions. I wonder if we could simplify this by always re-doing the
accounting after root domains are stable (also for partition_
sched_domain()). So, please take a look at what below. It can definitely
be better encapsulated (also more cleanups are needed) and maybe it's
just useless/stupid (hard to say here because I always see 'pass'
whatever I try to change), but anyway. Also pushed to the usual branch.

---
 include/linux/sched/deadline.h |  4 ++++
 kernel/cgroup/cpuset.c         | 13 ++++++++-----
 kernel/sched/deadline.c        | 11 ++++++++---
 kernel/sched/topology.c        |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 3a912ab42bb5..8fc4918c6f3f 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain_cpu(int cpu);
+
+extern u64 dl_generation;
+extern bool dl_bw_visited(int cpu, u64 gen);
 
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973..52243dcc61ab 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -958,6 +958,8 @@ static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
+	int cpu;
+	u64 gen = ++dl_generation;
 
 	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
@@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
 
 	rcu_read_lock();
 
-	/*
-	 * Clear default root domain DL accounting, it will be computed again
-	 * if a task belongs to it.
-	 */
-	dl_clear_root_domain(&def_root_domain);
+	for_each_possible_cpu(cpu) {
+		if (dl_bw_visited(cpu, gen))
+			continue;
+		
+		dl_clear_root_domain_cpu(cpu);
+	}
 
 	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8f7420e0c9d6..a6723ed84e68 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+bool dl_bw_visited(int cpu, u64 gen)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 gen)
+bool dl_bw_visited(int cpu, u64 gen)
 {
 	return false;
 }
@@ -3037,6 +3037,11 @@ void dl_clear_root_domain(struct root_domain *rd)
 	}
 }
 
+void dl_clear_root_domain_cpu(int cpu) {
+	printk_deferred("%s: cpu=%d\n", __func__, cpu);
+	dl_clear_root_domain(cpu_rq(cpu)->rd);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
@@ -3216,7 +3221,7 @@ DEFINE_SCHED_CLASS(dl) = {
 };
 
 /* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
-static u64 dl_generation;
+u64 dl_generation;
 
 int sched_dl_global_validate(void)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c6a140d8d851..9892e6fa3e57 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2814,5 +2814,6 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }


