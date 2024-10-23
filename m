Return-Path: <linux-kernel+bounces-378712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EB9AD446
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D714286DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027C1D4340;
	Wed, 23 Oct 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXq43cm3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744151D2B3D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709430; cv=none; b=Idqxv7LahMoa6QZZpHlQ0g8lEocBs6RtPrvSzh2M4dCxbGLSUtqkEao36oJC/YKKLEq5b5gEothW3NCJDeeOL/nzVR3Xrslb4g/rMyDsbx458PD8TAB5QPQDM/0X7FLwjS06LRtMgGtubo6Lvf1z8POEmLJe0KXydD6ZZPSMOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709430; c=relaxed/simple;
	bh=0MSK6pPABqBtmce3T9II/Ylr88oxS22UsdZ+9/3Yzds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOb113wHQgBziSqPCzJEr5mkHH9LFLUvaSV0mwpFLOQSTECcRxKzZ2cep1HggnJ6j0mcm1cI+hIh/VSOLbI4lmhKjJLT2b7+rcGm4UL2CbPy+mglVwR0D5a16xz+rtOvdVhWDvVTOvWex5gUNAmtkJm7vXTRG3lm1dJUFFBpt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXq43cm3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729709427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qmPSKp0YLHjUOyqd82hGayDLVrh/DCNFeJf+SQ6VSaA=;
	b=bXq43cm3SwGa6aLEwP/BQ44rQWmDFgyYAbCarLDYF6iwukfcB3/gkncDqEu6ozp5YQDPxR
	e/5fbmvscwceAYgDP47wxmNxJO0RZZsqnmBRztGikND9HwmwZkvv3PNjqNaPtxsxjIgzpw
	MVG2qI0Qvd8VOd9gXbBqR8V/47ob0SA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-x-f00-H2Ok-K7iY5lr8UcA-1; Wed, 23 Oct 2024 14:50:25 -0400
X-MC-Unique: x-f00-H2Ok-K7iY5lr8UcA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d563a1af4so12145f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709424; x=1730314224;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qmPSKp0YLHjUOyqd82hGayDLVrh/DCNFeJf+SQ6VSaA=;
        b=J3hOoQHFShJjXZ77J9xFXbNVqFQ+17GnO3QpGhR6WR7vkDfS+ZC4M/HWSqWzo/2A/1
         XmjwO1uwtPh4lSeriVZEynBvD3wGqZcaTiY4AnsVsQ3sa/0rUd3A6nCVd+eB/6WOvj2/
         9/BfEVNUvSsFyzFzx7oQ8mvIawM3l111edN2oKIz7K0fqCqwwBHtqede/yknG7Hgbn4I
         qecJv3khybC+P6mkspt0R0JbQX24wxQr7KmYcwvzDhT/UnetFiWzxBcbc1fAaEQCmcC6
         rZoqqe3ttNpfWz8sCB4jwwYCBj8rrCXGh3loVGoVXOl84c6Z1EZfn05lCqBWZaSIlpnL
         65nw==
X-Forwarded-Encrypted: i=1; AJvYcCUz5wLqrRCrHqkZ5AjCiUZsL9QZgCiLx2SBx1lmY6M6PxSlpnmlkgoFCgUdC7NDgWKl8YGHNcgLMfZXm30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gsMKVOzS1LH5OmZfEXM+so/tUES/rYeIPdjNv9ah1TCA2z+z
	Gsi/K1vg9Dc/Fq4z5EsI8gRnBhB5tvjY+IOK8hH/WnCX9xJfqEF1t/w6MXUVD/9zEGFSXTYMP4Y
	Gvgglene5fktk0/0NXoO/RloSsTRFH+Y0SbRLvffdQkhLuJyVwgjFwLhz3NbWZg==
X-Received: by 2002:a05:6000:dd1:b0:37d:4cd5:ffec with SMTP id ffacd0b85a97d-37efcef5609mr2226616f8f.2.1729709424651;
        Wed, 23 Oct 2024 11:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCB1tgfWSe/u39zeAbh2oZnmODTCV3s3IHynsl+a1e6iFCYYt/Y62YkQ4Pzzw0Zk2XHgEb7w==
X-Received: by 2002:a05:6000:dd1:b0:37d:4cd5:ffec with SMTP id ffacd0b85a97d-37efcef5609mr2226587f8f.2.1729709424224;
        Wed, 23 Oct 2024 11:50:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bfcfd0sm23625305e9.26.2024.10.23.11.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 11:50:23 -0700 (PDT)
Message-ID: <99d0e61b-9408-490c-8634-f44cb2487d96@redhat.com>
Date: Wed, 23 Oct 2024 20:50:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: avoid VM_BUG_ON when try to map an anon large folio
 to zero page.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: usamaarif642@gmail.com, baohua@kernel.org, cerasuolodomenico@gmail.com,
 corbet@lwn.net, hannes@cmpxchg.org, kernel-team@meta.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, npache@redhat.com,
 riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org,
 ryan.roberts@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 willy@infradead.org, yuzhao@google.com
References: <20241023171236.1122535-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241023171236.1122535-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 19:12, Zi Yan wrote:
> An anonymous large folio can be split into non order-0 folios,
> try_to_map_unused_to_zeropage() should not VM_BUG_ON compound pages but
> just return false. This fixes the crash when splitting anonymous large
> folios to non order-0 folios.
> 
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e950fd62607f..7ffdbe078aa7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>   	pte_t newpte;
>   	void *addr;
>   
> -	VM_BUG_ON_PAGE(PageCompound(page), page);
> +	if (PageCompound(page))
> +		return false;
>   	VM_BUG_ON_PAGE(!PageAnon(page), page);
>   	VM_BUG_ON_PAGE(!PageLocked(page), page);
>   	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);

Would read nicer in 2024 when working on folios ;)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


