Return-Path: <linux-kernel+bounces-535754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7471A476BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B776E3AD422
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53602222A4;
	Thu, 27 Feb 2025 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DzX3XyLE"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99911EB194
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642125; cv=none; b=OfSpDqV/JaxoOde3qc7kDOQ4a15rZRkzgw9E+sb4wHK8R4baSSncOGi1Uh2BzfpJFHfoxTqV+2w2p9Xo4WvDwi3zD0TheW68BKRI69S+Wr/8Zd7OwC/uvWn8vpzQl9zIH3dO/LvZDbRffGlYr3jt90DC6HkhcKJc2hC9jueUu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642125; c=relaxed/simple;
	bh=kUt1hw2OeGcF75w78SXUkJLgZ7NQEvchGPnQlK/Nwpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Duaiq0X+A3yMG+vqDEt9Y7bSNv6CNxrU2I/KVpmwh3TSEwaBabuAxhk0M1VbD12XEqxtjrAZTrrpLm6ihDngEIzH4d5SIsSkQKelQo8XFNPjfesBOlK6kxJOT5nvsDZViep5d87urJzDGpJ9wWLsJIawZgvdq6Az/3nu1N5ZbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DzX3XyLE; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wEmwrAZv2rrwivZwCQP0TGYEjyLyX3HOCE9A9/d0M3U=; b=DzX3XyLEbuSVOFEX1cMP19n5kg
	W377LZUUSGEQrXA6e8AoUYKjfq4bAdZP4RBL5W5MT/ouRq1Uugh0LUFDkjO/5hTTqh3KrO8x7uRlV
	pUFnqnZg+pO6gxAp1iXRqUQ9n8sMFWMFwbxX+xJneMlxMfQeiik4FhTVys61umIczLrT7T9CKbWb0
	ryaxDu3PmHynhOIDpiHyGmZ/ckWNOmkHFAf1js+dNbJoQ9kizbyHxGvD67u18AH95ghz9czCzit8n
	YFjS/zf1cmNWT4KPzTv+us6K86/03LkOMr3/H5hfWbNxwz83lgh/HklmneeUhWuR5pcF92fRxbySR
	49vJgIaQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tnYWf-001U5M-RF; Thu, 27 Feb 2025 08:41:52 +0100
Message-ID: <7d985c1a-1e4a-4518-917d-4ff701d7bb9e@igalia.com>
Date: Thu, 27 Feb 2025 16:41:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250226143327.231685-1-changwoo@igalia.com>
 <Z79ivCISjmFlkecF@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z79ivCISjmFlkecF@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun,

On 25. 2. 27. 03:51, Tejun Heo wrote:
> Hello,
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
> 
> Can we do sched_ext_event with @delta? Otherwise, looks fine to me.
Sure, @delta is clearer. I will change it as suggested.

Regards,
Changwoo Min

