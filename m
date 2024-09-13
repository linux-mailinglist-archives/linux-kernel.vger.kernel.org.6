Return-Path: <linux-kernel+bounces-328549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC34978597
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D7228BCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59E57CA7;
	Fri, 13 Sep 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1VDzhqY"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD1433C8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244254; cv=none; b=W4Q++Q14Wky0LamKao3K7wRfS7t+wnpyWkfP/L0NvvwK9lGf5HfPL3Io9SPKTwYbJzXa7NE3Hin5z7UPJof36J1mi0SYH2/bwcnNjT6HJSQSLcnTJKpyH7CGl7VL4XI9mj3eot2IpCiTUqh6HSD436KXp6MWF+bdjS+GWGor96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244254; c=relaxed/simple;
	bh=28q8xbfY7qmXvZ5AdJG3JOz/LrZu1iEyRQgo03T+o7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODMl394A5e0co66tcVPX1STE8CC/2IRcdTRoy2bhKTrWEN7MU6o3xCbPHGhiZpfoLvTkGIAy9omPvYkx716Fe6/SICq1gEqVI1b5iDzXYmIy7aB5l7ubLKrk6bcJAhWF6JU0XGUBsqmTRdIcfLYP7BgM6z37DIQH1JZ3FfzD7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1VDzhqY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8ee26af-3bd0-48d6-a130-65ceb56f23e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726244250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/yudrrTMbvFtpJWf16FJrES92TDLTd9teFau1I1jpI=;
	b=t1VDzhqYKv1FqGEgbgpvPbtdVUipZEJAgOtlkdIfXb1guM1oeGlBnyiBDcwyoIOqvUQfP0
	ML7A5++KK/9+o9EbI9xb4/JpAcUfrhX1+wQWDuAnzNNA5lVHUOidBnISTbDLxLHAd+4duM
	hvLVO/glueOiDaE2vjzk4OODAYGiILQ=
Date: Fri, 13 Sep 2024 12:17:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Brett Creeley <bcreeley@amd.com>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
 <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
 <e127f072-e034-4d21-a71f-4b140102118f@linux.dev>
 <53a6c904-161b-4665-a0c5-fda1cf838654@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <53a6c904-161b-4665-a0c5-fda1cf838654@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 12:08, Brett Creeley wrote:
> 
> 
> On 9/13/2024 8:23 AM, Sean Anderson wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On 9/13/24 11:16, Eric Dumazet wrote:
>>> On Fri, Sep 13, 2024 at 5:10 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>>>
>>>> The threadirqs kernel parameter can be used to force threaded IRQs even
>>>> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
>>>> skip disabling local interrupts. This defaults to false on regular
>>>> kernels, and is always true on PREEMPT_RT kernels.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>>>
>>>>   net/core/dev.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index 1e740faf9e78..112e871bc2b0 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
>>>>    */
>>>>   void __napi_schedule_irqoff(struct napi_struct *n)
>>>>   {
>>>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>>> +       if (!force_irqthreads())
>>>>                  ____napi_schedule(this_cpu_ptr(&softnet_data), n);
>>>>          else
>>>>                  __napi_schedule(n);
>>>> -- 
>>>> 2.35.1.1320.gc452695387.dirty
>>>>
>>>
>>> Seems reasonable, can you update the comment (kdoc) as well ?
>>>
>>> It says :
>>>
>>>   * On PREEMPT_RT enabled kernels this maps to __napi_schedule()
>>>   * because the interrupt disabled assumption might not be true
>>>   * due to force-threaded interrupts and spinlock substitution.
>>
>> OK
>>
>>> Also always specify net or net-next for networking patches.
>>
>> Ah, sorry. Should be net-next.
> 
> Is this worthy for a fixes/net tag?

Maybe? Commit 8380c81d5c4f ("net: Treat __napi_schedule_irqoff() as
__napi_schedule() on PREEMPT_RT") originally introduced the condition on
PREEMPT_RT but didn't include any fixes. And that's probably because
there's nothing wrong with the original behavior as long as you add
IRQF_NO_THREAD to your interrupt. Although at the time threadirqs had
existed for a while, so maybe this commit should fix that one.

--Sean

