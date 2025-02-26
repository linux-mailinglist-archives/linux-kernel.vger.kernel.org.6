Return-Path: <linux-kernel+bounces-534295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB90A46523
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A33F1887F21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E079B223710;
	Wed, 26 Feb 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFO5l3q5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391022331C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584120; cv=none; b=rlNkAYWDKFp6IFy1HlvELslq3JCyMOIXT2ERPUJErR3qc1qWhGm2Y+rDW+N4ayHaGBnUiTgqQz6PfpZBev1cbyFLoiGheMyY5ipuMnhqcm7+TQhY3yPgR1XIp7SIANYN5L6fHG5X1qJsuKWrhiOFqU4SgJmsi4d9A4MsepL91ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584120; c=relaxed/simple;
	bh=6mdAuvz781FCW4BfxP6ejJKtJ95cFcW7VnKKzsXundE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l86NsvJhaPcaz9dq6cIfVM7bY9vNNynrdfy0Wb7MYn0CBrANeGYm6Y0CTeaFAwDmK/KhtRwOi5pihcsfOMIpDn1A/O3zkvBqmo8HVrvY2Ny9XpWX0HZ8m21hi9h4rtrssVOik82foZRh69GPdOloiAx6aUtSeR2mTS78Rbusm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFO5l3q5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740584117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GLtL1iYvSdMyja7reFfUkLJoE1s+u20TWnWvDVhqKm8=;
	b=bFO5l3q5dOUHxNVUZJsl6ZW5e16bty9gXPL2MhlFzByT1B0dmKqq4VP6d+7oUsPdOf8mWx
	b/q4NXMWWDuIHt2tA1s9rqMzNuvKJsjNWM0zaa86/6jtzWOWl3ecHPg3KGIde9VgS8adH9
	NgZJ9zLHGPXs8aRQGfGf1n+Ht3Tk+pU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-B5qCOhjJMuWBZWI0iSbnGw-1; Wed, 26 Feb 2025 10:35:14 -0500
X-MC-Unique: B5qCOhjJMuWBZWI0iSbnGw-1
X-Mimecast-MFC-AGG-ID: B5qCOhjJMuWBZWI0iSbnGw_1740584113
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so35293655e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584113; x=1741188913;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLtL1iYvSdMyja7reFfUkLJoE1s+u20TWnWvDVhqKm8=;
        b=o8WTNsDpM3BaCKGZxFQhi1p693YzukU3+7nB10nKabwT0lxviK117Z8/Wv1SgZyiir
         n71u2PuRlalkmm+cV6ykzpcsugSeO47f4CjfR6pA2EBdmPezNRhK7+OeJsv6Qza7JbXi
         liJrfOEqC15+Kk7Gjo3Pkl+BYYWBjSXYjJ5oueKP8qHRWvspT85T5iYB8qKWTb/N4zIh
         nSw+yM29wkdSFL9DxKbXnLynN99GnH1wUMyKDIV+vTVzrEIsyIb7CoQivK3SZs8mYcBF
         VOKin4ocmDwHWRz4Q+UmdHwWOGB9GINZ3AY7UNSUAl+QcDCfuuIC3gF0WWv/uXdwWzsR
         iWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSf3dvr++EycidmXeDOrr+libPV+Btv13MNJ2Bgpm52vw+bLlVFVdxeKxphzP54NKtJLzvF2XQfHlV6kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyjmwKZ/tkaW42S7eHfj6araFAVOTuNtJuVBnoAw/FtNwsaLu
	gmwM6t2qZvlq9lsJqylsZbeXqesp0kjEJidhIlbX9fS/NyWA6FaFHd7/W6n0JwEpndjVHMblGVa
	z2eNuzOtec/0qD4veYJ6Um5WHoCec1ClwbSW8rZ+9F+Ar/eqcg7LCjC5cV5J/gQ==
X-Gm-Gg: ASbGncumgeLYuPQwvv3zbogANNZvj6cEcqj4HWY5hSkxMu1U/EUYcz7XYK6gUfDjBxt
	gTdsS9tnMxFRT+O7vLNiWbS68lKHLt1jlfAwjN+XAJcmFQ4RKpDW4+yoAffKXIvHuq/jd2LG/iI
	C5DdxAXLwhUfm06KFcZVtlSTBOnUeVyQXE7wRIA3DeMBM31KlGq2q6IL4ElmGNj8gzpXDJNnwFq
	JBGgK2YcfHg/zaszmwC3wrZ+2uoY0H0ZKdH1RR4eFTsA2DjnRjRNkhqqWHzMkFd8lwqLS+u6Gjg
	fmZA0xqxFxdHU3SEr7eDMlhPKqKcHrcOVJBW7/RXCNusIw1OekyTs+1ZAatHyt9tZYICWbcEfUE
	osRXzpk9DRxyN1JXrQhZo+1wnt0u/H8nKBwIRaj/dgi4=
X-Received: by 2002:a5d:59a7:0:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-38f7082b185mr23251361f8f.38.1740584113449;
        Wed, 26 Feb 2025 07:35:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp3v+bzi9Bw7o6djX9Ddt+sNpMhqZb5smTuPUCjkfiZJUnTn4b/UNLDawFdnr1VzSuvm/7yA==
X-Received: by 2002:a5d:59a7:0:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-38f7082b185mr23251341f8f.38.1740584113107;
        Wed, 26 Feb 2025 07:35:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba539466sm26915835e9.18.2025.02.26.07.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:35:12 -0800 (PST)
Message-ID: <3d372e93-599b-4072-955c-44c98eca469f@redhat.com>
Date: Wed, 26 Feb 2025 16:35:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: fix build warning when CONFIG_SWAP is not set
To: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
 kasong@tencent.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250226182511.592796-1-shikemeng@huaweicloud.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250226182511.592796-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 19:25, Kemeng Shi wrote:
> Fix build warning that folio_alloc_swap is defined but not used when
> CONFIG_SWAP is not set.
> 
> Fixes: b79768ab943cf ("mm, swap: simplify folio swap allocation")

Not a stable commit id from upstream / mm-stable, so this should be 
squashed into the original commit.

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   include/linux/swap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3a68da686c4e..d1f5414ea537 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -587,7 +587,7 @@ static inline int swp_swapcount(swp_entry_t entry)
>   	return 0;
>   }
>   
> -static int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
> +static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
>   {
>   	return -EINVAL;
>   }

LGTM

-- 
Cheers,

David / dhildenb


