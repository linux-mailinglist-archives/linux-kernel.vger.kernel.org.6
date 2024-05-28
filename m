Return-Path: <linux-kernel+bounces-192566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDA08D1F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00D0B22934
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521DD16FF27;
	Tue, 28 May 2024 14:46:35 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BE107A0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907594; cv=none; b=do3GfoZ2iV7nsNqNCgg/nUrupD8sL2UBdgciZcXrmUvYiXPadzA8h+qBzUexhP28ckv6iMsoExkANVLrv0pQnShtJs+wuErmuzLuq5wKHOtmSNVpR847sgCoYHnAdewSXC2k6rI7qMRHokyfZMKxEqi0jewW4vhH0t+sC5/wYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907594; c=relaxed/simple;
	bh=vLqVlrQmFst6uvCZmManf+IPjEYT46APy0CdgiX3KFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6RHruP/6N+SgP7daga8oh6McsjN8UGunA9m1XPzGJue8xnTP7ilYhFgSQMLvmRAdLzMmxA689eflupBw6Gc0TocP+6fOQbFj7hIXetNm0NmKr6OEwBA0VDxPa3tushm2I8Njp3+MyWP+7axc/MelB0HSrgOQbqzh1Q/8GJNZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VpZX03nw9z9v7Jk
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:24:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B81E11404F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:46:14 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwBXkCQp7lVmHb4SCQ--.53411S2;
	Tue, 28 May 2024 15:46:14 +0100 (CET)
Message-ID: <c366a946-fa00-44b2-88bd-c724b3b7a39e@huaweicloud.com>
Date: Tue, 28 May 2024 16:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 4/4] tools/memory-model: Distinguish between
 syntactic and semantic tags
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
 <20240527152253.195956-5-jonas.oberhauser@huaweicloud.com>
 <5ce0c8a3-bd9c-475a-9427-7edef47a90f2@rowland.harvard.edu>
 <dbcecf28-98e8-4f7e-957b-e73a4d811051@huaweicloud.com>
 <f9ea1b36-b345-4c94-a19f-4fa124d8f7c3@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <f9ea1b36-b345-4c94-a19f-4fa124d8f7c3@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBXkCQp7lVmHb4SCQ--.53411S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4fGrWUurWxWF17JF1rCrg_yoW8ArWkpF
	WIqa1Fkr4DJayayw4ktr1IqFyFv34FgFW5XF1SqrWI93Z0gryxuF1xGrWj9FWDZrn5Zw4U
	tay2v34xAa4kXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/28/2024 um 4:01 PM schrieb Alan Stern:
> On Tue, May 28, 2024 at 02:49:38PM +0200, Jonas Oberhauser wrote:
>>>> +let Mb = MB \ FailedRMW
>>>>>>    (* Compute marked and plain memory accesses *)
>>>> -let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
>>>> +let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | domain(rmw) | range(rmw) |
>>>
>>> The new MB term isn't needed, because MB tags on memory accesses are
>>> filtered out unless the access also belongs to domain(rmw) | range(rmw).
>>>
>>> Alan
>>
>>
>> Thanks for all the notes.
>> I think on this one is needed though under the assumption that herd7 would
>> no longer know internally to replace the MB with ONCE in case
>> of failure.

> Hmmm, this raises another question: Shouldn't the R event for a failed
> cmpxchg_release count as marked?  

Yes.

> At the moment it's not clear how such
> events will be tagged.

If by "at the moment" you mean the current herd7, then (as mentioned in 
the cover letter) this patch does not work at all with the current herd7 
because IIUC in fact ACQUIRE and RELEASE tags will be replaced by Once 
in all cases (so smp_store_release would be a store Once ...).

However, in a hypothetical version of herd7 which just leaves all the 
syntactic tags intact, we would get R & RMW & RELEASE, which would not 
be in the Release set (by nature of failing and being a read) but would 
be Marked (by nature of having a syntactic RELEASE tag).

> Perhaps the best thing to do is add RMW to
> this list, which would make domain(rmw) and range(rmw) unnecessary.


That's also a good idea.

> And then we probably don't need to keep MB

That's correct, although as a failsafe I would probably keep it anyways 
- it doesn't harm, but it may prevent a gotcha.

Have fun,
   jonas


