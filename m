Return-Path: <linux-kernel+bounces-535993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78DEA47A44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF933B0596
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772DE227EA4;
	Thu, 27 Feb 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OJ9OXth8"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489F21B9EE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651823; cv=none; b=POr6GUTh6aDtjSWIDHYUqACeo4uLn1nhOxZOde48letCUcPZXAD4ph3W33ZbcvFhHSoDRS2zyo3vW0PPITNly4CUS7OuKEmRUZCNOWcLG1lS3IEEWdQHupLX4GNbMTV1vhAemQZ9aiaTYQ+lKfSWm7hzOTbo1FF/4aAVWJlSdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651823; c=relaxed/simple;
	bh=rct5r5jCK0QPiVBzwS9sVOA59D2X5evPGMfau27KuDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP1o1UQZ+ODcutcVBHKYwExfSNybVHx8QkUVYJC2ouRkc0O015QfQakiK9sEuuqbHyBtkSelzU9o7CdCkNRXWJ2uyQ0bwfdFpZ1IJVuWgYrMzKleaDZ4nb88KyhX5cptpfUZQ6sh6STpz7bJE1g1sb4amWCnbs0vu5i1WmstUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OJ9OXth8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UlEdyx+jV4RZDQn5CVsOoRdLVvb3NYfTLquQ7a0Q2hE=; b=OJ9OXth8oNu5OYiBrtlOhJpZOA
	efN7jizyvOKj0HiaNTOFXfTjOMYiSCuBIosjYEMSKLvsCYF9MvrvXvjqrWCTLoafgEXYTRcb5FnoJ
	1P37oayNzjrCCcd7JWp7q/dKF4v+4eqpxRlbCCl00HHbqw06PgDUEbYbtEsqeKtnr0mZfvkytKJq+
	uQCot6UnG7agCGXWZ36QDqU8Au4TDyfhSNL+ciHD59yTSAnG9KVVQWVwSKrzXmXsEla4uuqP5zXXv
	rDVrnEd/YEw9WKDvvSvZ5XgXqJSPaUVXNlFiZKY/Q1P0AXqB83hft4VkJ95srw/v76/Ug1KqVa9po
	WIUg5DlA==;
Received: from [106.101.137.194] (helo=[192.168.11.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tnb37-001Xu6-Os; Thu, 27 Feb 2025 11:23:32 +0100
Message-ID: <ea71a8d7-ba0f-4d43-9304-6544060a1bb6@igalia.com>
Date: Thu, 27 Feb 2025 19:23:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
To: Andrea Righi <arighi@nvidia.com>, tj@kernel.org
Cc: void@manifault.com, kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250226143327.231685-1-changwoo@igalia.com>
 <Z8AWZBtrGN8h76AK@gpd3> <6a23642f-b3bf-4501-8464-f66bb9f1f57f@igalia.com>
 <Z8Af9PRa7LrxHpfp@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z8Af9PRa7LrxHpfp@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25. 2. 27. 17:19, Andrea Righi wrote:
> On Thu, Feb 27, 2025 at 05:05:54PM +0900, Changwoo Min wrote:
>> Hi Andrea,
>>
>> Thank you for the review!
>>
>> On 25. 2. 27. 16:38, Andrea Righi wrote:
>>> Hi Changwoo,
>>>
>>> On Wed, Feb 26, 2025 at 11:33:27PM +0900, Changwoo Min wrote:
>>>> Add tracing support, which may be useful for debugging sched_ext schedulers
>>>> that trigger a certain event.
>>>>
>>>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>>>> ---
>>>>    include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
>>>>    kernel/sched/ext.c               |  4 ++++
>>>>    2 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
>>>> index fe19da7315a9..88527b9316de 100644
>>>> --- a/include/trace/events/sched_ext.h
>>>> +++ b/include/trace/events/sched_ext.h
>>>> @@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
>>>>    	)
>>>>    );
>>>> +TRACE_EVENT(sched_ext_add_event,
>>>> +	    TP_PROTO(const char *name, int offset, __u64 added),
>>>> +	    TP_ARGS(name, offset, added),
>>>> +
>>>> +	TP_STRUCT__entry(
>>>> +		__string(name, name)
>>>> +		__field(	int,		offset		)
>>>> +		__field(	__u64,		added		)
>>>> +	),
>>>> +
>>>> +	TP_fast_assign(
>>>> +		__assign_str(name);
>>>> +		__entry->offset		= offset;
>>>> +		__entry->added		= added;
>>>> +	),
>>>> +
>>>> +	TP_printk("name %s offset %d added %llu",
>>>> +		  __get_str(name), __entry->offset, __entry->added
>>>> +	)
>>>> +);
>>>
>>> Isn't the name enough to determine which event has been triggered? What are
>>> the benefits of reporting also the offset within struct scx_event_stats?
>>>
>>
>> @name and @offset are duplicated information. However, I thought
>> having two is more convenient from the users' point of view
>> because they have different pros and cons.
>>
>> @offset is quick to compare and can be used easily in the BPF
>> code, but the offset of an event can change across kernel
>> versions when new events are added. @offset would be good to
>> write a quick trace hook for debugging.
>>
>> On the other hand, @name won't change across kernel versions,
>> which is good. However, it requires more code to acutally read
>> the string in the BPF code (__data_loc for string is a 32-bit
>> integer encoding string length and location).
>>
>> Does it make sense to you?


> So, IMHO @offset to me would make sense if we guarantee that it won't
> change across kernel versions, and that's probably doable, we just need to
> make sure that we always add new events at the bottom of scx_event_stats.

Keeping the offset across versions is possible if we add new
events to the bottom. However, I am not sure if that is what we
want because we lose the nice logical grouping of the events in
the scx_event_stats struct.

> Otherwise there's the risk to break potential users of this tracepoint that
> may consider the offset like a portable ID.

Hmm... I agree. The @offset would be too low level and could the
potential source of confusion.

> Maybe we can call it @id or @event_id or similar and guarantee its
> portability? What do you think?

Now I think dropping @offset would be better in the long run
because we can maintain scx_event_stats clean and do not create
a source of confusion. Regarding the ease of using @name, adding
an code example in the commit message will suffice, something
like this:

struct tp_add_event {
	struct trace_entry ent;
	u32 __data_loc_name;
	u64 delta;
};

SEC("tracepoint/sched_ext/sched_ext_add_event")
int tp_add_event(struct tp_add_event *ctx)
{
	char event_name[128];
	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
         bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);

	bpf_printk("name %s   delta %llu", event_name, ctx->delta);
	return 0;
}

The downside of not having a numerical ID (@offset or @event_id)
is the cost of string comparison to distinguish an event type. If
we assume the probing the event is rare, it will be okay.

@Tejun, @Andrea -- What do you think? Should we provide
a portability-guaranteed @event_id after dropping @offset? Or
would it be more than sufficient to have a string-type event name?

Regards,
Changwoo Min

