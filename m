Return-Path: <linux-kernel+bounces-242147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A81928441
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26051F2290C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C8145FED;
	Fri,  5 Jul 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HROtLVqi"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F613B5A9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169887; cv=none; b=uSI/sFU2pZO3tEZE8q2WtpTzPawi3Sz8pcj5SxQtvufW6zR/SGhLEocV3mJ46+sr1odb2I1W3NCv5OP25qm8d3LKqwBjwpdwuJLUVh7ocO9M867REJN93838lxHwisn/VM6rBZI4emM6CcdH64i6ckTR5wlSHAKj5K9N/dyveDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169887; c=relaxed/simple;
	bh=hvG0GCOWi4THCguOysp1g8/zVPa9vVrWs5MMxbroZr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUm8+yE6AHABvnrt/dqbHpx0wL2ohtZ/B2iKwQNp5xi281ePuIzQNusVAhDKPxY9aGHVDCL7QpdV3k3MMJXcpAFX48Mx31lGHqxCT/qRQ3+GUItcKgLy3cywruQd4LsUyJ0y+Zai1aIsuplBYgrzf/t8NJIowmwJFDrvD9TvoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HROtLVqi; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720169882; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/b2CH/0osx3Zqy3K9+ynEPiLNGlIv+mnOfWfcW761j4=;
	b=HROtLVqiFcztkybnJQzBQhgU8h0QYOx8V5M6m9TDB8qFhrHFolKOjaqP4ZxgEo+xkCqQwSqL24lUzL0jY4zUHgso7T02dkgOBymdL5rnKg9Eqeq8UklZeGfYFZdbozYcSFOM9To4wiHRfllA4oM5InNRGl/W+Trf5/QC2ckVVec=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W9uQFI._1720169879;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9uQFI._1720169879)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 16:58:00 +0800
Message-ID: <545e23ab-e40a-4f13-8167-c9aa85a34b19@linux.alibaba.com>
Date: Fri, 5 Jul 2024 16:57:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>, Bang Li <libang.linux@gmail.com>,
 akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
 <a3910f60-6e2e-4ede-b3f3-47d8dfe9f23b@gmail.com>
 <076550c4-0e8a-4344-9f8a-31ae9e1051b5@linux.alibaba.com>
 <96625631-ef7d-44a2-ad5f-f7beb64f0ed0@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <96625631-ef7d-44a2-ad5f-f7beb64f0ed0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/5 16:42, Ryan Roberts wrote:
> On 05/07/2024 04:01, Baolin Wang wrote:
>>
>>
>> On 2024/7/4 22:46, Bang Li wrote:
>>> Hi Bao lin,
>>>
>>> On 2024/7/4 19:15, Baolin Wang wrote:
>>>>
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Only allow inherit orders if the top-level value is 'force', which
>>>>>> +     * means non-PMD sized THP can not override 'huge' mount option now.
>>>>>> +     */
>>>>>> +    if (shmem_huge == SHMEM_HUGE_FORCE)
>>>>>> +        return READ_ONCE(huge_shmem_orders_inherit);
>>>>>
>>>>> I vaguely recall that we originally discussed that trying to set 'force' on the
>>>>> top level control while any per-size controls were set to 'inherit' would be an
>>>>> error, and trying to set 'force' on any per-size control except the PMD-size
>>>>> would be an error?
>>>>
>>>> Right.
>>>>
>>>>> I don't really understand this logic. Shouldn't we just be looking at the
>>>>> per-size control settings (or the top-level control as a proxy for every
>>>>> per-size control that has 'inherit' set)?
>>>>
>>>> ‘force’ will apply the huge orders for anon shmem and tmpfs, so now we only
>>>> allow pmd-mapped THP to be forced. We should not look at per-size control
>>>> settings for tmpfs now (mTHP for tmpfs will be discussed in future).
>>>>
>>>>>
>>>>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just always use the
>>>>> PMD-size control for decisions.
>>>>>
>>>>> I'm also really struggling with the concept of shmem_is_huge() existing along
>>>>> side shmem_allowable_huge_orders(). Surely this needs to all be refactored into
>>>>> shmem_allowable_huge_orders()?
>>>>
>>>> I understood. But now they serve different purposes: shmem_is_huge() will be
>>>> used to check the huge orders for the top level, for *tmpfs* and anon shmem;
>>>> whereas shmem_allowable_huge_orders() will only be used to check the per-size
>>>> huge orders for anon shmem (excluding tmpfs now). However, as I plan to add
>>>> mTHP support for tmpfs, I think we can perform some cleanups.
>>>
>>> Please count me in, I'd be happy to contribute to the cleanup and enhancement
>>> process if I can.
>>
>> Good. If you have time, I think you can look at the shmem khugepaged issue from
>> the previous discussion [1], which I don't have time to look at now.
>>
>> "
>> (3) khugepaged
>>
>> khugepaged needs to handle larger folios properly as well. Until fixed,
>> using smaller THP sizes as fallback might prohibit collapsing a
>> PMD-sized THP later. But really, khugepaged needs to be fixed to handle
>> that.
>> "
> 
> khugepaged can already collapse "folios of any order less then PMD-size" to
> PMD-size, for anon memory. Infact I modified the selftest to be able to test
> that in commit 9f0704eae8a4 ("selftests/mm/khugepaged: enlighten for multi-size
> THP"). I'd be surprised if khugepaged can't alreay handle the same for shmem?

I did not test this, but from the comment in hpage_collapse_scan_file(), 
seems that compacting small mTHP into a single PMD-mapped THP is not 
supported yet.

/*
		 * TODO: khugepaged should compact smaller compound pages
		 * into a PMD sized page
		 */
		if (folio_test_large(folio)) {
			result = folio_order(folio) == HPAGE_PMD_ORDER &&
					folio->index == start
					/* Maybe PMD-mapped */
					? SCAN_PTE_MAPPED_HUGEPAGE
					: SCAN_PAGE_COMPOUND;
			/*
			 * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
			 * by the caller won't touch the page cache, and so
			 * it's safe to skip LRU and refcount checks before
			 * returning.
			 */
			break;
		}

> Although the test will definitely want to be extended to test it.

Right.

