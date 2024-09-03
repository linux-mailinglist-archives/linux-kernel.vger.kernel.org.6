Return-Path: <linux-kernel+bounces-313009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99B3969EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3871F24EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085561A726D;
	Tue,  3 Sep 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzwIGbkm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BB1CA6AF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369860; cv=none; b=fMwGCDYgejKA3Ex2jjU/IsMj5wzGeNJy6ZWCGxpU5mhfltxHfJgq0Ex2P2SeUPqa4dDUnMOKWqyKN1RxVqgSBC0M+2CWaWCQcpDO0y7OP5iwC5GW+VYOwDRBDOAaEP5vKuNzl3XbRPFs8g6/YWsTsoBnorpsL3tDMwCb6vxNEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369860; c=relaxed/simple;
	bh=8YVLXhDhqqmJ8iift7tYrNvCIwI3ZUn4scQZalvinuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuxnHFIwbl0Q6dXcJsNSD1IYWkJoiYoSrOQ75ikHc4pBYRRaJsjqrJ5p0HutXv0psD6W8JpZAD4gai1QkIAvkvrkx5JpaImQbeukL8eIaP1yCfg3pYdldxyBuq5nTDyQYXOh8gER9zGFqtw3Lq9LvCJ1koosOK33vUkYm9Ds03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzwIGbkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725369857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghPHEvdoDmipgIdCSuvU6E6B9zqjyhhmpEJwlzNWqhQ=;
	b=PzwIGbkm89P+HoJNtn74Knbeu97ulaLLvl6iuF1nTTpJL8ZpS9SarFTD/jG8REvCeoVSa5
	Z+RYPKP8OnigG6DodAjBhEPpP+E96opsasoPkk0TJqu2V+xkTXoqFq92jEXZOaucusHyWG
	tHCgX2eRLZeXziRDkFhIKVKFYPxNKJQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-no3ofb49PoWW46HWr9IHKA-1; Tue,
 03 Sep 2024 09:24:14 -0400
X-MC-Unique: no3ofb49PoWW46HWr9IHKA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4293818EA80D;
	Tue,  3 Sep 2024 13:24:12 +0000 (UTC)
Received: from [10.2.16.89] (unknown [10.2.16.89])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E82C19560AE;
	Tue,  3 Sep 2024 13:24:09 +0000 (UTC)
Message-ID: <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
Date: Tue, 3 Sep 2024 09:24:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZtcK3aF_d3BUhiVz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 9/3/24 09:10, Frederic Weisbecker wrote:
> Le Sun, Aug 18, 2024 at 07:45:18PM -0400, Waiman Long a écrit :
>> The HK_FLAG_SCHED/HK_TYPE_SCHED flag is defined and is also used
>> in kernel/sched/fair.c since commit de201559df87 ("sched/isolation:
>> Introduce housekeeping flags"). However, the corresponding cpumask isn't
>> currently updated anywhere. So the mask is always cpu_possible_mask.
>>
>> Add it in nohz_full setup so that nohz_full CPUs will now be removed
>> from HK_TYPE_SCHED cpumask.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/isolation.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 5891e715f00d..a514994af319 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -196,7 +196,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
>>   	unsigned long flags;
>>   
>>   	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
>> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
>> +		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED;
>>   
>>   	return housekeeping_setup(str, flags);
>>   }
> find_new_ilb() already has HK_FLAG_MISC to prevent an isolated CPU
> from being elected as an ilb. So I think we should simply remove HK_FLAG_SCHED.

There is a check for HK_TYPE_SCHED in nohz_balance_enter_idle() and 
nohz_newidle_balance(), though it is essentially a no-op as the cpumask 
has all the CPUs. If we remove HK_TYPE_SCHED, the question now will be 
whether we should remove the checks at these 2 functions or change them 
to HK_TYPE_MISC.

Cheers,
Longman

>
> Thanks.
>


