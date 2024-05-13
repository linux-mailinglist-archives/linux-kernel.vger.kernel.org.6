Return-Path: <linux-kernel+bounces-177794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1779D8C44B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D911C21A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDC155323;
	Mon, 13 May 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLm0tSep"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C672154423
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615977; cv=none; b=eVA9EbedU4RQE7Ql+HWZJWIdKtBx/Mt/RrxF0vX+5uAqUynbrz2sxRvQ31S417DnwgwUNfokdD2/7zOK47NvOgUuJw3nCK8Jdl6cDPREb7MqSJcemY6IWbJ2FvOaAfXSUg8X+ZBySwG321Hy9hz91ddmJJXydK8o+j4JjGLqklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615977; c=relaxed/simple;
	bh=MYvDDPcLVa8KHX0mwrjACuHyq2jA1aSA3EU8Aocn1GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HM6dCbdZ+Ubw9zxhKJq+4LFB1ZptfYmVDFDHX7AEijlUPhFq43kHCtHZKgOQQKffEgcz6bp0pMTvW0YD7wP72sfG0NhmkTZq0/wuVdFGyRYPIbyaEE3VYJ/a8x6BOQgjr2u4VrVuWvCGN/XDIOkaRVXAWrRKbWA6d70KCSDuyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLm0tSep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715615974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j81z1AgmmEZ41ACc0AlxEnhwx9jcCCK60iobESSP7tA=;
	b=ZLm0tSepFU2LA62RVrRuViLM7ZvBMi345GOZTk+aqRT+yRZeRlIi08NvfR+imy7KNYOHT5
	sxLQV0AZYuf9KgSb3j3QvntXh998BBJ4iTq+kTsPJ+bcNeQxQQ08A1HAk6nHFGKByT1Y9D
	cxOYVpe6JGbn8Z/94EEHcBAXzcIXkIM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-uSR4p8k5OqW-F8CN34aSuA-1; Mon, 13 May 2024 11:58:29 -0400
X-MC-Unique: uSR4p8k5OqW-F8CN34aSuA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec896dae3cso48766615ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715615908; x=1716220708;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j81z1AgmmEZ41ACc0AlxEnhwx9jcCCK60iobESSP7tA=;
        b=Z7aUfCmrPC3FhqJX2TYT4sd2zQC298dCLxsqtCdfsEfq9nx646PWGL3g12PepnsnrX
         JZQkCsEy3xyi+hp0TUmFyC6t0ZbMY2A5Zpz9b5Q5PpI7F+esjcoIhqtT8N162y6+pGiy
         3WpLqzfBCXhU+/XkMswN269wu/Ro1wLYRh5Qsy5CT/lLHNRHcaeVY84MLxQQfSjpjpYF
         DiBhs+SzatDUtiUxwxIuKsJLrqYw5KxUQm6Rylx4vgSsf0J3VpOCxouqL2x0zQZww8Lb
         gfJbohB6tctpiqRzieLJDlSw/llCsQPGmhc1z8/1VZe2LGvfqmKx2exN9PMCl2i8E+11
         pJHg==
X-Forwarded-Encrypted: i=1; AJvYcCVu1l0z/qd6oNQPs/c2O6Sr1/ORjdl+CjoT+ymZ6j8PmoTCYd6J+qGDGSh8KLl2xXAI2vBfUAiGQxks8AaRI4Y5cOjpT9kVPWp/xRic
X-Gm-Message-State: AOJu0YxrqNSsLIGsOiIBHgXRnoX4hLi4tEwuZtDig3R4ncPrmHj8Yfjg
	EmzlOU7U3muqeqv1DEBwzPU6xT6nSKbGNzDGgB0AUl9ZyPGWNqdLn52TFUoVX5Y2Ir1gDtepGni
	4Wn5w/2gSNE1Y1Y58Yj9p71TY+k/qWOPhIJJu1Yig0eWiiZikXpMWm1RPqQMJKqsZPaTc9Q==
X-Received: by 2002:a17:903:947:b0:1e3:1526:77d5 with SMTP id d9443c01a7336-1ef43d28152mr132161625ad.23.1715615908215;
        Mon, 13 May 2024 08:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE71P5Um+01tB2LRbrMi9oX3hKDuf/VfBhA7z1Ohme8hggzZfJ+0Qt5GNlgm3+RXQ8eLseoEw==
X-Received: by 2002:a17:903:947:b0:1e3:1526:77d5 with SMTP id d9443c01a7336-1ef43d28152mr132161395ad.23.1715615907771;
        Mon, 13 May 2024 08:58:27 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf311d0sm80781775ad.132.2024.05.13.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:58:27 -0700 (PDT)
Message-ID: <baa40403-e498-4db8-ac47-126e7d3869c8@redhat.com>
Date: Mon, 13 May 2024 17:58:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm/huge_memory: remove redundant locking when
 parsing THP sysfs input
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: willy@infradead.org, shy828301@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240511144048767fdB7EqYoMHEw6A5b6FrXM@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240511144048767fdB7EqYoMHEw6A5b6FrXM@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.05.24 08:40, xu.xin16@zte.com.cn wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Since sysfs_streq() only performs a simple memory comparison operation
> and will not introduce any sleepable operation, So there is no
> need to drop the lock when parsing input. Remove redundant lock
> and unlock operations to make code cleaner.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>   mm/huge_memory.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 89f58c7603b2..87123a87cb21 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -478,32 +478,26 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>   	int order = to_thpsize(kobj)->order;
>   	ssize_t ret = count;
> 
> +	spin_lock(&huge_anon_orders_lock);
>   	if (sysfs_streq(buf, "always")) {
> -		spin_lock(&huge_anon_orders_lock);
>   		clear_bit(order, &huge_anon_orders_inherit);
>   		clear_bit(order, &huge_anon_orders_madvise);
>   		set_bit(order, &huge_anon_orders_always);
> -		spin_unlock(&huge_anon_orders_lock);
>   	} else if (sysfs_streq(buf, "inherit")) {
> -		spin_lock(&huge_anon_orders_lock);
>   		clear_bit(order, &huge_anon_orders_always);
>   		clear_bit(order, &huge_anon_orders_madvise);
>   		set_bit(order, &huge_anon_orders_inherit);
> -		spin_unlock(&huge_anon_orders_lock);
>   	} else if (sysfs_streq(buf, "madvise")) {
> -		spin_lock(&huge_anon_orders_lock);
>   		clear_bit(order, &huge_anon_orders_always);
>   		clear_bit(order, &huge_anon_orders_inherit);
>   		set_bit(order, &huge_anon_orders_madvise);
> -		spin_unlock(&huge_anon_orders_lock);
>   	} else if (sysfs_streq(buf, "never")) {
> -		spin_lock(&huge_anon_orders_lock);
>   		clear_bit(order, &huge_anon_orders_always);
>   		clear_bit(order, &huge_anon_orders_inherit);
>   		clear_bit(order, &huge_anon_orders_madvise);
> -		spin_unlock(&huge_anon_orders_lock);
>   	} else
>   		ret = -EINVAL;
> +	spin_unlock(&huge_anon_orders_lock);
> 
>   	return ret;
>   }

No strong opinion

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


