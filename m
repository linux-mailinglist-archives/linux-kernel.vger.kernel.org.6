Return-Path: <linux-kernel+bounces-228412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5B915F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FF0285753
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965714A0B8;
	Tue, 25 Jun 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Soy6e70l"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18034148828
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299263; cv=none; b=W9XPPRgQgUldrkjtCuvsWlXNtLoevvQ059yR/t2189Arjt4Aq27MEDC/oRHop74mlWffS+V3O6wyAh4vAfMkJjHWtAu88Y0RTIrzfW4eQAKpNXzn/PEY8N0h0Ue7sFLo7xL7E+BYpxo0m+u7NhEnmMhQp79C93+P2Kx05q+DDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299263; c=relaxed/simple;
	bh=4bOL+5Xjq1nEBBLj1FDD4myqDY/JwRv3gbU+lA0lOFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQQr7JXDleKi62D6XXONaBjQk9AECpx3vDwtpv8fYy4QHtVTkv2Et0rikRnHX+u1nLmB8WM7Q7/JQs/jO0XuZQ1KwY0ZwiDurAMGAyXh/8V0r4W2l61mw4UotqNSfjAiWSGTQ3mVX6Yk/E0NJvmJBQfejWJ4spKQp/pMWVxyLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Soy6e70l; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a70c0349b64so267695266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299259; x=1719904059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0V+eWwqaASepMhn2+Ez8y9ZYspqA/o2g8lqAxiVCQ=;
        b=Soy6e70liv3jd4zHbyk2wPiU0zmAw52vyKJyTOTexgkxqtydEhJ/74dLqkdGnt1r6u
         FZiW4IYEDSWPVkb45Hpw90G19oSHBbWTK3uD2OVJMMYmNfvvIfxdQNisPNTikCRvGCOo
         NxqUnPV3XyBpxRHXHwdOOAGPr1hOwSHnJf3u39sywl0izblQ+JAffoyHO/CkuPDZnMx4
         DBa3VVJgp4u+XnvIRMHKZa1K6VPqt31J/OLFcPubk803D78XOu7BRuNHnCTrSLfyIK3O
         v9j2JpZqTC330oRa1JD5x6lz8209qceisq4Mtz1lU8ICFLMJBBXu4zQkYA5NkzbVXXYi
         7NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299259; x=1719904059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R0V+eWwqaASepMhn2+Ez8y9ZYspqA/o2g8lqAxiVCQ=;
        b=Otbvr+BEs/Z0E+pZn+gVWjjDa3KujoSwd64F6/aAp7mFFx0NwMENXrM1xA7CH8ShwC
         ervY2KNEmS2Hi5u1bGzZGRdXab7UrzxMlWacT4/omWuWtTOTjWjVWhYxhPErd2URoR8U
         +Pq4vmd9totmqZV9rjgSn1cWllXnaSssTI1W8jOnE2KSSd0DNODDLukwZyeJjMuEjryW
         RziftMfwp8z2gE8iCJJS8g4ofJVMV3J7rnqxmyDq44E+8NZXC7oH1X5cfZH6mKGbin/W
         8q0tfy6IlDICLFEW/09jdoM+WjUvUS2nKKGZT8zCLmdqNTxSu0IUUyljL58VZH+fiyim
         6J5w==
X-Forwarded-Encrypted: i=1; AJvYcCXYhRFXGmptBrrfrkpS4GRDdDFTiST/tNwbx1P120FqcUsQ82/qRAPgE1P/Zc86NLpqxjGCfJAAJq9waBk6OvCBYeVGNYtc9VojAafG
X-Gm-Message-State: AOJu0YwgHm8Xw71Jn2Gqv1nKoReTOiPGFoEYP0JP8Mna1NeXwrtXIwsw
	iVVrW5fgguPsnPUXofLBndTAcwucuOtvV645yaDnx/cHq9lfXe7w/z7DUm/P4cs=
X-Google-Smtp-Source: AGHT+IFc//gmedhEDbGQAgTUfiuzQY8eRC6RP8S5oW2aencflGku5g/e8Wiz0KlIcuoUBNhnAoSo6Q==
X-Received: by 2002:a17:906:4904:b0:a72:5bbf:efc8 with SMTP id a640c23a62f3a-a725bbff18amr215737366b.62.1719299259422;
        Tue, 25 Jun 2024 00:07:39 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725efd0e18sm116473666b.195.2024.06.25.00.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:07:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:07:38 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/14] mm: memcg: rename charge move-related functions
Message-ID: <ZnpsujHxD2_bg_D8@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-6-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:57, Roman Gushchin wrote:
> Rename exported function related to the charge move to have
> the memcg1_ prefix.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 14 +++++++-------
>  mm/memcontrol-v1.h |  8 ++++----
>  mm/memcontrol.c    |  8 ++++----
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index f4c8bec5ae1b..c25e038ac874 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -384,7 +384,7 @@ static bool mem_cgroup_under_move(struct mem_cgroup *memcg)
>  	return ret;
>  }
>  
> -bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> +bool memcg1_wait_acct_move(struct mem_cgroup *memcg)
>  {
>  	if (mc.moving_task && current != mc.moving_task) {
>  		if (mem_cgroup_under_move(memcg)) {
> @@ -1056,7 +1056,7 @@ static void mem_cgroup_clear_mc(void)
>  	mmput(mm);
>  }
>  
> -int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> +int memcg1_can_attach(struct cgroup_taskset *tset)
>  {
>  	struct cgroup_subsys_state *css;
>  	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
> @@ -1126,7 +1126,7 @@ int mem_cgroup_can_attach(struct cgroup_taskset *tset)
>  	return ret;
>  }
>  
> -void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
> +void memcg1_cancel_attach(struct cgroup_taskset *tset)
>  {
>  	if (mc.to)
>  		mem_cgroup_clear_mc();
> @@ -1285,7 +1285,7 @@ static void mem_cgroup_move_charge(void)
>  	atomic_dec(&mc.from->moving_account);
>  }
>  
> -void mem_cgroup_move_task(void)
> +void memcg1_move_task(void)
>  {
>  	if (mc.to) {
>  		mem_cgroup_move_charge();
> @@ -1294,14 +1294,14 @@ void mem_cgroup_move_task(void)
>  }
>  
>  #else	/* !CONFIG_MMU */
> -static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
> +int memcg1_can_attach(struct cgroup_taskset *tset)
>  {
>  	return 0;
>  }
> -static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
> +void memcg1_cancel_attach(struct cgroup_taskset *tset)
>  {
>  }
> -static void mem_cgroup_move_task(void)
> +void memcg1_move_task(void)
>  {
>  }
>  #endif
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 55e7c4f90c39..d377c0be9880 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -29,11 +29,11 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
>  void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
>  
> -bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg);
> +bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
>  struct cgroup_taskset;
> -int mem_cgroup_can_attach(struct cgroup_taskset *tset);
> -void mem_cgroup_cancel_attach(struct cgroup_taskset *tset);
> -void mem_cgroup_move_task(void);
> +int memcg1_can_attach(struct cgroup_taskset *tset);
> +void memcg1_cancel_attach(struct cgroup_taskset *tset);
> +void memcg1_move_task(void);
>  
>  struct cftype;
>  u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3332c89cae2e..da2c0fa0de1b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2582,7 +2582,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * At task move, charge accounts can be doubly counted. So, it's
>  	 * better to wait until the end of task_move if something is going on.
>  	 */
> -	if (mem_cgroup_wait_acct_move(mem_over_limit))
> +	if (memcg1_wait_acct_move(mem_over_limit))
>  		goto retry;
>  
>  	if (nr_retries--)
> @@ -6030,12 +6030,12 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.css_free = mem_cgroup_css_free,
>  	.css_reset = mem_cgroup_css_reset,
>  	.css_rstat_flush = mem_cgroup_css_rstat_flush,
> -	.can_attach = mem_cgroup_can_attach,
> +	.can_attach = memcg1_can_attach,
>  #if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
>  	.attach = mem_cgroup_attach,
>  #endif
> -	.cancel_attach = mem_cgroup_cancel_attach,
> -	.post_attach = mem_cgroup_move_task,
> +	.cancel_attach = memcg1_cancel_attach,
> +	.post_attach = memcg1_move_task,
>  #ifdef CONFIG_MEMCG_KMEM
>  	.fork = mem_cgroup_fork,
>  	.exit = mem_cgroup_exit,
> -- 
> 2.45.2
> 

-- 
Michal Hocko
SUSE Labs

