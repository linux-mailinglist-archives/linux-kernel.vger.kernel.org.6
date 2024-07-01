Return-Path: <linux-kernel+bounces-235807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048C891D9EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2B41F21FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B268286F;
	Mon,  1 Jul 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="o7QnGHhJ"
Received: from out187-6.us.a.mail.aliyun.com (out187-6.us.a.mail.aliyun.com [47.90.187.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F782498
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822504; cv=none; b=DTQAy3gc/LBCHCD/KxLMI+AExhzQrkGaac0ojJ8E6P7ZVWrDl6wOSfpoZQUYG/kSfB0f7zWDQUZaTNGVrgazmaNQ9uhqhdTRaI8VW+ZqygfxMdvxnnRN5UOM6iXl2ZzQlbybcLhaKUN5VDetc9hRUy/bchmSXnYoGakItWPyPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822504; c=relaxed/simple;
	bh=LVZaEFFpmjLSLIHc3mWQaQg3P//cgDdA2m4wmoDiXFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmEDni72TCoO58XRcYFTzjiOiC586KA0NaEysrqOhoOE3fDgCXDdnjwqqEQVwqFowxB/1q5XlmhTORo7cxIL+tRQVh6NWT8Yl/ysNFeqTHVjbDadXVK1L/sznyIKa817685jbF7mtQx9Z3SW5kQh/LCgNaKdslxI+AWHIL9HF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=o7QnGHhJ; arc=none smtp.client-ip=47.90.187.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719822490; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vGhjO9uIjc37ou1f7D8tf/WdHUzM0CCNY36XPbaqCkA=;
	b=o7QnGHhJ73rwoGE3GBRfcgfT6wgLbHZ2Y1DS8YLYn2xLWWRQc4pxCDW8SpghUTuL+BAzd8TYAj6/CNdeYD9iXISHE1i6ZKzZnR26m/5TEcEPryRJcAVVUfBEIaNMq4hP2kCZ7JEK9hba3xAMAAxsgRdyaBP9C1/do2iDLcVedaA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068157007;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.YE88zYj_1719822171;
Received: from 30.13.185.168(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YE88zYj_1719822171)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 16:22:51 +0800
Message-ID: <d17c2da6-fa1f-4d89-afef-2be82e7d8d52@antgroup.com>
Date: Mon, 01 Jul 2024 16:22:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <21cnbao@gmail.com>
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <b2e6fac2-7c23-4a92-8d89-ff29b8566967@linux.alibaba.com>
 <2972d75a-ab26-4da7-88fa-81bed955cf52@redhat.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <2972d75a-ab26-4da7-88fa-81bed955cf52@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2024/7/1 14:55, David Hildenbrand wrote:
> On 01.07.24 08:47, Baolin Wang wrote:
>> CC Barry.
>>
>> On 2024/6/28 18:49, Bang Li wrote:
>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>> anonymous shmem"), we can configure different policies through
>>> the multi-size THP sysfs interface for anonymous shmem. But
>>> currently "THPeligible" indicates only whether the mapping is
>>> eligible for allocating THP-pages as well as the THP is PMD
>>> mappable or not for anonymous shmem, we need to support semantics
>>> for mTHP with anonymous shmem similar to those for mTHP with
>>> anonymous memory.
>>
>> I did not see a consensus that "THP*" related statistics should contain
>> mTHP in previous discussion [1].
>>
>> In addition, if we all agree that "THPeligible" should include mTHP
>> statistics, you should update the corresponding documentation to keep
>> consistency.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/202406262300.iAURISyJ-lkp@intel.com/T/#md7a77056110cebcc2a9b3cd7e4a8d682667f6ba5
>>
> 
> Fortunately, documentation (Documentation/filesystems/proc.rst) says:
> 
> "THPeligible" indicates whether the mapping is eligible for allocating 
> naturally aligned THP pages of any currently enabled size. 1 if true, 0 
> otherwise."
> 
> So that documentation is already pretty clear (we just have to make sure 
> the other ones are properly documented, for example as raised in reply 
> to [1]).
> 

Thanks for the clarification.

Thanks,
Bang

