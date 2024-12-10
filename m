Return-Path: <linux-kernel+bounces-439005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C749F9EA970
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879A9283F14
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6C222CBEB;
	Tue, 10 Dec 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YWPgYXjV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1EF19F471
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815294; cv=none; b=ALzYbl243J3pPiz2Zc5sKTQSyJt1y0LU8iwIZTJ4pAep0QYN5KXw79m1h9SUNY5BwxlNOhDyhKRelWS4jCzeMJMEAg6WHXD5HEymnqPmU3W5NjgXN8uD1cerlddUSXMRYqLzS9dh/0hSW3aMo7wKqPyH7PkLLllKEf0aJJXRAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815294; c=relaxed/simple;
	bh=RrVc4QpoSQM4iuG25WIbl04t6qd10VxLosfDjcCFBVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCMqafAlM7PtRh/qgdGqDmKg0lxW+x6kfTY2Hs/O83OvD3ZPVg/sAsCsT4C6iIf4B5YwlhH+O47OQ1zM1GJTEN+aRqbuLjxbsbOvAL4oyUur8do7El6a0aB2xr6fgyTepczpv46epnBctsjkKkky/anDU96zWCSOlxWVI1dmTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YWPgYXjV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gr9/Sh34c7zNzxKIvdyMiRRN/frtceZPv+8tWFte7sY=; b=YWPgYXjV+/FbHZDQsAwWdT64hB
	zfxHT6te/qq0RNpAe7lOIPr91/7LbghvDCYJ4zDBL10NFaUJyig1hewyOT+ifiihYO/HJFHNVGMB3
	Blfw9yYFelw7QQrttYXbBaNDAnHuO2KJ/qm357BWd//s1FiOQ4TwMHyAY+HAZ+b5hl5muMHbLEU79
	jCPY+6MUKAFcH7wDrMouci4jWCFNhMRVxt5hU9ZGm66RMdopX3aY5FjeW0n6fpyfoLiqLgOYL2XhB
	Ra9/CH7lgbLwNm2r5ZnqCcLGxM9ZN+RB2cbMOCXqyAWnIgnd7CAGC3tvSIB35Bj4YPNUCnkvOo0Y0
	oTlb0eSQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tKuYN-001NDl-28; Tue, 10 Dec 2024 08:21:07 +0100
Message-ID: <41fdc3ec-7082-41f9-99b5-ab28838d9ec1@igalia.com>
Date: Tue, 10 Dec 2024 16:21:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] sched_ext: Implement scx_rq_clock_update/stale()
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 peterz@infradead.org, kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-3-changwoo@igalia.com> <Z1a7EfETQi3FSLJG@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z1a7EfETQi3FSLJG@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrea,

Thank you for the review.

On 24. 12. 9. 18:40, Andrea Righi wrote:
>> @@ -766,9 +767,11 @@ struct scx_rq {
>>   	unsigned long		ops_qseq;
>>   	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
>>   	u32			nr_running;
>> -	u32			flags;
>>   	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
>>   	bool			cpu_released;
>> +	u32			flags;
>> +	u64			clock;			/* current per-rq clock -- see scx_bpf_now_ns() */
>> +	u64			prev_clock;		/* previous per-rq clock -- see scx_bpf_now_ns() */
> 
> Since we're reordering this struct, we may want to move cpu_released all
> the way to the bottom to get rid of the 3-bytes hole (and still have
> flags, clock and prev_clock in the same cacheline).

We'd better keep the layout as it is. That is because moving
cpu_released to the end of the struct creates 4-byte hole between
flags and clock and 7-byte padding at the end after cpu_released.
I double-checked the two layouts using pahole.


> Nit, this is just personal preference (feel free to ignore it):
> 
> 	if (!scx_enabled())
> 		return;
> 	rq->scx.prev_clock = rq->scx.clock;
> 	rq->scx.clock = clock;
> 	rq->scx.flags |= SCX_RQ_CLK_VALID;
> 
That's prettier. I will change it as you suggested.


> I'm wondering if we need to invalidate the clock on all rqs when we call
> scx_ops_enable() to prevent getting stale information from a previous
> scx scheduler.
> 
> Probably it's not an issue, since scx_ops_disable_workfn() should make
> sure that all tasks are going through rq_unpin_lock() before unloading
> the current scheduler, maybe it could be helpful to add comment about
> this scenario in scx_bpf_now_ns() (PATCH 4/6)?

That's a good catch. In theory, there is a possibility that
a scx_rq is not invalidated when unloading the sched_ext. Since
scx_ops_disable_workfn() iterates all the sched_ext tasks, an rq
would not be invalidated if there is no scx task on the rq.
I will add the code which iterates and invalidates all scx_rqs at
scx_ops_disable_workfn() in the next version.

Thank you again!
Changwoo Min


