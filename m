Return-Path: <linux-kernel+bounces-234757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1180E91CA77
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D812840A5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7E6AAD;
	Sat, 29 Jun 2024 02:09:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3753AC
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626992; cv=none; b=HfXZANNCYR0Lys6OlkbvM+ATm6ZZrPmjzyF+tetvu3wTd99O0HdzcD/fYU2u4+hYzGwR+u1PclFvwX4bzOVPhvHoudE8yLfDJMG4+ZtXgla+Oe6C4xNCfM83qVKbHOOc0FIubKZHJyADK4iuzOR84INc4N4ZYiAHV2ETFAZCVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626992; c=relaxed/simple;
	bh=82cMEDZgsOCStoszbG003JYDsvuSr6310ht9b8yYAJI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fHjS9kR9XRyeThrizvEFdsr3kdpZEVVwqNmR037iOHh3UwwraRNNv50u1RMiAPL/SJJSus7/Q4WF30Q60jKYJFNML5APumdvj09OBQV3kzPrIHpd9okLtNKSwY3KupzuFmqGaScFVEgs5v4FI6+5VEXg1ZAjZnnQ1oq87EQrYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W9wjY46QJznXv0;
	Sat, 29 Jun 2024 10:09:37 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id C390B140FDB;
	Sat, 29 Jun 2024 10:09:47 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Jun 2024 10:09:47 +0800
Subject: Re: [PATCH] mm/memory-failure: allow memory allocation from emergency
 reserves
To: Rui Qi <qirui.001@bytedance.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<nao.horiguchi@gmail.com>, <akpm@linux-foundation.org>
References: <20240625022342.6158-1-qirui.001@bytedance.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d7fb45a9-2d16-a2d5-59f4-f1e7a4362e33@huawei.com>
Date: Sat, 29 Jun 2024 10:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240625022342.6158-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/6/25 10:23, Rui Qi wrote:
> From: Rui Qi <qirui.001@bytedance.com>
> 
> we hope that memory errors can be successfully handled quickly, using
> __GFP_MEMALLOC can help us improve the success rate of processing

Comments of __GFP_MEMALLOC says:

 * Users of this flag have to be extremely careful to not deplete the reserve
 * completely and implement a throttling mechanism which controls the
 * consumption of the reserve based on the amount of freed memory.

It seems there's no such throttling mechanism in memory_failure.

> under memory pressure, because to_kill struct is freed very quickly,
> so using __GFP_MEMALLOC will not exacerbate memory pressure for a long time,
> and  more memory will be freed after killed task exiting, which will also

Tasks might not be killed even to_kill struct is allocated.

> reduce memory pressure.
> 
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>  mm/memory-failure.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 05818d09b4eb..0608383f927a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -451,7 +451,7 @@ static void __add_to_kill(struct task_struct *tsk, struct page *p,
>  {
>  	struct to_kill *tk;
>  
> -	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> +	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC | __GFP_MEMALLOC);
>  	if (!tk) {
>  		pr_err("Out of memory while machine check handling\n");
>  		return;
> @@ -1931,7 +1931,7 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>  			return -EHWPOISON;
>  	}
>  
> -	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC | __GFP_MEMALLOC);

In already hardware poisoned code path, raw_hwp can be allocated to store raw page info
without killing anything. So __GFP_MEMALLOC might not be suitable to use.
Or am I miss something?

Thanks.
.

