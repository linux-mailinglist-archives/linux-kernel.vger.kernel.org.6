Return-Path: <linux-kernel+bounces-523509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BCA3D7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AE73A4735
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE31F2382;
	Thu, 20 Feb 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGI1uRpB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88381EBFE0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049541; cv=none; b=oQ2FvD/izyDwR4eyK8f8ONG57KllKObjpa+m1BNt081oMDOVboHMpsIjvCxZTu7B6GS3UMXY69ItLYzO4pN2fR90wqwUCX72maM5fjX5rU9al8kH/EeIKERVwlFbzbB4fQFQUHArcTp+vdZS8eIt8Sem93OX2H5RY4H7ph1zz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049541; c=relaxed/simple;
	bh=F5wKzEP5vRrIWMVqHMdWaEgWvPjXQEljt4Rv8Cgnk84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6L69XOXWWOeybn5IDYkyq/H3R3BC7eHc9rKCJsCtjzEsYoYGfolaU6HAkWH0R4ILrPCl4lNRjTH4C9g97jFBoIYXntTiyrJnKUeNWgfPex/aoaX9KsttrfSCT+lmb3moL6qQnth9LhXoEpL2cgKt41qjslW8Og1iXR6s4HlvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGI1uRpB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740049538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lH8hZRovfEp/BEP5acQntlzmBgzDcs2Zn+aYw126Mlc=;
	b=HGI1uRpBmD7RMQNRqR5L6MNLeHuIyiQSZ9nMr7Dbzy4xro56oayXyCDL7RcWJDALo0NWlj
	EmLtyMvKRwWsBdnW4I5yq7FUJ9xmo8SeeJ+BUCAZ1HFFKQsilF0Hly3dGUQqVZL+oba+Pe
	lw1xYsrSdumj9pQz7sKRMcx27HOdQxc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yJpAVPikOAKvs5On2UMGHw-1; Thu, 20 Feb 2025 06:05:27 -0500
X-MC-Unique: yJpAVPikOAKvs5On2UMGHw-1
X-Mimecast-MFC-AGG-ID: yJpAVPikOAKvs5On2UMGHw_1740049527
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f3bac2944so314363f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740049526; x=1740654326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lH8hZRovfEp/BEP5acQntlzmBgzDcs2Zn+aYw126Mlc=;
        b=HdXgz4ovOCwNdqg+AerwR3lL4QnnDrWUu/dC42me9gTXE6kLVC+VBW+8U7B/iI6V10
         jRAU8KRLFP58FO23esGzowFZcMIUuHoKhBiAn6ouN8e+lR5A95FcAZ2fytv/Rwo9RtIS
         7ztm3zsl3t8OkENX6r5LAZAwR03Jxs+snf268zadR39xkU/tM44P9jUzFGGOAMWSh6sf
         qAVSpG9k/iARoF99jwpYPaCsm0D6VZ83J/MNaCzuZH5GVvnzweVlEu0SITRs6E8xmYZK
         s5BuOYhW4iGQpM8A9Yzif3ZJdkS69+QxGUStkLBWk0et/tgVTiDc6k8SKTWM7u5QvaQh
         UE6w==
X-Forwarded-Encrypted: i=1; AJvYcCX7nJmC7r7S2YubPD7vz30lZhijKVA6VqV6/DNe/EfqzIGWo3sP4nCp644SxW/vd0DXT6tBWiW2av3BbYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7kv9dPrLuOoDd2LUZhc2PX9Wgo2iYnEb+x0P8dcipM76W5bT
	ABwrGlD+8oTdWsF/sippYCD4nvJgT4NJLdKDFV15odaAx5pY8zULiakJOd82XIke6HzQX6hkdcP
	7KTtdKLoLe27IGj29k90kEjyCavgRjEDc/jGi0B/3OLIerHieDpOmDK2r0bvp1g==
X-Gm-Gg: ASbGncsBnQheZnTKTAQ5XDh9mRKPxGCC/t5JEAiQWRM4xh4JalP1Bthf6y/UPzmLhJk
	xSqsUTCfjzuJkzx5iV2GPXr4w2y5Nt2nRk69duSJPcOtEiFKVXyqyV6Y0u8FciTzBQioXaDRsY9
	4JrMA0Juu9kYF8w7IoYXUd9rnTaytRymbrxNtSVhdUtdCLK+N77lY+wIYZplh5hqsL8wzgCX5ws
	fBHYdSMj1NiYD2JGtSaspflqZRMZP8bxMuzUop5TyT1JNv7BS9xDHgoPswCwuh/JAhxUD3K2sSe
	c2zhZNX3al1L7Q9fiZanUSa1y6crlQTjIY2WVRDX3/BCoMpi8LngVDxBkpSjWNi+Bv+VV+97xaG
	qQVx/0l8BC/5DzwLuIGhbp5bpzVR8Tg==
X-Received: by 2002:a5d:64a3:0:b0:38f:4916:fc21 with SMTP id ffacd0b85a97d-38f587f3e7fmr7315435f8f.52.1740049526597;
        Thu, 20 Feb 2025 03:05:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyqNwGnJeS629h8BeaF+V2uQxC2fzEIpWbl8MMAGczpDyT/SRmr5r1FPPe2KdS3mTLTlXunQ==
X-Received: by 2002:a5d:64a3:0:b0:38f:4916:fc21 with SMTP id ffacd0b85a97d-38f587f3e7fmr7315404f8f.52.1740049526224;
        Thu, 20 Feb 2025 03:05:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4423sm20653252f8f.11.2025.02.20.03.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:05:25 -0800 (PST)
Message-ID: <fdef74f3-ada8-40c7-afea-9a0105f5c05f@redhat.com>
Date: Thu, 20 Feb 2025 12:05:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: page_table_check: use new iteration API
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <85f11743d259d5e4a1f47456fbcda82ff6db9ab3.1739931468.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <85f11743d259d5e4a1f47456fbcda82ff6db9ab3.1739931468.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.25 03:17, Luiz Capitulino wrote:
> The page_ext_next() function assumes that page extension objects for a
> page order allocation always reside in the same memory section, which
> may not be true and could lead to crashes. Use the new page_ext
> iteration API instead.
> 
> Fixes: cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   mm/page_table_check.c | 39 ++++++++++++---------------------------
>   1 file changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 509c6ef8de400..b52e04d31c809 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -62,24 +62,20 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
>    */
>   static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
>   {
> +	struct page_ext_iter iter;
>   	struct page_ext *page_ext;
>   	struct page *page;
> -	unsigned long i;
>   	bool anon;
>   
>   	if (!pfn_valid(pfn))
>   		return;
>   
>   	page = pfn_to_page(pfn);
> -	page_ext = page_ext_get(page);
> -
> -	if (!page_ext)
> -		return;
> -
>   	BUG_ON(PageSlab(page));
>   	anon = PageAnon(page);
>   
> -	for (i = 0; i < pgcnt; i++) {
> +	rcu_read_lock();
> +	for_each_page_ext(page, pgcnt, page_ext, iter) {
>   		struct page_table_check *ptc = get_page_table_check(page_ext);
>   
>   		if (anon) {
> @@ -89,9 +85,8 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
>   			BUG_ON(atomic_read(&ptc->anon_map_count));
>   			BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
>   		}
> -		page_ext = page_ext_next(page_ext);
>   	}
> -	page_ext_put(page_ext);
> +	rcu_read_unlock();
>   }

[...]

>   
>   /*
> @@ -140,24 +130,19 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
>    */
>   void __page_table_check_zero(struct page *page, unsigned int order)
>   {
> +	struct page_ext_iter iter;
>   	struct page_ext *page_ext;
> -	unsigned long i;
>   
>   	BUG_ON(PageSlab(page));
>   
> -	page_ext = page_ext_get(page);
> -
> -	if (!page_ext)
> -		return;
> -
> -	for (i = 0; i < (1ul << order); i++) {
> +	rcu_read_lock();
> +	for_each_page_ext_order(page, order, page_ext, iter) {

I would avoid introducing for_each_page_ext_order() and just pass "1 << 
order" as the page count.

>   		struct page_table_check *ptc = get_page_table_check(page_ext);
>   
>   		BUG_ON(atomic_read(&ptc->anon_map_count));
>   		BUG_ON(atomic_read(&ptc->file_map_count));
> -		page_ext = page_ext_next(page_ext);
>   	}
> -	page_ext_put(page_ext);
> +	rcu_read_unlock();
>   }
>   
>   void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte)

Apart from that, this looks very nice to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


