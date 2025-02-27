Return-Path: <linux-kernel+bounces-535598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A740FA474E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B76316C265
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4451E5210;
	Thu, 27 Feb 2025 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oGIVWIGJ"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D6270022
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631860; cv=none; b=AJCOGXTuFR+AL30N7TVK3baf+j5/vK0w0EJb9Z9Xj81iJFLShwbHNAdnJvlnZBtb/hK7QkGwjINGn10mWVr5/SsLEJWQz9tRFbD/32JqIO2URd1wfmKOLidOicEkNjsqFhydc2wk9/iabR6rgCQPbYyDpnjfZzXr/nqB6sc+4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631860; c=relaxed/simple;
	bh=ZImwhOKTAXCZnN+ybMvraar6WVEoDLchlO8zKVoIOBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZE0wkWkVwNYSAzGwNre/lB02MkG63M9xk5mGryAaoZrOrhS/hs3MSv+eUgwOtmboj9BaIp3Bb1p6o/nBJ+3b+6k++p5KKLYJrRnDWbDzoyTiiwLMj3y/fxTMGMAoM+gfPcd8t3rj1bEqd8vaBlM0iZzbq9G+2yiDIUtLoz6qJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oGIVWIGJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740631852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=teBbDeeWomhuKYrmqY15HEQouHnOjTiz77oFo6Ak1ns=;
	b=oGIVWIGJJz4fgymbTbkVOwne6coXgHHymjWsXQQmxSDCg0+qMfOb5MJ0yZcSCiG6xE1L0EEQ4Hs2493pZ8Q5N9z3Lb1yzb8NLoJZyElnFA7pPNohH+EeaQwsL4D+ra/UOEiAh2WogGWZWuArC92ElqIDIAsr9zbtLoM3O4l+RdY=
Received: from 30.74.144.117(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQL0NIW_1740631850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Feb 2025 12:50:50 +0800
Message-ID: <eb7a13b1-7e31-4010-b35d-0f289ba3a799@linux.alibaba.com>
Date: Thu, 27 Feb 2025 12:50:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: remove unnecessary warning in
 shmem_writepage()
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
 kernel-dev@igalia.com, Pengfei Xu <pengfei.xu@intel.com>
References: <20250226-20250221-warning-in-shmem_writepage-v1-1-5ad19420e17e@igalia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250226-20250221-warning-in-shmem_writepage-v1-1-5ad19420e17e@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/26 20:26, Ricardo Cañuelo Navarro wrote:
> Although the scenario where shmem_writepage() is called with info->flags
> & VM_LOCKED is unlikely to happen, it's still possible, as evidenced by
> syzbot [1]. However, the warning in this case isn't necessary because
> the situation is already handled correctly [2].
> 
> [2] https://lore.kernel.org/lkml/8afe1f7f-31a2-4fc0-1fbd-f9ba8a116fe3@google.com/
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Closes: https://lore.kernel.org/lkml/ZZ9PShXjKJkVelNm@xpf.sh.intel.com/ [1]
> Suggested-by: Hugh Dickins <hughd@google.com>
> Cc: Florent Revest <revest@chromium.org>
> Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
> Fixes: 9a976f0c847b ("shmem: skip page split if we're not reclaiming")
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/shmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ea6109a80431e5eeae15278064d5c86412f9fc9..a5eaad03038e8ca56a54d096159892e01c7a5bfe 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1548,7 +1548,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	if (WARN_ON_ONCE(!wbc->for_reclaim))
>   		goto redirty;
>   
> -	if (WARN_ON_ONCE((info->flags & VM_LOCKED) || sbinfo->noswap))
> +	if ((info->flags & VM_LOCKED) || sbinfo->noswap)
>   		goto redirty;
>   
>   	if (!total_swap_pages)
> 
> ---
> base-commit: ac9c34d1e45a4c25174ced4fc0cfc33ff3ed08c7
> change-id: 20250226-20250221-warning-in-shmem_writepage-e7f8f273317c
> 
> Cheers,
> Ricardo
> 

