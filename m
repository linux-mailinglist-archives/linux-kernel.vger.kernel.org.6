Return-Path: <linux-kernel+bounces-219000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9447B90C89A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58889286A88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836C1ACE83;
	Tue, 18 Jun 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1/cz+Ir"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AD1ACE7E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704546; cv=none; b=Zsj1szKAH9asVOLNwnKmvznDOrOM8pwv39iOHg0YE5zlIv8G2Tj2W493JrtgKbZTh2D98FXJ7Yh9BoElQ+6v1ZAlL0oK3R7QztK/moubiGMGLAVhqsmhLuNApSdzwdYXetNUlCBe6EzQ2G+++L32j/RFLt8pO2JGfrCY7HhnqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704546; c=relaxed/simple;
	bh=9EIdu6DrIa6ZWsaXOBjxRIzxgq95rZNp413XtZFFnK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7MW+gHbsOgdkv37HSQ7Se399abY3h7wJc8BHMIXt+2+Xl5BYpREN/wXwzTg6c2HvPx63c/hNElAMQyfSGlMrKl+Q8rxA0XZuF6eTmZYqz3WK8X+ln2Ctx21KgcvLxOz3X63oYQ0j53Zb2mKm3zcZRWe7aEupcRqmjo/NbmiAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1/cz+Ir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718704544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z5YI0xydh0ov76+FamwJ/hbbiesyq6lQbps4wdHRql8=;
	b=a1/cz+IrVjZG3HWfbl9X60UUGemwXhosYcn84zmxUuBaYVpLj8h5BsuhVScqQ5tarHrOiS
	GvOB0AVZttz95FODgqnLtQEaAuvcGFWXR3TFrw7lYopm8WYrPGrQ9NgqUFgfeYxz7SMgsV
	4+RNcNoxGwm0GsBX1S22X4/E5K3he/k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-LtCOw5N7NEy_-3hvrNTN6A-1; Tue, 18 Jun 2024 05:55:42 -0400
X-MC-Unique: LtCOw5N7NEy_-3hvrNTN6A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c94ad861aso4116480e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704541; x=1719309341;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5YI0xydh0ov76+FamwJ/hbbiesyq6lQbps4wdHRql8=;
        b=KMJmEjtxsaxB8vhT+rTuLgByeYZCogTYC9XML9k/sPCe37x0Sd5DV2yiy8jm0jF4FX
         Iaj4YrdvvXQs4pN1j9rF7fwzSPj71Rm1rQsIR0DtutpJts4e7HjQA6+ETtfK+JKkmcWr
         1CKBGEliHJ87zx7D/ZodV3ryUKu+fXXYVzXYMSS1MvwCHIPJJ3FZwwpHA94P8FOhZf1w
         ZytRi50NWg2Cu/VWMp7xMXOpf9TO35b9q6d9LMOInjFX2k8eJukUlycjArYTYCSl/rOP
         LwFbRSSyWcXYFH5RiEotqsdESX4EHuywWCELjHpv2iAMV1lbWeJ99yRJtatXJNAcUB8w
         1kaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUnXbm1ff4NIFQN7B4IxxGDXnvZjGPXq5YgCvzHAhQrVaP3ohQVUgmgnzF6Dqe4zzzzra7LNMYPE4QKZTyZm9B/Ogj4zvsDn3g/nxU
X-Gm-Message-State: AOJu0YwfY2EvqvZ6B3ovBGR2F5uRfxVECrTLS6ksESP1h2sYDcWbXjL1
	pus4ub23RXFfY7iCG6IU5OaGuImDNnsGfqcF1p3snCgU4JXKD+H456pdCG+OnJWAnXA2iBPqO/Y
	xX0ZBnmtPz6S9hHVSDA3yiP2YG7wN+D4heG6fE3olOupLf94HsJDjhfDXupfMAw==
X-Received: by 2002:a05:6512:2803:b0:52c:5925:fc9d with SMTP id 2adb3069b0e04-52ca6e91e8bmr8881732e87.45.1718704541079;
        Tue, 18 Jun 2024 02:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUyzt/BRLVaWoSSFFyk+Io1RCvpoKcwPlM3m4GASbG4LK3I3KVQJy3llQsTPnUUYQz5lJfAg==
X-Received: by 2002:a05:6512:2803:b0:52c:5925:fc9d with SMTP id 2adb3069b0e04-52ca6e91e8bmr8881715e87.45.1718704540575;
        Tue, 18 Jun 2024 02:55:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe8fb8sm223290305e9.11.2024.06.18.02.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:55:40 -0700 (PDT)
Message-ID: <171f18ed-3fc7-47c8-8aef-d4ab31f55be0@redhat.com>
Date: Tue, 18 Jun 2024 11:55:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: remove folio_test_anon(folio)==false path in
 __folio_add_anon_rmap()
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
 yuzhao@google.com, Shuai Yuan <yuanshuai@oppo.com>
References: <20240617231137.80726-1-21cnbao@gmail.com>
 <20240617231137.80726-4-21cnbao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240617231137.80726-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.24 01:11, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The folio_test_anon(folio)==false cases has been relocated to
> folio_add_new_anon_rmap(). Additionally, four other callers
> consistently pass anonymous folios.
> 
> stack 1:
> remove_migration_pmd
>     -> folio_add_anon_rmap_pmd
>       -> __folio_add_anon_rmap
> 
> stack 2:
> __split_huge_pmd_locked
>     -> folio_add_anon_rmap_ptes
>        -> __folio_add_anon_rmap
> 
> stack 3:
> remove_migration_pmd
>     -> folio_add_anon_rmap_pmd
>        -> __folio_add_anon_rmap (RMAP_LEVEL_PMD)
> 
> stack 4:
> try_to_merge_one_page
>     -> replace_page
>       -> folio_add_anon_rmap_pte
>         -> __folio_add_anon_rmap
> 
> __folio_add_anon_rmap() only needs to handle the cases
> folio_test_anon(folio)==true now.
> We can remove the !folio_test_anon(folio)) path within
> __folio_add_anon_rmap() now.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Shuai Yuan <yuanshuai@oppo.com>
> ---
>   mm/rmap.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2b19bb92eda5..ddcdda752982 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1297,23 +1297,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>   {
>   	int i, nr, nr_pmdmapped = 0;
>   
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
>   	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
>   
> -	if (unlikely(!folio_test_anon(folio))) {
> -		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> -		/*
> -		 * For a PTE-mapped large folio, we only know that the single
> -		 * PTE is exclusive. Further, __folio_set_anon() might not get
> -		 * folio->index right when not given the address of the head
> -		 * page.
> -		 */
> -		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> -				 level != RMAP_LEVEL_PMD, folio);
> -		__folio_set_anon(folio, vma, address,
> -				 !!(flags & RMAP_EXCLUSIVE));
> -	} else if (likely(!folio_test_ksm(folio))) {
> +	if (likely(!folio_test_ksm(folio)))
>   		__page_check_anon_rmap(folio, page, vma, address);
> -	}
>   
>   	__folio_mod_stat(folio, nr, nr_pmdmapped);
>   

Lovely!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


