Return-Path: <linux-kernel+bounces-257079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E549374EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DFD1F21AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C76EB7D;
	Fri, 19 Jul 2024 08:18:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B2208BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377124; cv=none; b=NHNcJb8oFr7IZ+sP7q1c5wEfOyVtgPPpq0dsTmL5gwwz/Gb+4Z3y12Bb9C1rogsCmMj0zaYDtuTiwn5SKB67JVsJuyz7msAy1pYo14CBoI8Yxmg6D/x8jJKqhvziZ06Ml9yy+na1xiLZhBGo1tqHYcvSRILcfBbBZb23a3V7e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377124; c=relaxed/simple;
	bh=HDW6dMvBwS6UBOIDI+vLt4Sx9qWShaZEWDwQePeBODQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAnewVMiUDfT1oDuKbg30UHydKkiA4PzRaEDBaB04x1KkAZRS6bm5HY69XXN6EjZWYBOHpAWeoYa1175p7KVbT3akhlT8vmtm9L7CC9k4WJauZQ99ey3H1UwSt86qhu0SuhneEmOtNBuTvavD3FMjmHbjhaoycB3BK2x9MGJWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A44F1042;
	Fri, 19 Jul 2024 01:19:06 -0700 (PDT)
Received: from [10.57.76.151] (unknown [10.57.76.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07823F766;
	Fri, 19 Jul 2024 01:18:38 -0700 (PDT)
Message-ID: <f2d1986a-c3bd-4a37-9028-97df44da4b11@arm.com>
Date: Fri, 19 Jul 2024 09:18:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm: Override mTHP "enabled" defaults at kernel
 cmdline
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <20240717071257.4141363-4-ryan.roberts@arm.com>
 <CAGsJ_4wiZRP9siEk9WpAYRjj-gehxptGY9XWC8k3N4QHBppAhQ@mail.gmail.com>
 <fa5bd4cb-6d5c-4cb7-bb41-3c277e291cd6@arm.com>
 <CAGsJ_4xSDc8pX+-vOUcXtV_ivt0Jc-LECiC=tto9oxYeOtU38Q@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xSDc8pX+-vOUcXtV_ivt0Jc-LECiC=tto9oxYeOtU38Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/07/2024 08:52, Barry Song wrote:
> On Fri, Jul 19, 2024 at 7:48 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 19/07/2024 01:46, Barry Song wrote:
>>> On Wed, Jul 17, 2024 at 7:13 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
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
>>>
>>> This is exactly what I need and want to implement, as the current behavior
>>> is problematic. We need to boot up the system and reach the point where
>>> we can set up the sys interfaces to enable mTHP. Many processes miss the
>>> opportunity to use mTHP.
>>>
>>> On the other hand, userspace might have been tuned to detect that mTHP
>>> is enabled, such as a .so library. However, it turns out we have had
>>> inconsistent settings between the two stages - before and after setting
>>> mTHP enabled by sys interfaces.
>>
>> Good feedback - sounds like I should separate out this patch from the rest of
>> the series to get it reviewed and merged faster?
> 
> +1

OK I'll wait a couple of days to see if anyone has any feedback against this
version, then I'll re-post this on its own.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  .../admin-guide/kernel-parameters.txt         |  8 +++
>>>>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>>>>  mm/huge_memory.c                              | 55 ++++++++++++++++++-
>>>>  3 files changed, 82 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index bc55fb55cd26..48443ad12e3f 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -6592,6 +6592,14 @@
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
>>>> index 1aaf8e3a0b5a..f53d43d986e2 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>> @@ -311,13 +311,27 @@ performance.
>>>>  Note that any changes to the allowed set of sizes only applies to future
>>>>  file-backed THP allocations.
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
>>>> index 4249c0bc9388..794d2790d90d 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -82,6 +82,7 @@ unsigned long huge_anon_orders_madvise __read_mostly;
>>>>  unsigned long huge_anon_orders_inherit __read_mostly;
>>>>  unsigned long huge_file_orders_always __read_mostly;
>>>>  int huge_file_exec_order __read_mostly = -1;
>>>> +static bool anon_orders_configured;
>>>>
>>>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>                                          unsigned long vm_flags,
>>>> @@ -763,7 +764,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>>>>          * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>>>>          * constant so we have to do this here.
>>>>          */
>>>> -       huge_anon_orders_inherit = BIT(PMD_ORDER);
>>>> +       if (!anon_orders_configured) {
>>>> +               huge_anon_orders_inherit = BIT(PMD_ORDER);
>>>> +               anon_orders_configured = true;
>>>> +       }
>>>>
>>>>         /*
>>>>          * For pagecache, default to enabling all orders. powerpc's PMD_ORDER
>>>> @@ -955,6 +959,55 @@ static int __init setup_transparent_hugepage(char *str)
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
>>


