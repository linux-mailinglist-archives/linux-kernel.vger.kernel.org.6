Return-Path: <linux-kernel+bounces-301760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6095F536
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7117CB218AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49546189514;
	Mon, 26 Aug 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cH1i0d7V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A03186298
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686420; cv=none; b=HmeRLlpvBF704QRvWtCAWWsnz5ZYEyLO7ZT2HDgJh0GND6OoizIgpZhrHJt36CW2GXzqHiweJ3zzz14eAXg4VaWNZEGVnFKsCM4xKqKwTB7a6fiBk7V+h6rH44vOzyXHXzWK1SKyuBc2oMK6ly+P42BEn9UYOHXAQx59KR7VObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686420; c=relaxed/simple;
	bh=KEosndWVrsw/517naVNGOqnpRxqUikWyC7LPyftVLaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1Qmq80YkeXTUeY/5mFtE0AD7hSrJkW0UiZAg4UVV5n3Jo7syc+iAQEAKJ5XMpNGYzZdLsIGfxpVACoPIqNfcp1YJG/pcrYAradnhRjQ9e/ZF8EbbTNXAOsyjf3/uplu4rmKTjJEEHJ4ltCH0obKsPXANCkPsrzCRjnSQJqJUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cH1i0d7V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724686417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fLHVmwuLAYPsFURDKjEb+NeYe5prtzLVT02SsD4UDUM=;
	b=cH1i0d7Vsl6ePGvGVramWTlG0rCHcS6RwPDv+MOceklieeAk/2zP95EzqtHTLTUweDaJrY
	2Ek/5jKvVQ8zueGx1AFSkRuaCYjKocL06AVGfhxP03hZQ/+j6P78/La6q1/kpiDoe2tWOF
	6wWypMrwQk8pp2i3Hluy9YI1kzH7MYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-TE6dnMAyNequxvo5pk7iFQ-1; Mon, 26 Aug 2024 11:33:35 -0400
X-MC-Unique: TE6dnMAyNequxvo5pk7iFQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367990b4beeso2295909f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686414; x=1725291214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLHVmwuLAYPsFURDKjEb+NeYe5prtzLVT02SsD4UDUM=;
        b=emw2cL5E17ySk3BzPXOaRcZi2TtcXI61CXtM8Q2W6By9wgxxfYUlshyFgYQa8mkjOp
         rNoUuuFblH4Jsx2+wFb7liy2tAUmYKasaw98tQm6JfK/H6H8pmu+sg33Idud8ZCJBSmo
         lmhPPFi5hlwa5U3MVwqRN3PUr2qCwJUxMJAH38HdJZ4W2cJ0uYkdTqyZocelb4ypl911
         /6/ijr3NYF/BTb+QlPudZIQZTsfjytOJ8tFRXLWYWaaYN0rKP0ry9IbYjBtHF487zeF6
         yO816/X6ScmNQIzL9OAdip3dfZvGTjXX/wQH2XSTMBlfeD8tP9KfJSQGL96p+w7/KTsX
         YWhQ==
X-Gm-Message-State: AOJu0YyyKLuh+IrOQT/ac1TJowRGbqM8Gbu3WXzuO+hZzYNrZpRjpU/Z
	z13pZe8Fr7RL75QtAODhoTNoq4LPwSs8YHif/xLuiZbI6unLcKYQzbnuVJB/GwveodD8FsmsmvK
	RTSxZHFiWCsZogmvLDmWc8+Gyv4o3pLsy6Fu2y/F7NSVr0KOse8U8/DR5EQVJZw==
X-Received: by 2002:a5d:58fb:0:b0:371:7dda:d7d9 with SMTP id ffacd0b85a97d-373118400c7mr7060069f8f.9.1724686414511;
        Mon, 26 Aug 2024 08:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHytmu9SRRnL82xMRuRcaexgdIVoLY9mV2pWJmUW8w6VZNMmeRxH8CESB56unxuK81kkNwCqA==
X-Received: by 2002:a5d:58fb:0:b0:371:7dda:d7d9 with SMTP id ffacd0b85a97d-373118400c7mr7060032f8f.9.1724686413712;
        Mon, 26 Aug 2024 08:33:33 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23ced.dip0.t-ipconnect.de. [79.242.60.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110436sm11025885f8f.11.2024.08.26.08.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 08:33:33 -0700 (PDT)
Message-ID: <0b7ca0c2-7a64-4d0e-aa18-2fc4257c199e@redhat.com>
Date: Mon, 26 Aug 2024 17:33:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] mm: khugepaged: __collapse_huge_page_swapin()
 use pte_offset_map_ro_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <2b7dceaa12da273c6decf92e3bf2ebc4f4e85ec5.1724310149.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2b7dceaa12da273c6decf92e3bf2ebc4f4e85ec5.1724310149.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 09:13, Qi Zheng wrote:
> In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
> in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
> so convert it to using pte_offset_map_ro_nolock().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/khugepaged.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4a83c40d90538..53bfa7f4b7f82 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1011,7 +1011,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   		};
>   
>   		if (!pte++) {
> -			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
> +			/*
> +			 * Here the ptl is only used to check pte_same() in
> +			 * do_swap_page(), so readonly version is enough.
> +			 */
> +			pte = pte_offset_map_ro_nolock(mm, pmd, address, &ptl);
>   			if (!pte) {
>   				mmap_read_unlock(mm);
>   				result = SCAN_PMD_NULL;

Suboptimal that the pteval comparison + unmap is buried in 
do_swap_page(). Moving that to the caller is also not significantly 
better ...

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


