Return-Path: <linux-kernel+bounces-510503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D435A31DED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0FA188BA31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC151F5424;
	Wed, 12 Feb 2025 05:25:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3C1F4295
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337925; cv=none; b=rjQyZj6NRZMusZ7+wRrRTqnP12ywSxHXiUt+ATEKsufMst74H1vW9wWIz6d+xL12/5wpUpXEBAe/6Wzk6hJdTyXDOUDlzpwXiXFe6pFaGQzK6aTf1hXv8U20YJGWFMiRhFa67eBlywQJSKiUobytxAyDsErWgpLaVHYKVXYph44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337925; c=relaxed/simple;
	bh=e68gMHBciE17ql8Pzu7LlCsE41pQ5QWryFkhO1ze4CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjDb/+dfga8a43K1HVtzKxpxFlzIeqh+rVnWBk81sdfph0U9urnnCx/MRkb1DXSjrxzYQF4oujklVYHo2jiO8jvxdWAbsr4EdPRo6sEvw7v4A8fjoNhbCXnTUvE0iQtz35FmghjFbP262AinNSpHmcwoFR+2Xk2oTwbSYlPYBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EEF13D5;
	Tue, 11 Feb 2025 21:25:43 -0800 (PST)
Received: from [10.162.43.26] (K4MQJ0H1H2.blr.arm.com [10.162.43.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914C03F58B;
	Tue, 11 Feb 2025 21:25:20 -0800 (PST)
Message-ID: <df25775e-9c78-44f3-b058-1c8e8de32288@arm.com>
Date: Wed, 12 Feb 2025 10:55:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/folio_queue: Delete __folio_order and use
 folio_order directly
To: Liu Ye <liuye@kylinos.cn>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-2-liuye@kylinos.cn>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250212025843.80283-2-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/25 8:28 am, Liu Ye wrote:
> __folio_order is the same as folio_order, remove __folio_order and then
> just include mm.h and use folio_order directly.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>   include/linux/folio_queue.h | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
> index 4d3f8074c137..45ad2408a80c 100644
> --- a/include/linux/folio_queue.h
> +++ b/include/linux/folio_queue.h
> @@ -15,6 +15,7 @@
>   #define _LINUX_FOLIO_QUEUE_H
>   
>   #include <linux/pagevec.h>
> +#include <linux/mm.h>
>   
>   /*
>    * Segment in a queue of running buffers.  Each segment can hold a number of
> @@ -216,13 +217,6 @@ static inline void folioq_unmark3(struct folio_queue *folioq, unsigned int slot)
>   	clear_bit(slot, &folioq->marks3);
>   }
>   
> -static inline unsigned int __folio_order(struct folio *folio)
> -{
> -	if (!folio_test_large(folio))
> -		return 0;
> -	return folio->_flags_1 & 0xff;
> -}
> -
>   /**
>    * folioq_append: Add a folio to a folio queue segment
>    * @folioq: The segment to add to
> @@ -241,7 +235,7 @@ static inline unsigned int folioq_append(struct folio_queue *folioq, struct foli
>   	unsigned int slot = folioq->vec.nr++;
>   
>   	folioq->vec.folios[slot] = folio;
> -	folioq->orders[slot] = __folio_order(folio);
> +	folioq->orders[slot] = folio_order(folio);
>   	return slot;
>   }
>   
> @@ -263,7 +257,7 @@ static inline unsigned int folioq_append_mark(struct folio_queue *folioq, struct
>   	unsigned int slot = folioq->vec.nr++;
>   
>   	folioq->vec.folios[slot] = folio;
> -	folioq->orders[slot] = __folio_order(folio);
> +	folioq->orders[slot] = folio_order(folio);
>   	folioq_mark(folioq, slot);
>   	return slot;
>   }

This looks like a reasonable change to make, since it avoids code 
duplication. Please consider:

Reviewed-by: Dev Jain <dev.jain@arm.com>


