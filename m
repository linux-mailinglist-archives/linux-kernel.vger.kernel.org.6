Return-Path: <linux-kernel+bounces-296178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE595A6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A52C281C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCF178361;
	Wed, 21 Aug 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhcWsIsE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF513A3E8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276086; cv=none; b=WQzUfSojt5O5CE8MR9NhCVdnGWqAT3RHU0OfvCYSMCWg9Jf4ywjzxY9//H3eglpQVeY00xPuGJGqTCULh2vSNN2cPNO5E7XEVrSKvOJkCQdLTlM+l2jrExokeG+4ffOK/7Q9tn4leg6hYm6uG8fYCuDxDEBUdKi7JqyZdXsK37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276086; c=relaxed/simple;
	bh=pI1z0aMFKJiKisJvAxQ3Ch3hUKwYtDumCCD2V1g0wIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdz3z8Pvlaf0icgErPBoiu2hVxI3dMsSi8D+HSegKIIRXoFiQL9Z44f4RMx/Rig9uzqh1QP/l06xoAfvyU7EctdoWBANuYBmqvlLLlkg2CE1n16Vdu/jYu7PpAxHWFRC9hCH49M0ZomD21oegmgMasUpd2ajZx0WPASs93jhoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhcWsIsE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724276083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L9SRPOtEYa7Vq9IzjmCle+ZKcbGVaJuocm8tqYqXS/s=;
	b=GhcWsIsEZpFnJaCsM5kiD6wkm63zLk3UqvqYU0pxcXdBRB8u4LtnyOIY4CLaSoZbYHWf7l
	Ynh33iY2ohSrZRTD8QqrCjdM8NWlk1pH15zFAb+DkUwZE03aIEUAZVlm7Ubf/pIZZ+jxv0
	Q1bi37jR/Ho/RG4P/ka2y3gGlaypEj0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Acc_ZP8mN-eSEKp1XVY_Xw-1; Wed, 21 Aug 2024 17:34:41 -0400
X-MC-Unique: Acc_ZP8mN-eSEKp1XVY_Xw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280a434147so455845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276080; x=1724880880;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9SRPOtEYa7Vq9IzjmCle+ZKcbGVaJuocm8tqYqXS/s=;
        b=RIdE6QuAU4/Z0nJB+fNhm8HIvPbI4sH4U7YGkgy9OucUumywDIhKsAgpyfBsNPNpIe
         N7t8b64BKosgW5x8nwqS7IPmRyMNzlbTr68SAzN7HoETPJRs40CX9UBwCeHPa09s3g+n
         FOiw65qXPhIcQvaRQi1R37WyNaqWDymXkUgIZE1aU+I3xBKOlnUO/nbKYfzIDvvNqzhV
         HLQRnYt8IJYs+Et8V8wfBc8XgifHor57CnYQnnzP1g0b37G3d9B/yL2DpB+q3w8De82u
         V+FS294MFkKZW8L4dd7dMIgB6QQYq8eevsY6YAepg3UQxAOVE9VtaBDupMyPYQbesUXR
         hXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPbh+rnBEOfqsZ1+aWExdpq3FPCHcWgwZgNJ8Vjtlxu024jMYyVG5+pbLiRbqYR1rlhuetc9V5NreKFqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWIzFxY1YscsazmBOgqF1dvtx76PFvVB8oALdDfjGfpQ0X+wH
	nwAeV5SgivIIgoXUGfc7Npi1iXZZGT3arLjyS49a2t0WThNakH6KPJO+5C6RtIh45AlB2dmXwtn
	fwKNIHEvX86tUIkDjFQtVqNcQP65K8G0b4pVOqudnovAqHbzOR6+vHjuHP/XQBA==
X-Received: by 2002:a05:600c:4e91:b0:428:9ba:39f with SMTP id 5b1f17b1804b1-42abf050ac9mr19897805e9.11.1724276080517;
        Wed, 21 Aug 2024 14:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFdo1tyDR9h9u6Fe4Cg5JrjJXAZ+0S4BhkG3v5X7DVND3RUng/BMfFJTGsVag10PxZdUBhHg==
X-Received: by 2002:a05:600c:4e91:b0:428:9ba:39f with SMTP id 5b1f17b1804b1-42abf050ac9mr19897585e9.11.1724276079602;
        Wed, 21 Aug 2024 14:34:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734? (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de. [2003:cb:c705:4300:16d5:c5b:8388:a734])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed8b848sm39449985e9.5.2024.08.21.14.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 14:34:39 -0700 (PDT)
Message-ID: <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com>
Date: Wed, 21 Aug 2024 23:34:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: collect the number of anon large folios
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com, yuanshuai@oppo.com
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <20240811224940.39876-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240811224940.39876-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.24 00:49, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Anon large folios come from three places:
> 1. new allocated large folios in PF, they will call folio_add_new_anon_rmap()
> for rmap;
> 2. a large folio is split into multiple lower-order large folios;
> 3. a large folio is migrated to a new large folio.
> 
> In all above three counts, we increase nr_anon by 1;
> 
> Anon large folios might go either because of be split or be put
> to free, in these cases, we reduce the count by 1.
> 
> Folios that have been added to the swap cache but have not yet received
> an anon mapping won't be counted. This is consistent with the AnonPages
> statistics in /proc/meminfo.

Thinking out loud, I wonder if we want to have something like that for 
any anon folios (including small ones).

Assume we longterm-pinned an anon folio and unmapped/zapped it. It would 
be quite interesting to see that these are actually anon pages still 
consuming memory. Same with memory leaks, when an anon folio doesn't get 
freed for some reason.

The whole "AnonPages" counter thingy is just confusing, it only counts 
what's currently mapped ... so we'd want something different.

But it's okay to start with large folios only, there we have a new 
interface without that legacy stuff :)

> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>   include/linux/huge_mm.h                    | 15 +++++++++++++--
>   mm/huge_memory.c                           | 13 ++++++++++---
>   mm/migrate.c                               |  4 ++++
>   mm/page_alloc.c                            |  5 ++++-
>   mm/rmap.c                                  |  1 +
>   6 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 058485daf186..9fdfb46e4560 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -527,6 +527,11 @@ split_deferred
>           it would free up some memory. Pages on split queue are going to
>           be split under memory pressure, if splitting is possible.
>   
> +nr_anon
> +       the number of anon huge pages we have in the whole system.

"transparent ..." otherwise people might confuse it with anon hugetlb 
"huge pages" ... :)

I briefly tried coming up with a better name than "nr_anon" but failed.


[...]

> @@ -447,6 +449,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   	 */
>   	newfolio->index = folio->index;
>   	newfolio->mapping = folio->mapping;
> +	if (folio_test_anon(folio) && folio_test_large(folio))
> +		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>   	folio_ref_add(newfolio, nr); /* add cache reference */
>   	if (folio_test_swapbacked(folio)) {
>   		__folio_set_swapbacked(newfolio);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 84a7154fde93..382c364d3efa 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1084,8 +1084,11 @@ __always_inline bool free_pages_prepare(struct page *page,
>   			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>   		}
>   	}
> -	if (PageMappingFlags(page))
> +	if (PageMappingFlags(page)) {
> +		if (PageAnon(page) && compound)
> +			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);

I wonder if you could even drop the "compound" check. mod_mthp_stat 
would handle order == 0 just fine. Not that I think it makes much 
difference.


Nothing else jumped at me.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


