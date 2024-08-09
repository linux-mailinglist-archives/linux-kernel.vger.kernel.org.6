Return-Path: <linux-kernel+bounces-280532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D646C94CBC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EC01C209E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928CC18C908;
	Fri,  9 Aug 2024 07:58:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B81741C8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190315; cv=none; b=XnDgd3HlsruBl82ePbktUFTDIlTMqhZNM4npel4lYIuWDh1waqgI8jLPQRpVggDrRiKR6erzlNgT4HX1OxuI4PuEhzzlCgoIw67W6ikB8Nrp11pFw1nuhMiXsBAhjx2HCsyHKMZMDL0QCK3hlVOOt5q6lWs05JuZ7nR0PevxpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190315; c=relaxed/simple;
	bh=f52BAY9VzR7BIQMp8dRhSL2Ohz1j+rfbb6M1lspzfv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWCBxOUrXW27znWSTDYl1d6ewBZNrPP7jf4onXCnip/V3DeBUPBkNOY8SyRRxb4CgWC0PlOj7OnYbYHabo/dvK2WvDNS71m7XUxM3KZR35OCT5xHmkpWSqEv13etmy2cebVtZJDl4cRby7VFRyI1W0CxGBGZFdYLlCuczi8L9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D6DFFEC;
	Fri,  9 Aug 2024 00:58:58 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2754D3F6A8;
	Fri,  9 Aug 2024 00:58:31 -0700 (PDT)
Message-ID: <fe784034-0321-481b-96c0-ac5c48e0fb84@arm.com>
Date: Fri, 9 Aug 2024 08:58:29 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zPCFhngM0R5X6zGSw6KHPYqT8b7izQZt2xoFPSxCpRng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/08/2024 22:17, Barry Song wrote:
> On Thu, Aug 8, 2024 at 10:17 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Add thp_anon= cmdline parameter to allow specifying the default
>> enablement of each supported anon THP size. The parameter accepts the
>> following format and can be provided multiple times to configure each
>> size:
>>
>> thp_anon=<size>[KMG]:<value>
>>
>> See Documentation/admin-guide/mm/transhuge.rst for more details.
>>
>> Configuring the defaults at boot time is useful to allow early user
>> space to take advantage of mTHP before its been configured through
>> sysfs.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Hi All,
>>
>> I've split this off from my RFC at [1] because Barry highlighted that he would
>> benefit from it immediately [2]. There are no changes vs the version in that
>> series.
>>
>> It applies against today's mm-unstable (275d686abcb59). (although I had to fix a
>> minor build bug in stackdepot.c due to MIN() not being defined in this tree).
>>
>> Thanks,
>> Ryan
>>
>>
>>  .../admin-guide/kernel-parameters.txt         |  8 +++
>>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>>  mm/huge_memory.c                              | 55 ++++++++++++++++++-
>>  3 files changed, 82 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index bcdee8984e1f0..5c79b58c108ec 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6631,6 +6631,14 @@
>>                         <deci-seconds>: poll all this frequency
>>                         0: no polling (default)
>>
>> +       thp_anon=       [KNL]
>> +                       Format: <size>[KMG]:always|madvise|never|inherit
>> +                       Can be used to control the default behavior of the
>> +                       system with respect to anonymous transparent hugepages.
>> +                       Can be used multiple times for multiple anon THP sizes.
>> +                       See Documentation/admin-guide/mm/transhuge.rst for more
>> +                       details.
>> +
>>         threadirqs      [KNL,EARLY]
>>                         Force threading of all interrupt handlers except those
>>                         marked explicitly IRQF_NO_THREAD.
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 24eec1c03ad88..f63b0717366c6 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would block the collapse::
>>
>>  A higher value may increase memory footprint for some workloads.
>>
>> -Boot parameter
>> -==============
>> +Boot parameters
>> +===============
>>
>> -You can change the sysfs boot time defaults of Transparent Hugepage
>> -Support by passing the parameter ``transparent_hugepage=always`` or
>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>> -to the kernel command line.
>> +You can change the sysfs boot time default for the top-level "enabled"
>> +control by passing the parameter ``transparent_hugepage=always`` or
>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>> +kernel command line.
>> +
>> +Alternatively, each supported anonymous THP size can be controlled by
>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>> +``inherit``.
>> +
>> +For example, the following will set 64K THP to ``always``::
>> +
>> +       thp_anon=64K:always
>> +
>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>> +not explicitly configured on the command line are implicitly set to
>> +``never``.
>>
>>  Hugepages in tmpfs/shmem
>>  ========================
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0c3075ee00012..c2c0da1eb94e6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
>>  unsigned long huge_anon_orders_always __read_mostly;
>>  unsigned long huge_anon_orders_madvise __read_mostly;
>>  unsigned long huge_anon_orders_inherit __read_mostly;
>> +static bool anon_orders_configured;
>>
>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>                                          unsigned long vm_flags,
>> @@ -672,7 +673,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>>          * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>>          * constant so we have to do this here.
>>          */
>> -       huge_anon_orders_inherit = BIT(PMD_ORDER);
>> +       if (!anon_orders_configured) {
>> +               huge_anon_orders_inherit = BIT(PMD_ORDER);
>> +               anon_orders_configured = true;
>> +       }
> 
> If a user configures 64KB and doesn't adjust anything for PMD_ORDER,
> then PMD_ORDER will  be set to "never", correct? This seems to change
> the default behavior of PMD_ORDER. Could we instead achieve this by
> checking if PMD_ORDER has been explicitly configured?

Yes, that's how it's implemented in this patch, and the accompanying docs also
state:

  If ``thp_anon=`` is specified at least once, any anon THP sizes
  not explicitly configured on the command line are implicitly set to
  ``never``.

My initial approach did exactly as you suggest. But in the original series, I
also had a similar patch to configure file thp with "thp_file=". And for file,
all of the orders default to `always`. So if taking the same approach with that
control, the user would have to explicitly opt-out of all supported orders
rather than just opt-in to the orders they want. And I thought that could get
tricky in future if support is added for more orders. I felt that was
potentially very confusing so decided it was clearer to have the above rule and
make both controls consistent.

What do you think?


> 
>>
>>         *hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>>         if (unlikely(!*hugepage_kobj)) {
>> @@ -857,6 +861,55 @@ static int __init setup_transparent_hugepage(char *str)
>>  }
>>  __setup("transparent_hugepage=", setup_transparent_hugepage);
>>
>> +static int __init setup_thp_anon(char *str)
>> +{
>> +       unsigned long size;
>> +       char *state;
>> +       int order;
>> +       int ret = 0;
>> +
>> +       if (!str)
>> +               goto out;
>> +
>> +       size = (unsigned long)memparse(str, &state);
>> +       order = ilog2(size >> PAGE_SHIFT);
>> +       if (*state != ':' || !is_power_of_2(size) || size <= PAGE_SIZE ||
>> +           !(BIT(order) & THP_ORDERS_ALL_ANON))
>> +               goto out;
>> +
>> +       state++;
>> +
>> +       if (!strcmp(state, "always")) {
>> +               clear_bit(order, &huge_anon_orders_inherit);
>> +               clear_bit(order, &huge_anon_orders_madvise);
>> +               set_bit(order, &huge_anon_orders_always);
>> +               ret = 1;
>> +       } else if (!strcmp(state, "inherit")) {
>> +               clear_bit(order, &huge_anon_orders_always);
>> +               clear_bit(order, &huge_anon_orders_madvise);
>> +               set_bit(order, &huge_anon_orders_inherit);
>> +               ret = 1;
>> +       } else if (!strcmp(state, "madvise")) {
>> +               clear_bit(order, &huge_anon_orders_always);
>> +               clear_bit(order, &huge_anon_orders_inherit);
>> +               set_bit(order, &huge_anon_orders_madvise);
>> +               ret = 1;
>> +       } else if (!strcmp(state, "never")) {
>> +               clear_bit(order, &huge_anon_orders_always);
>> +               clear_bit(order, &huge_anon_orders_inherit);
>> +               clear_bit(order, &huge_anon_orders_madvise);
>> +               ret = 1;
>> +       }
>> +
>> +       if (ret)
>> +               anon_orders_configured = true;
> 
> I mean:
> 
> if (ret && order == PMD_ORDER)
>             anon_pmd_order_configured = true;
> 
>> +out:
>> +       if (!ret)
>> +               pr_warn("thp_anon=%s: cannot parse, ignored\n", str);
>> +       return ret;
>> +}
>> +__setup("thp_anon=", setup_thp_anon);
>> +
>>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>>  {
>>         if (likely(vma->vm_flags & VM_WRITE))
>> --
>> 2.43.0
>>
> 
> Thanks
> Barry


