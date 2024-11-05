Return-Path: <linux-kernel+bounces-396133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD39BC84F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BD928392F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BE81D041B;
	Tue,  5 Nov 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP0GkmdL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1741CF7C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796451; cv=none; b=Q7QXLerUHsw563BeSR4lgQfdZQ0QuHeeFLLQ3mwpt8DCFJoymt5OLhrjBrRoqI3Sd7dJSXOgvjDkn98rNePimoxTjOrog3wdc3DmHbHCX1FmOlLtilQAfeOypYchqboL4Aa5FWWYRYpcy5g0iUOB18hXW7nzYinUM9URyhD76L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796451; c=relaxed/simple;
	bh=EmBSefaTzgT/+5c2+fwzv6QaVnm9UIjkSHmU9Kb+xik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/OTytcaS7bmkn2Ysp/JaC6HHBFhpuOcLqdvMYiUWtror1X1rcTAuB/U/hSf69zRFrvbfpW7Pt6syShZ4/m/a+7hXeE/U8jY3eqpt+jzZGkYg7cSuIvJ0Ij+uIozasM/FJX6SsXgpFKVBYYeRvzzpub4RHzwTPfCSMRL6FMr4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LP0GkmdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730796448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lp4A3d+7xk3DaFpMp5OemgjcjnNIT8GjSSrM/U5i5Qw=;
	b=LP0GkmdLoBlxko+xyPrfVJu3YPz1AehGe/vv2q9WqGx7ZqkCYZvzMp5AepU9c8DOl0J3b4
	48RRT79QBqoMLp+NMtvIaICnEnoEm9lheIutO4rH+YidsnVnjvMWXuV1UWm1BXzbnkyPgm
	9kOPy0ioPuGBdAGhn+Ng1hUdfmlhP2Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-H7V-t_ZrMMm5l6aqn4MIaw-1; Tue, 05 Nov 2024 03:47:27 -0500
X-MC-Unique: H7V-t_ZrMMm5l6aqn4MIaw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315544642eso38267145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730796446; x=1731401246;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lp4A3d+7xk3DaFpMp5OemgjcjnNIT8GjSSrM/U5i5Qw=;
        b=BuISMnmtrj4DrFE8oZyJWrUF67liQmdSVdkmXZDnGqE8sCZ2PXXMtkZSL7sDTHzdDj
         Nnks/iinkvmaQk8jHrYGZB04DbFIAhHbWYqu5Yxv+cJ+oFWnrkJXgU9k9BimwnMCe/F+
         IEnLJxIdbLEV82Awyj6bfmt+YiiHN6FM7pprQaCY9ohXmODfEvXTcgAB6ujPmw2wyyxp
         EcSZMP6DGamwEG3ToPdsMfsS38f8shL5JP+njEGqBnhLOtiCOVudZ33kzBGSs60NDtpU
         f9a0V1neL//Qor4vjX4I/Zy5KB95oRJCEDLytWTnyphCOKafT1zV4ksNF91TKcxPe4qX
         ZYug==
X-Gm-Message-State: AOJu0YwCZ+ucZ8F7UBf35+tzEfnhvBqadFaxixWOB24+XQyzhTkEa1/4
	0JhWhUm/MgFDyDNbwx4CR9Fn6hk1Tp2VaiZZKhuQER2MvFell9Ao+3y61fKVrL0OmDzMp0+ths3
	whLwFotbU9q5zwtxDL6kd6uwqrieg4tJSZwdMxMddtaaOaH6xNWYxS2bh6Z5S2A==
X-Received: by 2002:a05:600c:190f:b0:431:6153:a246 with SMTP id 5b1f17b1804b1-4327b6fd999mr162501415e9.13.1730796445995;
        Tue, 05 Nov 2024 00:47:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI2g1hEbbL2W+zjXyjFd0TObFa9gYDLjKxdkvOw9lD+NEnk9EKowwlN3DzC1izRc64PpTprw==
X-Received: by 2002:a05:600c:190f:b0:431:6153:a246 with SMTP id 5b1f17b1804b1-4327b6fd999mr162501145e9.13.1730796445624;
        Tue, 05 Nov 2024 00:47:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b8csm15541589f8f.5.2024.11.05.00.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 00:47:25 -0800 (PST)
Message-ID: <80500348-e86a-4b8b-94a5-1953aa4ebe12@redhat.com>
Date: Tue, 5 Nov 2024 09:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation
 call for FOLL_LONGTERM cases
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>,
 linux-stable@vger.kernel.org
References: <20241105032944.141488-1-jhubbard@nvidia.com>
 <20241105032944.141488-2-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241105032944.141488-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.24 04:29, John Hubbard wrote:
> commit 53ba78de064b ("mm/gup: introduce
> check_and_migrate_movable_folios()") created a new constraint on the
> pin_user_pages*() API family: a potentially large internal allocation
> must now occur, for FOLL_LONGTERM cases.
> 
> A user-visible consequence has now appeared: user space can no longer
> pin more than 2GB of memory anymore on x86_64. That's because, on a 4KB
> PAGE_SIZE system, when user space tries to (indirectly, via a device
> driver that calls pin_user_pages()) pin 2GB, this requires an allocation
> of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
> kmalloc().
> 
> In addition to the directly visible effect described above, there is
> also the problem of adding an unnecessary allocation. The **pages array
> argument has already been allocated, and there is no need for a
> redundant **folios array allocation in this case.
> 
> Fix this by avoiding the new allocation entirely. This is done by
> referring to either the original page[i] within **pages, or to the
> associated folio. Thanks to David Hildenbrand for suggesting this
> approach and for providing the initial implementation (which I've tested
> and adjusted slightly) as well.
> 
> Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Junxiao Chang <junxiao.chang@intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: linux-stable@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---



>   
>   	return ret;
>   }
>   
> +static long
> +check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
> +{
> +	LIST_HEAD(movable_folio_list);
> +	unsigned long collected;
> +
> +	collected =
> +		collect_longterm_unpinnable_folios(&movable_folio_list, pofs);

Nit: We're allowed to use more than 80 characters :)

(I would prefer the old way it was split across more lines if we really 
want to split; this way here is less common)


Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


