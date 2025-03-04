Return-Path: <linux-kernel+bounces-544648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE87A4E3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665F717254A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605D294EDA;
	Tue,  4 Mar 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPIiPyHq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E527FE9D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101477; cv=none; b=GKlDJCvvw9V9PE19Uf2tKwQlJAE3jjzlFhUHb22eM6SeI2LKcSJ6i4No05KNDNIH6RpuuOdQA646BQKuabE5rfMYnRMHdKvzkl6n6tlE5/yxbE4TaqnoU1UHopa/rguCmDsYPvMwPEb0TCSBjXIPqQGI1ZBoZ7++qaGFgpGJCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101477; c=relaxed/simple;
	bh=WOkwYBJ6mURKrzAo56DfT5siukCfEs71MN6//Njmljw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fmY/5BoD39FRc4Hb0736UOiSkRV8t9q8f506fexwNBkRi6hcGJc+RUfJavrpYTEAk/jcaMKsLUd9idNiYRxDalSnpJO1bb+rscec9AXQFlkt6NjdmH4HGEzzUoYu/9WJIk/15+QKS7D8pWdhw6wLexj02KyqdkpMxiyucZkZFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPIiPyHq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741101474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0lr8kKXCfO90fVf3E5CbEg1FpivAju4c8en810I8Rk=;
	b=VPIiPyHqT4e5RjnP1Xx3jQygRHX7Vf69+SB85vUfK8ffWA8f8OygtEMdqBKmAkSd/iiQsh
	hdcIA8YQtEKf1i4wexAqcy5zQIJjG5K5xfnxgJdAK8WXcHXsnjKuN12V8i25rHwbYqAsIp
	ckaTnHQqZHkESTmz0Uir98xm9jb7n/E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-FPUdwJQXP6aKo9_tII7l6g-1; Tue, 04 Mar 2025 10:17:48 -0500
X-MC-Unique: FPUdwJQXP6aKo9_tII7l6g-1
X-Mimecast-MFC-AGG-ID: FPUdwJQXP6aKo9_tII7l6g_1741101467
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8e171fd66so12728066d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101467; x=1741706267;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0lr8kKXCfO90fVf3E5CbEg1FpivAju4c8en810I8Rk=;
        b=m7C/3714z51KO8wgJeG2rKgko+Hn/wZzShf6hQcrq/Yci8m9CNIvrBDhJwlQGgHxuk
         XgWOWxPPfOcFB+Qy9Q+bln82wcUrYv4hDlTjzPhTf+vr+HeBx/MV8JhJ6QgXLGR5i4tA
         W8ybKpiByBKv93l+MZAakSyrUy5Sayn4SOJDejcx8lmbg6OuywDJNWpGGwyIt5quQJA/
         Kl+AAb+Bj76SOtMGnydzgQx8vUGFoRLXDC8a5CxTMAkMRFpPdU6SgU2eSXsdfTi5UOM6
         vLI1K2nfs0YfAZ5zl/4lPmElXzRPAC+uMohPNC5av/cOmi4bs9PD9BO9KfQ1COOLTw9U
         MJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7u88X821xPpruhb90IY0USJp7YbLd4XBdrZp7wtXv13+lCuxnkJ3H/DFEAYB7G6oxTGSbwHnpTzOMYZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4xpSTBL0divVOe7GUPvf8RmviXrNnxkiRReYENpewdBZ/lwC
	NNGr0hMJ/QiV5wNjpSdAGa+gyxECMAfAqGvxzzUyo5waGM47XJC0fqozHNLLLSgd9FWUHg4RdGk
	w8vSCbVlEzD4fimqvWUWAVeOdGTyZ6QMznRzmvroI/UMIkM65Z4ApOhrDHq4S8A==
X-Gm-Gg: ASbGncvMrEoDm7Fy/BVXDx8lF4zQ94RkXMi3UhigUQ6aVBdZ7CJykZL+y2TkXCyca/R
	+/w+/RvcwUsUttJ4JtHsX2m3ZKibR/3dU601R3wja5PcDXKkP5wfAFHUlFTy1tvcToMMpkSg35u
	naYb94m0EKhAf1jN3VmFZpMyP7wxxvs4ORYoNB1JlJA3gPiK5GOBU7RZFi1lLGAnQlC9lsWxMoN
	yUB/Hungv3b4kPdkwnQ1aTQSeBBnv4WK+jmPAAs/Tf4jIWmk/c3nZXs7KoWnYymyfpfo6WeOb4G
	I2XEcUGFVJqMACq6qOmhgLIqQIwWGRxrx7hZOa642OceaN88gwgPLm71wkk=
X-Received: by 2002:a05:6214:2462:b0:6e4:2f4c:f2d2 with SMTP id 6a1803df08f44-6e8a0d4a85dmr296961076d6.31.1741101467592;
        Tue, 04 Mar 2025 07:17:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkHDKpx95IvLlNWfMuPOgJAI9UpdVjyVUiKIhZFFUom81X7LiUCPrloV7QmTIDO56sr2LL9A==
X-Received: by 2002:a05:6214:2462:b0:6e4:2f4c:f2d2 with SMTP id 6a1803df08f44-6e8a0d4a85dmr296960696d6.31.1741101467233;
        Tue, 04 Mar 2025 07:17:47 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634a8dsm67563276d6.7.2025.03.04.07.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:17:46 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Date: Tue, 4 Mar 2025 10:17:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250304084045.62554-5-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 3:40 AM, Juri Lelli wrote:
> Rebuilding of root domains accounting information (total_bw) is
> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> is that the way we keep track of domain changes and try to add bandwidth
> back is convoluted and fragile.
>
> Fix it by simplify things by making sure bandwidth accounting is cleared
> and completely restored after root domains changes (after root domains
> are again stable).
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched/deadline.h |  4 ++++
>   include/linux/sched/topology.h |  2 ++
>   kernel/cgroup/cpuset.c         | 16 +++++++++-------
>   kernel/sched/deadline.c        | 16 ++++++++++------
>   kernel/sched/topology.c        |  1 +
>   5 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 6ec578600b24..a780068aa1a5 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
>   struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
>   extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain_cpu(int cpu);
> +
> +extern u64 dl_cookie;
> +extern bool dl_bw_visited(int cpu, u64 gen);
>   
>   #endif /* CONFIG_SMP */
>   
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 7f3dbafe1817..1622232bd08b 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -166,6 +166,8 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
>   	return to_cpumask(sd->span);
>   }
>   
> +extern void dl_rebuild_rd_accounting(void);
> +
>   extern void partition_sched_domains_locked(int ndoms_new,
>   					   cpumask_var_t doms_new[],
>   					   struct sched_domain_attr *dattr_new);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f87526edb2a4..f66b2aefdc04 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,10 +954,12 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>   	css_task_iter_end(&it);
>   }
>   
> -static void dl_rebuild_rd_accounting(void)
> +void dl_rebuild_rd_accounting(void)
>   {
>   	struct cpuset *cs = NULL;
>   	struct cgroup_subsys_state *pos_css;
> +	int cpu;
> +	u64 cookie = ++dl_cookie;
>   
>   	lockdep_assert_held(&cpuset_mutex);
>   	lockdep_assert_cpus_held();
> @@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
>   
>   	rcu_read_lock();
>   
> -	/*
> -	 * Clear default root domain DL accounting, it will be computed again
> -	 * if a task belongs to it.
> -	 */
> -	dl_clear_root_domain(&def_root_domain);
> +	for_each_possible_cpu(cpu) {
> +		if (dl_bw_visited(cpu, cookie))
> +			continue;
> +
> +		dl_clear_root_domain_cpu(cpu);
> +	}
>   
>   	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>   
> @@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   {
>   	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	dl_rebuild_rd_accounting();
>   	sched_domains_mutex_unlock();
>   }

With this patch, partition_and_rebuild_sched_domains() is essentially 
the same as partition_sched_domains(). We can remove 
partition_and_rebuild_sched_domains() and use partition_sched_domains() 
directly. Also we don't need to expose partition_sched_domains_locked() 
as well as there is no more caller outside of topology.c.

Cheers,
Longman

>   
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 339434271cba..17b040c92885 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	}
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 cookie)
> +bool dl_bw_visited(int cpu, u64 cookie)
>   {
>   	struct root_domain *rd = cpu_rq(cpu)->rd;
>   
> @@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
>   	return SCHED_CAPACITY_SCALE;
>   }
>   
> -static inline bool dl_bw_visited(int cpu, u64 cookie)
> +bool dl_bw_visited(int cpu, u64 cookie)
>   {
>   	return false;
>   }
> @@ -2981,18 +2981,22 @@ void dl_clear_root_domain(struct root_domain *rd)
>   	rd->dl_bw.total_bw = 0;
>   
>   	/*
> -	 * dl_server bandwidth is only restored when CPUs are attached to root
> -	 * domains (after domains are created or CPUs moved back to the
> -	 * default root doamin).
> +	 * dl_servers are not tasks. Since dl_add_task_root_domanin ignores
> +	 * them, we need to account for them here explicitly.
>   	 */
>   	for_each_cpu(i, rd->span) {
>   		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
>   
>   		if (dl_server(dl_se) && cpu_active(i))
> -			rd->dl_bw.total_bw += dl_se->dl_bw;
> +			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
>   	}
>   }
>   
> +void dl_clear_root_domain_cpu(int cpu)
> +{
> +	dl_clear_root_domain(cpu_rq(cpu)->rd);
> +}
> +
>   #endif /* CONFIG_SMP */
>   
>   static void switched_from_dl(struct rq *rq, struct task_struct *p)
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b70d6002bb93..bdfda0ef1bd9 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2796,6 +2796,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   	ndoms_cur = ndoms_new;
>   
>   	update_sched_domain_debugfs();
> +	dl_rebuild_rd_accounting();
>   }
>   
>   /*


