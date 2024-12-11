Return-Path: <linux-kernel+bounces-441768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFE9ED3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3B1610B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7921FF1B2;
	Wed, 11 Dec 2024 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqdxFQqI"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C901D6DA4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939012; cv=none; b=HEqW7BkOrJCRvGzayJT8JrFPiSTf9xBPI/ll6REL30l3JyrxUwSS6DEiDBUQZEtMBgPJcc5rAdHTehDFLgtQKAvxkHL4hE70OqQHpjrAqBIM0SvbWc2avM1fDJ5uhJQidQ5FzTQJ/2gql2k7cawIWHaKSIZLGKeKJjlXTvBihzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939012; c=relaxed/simple;
	bh=cEr/qqQUgmVCu78IO95yZkuBiVTRwRaaAfVivRCrUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9KBRqDgBfDYV8cP7gvcL96MMj7wH+RGCb+79tsHCTPmCqjqLe7LxvmuVdLfI4YGaJRSQukBEwuIVhhUwrPpNdf7yOfF98wj1HJLZ2EQr7g4Z9V7NdoHDHFseeupCHmfS1YffidSvBlP6DZ4S9+SW45VWPdHqlKTVR1MdrPiZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqdxFQqI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728d1a2f180so817137b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733939010; x=1734543810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKfwGZf3t30W3AvAZx55H+w/zcQCcR/FMX1vKa9UJjo=;
        b=CqdxFQqIn/LGnewyg+c5eY50KgruI7arINvdksQEBBv1R5FIDHYtWylofr+1YofxoB
         Rk/kwTGPWYXTrPsF+z5rEsNhqyP+ozk4KAzPWtPR8eWq83AGaUpFUPY0z4S/Du4f9TYK
         tN53bEKZMsm3LP4K2L1aeV74EZipzDFNzZfHmYrhuZ38gWs1EL5uKC0Q2UJUg8gw8UDy
         LpqsYrQSGVdjbC7oq3DVKmGQF2H9XzHA2zeZ1jiv8dnZBGRAWIi+qChVpx9osBrzitwG
         tCIZ+C66Hm/vwYdb6D5XFp0KIBBBFa8VgQyvp1w/SDBorhpcelV0D3pRlqbr2Lq8u6yu
         as3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939010; x=1734543810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKfwGZf3t30W3AvAZx55H+w/zcQCcR/FMX1vKa9UJjo=;
        b=mH3ZFRolZLRDr719FxmtVH8JRjNY+j1PYjK3oeyoWPjtZm+rfhlEA5RxHKNf7v9Tzl
         OLV7K6g6WOWbm0FSraTGDXsGfE0WXMHzaThmBxL8KDKGGydg1K8E/U8oeiH5UDszqnUP
         CG444uKtlys7BvCQd7Lc0T4IJmLm7uNkMyKWwKdR+K3KqQfLBsVmQ9IHepWXcxZwNMiH
         alAzAuFu578rWmEvJmeaqFlD8mWBMmHhQP/PslXDM10dd2QkqmUon3rHApN4K49VrNF/
         sViNbRwRn4A5a6ZTMhZXPn9pZMhYmphjYG03YhA6LwygE6LAoCtB9vrPzsuDOUW+wEA5
         0dNg==
X-Forwarded-Encrypted: i=1; AJvYcCXBGQGbA59pwYE9Im4EAGSaA54G97AydalPFU1xn1wd5XEt/T0heUrN8ZKYiTleuWLENPopOZA/SGlo7Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXwOLxHArVvkW4hDVtHCbnmaLm/cyTXpnRwoJLWMvor1rfoc9
	6NZm4dxnrRKrGex3X5yAchXzov/6BsXxZkN2LRwZoOW8vut+Wag/
X-Gm-Gg: ASbGncuEmE0c05RCDz5Xr7rMVEO9YrR2A4MI4RqZColzuIj8g5x6CgZ0MkqlsBk3Sy1
	TUfPFikc93K+yf2IcLuEllfAngKE2mo1K6+d2cxqJ+/I4+yallLG4Xo8cx0QDzrPB9vfung2Ufi
	TaowQiakTDs+XrJ8kqXtNTEFMm+E1W5FGp1eWOrHKLaxAz2kQ/ICsLtJkJPKkSZJzKZtvA8oiJ/
	1IjJDJs9UKy+4y2bRJpkmuwgiGFbfb4yNqvntg+80oug+tFQEFy5Q==
X-Google-Smtp-Source: AGHT+IHLIvTe9+eBtbDAg/Pj6Nw07rvJMNAIkxKGfuZfZx4pXL4Mq7QZbk53hptHUp2Ju3tnmIuTdw==
X-Received: by 2002:a05:6a00:852:b0:71e:60d9:910d with SMTP id d2e1a72fcca58-728fac7bf12mr81996b3a.6.1733939009845;
        Wed, 11 Dec 2024 09:43:29 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ede70e4dsm5708530b3a.93.2024.12.11.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:43:29 -0800 (PST)
Date: Wed, 11 Dec 2024 09:43:26 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched_ext: Introduce NUMA aware idle cpu kfunc
 helpers
Message-ID: <Z1nPPhe_83lBTna4@yury-ThinkPad>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209104632.718085-5-arighi@nvidia.com>

On Mon, Dec 09, 2024 at 11:40:58AM +0100, Andrea Righi wrote:
> Add the following kfunc's to provide scx schedulers direct access to
> per-node idle cpumasks information:
> 
>  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
>  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
>  s32 scx_bpf_pick_idle_cpu_node(int node,
>                                 const cpumask_t *cpus_allowed, u64 flags)
>  int scx_bpf_cpu_to_node(s32 cpu)
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c                       | 96 +++++++++++++++++++++++-
>  tools/sched_ext/include/scx/common.bpf.h |  4 +
>  tools/sched_ext/include/scx/compat.bpf.h | 19 +++++
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index d0d57323bcfc..ea7cc481782c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -433,6 +433,7 @@ struct sched_ext_ops {
>  	 * - scx_bpf_select_cpu_dfl()
>  	 * - scx_bpf_test_and_clear_cpu_idle()
>  	 * - scx_bpf_pick_idle_cpu()
> +	 * - scx_bpf_pick_idle_cpu_node()
>  	 *
>  	 * The user also must implement ops.select_cpu() as the default
>  	 * implementation relies on scx_bpf_select_cpu_dfl().
> @@ -955,6 +956,8 @@ static struct cpumask *get_idle_cpumask_node(int node)
>  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>  		return idle_masks[0]->cpu;
>  
> +	if (node < 0 || node >= num_possible_nodes())
> +		return NULL;

1. This sanity should go before the check above.
2. In-kernel users don't need to do sanity checks. BPF users should,
   but for them you need to move it in BPF wrapper.
3. -1 is a valid parameter, means NUMA_NO_NODE. 

>  	return idle_masks[node]->cpu;
>  }
>  
> @@ -963,6 +966,8 @@ static struct cpumask *get_idle_smtmask_node(int node)
>  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>  		return idle_masks[0]->smt;
>  
> +	if (node < 0 || node >= num_possible_nodes())
> +		return NULL;
>  	return idle_masks[node]->smt;
>  }
>  
> @@ -7469,6 +7474,16 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
>  	return nr_cpu_ids;
>  }
>  
> +/**
> + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> + */
> +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> +{
> +	if (cpu < 0 || cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +	return cpu_to_node(cpu);
> +}

I believe this wrapper should be declared somewhere in
kernel/sched/topology.c, and better be a separate patch.

> +
>  /**
>   * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
>   */
> @@ -7499,11 +7514,32 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
>  	 */
>  }
>  
> +/**
> + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
> + * per-CPU cpumask of a target NUMA node.
> + *
> + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> + * valid, or running on a UP kernel.
> + */
> +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> +{
> +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> +		scx_ops_error("built-in idle tracking is disabled");
> +		return cpu_none_mask;
> +	}
> +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("per-node idle tracking is disabled");
> +		return cpu_none_mask;
> +	}

Nub question: is it possible that scx_builtin_idle_per_node is enable,
but scx_builtin_idle_enabled not? From my naive perspective, we can't
enable per-node idle masks without enabling general idle masks. Or I
mislead it?

> +
> +	return get_idle_cpumask_node(node) ? : cpu_none_mask;
> +}
>  /**
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
>   * per-CPU cpumask of the current NUMA node.
>   *
> - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> + * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
> + * kernel.
>   */
>  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  {
> @@ -7515,12 +7551,35 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  	return get_curr_idle_cpumask();
>  }
>  
> +/**
> + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
> + * per-physical-core cpumask of a target NUMA node. Can be used to determine
> + * if an entire physical core is free.
> + *
> + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> + * valid, or running on a UP kernel.
> + */
> +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> +{
> +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> +		scx_ops_error("built-in idle tracking is disabled");
> +		return cpu_none_mask;
> +	}
> +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("per-node idle tracking is disabled");
> +		return cpu_none_mask;
> +	}

Can you add vertical spacing between blocks?

Also, because you use this construction more than once, I think it
makes sense to make it a helper.

> +
> +	return get_idle_smtmask_node(node) ? : cpu_none_mask;
> +}
> +
>  /**
>   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
>   * per-physical-core cpumask of the current NUMA node. Can be used to determine
>   * if an entire physical core is free.
>   *
> - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> + * Returns an empty cumask if idle tracking is not enabled, or running on a UP
> + * kernel.
>   */
>  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
>  {
> @@ -7569,6 +7628,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
>  		return false;
>  }
>  
> +/**
> + * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
> + * @node: target NUMA node
> + * @cpus_allowed: Allowed cpumask
> + * @flags: %SCX_PICK_IDLE_CPU_* flags
> + *
> + * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
> + * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
> + * was found.
> + *
> + * Unavailable if ops.update_idle() is implemented and
> + * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
> + * not set.
> + */
> +__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
> +				      u64 flags)
> +{

Sanity checks here?

> +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> +		scx_ops_error("built-in idle tracking is disabled");
> +		return -EBUSY;
> +	}
> +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> +		scx_ops_error("per-node idle tracking is disabled");
> +		return -EBUSY;
> +	}
> +
> +	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> +}
> +
>  /**
>   * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
>   * @cpus_allowed: Allowed cpumask
> @@ -7705,14 +7793,18 @@ BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
>  BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
> +BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
>  BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 625f5b046776..9bbf6d5083b5 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -59,14 +59,18 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
>  u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
>  void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
>  u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
> +int scx_bpf_cpu_to_node(s32 cpu) __ksym __weak;
>  const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
>  const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
>  void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
>  const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
> +const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
>  const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
> +const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
>  void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
>  bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
>  s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
> +s32 scx_bpf_pick_idle_cpu_node(int node, const cpumask_t *cpus_allowed, u64 flags) __ksym __weak;
>  s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index d56520100a26..587650490743 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -125,6 +125,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
>  	false;									\
>  })
>  
> +#define __COMPAT_scx_bpf_cpu_to_node(cpu)                                       \
> +	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?                                 \
> +	 scx_bpf_cpu_to_node(cpu) : 0)
> +
> +#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)                            \
> +	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?                       \
> +	 scx_bpf_get_idle_cpumask_node(node) :                                  \
> +	 scx_bpf_get_idle_cpumask())                                            \
> +
> +#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)                            \
> +	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?                       \
> +	 scx_bpf_get_idle_smtmask_node(node) :                                  \
> +	 scx_bpf_get_idle_smtmask())                                            \
> +
> +#define __COMPAT_scx_bpf_pick_idle_cpu_node(node, cpus_allowed, flags)          \
> +	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?                          \
> +	 scx_bpf_pick_idle_cpu_node(node, cpus_allowed, flags) :                \
> +	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variants for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> -- 
> 2.47.1

