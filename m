Return-Path: <linux-kernel+bounces-536561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B60A480FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B5E3A5C46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C27231C9C;
	Thu, 27 Feb 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VldufT1A"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075E17BA6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666103; cv=none; b=sPiWe25SP9XC0/tUk0S7tXKr5t08ym1Y5ng9YFmAD0mrYdVU7u0BswYZWM7dgWtNkUF2aUNX07MG0tsM+ytveKo1rJuPjFaEs4Lfj833pDFtxhFVI1plvvOpB4NTdkspd3dwY1wcCPpao1pZc/eCnJdUaY3mSc7m5kjcNf9uhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666103; c=relaxed/simple;
	bh=hBrf7c+UFiKZli5U1l7NtS9fbLhngdZIbJBDuc626pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpMDxJZ+OuZYQmnwHTJBWRRki8Dp8ieXjhCitKRfkE2Q5Gb5G5kmj1g1iArCEwikknb60qyvTEDTpbADTe+XXZvHqDvwBGMOEBk89x0qQviP/JR1Q9yZdQ/Icy0SPOXTqsrPsxu7VPPa2brh+K3ZotxHCv1oZnK6huUEI4jX9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VldufT1A; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EEtWdJ8PDIxGw+HxqjO8MiMDtE8KtosznzVhAqUzc1I=; b=VldufT1ApqRRkyV2LvMbtNHY/r
	qZSWWnznT2RuTKELILooJeZ3kRbgMlrN7LGgwyt1T0WSi3jRByvdK0ZUepQxKKaGSdwUSH6zLsD8I
	puOQgSQgWSa8fXXg5O4S8eQh6oOMvMje1c2kfxpUzOHzFhTWCOqOopb7e9Uc0wHSoOmwy2Bw0qva6
	PU9szInus1EdLoW0gGVL+TT7sWFjbPo4D/XPoyjtXta5KeAebpXpAdkBQSH/vv7OMTX02h5HXUSF5
	keYENhzT1Zini5hR3kcMd9LkrG2OFi4wce5OE621u+fWJj1OxcZxQMFdWC90a2umAZ+Qr8eEFDnuf
	JMbv8hSA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tnelQ-001cqJ-1A; Thu, 27 Feb 2025 15:21:30 +0100
Message-ID: <9ce1f9f6-f69c-4b14-be79-f46542d7316f@igalia.com>
Date: Thu, 27 Feb 2025 23:21:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250226143327.231685-1-changwoo@igalia.com>
 <Z8AWZBtrGN8h76AK@gpd3> <6a23642f-b3bf-4501-8464-f66bb9f1f57f@igalia.com>
 <Z8Af9PRa7LrxHpfp@gpd3> <ea71a8d7-ba0f-4d43-9304-6544060a1bb6@igalia.com>
 <Z8BEiHv3u8BsX3yG@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z8BEiHv3u8BsX3yG@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25. 2. 27. 19:55, Andrea Righi wrote:
> On Thu, Feb 27, 2025 at 07:23:23PM +0900, Changwoo Min wrote:
>> On 25. 2. 27. 17:19, Andrea Righi wrote:
>>> On Thu, Feb 27, 2025 at 05:05:54PM +0900, Changwoo Min wrote:
>>> Otherwise there's the risk to break potential users of this tracepoint that
> ...
>>> Maybe we can call it @id or @event_id or similar and guarantee its
>>> portability? What do you think?
>>
>> Now I think dropping @offset would be better in the long run
>> because we can maintain scx_event_stats clean and do not create
>> a source of confusion. Regarding the ease of using @name, adding
>> an code example in the commit message will suffice, something
>> like this:
>>
>> struct tp_add_event {
>> 	struct trace_entry ent;
>> 	u32 __data_loc_name;
>> 	u64 delta;
>> };
>>
>> SEC("tracepoint/sched_ext/sched_ext_add_event")
>> int tp_add_event(struct tp_add_event *ctx)
>> {
>> 	char event_name[128];
>> 	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
>>          bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);
>>
>> 	bpf_printk("name %s   delta %llu", event_name, ctx->delta);
>> 	return 0;
>> }
> 
> We can definitely add a BPF code example, but keep in mind that tracepoints
> can be used also outside of BPF, like:
> 
>   $ sudo perf trace -e sched_ext:sched_ext_add_event
> 
> In this case I think just having the name is totally fine.

Sure.

> 
>>
>> The downside of not having a numerical ID (@offset or @event_id)
>> is the cost of string comparison to distinguish an event type. If
>> we assume the probing the event is rare, it will be okay.
>>
>> @Tejun, @Andrea -- What do you think? Should we provide
>> a portability-guaranteed @event_id after dropping @offset? Or
>> would it be more than sufficient to have a string-type event name?
> 
> I think a tracepoint should be used mostly for tracing purposes, not in
> critical hot paths. So, under this assumption, the overhead of the string
> comparison is probably acceptable and it allows us to not worry too much
> about breaking compatibility.

I agree.

> 
> Also, perf trace allows to use filters based on strings, so in our case we
> can do something like this for example:
> 
>   $ sudo perf trace -e sched_ext:sched_ext_add_event --filter 'name == "SCX_EV_ENQ_SLICE_DFL"'
> 
> While at it, what do you think about renaming this tracepoint
> sched_ext_event or maybe sched_ext_core_event?

To me, sched_ext_event sounds better than others as it is simple.

Regards,
Changwoo Min

