Return-Path: <linux-kernel+bounces-390573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B739B7B99
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47297B20E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C8C19DF8D;
	Thu, 31 Oct 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eAzh/A3V"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17891BD9FC;
	Thu, 31 Oct 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381079; cv=none; b=Pawfed3Q0USMZtWIc0XCDWAYTfeD8DQQPTexU1W5q5rQV2aX78cs7sKq5ubv2wWXi6ACrZKHuZUi/cbbo5OsrhJGmM+rOp4vaBfABCUt+E4yCvHdKC9gx8MvnmHDMFOpZ9FEqXFdLlefHdIJLGDiVELJsc7AXorsAs1/jJkLAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381079; c=relaxed/simple;
	bh=etBw7lL2KSptNVbO8tJFws/RqXFvMyYgm+bsQEi4yR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgiI5dWiG/dXDbcCiPeDeSYMf9i2aqEnWkbpNQ5MkF7cXTQ4LkD2vaWIOxBPTrAY4M0wfkxAWuiJ4GDGMNAJqfNdAOza4OvWI2K4o2AcVorkV24z8rzXRl9Nksm/regTJ43fpwEIKA7av80iV4iZqaj/2Juuvb3Wo766L52jnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eAzh/A3V; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VFUExYJbzjpGCUKWqplKyt76LINRzQm1m5oqqk1sjF0=; b=eAzh/A3Vmx4XuSKHwLyp1tpaY4
	Bhp+Jo1SBhYCBaGWw09jgqvIVVWJlr7j/+PCtFTsZ//FMhrll/hsDxw0Y5hVTK/B2gytrc+MLLqpU
	zxH69w8JX65wLbUhLbnHNcqpZtnp5iZAEDSu1EugXWQimLLKglWc658u4CQW9w+5HInmrul5tV3Zr
	WLGGI6LkChI/gdmlgppepW8pERpyuxkLRGG36R63sS91YYPr1HbkWVR1ccSrbJhvrWv/FGYiIyWpf
	BE7WJo1sqiWS/D/cQI0wkb9CPr7WuG4fR0/IwXXW2nJfYwq/8L+d20yCsqqvXqVHVNBOJP/h6ex8C
	mGwP0Jhw==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6V9k-0001ol-5O; Thu, 31 Oct 2024 14:24:08 +0100
Message-ID: <95c48a30-0696-4110-950e-e81afb4ffc2a@igalia.com>
Date: Thu, 31 Oct 2024 10:24:01 -0300
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
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <cfcfaed5-8612-46f4-b3dd-67e1d81d049f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 31/10/24 09:57, David Hildenbrand wrote:
> On 31.10.24 13:51, Maíra Canal wrote:
>> Hi David,
>>
>> On 31/10/24 09:37, David Hildenbrand wrote:
>>> On 30.10.24 13:58, Maíra Canal wrote:
>>>> Add the ``thp_shmem=`` kernel command line to allow specifying the
>>>> default policy of each supported shmem hugepage size. The kernel
>>>> parameter
>>>> accepts the following format:
>>>>
>>>> thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-
>>>> <size>[KMG]:<policy>
>>>>
>>>> For example,
>>>>
>>>> thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size
>>>>
>>>> By configuring the default policy of several shmem hugepages, the user
>>>> can take advantage of mTHP before it's been configured through sysfs.
>>>>
>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         |  10 ++
>>>>    Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>>>>    mm/shmem.c                                    | 109 +++++++++++++ 
>>>> ++++-
>>>>    3 files changed, 135 insertions(+), 1 deletion(-)
>>>>
>>
>> [...]
>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index dfcc88ec6e34..c2299fa0b345 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always
>>>> __read_mostly;
>>>>    static unsigned long huge_shmem_orders_madvise __read_mostly;
>>>>    static unsigned long huge_shmem_orders_inherit __read_mostly;
>>>>    static unsigned long huge_shmem_orders_within_size __read_mostly;
>>>> +static bool shmem_orders_configured __initdata;
>>>>    #endif
>>>>    #ifdef CONFIG_TMPFS
>>>> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
>>>>         * Default to setting PMD-sized THP to inherit the global
>>>> setting and
>>>>         * disable all other multi-size THPs.
>>>>         */
>>>> -    huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>>> +    if (!shmem_orders_configured)
>>>> +        huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>>>    #endif
>>>>        return;
>>>> @@ -5180,6 +5182,26 @@ struct kobj_attribute 
>>>> thpsize_shmem_enabled_attr =
>>>>    #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>>>> +static inline int get_order_from_str(const char *size_str)
>>>> +{
>>>> +    unsigned long size;
>>>> +    char *endptr;
>>>> +    int order;
>>>> +
>>>> +    size = memparse(size_str, &endptr);
>>>> +
>>>> +    if (!is_power_of_2(size))
>>>> +        goto err;
>>>> +    order = get_order(size);
>>>> +    if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
>>>> +        goto err;
>>>> +
>>>> +    return order;
>>>> +err:
>>>> +    pr_err("invalid size %s in thp_shmem boot parameter\n", size_str);
>>>> +    return -EINVAL;
>>>> +}
>>>
>>> Hm, mostly copy and paste. You could reuse existing get_order_from_str()
>>> simply by passing in the supported orders and moving error reporting to
>>> the caller.
>>>
>>
>> Can I use functions from mm/huge_memory.c here?
> 
> Yes, that's the idea.
> 

Unfortunately, it isn't possible without adding the function to a
header.

I deleted `get_order_from_str()` from mm/shmem.c just to test it:

mm/shmem.c:5230:13: error: call to undeclared function 
'get_order_from_str'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
  5230 |                                 start = 
get_order_from_str(start_size);
       |                                         ^
mm/shmem.c:5233:19: error: call to undeclared function 
'get_order_from_str'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]
  5233 |                                 start = end = 
get_order_from_str(subtoken);
       |                                               ^
2 errors generated.
make[3]: *** [scripts/Makefile.build:229: mm/shmem.o] Error 1
make[2]: *** [scripts/Makefile.build:478: mm] Error 2
make[2]: *** Waiting for unfinished jobs....

Please, check the discussion I had with Barry about the pros and cons of
copy and paste and code refactor [1][2]. We ended up deciding to
duplicate the code.

[1] 
https://lore.kernel.org/linux-mm/CAGsJ_4wJ2xoNRLMNkmLL3x1t2YiqQJ1=saXa+HNxRUbSNivRCw@mail.gmail.com/
[2] 
https://lore.kernel.org/linux-mm/CAGsJ_4yp89one_hoB_87poU2wrpJh_0NVicRKW538eE6yo1kZw@mail.gmail.com/

Best Regards,
- Maíra


