Return-Path: <linux-kernel+bounces-171080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAE8BDF93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C304B22ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F414F109;
	Tue,  7 May 2024 10:21:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C814E2E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077308; cv=none; b=Ft4xzDFthjzxA/lncxFCHMVaYuyWiVKgquVdxTMqnlCaMLp3sxW0lPGNJozI0JPbG513EeM3rykybJ0JSbjw6WF7SQFqE5gTgKydZDRID3n8nHK5lty76JyPiIMnEHCTBXSlPmqccv4o8FMGd4XldANUgH7BqLnxW+k3A1S8sv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077308; c=relaxed/simple;
	bh=ECyR1tgzfLMX85fMy9PUgl5KdwwbExytsPT9LvKv8Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfGocQB009Aba+WrVmmC5N+xZXYW5AYjAPOQQtCNDE9gUEwAEniug/36Nd3tmt+CZKZoUbdHoRoubA0vItzAnie4kP/KTzSj+N33pb0OPTxJRoMTSPsp4TEoCxSjDVuTHDlyy/H8SUrcs734Q15m074UCnLAFdGJLTd0tagMyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC7C1063;
	Tue,  7 May 2024 03:22:12 -0700 (PDT)
Received: from [10.1.34.181] (unknown [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FCCC3F587;
	Tue,  7 May 2024 03:21:45 -0700 (PDT)
Message-ID: <9576c979-8a11-48e2-aec4-646acf0d8e26@arm.com>
Date: Tue, 7 May 2024 11:21:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: move highest_order() and next_order() out of the
 THP config
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <d9c0ac9df6f6e6176b09fc1ae58146ec4f8d73f5.1714978902.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d9c0ac9df6f6e6176b09fc1ae58146ec4f8d73f5.1714978902.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 09:46, Baolin Wang wrote:
> Move highest_order() and next_order() out of the CONFIG_TRANSPARENT_HUGEPAGE
> macro, which can be common functions to be used.

Sorry if I haven't kept up with the discussion, but why is this needed? I
wouldn't expect a need to iterate over orders if THP is compile-time disabled
because we will never try to allocate THP?

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 017cee864080..e49b56c40a11 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -106,6 +106,17 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>  #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>  
> +static inline int highest_order(unsigned long orders)
> +{
> +	return fls_long(orders) - 1;
> +}
> +
> +static inline int next_order(unsigned long *orders, int prev)
> +{
> +	*orders &= ~BIT(prev);
> +	return highest_order(*orders);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  
>  extern unsigned long transparent_hugepage_flags;
> @@ -138,17 +149,6 @@ static inline bool hugepage_flags_enabled(void)
>  	       huge_anon_orders_madvise;
>  }
>  
> -static inline int highest_order(unsigned long orders)
> -{
> -	return fls_long(orders) - 1;
> -}
> -
> -static inline int next_order(unsigned long *orders, int prev)
> -{
> -	*orders &= ~BIT(prev);
> -	return highest_order(*orders);
> -}
> -
>  /*
>   * Do the below checks:
>   *   - For file vma, check if the linear page offset of vma is


