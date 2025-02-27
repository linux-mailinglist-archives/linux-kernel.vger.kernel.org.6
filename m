Return-Path: <linux-kernel+bounces-535797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCFA4774C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BD91891547
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D72A8C1;
	Thu, 27 Feb 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MtmTOgfk"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703A2192FF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643572; cv=none; b=lAci2vj78LIyoytF3iftuASr+uzVKe53e7Bhbx5Lh96VCbcGCUC9Ngjnchm07oALqFjll11+r1UeF22+iV4O9Afr07AAVOhn2Ijl3oTvreHlqUMoP8Z4M+9nmtHVaZJABQkmjS5zbkPCmFsxeX8EgO2joJc3A6ReEppfdr60qdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643572; c=relaxed/simple;
	bh=3aQyHdmF6edFmgZ8cBPFD4bY2ZlFYW8VkJdwCIkQTHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiTfRjHg5vUCMKEsTMPCckgF6OXlvHdmBccNeGXCFEAP1nhI0R+ANgbmgOgEqLE1BlWh2lUKFXrmq4jaI/+2jgsWR8MRs30snJVrIfva/mj5ULBABfZhrSCqRMVIs6KVA1pfQ/ZZ0W6Dkvh2xNt7JtxnsvqZg31d+Azt4+TKAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MtmTOgfk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8uUTVXqDEpLQMRtxsW/6lHZSiCWV894OCjbXPPjULR8=; b=MtmTOgfkoCgA12x49jNeO8EPuJ
	lo+HsoPmbgyQ4GSd3gGLScdIJDUTrx8LdUr2obGRx5QPEGfN99i/e7u3pafg6nUrWbZcSPwe2HNdk
	WoMA5A1vOqJJpyxFvnirbhtmTYBD1oJ91DdNpEhGnRrOJsR5K6lRlXJL2x+nPbSZqqH3wGemc9Rmb
	5jZwMBRj5jiFA7S9SiB8h6SewKRVAenYJ7o6MMCVtMh74tnRDyoGeVfO6YbSHENMc6lhLAZyhO7bz
	uIgzvn3yK3FcO9Wp/KGFT3KcT9BwtTenOFAXvVGMEW+iyEmV6zFXzLxQvLsMmUza7KY1f51lPJvnu
	JfjXtL9A==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tnYu3-001UWT-Iq; Thu, 27 Feb 2025 09:06:01 +0100
Message-ID: <6a23642f-b3bf-4501-8464-f66bb9f1f57f@igalia.com>
Date: Thu, 27 Feb 2025 17:05:54 +0900
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
 <Z8AWZBtrGN8h76AK@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z8AWZBtrGN8h76AK@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

Thank you for the review!

On 25. 2. 27. 16:38, Andrea Righi wrote:
> Hi Changwoo,
> 
> On Wed, Feb 26, 2025 at 11:33:27PM +0900, Changwoo Min wrote:
>> Add tracing support, which may be useful for debugging sched_ext schedulers
>> that trigger a certain event.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
>>   kernel/sched/ext.c               |  4 ++++
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
>> index fe19da7315a9..88527b9316de 100644
>> --- a/include/trace/events/sched_ext.h
>> +++ b/include/trace/events/sched_ext.h
>> @@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
>>   	)
>>   );
>>   
>> +TRACE_EVENT(sched_ext_add_event,
>> +	    TP_PROTO(const char *name, int offset, __u64 added),
>> +	    TP_ARGS(name, offset, added),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(	int,		offset		)
>> +		__field(	__u64,		added		)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name);
>> +		__entry->offset		= offset;
>> +		__entry->added		= added;
>> +	),
>> +
>> +	TP_printk("name %s offset %d added %llu",
>> +		  __get_str(name), __entry->offset, __entry->added
>> +	)
>> +);
> 
> Isn't the name enough to determine which event has been triggered? What are
> the benefits of reporting also the offset within struct scx_event_stats?
> 

@name and @offset are duplicated information. However, I thought
having two is more convenient from the users' point of view
because they have different pros and cons.

@offset is quick to compare and can be used easily in the BPF
code, but the offset of an event can change across kernel
versions when new events are added. @offset would be good to
write a quick trace hook for debugging.

On the other hand, @name won't change across kernel versions,
which is good. However, it requires more code to acutally read
the string in the BPF code (__data_loc for string is a 32-bit
integer encoding string length and location).

Does it make sense to you?

Regards,
Changwoo Min

