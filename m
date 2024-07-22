Return-Path: <linux-kernel+bounces-259043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A793905D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC121F2183F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01416D9D0;
	Mon, 22 Jul 2024 14:10:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43748F5E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657432; cv=none; b=qt95gW/fNYt00LT905/N6iU6fwEMnDQHo5L9dbK8Zfjbrkv1jHLkSLFDKcE5XAFVTQbwVzgPgb4G4P0ufDszRtw6T9x4T/zJv7TmgjUvwS+zVGHBWvcLI/yL8E5KSiQ48ES7DXos85wQJVcfYgzFyye2kvjWmt1TIvTioPj8R8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657432; c=relaxed/simple;
	bh=K/6Qwa6EzamjPG++1waTjTeBj8ru+goP6Ae6K0UhmoI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hq9UD8pLWy2ndvi2ZYfL5hebUYlnNgWDAKXvGJuVaPeNP3ogYi/pgqddwTBnlZllJZQz1+S7bG9I44lxYR0qGkWvQ3Uz2owJTN7AxX9SC4S+W05T8S9ilKBZrVGPfI8q7RigsAYSO/GwbKGXiHjlyr3QXX9US1QMammddM5QwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75867FEC;
	Mon, 22 Jul 2024 07:10:54 -0700 (PDT)
Received: from [10.1.27.165] (XHFQ2J9959.cambridge.arm.com [10.1.27.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7790A3F73F;
	Mon, 22 Jul 2024 07:10:27 -0700 (PDT)
Message-ID: <3a499df9-f1ef-4552-b460-8585bf8bca92@arm.com>
Date: Mon, 22 Jul 2024 15:10:26 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <CGME20240717071315eucas1p199a8b4a7134ecf38255a721432e1b65b@eucas1p1.samsung.com>
 <20240717071257.4141363-4-ryan.roberts@arm.com>
 <axqj32jqs3ehzpz4vewtfbgcl2sg4lkntfm4prrqcd3evt7klr@qlurbuivkgbe>
 <d46fea2f-fbb1-41f7-8d29-9c25984278cf@arm.com>
In-Reply-To: <d46fea2f-fbb1-41f7-8d29-9c25984278cf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 10:36, Ryan Roberts wrote:
> On 22/07/2024 10:13, Daniel Gomez wrote:
>> On Wed, Jul 17, 2024 at 08:12:55AM GMT, Ryan Roberts wrote:
>>> Add thp_anon= cmdline parameter to allow specifying the default
>>> enablement of each supported anon THP size. The parameter accepts the
>>> following format and can be provided multiple times to configure each
>>> size:
>>>
>>> thp_anon=<size>[KMG]:<value>
>>
>> Minor suggestion. Should this be renamed to hp_anon= or hugepages_anon= instead?
>> This would align with the values under /sys/kernel/mm/transparent_hugepage/
>> hugepages-*kB.
> 
> "hp" doesn't feel right; that's not an abreviation we use today to my knowledge.
> But I'd be happy to change it to "hugepages_anon", if that's the concensus.

Thinking about this a bit more, "hugepages=" is already a cmdline parameter used
to reserve hugepages for use with HugeTLB. So I think that could get confusing.

transparent_hugepage= is the existing cmdline parameter for the top-level (anon)
control. I considered "transparent_hugepage_anon=" or even just extending to use
the same parameter for both the top level and the per-size controls (with
optional size):

  transparent_hugepage=[<size>[KMG]:]<value>

But given they likely need to be provided multiple times, both of those options
seem too long. Which is how I settled on thp_anon= (and in the next patch,
thp_file=).

> 
>>
>>>
>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
>>>
>>> Configuring the defaults at boot time is useful to allow early user
>>> space to take advantage of mTHP before its been configured through
>>> sysfs.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  .../admin-guide/kernel-parameters.txt         |  8 +++
>>>  Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>>>  mm/huge_memory.c                              | 55 ++++++++++++++++++-
>>>  3 files changed, 82 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index bc55fb55cd26..48443ad12e3f 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -6592,6 +6592,14 @@
>>>  			<deci-seconds>: poll all this frequency
>>>  			0: no polling (default)
>>>  
>>> +	thp_anon=	[KNL]
>>> +			Format: <size>[KMG]:always|madvise|never|inherit
>>> +			Can be used to control the default behavior of the
>>> +			system with respect to anonymous transparent hugepages.
>>> +			Can be used multiple times for multiple anon THP sizes.
>>> +			See Documentation/admin-guide/mm/transhuge.rst for more
>>> +			details.
>>> +
>>>  	threadirqs	[KNL,EARLY]
>>>  			Force threading of all interrupt handlers except those
>>>  			marked explicitly IRQF_NO_THREAD.
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>> index 1aaf8e3a0b5a..f53d43d986e2 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -311,13 +311,27 @@ performance.
>>>  Note that any changes to the allowed set of sizes only applies to future
>>>  file-backed THP allocations.
>>>  
>>> -Boot parameter
>>> -==============
>>> +Boot parameters
>>> +===============
>>>  
>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>> -to the kernel command line.
>>> +You can change the sysfs boot time default for the top-level "enabled"
>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>> +kernel command line.
>>> +
>>> +Alternatively, each supported anonymous THP size can be controlled by
>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>> +``inherit``.
>>> +
>>> +For example, the following will set 64K THP to ``always``::
>>> +
>>> +	thp_anon=64K:always
>>> +
>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>> +not explicitly configured on the command line are implicitly set to
>>> +``never``.
>>>  
>>>  Hugepages in tmpfs/shmem
>>>  ========================
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 4249c0bc9388..794d2790d90d 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -82,6 +82,7 @@ unsigned long huge_anon_orders_madvise __read_mostly;
>>>  unsigned long huge_anon_orders_inherit __read_mostly;
>>>  unsigned long huge_file_orders_always __read_mostly;
>>>  int huge_file_exec_order __read_mostly = -1;
>>> +static bool anon_orders_configured;
>>>  
>>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>  					 unsigned long vm_flags,
>>> @@ -763,7 +764,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>>>  	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>>>  	 * constant so we have to do this here.
>>>  	 */
>>> -	huge_anon_orders_inherit = BIT(PMD_ORDER);
>>> +	if (!anon_orders_configured) {
>>> +		huge_anon_orders_inherit = BIT(PMD_ORDER);
>>
>> PMD_ORDER for 64k base PS systems would result in a 512M value, which exceeds
>> the xarray limit [1]. Therefore, I think we need to avoid PMD-size orders by
>> checking if PMD_ORDER > MAX_PAGECACHE_ORDER.
> 
> This is for anon memory, which isn't installed in the page cache so its
> independent of MAX_PAGECACHE_ORDER. I don't believe there is a problem here.
> 
>>
>> [1] https://lore.kernel.org/all/20240627003953.1262512-1-gshan@redhat.com/
>>
>>> +		anon_orders_configured = true;
>>> +	}
>>>  
>>>  	/*
>>>  	 * For pagecache, default to enabling all orders. powerpc's PMD_ORDER
>>> @@ -955,6 +959,55 @@ static int __init setup_transparent_hugepage(char *str)
>>>  }
>>>  __setup("transparent_hugepage=", setup_transparent_hugepage);
>>>  
>>> +static int __init setup_thp_anon(char *str)
>>> +{
>>> +	unsigned long size;
>>> +	char *state;
>>> +	int order;
>>> +	int ret = 0;
>>> +
>>> +	if (!str)
>>> +		goto out;
>>> +
>>> +	size = (unsigned long)memparse(str, &state);
>>> +	order = ilog2(size >> PAGE_SHIFT);
>>> +	if (*state != ':' || !is_power_of_2(size) || size <= PAGE_SIZE ||
>>> +	    !(BIT(order) & THP_ORDERS_ALL_ANON))
>>> +		goto out;
>>> +
>>> +	state++;
>>> +
>>> +	if (!strcmp(state, "always")) {
>>> +		clear_bit(order, &huge_anon_orders_inherit);
>>> +		clear_bit(order, &huge_anon_orders_madvise);
>>> +		set_bit(order, &huge_anon_orders_always);
>>> +		ret = 1;
>>> +	} else if (!strcmp(state, "inherit")) {
>>> +		clear_bit(order, &huge_anon_orders_always);
>>> +		clear_bit(order, &huge_anon_orders_madvise);
>>> +		set_bit(order, &huge_anon_orders_inherit);
>>> +		ret = 1;
>>> +	} else if (!strcmp(state, "madvise")) {
>>> +		clear_bit(order, &huge_anon_orders_always);
>>> +		clear_bit(order, &huge_anon_orders_inherit);
>>> +		set_bit(order, &huge_anon_orders_madvise);
>>> +		ret = 1;
>>> +	} else if (!strcmp(state, "never")) {
>>> +		clear_bit(order, &huge_anon_orders_always);
>>> +		clear_bit(order, &huge_anon_orders_inherit);
>>> +		clear_bit(order, &huge_anon_orders_madvise);
>>> +		ret = 1;
>>> +	}
>>> +
>>> +	if (ret)
>>> +		anon_orders_configured = true;
>>> +out:
>>> +	if (!ret)
>>> +		pr_warn("thp_anon=%s: cannot parse, ignored\n", str);
>>> +	return ret;
>>> +}
>>> +__setup("thp_anon=", setup_thp_anon);
>>> +
>>>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>>>  {
>>>  	if (likely(vma->vm_flags & VM_WRITE))
>>> -- 
>>> 2.43.0
> 


