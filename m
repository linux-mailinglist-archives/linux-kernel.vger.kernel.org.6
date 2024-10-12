Return-Path: <linux-kernel+bounces-362009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679599AFE8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204E81F22BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDED528;
	Sat, 12 Oct 2024 01:50:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDCDDC1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697853; cv=none; b=u5/qrsY5PJ0W6M+q+V5hD4yGY4SC+Bgs0VJNM5URlPgeCL5toHrixby8vzF81UlBe2rlRGHB/JgBpoMsN4DEnSuTDccnit0EUlHfNM/952fp1Fob4k4Q20dkkCqTbxU4ssJwhHgI6eqsrPVqLkvmykY9HX8MiWQTJucSbalXrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697853; c=relaxed/simple;
	bh=XwUA4HQVTLWftHWbWzgeRtBz5HBj2L4N/TNdDvOxFME=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z7l5BzO39k7Ve55oGEsbGdOfHOVrMx+QBzupcXhMCaYxuB/Hq71gSqy63nd51EsBDV6cSCPt4VIm4ZWU2C5t1IeK0ozJIpjYqfi0wQOsryoSV8mBF7PNU/BaKIR6EBT6MxJ8n024Gx7FDGFA2IyhBV70CsstT4Y8NidWLZZ9prE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XQRH32vLqzpWf9;
	Sat, 12 Oct 2024 09:48:47 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id A8C92180AE9;
	Sat, 12 Oct 2024 09:50:46 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 09:50:46 +0800
Subject: Re: [patch 03/25] debugobjects: Dont destroy kmem cache in init()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.137021337@linutronix.de>
 <c118dad2-4e39-78f2-c09b-0fe771feb86a@huawei.com> <878quwi3jb.ffs@tglx>
 <02904743-8c39-5a44-78cd-a41715bf2f0b@huawei.com> <87plo6gyug.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e8a845d4-bab7-33ae-07e9-89c38e6f19cc@huawei.com>
Date: Sat, 12 Oct 2024 09:50:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87plo6gyug.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/12 4:37, Thomas Gleixner wrote:
> On Thu, Oct 10 2024 at 21:31, Leizhen wrote:
>> On 2024/10/10 19:46, Thomas Gleixner wrote:
>>> On Thu, Oct 10 2024 at 10:14, Leizhen wrote:
>>>> On 2024/10/8 0:49, Thomas Gleixner wrote:
>>>>> -	if (!obj_cache || debug_objects_replace_static_objects()) {
>>>>> +	if (!cache || !debug_objects_replace_static_objects(cache)) {
>>>>>  		debug_objects_enabled = 0;
>>>>> -		kmem_cache_destroy(obj_cache);
>>>>
>>>> kmem_cache_destroy(cache) should be kept, or move it into debug_objects_replace_static_objects()
>>>> and place it above 'return false'.
>>>
>>> At that point it can't be destroyed. See the backtrace.
>>>
>>> So we just give the objects back and leak the kmem_cache.
>>
>> Oh, sorry, I didn't figure it out before, but now I do.
>> But shouldn't we add kmemleak_ignore(cache) ?
> 
> I don't know if it's worth the trouble. With the follow up changes the
> only reason why this can happen is that the static object conversion
> cannot allocate memory. Leaking the kmemcache in that case is the least
> of the worries.
> 
> I just tripped over that back trace because I intentionally triggered
> the error path.

Yes, that's an error path that almost never goes to.
OK, so keep it still.

> 
> Thanks,
> 
>         tglx
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

