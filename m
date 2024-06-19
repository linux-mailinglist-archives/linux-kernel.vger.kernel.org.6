Return-Path: <linux-kernel+bounces-220425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38690E191
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A3C1C2274B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514433993;
	Wed, 19 Jun 2024 02:16:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C772F1EA74
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763385; cv=none; b=PtS1P91YCw/EbGdE3e3i3gucS1Yex0PqhltbizcNJC5ocYG3LWOHLIU9+UulmRGDIoW/BodPvFGiN7DD8hJBzvV6vNYyjlL6/ung+1dwjYQTgCjmIrRlxwqsp9ki+3tj+CsPnExc1AaR6XL3srsq6BZsnRDGPBMYwGCW+CahxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763385; c=relaxed/simple;
	bh=Gn5D3k1g9gIN2KPelU2LJ7WaOAQjs2ONFDCLV2u2NIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dl91pf8cLvxrQiAZe1KYcOiTrHd/p9yOz8qn1A5AH0Bu68mz7RgwSDwIDVo7SirYPqtCJYA73v+CbCmNteUzpNn/7QjNgsFYpZAXiBW4bJO6aoh81E3GUvuVqaEJfsfV62sqvkMM2Y3FmKwBkuJtrdW/PUdtRRVoSQT9rw4eLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W3nFq6BzVzPrMY;
	Wed, 19 Jun 2024 10:12:47 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DF2514011F;
	Wed, 19 Jun 2024 10:16:20 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 10:16:19 +0800
Message-ID: <f61855bc-2c2c-d819-a594-800469f9441c@huawei.com>
Date: Wed, 19 Jun 2024 10:16:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 -next] mm/hugetlb_cgroup: register lockdep key for
 cftype
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240618233608.400367-1-sj@kernel.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20240618233608.400367-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/19 7:36, SeongJae Park wrote:
> Hi Xiu,
> 
> 
> On Tue, 18 Jun 2024 07:19:22 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
>> When CONFIG_DEBUG_LOCK_ALLOC is enabled, the following commands can
>> trigger a bug,
>>
>> mount -t cgroup2 none /sys/fs/cgroup
>> cd /sys/fs/cgroup
>> echo "+hugetlb" > cgroup.subtree_control
> 
> [...]
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index 2b899c4ae968..4ff238ba1250 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -836,6 +836,8 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>>  			cft->file_offset = MEMFILE_OFFSET0(offset) +
>>  					   MEMFILE_FIELD_SIZE(offset) * idx;
>>  		}
>> +
>> +		lockdep_register_key(&cft->lockdep_key);
>>  	}
>>  }
> 
> I found the latest mm-unstable tree fails build as below, and 'git bisect'
> points this patch.
> 
>     linux/mm/hugetlb_cgroup.c: In function ‘hugetlb_cgroup_cfttypes_init’:
>     linux/mm/hugetlb_cgroup.c:840:42: error: ‘struct cftype’ has no member named ‘lockdep_key’
>       840 |                 lockdep_register_key(&cft->lockdep_key);
>           |                                          ^~
> 
> Maybe we should take care of CONFIG_DEBUG_LOCK_ALLOC undefined case, like
> below?
> 
> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index a45065698419..9747c2e64e95 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -837,7 +837,9 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>                                            MEMFILE_FIELD_SIZE(offset) * idx;
>                 }
> 
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>                 lockdep_register_key(&cft->lockdep_key);
> +#endif
>         }
>  }

Hi SeongJae,

Thanks for you review.

I think it's better to remove the #ifdef CONFIG_DEBUG_LOCK_ALLOC from
the struct cftype which guards the cft->lockdep_key, because when
CONFIG_DEBUG_LOCK_ALLOC is not defined, struct lock_class_key is an
empty definition which takes no space and can be unconditionally used
within the structure, this may make the code more clean.

To Andrew,

Would you please drop the v2 and pick the v3? thanks.

> 
> [...]
> 
> 
> Thanks,
> SJ

