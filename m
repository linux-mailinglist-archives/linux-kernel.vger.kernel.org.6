Return-Path: <linux-kernel+bounces-377591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007D9AC0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE234281263
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41E156641;
	Wed, 23 Oct 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pWR9Sj+w"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9A1448DF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670674; cv=none; b=DjrTnyZOtrL1SJbl2yYosH0x8L2X8dfkuniGOid0CsYOWx1+6IRbWV80zKxx2S12PXbu1tiMMriO6lTKGPrH3xyxy6xX/f9qJ0huVev3GsJMUgTHcd/KxgoGfESbbDegyB58bfC2WuZTCvkY/6Wyq86rjs2ja3P+f01jP2NHNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670674; c=relaxed/simple;
	bh=BC9dLwoLvpUyPy0c7vauvssKc7vureSQdSwUr0P1MHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDZ04qdTn5ZuX8Zvon55Weudy25uTapw4ag/HHGVdRRI9Q2D6e55/jz8b9e6sSdiVlzN1RXL5FKmYRtxVeVwdk+iLm8/sZc7UWKnw9MWdbqb7Lx2IhTCEoWpJ9BVfNdQjpeh4UidifOYbfYI/GW8NOgp9iAZCvf8oWCxYjyAwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pWR9Sj+w; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729670663; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K9VJ2p+XZ+PUBAleTJhU7TSC+VfHlht8O6qDk/d3Mew=;
	b=pWR9Sj+wLC2817fwcNFOEyPXB32ucl/OXCTS4KxpQCfMPBL8WSHMkQK+mApoEQOKoR0pGdqGmlNYtWiHoKSXvpZdeWlxTWFEYaiMWjGAHEkmpud+Z+zU3l76Ta4xlxvefFXvT/azSFx4d3sHyYN0VoObP+LSHZ7Lm7to5hh5sHc=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHkczZg_1729670661 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Oct 2024 16:04:21 +0800
Message-ID: <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
Date: Wed, 23 Oct 2024 16:04:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: David Hildenbrand <david@redhat.com>, Daniel Gomez
 <da.gomez@samsung.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/22 23:31, David Hildenbrand wrote:
> On 22.10.24 05:41, Baolin Wang wrote:
>>
>>
>> On 2024/10/21 21:34, Daniel Gomez wrote:
>>> On Mon Oct 21, 2024 at 10:54 AM CEST, Kirill A. Shutemov wrote:
>>>> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
>>>>>> On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
>>>>>>> + Kirill
>>>>>>>
>>>>>>> On 2024/10/16 22:06, Matthew Wilcox wrote:
>>>>>>>> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
>>>>>>>>> Considering that tmpfs already has the 'huge=' option to 
>>>>>>>>> control the THP
>>>>>>>>> allocation, it is necessary to maintain compatibility with the 
>>>>>>>>> 'huge='
>>>>>>>>> option, as well as considering the 'deny' and 'force' option 
>>>>>>>>> controlled
>>>>>>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>>>
>>>>>>>> No, it's not.  No other filesystem honours these settings.  
>>>>>>>> tmpfs would
>>>>>>>> not have had these settings if it were written today.  It should 
>>>>>>>> simply
>>>>>>>> ignore them, the way that NFS ignores the "intr" mount option 
>>>>>>>> now that
>>>>>>>> we have a better solution to the original problem.
>>>>>>>>
>>>>>>>> To reiterate my position:
>>>>>>>>
>>>>>>>>      - When using tmpfs as a filesystem, it should behave like 
>>>>>>>> other
>>>>>>>>        filesystems.
>>>>>>>>      - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, 
>>>>>>>> it should
>>>>>>>>        behave like anonymous memory.
>>>>>>>
>>>>>>> I do agree with your point to some extent, but the ‘huge=’ option 
>>>>>>> has
>>>>>>> existed for nearly 8 years, and the huge orders based on write 
>>>>>>> size may not
>>>>>>> achieve the performance of PMD-sized THP in some scenarios, such 
>>>>>>> as when the
>>>>>>> write length is consistently 4K. So, I am still concerned that 
>>>>>>> ignoring the
>>>>>>> 'huge' option could lead to compatibility issues.
>>>>>>
>>>>>> Yeah, I don't think we are there yet to ignore the mount option.
>>>>>
>>>>> OK.
>>>>>
>>>>>> Maybe we need to get a new generic interface to request the semantics
>>>>>> tmpfs has with huge= on per-inode level on any fs. Like a set of 
>>>>>> FADV_*
>>>>>> handles to make kernel allocate PMD-size folio on any allocation 
>>>>>> or on
>>>>>> allocations within i_size. I think this behaviour is useful beyond 
>>>>>> tmpfs.
>>>>>>
>>>>>> Then huge= implementation for tmpfs can be re-defined to set these
>>>>>> per-inode FADV_ flags by default. This way we can keep tmpfs 
>>>>>> compatible
>>>>>> with current deployments and less special comparing to rest of
>>>>>> filesystems on kernel side.
>>>>>
>>>>> I did a quick search, and I didn't find any other fs that require 
>>>>> PMD-sized
>>>>> huge pages, so I am not sure if FADV_* is useful for filesystems 
>>>>> other than
>>>>> tmpfs. Please correct me if I missed something.
>>>>
>>>> What do you mean by "require"? THPs are always opportunistic.
>>>>
>>>> IIUC, we don't have a way to hint kernel to use huge pages for a 
>>>> file on
>>>> read from backing storage. Readahead is not always the right way.
>>>>
>>>>>> If huge= is not set, tmpfs would behave the same way as the rest of
>>>>>> filesystems.
>>>>>
>>>>> So if 'huge=' is not set, tmpfs write()/fallocate() can still 
>>>>> allocate large
>>>>> folios based on the write size? If yes, that means it will change the
>>>>> default huge behavior for tmpfs. Because previously having 'huge=' 
>>>>> is not
>>>>> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar 
>>>>> to what I
>>>>> mentioned:
>>>>> "Another possible choice is to make the huge pages allocation based 
>>>>> on write
>>>>> size as the *default* behavior for tmpfs, ..."
>>>>
>>>> I am more worried about breaking existing users of huge pages. So 
>>>> changing
>>>> behaviour of users who don't specify huge is okay to me.
>>>
>>> I think moving tmpfs to allocate large folios opportunistically by
>>> default (as it was proposed initially) doesn't necessary conflict with
>>> the default behaviour (huge=never). We just need to clarify that in
>>> the documentation.
>>>
>>> However, and IIRC, one of the requests from Hugh was to have a way to
>>> disable large folios which is something other FS do not have control
>>> of as of today. Ryan sent a proposal to actually control that globally
>>> but I think it didn't move forward. So, what are we missing to go back
>>> to implement large folios in tmpfs in the default case, as any other fs
>>> leveraging large folios?
>>
>> IMHO, as I discussed with Kirill, we still need maintain compatibility
>> with the 'huge=' mount option. This means that if 'huge=never' is set
>> for tmpfs, huge page allocation will still be prohibited (which can
>> address Hugh's request?). However, if 'huge=' is not set, we can
>> allocate large folios based on the write size.
> 
> I consider allocating large folios in shmem/tmpfs on the write path less 
> controversial than allocating them on the page fault path -- especially 
> as long as we stay within the size to-be-written.
> 
> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g., 
> shmem_enabled=never). Maybe because of some rather undesired 
> side-effects (maybe some are historical?): I recall issues with VMs with 
> THP+ memory ballooning, as we cannot reclaim pages of folios if 
> splitting fails). I assume most of these problematic use cases don't use 
> tmpfs as an ordinary file system (write()/read()), but mmap() the whole 
> thing.
> 
> Sadly, I don't find any information about shmem/tmpfs + THP in the RHEL 
> documentation; most documentation is only concerned about anon THP. 
> Which makes me conclude that they are not suggested as of now.
> 
> I see more issues with allocating them on the page fault path and not 
> having a way to disable it -- compared to allocating them on the write() 
> path.

I may not understand your issues. IIUC, you can disable allocating huge 
pages on the page fault path by using the 'huge=never' mount option or 
setting shmem_enabled=deny. No?

