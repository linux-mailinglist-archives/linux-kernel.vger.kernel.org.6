Return-Path: <linux-kernel+bounces-316835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5A96D5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89C71C237BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC981991A1;
	Thu,  5 Sep 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a83ynjGB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6E198824
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531766; cv=none; b=pfU++tlF3LChiJosZiYtV2NPO4IaEEHZCa+Il5QEqAkZ4GEOiuWHGInkCo4FBv0N6u0kKGLrkCTsbM+xQlHIVYqRGsb0MRX+lUfzMMM8XlT13WvviKhrzU61+bHUev8590HM7rUuvXH+d19H0Jbc0YWyFeKO66ZVb2gV0zNawnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531766; c=relaxed/simple;
	bh=yetVhG1if+1LQady3DPiCJRHSAjmTp0a60OBziU0tZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=silMThDikvTfIJ+Gi9xjGVbFyDdje/02NrxuUSu4r1Wa+HZMRWy8mChs8U2RRwXoQU1v3rjPvVEuVgi+HTxoUxlSXPBIHH/AIEvje5K+FwIB+nyb9L71DcgYDhlylOKONRpAKWDc8pODc6F6Q6p8tnWacLEcplsbrP0/VcwLaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a83ynjGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725531763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wBauPtDcaZ6X23tUbMEqQdp+l+QLT20d6gNsUmMM1J4=;
	b=a83ynjGBiLvHTnCk+OfW+uSE2LSzofe/+BdOPP2gazQ5fo7JKUJ1ItC0GhfrR7tf5PD9hA
	B7RDbm4NstXVxEWW/x0Ql7VAl46BmO7BWHqeQDhughzq/SYE4/ONVV6qiDyzm/9YUATHwq
	B7axiR0JthzMzfxVnkGPHCe1SJHxKMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Tp3vm6w1N1SM6E0CRFpM2A-1; Thu, 05 Sep 2024 06:22:41 -0400
X-MC-Unique: Tp3vm6w1N1SM6E0CRFpM2A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb68e16b0so6182785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531760; x=1726136560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBauPtDcaZ6X23tUbMEqQdp+l+QLT20d6gNsUmMM1J4=;
        b=amxPwK+LKJCPL/N4jAundEWXuLhP7N/GawFyayHynpEUy+//DJ0ExgGI7W+kcbR60r
         nKCjrQ0egvXfNxTTk5f9CIq0OX4jURvjSX+s48hd2WqqsDKycv+omLRdn3XEficNUk59
         aZJ6WTrsV2iH6+tzinjYom9in5vducCusFDxEg0sPaiMISxyNZJwDQTtv43srnvVkGpq
         0e4pzHduAqB1QMgt+LtmyjHF17FRyC43Sqy2RvuSUUNa/UsvstYY+nAZxPiw89jdGpVo
         qlz77ptpwkSfP7kW2OIbfULeOXCEto5fwmZYB5ePN5/Gbr9acbbYSzwqJtN6+2OwbbZA
         PPlg==
X-Forwarded-Encrypted: i=1; AJvYcCX207p15QfFuch2nzJfxiPrqGDuffnA7oTgebF+LON6i75+yWZCrz+2MvRpfik/DRyl+boKHXjzs/7ait8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7F2D1GOznSdC4f0rczPtTSWKy7N3P/Oiwmh9p1kmtgjq99K27
	1CwtE4qnHX9Ep9hOXvM/ml8IJ9fNvJB+bGzddh/yj06bDOgeNEBMozj1oByQJsA7zxyBtrLTE/m
	TF1+U7+NRwbBFGS/HQ1AwtOdxuyDwQ0WwYLUcBjt8KlTsEPRs4duQsuHily5R2w==
X-Received: by 2002:a05:600c:1c12:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-42c9a36c5c6mr16332045e9.17.1725531760224;
        Thu, 05 Sep 2024 03:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUHbHDBvHnJH9EC8AJcVxvoiifAHF4EhGB5UHIad66+ayxQ/spxG7PtAt2DbvQSbHV7NoujQ==
X-Received: by 2002:a05:600c:1c12:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-42c9a36c5c6mr16331565e9.17.1725531759047;
        Thu, 05 Sep 2024 03:22:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:5400:6c12:d0e2:3757:2963? (p200300cbc70854006c12d0e237572963.dip0.t-ipconnect.de. [2003:cb:c708:5400:6c12:d0e2:3757:2963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ccab8a76sm9628797f8f.99.2024.09.05.03.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:22:38 -0700 (PDT)
Message-ID: <50595531-87b0-4420-9624-948810066a6e@redhat.com>
Date: Thu, 5 Sep 2024 12:22:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move bad zone checking before getting it
To: Wang Yibo <lcnwed@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, trivial@kernel.org,
 Wang Yibo <wangyibo@uniontech.com>
References: <20240905095216.7888-1-wangyibo@uniontech.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240905095216.7888-1-wangyibo@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.24 11:52, Wang Yibo wrote:
> When flags from gfp_zone() has an error combination, VM_BUG_ON() should firt know it before use it.

s/firt/first/

Please break long lines. (checkpatch.pl should have warned you)

> 
> Signed-off-by: Wang Yibo <wangyibo@uniontech.com>
> ---
>   include/linux/gfp.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index f53f76e0b17e..ca61b2440ab3 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -133,10 +133,11 @@ static inline enum zone_type gfp_zone(gfp_t flags)
>   {
>   	enum zone_type z;
>   	int bit = (__force int) (flags & GFP_ZONEMASK);
> +	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);

Better use VM_WARN_ON_ONCE() instead while at it.

>   
>   	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
>   					 ((1 << GFP_ZONES_SHIFT) - 1);
> -	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> +

Unrelated whitespace change.

>   	return z;
>   }
>   

But I don't see why we would want this change? It's not like the kernel 
would crash when calculating z.

Or is there some change in behavior I am missing?

-- 
Cheers,

David / dhildenb


