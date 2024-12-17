Return-Path: <linux-kernel+bounces-448454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD39F404C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1952188D585
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CF42AA1;
	Tue, 17 Dec 2024 02:02:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06BE545
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400953; cv=none; b=ahAkYeZXZW5x0Cg/KHdfMTLxy+nk5MX10UCsw7fmNBdSfbiaZsDHs8Wmy8NeWwPrFcLo7oFBq1iFarYQ7VCmE3TCpWVx1e912trkC9WZ/qChz1Ryn4iWptbczAx5DsNCqv3nCdCeC6QLHCvIJC4wt8wRme736gkrsCwwVjRQsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400953; c=relaxed/simple;
	bh=YuBaVC+avyjKXDjlXOxUD+YSASxV0SWmsaunAeiyvcg=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J53aTUyMeJ4WIYfFKekgsP7cw8t3wWOOBRywF51XVAd/lQNSnLp9rHWD0i4vZIFxI9zeQuWEmHnD59vw3REk8qUleSFHVeugCXVXSjRpm/HKlrLaO9W7gmEpMaSIF8OVkVDDbwYNNUTu6VtrBf5I2Bxwni0OMu3KC12kRHgCwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YC0PP6fd4z2Dj6Y;
	Tue, 17 Dec 2024 09:59:53 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id DD81A1400DD;
	Tue, 17 Dec 2024 10:02:26 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 kwepemg200013.china.huawei.com (7.202.181.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Dec 2024 10:02:26 +0800
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Kenneth W
 Chen <kenneth.w.chen@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Nanyong Sun <sunnanyong@huawei.com>
References: <20241214104401.1052550-1-liushixin2@huawei.com>
 <8e59d2bd-77d3-41bc-83b7-532b018db4e2@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <00edd087-8df6-343a-95bf-ca23381085a8@huawei.com>
Date: Tue, 17 Dec 2024 10:02:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e59d2bd-77d3-41bc-83b7-532b018db4e2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200013.china.huawei.com (7.202.181.64)



On 2024/12/16 23:34, David Hildenbrand wrote:
> On 14.12.24 11:44, Liu Shixin wrote:
>> The folio refcount may be increased unexpectly through try_get_folio() by
>> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
>> check whether a pmd page table is shared. The check is incorrect if the
>> refcount is increased by the above caller, and this can cause the page
>> table leaked:
>
> Are you sure it is "leaked" ?
>
> I assume what happens is that we end up freeing a page table without calling its constructor. That's why page freeing code complains about "nonzero mapcount" (overlayed by something else).

1. The page table itself will be discarded after reporting the "nonzero mapcount".

2. The HugeTLB page mapped by the page table miss freeing since we treat the page table as shared
    and a shared page table will not be to unmap.

>
> > >   BUG: Bad page state in process sh  pfn:109324
>>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
>>   flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
>>   page_type: f2(table)
>>   raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
>>   raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
>>   page dumped because: nonzero mapcount
>>   ...
>>   CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
>>   Tainted: [B]=BAD_PAGE
>>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>   Call trace:
>>    show_stack+0x20/0x38 (C)
>>    dump_stack_lvl+0x80/0xf8
>>    dump_stack+0x18/0x28
>>    bad_page+0x8c/0x130
>>    free_page_is_bad_report+0xa4/0xb0
>>    free_unref_page+0x3cc/0x620
>>    __folio_put+0xf4/0x158
>>    split_huge_pages_all+0x1e0/0x3e8
>>    split_huge_pages_write+0x25c/0x2d8
>>    full_proxy_write+0x64/0xd8
>>    vfs_write+0xcc/0x280
>>    ksys_write+0x70/0x110
>>    __arm64_sys_write+0x24/0x38
>>    invoke_syscall+0x50/0x120
>>    el0_svc_common.constprop.0+0xc8/0xf0
>>    do_el0_svc+0x24/0x38
>>    el0_svc+0x34/0x128
>>    el0t_64_sync_handler+0xc8/0xd0
>>    el0t_64_sync+0x190/0x198
>>
>> The issue may be triggered by damon, offline_page, page_idle etc. which
>> will increase the refcount of page table.
>
> Right, many do have a racy folio_test_lru() check in there, that prevents "most of the harm", but not all of them.
Yes, this makes the problems nearly impossible to happen for some function, but not really safe.

thanks,
>
>


