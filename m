Return-Path: <linux-kernel+bounces-317142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787196D9EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1A283E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2519CCF3;
	Thu,  5 Sep 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHwVFch7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2719923F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542008; cv=none; b=dYvPUDczwg471JS9+61Q/9RgvZPwvu+HLOJrUz7BY/LbcyPEs5eBt2Z3gw4ZW/e6cG2Hlqnb+oSpRRkEvY4Ff9Dwo7XA7fW5zyydHUPtArubNB9kdVB7BuDEIA4yW/X96+MK0w/pO/fGs3t9A6L1kN8Fo7Ao2gzv5Qj9Nht74To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542008; c=relaxed/simple;
	bh=WQXn4smK8/dbJpL9jy50AGDmsVxCDvYbRmDwaB6kkww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq1uRAWWnzpeo5tSeFDl0wFTklxKdMfQRwYUvfxfYlJpZxLnTTmIpEfoLHUIg2VTUBgDgYsxZC8NPDHllumf6BuSCs3VOITvHVWgwjQkSawSXe1CtHogQtRlQcHWyrgu6daLPqbzRPu8vxfU17uTi66vDUZQzCanu/+OYHKJUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHwVFch7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725542006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AYFFhAYGLWjIKXe/lp6WVXnfENFxMkNEag3Fa1KXCQU=;
	b=GHwVFch7ntJCJTeGcgVPsaQoYae5Ify3t5q80Gh0i2YMKKIPvhM4R9YerFrGkl4NxqKUoK
	+xu+qOEAU3eCWuDQbACeN6LW6/XCWuQPI+BanWD/4i6NlfqKCbDOjRIdGwobUYLrjdVNCJ
	/O4sBUmhu8QzpYbbL4fY2fw9Je5kH3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-5C27ZyHzPreU_4PTsH76Ig-1; Thu, 05 Sep 2024 09:13:22 -0400
X-MC-Unique: 5C27ZyHzPreU_4PTsH76Ig-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bfc57e2aso572002f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542002; x=1726146802;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYFFhAYGLWjIKXe/lp6WVXnfENFxMkNEag3Fa1KXCQU=;
        b=U/9IuhZln1HflE0basaDBpBQFq1OfQZKJ2xW+kHrfpXyPdP/dToW5FjZovX4TcpCai
         2Uo5VAOZCv6enKqC74+6THNQCn07KbLTCFldMmIq9gUgT9SCPXOIyhonLPCvuTpoAxx9
         JJhcM4vlaV6Wd03EPbk0k7wGbFIx5IWED8X9UYJcm+a4jVHYL77ERhHlLZAmWB4AuEQB
         qoE0ll8LjhZrFjm1Mkiltp0oQ69aekHjaaNxlqp1j064+7UNO/nqlUmyFKU16cUr0kHv
         xp9EPIjO91rcWgmBJ6DgAiCT9QuJsPFohxYv3xFsxLraKAUIGM6Uvq7cWV8Urke0/teG
         prGA==
X-Forwarded-Encrypted: i=1; AJvYcCXQgxjVMLgdESVsqw77O3CclxtPYpCH2D0V0yVMIxwtzPSUX5ZwE0HT/+ZG/3yE+O0f/EKxdzCu9L4GKPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXgUlj+oNQ3imYsuzms78xuTdcNnGIwkMmCYSi6ag2uPqctX0
	INKluY4qax9MPdrOXbi2gU1490SkEUuCiGn3zuzFeTbMveR235l2qFaG7CmJE98hb/ElNls4D0b
	omcNuJfh7orYtQQQt8fwaqKNdSEcW36T0eEmmsetNZe0M2NYeAOIZ3g9f2Wv1yg==
X-Received: by 2002:adf:f106:0:b0:371:86bc:6c05 with SMTP id ffacd0b85a97d-3776ee902f2mr4076214f8f.10.1725542001663;
        Thu, 05 Sep 2024 06:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvik4mz7clc9mCfUKO1QM0VVLKwna6dQQ171Rn+bRn4aVk8Yt91uTdDtZdVji09pzCcf5IfQ==
X-Received: by 2002:adf:f106:0:b0:371:86bc:6c05 with SMTP id ffacd0b85a97d-3776ee902f2mr4076187f8f.10.1725542001081;
        Thu, 05 Sep 2024 06:13:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:5400:6c12:d0e2:3757:2963? (p200300cbc70854006c12d0e237572963.dip0.t-ipconnect.de. [2003:cb:c708:5400:6c12:d0e2:3757:2963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-375f59f3d5esm7342495f8f.96.2024.09.05.06.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 06:13:20 -0700 (PDT)
Message-ID: <97a56b6a-bafa-448a-b082-917b7f9f30c6@redhat.com>
Date: Thu, 5 Sep 2024 15:13:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: move bad zone checking in gfp_zone()
To: Wang Yibo <lcnwed@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, trivial@kernel.org, wangyibo@uniontech.com
References: <50595531-87b0-4420-9624-948810066a6e@redhat.com>
 <20240905104808.27528-1-wangyibo@uniontech.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240905104808.27528-1-wangyibo@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.24 12:48, Wang Yibo wrote:
> When flags in gfp_zone() has an error combination,
> VM_BUG_ON() should first know it before use it.
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
>   
>   	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
>   					 ((1 << GFP_ZONES_SHIFT) - 1);
> -	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> +

I'm afraid you either missed half my review comments or your answer to 
my mail did not make it to my inbox.

-- 
Cheers,

David / dhildenb


