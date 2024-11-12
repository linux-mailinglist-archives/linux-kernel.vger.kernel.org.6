Return-Path: <linux-kernel+bounces-406374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5369D9C6076
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E07B2FF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D672076C1;
	Tue, 12 Nov 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw8Th6np"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B22076AB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430838; cv=none; b=cmfu+cJSj6PT5N5lQAxMA+/mVxw5ogifHYJ3iaIKrAHLo7sHO/l+o+U+daAdKsMVHND4RUAUsSKqfvXkELtsdtf/KbID51EgP7COcGGhnnqaqpBg20vBy0FjEMSLbTVqdmPgg6WoaIrdda5TkLydfZDSJpLPXlOBdDhiDDn5rSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430838; c=relaxed/simple;
	bh=WCJLjzzIDo2SIMGGlZx47qliX29OqtDvchGG6G+j3Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwIL/ioqyZG1hWkD8Bs65oh0eN2Laz+fVNOujB7jcCxaYgrzU0HAB0tMe/3U+0oH79Va5Lg3VBtkT015loHL7CDiSSnT8ruMCqxZCONFpBmi0wSuGUjXTH6kIyLjSNwqikJfe1+Zl4EVWTpz4ZhwyOssICo2J6Rw7xizGtUdjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qw8Th6np; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731430834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VUfaWShBFhg60HF7n2Oymzj83fsTHFbg7DkrS32qcoA=;
	b=Qw8Th6npFwQqSlBZejYu4ene297qIkYnwNt3S5QkCgFRjsFOxBLdLTu8XgzqKR1XLi4W5x
	l7YKzI7QhwNPj/0frxWvQho/9/oLVqXfCxSl6PwUa7pqmmZROSBC6HfMbxmXdmvdG3vZ7L
	gG8pGr4rhHLHGOUg8GVU0NjpxJD1x6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-oKKt6BF1Nl6vvt_QSitvrQ-1; Tue, 12 Nov 2024 12:00:31 -0500
X-MC-Unique: oKKt6BF1Nl6vvt_QSitvrQ-1
X-Mimecast-MFC-AGG-ID: oKKt6BF1Nl6vvt_QSitvrQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43152cd2843so39409745e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430830; x=1732035630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUfaWShBFhg60HF7n2Oymzj83fsTHFbg7DkrS32qcoA=;
        b=kkJRV5P7Uq8TQWGsD3np1qVtTAGwWEQ+txWsQ2uWf5bAffx734+9l+1dlnZfuzCYYx
         mnYv2ftfD82KwAmBfFRCdt7Ip8BckQlOaJrqycVDfsreNhgC+rKGgG190oZK7NswaGJp
         +IXsKv6lf5dV9RSoQO4R6TrL4AOocLK6YvJStdNRG1f1+km55TGT8ciC4IejNWCEcVBv
         B2jv1a9YV1stlZNH9POnIuqbPJIRUe45mDzr8DGv9yF1O3Ff4i4uh+68QGFzwOxkBKeL
         1TF7cmzM3cNkzVb5hr9bgkOUAFDkXkjlrwkBMBuLVuUDop53md1JJrjs26pKgRwnTM/H
         dnTA==
X-Forwarded-Encrypted: i=1; AJvYcCUmf49XzfdD4B9Jg9q5xDTjJ8L6AiYUXXvg3euD6F3QpMWVEJ7/TrptyEgxVx+xl/J2+i4jK+lF2GCS3Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfV6uJtqRMOOg5VRTXTWnqDApJz2qdIHOJwn8KhluU1g6kuGc
	0AMQkthHRJM3TLgJh+/1hcDs9zFcSNKSNO8dFFPu07OUPQbKlgpQgQhXECivryFxrGqWbyjKB8Y
	CsQxH4xhwVOwZcjhVwogn0Owe/P6nwV/eLSmXIXJ7IKoMN18EU6AowBjGNd1Zgw==
X-Received: by 2002:a05:600c:4e50:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-432cd47dacemr29787895e9.31.1731430829535;
        Tue, 12 Nov 2024 09:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZBQDM3m3GBVIewAYn6OeK9My0ngUTS4oqIGs8ceDQed6Urf2DsL+DX18U4Ccid/zFZcPuTQ==
X-Received: by 2002:a05:600c:4e50:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-432cd47dacemr29787465e9.31.1731430829114;
        Tue, 12 Nov 2024 09:00:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054c179sm213460315e9.18.2024.11.12.09.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:00:28 -0800 (PST)
Message-ID: <db3cd6c1-03d6-48fd-9591-ab3e90d7e10f@redhat.com>
Date: Tue, 12 Nov 2024 18:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
To: Qi Zheng <zhengqi.arch@bytedance.com>, jannh@google.com,
 hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.24 09:13, Qi Zheng wrote:
> This commit introduces do_zap_pte_range() to actually zap the PTEs, which
> will help improve code readability and facilitate secondary checking of
> the processed PTEs in the future.
> 
> No functional change.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>   1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bd9ebe0f4471f..c1150e62dd073 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
>   	return nr;
>   }
>   
> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
> +				   struct vm_area_struct *vma, pte_t *pte,
> +				   unsigned long addr, unsigned long end,
> +				   struct zap_details *details, int *rss,
> +				   bool *force_flush, bool *force_break)
> +{
> +	pte_t ptent = ptep_get(pte);
> +	int max_nr = (end - addr) / PAGE_SIZE;
> +
> +	if (pte_none(ptent))
> +		return 1;

Maybe we should just skip all applicable pte_none() here directly.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


