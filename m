Return-Path: <linux-kernel+bounces-544834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980E0A4E5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C51C188D57A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64D286280;
	Tue,  4 Mar 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrNgxOAf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D627F4C1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103872; cv=none; b=eBL22BTpXtEGF/IlC1tkrGcxW/bkCkYxi3RkTzDDENuvSZoMI6S44PkZ3tLBxjrIbbgCv6ogbMAbLZ5WTOyiN5iF+iJVTfDd2r2CcVLy5qsa0bTF8fOqjqxJQbhrXIoFjxrXYlIXE0D7tlhx6xugmcYSC8vojHxgy1b4GRV58CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103872; c=relaxed/simple;
	bh=0A5RzxULdn6BnG/wUjI8HXWCUR1CnoyxE7bNXv0lXO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg/NH1vyJi29NKP2+QzFZx2bMbMAhhijUSuZo2/kzaAE9Qbi7Z82WtIQ1HunR/RA8qTJAwFEYaYsR+G5by4BIRZ14xkrKJCURqp03KxX7+iqBOpstqWrmXbIPiWZiwFhKu7z6mEQ+LIWlB5UgEXH2cnn3lzzk8U97NlDqpIAt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrNgxOAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5c+TIt92FxB8qVNIe2L0vIj1KttGJBjP8IGbM1VlN8=;
	b=KrNgxOAfXLuasfXDxMVK8GM7BfkdC2CHT9gSDKhaGt5nXHqB5jM9ARlg9ADqoWmFoFWTgN
	oZKMMKsuQEVDuZioJGpoQsIDaNU+HdnU2LRRJjSN6QdwD+eK8ll6URLNJgeGJMOY/LC5Ct
	kfP7kaWOpA2EdO6afSTZwf2mfaIhlDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-Xp_550LOPBas6fCGZ3iO5A-1; Tue, 04 Mar 2025 10:57:26 -0500
X-MC-Unique: Xp_550LOPBas6fCGZ3iO5A-1
X-Mimecast-MFC-AGG-ID: Xp_550LOPBas6fCGZ3iO5A_1741103845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935e09897so42263805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103845; x=1741708645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5c+TIt92FxB8qVNIe2L0vIj1KttGJBjP8IGbM1VlN8=;
        b=EJ19qiaPaa7z/BE0y6EFKKywQ0DXku9bRzWyZd7wWbHVCNXROyPRuRNhLrz64ShL0T
         dDxQlgrmVm+34oSFcWbqSLZiGJ825HXJgRfXVGeI7LZCZM2gSwps9Ad8seFL/luB4q4V
         OIyuxEw5Jh2EP3vgfsBxU3BXltgDYuw4GT7IFU4a8EMoTUIW4pFR86C+9pOsiKo5BibK
         bk0mLWz01jc00gKDPF765GL5DxSCmcr/QI2EbSVGUfz4v7mIJLpty0bnirwM+5+AnyHC
         jwKKuTQFMZQsarpDYnWR9P0tbgeQMJTHhjbd+Dv+LgCxqKGIb1ld09RErcIldV2eFEhb
         B8XA==
X-Gm-Message-State: AOJu0YyVrEKxOWo8bPtSZ4icN431LBKvFwAe6o3jxchzQaQjw42hY+E/
	HHDj+kVUslCozTHnr3Z2oVLVlCHzGwRD4tjpXp6LsL5znPq/YmbXsd0ZPUT4rZXFurQdG7MTjr/
	w2hyERjvd98h4qo85Y7q5YdpE50ea+1S7+5Gfr4+lsBlFUsCC8KlZjv2atPfHlw==
X-Gm-Gg: ASbGncv26eysA3hZvJayGcw6pBgEvofzm+aAw3XP+xiLFrr9QV/7A2LwFhUk8kqyEBW
	fe/enDKWg0br127oaExkyWW9dYY2+omvt6NscS6nYMDEz58INlyMViZFBNPwxFDB73Il9BTp+LC
	k5UWloxvojAu04iwBb4EZM9p9E43LFwXbT5aZmDiClQNLbPLn2A8VHUPmgSPakjYWXgF5zvihwf
	/qqgpufgwOJ/zDFLhyaMqRl+HHFCMzXf1R3vOIGA8NrDexXoWcFIc7vszEK6N3toYJuS+ksFMqw
	58CRiofp9gIFil5yCAF5f8raKOxSX9BZc4BZJCqC6RpBGENUmSnMj0hdhZv5s+O314eBGJTb8z7
	e5iHh
X-Received: by 2002:a05:600c:4f86:b0:43b:ca39:a9ca with SMTP id 5b1f17b1804b1-43bca39ac88mr48532085e9.16.1741103845271;
        Tue, 04 Mar 2025 07:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF551Hnt03L5tmeixMOfNScnGLbQ9obdAPDfAXfF76/qxOEU3+vZ2la9fN5VW2oCHpNIfsibg==
X-Received: by 2002:a05:600c:4f86:b0:43b:ca39:a9ca with SMTP id 5b1f17b1804b1-43bca39ac88mr48531665e9.16.1741103844801;
        Tue, 04 Mar 2025 07:57:24 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcbb82074sm29324895e9.28.2025.03.04.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:57:24 -0800 (PST)
Date: Tue, 4 Mar 2025 15:57:22 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8ci4jq5IhYGkxtk@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>

Hi Waiman,

Thanks for the review!

On 04/03/25 10:05, Waiman Long wrote:
> On 3/4/25 3:40 AM, Juri Lelli wrote:
> > Create wrappers for sched_domains_mutex so that it can transparently be
> > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > do.
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >   include/linux/sched.h   |  2 ++
> >   kernel/cgroup/cpuset.c  |  4 ++--
> >   kernel/sched/core.c     |  4 ++--
> >   kernel/sched/debug.c    |  8 ++++----
> >   kernel/sched/topology.c | 17 +++++++++++++++--
> >   5 files changed, 25 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9632e3318e0d..d5f8c161d852 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -383,6 +383,8 @@ enum uclamp_id {
> >   extern struct root_domain def_root_domain;
> >   extern struct mutex sched_domains_mutex;
> >   #endif
> > +extern void sched_domains_mutex_lock(void);
> > +extern void sched_domains_mutex_unlock(void);
> 
> If all access to sched_domains_mutex is through the wrappers, we may not
> need to expose sched_domains_mutex at all. Also it is more efficient for the
> non-SMP case to put the wrappers inside the CONFIG_SMP block and define the
> empty inline functions in the else part.
> 
> 
> >   struct sched_param {
> >   	int sched_priority;
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 0f910c828973..f87526edb2a4 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -994,10 +994,10 @@ static void
> >   partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >   				    struct sched_domain_attr *dattr_new)
> >   {
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> >   	dl_rebuild_rd_accounting();
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   }
> >   /*
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9aecd914ac69..7b14500d731b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8424,9 +8424,9 @@ void __init sched_init_smp(void)
> >   	 * CPU masks are stable and all blatant races in the below code cannot
> >   	 * happen.
> >   	 */
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	sched_init_domains(cpu_active_mask);
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   	/* Move init over to a non-isolated CPU */
> >   	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index ef047add7f9e..a0893a483d35 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -292,7 +292,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
> >   	bool orig;
> >   	cpus_read_lock();
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	orig = sched_debug_verbose;
> >   	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
> > @@ -304,7 +304,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
> >   		sd_dentry = NULL;
> >   	}
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   	cpus_read_unlock();
> >   	return result;
> > @@ -515,9 +515,9 @@ static __init int sched_init_debug(void)
> >   	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
> >   	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	update_sched_domain_debugfs();
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   #endif
> >   #ifdef CONFIG_NUMA_BALANCING
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index c49aea8c1025..e2b879ec9458 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -6,6 +6,19 @@
> >   #include <linux/bsearch.h>
> >   DEFINE_MUTEX(sched_domains_mutex);
> > +#ifdef CONFIG_SMP
> > +void sched_domains_mutex_lock(void)
> > +{
> > +	mutex_lock(&sched_domains_mutex);
> > +}
> > +void sched_domains_mutex_unlock(void)
> > +{
> > +	mutex_unlock(&sched_domains_mutex);
> > +}
> > +#else
> > +void sched_domains_mutex_lock(void) { }
> > +void sched_domains_mutex_unlock(void) { }
> > +#endif
> >   /* Protected by sched_domains_mutex: */
> >   static cpumask_var_t sched_domains_tmpmask;
> > @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
> >   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> >   			     struct sched_domain_attr *dattr_new)
> >   {
> > -	mutex_lock(&sched_domains_mutex);
> > +	sched_domains_mutex_lock();
> >   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > -	mutex_unlock(&sched_domains_mutex);
> > +	sched_domains_mutex_unlock();
> >   }
> 
> There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
> topology.c file and one in cpuset.c. That can be problematic in the non-SMP
> case. Maybe another wrapper to do the assert?

Yes, makes sense. Will modify as you suggest here and above.

Best,
Juri


