Return-Path: <linux-kernel+bounces-422929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142D89DA011
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A12283B83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069C8F49;
	Wed, 27 Nov 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sHWCNGAK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3A8831
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668125; cv=none; b=iqaqXJ1VKzVSxJv97eNVzDUibdofB57R7G9BLqiMYxYU/gGsvTSHKWxL0qTk5kdVHLQVxkQekCc832sFZyFnAit/MN2GplQutTpTVhp+G80dKRYq+tcf97BHV81/llLYUNyVneHJ6AeV1+xs0ipJp0WfsTL6HngnMYSKKYiV610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668125; c=relaxed/simple;
	bh=e64eiSaj3E/N55rH4WHugQJd8+Wr/ApxMZdKfQx1O9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMndwRyv/P2JZVCT5CxAM7nhXt6VvRTaqe+Y5Ir4u06I8uHRV+j4g9exjAW1A2thJNwuiZJpsnRF1cSkMRopr90UBd6YX7U7DuoB91asIGe2J/qjb4aTAYudpmgCzfZPr6HQa3miEW8/HPRUYtaifHaUUl2kEL5RNvtyRregEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sHWCNGAK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wj4xUgLDkEbLpQugqy4KRnKjeZwh4Cl4LIFBDNjGph0=; b=sHWCNGAK7IMB4+lwr0W821QvZo
	3U4DqW7z81fvtTWdittyLAadWrDhViPhBCHueG1zN6TqurprwmD+njUIv9TIsZGo9+Q2Etsu+P8vj
	Fa7TpEuezYuhHGAJ+a/cFPNQb8lx7Ia0J0K+7R4tVBvBiN+2ix/kuRZLGrSRNaeBbBtHShoyVKehk
	fZmeyHTGUzHqq5VzSfIPmN/crd0LTRdzUK5YTbVwqeypaJPq1ZXpcE80WEmarzXKNxdAu3YKwsark
	FSfbQktfl5QhRorA2ts+N4rqgpIv3x2z2hhUnSjkRGT368F966zh1YyI23Bzj6iJOdFZ2a5UKAfYx
	RGzdJY6g==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tG67Y-00DPc1-4g; Wed, 27 Nov 2024 01:41:32 +0100
Message-ID: <6e9a6084-2e78-4139-8c61-4d2f2ccd068e@igalia.com>
Date: Wed, 27 Nov 2024 09:41:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Changwoo Min <changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-3-changwoo@igalia.com>
 <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
 <494b8851-ba5b-4205-bea0-dc504c2ffa33@igalia.com>
 <20241118094100.GG39245@noisy.programming.kicks-ass.net>
 <9a2bfe0d-3a1d-4917-bf10-33259c79a3bb@igalia.com>
 <20241119081740.GB11903@noisy.programming.kicks-ass.net>
 <a7a989d2-b88b-4ceb-9c57-6874e09a1599@igalia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <a7a989d2-b88b-4ceb-9c57-6874e09a1599@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 11. 20. 00:57, Changwoo Min wrote:
> Hello,
> 
> On 24. 11. 19. 17:17, Peter Zijlstra wrote:
>> On Tue, Nov 19, 2024 at 10:19:44AM +0900, Changwoo Min wrote:
> 
>>> Let's suppose the following timeline:
>>>
>>>    T1. rq_lock(rq)
>>>    T2. update_rq_clock(rq)
>>>    T3. a sched_ext BPF operation
>>>    T4. rq_unlock(rq)
>>>    T5. a sched_ext BPF operation
>>>    T6. rq_lock(rq)
>>>    T7. update_rq_clock(rq)
>>>
>>> For [T2, T4), we consider that rq clock is valid
>>> (SCX_RQ_CLK_UPDATED is set), so scx_bpf_clock_get_ns calls during
>>> [T2, T4) (including T3) will return the rq clock updated at T2.
>>> Let's think about what we should do for the duration [T4, T7)
>>> when a BPF scheduler can still call scx_bpf_clock_get_ns (T5).
>>> During that duration, we consider the rq clock is invalid
>>> (SCX_RQ_CLK_UPDATED is unset). So when calling
>>> scx_bpf_clock_get_ns at T5, we call sched_clock() to get the
>>> fresh clock.
> 
>> So the question then becomes, what is T5 doing and is it 'right' for it
>> to get a fresh clock value.
>>
>> Please give an example of T5 -- I really don't know this BPF crap much
>> -- and reason about how the clock should behave.
> 
> Here is one example. `scx_central` uses a BPF timer for
> preemptive scheduling. In every msec, the timer callback checks
> if the currently running tasks exceed their timeslice. At the
> beginning of the BPF timer callback (central_timerfn in
> scx_central.bpf.c), scx_central gets the current time. When the
> BPF timer callback runs, the rq clock could be invalid, the same
> as T5. In this case, it is reasonable to return a fresh clock
> value rather than returning the old one (T2).
> 
> Besides this timer example, scx_bpf_clock_get_ns() can be called
> any callbacks defined in `struct sched_ext_ops`. Some callbacks
> can be called without holding a rq lock (e.g., ops.cpu_online,
> ops.cgroup_init). In these cases, it is reasonable to reutrn a
> fresh clock value rather returning the old one.

I wonder if the above example is sufficient for you. If you need
more examples or clarification, please let me know.


Regarding the my following my comment in the previous email, ...

On 24. 11. 19. 10:19, Changwoo Min wrote:
>> Growing sched_clock_data shouldn't be a problem, it's only 24 bytes,
>> so we have plenty free bytes there.
> 
> Alright. I will change the current implementation and extend
> `struct sched_clock_data` to store the `VALID` flag in the next
> version.


I found `struct sched_clock_data` is defined only when
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK is set, so I think extending
`struct sched_clock_data` is not an approach approach. Extending
`struct scx_rq` seems the best option after opting out
sched_clock_data. I will make sure the cached clock value and
flag in the scx_rq are in the same cache line to minimize the
cache misses. What do you think?

Thanks!
Changwoo Min

