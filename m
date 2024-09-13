Return-Path: <linux-kernel+bounces-328475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9149784C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C142F284F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1BA6E61B;
	Fri, 13 Sep 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTdiVRoN"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02A8120D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241005; cv=none; b=dTZp/9+2G/fccG9xp6UwuQHEYPGD5T75pqVe7/bZCQgDIyr7XkmuZkzUXbuP1r38mJ4zpIX6R7ziwQSCmbVGhpi80S2pdi7GiQ8bubVJghHN5cH+4o1wPH6ZFywMC2EdiNYtpXU1qL84ExOeE5YRk2V4m3jYhc06TJ6z3/ihT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241005; c=relaxed/simple;
	bh=3S58DXY55WpwVXDEntOH0JH7i3ZkHdmJYfPiFp2ysHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2cDy0aCZZmN28WJ9aRpaYVhiu8U1W5rMOUw8ZDqlcPjWcQMUiFuE4OQKUPkrLp7GccGhOPwt4I7YnlEFNy89gxISRP3igkis5FZ2ESoHe+q2jT3+sOKzHfJSMfKwWX7pW2MI2uZjT9J802JjfAGSgZ5j+OtJbQgyYim0jXfLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTdiVRoN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e127f072-e034-4d21-a71f-4b140102118f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726241001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjiZRz1f1ZhW4Id2MWE6ZKYWVTPhf2b5fR7566irLyc=;
	b=UTdiVRoN5Kns2ogC5NuLANhV8zVT0NAmqMISysZyEgW1uBQbSdd01qOu/R6++bm5k/XfzZ
	f97j6ICqdtpJg2MgRujFvbLAi8ThoS5lgqyxSsm8txAIrEaiK6eD02RtEvi0/1X7g0BZ4Q
	s5AXRoF+tVCoyDIvpjP9/aqJettwq7A=
Date: Fri, 13 Sep 2024 11:23:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
 <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 11:16, Eric Dumazet wrote:
> On Fri, Sep 13, 2024 at 5:10 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> The threadirqs kernel parameter can be used to force threaded IRQs even
>> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
>> skip disabling local interrupts. This defaults to false on regular
>> kernels, and is always true on PREEMPT_RT kernels.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>  net/core/dev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 1e740faf9e78..112e871bc2b0 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
>>   */
>>  void __napi_schedule_irqoff(struct napi_struct *n)
>>  {
>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> +       if (!force_irqthreads())
>>                 ____napi_schedule(this_cpu_ptr(&softnet_data), n);
>>         else
>>                 __napi_schedule(n);
>> --
>> 2.35.1.1320.gc452695387.dirty
>>
> 
> Seems reasonable, can you update the comment (kdoc) as well ?
> 
> It says :
> 
>  * On PREEMPT_RT enabled kernels this maps to __napi_schedule()
>  * because the interrupt disabled assumption might not be true
>  * due to force-threaded interrupts and spinlock substitution.

OK

> Also always specify net or net-next for networking patches.

Ah, sorry. Should be net-next.

--Sean


