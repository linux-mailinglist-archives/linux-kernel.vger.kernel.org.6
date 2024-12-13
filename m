Return-Path: <linux-kernel+bounces-444172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CE9F0267
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D233188E689
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C12A1BB;
	Fri, 13 Dec 2024 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="igmn5UHV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230E17C60
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054134; cv=none; b=rJeoGBnea1APbww9R5NQha2GU5T1k8CCOUuHblDNev6ozCuDAZepGHQR+S9IE4oL9uhiBPQmbIBjxDg/xd2xzGkq2MysfyCoS5MFGlD6C+Q+JC80e4cO0kOOuA1HhYG/cC+9HsQof6MR5Y7U84F49eviFPSUVNA5uFOdN169HNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054134; c=relaxed/simple;
	bh=sbNnwrxdmPvVbwepQbobT9BdPrU4oV3hT1gtkBC2MrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxlTIntNq26c7QceNtK5jcH0XQt+ZTb8nrMl9Wy2RXpQL01WZlqUAJxCgZ6nQJmWE5vu8FhimLezTftt5KraSa1fZjww3dC18Ta5JIRBAp5DMxc7HkVvWsL4c5Z7klWYdp/i3wj2WHxAN+cutwGw7KfXx24kSNCwCc98rOFRh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=igmn5UHV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=np8T7mWlht8plu2pa8HCEwfFHDwDqGqVQXZZGrLwAj8=; b=igmn5UHVgAc2+1vrRiR3RrBqDV
	dWtYjbyKcKRZST+KOTaYeN1J/9W5g4qybJSsj7DAU9XUaY8d4Itm0yu9M9Z3UAHdJdD/lc46YP12i
	ANbUTBO5h5uf4URfn15HLXGjZlOHj4ZTMNUCeU9vD3yN0ePv502zf+MMU+U9khFjZieNew2jVkZq4
	Om2f6jb/ATAEG5vKhfOUIKPwr3wo/gzt8JZ7Kt4TkARi7JjiViAO/AyCKy+gD4WVZv/8u/0PrEp9H
	mUURAZC3iMAaNUM/6VRzQpDEGOg4oDjwiJzCpktGCNvRQpTusVtY276dEwq1cWhiBVPSHBx58/aCF
	k4SOYz2Q==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tLugs-002TY7-L6; Fri, 13 Dec 2024 02:42:02 +0100
Message-ID: <f7924c58-dfaa-424c-9dd4-cec9a50137c9@igalia.com>
Date: Fri, 13 Dec 2024 10:41:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] sched_ext: Implement scx_bpf_now_ns()
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-5-changwoo@igalia.com>
 <Z1lJ-AzRlFIv4OuP@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z1lJ-AzRlFIv4OuP@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 11. 17:14, Tejun Heo wrote:
> Hello,
> 
> I'd roll the preceding two patches into this one.
Sure. I will merge patches 2, 3, 4 into one.

> On Mon, Dec 09, 2024 at 03:15:29PM +0900, Changwoo Min wrote:
> ...
>> 3) Monotonically non-decreasing clock for the same CPU: scx_bpf_now_ns()
>>   guarantees the clock never goes backward when comparing them in the same
>>   CPU. On the other hand, when comparing clocks in different CPUs, there
>>   is no such guarantee -- the clock can go backward. It provides a
>>   monotonically *non-decreasing* clock so that it would provide the same
>>   clock values in two different scx_bpf_now_ns() calls in the same CPU
>>   during the same period of when the rq clock is valid.
> 
> We probably should provide helpers to calculate deltas between timestamps
> and use them consitently in SCX scheds. e.g. ops.runnable() and
> ops.running() can run on different CPUs and it'd be useful and common to
> calculate the delta between the two points in time.

If I understand correctly, it should be something similar to
jiffies_delta_to_msecs(). Regarding the API name, what about
scx_time_delta(s64 time_delta) and/or scx_time_diff(u64 time_a,
u64 time_b)?

>> +	if (!(rq->scx.flags & SCX_RQ_CLK_VALID) ||
>> +	    (rq->scx.prev_clock >= clock)) {
> 
> The clocks usually start at zero but it'd still be a good idea to use
> time_after64() and friends when comparing the ordering between timestamps.

Sure. I will update the code as suggested.

> 
>> +		/*
>> +		 * If the rq clock is invalid or goes backward,
>> +		 * start a new rq clock period with a fresh sched_clock_cpu().
>> +		 *
>> +		 * The cached rq clock can go backward because there is a
>> +		 * race with a timer interrupt. Suppose that a timer interrupt
> 
> This is not limited to timer interrupts, right? This kfunc can be called
> from anywhere including tracepoints for code running in IRQ
Yup, you are right. I will update the comments.


> 
>> +		 * occurred while running scx_bpf_now_ns() *after* reading the
>> +		 * rq clock and *before* comparing the if condition. The timer
>> +		 * interrupt will eventually call a BPF scheduler's ops.tick(),
>> +		 * and the BPF scheduler can call scx_bpf_now_ns(). Since the
>> +		 * scheduler core updates the rq clock before calling
>> +		 * ops.tick(), the scx_bpf_now_ns() call will get the fresh
>> +		 * clock. After handling the timer interrupt, the interrupted
> 
> This might be easier to explain with two column table explaning what each
> party is doing in what order.
I will beautify the text for readability.

> 
>> +		 * scx_bpf_now_ns() will be resumed, so the if condition will
>> +		 * be compared. In this case, the clock, which was read before
>> +		 * the timer interrupt, will be the same as rq->scx.prev_clock.
>> +		 * When such a case is detected, start a new rq clock period
>> +		 * with a fresh sched_clock_cpu().
>> +		 */
>> +		clock = sched_clock_cpu(cpu_of(rq));
>> +		scx_rq_clock_update(rq, clock);
> 
> Hmmm... what happens if e.g. a timer ends up performing multiple operations
> each going through rq pin/unpin?

That should be okay. After multiple rq pin/unpin operations, the
resumed scx_bpf_now_ns() will found that the prev_clock is
greater (not equal) than the current clock, so it will get the
fresh clock.

Thanks!
Changwoo Min

