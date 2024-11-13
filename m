Return-Path: <linux-kernel+bounces-407968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E949C7811
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FEF286936
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4854158DC0;
	Wed, 13 Nov 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiIRvvPK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79813CA81
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513660; cv=none; b=koJf+sfuev3X2n5w3fatWTsLpu3OmfRU7tyJV662s4aUxSesJYfn/cQIBiw/1z6fIc9nMd0iDUXMG0WLRUxX7OxdRHIJPohHWAhpcY6Nn8sBoq+iuzNKMAdALf926CSor0ZCxo8TH6N9LQb9J8meUkueNlm3mNWOeDw5dStu+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513660; c=relaxed/simple;
	bh=+Slv5CC/4TAzKjLZg0OGlTnIZZ5EzRic/m8KO2N0W5I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DxUT9bkSnYAeSaQgHTdwIAa9ictvla2HQMu5DtCqgE0k7/qBVo/O2Rw92mzUXHKNjpH3SWjrkkrSc7z7wMPJpYK9R2eH3kCz+vQpDQBSyfBhYOMIWHfWi5bYZ9tTndlQyQ+a+TEPZyiLLD/QjeFlNWrj09gpTn9EVrh0gJClYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiIRvvPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731513658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWQPA9RVyE5frZ47nu2bneN1jwH5ernfdKrCSBJzB7o=;
	b=TiIRvvPKFt7j15AH3nG7J2fpKci/p+zKYWOhis63PY3ixIgBtuzJthZJEFekXugHNCf0/T
	jWGJ7it7srReNNOBLi3milQTmen8Ac9V+io7dA9VEq1lWXTBWJJvnp+1FN5sBmqrsxWujG
	QLGhweEOhp6P7QXRROJ/BERshYpVnv4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-VmcSG_kGOZSuG_u874Mf9A-1; Wed, 13 Nov 2024 11:00:57 -0500
X-MC-Unique: VmcSG_kGOZSuG_u874Mf9A-1
X-Mimecast-MFC-AGG-ID: VmcSG_kGOZSuG_u874Mf9A
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6ea8901dff1so135320717b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513651; x=1732118451;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWQPA9RVyE5frZ47nu2bneN1jwH5ernfdKrCSBJzB7o=;
        b=L96w2eqeiYRGZetaWBDkqmVCvNlUfrxvuGwrFpj6Uma1z5hw4Z3y3QrUHkYFF4GugQ
         zIydgWNqc3twrHS5xwjtd9dPzzyE+D0x0cFTFk/InTsOIXfO+qJmWX7MM8sBkoQxQ5P/
         jTNr1AaSkp2j5jECgaRgHiygcJYEswk8d5y2ueOTV1i0xEy+kYjinnACWGokbGLr7mq/
         A9Jc2I7x2GHuRAp6bWX/4CDVtQ54p5EES2E5s9mZvcRsoL8aY10mJE+G+8kOlb41XrL4
         8nGfwj5HE9Oyd+WUStX+3T9wtafHgGXm9yoRIzQQtujm+x01anC/oV7c8N+WFCpzJi9M
         0MNw==
X-Forwarded-Encrypted: i=1; AJvYcCUdIsB7H8n+1gobErZhvrFz09hBP9n4hGyA4IzLepv5tEQM0bLxag9v2fkWOHIArleQ2ag3AuvdkNUor68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcngrd/7Xyo+NkPBtUhHAOSeMx+S7cTACL2eJb7Kd9lKpJmd58
	BwRQXlN9+o/qwbn9FZTS7fbwwvG5cax6vOHM8qGWFVIiEIHm9pCObbY0ysKZs1s0jAwuF0fVP8r
	MDmU9PWUWOJUICqiKJ4s2rHUUXgp3AOFhTyEf8RS+9nQD5LiVGYxapPQVn+5wJiVKNSATYA==
X-Received: by 2002:a05:690c:4b8d:b0:6c3:7d68:b400 with SMTP id 00721157ae682-6eaddd98d0fmr210846747b3.10.1731513651295;
        Wed, 13 Nov 2024 08:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxWWUuPKP0t2ZZvJuTp9gzfR0PFWGV7zxdTg/WhdiX/MmEftHmL8gY4oQmepjvJnQv3ILkxA==
X-Received: by 2002:a05:6e02:160b:b0:3a3:4164:eec9 with SMTP id e9e14a558f8ab-3a6f1a15cb8mr236895055ab.14.1731513639554;
        Wed, 13 Nov 2024 08:00:39 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f9cd1sm2841953173.140.2024.11.13.08.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:00:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4a388ba7-8533-4c86-9135-883451f65065@redhat.com>
Date: Wed, 13 Nov 2024 11:00:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/deadline: Restore dl_server bandwidth on
 non-destructive root domain changes
To: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-2-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20241113125724.450249-2-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 7:57 AM, Juri Lelli wrote:
> When root domain non-destructive changes (e.g., only modifying one of
> the existing root domains while the rest is not touched) happen we still
> need to clear DEADLINE bandwidth accounting so that it's then properly
> restore taking into account DEADLINE tasks associated to each cpuset
> (associated to each root domain). After the introduction of dl_servers,
> we fail to restore such servers contribution after non-destructive
> changes (as they are only considered on destructive changes when
> runqueues are attached to the new domains).
>
> Fix this by making sure we iterate over the dl_server attached to
> domains that have not been destroyed and add them bandwidth contribution
> back correctly.
>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched/deadline.h |  2 +-
>   kernel/cgroup/cpuset.c         |  2 +-
>   kernel/sched/deadline.c        | 18 +++++++++++++-----
>   kernel/sched/topology.c        | 10 ++++++----
>   4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index 3a912ab42bb5..82c966a55856 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -33,7 +33,7 @@ static inline bool dl_time_before(u64 a, u64 b)
>   
>   struct root_domain;
>   extern void dl_add_task_root_domain(struct task_struct *p);
> -extern void dl_clear_root_domain(struct root_domain *rd);
> +extern void dl_clear_root_domain(struct root_domain *rd, bool restore);
>   
>   #endif /* CONFIG_SMP */
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 142303abb055..4d3603a99db3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -954,7 +954,7 @@ static void dl_rebuild_rd_accounting(void)
>   	 * Clear default root domain DL accounting, it will be computed again
>   	 * if a task belongs to it.
>   	 */
> -	dl_clear_root_domain(&def_root_domain);
> +	dl_clear_root_domain(&def_root_domain, false);
>   
>   	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>   
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ce93d0bf452..e53208a50279 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2968,13 +2968,21 @@ void dl_add_task_root_domain(struct task_struct *p)
>   	task_rq_unlock(rq, p, &rf);
>   }
>   
> -void dl_clear_root_domain(struct root_domain *rd)
> +void dl_clear_root_domain(struct root_domain *rd, bool restore)
>   {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
> +	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
>   	rd->dl_bw.total_bw = 0;
> -	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
> +
> +	if (restore) {
> +		int i;
> +
> +		for_each_cpu(i, rd->span) {
> +			struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
> +
> +			if (dl_server(dl_se))
> +				rd->dl_bw.total_bw += dl_se->dl_bw;
> +		}
> +	}
>   }
>   
>   #endif /* CONFIG_SMP */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..e9e7a7c43dd6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2721,12 +2721,14 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>   
>   				/*
>   				 * This domain won't be destroyed and as such
> -				 * its dl_bw->total_bw needs to be cleared.  It
> -				 * will be recomputed in function
> -				 * update_tasks_root_domain().
> +				 * its dl_bw->total_bw needs to be cleared.
> +				 * Tasks contribution will be then recomputed
> +				 * in function dl_update_tasks_root_domain(),
> +				 * dl_servers contribution in function
> +				 * dl_restore_server_root_domain().
>   				 */
>   				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
> -				dl_clear_root_domain(rd);
> +				dl_clear_root_domain(rd, true);
>   				goto match1;
>   			}
>   		}

With my limited understanding of the deadline code, this change looks 
reasonable to me. dl_rebuild_rd_accounting() is a part of the cpuset 
code that is seldom touched. So I don't think this particular hunk will 
cause any merge conflict. So it can be carried in the tip tree.

Acked-by: Waiman Long <longman@redhat.com>


