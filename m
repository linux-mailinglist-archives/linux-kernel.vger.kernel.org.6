Return-Path: <linux-kernel+bounces-250071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDF92F3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C01C223A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25098BF0;
	Fri, 12 Jul 2024 02:08:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC14C6C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720750108; cv=none; b=PzLSr0Tq+Z5aChEAsgncJRW3eB01k8cbFGdjIlyZYIfDXw/Mjz4/U6cFPJch6VK1IgaoJv2WklUADplQtOGb8j9HqX9q/QQsWzFCcv+vY3qxPenHiW5DY///3YIpxUzfDv7ZkgRpF1yPY86xocOcRKZSdWcWAEi25H7J1WY+z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720750108; c=relaxed/simple;
	bh=Z8lHIf2L5e/WXNnk/CJQuyhgt0SQMV6BADSjTn5qGTY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eH9d8bhLY1ZA54H3mBF4PB8+BPkr/XALv0t8bnS2BDxoQ0xpDowCwOraPVBHRZQyUJ6sq68vW6EcRTE9RQLMszUuElivGgQbZJwwvWdWeZkMwQrcJj8SiwAG6/1AN4dnE99FwwKtaYKtYNNsnNV3B8stNA4ncg5BVheR407jaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WKvyn0Zd3zxWDM;
	Fri, 12 Jul 2024 10:03:45 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 15A37140413;
	Fri, 12 Jul 2024 10:08:22 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 12 Jul 2024 10:08:21 +0800
Message-ID: <e66bb4c1-f1bc-4aeb-a413-fcdbb327e73f@huawei.com>
Date: Fri, 12 Jul 2024 10:08:21 +0800
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

