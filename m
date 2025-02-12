Return-Path: <linux-kernel+bounces-510488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931EA31DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B549E188A57E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926F1D63FF;
	Wed, 12 Feb 2025 05:13:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE65474C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337188; cv=none; b=M4l+2ZE05nK2//2uNMjxe8arifRUk9eQEd5TsXRtmkEoHKl0Nf8QVrA8seapSdNkyrlfJBWp5h3ekwLkmR5Dx7qMWEEYI4kAvJhpc948ngA5+yI+iOQRp8dNdjScr+uCwU/hq960/arJSlzWg0tIRwFr2kNl2CE5Dc3If9Jj26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337188; c=relaxed/simple;
	bh=apAY5igXLHo93QleIpsBztmO7BUOMH9zII/geat3C6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phYHgLAuthRNNPSzF7I9Zy2uZuxeNdkTVcGWACH8l12oSxldJwmvm04muM70DaEmYJ1DOLb0ZG2mf3cQNH1F7tjro2jgz1TvkbU9xDKn0TNJS/DqBseyQY+BuExC1cOxRqcjvJTCVsHZ8pyOwjRrv+RqvkHQkheqTxncxJb+D8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD8A13D5;
	Tue, 11 Feb 2025 21:13:26 -0800 (PST)
Received: from [10.162.43.26] (unknown [10.162.43.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CFCE3F58B;
	Tue, 11 Feb 2025 21:13:03 -0800 (PST)
Message-ID: <bd881d92-cf4f-4f5e-9c22-1f5f6a5c4f15@arm.com>
Date: Wed, 12 Feb 2025 10:42:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
To: Liu Ye <liuye@kylinos.cn>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250212025843.80283-3-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/25 8:28 am, Liu Ye wrote:
> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
> used. Write it as a macro definition to improve the readability and
> maintainability of the code.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>   include/linux/mm.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..750e75f45557 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>   struct mmu_gather;
>   struct inode;
>   
> +#define FOLIO_ORDER(folio) ((folio)->_flags_1 & 0xff)
> +
>   /*
>    * compound_order() can be called without holding a reference, which means
>    * that niceties like page_folio() don't work.  These callers should be
> @@ -1111,7 +1113,7 @@ static inline unsigned int compound_order(struct page *page)
>   
>   	if (!test_bit(PG_head, &folio->flags))
>   		return 0;
> -	return folio->_flags_1 & 0xff;
> +	return FOLIO_ORDER(folio);
>   }
>   
>   /**
> @@ -1127,7 +1129,7 @@ static inline unsigned int folio_order(const struct folio *folio)
>   {
>   	if (!folio_test_large(folio))
>   		return 0;
> -	return folio->_flags_1 & 0xff;
> +	return FOLIO_ORDER(folio);
>   }
>   
>   #include <linux/huge_mm.h>
> @@ -2061,7 +2063,7 @@ static inline long folio_nr_pages(const struct folio *folio)
>   #ifdef CONFIG_64BIT
>   	return folio->_folio_nr_pages;
>   #else
> -	return 1L << (folio->_flags_1 & 0xff);
> +	return 1L << FOLIO_ORDER(folio);
>   #endif
>   }
>   
> @@ -2086,7 +2088,7 @@ static inline unsigned long compound_nr(struct page *page)
>   #ifdef CONFIG_64BIT
>   	return folio->_folio_nr_pages;
>   #else
> -	return 1L << (folio->_flags_1 & 0xff);
> +	return 1L << FOLIO_ORDER(folio);
>   #endif
>   }
>   

Personally I do not think this is improving readability. You are 
introducing one more macro for people to decipher instead of directly 
seeing folio->_flags_1 & 0xff. This is similar to whether to write
if (x) => do_stuff(), or if (x != 0) => do_stuff(). The former is more 
"readable" by convention but the latter makes it easier and obvious to 
understand.


