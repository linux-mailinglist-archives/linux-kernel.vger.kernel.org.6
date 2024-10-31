Return-Path: <linux-kernel+bounces-390638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41D9B7CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE929282FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925F1A01C6;
	Thu, 31 Oct 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J19kYMGV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719781751;
	Thu, 31 Oct 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384416; cv=none; b=o0E07ssfkS7TrpDSSYgk4AUohKV+uYoO0Ag4k/6QX4OyGx3kCu8cz2K+OpBcn9GhJB3Mc/PGiIj1XGsS0zs7oDgYC74XF8m48P9juEDgWb0sL2JQMaW6Pa5J7FHXO/6bGBubp8fEhlCk4FgGx5nObwpmSSH2v0GficPxe9l7lx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384416; c=relaxed/simple;
	bh=V2z3r4p0OygZ4QgyQBLc05eGv+c1PrkFwqAlmlFoYns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEJyI1OD4vKEIYaCIa/aR7tssFaFb/Q7VuufBFbk4UIlo9YAGKqWHCg7N6/1gBj+kDrAjt/UwXNTDmBzef+sBWqD2YxYFpP/pcYZOlu6T/a/l98iwdYc8p1/smVkEAfo+baad5T9bssCCWK4cFosS6KaJoehu2hz7yLhq0EY+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J19kYMGV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kg0P4lg1nIKp7KumwZpkm4ToOJ5Q8FhIO5DTYH2Efw4=; b=J19kYMGVQBi9BBy59O83uP3nZm
	qv00IduAsft95dR149ebJI5EcUeesPLgDi1fMriDmvGIeEQrHDA6F8f9JEFm26GlMNngGIdhmsV62
	h/7yj142b7Xd6LLecv+0jUetn6wsAj3UYIncaduyjw89Ah4cgF4Ms+gVwfQdxztU5bczF8fvyHV4R
	F/NNIEHtCLTmopnxOQYA5TtrjE25SsHWCYUZZwUvB46BUfBPheXO8+IAy27Y+iTWZvSl/LfNyyuPY
	6bK4BjJRKoBGN/uImWHNk9v9YQNnIOTZfCAwLotVcPblJmN/STBf8o/jvcPjNH3aY8bVXddyWGzST
	9iuCnPKw==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6W1h-0002xI-19; Thu, 31 Oct 2024 15:19:53 +0100
Message-ID: <d65176f1-df6f-4e21-b281-469ec958f26f@igalia.com>
Date: Thu, 31 Oct 2024 11:19:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: David Hildenbrand <david@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-4-mcanal@igalia.com>
 <2c507326-3267-431e-936a-23e2ab6a3baf@redhat.com>
 <899284fa-953f-48a1-af29-222d0d55881c@igalia.com>
 <cfcfaed5-8612-46f4-b3dd-67e1d81d049f@redhat.com>
 <95c48a30-0696-4110-950e-e81afb4ffc2a@igalia.com>
 <5745d2ca-4d87-4d1f-b38f-734c7086f462@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <5745d2ca-4d87-4d1f-b38f-734c7086f462@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/10/24 10:33, David Hildenbrand wrote:
> On 31.10.24 14:24, Maíra Canal wrote:
>> Hi David,
>>
>> On 31/10/24 09:57, David Hildenbrand wrote:
>>> On 31.10.24 13:51, Maíra Canal wrote:
>>>> Hi David,
>>>>
>>>> On 31/10/24 09:37, David Hildenbrand wrote:
>>>>> On 30.10.24 13:58, Maíra Canal wrote:
>>>>>> Add the ``thp_shmem=`` kernel command line to allow specifying the
>>>>>> default policy of each supported shmem hugepage size. The kernel
>>>>>> parameter
>>>>>> accepts the following format:
>>>>>>
>>>>>> thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-
>>>>>> <size>[KMG]:<policy>
>>>>>>
>>>>>> For example,
>>>>>>
>>>>>> thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size
>>>>>>
>>>>>> By configuring the default policy of several shmem hugepages, the 
>>>>>> user
>>>>>> can take advantage of mTHP before it's been configured through sysfs.
>>>>>>
>>>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>>>> ---
>>>>>>     .../admin-guide/kernel-parameters.txt         |  10 ++
>>>>>>     Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>>>>>>     mm/shmem.c                                    | 109 +++++++++++++
>>>>>> ++++-
>>>>>>     3 files changed, 135 insertions(+), 1 deletion(-)
>>>>>>
>>>>
>>>> [...]
>>>>
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index dfcc88ec6e34..c2299fa0b345 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always
>>>>>> __read_mostly;
>>>>>>     static unsigned long huge_shmem_orders_madvise __read_mostly;
>>>>>>     static unsigned long huge_shmem_orders_inherit __read_mostly;
>>>>>>     static unsigned long huge_shmem_orders_within_size __read_mostly;
>>>>>> +static bool shmem_orders_configured __initdata;
>>>>>>     #endif
>>>>>>     #ifdef CONFIG_TMPFS
>>>>>> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
>>>>>>          * Default to setting PMD-sized THP to inherit the global
>>>>>> setting and
>>>>>>          * disable all other multi-size THPs.
>>>>>>          */
>>>>>> -    huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>>>>> +    if (!shmem_orders_configured)
>>>>>> +        huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>>>>>     #endif
>>>>>>         return;
>>>>>> @@ -5180,6 +5182,26 @@ struct kobj_attribute
>>>>>> thpsize_shmem_enabled_attr =
>>>>>>     #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>>>>>> +static inline int get_order_from_str(const char *size_str)
>>>>>> +{
>>>>>> +    unsigned long size;
>>>>>> +    char *endptr;
>>>>>> +    int order;
>>>>>> +
>>>>>> +    size = memparse(size_str, &endptr);
>>>>>> +
>>>>>> +    if (!is_power_of_2(size))
>>>>>> +        goto err;
>>>>>> +    order = get_order(size);
>>>>>> +    if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
>>>>>> +        goto err;
>>>>>> +
>>>>>> +    return order;
>>>>>> +err:
>>>>>> +    pr_err("invalid size %s in thp_shmem boot parameter\n", 
>>>>>> size_str);
>>>>>> +    return -EINVAL;
>>>>>> +}
>>>>>
>>>>> Hm, mostly copy and paste. You could reuse existing 
>>>>> get_order_from_str()
>>>>> simply by passing in the supported orders and moving error 
>>>>> reporting to
>>>>> the caller.
>>>>>
>>>>
>>>> Can I use functions from mm/huge_memory.c here?
>>>
>>> Yes, that's the idea.
>>>
>>
>> Unfortunately, it isn't possible without adding the function to a
>> header.
> 
> Well ... sure, what's the problem with that?

David & Barry, how do you feel about adding `get_order_from_str()` to
lib/cmdline.c?

Best Regards,
- Maíra

> 


