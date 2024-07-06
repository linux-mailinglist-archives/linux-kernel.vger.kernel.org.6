Return-Path: <linux-kernel+bounces-243127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE27929228
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6CD1F21CCE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE952487A7;
	Sat,  6 Jul 2024 09:15:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868328F0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720257324; cv=none; b=BUaAIyvFctgZParIr4fHZo1Mo/jCYVNOrtQoK6IIq4U4i41mB4TID/M+d7M+m4kKAeRKBageEVByClqrOteIVsN00u/68yhtmlYQF0deRg600QgrR6TBR6g0MztSsGePnX+58fCrS1dwAckPQ9UXJHhAVTicK+NymVlRV99eUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720257324; c=relaxed/simple;
	bh=RYlzuwMe8V/B7pTv2HlzTGX3NwfCGI/IFNPb8xHwRUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KOR6pvGdIm0OMYMgU9gw/KJ//hzWlTF8Ncao2boo2MomDtnJwBMsZIM+ZNfWaHqZj22BiCyEAChtf+2MR8lj0MTnKKZnJerKfNrJawKmp1QAKCj0+63nba+FEUGifoooQr3ZlRQ3fILYUV0iXpeXrabpQeHRMk8qze4B5Jn2rpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WGPpy624GznZDv;
	Sat,  6 Jul 2024 17:14:50 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 302BD180AA6;
	Sat,  6 Jul 2024 17:15:12 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 6 Jul 2024 17:15:11 +0800
Message-ID: <3ccb25fa-873d-44d5-d7c4-8385a6152508@huawei.com>
Date: Sat, 6 Jul 2024 17:15:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] filemap: replace pte_offset_map() with
 pte_offset_map_nolock()
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <willy@infradead.org>,
	<ying.huang@intel.com>, <fengwei.yin@intel.com>, <david@redhat.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240313012913.2395414-1-zhangpeng362@huawei.com>
 <20240625140643.bf4a1a19b0d534d802764610@linux-foundation.org>
 <20240704114039.4fd0739593cd0a96fe428496@linux-foundation.org>
Content-Language: en-US
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240704114039.4fd0739593cd0a96fe428496@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/7/5 2:40, Andrew Morton wrote:

> On Tue, 25 Jun 2024 14:06:43 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Wed, 13 Mar 2024 09:29:13 +0800 Peng Zhang <zhangpeng362@huawei.com> wrote:
>>
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>
>>> The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
>>> handle_pte_fault(). But at the same time, we did a pte_unmap(vmf->pte).
>>> After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
>>> may be racily changed and vmf->ptl maybe fails to protect the actual
>>> page table.
>>> Fix this by replacing pte_offset_map() with pte_offset_map_nolock().
>>>
>>> ...
>>>
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>>>   	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
>>>   		return 0;
>>>   
>>> -	ptep = pte_offset_map(vmf->pmd, vmf->address);
>>> +	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
>>> +				     &vmf->ptl);
>>>   	if (unlikely(!ptep))
>>>   		return VM_FAULT_NOPAGE;
>>>   
>> whoops, I'm still sitting on this because I didn't know whether we
>> should backport it.
>>
>> And...  guess what I say next.  Can we please describe what are the
>> userspace visible effects of the bug?
>>
> Nobody?
>
> Oh well, I'll add cc:stable amd move this into mm-hotfixes.
>
Sorry for the late reply.

As David said, the PTL pointer might be stale so if we continue to use it infilemap_fault_recheck_pte_none(), it might trigger UAF.
Also, if the PTL fails, the issue fixed by commit 58f327f2ce80 ("filemap: avoid unnecessary major faults in filemap_fault()") might reappear.

-- 
Best Regards,
Peng


