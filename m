Return-Path: <linux-kernel+bounces-341727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213429884BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAEDB21C32
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0318C019;
	Fri, 27 Sep 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfzDtLwD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C021E507
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440226; cv=none; b=TwHt7++Ygmpr8CCEwPiaiwbP3Pl2xuQg4/G8Cp5VJSCivArSmVXe6u+z63BmgyKRP7gWsdv5zCaV1cRf8oqFg7eqLc7kATAIAUvhhEcXYeURg36aliimBMmF0tyWecdLAp94zoLPSvFZqoyLgizs8nsZ0zpLjZuge4eElFX3664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440226; c=relaxed/simple;
	bh=tHRUqCMWaS4E0lwZZuFt/tXCyKXxjn5fb4KXIUqpMWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXkwV6e51vtkBON4YWoUwS2tX0/bj+izZe+hZP237Jb7RkscLhdUaWKpDHjz9Ab9ToSpQaMuZMwVTB70E7XrdmRVICMed/kZ1cLc/ydG3Tp9U4sKHbuisY26IHmMr/FDfL2ZBLfBhO55/jbwu+JCfL43bq4p2u+NRV4pG8sEAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfzDtLwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727440223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b70emq1asFc0837pR5hOySriSfg2vpMiOIzL46iGcG0=;
	b=AfzDtLwDv2CDEwBDc8hUBhFBck2qMMuB16E/eCZw4XXDKt38q0TbbVvqxSMazMQxvq2O4P
	U5AcECgrE97ACUQ2SLCDTscghCD55pqYh30eUMAHNQsKMMEu9iKyuhCp4C0eSyMmC+v3yo
	2Mmttj3enmNFqApEuAjjFtNV/e4gODo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-3-sUwM4CNq6A3uPHcWRcdQ-1; Fri, 27 Sep 2024 08:30:22 -0400
X-MC-Unique: 3-sUwM4CNq6A3uPHcWRcdQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb471a230so15147735e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727440221; x=1728045021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b70emq1asFc0837pR5hOySriSfg2vpMiOIzL46iGcG0=;
        b=fUuF/T9Y2NFug6akdkP9uetezLFcFRHw40sTrVls0sAzfH2GJFTCIqqpLCEVUGSEbt
         KbsfUL6mc6D1HKWmoTmoKYBGyjMp8hjORBb1e/PCmS3s5IrR5TQJ19WpkzGUqDuzhk06
         11fV33ubbEKMhEdRifU6IAA907xK27EqNeElmjheHaK4exS4weEdaVl7Ji3lG6vbP2YT
         U46GQkDY1kphhV6vEWD5N5koOkrv8CuHWnAs/CoWaGckosvaqGfjVDoIn9coqPyQ5gvH
         F6J5Um/hrB0yPBsRGL+KrTaPiaM0UMp0KDQc+Nbk958GP/QNchm2Q/aRJyzslJzRY3la
         H+BA==
X-Forwarded-Encrypted: i=1; AJvYcCXZRyqBJBg0MNrrFTIuH2RuuP5hmEvpfetuBOjkUliQ/CYwOVoH4CEBklKIm7qkQo7AkhN5IPWbi5B32MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwteqBbKPEP1bp5jhseeZ5XKSAGkhJhxgTxxZqvWmA8recTD6bB
	BhIYrUPNXpSccOJyJHeDS5hJzoeeH2AYxIOmtV5YXjmVFwMWISdDfbApJonu5Cev8cYwO53Mvc8
	J4WAcVzUpAABeHcV5Ni86k3mZpYKS6zqAneUtTxev32Hd+v52hB6GXoaGY4LmBg==
X-Received: by 2002:a05:600c:4e8f:b0:42c:b950:680b with SMTP id 5b1f17b1804b1-42f5844b9e9mr21067935e9.20.1727440220884;
        Fri, 27 Sep 2024 05:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbeKokqzPe5HzgTC9M987h8/ulPeXqAyPBJYVCgaBKlgmGQE/SiUjYvPIcdpIf0Eah4AKNjg==
X-Received: by 2002:a05:600c:4e8f:b0:42c:b950:680b with SMTP id 5b1f17b1804b1-42f5844b9e9mr21067725e9.20.1727440220462;
        Fri, 27 Sep 2024 05:30:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:8000:b502:8c1c:3624:99d4? (p200300cbc7098000b5028c1c362499d4.dip0.t-ipconnect.de. [2003:cb:c709:8000:b502:8c1c:3624:99d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f2083sm72248885e9.15.2024.09.27.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 05:30:20 -0700 (PDT)
Message-ID: <755ff53a-2727-4993-92b4-95be668f3b67@redhat.com>
Date: Fri, 27 Sep 2024 14:30:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: print total and used count in cma_alloc()
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20240926120049.321514-1-gxxa03070307@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240926120049.321514-1-gxxa03070307@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.24 14:00, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> before:
> [   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> [   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
> 
> after:
> [   24.097989] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
> [   24.104260] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
> [   24.107504] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)
> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>   mm/cma.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 2d9fae939283..fc35a86aa82f 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -403,6 +403,17 @@ static void cma_debug_show_areas(struct cma *cma)
>   	spin_unlock_irq(&cma->lock);
>   }
>   
> +static unsigned long cma_get_used(struct cma *cma)

I would call it "cma_get_used_pages()"

> +{
> +	unsigned long used;
> +
> +	spin_lock_irq(&cma->lock);
> +	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> +	spin_unlock_irq(&cma->lock);
> +
> +	return used << cma->order_per_bit;
> +}
> +
>   static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>   				unsigned int align, gfp_t gfp)
>   {
> @@ -420,8 +431,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>   	if (!cma || !cma->count || !cma->bitmap)
>   		return page;
>   
> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> -		(void *)cma, cma->name, count, align);
> +	pr_debug("%s(cma %p, name: %s, total count %lu, used count: %lu, request count %lu, align %d)\n", __func__,

I would suggest dropping the "count", or using "pages" instead. Also, 
inconsistent usage of ":".

Either:

pr_debug("%s(cma %p, name: %s, total: %lu, used: %lu, requested: %lu, ..."

or

pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, 
requested pages: %lu, ..."

> +		(void *)cma, cma->name, cma->count, cma_get_used(cma), count, align);
>   
>   	if (!count)
>   		return page;


-- 
Cheers,

David / dhildenb


