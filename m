Return-Path: <linux-kernel+bounces-342768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3811A9892CD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA3B2821AF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD58BE7;
	Sun, 29 Sep 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jB9uNQSv"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490420ED
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578832; cv=none; b=YkFMi7Wzkz387AQvcMLKFP27/fmP3KvvOl9/hOErmIcjyRCConMfz31eFalKs8cZ0zwO2aMdiRnB5Uf7kGfZaVt4NpiIPyf7DNsXfPw9LaWkRV/PYwYzIB2YukU137BtI/FSlpogWtSE064uBLSSbES7PKnrlHPJaQEe+IRSyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578832; c=relaxed/simple;
	bh=DQ+z8ada+GNaj1xnNNuernLATDKO5IGMqhvZCWEMRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEShsYE5gxq+vc3cMVwXSjro7PNC2e7nkpbPdYbTRR4t46m19fje2LJtSj+T1peyCtcNdrlL0+HAQ1rhOhcEAUBG03fM7FnRWI3vzkxdp4zbHkzOf7ZwELlYupZqSE97s+T2KQ1twsyAQRqeKKFNYT60HaXvMmkAkZqhr0te/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jB9uNQSv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727578819; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rEivD6GU1wyVEwRx14F5mTY19RoTHSY7OwXHFHHtPYc=;
	b=jB9uNQSvneouuN9q0wYiXzGOp9TRF/KVvMnOvH7ThdaAGWtmO0os92xj2pnf01Tr5aXdN9sQLP7m8IADqoWRR/nECyRT4ZyZaU8QAk4H6ii7wAMkAGC9+iU+M1uAM7hmxjCVqdsNE7I2hxwjLjo1YrET4i52cQIZakr+C/4PCvw=
Received: from 30.171.214.186(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0WFuk-FD_1727578818)
          by smtp.aliyun-inc.com;
          Sun, 29 Sep 2024 11:00:19 +0800
Message-ID: <0e574409-cf12-47fd-b107-664e7f1b9cb6@linux.alibaba.com>
Date: Sun, 29 Sep 2024 11:00:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] device-dax: Correct pgoff align in dax_set_mapping()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <23c02a03e8d666fef11bbe13e85c69c8b4ca0624.1727421694.git.llfl@linux.alibaba.com>
 <20240927104646.3a0b777b5114ec62becd7f47@linux-foundation.org>
Content-Language: en-US
From: "Kun(llfl)" <llfl@linux.alibaba.com>
In-Reply-To: <20240927104646.3a0b777b5114ec62becd7f47@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That's a subtle situation that only can be observed in 
page_mapped_in_vma() after the page is page fault handled by 
dev_dax_huge_fault. Generally, there is little chance to perform 
page_mapped_in_vma in dev-dax's page unless in specific error injection 
to the dax device to trigger an MCE - memory-failure. In that case, 
page_mapped_in_vma() will be triggered to determine which task is 
accessing the failure address and kill that task in the end.


We used self-developed dax device (which is 2M aligned mapping) , to 
perform error injection to random address. It turned out that error 
injected to non-2M-aligned address was causing endless MCE until panic. 
Because page_mapped_in_vma() kept resulting wrong address and the task 
accessing the failure address was never killed properly:


[ 3783.719419] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3784.049006] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3784.049190] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3784.448042] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3784.448186] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3784.792026] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3784.792179] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3785.162502] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3785.162633] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3785.461116] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3785.461247] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3785.764730] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3785.764859] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3786.042128] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3786.042259] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3786.464293] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3786.464423] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3786.818090] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3786.818217] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered
[ 3787.085297] mce: Uncorrected hardware memory error in user-access at 
200c9742380
[ 3787.085424] Memory failure: 0x200c9742: recovery action for dax page: 
Recovered

It took us several weeks to pinpoint this problem,  but we eventually 
used bpftrace to trace the page fault and mce address and successfully 
identified the issue.

On 9/28/24 1:46 AM, Andrew Morton wrote:
> (cc's added)
>
> On Fri, 27 Sep 2024 15:45:09 +0800 "Kun(llfl)" <llfl@linux.alibaba.com> wrote:
>
>> pgoff should be aligned using ALIGN_DOWN() instead of ALIGN(). Otherwise,
>> vmf->address not aligned to fault_size will be aligned to the next
>> alignment, that can result in memory failure getting the wrong address.
>>
>> Fixes: b9b5777f09be ("device-dax: use ALIGN() for determining pgoff")
> That's quite an old change.  Can you suggest why it took this long to
> be discovered?  What is your userspace doing to trigger this?
>
>> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
>> Tested-by: JianXiong Zhao <zhaojianxiong.zjx@alibaba-inc.com>
>> ---
>>   drivers/dax/device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>> index 9c1a729cd77e..6d74e62bbee0 100644
>> --- a/drivers/dax/device.c
>> +++ b/drivers/dax/device.c
>> @@ -86,7 +86,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
>>   		nr_pages = 1;
>>   
>>   	pgoff = linear_page_index(vmf->vma,
>> -			ALIGN(vmf->address, fault_size));
>> +			ALIGN_DOWN(vmf->address, fault_size));
>>   
>>   	for (i = 0; i < nr_pages; i++) {
>>   		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
>> -- 
>> 2.43.0

-- 
Best,
KUN


