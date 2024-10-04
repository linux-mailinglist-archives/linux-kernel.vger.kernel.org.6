Return-Path: <linux-kernel+bounces-350434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A8990511
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039F51C22940
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662F216A24;
	Fri,  4 Oct 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OkyLidxr"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C712139CE
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050274; cv=none; b=T8pfwZYPiAo/2jxEkfyaT5c8CfnXzwjyiOjfrEwMUj6q5p2nVrQYEee8x9lR5vDSFqd3/RYE6kzNngZdd/2Yl1QA3atKoo+RLg1nlyi1gz7KMdfInjtYqwdipSZFNI3Q9Ip9oyJJzHsrXImP7ycRamkMmkBR4SgaK86rk0qr/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050274; c=relaxed/simple;
	bh=24w4lk7SvaenZ0ziLr+tvTw/WsmBaqEwF+QkR9p4C6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEU4TsOsvC1R0KLaxzlOV6B/UbdnmU+CShyRqm35BM1GdSQs3X8h4hTNa3n6cFn86KzDUcHxCcBisp/PlgYoZm3shF3MYL15yXjHUSbRWdpgVNzdYZ3+XahwGwI2Aw2gHuZfheRwaj+uxa/oDGTvFr1PAN4q3Gdp+A7sHtqcANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OkyLidxr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ae6f4b1f16so66391585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728050270; x=1728655070; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+FZ0kxaLjXk/GKIK9zghfxKlcS0PF+7Mts6IvWYtHK8=;
        b=OkyLidxrCv3vA5WjBRG2+ENXnwyj+avkuJ3ysDuVG8WUrqiBV9QpDVnJMozu8z+tQj
         hODrwNWSY/fPv4dioqUGr0qPiP/xSA9p0t47Q1GkIeGK7ex7i+fis5e9gcQ/WrwPXdBj
         gZWqQvUyh/sh7TsxxqU+vrQ57x0kbrtDVXOyrFePloKWEcGk3ZyMlQbbVlm4M309Vris
         UWORBk3+ybp+07ThNoXji4t97JA5vjjN2US7DZHzot6NEstAIPRgDJD4SNZzy1mtl1CA
         7eK61sUE6sqIDd+TdVXx1Sj48k68PdDbxngizT1SbrpffIuEr5m9FqfTGHCfOoAOL/Xv
         39Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050270; x=1728655070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FZ0kxaLjXk/GKIK9zghfxKlcS0PF+7Mts6IvWYtHK8=;
        b=rhLP5IKoKCMXQureE5mX3hmAJrvTv4P3MVpEB9v0R6FLEG+ZeefynHVVnC6d+luUBY
         06cZAUefwdtOLfaQfrDTpUt/IAH7ZnYwVOY8yCK9exfYVG4IvoA+hvIF8ONxLh1+JHfG
         hm8q3mcbOq4C0J/jqToN3Tvv2bLGQ0oLIc+tGMrLvMTZLizrmmdFRfSwErG4LiVGytTg
         RNzgYkkiFRH5MhUQ030xpY7/TQT4Z+hmJg9OWNlo+M2XvNqAgiJ6QHpaodRWueUEU1h1
         cOIggLSqxzigoZDYgAMVedHRZ69IdDis9BH55BIFq69Fd/wnOnTHTGt/zxR2ydrOkmgv
         w97A==
X-Forwarded-Encrypted: i=1; AJvYcCUuKuTQ3gkwr/P7R7CggtvmmgaLXCrZEwNsoGDJb+RpS0veK0AMtMJHmpcTjDhvkdTr06AGH71mDAA1w8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzyu4DG+TYyG8m1czKTD053DUJimUGDeUO4OO8aSFw/C5YpIV+
	BcAerozJbmygQxz57UD/ym5u5Jfsf5uE2IrxPxgGO3f0vOIall7obNMJazMuE2I=
X-Google-Smtp-Source: AGHT+IHjNBpWVaK7Gnu6jfxORzUVFxM0baQ/+G2aytNG75YdiEvM0epEbw2jzYdMVEOSG46j/T/sAw==
X-Received: by 2002:a05:620a:2806:b0:7a3:49dd:1f60 with SMTP id af79cd13be357-7ae6f43a911mr459388885a.25.1728050269565;
        Fri, 04 Oct 2024 06:57:49 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b39b674sm139954685a.34.2024.10.04.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:57:48 -0700 (PDT)
Date: Fri, 4 Oct 2024 09:57:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	linux-kernel@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, efault@gmx.de, juri.lelli@redhat.com,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	tglx@linutronix.de, vincent.guittot@linaro.org, vschneid@redhat.com,
	wuyun.abel@bytedance.com, youssefesmat@chromium.org,
	spasswolf@web.de, regressions@lists.linux.dev,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
Message-ID: <20241004135744.GB1658449@cmpxchg.org>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
 <20241004123506.GR18071@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004123506.GR18071@noisy.programming.kicks-ass.net>

On Fri, Oct 04, 2024 at 02:35:06PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 04, 2024 at 04:40:08PM +0530, K Prateek Nayak wrote:
> > Hello folks,
> > 
> > On 10/3/2024 11:01 AM, Klaus Kudielka wrote:
> > > On Sun, 2024-09-22 at 16:45 +0100, Chris Bainbridge wrote:
> > > > On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
> > > > > Since linux next-20240820 the following messages appears when booting:
> > > > > 
> > > > > [    T1] smp: Bringing up secondary CPUs ...
> > > > > [    T1] smpboot: x86: Booting SMP configuration:
> > > > > [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
> > > > > This is the line I'm concerend about:
> > > > > [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
> > > > > [    T1]   #3  #5  #7  #9 #11 #13 #15
> > > > > [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
> > > > > [    T1] smp: Brought up 1 node, 16 CPUs
> > > > > [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
> > > > > 
> > > > > I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
> > > > > Is this normal or is this something I should worry about?
> > > > > 
> > > > > Bert Karwatzki
> > > > 
> > > > I am also getting a similar error on boot, and bisected it to the same commit:
> > > > 
> > > > [    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4
> > > > 
> > > > #regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d
> > > 
> > > Just another data point, while booting 6.12-rc1 on a Turris Omnia:
> > > 
> > > [    0.000000] Linux version 6.12.0-rc1 (XXX) (arm-linux-gnueabihf-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Thu Oct  3 06:59:25 CEST 2024
> > > [    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
> > > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> > > [    0.000000] OF: fdt: Machine model: Turris Omnia
> > > ...
> > > [    0.000867] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> > > [    0.000876] psi: inconsistent task state! task=2:kthreadd cpu=0 psi_flags=4 clear=0 set=4
> > > 
> > 
> > Not sure if someone took a stab at this but I haven't seen the "psi:
> 
> I'm aware of the issue, but since it's just statistics and not
> anything 'important', I've been spending my time on those crashing bugs.
> 
> > inconsistent task state" warning with the below diff. I'm not sure if my
> > approach is right which if why I'm pasting the diff before sending out
> > an official series. Any comments or testing is greatly appreciated.

This fixes the bug for me.

> Anyway, assuming PSI wants to preserve current semantics, does something
> like the below work?

This doesn't. But it's a different corruption now:

[    2.298408] psi: inconsistent task state! task=24:cpuhp/1 cpu=1 psi_flags=10 clear=14 set=0

It's psi_sched_switch(.sleep=true) trying to clear the running state
and the queued state, but finds only the running state set.

I don't think it's an erroneous dequeue. __schedule() has that
block_task() dequeue before the switch, but the DEQUEUE_SLEEP makes it
a no-op and leaves the combined update to psi_sched_switch().

It looks instead it's missing an enqueue callback. This triggers:

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..09a251e3986d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -922,6 +922,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
+		WARN_ON_ONCE(!(next->psi_flags & TSK_RUNNING));
+
 		psi_flags_change(next, 0, TSK_ONCPU);
 		/*
 		 * Set TSK_ONCPU on @next's cgroups. If @next shares any

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..0d766fb9fbc4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2012,7 +2012,7 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(flags & ENQUEUE_NOCLOCK))
>  		update_rq_clock(rq);
>  
> -	if (!(flags & ENQUEUE_RESTORE)) {
> +	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
>  		sched_info_enqueue(rq, p);
>  		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>  	}

... we must be skipping here when we shouldn't.

I tried moving it past ->enqueue_task(), like we did for uclamp, to
get the enqueue when sched_delayed is cleared by the callback and task
is considered properly queued again. However, that results in yet
another problem:

[    4.624776] psi: inconsistent task state! task=161:systemd-ssh-gen cpu=1 psi_flags=15 clear=14 set=1

This is a psi_sched_switch() trying to clear running|queued and set
iowait. Task is already running|queued|iowait. It looks like we had a
genuine wakeup that was signaled with psi_enqueue(.wakeup=false) (so
it didn't clear the iowait).

> @@ -2039,7 +2039,7 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(flags & DEQUEUE_NOCLOCK))
>  		update_rq_clock(rq);
>  
> -	if (!(flags & DEQUEUE_SAVE)) {
> +	if (!(flags & DEQUEUE_SAVE) && !p->se.sched_delayed) {
>  		sched_info_dequeue(rq, p);
>  		psi_dequeue(p, flags & DEQUEUE_SLEEP);
>  	}
> @@ -6537,6 +6537,7 @@ static void __sched notrace __schedule(int sched_mode)
>  	 * as a preemption by schedule_debug() and RCU.
>  	 */
>  	bool preempt = sched_mode > SM_NONE;
> +	bool block = false;
>  	unsigned long *switch_count;
>  	unsigned long prev_state;
>  	struct rq_flags rf;
> @@ -6622,6 +6623,7 @@ static void __sched notrace __schedule(int sched_mode)
>  			 * After this, schedule() must not care about p->state any more.
>  			 */
>  			block_task(rq, prev, flags);
> +			block = true;
>  		}
>  		switch_count = &prev->nvcsw;
>  	}
> @@ -6667,7 +6669,7 @@ static void __sched notrace __schedule(int sched_mode)
>  
>  		migrate_disable_switch(rq, prev);
>  		psi_account_irqtime(rq, prev, next);
> -		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
> +		psi_sched_switch(prev, next, block);
>  
>  		trace_sched_switch(preempt, prev, next, prev_state);

