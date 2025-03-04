Return-Path: <linux-kernel+bounces-544588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8942A4E2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825C8169AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509C27C140;
	Tue,  4 Mar 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMDc0gyi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E257284B5E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100764; cv=none; b=RTcR5JqS9qOVyajS1allrhlY0J0IpNJY6Q1OYPcr/Fgl1GuEpi4CkKqnCtgw1HlAnIzSOigXhYTaJ5jnbmEXriyc/8/d7eCFgb4Ge4eAsaAd8aXbDjyo6ndXxcD6vTYBQQSjlvnmkRhy5RxuG9VDVRtsuvTuuX82gJLpDxkvaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100764; c=relaxed/simple;
	bh=Ausz82rABUmsFDHngVFigCx2TfyazEHTkTJOWZT6A/k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M9siC+XABIIZZCvogGMuftp0ecRScLbNeL3Y05ytn4jVzh2iu0QbaZkzRAhrYDSL1o0AsmUnOvLKks/iIRMz9IjPfGEdwOhqmUGhuVnzL5UvAS5viWQVEojy7E9W+X530dKRfkRABazsLnZe9Di7Ma6qUtLzEzH4w1/SUA2C1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMDc0gyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741100760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLtWpbvMEFCI7y1aGgi0AZHDOLR7+yjwGF1He+h1A9c=;
	b=QMDc0gyieqycWLhfm59xzzf1Ottu3RlPe+5hTWjTjQx780soU5A3sVKl/aoIC5pqO2D1oB
	XV+OEEAJHt13AUv098XhDNwFdAqm/NSmm7dSFn72qUgXjZH0BMHfcwFU2WUebKpSZmvY4e
	m5zASs4Yq6jZ1ftY5D0mh/NgTqoSGJs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-T7HCdpznOQCH_IdULhQBAw-1; Tue, 04 Mar 2025 10:05:59 -0500
X-MC-Unique: T7HCdpznOQCH_IdULhQBAw-1
X-Mimecast-MFC-AGG-ID: T7HCdpznOQCH_IdULhQBAw_1741100759
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-471f4381c1eso136085841cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100758; x=1741705558;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLtWpbvMEFCI7y1aGgi0AZHDOLR7+yjwGF1He+h1A9c=;
        b=Z8ycsWfxew5YQyYMVKORGMnUhI/s2EeGXR4jFWJvoboHxeTHKQ3wYt1RuwPLKvdlgW
         bhxnc7Dbdo3ZDTLisSxqpNvyXGHqgLb+t6uCpHFJD9tNYMeePj5ZrsnX4XV7nSQKrWhO
         KhjqhVIHAI895NCZWnc5vE/nWkVKqr4bZ/pHd/s/EkqN8Sl5yzun/+6fu8l2/ee1DvFx
         kLgajNNxbyQQu93UCKZDqjT3ujdkVsqOWgmdAyvWihbz3XSce8gVrm7iq9LMuf6JHVcK
         hT2QN+EIvRi8n/GfE2LJulDTir0aZmuaGSWUYR8OFI3C57IzfJ80/0eFKO/mvTqURNSR
         lIRA==
X-Forwarded-Encrypted: i=1; AJvYcCWcn4i1cPfFMKIlIvRR6HulIiiXKtF8addcfRrcT5iHV+p6+DNQWQ0hjNJs6bgmCO1RlgeU0wHMATcjX/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJFqUrS1ACMIRJWc7S3goPaQPxixdtDfM0aHnUF1a/6vxVFLL
	gmD4CyNP3fPXdYA4u/tUL7QpGFOFSzVolW21Zlc43ihDQIShcg15r2uoi7+CDsGxyRbeG4FnVQk
	+91rCtgw/sbBQUbI7HZFVTBHjX23xB63T/IoIjBde43cF7DSAAMpgWNx23LOa3lvfSzhayQ==
X-Gm-Gg: ASbGncuxItXBwiEuSP6lAkrXIrJBhvsPe8GALzttNybi84aiWNOMSvyk0ZuWcEgo+2t
	P38iglVaGI5ldty+E+1QwvDBySbSqOapSumRfUbhP53F3NxLb0pCIbwC/GydLWZRGgGEpFnif+4
	pvYNqK64SMEsUZixthG5StNJIrCi7tTVkR9q+U64p9f8BNPo1Y6gAAapZLe91ZN/ai0SfBYU6S0
	/ePqjxDrp0uL7okU6uHb2LtagtCHeMW7I2soK1AN5yiPDTuliLjOmQJc7r4pRt6Ocui7Piq7Cgx
	uUmGj1d91Q0oyRBx2nb8akvb4o3pCETkbUTwn7oC8uvKex1a4aVhUcXTYpc=
X-Received: by 2002:a05:622a:1187:b0:471:ef27:a316 with SMTP id d75a77b69052e-474bc0a9120mr240046811cf.25.1741100757693;
        Tue, 04 Mar 2025 07:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmxjoZQ+WwtQaBwoBtwwt7AY0W0M6nAO4E7HJDDlK+Q2gc9JnNsbTlz0jrKkabcpqb1EUUcQ==
X-Received: by 2002:a05:622a:1187:b0:471:ef27:a316 with SMTP id d75a77b69052e-474bc0a9120mr240046361cf.25.1741100757124;
        Tue, 04 Mar 2025 07:05:57 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474fd8ce3bbsm11094961cf.59.2025.03.04.07.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:05:56 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
Date: Tue, 4 Mar 2025 10:05:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
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
 <20250304084045.62554-3-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250304084045.62554-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 3:40 AM, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched.h   |  2 ++
>   kernel/cgroup/cpuset.c  |  4 ++--
>   kernel/sched/core.c     |  4 ++--
>   kernel/sched/debug.c    |  8 ++++----
>   kernel/sched/topology.c | 17 +++++++++++++++--
>   5 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d..d5f8c161d852 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -383,6 +383,8 @@ enum uclamp_id {
>   extern struct root_domain def_root_domain;
>   extern struct mutex sched_domains_mutex;
>   #endif
> +extern void sched_domains_mutex_lock(void);
> +extern void sched_domains_mutex_unlock(void);
>   

If all access to sched_domains_mutex is through the wrappers, we may not 
need to expose sched_domains_mutex at all. Also it is more efficient for 
the non-SMP case to put the wrappers inside the CONFIG_SMP block and 
define the empty inline functions in the else part.


>   struct sched_param {
>   	int sched_priority;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0f910c828973..f87526edb2a4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -994,10 +994,10 @@ static void
>   partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   				    struct sched_domain_attr *dattr_new)
>   {
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>   	dl_rebuild_rd_accounting();
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   }
>   
>   /*
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9aecd914ac69..7b14500d731b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8424,9 +8424,9 @@ void __init sched_init_smp(void)
>   	 * CPU masks are stable and all blatant races in the below code cannot
>   	 * happen.
>   	 */
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	sched_init_domains(cpu_active_mask);
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   
>   	/* Move init over to a non-isolated CPU */
>   	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index ef047add7f9e..a0893a483d35 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -292,7 +292,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
>   	bool orig;
>   
>   	cpus_read_lock();
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   
>   	orig = sched_debug_verbose;
>   	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
> @@ -304,7 +304,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
>   		sd_dentry = NULL;
>   	}
>   
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   	cpus_read_unlock();
>   
>   	return result;
> @@ -515,9 +515,9 @@ static __init int sched_init_debug(void)
>   	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
>   	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
>   
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	update_sched_domain_debugfs();
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   #endif
>   
>   #ifdef CONFIG_NUMA_BALANCING
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..e2b879ec9458 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -6,6 +6,19 @@
>   #include <linux/bsearch.h>
>   
>   DEFINE_MUTEX(sched_domains_mutex);
> +#ifdef CONFIG_SMP
> +void sched_domains_mutex_lock(void)
> +{
> +	mutex_lock(&sched_domains_mutex);
> +}
> +void sched_domains_mutex_unlock(void)
> +{
> +	mutex_unlock(&sched_domains_mutex);
> +}
> +#else
> +void sched_domains_mutex_lock(void) { }
> +void sched_domains_mutex_unlock(void) { }
> +#endif
>   
>   /* Protected by sched_domains_mutex: */
>   static cpumask_var_t sched_domains_tmpmask;
> @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   			     struct sched_domain_attr *dattr_new)
>   {
> -	mutex_lock(&sched_domains_mutex);
> +	sched_domains_mutex_lock();
>   	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	mutex_unlock(&sched_domains_mutex);
> +	sched_domains_mutex_unlock();
>   }

There are two "lockdep_assert_held(&sched_domains_mutex);" statements in 
topology.c file and one in cpuset.c. That can be problematic in the 
non-SMP case. Maybe another wrapper to do the assert?

Cheers,
Longman



