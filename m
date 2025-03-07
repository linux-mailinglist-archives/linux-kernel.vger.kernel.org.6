Return-Path: <linux-kernel+bounces-550634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37336A56240
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E68B1897316
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE10F1A2C0B;
	Fri,  7 Mar 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGTdJB3G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BA1A3162
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335061; cv=none; b=hurRKdhWoWjNea9eifAPHe6JjVaHk3a23+8lI36KMzPpbKIHqCdSg5im4x11Wg9Q/Q658ZTp84Imac2YbigGBxwfWzsfesfPnw2czm7jdU0ShhJRyWDxwK8h3vxIgVXagLaafp7ttfp/c5bYHFT+zkj0xBGGWxQJintdcepUDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335061; c=relaxed/simple;
	bh=nGnmSZMvzzXj/JyVXyljLmmrQBwjG+ZBrxM491q1p+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy8ZvIJwXEholN7pSAhZC44ri6rJuxm8I1BDX+omhnPiAh1CCyWuKL/3hferLEnDnKbFrG12mrpTK92J1tAu7b7Stft9amXCkRivkjnwf7Dg4ufiry8u5b80sUVT2FWldw7FoEwqwO0cZHK+2jpWQs5A01m0DlYjuBZFVmzmQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGTdJB3G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741335058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mVfWQB0NQ+MbimPhvRavFkJGs3945QyRHOG2gnewxc8=;
	b=LGTdJB3GL0IIfQfARK5WgUX29Q1EAIR1o4N2jHC0RfUhyu0PLck25grp/eY/HE8SBGQRys
	uxA0aO5Do8yuNHMTDZOrAtOm5ghYXCaRiVfw2ouJP+LlcxbET5miwHb2mA33lCB5CHVWZR
	pAoTd/zJgBuhnumYf8xX2MRvZUrj5sM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-XzBf-10tOwCi7BJJIoWUYg-1; Fri, 07 Mar 2025 03:10:56 -0500
X-MC-Unique: XzBf-10tOwCi7BJJIoWUYg-1
X-Mimecast-MFC-AGG-ID: XzBf-10tOwCi7BJJIoWUYg_1741335055
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so125521f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335055; x=1741939855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mVfWQB0NQ+MbimPhvRavFkJGs3945QyRHOG2gnewxc8=;
        b=R2C4yvDq9qo2HzQxPd+MSYHgl+vn2fEOEEqtynh/QLryPwO2GHkMMk9gFbfy7ukg0w
         uSxejBbcCHXzLpq3sh3XajKWrvwje97BFsJbg8UAy9CDaxUc6ZJMhccIMds9Q+KIIqqQ
         wZ55y5eDSHttRP60SkxYe2xTT+ekIG0ZqiBvG/uzXwL5JdYuAy1zC3SCYnJm/nhA6crW
         TGxABPS1SF2VsNg2u64BGLAXs3EWJnacb264CbjAVN/NneBrnPepTVBIylm/fgH+VdeC
         Db+gFVNc4SrYp5GUwSSygCfM9yfINBYMgSqujLUopKL5375fYgSnf/j4UJVbjNujyBtX
         DScw==
X-Forwarded-Encrypted: i=1; AJvYcCVxmmJD6e1z27XApQm0eUvMMZ41IYEK5JtrqG4r+LiemIdFZbMEExAiSluB/6S15DV8YQ/yVIhlXC/j0iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8n1qtVQiOiOJoG44+2qjIl5XSn3e9o1J0K8d6dGuDRW5deH/u
	kfoUvctCcUE5MeGT5880q+M9ePrP4gqugLHdFmI0B5x7UXiVGCApopOC5dYZPgmHVnpB63iU2sw
	SZtWeHsydP3+OAitF8Sx9TOegyZnBkZonP9f40X6w4wiGWeKfpGLZzODFSe9R4w==
X-Gm-Gg: ASbGnctVTUu6ri6gQnCB9A/B3uMnaVdzF0P+6SgLfQRVE2w8qUmJhD9Fm1VkOq0tgI1
	B8bo4UjIa4vut/X62wsUiFBIlFJRFlvX8nj032kUui4yeFXtSbnqrlZxcK7dVBnPgeY1BPLazyY
	E2xBnPm9CSi9G2ziI9MH6CP2BKl6QeSlkBqHDbl0k+C5mAdLKmyzrwun62SggzacB3Lvv753PL1
	qOUtpnvZRWOWoc0aIQbZGbXYexsCBpnHmBRg1Y4xQvq7F1dBWMjRoe13zrRp7I9p6csMU5H8UZG
	CDu9sWG6QMu1sok/FXPPCZbLTKTqvJWIkgwMhXi4lddCQazAOdiwR8fgcRxvLJL+Wfp/+BSw7hB
	QQbd4Wyfusys1TU67qFbYl71IDlM58LmrliNLhA==
X-Received: by 2002:a05:6000:1fa9:b0:390:f9e0:f0d0 with SMTP id ffacd0b85a97d-39132026f40mr1610104f8f.6.1741335055430;
        Fri, 07 Mar 2025 00:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2hm+zGObhlUKR0rZFQq8y9c7sla/GE6/dcqjXIzrKlU1Y4X8O4R9N1msf3h3U8Fmgkl4U2g==
X-Received: by 2002:a05:6000:1fa9:b0:390:f9e0:f0d0 with SMTP id ffacd0b85a97d-39132026f40mr1610086f8f.6.1741335055049;
        Fri, 07 Mar 2025 00:10:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17? (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de. [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103290sm4461424f8f.87.2025.03.07.00.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 00:10:54 -0800 (PST)
Message-ID: <264e859c-820f-4001-b5b7-d4011fcbc192@redhat.com>
Date: Fri, 7 Mar 2025 09:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: page_ext: add an iteration API for page
 extensions
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1741301089.git.luizcap@redhat.com>
 <a45893880b7e1601082d39d2c5c8b50bcc096305.1741301089.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a45893880b7e1601082d39d2c5c8b50bcc096305.1741301089.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> +++ b/mm/page_ext.c
> @@ -507,6 +507,19 @@ void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
>   
>   #endif
>   
> +/**
> + * page_ext_lookup() - Lookup a page extension for a PFN.
> + * @pfn: PFN of the page we're interested in.
> + *
> + * Must be called with RCU read lock taken and @pfn must be valid.
> + *
> + * Return: NULL if no page_ext exists for this page.
> + */
> +struct page_ext *page_ext_lookup(unsigned long pfn)
> +{
> +	return lookup_page_ext(pfn_to_page(pfn));
> +}
> +
>   /**
>    * page_ext_get() - Get the extended information for a page.
>    * @page: The page we're interested in.

As discussed offline, getting rid of lookup_page_ext() can be done later 
as a cleanup.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


