Return-Path: <linux-kernel+bounces-268848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946FE942A33
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA5285C24
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242991AB502;
	Wed, 31 Jul 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMZW1Gd2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD32208A4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417470; cv=none; b=Lu7h/UZou18DQushxYDfmzZ6F5rY5Mb/QnPMZzEnA8FPRCtUugR0Ltn0WgL7pWWIUAS0uF/xoBpzgXzgVHHpSfkrw14qRcl9DKhSxs5D+Jsrq181AjtUuCjAn54CMb61V/o7KgIhCdW1xz933uUBoC1v3dHV7K4QM7tLxyy/gwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417470; c=relaxed/simple;
	bh=okjICwl915IzSUgSJ9h0JPC+vPjLombGNfP4KeD2D5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqrRGCnG7pkyehxBZuG42GT34i+lsDm1ZFXF3n3E5meJ+1whEmf/hXUm0eF4X41jZRMnQPCrT6jjmgyXC+AvaTjiEd6whjRV2pYLojSaYmZN5MoHI0KcIFYc363LFCEYHhWEwtFKFnZzQt9i7SgIE4iVSNKG/+LP4JWCA586qKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMZW1Gd2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722417467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDE94ttAmSeZaBo4E5VKbvpN4U6EyPy1h2kJNjBGAF8=;
	b=EMZW1Gd28eVZ84bNyhhSBxttRsjJsF2kTgF6tGgF8obFtqUU1T6szHqeDj2jjIlmbsmJFn
	c9yjW+WlAdyzZWJeVqJtZsMxPH4wwxF89EBGZKxag60IHdclTsqZl4EpZWnkeIUR8jINu6
	I4nsdmCzTWEWsYxwkhEluGWfuT8QehE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-_P-ropSFOiOuID6IKz7Egw-1; Wed, 31 Jul 2024 05:17:45 -0400
X-MC-Unique: _P-ropSFOiOuID6IKz7Egw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3684ea1537fso2684078f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722417464; x=1723022264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDE94ttAmSeZaBo4E5VKbvpN4U6EyPy1h2kJNjBGAF8=;
        b=by2/t24lz4RIuP3QTRqO3KpWl7/RgP5/1NK04QZ9JT0p5L5lYTw1vFx+K3zYXnoVon
         E0T1NGBa6+u+j8nEdhreHG7Q+ftGVgpbRSTtxwcBKroRnPGkZNr3BIa091uzyIYLHYnw
         4nNEZF1NvqHNtguiXSBYNQPIJ0NEwokHWMDBFL/o8Tl86Idxb/4pi1rVbyQPFRBKdIJ5
         k/iJf4wZvjHDPGZ05RhooAHpSn8D6QMVw06IKDLmDbsPDNE8hnzgiPR50HEcaTywyv8V
         LxIc+nkyWubGIvd9doxi+Jid/W4kTfEUYX2csseK0iffzUAQztUEhoZfHTNIlOh3uNwW
         QLNw==
X-Forwarded-Encrypted: i=1; AJvYcCVtTEWVlhJp+YRqYxUrTz5fdmOc4+nx3jPhg/ChazqbtxYjYYHwTH04cPyPszW688dtbXrPM1ygZoJoT/ayAntlYNoCE7YaSvTLkAU7
X-Gm-Message-State: AOJu0YzMX8RiEujWQNvBd0/UUuzsEs6bsatM5svjRtt4479S2DE1YB/F
	SoeHRY2b9ya1G47S30649BqE0fLSEk6lUcm/2iby1t0w6ddZLCWFQiRVN3BqwLfpIwNf6KAA3I/
	+GC+FB6izENIzim1YDC1uc3jWcLumcP0F3So54XWMqarQ4bb2YYpGO9ZxpsCyYQ==
X-Received: by 2002:adf:a188:0:b0:367:97b9:d5ed with SMTP id ffacd0b85a97d-36b5d0b0959mr9948696f8f.9.1722417464495;
        Wed, 31 Jul 2024 02:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXq4J7fR+jTjcwE40Onq8d8tUKj9c75MzvlyIdbr/reJom+fLTDjGVDxLA5sSJg4f53jQ0iQ==
X-Received: by 2002:adf:a188:0:b0:367:97b9:d5ed with SMTP id ffacd0b85a97d-36b5d0b0959mr9948678f8f.9.1722417464049;
        Wed, 31 Jul 2024 02:17:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49? (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de. [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36861b29sm16501584f8f.93.2024.07.31.02.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:17:43 -0700 (PDT)
Message-ID: <450360af-9222-4251-8529-f44c4b8b498a@redhat.com>
Date: Wed, 31 Jul 2024 11:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ziy@nvidia.com, gshan@redhat.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.24 07:46, Baolin Wang wrote:
> Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size page cache
> if needed"), ARM64 can support 512MB PMD-sized THP when the base page size is
> 64KB, which is larger than the maximum supported page cache size MAX_PAGECACHE_ORDER.
> This is not expected. To fix this issue, use THP_ORDERS_ALL_FILE_DEFAULT for
> shmem to filter allowable huge orders.
> 
> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2faa9daaf54b..a4332a97558c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1630,10 +1630,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>   	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
>   	unsigned long vm_flags = vma->vm_flags;
>   	/*
> -	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> +	 * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 that
>   	 * are enabled for this vma.
>   	 */
> -	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
> +	unsigned long orders = THP_ORDERS_ALL_FILE_DEFAULT;
>   	loff_t i_size;
>   	int order;
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


