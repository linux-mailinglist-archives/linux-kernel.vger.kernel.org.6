Return-Path: <linux-kernel+bounces-300656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D57895E6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D785B20E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3299BA2E;
	Mon, 26 Aug 2024 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ysm3pp2+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF787489
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724638744; cv=none; b=Ey1pS6aqYfSiVVDjMaZEG0u5HOfSNYyjupsRDgYl9XmUPCKDK2TBtDNHdv8ONZzTOZEAY0bjeIXG918THb/LFGyag0/DB+Ft1VmKNd9U1LhPh5o0JQJ+O3UtN9a6zI8rsGw60ESzqWod6/6+OeMJ37Y9bPvwL+SC1c92bTf0Cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724638744; c=relaxed/simple;
	bh=cpxFtFrDaAVbbqi2/Z4lQS+O2tK9ibojb2GgQmgm4yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccym6EtTEhkAxRQmSZx8GMnLXpS0OgacCmvR0/0xvXktQfAxGdnPM1kJJsE5Vq/PIydUqJgNlPK4GdtdIzjkrPKItJKmwlFQwBB3OykbfqMCUhnF6CJDCpOd5A5on8snhqBgtrgcfhQVNABw4Kfsjlq/GZSQ59LAYAzC2K+tYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ysm3pp2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724638741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QBXGHuwlMJiFVNO87FMUC97txRcnYGUsrxNWu1JS3c=;
	b=Ysm3pp2+pCQl5P9D65nr5yGA1V8JiCS/L+HEpr24NsQwOfk5rnIjiv1sYtbq/2tLtQ4zRR
	srte23+g/RLhVxyFIKpxhmGEESOdYv/OCV+dBKFGM6t9pZeQFhvtzUb/7wsgVuRqhx7wHT
	72/qYI1tSth/V8oqEBZHP6DWrOLOWz8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-vXq3FX5APEiUyeUxOe_eSw-1; Sun,
 25 Aug 2024 22:18:55 -0400
X-MC-Unique: vXq3FX5APEiUyeUxOe_eSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FE721955D4A;
	Mon, 26 Aug 2024 02:18:53 +0000 (UTC)
Received: from [10.2.16.7] (unknown [10.2.16.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 292471955F43;
	Mon, 26 Aug 2024 02:18:50 +0000 (UTC)
Message-ID: <8aec8306-18aa-44af-81ba-dbb6ca9dcca0@redhat.com>
Date: Sun, 25 Aug 2024 22:18:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 10/11] cgroup/cpuset: guard cpuset-v1 code under
 CONFIG_CPUSETS_V1
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240823100110.472120-1-chenridong@huawei.com>
 <20240823100110.472120-11-chenridong@huawei.com>
 <de64f686-fccb-4d33-99d8-b8b44dc534fa@redhat.com>
 <bcbaeb36-ad90-47a0-b832-86eadefd3e6a@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <bcbaeb36-ad90-47a0-b832-86eadefd3e6a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 8/25/24 21:34, Chen Ridong wrote:
>
>
> On 2024/8/26 1:25, Waiman Long wrote:
>> On 8/23/24 06:01, Chen Ridong wrote:
>>> This patch introduces CONFIG_CPUSETS_V1 and guard cpuset-v1 code under
>>> CONFIG_CPUSETS_V1. The default value of CONFIG_CPUSETS_V1 is N, so that
>>> user who adopted v2 don't have 'pay' for cpuset v1.
>>> Besides, to make code succinct, rename 
>>> '__cpuset_memory_pressure_bump()'
>>> to 'cpuset_memory_pressure_bump()', and expose it to the world, which
>>> takes place of the old mocro 'cpuset_memory_pressure_bump'.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>   include/linux/cpuset.h          |  8 +-------
>>>   init/Kconfig                    | 13 +++++++++++++
>>>   kernel/cgroup/Makefile          |  3 ++-
>>>   kernel/cgroup/cpuset-internal.h | 15 +++++++++++++++
>>>   kernel/cgroup/cpuset-v1.c       | 10 ++++++----
>>>   kernel/cgroup/cpuset.c          |  2 ++
>>>   6 files changed, 39 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>> index 2a6981eeebf8..f91f1f61f482 100644
>>> --- a/include/linux/cpuset.h
>>> +++ b/include/linux/cpuset.h
>>> @@ -99,13 +99,7 @@ static inline bool cpuset_zone_allowed(struct 
>>> zone *z, gfp_t gfp_mask)
>>>   extern int cpuset_mems_allowed_intersects(const struct task_struct 
>>> *tsk1,
>>>                         const struct task_struct *tsk2);
>>> -#define cpuset_memory_pressure_bump()                 \
>>> -    do {                            \
>>> -        if (cpuset_memory_pressure_enabled)        \
>>> -            __cpuset_memory_pressure_bump();    \
>>> -    } while (0)
>>> -extern int cpuset_memory_pressure_enabled;
>>> -extern void __cpuset_memory_pressure_bump(void);
>>> +extern void cpuset_memory_pressure_bump(void);
>>>   extern void cpuset_task_status_allowed(struct seq_file *m,
>>>                       struct task_struct *task);
>>
>> As you are introducing a new CONFIG_CPUSET_V1 kconfig option, you can 
>> use it to eliminate a useless function call if cgroup v1 isn't 
>> enabled. Not just this function, all the v1 specific functions should 
>> have a !CONFIG_CPUSET_V1 version that can be optimized out.
>>
>> Cheers,
>> Longman
>>
>>
> Hi, Longman, currently, we have only added one place to manage all the 
> functions whose are empty if !CONFIG_CPUSET_V1 is not defined , and 
> the caller does not need to care about using cpuset v1 or v2, which 
> makes it succinct.
>
> However, we have to add !CONFIG_CPUSET_V1 to many places to avoid 
> useless function calls. I am not opposed to do this if you thick it 'a 
> better implementation.

You don't need to touch any files that use these cgroup v1 only 
functions. You only need to add some #ifdef code in the cpuset.h header 
file like

#ifdef CONFIG_CPUSET_V1
extern void cpuset_memory_pressure_bump(void);
#else
static inline void cpuset_memory_pressure_bump(void) { }
#endif

BTW, try not to introduce unnecessary performance regression. The reason 
cpuset_memory_pressure_bump() is a macro is to avoid a function call if 
cpuset_memory_pressure_enabled isn't set which is most likely case. It 
is cheaper to read a variable than do a function call.

Cheers,
Longman




