Return-Path: <linux-kernel+bounces-280608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731694CCC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FA1281882
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5718FC85;
	Fri,  9 Aug 2024 08:57:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEB1129E9C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193840; cv=none; b=dlgUKEAvkWTWhwBNwSL/oNL5XNX+7mFetPcu5bxJkX+eRUX6hvi90AX+Ff6I3I/NnRTgxp4c094zY6MwI8umQrV2rsKgMmVKL9+WhkvtS9TtVHXRXtLo7KvUU1TaRKzWxRYNP7nKXxA+ficrKVABZ7iR4m0f9QjEVQiNwwyuDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193840; c=relaxed/simple;
	bh=DyoDyzDDmJq2N0QbVPAtkFu4MvXTxSXorrZmNmiKcKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouElIG2HBz9ozTE31ZgecWAUpZb03UjQ2ggQ6rLxCbY/gSVENEY3fQtkTxzdIjKWkcNnv76NUU8j/KROeZyPlghJNx/AIpxP/1L8B8zgk25PNbkEhCArVpysrd58LgZzC63SwqjPRPFLpHIj9kf4cdhrHYd1+ZxPY+L9b64/FPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA100FEC;
	Fri,  9 Aug 2024 01:57:42 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A944B3F6A8;
	Fri,  9 Aug 2024 01:57:15 -0700 (PDT)
Message-ID: <f50a4630-c3bf-4af5-a17f-133ef599e705@arm.com>
Date: Fri, 9 Aug 2024 09:57:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808101700.571701-1-ryan.roberts@arm.com>
 <CAGsJ_4zPCFhngM0R5X6zGSw6KHPYqT8b7izQZt2xoFPSxCpRng@mail.gmail.com>
 <fe784034-0321-481b-96c0-ac5c48e0fb84@arm.com>
 <CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2024 09:31, Barry Song wrote:
> On Fri, Aug 9, 2024 at 3:58 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 08/08/2024 22:17, Barry Song wrote:
>>> On Thu, Aug 8, 2024 at 10:17 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Add thp_anon= cmdline parameter to allow specifying the default
>>>> enablement of each supported anon THP size. The parameter accepts the
>>>> following format and can be provided multiple times to configure each
>>>> size:
>>>>
>>>> thp_anon=<size>[KMG]:<value>
>>>>
>>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
>>>>
>>>> Configuring the defaults at boot time is useful to allow early user
>>>> space to take advantage of mTHP before its been configured through
>>>> sysfs.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>
>>>> Hi All,
>>>>
>>>> I've split this off from my RFC at [1] because Barry highlighted that he would
>>>> benefit from it immediately [2]. There are no changes vs the version in that
>>>> series.
>>>>
>>>> It applies against today's mm-unstable (275d686abcb59). (although I had to fix a
>>>> minor build bug in stackdepot.c due to MIN() not being defined in this tree).
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>  .../admin-guide/kernel-parameters.txt         |  8 +++
>>>>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>>>>  mm/huge_memory.c                              | 55 ++++++++++++++++++-
>>>>  3 files changed, 82 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index bcdee8984e1f0..5c79b58c108ec 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -6631,6 +6631,14 @@
>>>>                         <deci-seconds>: poll all this frequency
>>>>                         0: no polling (default)
>>>>
>>>> +       thp_anon=       [KNL]
>>>> +                       Format: <size>[KMG]:always|madvise|never|inherit
>>>> +                       Can be used to control the default behavior of the
>>>> +                       system with respect to anonymous transparent hugepages.
>>>> +                       Can be used multiple times for multiple anon THP sizes.
>>>> +                       See Documentation/admin-guide/mm/transhuge.rst for more
>>>> +                       details.
>>>> +
>>>>         threadirqs      [KNL,EARLY]
>>>>                         Force threading of all interrupt handlers except those
>>>>                         marked explicitly IRQF_NO_THREAD.
>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>> index 24eec1c03ad88..f63b0717366c6 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would block the collapse::
>>>>
>>>>  A higher value may increase memory footprint for some workloads.
>>>>
>>>> -Boot parameter
>>>> -==============
>>>> +Boot parameters
>>>> +===============
>>>>
>>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>>> -to the kernel command line.
>>>> +You can change the sysfs boot time default for the top-level "enabled"
>>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>>> +kernel command line.
>>>> +
>>>> +Alternatively, each supported anonymous THP size can be controlled by
>>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>>> +``inherit``.
>>>> +
>>>> +For example, the following will set 64K THP to ``always``::
>>>> +
>>>> +       thp_anon=64K:always
>>>> +
>>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>>> +not explicitly configured on the command line are implicitly set to
>>>> +``never``.
>>>>
>>>>  Hugepages in tmpfs/shmem
>>>>  ========================
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 0c3075ee00012..c2c0da1eb94e6 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>>>>  unsigned long huge_anon_orders_always __read_mostly;
>>>>  unsigned long huge_anon_orders_madvise __read_mostly;
>>>>  unsigned long huge_anon_orders_inherit __read_mostly;
>>>> +static bool anon_orders_configured;
>>>>
>>>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>                                          unsigned long vm_flags,
>>>> @@ -672,7 +673,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>>>>          * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>>>>          * constant so we have to do this here.
>>>>          */
>>>> -       huge_anon_orders_inherit = BIT(PMD_ORDER);
>>>> +       if (!anon_orders_configured) {
>>>> +               huge_anon_orders_inherit = BIT(PMD_ORDER);
>>>> +               anon_orders_configured = true;
>>>> +       }
>>>
>>> If a user configures 64KB and doesn't adjust anything for PMD_ORDER,
>>> then PMD_ORDER will  be set to "never", correct? This seems to change
>>> the default behavior of PMD_ORDER. Could we instead achieve this by
>>> checking if PMD_ORDER has been explicitly configured?
>>
>> Yes, that's how it's implemented in this patch, and the accompanying docs also
>> state:
>>
>>   If ``thp_anon=`` is specified at least once, any anon THP sizes
>>   not explicitly configured on the command line are implicitly set to
>>   ``never``.
>>
>> My initial approach did exactly as you suggest. But in the original series, I
>> also had a similar patch to configure file thp with "thp_file=". And for file,
>> all of the orders default to `always`. So if taking the same approach with that
>> control, the user would have to explicitly opt-out of all supported orders
>> rather than just opt-in to the orders they want. And I thought that could get
>> tricky in future if support is added for more orders. I felt that was
>> potentially very confusing so decided it was clearer to have the above rule and
>> make both controls consistent.
>>
>> What do you think?
> 
> If this is the intention, once the user sets the command line, they should
> realize that the default settings have been overridden. I am perfectly fine
> with this strategy.

OK. I can see it from both sides to be honest. Let's see if anyone else has
issue with this approach.

> 
> with the below cmdline:
>  thp_anon=64K:always thp_anon=8K:inherit thp_anon=32K:madvise
> thp_anon=1M:inherit thp_anon=2M:always
> 
> I am getting:
>   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
>   [always] inherit madvise never
>   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
>   always inherit [madvise] never
>   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled
>   always [inherit] madvise never
>   / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>   [always] inherit madvise never

And you should also be seeing a warning in the boot log that thp_anon=8K:inherit
is unrecognised (since anon doesn't support order-1).

> 
> Thus,
> 
> Tested-by: Barry Song <baohua@kernel.org>

Thanks!

> 
>>
>>
>>>
>>>>
>>>>         *hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>>>>         if (unlikely(!*hugepage_kobj)) {
>>>> @@ -857,6 +861,55 @@ static int __init setup_transparent_hugepage(char *str)
>>>>  }
>>>>  __setup("transparent_hugepage=", setup_transparent_hugepage);
>>>>
>>>> +static int __init setup_thp_anon(char *str)
>>>> +{
>>>> +       unsigned long size;
>>>> +       char *state;
>>>> +       int order;
>>>> +       int ret = 0;
>>>> +
>>>> +       if (!str)
>>>> +               goto out;
>>>> +
>>>> +       size = (unsigned long)memparse(str, &state);
>>>> +       order = ilog2(size >> PAGE_SHIFT);
>>>> +       if (*state != ':' || !is_power_of_2(size) || size <= PAGE_SIZE ||
>>>> +           !(BIT(order) & THP_ORDERS_ALL_ANON))
>>>> +               goto out;
>>>> +
>>>> +       state++;
>>>> +
>>>> +       if (!strcmp(state, "always")) {
>>>> +               clear_bit(order, &huge_anon_orders_inherit);
>>>> +               clear_bit(order, &huge_anon_orders_madvise);
>>>> +               set_bit(order, &huge_anon_orders_always);
>>>> +               ret = 1;
>>>> +       } else if (!strcmp(state, "inherit")) {
>>>> +               clear_bit(order, &huge_anon_orders_always);
>>>> +               clear_bit(order, &huge_anon_orders_madvise);
>>>> +               set_bit(order, &huge_anon_orders_inherit);
>>>> +               ret = 1;
>>>> +       } else if (!strcmp(state, "madvise")) {
>>>> +               clear_bit(order, &huge_anon_orders_always);
>>>> +               clear_bit(order, &huge_anon_orders_inherit);
>>>> +               set_bit(order, &huge_anon_orders_madvise);
>>>> +               ret = 1;
>>>> +       } else if (!strcmp(state, "never")) {
>>>> +               clear_bit(order, &huge_anon_orders_always);
>>>> +               clear_bit(order, &huge_anon_orders_inherit);
>>>> +               clear_bit(order, &huge_anon_orders_madvise);
>>>> +               ret = 1;
>>>> +       }
>>>> +
>>>> +       if (ret)
>>>> +               anon_orders_configured = true;
>>>
>>> I mean:
>>>
>>> if (ret && order == PMD_ORDER)
>>>             anon_pmd_order_configured = true;
>>>
>>>> +out:
>>>> +       if (!ret)
>>>> +               pr_warn("thp_anon=%s: cannot parse, ignored\n", str);
>>>> +       return ret;
>>>> +}
>>>> +__setup("thp_anon=", setup_thp_anon);
>>>> +
>>>>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>>>>  {
>>>>         if (likely(vma->vm_flags & VM_WRITE))
>>>> --
>>>> 2.43.0
>>>>
>>>
>>> Thanks
>>> Barry
>>


