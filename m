Return-Path: <linux-kernel+bounces-176460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACC8C303D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C023C1F231E2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683147A4C;
	Sat, 11 May 2024 08:29:10 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DA1C01
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715416150; cv=none; b=t0tb3AN6XWVs+KucunrpbIcET1nSLQonrkiifL2/c6WX6awz02itBZDhGuRtbUn4vM147CsKC3C34NLkUXpQ9Sn+P/w99M5DQHeOe6zq5BCltzBL8Mg8zRuvmKJpu0PhiHqe4oX8rS/VRM6TSJW64Ucy+DLG3r46k5cx4l3rCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715416150; c=relaxed/simple;
	bh=+jMW1AgTe1UQI84dE9Yx6UlQviyhETSbJjkNkE3s8+E=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nrUARAFqGh7h6jp84tzhe0yAKeuBMtgm6wQmnBc/HOa9nyukiveyLYzkXg6qT+Eva+qIJMBCqFMcMuC/vjnruxvTsBept0DhDBBzoi2hK9or2zfjCj3SpF25vVlyLD8EDnS1hcYhJ0ukE5auPni6o3PcFeys4xsZo7owr4uHwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VbzNk6WdHz1ypGL;
	Sat, 11 May 2024 16:26:14 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 640C818005F;
	Sat, 11 May 2024 16:29:04 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 16:29:03 +0800
Subject: Re: [PATCH v2 4/5] mm/memory-failure: move hwpoison_filter() higher
 up
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240510062602.901510-1-jane.chu@oracle.com>
 <20240510062602.901510-5-jane.chu@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <329c33ce-3fb8-436c-2ceb-e6520f0a973a@huawei.com>
Date: Sat, 11 May 2024 16:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240510062602.901510-5-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/10 14:26, Jane Chu wrote:
> Move hwpoison_filter() higher up as there is no need to spend a lot
> cycles only to find out later that the page is supposed to be skipped
> for hwpoison handling.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  mm/memory-failure.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 62133c10fb51..2fa884d8b5a3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2236,6 +2236,13 @@ int memory_failure(unsigned long pfn, int flags)
>  		goto unlock_mutex;
>  	}
>  
> +	if (hwpoison_filter(p)) {
> +		if (flags & MF_COUNT_INCREASED)
> +			put_page(p);
> +		res = -EOPNOTSUPP;
> +		goto unlock_mutex;
> +	}

It might not be a good idea to do hwpoison_filter() here. We don't hold extra page refcnt
yet, so the page state will be really unstable. Or am I miss something?
Thanks.
.

