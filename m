Return-Path: <linux-kernel+bounces-192514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CF8D1E59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1411C23099
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1116F84D;
	Tue, 28 May 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7vgjl/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5F16E895
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905958; cv=none; b=r985iDd5Xg04D7ScRR6QRm28ICvuqYIxbSgGE899lCreyMdB6l31PBEX2oObadTF/oOasF7YPrMgdJ9r4OkQBwH/mSf4q2c1/Bp8S3ad87120han9IzT7ZxZ5kSoGA/wh9zD/8p79kW2kW+k6WLHQHRJLbxkkz7vNRiuMPiqtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905958; c=relaxed/simple;
	bh=yuPDGgUn+VpqJiWJHL5pFexMSMO0h7DglLbUSyFNJ5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNgTugJqAleSiPD/txaQhYMem040GMZbLAHAx/RBxRuDugDjl/Ytudhp8CMluCs69Mkd69Fb/iutLQylV3mSN8QXUNYTEMNRym666duUT6SPE+APg5ZGPDs7U2NTxnd0rLUx3dD3q/YmwNNLkfva2W0NPdQJhEYk0ROWfzpUC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7vgjl/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415C7C3277B;
	Tue, 28 May 2024 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716905958;
	bh=yuPDGgUn+VpqJiWJHL5pFexMSMO0h7DglLbUSyFNJ5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7vgjl/Vztm2dNd7g3fcwJZSC9bQIl/dDnx7qD4i9yL3YYEYfUFzGVIb4T0QZLi7z
	 Vx9xUR7HGlRrdvVzyMrEPer5QIPqvdkKi9dE301/IWlqSdpQnmW424JRVgM7kEMX8Y
	 TNvyBdnw0f+nA7QbJ5SIf34APGwvIYDlCtwcHugeNe3sJlInHH6YTzvXKUeAdCwi/C
	 igx906FH1Nkgt+wKfaYxXdCicVg3vkdjqYMA1t7ZZRU5dvZAuyBaprkmHLS5LKCZkL
	 qFVRMmiVYo+BwZkDbq9dVHaUWRO5OJW5FWHKFB5Rd4ydnnFTBTzDLrbzKiauxIYqvR
	 Nnv6nB3VpWq8Q==
Message-ID: <3f4c0d70-8689-40a9-b051-13d013c4f09c@kernel.org>
Date: Tue, 28 May 2024 16:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240528141341.rz_rytN_@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 4:13 PM, Sebastian Andrzej Siewior wrote:
> The assert was introduced in the commit cited below as an insurance that
> the semantic is the same after the local_irq_save() has been removed and
> the function has been made static.
> 
> The original requirement to disable interrupt was due the modification
> of per-CPU counters which require interrupts to be disabled because the
> counter update operation is not atomic and some of the counters are
> updated from interrupt context.
> 
> All callers of __mod_objcg_mlstate() acquire a lock
> (memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
> the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
> disabled and the assert triggers.
> 
> The safety of the counter update is already ensured by
> VM_WARN_ON_IRQS_ENABLED() which is part of __mod_memcg_lruvec_state() and
> does not require yet another check.
> 
> Remove the lockdep assert from __mod_objcg_mlstate().
> 
> Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
> Link: https://lore.kernel.org/r/20240528121928.i-Gu7Jvg@linutronix.de
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

mm-hotfixes as it's a rc1 regression

> ---
> On 2024-05-28 15:44:51 [+0200], Vlastimil Babka (SUSE) wrote:
>> I think just s/memcg_stats_lock()/__mod_memcg_lruvec_state()/ in your
>> phrasing, since we are removing the lockdep assert from path that calls
>> __mod_memcg_lruvec_state() and not memcg_stats_lock()?
>> Or am I missing something?
> 
> Yeah, makes sense.
> 
>  mm/memcontrol.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3147,8 +3147,6 @@ static inline void __mod_objcg_mlstate(s
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  
> -	lockdep_assert_irqs_disabled();
> -
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);


