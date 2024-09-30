Return-Path: <linux-kernel+bounces-343702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16F989E83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A818B24982
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8027189F58;
	Mon, 30 Sep 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED6WNjn8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F11885B4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688857; cv=none; b=FCpTcQjOXto62Z1CitfIGkXT2neNSk5OUKSHi0qOL1+fJGo03pzRQGGKZx717qrG7oEyH0x1RcelRe66uYhNuO+/QwkRRlb02eZAaZwjtNOipKIJkityr+zWAT2jCVXdA3U9UuTppa0d6E/G8K4++rTdzV0mDNq7Ys8NPeNcz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688857; c=relaxed/simple;
	bh=luJ7ZCRTIbwHqo30qQ88Bs0maLVLwi4SZQIGStnf8QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnZaw7L6AGIKmdf01ekEw5l5lIluCwbmiNqZmr/8tOKPZ0l354qXkQcHv18ENzaYKZHl6fGaycP++Tp6l3XQScfNzEgFcRJAjjW+fSI2VjgW8WAslhsY4P4NgtsPOs2uIpXgkESjZYmCbPogywA+UAcfq25fUyvK1eX4JvIbe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ED6WNjn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727688854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BZVthEUNPIwlM6FtjNXOfho4rXdOAOuOvTnuN3Ett20=;
	b=ED6WNjn8LRVqk9kYBkVPojaHYnCckq81sd8Po4vxzfl7yTMGmNjRDAjeQCDVo+C2GXzokG
	+waZXi3WrHx8FJsgYSlbfpX692yFwTLujhxeNyVahmKLpAYcPD6icQo+nAEpYUCWFsLgRh
	zTRapZsM5YMmJ37dG7oAIBQm92Zc5/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-pYPw2P5IOf249MpEbYx5hA-1; Mon, 30 Sep 2024 05:34:11 -0400
X-MC-Unique: pYPw2P5IOf249MpEbYx5hA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb471a230so31792215e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688850; x=1728293650;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZVthEUNPIwlM6FtjNXOfho4rXdOAOuOvTnuN3Ett20=;
        b=l8WxQ05F6MqJ6/XB7M/n3L0CNlz0nXzRLw4N3Y53gQpkfi8PIX8laYIRsuiIlvusLe
         YcZcdu+fL6nA6EbtmRjOfPPal5ATos7xVKYYcgnb45+z3S06GFv/HTRSEUxVzGurxg+T
         3rxgfVpogftdd87PId+UKLhkjSyMURilKO0I4YVzWSRrBoQkYbKaT7ClEEb6pFun1Ena
         uy1BByC0BfPTxtDqH32SF//dESii2XxRXPVFCN07KeJTXi9utEbJSDNVku3gK1oWyw/g
         8rUv3konHXTsZemB5CcbDYnB6+ye8sTP01NBYTxPvvu63bR0lW9y43bJiD674THWW3+3
         suMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfeva1bc1sTLGhHNJcKT39EgbfGOZ1tZfja45dxB2ckOPr49a4K4mn1XB1QWUd7z6yO1uluUw6nG+vSQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnB2esxnF3VzogdZ+v1tm5BYyEfd67uNMGlN+hd2jvn83AN6r
	reIawOhf8BsS6Bfr2uo2LvbRfGXCNAYInsxhKs9fIIY7aXjoFVQJZhRtdy09mc+G88vbCrCEKv2
	Yn3HqAk5YgeJyYl3j9HNn0xFXf4IhEnhRwwTCj3keaqqfftFstKov1j+hFD7ecw==
X-Received: by 2002:a05:600c:1d20:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42f58497f3emr75046775e9.27.1727688850669;
        Mon, 30 Sep 2024 02:34:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9564xoWIXAwNWACxO0PL3zRCHxnAkBlODzEk3tsz/hgC2LVEkzK7dp2NTczi6+euZoUHS3g==
X-Received: by 2002:a05:600c:1d20:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42f58497f3emr75046565e9.27.1727688850279;
        Mon, 30 Sep 2024 02:34:10 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de11aasm97132975e9.16.2024.09.30.02.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 02:34:09 -0700 (PDT)
Message-ID: <f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com>
Date: Mon, 30 Sep 2024 11:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/cma: print total and used count in cma_alloc()
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20240929032757.404707-1-gxxa03070307@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240929032757.404707-1-gxxa03070307@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.09.24 05:27, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 

We should add here

"To debug CMA allocations (especially failing ones), it is valuable to 
know the state of CMA: how many pages out of the total ones are 
allocated, and how many were requested to be allocated. Let's print
some more information."

I assume Andrew can fix that up when applying.

> before:
> [   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> 
> after:
> [   24.069738] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 64, request pages: 1, align 0)
> [   24.075317] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 65, request pages: 1, align 0)
> [   24.078455] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 66, request pages: 1, align 0)
> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>   mm/cma.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 2d9fae939283..90b3fdbac19c 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -403,6 +403,17 @@ static void cma_debug_show_areas(struct cma *cma)
>   	spin_unlock_irq(&cma->lock);
>   }
>   
> +static unsigned long cma_get_used_pages(struct cma *cma)
> +{
> +	unsigned long used;
> +
> +	spin_lock_irq(&cma->lock);
> +	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> +	spin_unlock_irq(&cma->lock);

This adds overhead to each allocation, even if debug outputs are ignored 
I assume?

I wonder if we'd want to print these details only when our allocation 
failed?

Alternatively, we could actually track how many pages are allocated in 
the cma, so we don't have to traverse the complete bitmap on every 
allocation.


-- 
Cheers,

David / dhildenb


