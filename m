Return-Path: <linux-kernel+bounces-177803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C585F8C44CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768452863D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96974155333;
	Mon, 13 May 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgZY8v1A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387557CAA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616348; cv=none; b=bTMMGK1/OnNuctaSmUaVwk8jmsDII+WBIkO8OQzt5GjDcWBLZPBswISRqB8DSavDbqVXEG7egMrIuXCP6iALfynr3ceidoqufufckOEVuFjTi2rRDoehxKkLl6NpAqgzaoF88nAVNltCVO3N4EzMSKkORkHyKIz+1vXucenkmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616348; c=relaxed/simple;
	bh=RLEELJfEeHQtxm18MynLKhUbioeO2FL7LlUadhrBTyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVxXYtkHdc94IaLMKfzeqK0o9l+3rvBddJ2eBSLShwehHGGVCUpn+e96VkroYI1NsetMgYDjfH+3mCxxQzYSPhIaozAL7ZtlYoecb5XJO7HTvEm+Y77hGtLmx8SR9ptHTkdw7iH08rcFeXNs2cZiBK64fb08IKoGBWiHqJ+ve/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgZY8v1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715616346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K0CYoZs0dx2HGoMj4p9xHQbvgN9/vzp+5liOIZ+zRdo=;
	b=MgZY8v1A/QZVuMjFfdKernqQi6EnXyWy/4OD9vumkfWm/AVmHTRxsHSgYZzw5xdIZ4WKOq
	1zrrRmHwKe5Xdp6xtt3eh8Xe1wPKQrgPeaxcAEiCbRcNb6FtEMbqycezs+9FIri51A8a2I
	3zoxn4cacPKSfNgffj/nJRxkIeZfqjA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-xfAVrGmcMx2_A-iDyvyYbw-1; Mon, 13 May 2024 12:00:40 -0400
X-MC-Unique: xfAVrGmcMx2_A-iDyvyYbw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5b27fcd20ebso4220709eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616039; x=1716220839;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K0CYoZs0dx2HGoMj4p9xHQbvgN9/vzp+5liOIZ+zRdo=;
        b=eDqdgmiLEaiWFDrjLwyzTKmUKzgBQpbLAfAZpxwDDPt8EnP016FkRmC3Kptpqun2PC
         S8Y9kV1mNWwSfstsmdHpEUaKdJO6lIrlpG40tYR0/8u+1kLyScrEg2b8dLdtTphtpd3V
         V+c8smQ+ELdputD5qx1vGFse4HBZvC5Kw0GFAapm/lO2br60pQyT39E70foXs5Ubj0wl
         jii4YzmJ2J9cIv7hEaDco2382ed0b0uvr3/1IRIyomLZZNkBsEoFONq6NiNb5dE2wg4b
         3Eo0NL6BNXxL/Jv8IYrOlDv/augP+HPBgOKgyvghXO1hw35j+l4uNVrKg+w/BeUHKCfd
         MAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXORyL6rH8I8P4Uf+qEoii7YtKXcbSn/L/Ua0i7WcrpU6RIksqce4kaObxYNqJEGNe2h+yt+OAEnQBQrsoLCiRqdo1IVD9VDNWgjLQ
X-Gm-Message-State: AOJu0YzLZv8FOm6tRPmddn23xCWf4NHddExY5QNTFKelPXqF7URM9oJB
	362tHJr2ItsSPmiLRfI/UAZNCJiC7TajCenGVJ2yJIWKRhdGsuirEIGUZV2e06RBEwiI60gHE0P
	GYBMGRjtJt6XOJjQMidYL4c+eml/A4q40rTx/eiuMdRd7Tu1LkgLGfElGZFbUAw==
X-Received: by 2002:a05:6358:339f:b0:192:c556:5552 with SMTP id e5c5f4694b2df-193bb3fc5fcmr990632555d.6.1715616039122;
        Mon, 13 May 2024 09:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeWg5zvCqydqbu87+C41bMR+br/c5m2gqcBqQMojKuo+mwd1ZzTwAvHMx7nrzpYwnz/sN+Bw==
X-Received: by 2002:a05:6358:339f:b0:192:c556:5552 with SMTP id e5c5f4694b2df-193bb3fc5fcmr990629555d.6.1715616038660;
        Mon, 13 May 2024 09:00:38 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449ffbsm8008935a12.2.2024.05.13.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:00:37 -0700 (PDT)
Message-ID: <10529556-e22d-4afa-803d-c75511ce8425@redhat.com>
Date: Mon, 13 May 2024 18:00:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm/huge_memory: mark racy access on
 huge_anon_orders_always
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: willy@infradead.org, shy828301@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ziy@nvidia.com
References: <20240511144436754EiKfJM4xjMSTyCbEExwcL@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240511144436754EiKfJM4xjMSTyCbEExwcL@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.05.24 08:44, xu.xin16@zte.com.cn wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> huge_anon_orders_always and huge_anon_orders_always are accessed

"huge_anon_orders_always" mentioned twice.

> lockless, it is better to use the READ_ONCE() wrapper.
> This is not fixing any visible bug, hopefully this can cease some
> KCSAN complains in the future.
> Also do that for huge_anon_orders_madvise.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>   include/linux/huge_mm.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index de0c89105076..6573430ea600 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -122,8 +122,8 @@ static inline bool hugepage_flags_enabled(void)
>   	 * So we don't need to look at huge_anon_orders_inherit.
>   	 */
>   	return hugepage_global_enabled() ||
> -	       huge_anon_orders_always ||
> -	       huge_anon_orders_madvise;
> +			READ_ONCE(huge_anon_orders_always) ||
> +			READ_ONCE(huge_anon_orders_madvise);

Don't mess up the alignment please.

>   }
> 
>   static inline int highest_order(unsigned long orders)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


