Return-Path: <linux-kernel+bounces-192615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90248D1FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5362859B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4427172BCB;
	Tue, 28 May 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s12TwydI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA4172BC3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908831; cv=none; b=kMgR9Y8PNpy33OdN2DJHMJ5YroLzZsvfO5PLH7Ab+weRVuRosKK/gFsD2gPD8wHrb50luCpZ99l9DJgDbcQxMStylH3V4Gq09PNwloZgPGXaMRzHtKEtGyiBR1EcEuhg05MP2ZFewZdhRIYCpBDC9f2JHRffuTG8pjeC35l87IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908831; c=relaxed/simple;
	bh=bqgQfeocbpfMkksERSp1895rbSELWnveQUM/jhUVweo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGixf7xGTPyjLhlJvAkL6WhywOBFBKwvZFib/9b2CepuTTic45qb7sgSCn+MW4WnKtFf+ZYpG86PRGBvWah45gXq3jp/zYuVYary+srOorERyg5AKP03x3RD6mE3/F+BwkZJAV5a6ljTsn8ga0+jyRaV2OLh/z7aLteGEZm+wv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s12TwydI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B7FC3277B;
	Tue, 28 May 2024 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716908830;
	bh=bqgQfeocbpfMkksERSp1895rbSELWnveQUM/jhUVweo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s12TwydIpV3sydIr3BalADafyre2uwqbeoAJwzzEqfFVBnyyGSji1U01f5Ny3JVOE
	 1MtRs0lS+M1T3TilgAt3O5BT9LHmV6dn4TAIo5mRNygL49bnm76NcbLOGPup9O5Foi
	 5Cl9qisZDzB1ONtLmQNyPSXwHzCGG7Blt7JMwICkxNEI9bQbYpn8p7OWIQh+11/J8r
	 tTnSyuuJWDi4fwNPRzLKKNedf9w1ivSOLNqgNoorCGHMjs+hv1f9QPdae1SLUN0b+J
	 CXDJ+TI7OQP9vc9WdokuBFf7mJBdKZzhrEvU9WZAhezrRUA9N3cs51b75KTeSpGIwR
	 2QK9/PNqpxJyQ==
Message-ID: <897354c6-764b-4f3f-9ece-2feafb0222e9@kernel.org>
Date: Tue, 28 May 2024 17:07:06 +0200
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
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
 <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 4:59 PM, Shakeel Butt wrote:
> On Tue, May 28, 2024 at 04:13:41PM GMT, Sebastian Andrzej Siewior wrote:
>> The assert was introduced in the commit cited below as an insurance that
>> the semantic is the same after the local_irq_save() has been removed and
>> the function has been made static.
>> 
>> The original requirement to disable interrupt was due the modification
>> of per-CPU counters which require interrupts to be disabled because the
>> counter update operation is not atomic and some of the counters are
>> updated from interrupt context.
>> 
>> All callers of __mod_objcg_mlstate() acquire a lock
>> (memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
>> the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
>> disabled and the assert triggers.
>> 
>> The safety of the counter update is already ensured by
>> VM_WARN_ON_IRQS_ENABLED() which is part of __mod_memcg_lruvec_state() and
>> does not require yet another check.
> 
> One question on VM_WARN_ON_IRQS_ENABLED() in __mod_memcg_lruvec_state().
> On a PREEMPT_RT kernel with CONFIG_DEBUG_VM, will that
> VM_WARN_ON_IRQS_ENABLED() cause a splat or VM_WARN_ON_IRQS_ENABLED is
> special on PREEMPT_RT kernels?

It only does something with CONFIG_DEBUG_VM_IRQSOFF and that's disabled by
dependencies on PREEMPT_RT :)

>> 
>> Remove the lockdep assert from __mod_objcg_mlstate().
>> 
>> Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
>> Link: https://lore.kernel.org/r/20240528121928.i-Gu7Jvg@linutronix.de
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> On 2024-05-28 15:44:51 [+0200], Vlastimil Babka (SUSE) wrote:
>> > I think just s/memcg_stats_lock()/__mod_memcg_lruvec_state()/ in your
>> > phrasing, since we are removing the lockdep assert from path that calls
>> > __mod_memcg_lruvec_state() and not memcg_stats_lock()?
>> > Or am I missing something?
>> 
>> Yeah, makes sense.
>> 
>>  mm/memcontrol.c |    2 --
>>  1 file changed, 2 deletions(-)
>> 
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3147,8 +3147,6 @@ static inline void __mod_objcg_mlstate(s
>>  	struct mem_cgroup *memcg;
>>  	struct lruvec *lruvec;
>>  
>> -	lockdep_assert_irqs_disabled();
>> -
>>  	rcu_read_lock();
>>  	memcg = obj_cgroup_memcg(objcg);
>>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);


