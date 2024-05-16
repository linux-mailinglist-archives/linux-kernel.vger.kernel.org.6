Return-Path: <linux-kernel+bounces-180884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772388C7453
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5571C223D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BE14388A;
	Thu, 16 May 2024 10:03:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D7143754
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853836; cv=none; b=I2xk8nsjapAXW51qV2gpSW3eBKcgcAoqEFoGVFCIe3mbJ7Wf6QZUg1O9LanOIJTNN/o5XFQHHTBeoOKnnaAV75fMTGLM5kBnKwVskSV31sE2isQ79rCFopXWOxgZeuXaTcNpxTW+8MQu/4QNaMvFkLv7AqpF0ggw4ijesdLQ4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853836; c=relaxed/simple;
	bh=009iAbl0t2VqPd7PIsRrUBmqkdj8koEBV/R4e8ltrCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NBCoBtLX81A2e0STF9jqWIZlAfmtTF6Nhv0sd5HCMWkGmuYzdEdfudftzHq+Jqaqu/zNAwrrRDTS30WWHHNecQkiTvVP3hjmrL/rIRSMNUuxw/HudH5+uY14FEPO9oi9yuP3YyTcHs1dmhK6DoBRQEhT1UngnYwSy6ZL1ZLKk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vg5HV2Y4gzcf7D;
	Thu, 16 May 2024 18:02:30 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2747B14038F;
	Thu, 16 May 2024 18:03:45 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 18:03:44 +0800
Message-ID: <1d38aa26-cd2f-4330-9dcc-6c379cecb83b@huawei.com>
Date: Thu, 16 May 2024 18:03:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: get nid from physical address
Content-Language: en-US
To: Yajun Deng <yajun.deng@linux.dev>, <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240516091701.1527002-1-yajun.deng@linux.dev>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240516091701.1527002-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/16 17:17, Yajun Deng wrote:
> The nid passed to cma_declare_contiguous_nid() may be NUMA_NO_NODE,
> which is not the actual nid. To get the correct nid, we can get the nid
> from physical address.
> 

Please check

https://lore.kernel.org/linux-riscv/47437c2b-5946-41c6-ad1b-cc03329eb230@huawei.com/

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   mm/cma.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..be6cdde32944 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -361,6 +361,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>   		kmemleak_ignore_phys(addr);
>   		base = addr;
>   	}
> +	nid = early_pfn_to_nid(PHYS_PFN(base));
>   
>   	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
>   	if (ret)

