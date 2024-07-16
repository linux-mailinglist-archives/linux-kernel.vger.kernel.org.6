Return-Path: <linux-kernel+bounces-253224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B11931E54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D6B1C22124
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065044A32;
	Tue, 16 Jul 2024 01:12:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F84405
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092360; cv=none; b=GeA/nOKrXXDeNwribEClzTz/cW4kc2aB8Scg/IrYoq3zc7kDUeEhewSMtH1Ag3QovkTsqbGWcyCjIZBGBshpihm+HDvra9lynzGYhVl43Kc2X4f9p1Lm4RsErUh3pD47DBqM9JOvjryGGI2vD+pit8ibNFylRUuJmv/YeceUx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092360; c=relaxed/simple;
	bh=Z+C+4xLkWxur6AEVnE/8wvZSUObIa5jpjlzPkiUa5dY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ohu2ipgHnifPH3IKwG9T4j1d7VGPTQAzNEF6YZlaABX48oM+p4qi2op2GrD5wBsO4sX7zyxao9witKp0aeHp9VgxlTuSPUzvKhSVQsSUvA2ZKcRVHVNbjehK63XhkSHnRz/NVF7DueplhshIJPzz1AkywT+bUARyyi7DAFCJWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WNLXK095bzxSmp;
	Tue, 16 Jul 2024 09:07:45 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EAA8140795;
	Tue, 16 Jul 2024 09:12:35 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 16 Jul 2024 09:12:34 +0800
Message-ID: <50385bd0-f47a-46b3-a196-a93ec8f040f6@huawei.com>
Date: Tue, 16 Jul 2024 09:12:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
	<ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>, <dvyukov@google.com>,
	<vincenzo.frascino@arm.com>, <kasan-dev@googlegroups.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Question] race during kasan_populate_vmalloc_pte
To: <glider@google.com>
References: <20240618064022.1990814-1-mawupeng1@huawei.com>
 <e66bb4c1-f1bc-4aeb-a413-fcdbb327e73f@huawei.com>
 <CAG_fn=VTKFDAx2JQAEur5cxkSwNze-SOqQRbqBGwDx96Xq-6nQ@mail.gmail.com>
Content-Language: en-US
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAG_fn=VTKFDAx2JQAEur5cxkSwNze-SOqQRbqBGwDx96Xq-6nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)



On 2024/7/16 1:19, Alexander Potapenko wrote:
> On Fri, Jul 12, 2024 at 4:08 AM mawupeng <mawupeng1@huawei.com> wrote:
>>
>> Hi maintainers,
>>
>> kingly ping.
>>
>> On 2024/6/18 14:40, Wupeng Ma wrote:
>>> Hi maintainers,
>>>
>>> During our testing, we discovered that kasan vmalloc may trigger a false
>>> vmalloc-out-of-bounds warning due to a race between kasan_populate_vmalloc_pte
>>> and kasan_depopulate_vmalloc_pte.
>>>
>>> cpu0                          cpu1                            cpu2
>>>   kasan_populate_vmalloc_pte  kasan_populate_vmalloc_pte      kasan_depopulate_vmalloc_pte
>>>                                                               spin_unlock(&init_mm.page_table_lock);
>>>   pte_none(ptep_get(ptep))
>>>   // pte is valid here, return here
>>>                                                               pte_clear(&init_mm, addr, ptep);
>>>                               pte_none(ptep_get(ptep))
>>>                               // pte is none here try alloc new pages
>>>                                                               spin_lock(&init_mm.page_table_lock);
>>> kasan_poison
>>> // memset kasan shadow region to 0
>>>                               page = __get_free_page(GFP_KERNEL);
>>>                               __memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
>>>                               pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
>>>                               spin_lock(&init_mm.page_table_lock);
>>>                               set_pte_at(&init_mm, addr, ptep, pte);
>>>                               spin_unlock(&init_mm.page_table_lock);
>>>
>>>
>>> Since kasan shadow memory in cpu0 is set to 0xf0 which means it is not
>>> initialized after the race in cpu1. Consequently, a false vmalloc-out-of-bounds
>>> warning is triggered when a user attempts to access this memory region.
>>>
>>> The root cause of this problem is the pte valid check at the start of
>>> kasan_populate_vmalloc_pte should be removed since it is not protected by
>>> page_table_lock. However, this may result in severe performance degradation
>>> since pages will be frequently allocated and freed.
>>>
>>> Is there have any thoughts on how to solve this issue?
>>>
>>> Thank you.
> 
> I am going to take a closer look at this issue. Any chance you have a
> reproducer for it?

So far not good. I am trying to get a reproducer, but there is little progress in it.

> 

