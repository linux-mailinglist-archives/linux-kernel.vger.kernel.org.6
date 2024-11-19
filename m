Return-Path: <linux-kernel+bounces-414580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B09D2A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEADA2838BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B111CF7B7;
	Tue, 19 Nov 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nlGHk3Bk"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7778C76
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031880; cv=none; b=RiuD8W3E3HGA5cRkA8dCCZ6Cpbnn27d8qtZFT9Ws4z0pNy5JZYL02rPoECB4+F5HOe99f6OfrDLEf4B0DrepaB1s42n42RCjnMbNA+eX4SyPwO/snod1MluXBVRdLdYxb87D8Eg5l5ge3LjS5dgQurzgkSx5UQOQLj1htHcgZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031880; c=relaxed/simple;
	bh=HCvpbOR/u7jcZBAvbHV1kj7GB7odNK1lNIc4a25TwM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRHv+mjUzT24wQnUr1yi6eaYcBy9BMBNzL/sm5Tnpgkq28wwO0PGtfTNztkh+Ld09U+BjbQ+YfbPZQjOB9O5vlfIIt+R9DAgLq1f8ULrjR2KpwlDyWWS1y94S2oFp1eNekXWG8f8YHA3fTfOiALpyjCXsIYUJYTMIS2KdZyIxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nlGHk3Bk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R5Bm2aFGF7WjE8eQmHljol8A58CppSEzXwVNwiZMOwM=; b=nlGHk3Bk0RRraB7NAE3zdL9hEw
	6tzKv7PPIbVwK+LB2Nm9MahGx0zw9cswvDZGkl3QveziP4aRClNme/HWpBAzZXAhqcjmK0k3rXWUb
	omVXmIrgKa6IwyzMQrRNKo4xkS5nDvYCIHb81dKvDa1ocICmICEElnofQACExhOeupuMeqbZ6cCBD
	d1SNnsqxeFa4z7p5RoBoX5ubfAh+7aqvIid/MdJLi+wQbOohxQzzjOQsgl5EMXL/KblKWo0gQHrd7
	VcT5wDpEfurMGDDStyZ2BBPgaMl6ATYFgkhBqHPKNR+K93wpGSgI3vqAGOF19hMknl6xzKxoxuE53
	bkz2Olvw==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tDQbl-00993p-My; Tue, 19 Nov 2024 16:57:42 +0100
Message-ID: <a7a989d2-b88b-4ceb-9c57-6874e09a1599@igalia.com>
Date: Wed, 20 Nov 2024 00:57:30 +0900
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
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241119081740.GB11903@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 11. 19. 17:17, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 10:19:44AM +0900, Changwoo Min wrote:

>> Let's suppose the following timeline:
>>
>>    T1. rq_lock(rq)
>>    T2. update_rq_clock(rq)
>>    T3. a sched_ext BPF operation
>>    T4. rq_unlock(rq)
>>    T5. a sched_ext BPF operation
>>    T6. rq_lock(rq)
>>    T7. update_rq_clock(rq)
>>
>> For [T2, T4), we consider that rq clock is valid
>> (SCX_RQ_CLK_UPDATED is set), so scx_bpf_clock_get_ns calls during
>> [T2, T4) (including T3) will return the rq clock updated at T2.
>> Let's think about what we should do for the duration [T4, T7)
>> when a BPF scheduler can still call scx_bpf_clock_get_ns (T5).
>> During that duration, we consider the rq clock is invalid
>> (SCX_RQ_CLK_UPDATED is unset). So when calling
>> scx_bpf_clock_get_ns at T5, we call sched_clock() to get the
>> fresh clock.

> So the question then becomes, what is T5 doing and is it 'right' for it
> to get a fresh clock value.
> 
> Please give an example of T5 -- I really don't know this BPF crap much
> -- and reason about how the clock should behave.

Here is one example. `scx_central` uses a BPF timer for
preemptive scheduling. In every msec, the timer callback checks
if the currently running tasks exceed their timeslice. At the
beginning of the BPF timer callback (central_timerfn in
scx_central.bpf.c), scx_central gets the current time. When the
BPF timer callback runs, the rq clock could be invalid, the same
as T5. In this case, it is reasonable to return a fresh clock
value rather than returning the old one (T2).

Besides this timer example, scx_bpf_clock_get_ns() can be called
any callbacks defined in `struct sched_ext_ops`. Some callbacks
can be called without holding a rq lock (e.g., ops.cpu_online,
ops.cgroup_init). In these cases, it is reasonable to reutrn a
fresh clock value rather returning the old one.

Regards,
Changwoo Min



