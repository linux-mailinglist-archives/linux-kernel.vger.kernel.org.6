Return-Path: <linux-kernel+bounces-257855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A32B937FC7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812111C20E88
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26722F14;
	Sat, 20 Jul 2024 07:50:11 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A221803D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461811; cv=none; b=MKYhRKJjvnzdQh4HJ1+SYTwh+X4GW2Zs9CWPHxmS8uzAfjO+lx+ppli0+rr9qz4ALQNwANQTFQKh8R7xq2fUAZc1OBnyc/wm+7jrKiLYxJl0lNpKJRgLYTBPR0QXOWMXIDoPcKCBv9lkxUBposogK+Dr8PGYpgk32EsuFeYrqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461811; c=relaxed/simple;
	bh=Kh2EUFGYFXy14diaH6KHdGDZo+axku4hAZY5nq6jmGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j4J+g1XWGSNmdbD2gh6wvPCTA1Y/rPZl+P+Yd+2uPBwEvjmywz7KiR+TPdDfjQEPsHF3qvtZ79s3BMw5MU7UDprmrk7hTOnRY5DLr6xY8axJYypqVWqPcwu7LsCYI56kD8+aQ2Cw+2qpFxRWUroJiKKQgNrGNlJNXvPjUuHp8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WQz8y3t2xz1JCmH;
	Sat, 20 Jul 2024 15:45:06 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C54D140427;
	Sat, 20 Jul 2024 15:50:02 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 20 Jul 2024 15:50:01 +0800
Message-ID: <da7eff7c-ba42-4152-9186-14021befe5f1@huawei.com>
Date: Sat, 20 Jul 2024 15:50:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memory tiering: introduce folio_has_cpupid() check
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
CC: David Hildenbrand <david@redhat.com>, "Huang, Ying"
	<ying.huang@intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>
References: <20240719144306.258018-1-ziy@nvidia.com>
 <20240719144306.258018-2-ziy@nvidia.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240719144306.258018-2-ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/19 22:43, Zi Yan wrote:
> Instead of open coded check for if memory tiering mode is on and a folio
> is in the top tier memory, use a function to encapsulate the check.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>   include/linux/memory-tiers.h |  8 ++++++++
>   kernel/sched/fair.c          |  3 +--
>   mm/huge_memory.c             |  6 ++----
>   mm/memory-tiers.c            | 17 +++++++++++++++++
>   mm/memory.c                  |  3 +--
>   mm/mprotect.c                |  3 +--
>   6 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 0dc0cf2863e2..10c127d461c4 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -73,6 +73,10 @@ static inline bool node_is_toptier(int node)
>   }
>   #endif
>   
> +
> +bool folio_has_cpupid(struct folio *folio);
> +
> +
>   #else
>   
>   #define numa_demotion_enabled	false
> @@ -151,5 +155,9 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
>   static inline void mt_put_memory_types(struct list_head *memory_types)
>   {
>   }
> +static inline bool folio_has_cpupid(struct folio *folio)
> +{
> +	return true;
> +}

Maybe better to move into mm.h since most folio_foo_cpupid()s are there?


