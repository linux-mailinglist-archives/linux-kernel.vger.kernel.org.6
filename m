Return-Path: <linux-kernel+bounces-331319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D997AB40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60349B25413
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9D49634;
	Tue, 17 Sep 2024 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eyz5V3dJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C34174A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553090; cv=none; b=qq8m8v37ITvR2fq5+lMnXNa6+n9cNVN8jnDhofo3n5NtiKVsjgavtH5x6TJt+bHegTh08mcrtERwkbLtbGiirVHMci6PghnDR2eUmBqEZ6jG18FXHazd6rxHsXZisBNbHDQUEWZ50tfg7NMtys89YBE0dNKJGdFjzZLOCtfWP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553090; c=relaxed/simple;
	bh=T8jN8uIqnVIuytMyftLQA1cByWItBknUN5J+DtGe/eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6rsguPLB9Hb27Q1RUsWrx0M3tqFKlABx3WbnO0/IJftL7kDfUn+SZEZCS4Wp+YU4yUxIlMBSZRnMv6NahcoZ3xP+sjSb4lie1ZeWZWkUUTVANjR1Mca0rEDvUgvPJIggwu3uYOzNqVxdiPlzMvNuRUP3crVOAndkW2nhiBYsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eyz5V3dJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so32868135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726553085; x=1727157885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+QHYq7633zmakbskovpL4u4ejDhGKehunkMUdAo+20=;
        b=eyz5V3dJxe5aMz8/xL54eYc13n8sd1rDXAOM6W2Fb3XtMoWoOnfMrMG7P7ZRkswa8j
         MMtR3zfIskwA9gLVyNm7wJgVRPbkIDvKcu9R/f3ssC0Gg1MfujBz2bfO6y6JT9ye1tOG
         ImUDIFqeGcqpQtz0f2PCjJlgAtMpXYesiguh4Cdu/WWtblAA2dE9pMLke2da0FBKmflO
         wwsAEVt3xhkwlevMWUAhLGKUuuaHAaOlXCFsIoUnO2l06a1iVTO0weBFg94gb0ZgKPl4
         GZmSQRlJRYfGpvF972mpuGDJqfkGy6DVkhpktpw1w9foST/pqsOg/gt+anyD/TiIb0ks
         f8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726553085; x=1727157885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+QHYq7633zmakbskovpL4u4ejDhGKehunkMUdAo+20=;
        b=uBDXa8OeBOS0pXoTc563f2yjtk0MB/YD9OaeNykCxbVowgImQjsw3Y6Ngxe0b7RV3m
         7dNsAd/ofKr885N/moX4m/6Z4Kz9freKzm90II76XXJlApZLMNn8Q5paqjdN8P8gSxaJ
         O8BCHR62d9XQVAxkHFVAk/HllTCpRx4KFjWy4fHd6oCAFaUMSqLipKLAysiZW0sMprhy
         zESdbQizNOoWH0bz/0/88dl0L5Q9CHxYRSM9/MlhfrvFNx8oC5oC6wIW2ZGMC8Y2kRRx
         Q3d5HFMbLqdfn1L1u4pR/hs8YLdi7BL4vAAFchGM3mTNv6FtRZIvOxaCO0MIXkkY3P4T
         UEJw==
X-Gm-Message-State: AOJu0Yxk+ipvckjrTagZvgu1VsysClmtHn5Kfl8Ga0HKp2cIfk2z5Ium
	Ocx/MIUrFpvxVlP9qyq4nwADxfOx0vYzS/ChseN9N27xOlEr2iTQ9WKOM4DdBXY=
X-Google-Smtp-Source: AGHT+IHETGMgx1Yh32zfGXj9vccCNdLbPLd/l1Gn7bQOQ4puEMDXLSWmyvdFQeTf4t7KbDZsWtv0Dg==
X-Received: by 2002:a05:600c:4e8c:b0:42c:c37b:4d53 with SMTP id 5b1f17b1804b1-42d86cdba37mr83900355e9.0.1726553085295;
        Mon, 16 Sep 2024 23:04:45 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054f97sm127329025e9.4.2024.09.16.23.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:04:45 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:04:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/19] mm: Create/affine kcompactd to its preferred node
Message-ID: <Zukb_FEVRllBDhKO@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-14-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916224925.20540-14-frederic@kernel.org>

On Tue 17-09-24 00:49:17, Frederic Weisbecker wrote:
> Kcompactd is dedicated to a specific node. As such it wants to be
> preferrably affine to it, memory and CPUs-wise.
> 
> Use the proper kthread API to achieve that. As a bonus it takes care of
> CPU-hotplug events and CPU-isolation on its behalf.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Clear simplification, thanks!

> ---
>  mm/compaction.c | 43 +++----------------------------------------
>  1 file changed, 3 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index eb95e9b435d0..69742555f2e5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -3179,15 +3179,9 @@ void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx)
>  static int kcompactd(void *p)
>  {
>  	pg_data_t *pgdat = (pg_data_t *)p;
> -	struct task_struct *tsk = current;
>  	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
>  	long timeout = default_timeout;
>  
> -	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> -
> -	if (!cpumask_empty(cpumask))
> -		set_cpus_allowed_ptr(tsk, cpumask);
> -
>  	set_freezable();
>  
>  	pgdat->kcompactd_max_order = 0;
> @@ -3258,10 +3252,12 @@ void __meminit kcompactd_run(int nid)
>  	if (pgdat->kcompactd)
>  		return;
>  
> -	pgdat->kcompactd = kthread_run(kcompactd, pgdat, "kcompactd%d", nid);
> +	pgdat->kcompactd = kthread_create_on_node(kcompactd, pgdat, nid, "kcompactd%d", nid);
>  	if (IS_ERR(pgdat->kcompactd)) {
>  		pr_err("Failed to start kcompactd on node %d\n", nid);
>  		pgdat->kcompactd = NULL;
> +	} else {
> +		wake_up_process(pgdat->kcompactd);
>  	}
>  }
>  
> @@ -3279,30 +3275,6 @@ void __meminit kcompactd_stop(int nid)
>  	}
>  }
>  
> -/*
> - * It's optimal to keep kcompactd on the same CPUs as their memory, but
> - * not required for correctness. So if the last cpu in a node goes
> - * away, we get changed to run anywhere: as the first one comes back,
> - * restore their cpu bindings.
> - */
> -static int kcompactd_cpu_online(unsigned int cpu)
> -{
> -	int nid;
> -
> -	for_each_node_state(nid, N_MEMORY) {
> -		pg_data_t *pgdat = NODE_DATA(nid);
> -		const struct cpumask *mask;
> -
> -		mask = cpumask_of_node(pgdat->node_id);
> -
> -		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
> -			/* One of our CPUs online: restore mask */
> -			if (pgdat->kcompactd)
> -				set_cpus_allowed_ptr(pgdat->kcompactd, mask);
> -	}
> -	return 0;
> -}
> -
>  static int proc_dointvec_minmax_warn_RT_change(const struct ctl_table *table,
>  		int write, void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -3362,15 +3334,6 @@ static struct ctl_table vm_compaction[] = {
>  static int __init kcompactd_init(void)
>  {
>  	int nid;
> -	int ret;
> -
> -	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -					"mm/compaction:online",
> -					kcompactd_cpu_online, NULL);
> -	if (ret < 0) {
> -		pr_err("kcompactd: failed to register hotplug callbacks.\n");
> -		return ret;
> -	}
>  
>  	for_each_node_state(nid, N_MEMORY)
>  		kcompactd_run(nid);
> -- 
> 2.46.0

-- 
Michal Hocko
SUSE Labs

