Return-Path: <linux-kernel+bounces-173067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A88BFB12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CB21C211C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBA8120A;
	Wed,  8 May 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mKlT/PE1"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD0818
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164538; cv=none; b=RO90fX5Dtp6bZVC3SpLiP9CP35MilfHOK1m+gZ+OSEiLxmK8KH6YEuvqeJnRTr2/rVlVx5epvzsy5T/x92hNhnnV7+ncPROsgeKVIUTmLp/FN4M3lLHRCINFxOQvH8NTXrjm5i1ZUBB/Gxor5HfB8WFIp8LsZJaerURyKi7rO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164538; c=relaxed/simple;
	bh=APidSQ+3WQOS9Q06FfKzB35Pu5Hy9eNcQ8g5v/Lka7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3BpCZja0IviMqfMCLla7VjhlQIsyHaUaolBhEGbIDmK6FFKvxR9DkuSslyzkeQIvu2/zVgsvncWPm3aXFszmoyIjs3ntJahKp6+uGHXsdSTjCsYFuxP9sf8zokQ/TPYqIAeLuxVTzSw5ZgUW5ZJXy92eDjVLgwh/rGy4nKCQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mKlT/PE1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36168dfd-bdfa-42cd-965a-f7a0e108108e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715164534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RK5/NX8sHGGXG6wjj5Bs0mAPLkvXvHvETx9taLYIC70=;
	b=mKlT/PE19fkGF6lF6eMgEHYE2HIx9ALSLH0p+Ofh6u5w4NhlCKa7XMgT7lhjiGpGTOXUPm
	9toyXZZBCIz2c5psawYuWP3+8f9kWQZGpQAjsPaaXpqH0HMI09JSKTwEMHv+StDkLQjBe/
	LQsv6a2XOAtLk20SHawA0zEkmFbWEbc=
Date: Wed, 8 May 2024 18:35:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm/ksm: fix ksm_pages_scanned accounting
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>,
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
 <20240508-b4-ksm-counters-v1-1-e2a9b13f70c5@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240508-b4-ksm-counters-v1-1-e2a9b13f70c5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/8 17:55, Chengming Zhou wrote:
> During testing, I found ksm_pages_scanned is unchanged although the
> scan_get_next_rmap_item() did return valid rmap_item that is not NULL.
> 
> The reason is the scan_get_next_rmap_item() will return NULL after
> a full scan, so ksm_do_scan() just return without accounting of the
> ksm_pages_scanned.
> 
> Fix it by just putting ksm_pages_scanned accounting in that loop,
> and it will be accounted more timely if that loop would last for
> a long time.
> 

Fixes: b348b5fe2b5f ("mm/ksm: add pages scanned metric")

> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  mm/ksm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index e1034bf1c937..0f9c491552ff 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2753,18 +2753,16 @@ static void ksm_do_scan(unsigned int scan_npages)
>  {
>  	struct ksm_rmap_item *rmap_item;
>  	struct page *page;
> -	unsigned int npages = scan_npages;
>  
> -	while (npages-- && likely(!freezing(current))) {
> +	while (scan_npages-- && likely(!freezing(current))) {
>  		cond_resched();
>  		rmap_item = scan_get_next_rmap_item(&page);
>  		if (!rmap_item)
>  			return;
>  		cmp_and_merge_page(page, rmap_item);
>  		put_page(page);
> +		ksm_pages_scanned++;
>  	}
> -
> -	ksm_pages_scanned += scan_npages - npages;
>  }
>  
>  static int ksmd_should_run(void)
> 

