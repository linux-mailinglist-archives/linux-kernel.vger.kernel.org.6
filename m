Return-Path: <linux-kernel+bounces-295411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37423959A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B432D1F23BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B21CEAC5;
	Wed, 21 Aug 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw+uAdib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FC1CE711
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239696; cv=none; b=nr6DlBR0Ehhcwn6lR3j+fJ9EMy1+y/d53rfK7OBWRAZQKF0eI08hDJ6diyyMs47IOZBUA8MyAMKzDtcMqEcJwV7bNTO+PHHPbN5em3Si1V6hYjZ0sd43J2v+Y6jZkeiJgeZe4xb+svskDZorvRLUDrAkbs4gnALBaTL0gKA8i8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239696; c=relaxed/simple;
	bh=hVE7g8OGozDBVSSu0AaxGgSGPg1NQcKsl5nkmTQ9nlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dLTxKemWXFOUSFRi4LLqIwQm7TFE/dpZeVkj/8412a97vxAeHrw7M5JI8kCUztY6w3bNi4YFCKOlWWc25wdAUv6jO22JCDxgmg488fmBmkZuTXIySyK5Mlh2ODzGmk1/eZruAO060Fa4j1EGV3tkLOPLAyslbyU/cQ2JTaXm//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw+uAdib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724239693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qne6Mfq7XN0PgJHnYPv+oM9l8Itj9wstRbNvLqM8lx4=;
	b=Hw+uAdibopC4GyyT1ij2rYD3yyqVwQmqC1h8qk9wxyKEgmi/MBF5EGf4w+qDNtvel+mMKG
	38NEFMm9fsJGqhgBXXGwNSc83I3kPHHlOGmgB+Toj9ING5g+HRQne7PjDIorRqIvrpsBF8
	xP5txqgUFEJtyZHH9ZwUm1W10/sBNVo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-m3KumJ43OLijla0W_C4deQ-1; Wed, 21 Aug 2024 07:28:12 -0400
X-MC-Unique: m3KumJ43OLijla0W_C4deQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ab8492cedso16674935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239691; x=1724844491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qne6Mfq7XN0PgJHnYPv+oM9l8Itj9wstRbNvLqM8lx4=;
        b=pwjlV8Ynd5zpXLnkyxCGUcRAVT3Emwsoj3dvIHr9WLYRMMq75fluvVAvdPm1GfgzYa
         6s1GVlc2HPuttrXP8BhkvcJIOYE26RkVO2uy8aJzS7prHIJi+vGHC5AnwM06v0DLjXjQ
         UJ1EEk/t+kUTasWR73Zdh9TvnfnOmzbeUQOAX9QbWu8elvF9ZNadEAlghtZbvnT7Abre
         uHhQUL6DsEZYgfkYC8V9nQbgo6RUp0hB1jvDMzFoejbGdqrJ2Czviw/4+vh+U3B5quds
         2kDAM9evDVClZ5jkLYl81bIsXZjCL1ZdF6kgv3bmpd+ikOJprkkuAYEkL/rT5AwG4ihP
         C0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVlgrJrRsLBR1UqeAD6tsch1V9cm8OTiXBjNdPVDnsK53qkUtJP1XLGz5pmNN7PgBam7cTepvzUu170qbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xmuiGUC/B2ZoBJstUGMOZ23TQM5sSQVw5uTYu0V7lOw2qyTY
	OO7brC4+CBDX2lYFwQ2GS5oxKLZIMmNw++QfyUvRDaCyqgFqXFnJDkjPswRVdD3PY6I+PMW78h2
	JidQYVlrSVbV8/txRWO9dTWXEV7S2MgirwI7we4FZNzZ1ldst6pc5wsXsmikdMQ==
X-Received: by 2002:a05:600c:1986:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42abd21293cmr16440485e9.12.1724239690861;
        Wed, 21 Aug 2024 04:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmbgWpiWAbJrU2VCY8lzmx3OGuYsJIizApBkzPXMMf+CMDZqKbj7GqsitWq8P6PuZThQuA+Q==
X-Received: by 2002:a05:600c:1986:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42abd21293cmr16440135e9.12.1724239690012;
        Wed, 21 Aug 2024 04:28:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734? (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de. [2003:cb:c705:4300:16d5:c5b:8388:a734])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897066sm15510040f8f.76.2024.08.21.04.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:28:09 -0700 (PDT)
Message-ID: <8d40e74e-c68b-4f94-ae1e-42c4430d55e2@redhat.com>
Date: Wed, 21 Aug 2024 13:28:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/page_poison: slightly optimize check_poison_mem()
To: Zhen Lei <thunder.leizhen@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821075311.1953-1-thunder.leizhen@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240821075311.1953-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.08.24 09:53, Zhen Lei wrote:
> When the debug information needs to be suppressed due to ratelimit,
> it is unnecessary to determine the end of the corrupted memory.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   mm/page_poison.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index 3e9037363cf9d85..23fa799214720f1 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -55,14 +55,15 @@ static void check_poison_mem(struct page *page, unsigned char *mem, size_t bytes
>   	if (!start)
>   		return;
>   
> +	if (!__ratelimit(&ratelimit))
> +		return;
> +
>   	for (end = mem + bytes - 1; end > start; end--) {
>   		if (*end != PAGE_POISON)
>   			break;
>   	}
>   
> -	if (!__ratelimit(&ratelimit))
> -		return;
> -	else if (start == end && single_bit_flip(*start, PAGE_POISON))
> +	if (start == end && single_bit_flip(*start, PAGE_POISON))
>   		pr_err("pagealloc: single bit error\n");
>   	else
>   		pr_err("pagealloc: memory corruption\n");

This way, you will be ratelimiting on every function call, possibly 
skipping PAGE_POISON checks even if there was no prior corruption detected?

-- 
Cheers,

David / dhildenb


