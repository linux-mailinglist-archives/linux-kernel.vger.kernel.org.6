Return-Path: <linux-kernel+bounces-223803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4691184B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD31283F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB082891;
	Fri, 21 Jun 2024 02:08:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9343EA6C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935708; cv=none; b=mRjmdDFPpGFI59s/2yAAr5syMoIgUL9OKgHw/5I3gmZWV3EX6ER9R06VgH4Vr8Cag/dit+xJ7EVofIUo0tV67V5s1o12A9KAaoal9gAiLXBMCpLC+0Mq7xG3ntgyLnOUbwJwFEebB94R3tTjSnUIbW451hcGl+Ty/lTqB89Dha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935708; c=relaxed/simple;
	bh=Z8lHIf2L5e/WXNnk/CJQuyhgt0SQMV6BADSjTn5qGTY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KavRMpGJo5Iowx1Z+Eba3Vg3b2IabsomTaWqQ/Y8xYQK8xfwgQVGZjxqzYbh7J9lKNgx41bSLIjsMsQXeJ7+XxGU++6nMkGpvpnt8kcrwkQ0e+he60Le4W/r19zPWJRWDj17bu1xQ80VkVEDEE38baCS6mCVvhHApJ0o0CEXucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W50y43BvWzVm4r;
	Fri, 21 Jun 2024 10:03:24 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 55A5A14011A;
	Fri, 21 Jun 2024 10:08:21 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 10:08:20 +0800
Message-ID: <dc0294ea-0724-4403-ab0f-d968fbf36586@huawei.com>
Date: Fri, 21 Jun 2024 10:08:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <kasan-dev@googlegroups.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Question] race during kasan_populate_vmalloc_pte
To: <akpm@linux-foundation.org>, <ryabinin.a.a@gmail.com>,
	<glider@google.com>, <andreyknvl@gmail.com>, <dvyukov@google.com>,
	<vincenzo.frascino@arm.com>
References: <20240618064022.1990814-1-mawupeng1@huawei.com>
Content-Language: en-US
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20240618064022.1990814-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Hi maintainers,

kingly ping.

On 2024/6/18 14:40, Wupeng Ma wrote:
> Hi maintainers,
> 
> During our testing, we discovered that kasan vmalloc may trigger a false
> vmalloc-out-of-bounds warning due to a race between kasan_populate_vmalloc_pte
> and kasan_depopulate_vmalloc_pte.
> 
> cpu0				cpu1				cpu2
>   kasan_populate_vmalloc_pte	kasan_populate_vmalloc_pte	kasan_depopulate_vmalloc_pte
> 								spin_unlock(&init_mm.page_table_lock);
>   pte_none(ptep_get(ptep))
>   // pte is valid here, return here
> 								pte_clear(&init_mm, addr, ptep);
> 				pte_none(ptep_get(ptep))
> 				// pte is none here try alloc new pages
> 								spin_lock(&init_mm.page_table_lock);
> kasan_poison
> // memset kasan shadow region to 0
> 				page = __get_free_page(GFP_KERNEL);
> 				__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
> 				pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
> 				spin_lock(&init_mm.page_table_lock);
> 				set_pte_at(&init_mm, addr, ptep, pte);
> 				spin_unlock(&init_mm.page_table_lock);
> 
> 
> Since kasan shadow memory in cpu0 is set to 0xf0 which means it is not
> initialized after the race in cpu1. Consequently, a false vmalloc-out-of-bounds
> warning is triggered when a user attempts to access this memory region.
> 
> The root cause of this problem is the pte valid check at the start of
> kasan_populate_vmalloc_pte should be removed since it is not protected by
> page_table_lock. However, this may result in severe performance degradation
> since pages will be frequently allocated and freed.
> 
> Is there have any thoughts on how to solve this issue?
> 
> Thank you.

