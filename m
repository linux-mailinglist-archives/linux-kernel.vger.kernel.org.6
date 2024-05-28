Return-Path: <linux-kernel+bounces-192309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B38D1B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10F01C21A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEED16D4E1;
	Tue, 28 May 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXS7Cjui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAE502B9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899699; cv=none; b=ejn78LP6CJ+wbFuB2VNzO5VDEkAiYoeEJ/C4PlObYkU3j6tvx864W5oRHbKoh/2+yVvLttoQI9HpoSmupJY5NQYVLdlO/yiKAdSzFB7FVfkVvbuw7CpQ9dI35HRqpVCU4oLPuMtai6u14IwWe4iekBy+zBI4AmvYdoAZ5PgUm9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899699; c=relaxed/simple;
	bh=OXBNq2DCVe/9Ba++zAGJfyl/7AkqAaG5L7+KqLyGUg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTQgJRq4knTVl2jzUD7CeBx/FoHqeQsXFnUZN3XOad6NEMyJoeikdYhIgGWunmrfVosb98v/HDYoqYZ2fJurAVP6NGXOJ/990GdSh/IPVXisutUK0wf209Rkr5s0kutoOCTpsUUv0rLzKuPeHTNbV7P5mH4WHMZ5RcRWooA2COo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXS7Cjui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF36BC32782;
	Tue, 28 May 2024 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716899698;
	bh=OXBNq2DCVe/9Ba++zAGJfyl/7AkqAaG5L7+KqLyGUg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jXS7CjuiItpMTYwxbpCNT2T9U4jeXg6Nigw3MpWl2GCOzDcC+P5bmvFidqN7rd7fF
	 tUzK72Sw+2BhK2ThJasAza1QNi2JajeF0EImZPL8ds97rhduxllbhXyaGASZHoqvqV
	 CrOLPM2lFdlqHa9BAb8xQ3onsrrRk5q75asNGfZ1S8XgxxVoS/UlUI62C3anLsFfKv
	 dRKlBhxycNSqr2blAkod13P1ZZZ71ilWmHSgCcf6cgoREjfOSz4WaOI9ps/8KG158E
	 zac0/LVA1162X+fKZVdzFWo8BgrAqsolwJ5vq6HUWOs+jMpO4Yd20ja7Fw44GaQfzV
	 diYTktnv3rBgg==
Message-ID: <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
Date: Tue, 28 May 2024 14:34:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Remove the lockdep assert from
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
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240528121928.i-Gu7Jvg@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 2:19 PM, Sebastian Andrzej Siewior wrote:
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
> VM_WARN_ON_IRQS_ENABLED() which is part of memcg_stats_lock() and does
> not require yet another check.

I think here it's __mod_memcg_lruvec_state() doing the VM_WARN_ON_ as we
don't go through memcg_stats_lock()?

> Remove the lockdep assert from __mod_objcg_mlstate().
> 
> Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

mm-hotfixes as it's a rc1 regression

> ---
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


