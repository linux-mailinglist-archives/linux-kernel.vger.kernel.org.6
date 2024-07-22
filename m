Return-Path: <linux-kernel+bounces-259118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5617A939180
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D111F221BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080E16DEB2;
	Mon, 22 Jul 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCNX+vhQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171A16DC38
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661193; cv=none; b=h69t6EUib166BbqpJ0ZkU5oVUxTwg90U38vaM896Tbo8PjmyGPWsyYOISBFdGCxhfKIjiSYnOyqV+RCG6owRg+pB57DTPTt1d3YL/svGsciWI5h5N5oo30ygKwXcS6/o5A3VCRbJQggQUMGMZsejWeNgqGTwg9ruUG10IYsuzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661193; c=relaxed/simple;
	bh=WPd4rBuWpikv/p0NU+j9kgLvB4bGfYwsGcobXi6mMLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI7XJOdANGEdMgIxXU5R0iCUKoQcuu1tscFrXn6Y+LFRP+oCK/d8NENFXxD+GboXXstBarg0GOuDa8MbT+xEEP029S0B7fWvhX1Fg35GM+7W9iNL/QnwwkbBpc4TF5OvHlvrMXJ63Q6W8zBlvw8HBVQtAEA/U59aDBKz67gR3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCNX+vhQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721661190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMWVMXrQXYYFzMd10SNaCJx+3QOo1fp1CR3QhQ24B/8=;
	b=cCNX+vhQgc/zNFZZOkFmBJXXFkRI2H5Sl6FYjYQDBS8L0YZyOBWGrdToQBFQaDZKJO9sWn
	9qdIKcz1CQd3id5QbMMOkOLFwroC9JpVB2hmi1waHJFAwOWP1D8px+or2DX9EoqolDgJzB
	86HdTKoyDYmaTS0XCYL7YY6LqP+Omao=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-oujJkq3EPmWpP0MblAYt-Q-1; Mon,
 22 Jul 2024 11:13:07 -0400
X-MC-Unique: oujJkq3EPmWpP0MblAYt-Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A5DE1955D53;
	Mon, 22 Jul 2024 15:13:05 +0000 (UTC)
Received: from [10.22.17.2] (unknown [10.22.17.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91CE63000195;
	Mon, 22 Jul 2024 15:13:03 +0000 (UTC)
Message-ID: <64b0aba3-6eab-4418-9019-a7e1123fba96@redhat.com>
Date: Mon, 22 Jul 2024 11:13:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/pvqspinlock: Correct the type of "old" variable
 in pv_kick_node()
To: maobibo <maobibo@loongson.cn>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240721164552.50175-1-ubizjak@gmail.com>
 <62c029b7-13dc-f4fc-d67a-7bd86f973e2f@loongson.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <62c029b7-13dc-f4fc-d67a-7bd86f973e2f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 7/22/24 02:54, maobibo wrote:
> Uros,
>
> Sorry for late reply because of weekend time. This modification works 
> well for me.
>
> In later I want to define pv_node::state as int type on LoongArch 
> because there is only int32/int64 cmpxchg is better supported on the 
> system, however that is another issue.

I thought about changing pv_node::state to int, but that requires 
changing the pv_wait() call to use int too. That doesn't work because 
pv_wait() is also used to monitor the state of the lock byte of the 
qspinlock. In essence, we can't use pvqspinlock if 8-bit cmpxchg isn't 
supported.

Cheers,
Longman

>
> Tested-by:Bibo Mao <maobibo@loongson.cn>
>
> On 2024/7/22 上午12:45, Uros Bizjak wrote:
>> "enum vcpu_state" is not compatible with "u8" type for all targets,
>> resulting in:
>>
>> error: initialization of 'u8 *' {aka 'unsigned char *'} from 
>> incompatible pointer type 'enum vcpu_state *'
>>
>> for LoongArch. Correct the type of "old" variable to "u8".
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Fixes: fea0e1820b51 ("locking/pvqspinlock: Use try_cmpxchg() in 
>> qspinlock_paravirt.h")
>> Reported-by: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>> Closes: 
>> https://lore.kernel.org/lkml/20240719024010.3296488-1-maobibo@loongson.cn/
>> ---
>>   kernel/locking/qspinlock_paravirt.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/qspinlock_paravirt.h 
>> b/kernel/locking/qspinlock_paravirt.h
>> index f5a36e67b593..ac2e22502741 100644
>> --- a/kernel/locking/qspinlock_paravirt.h
>> +++ b/kernel/locking/qspinlock_paravirt.h
>> @@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock 
>> *node, struct mcs_spinlock *prev)
>>   static void pv_kick_node(struct qspinlock *lock, struct 
>> mcs_spinlock *node)
>>   {
>>       struct pv_node *pn = (struct pv_node *)node;
>> -    enum vcpu_state old = vcpu_halted;
>> +    u8 old = vcpu_halted;
>>       /*
>>        * If the vCPU is indeed halted, advance its state to match 
>> that of
>>        * pv_wait_node(). If OTOH this fails, the vCPU was running and 
>> will
>>
>


