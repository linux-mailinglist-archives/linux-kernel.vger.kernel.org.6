Return-Path: <linux-kernel+bounces-211071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E4904CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C551C23B66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218416D30D;
	Wed, 12 Jun 2024 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMyplx7m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF454FB5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177038; cv=none; b=mWK+hORyvwTdx9vh+rAT8Lwrwp/2t1BVe1LphlZMsoPZvNgcqmm1XZwLgR87L7DLID9WHRLTvU6gjzp8VqA0BfUn4HYF5ZnYgUTJiTlALHVO0LNrs7vs0xkOwxN3VNo5/GJYsjzo5QAdPTwkLfFhcB3Tr3yVqsqXX8o4X33QzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177038; c=relaxed/simple;
	bh=zyeH7hpVXD5gOotVuNMmMsh0jgjOfSeYs9k3afJeouA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLmI3Q76AJ6PVlMKVuNGcXYfOaGpeY9LOhw6+PcREzhQf1wlwbP4ezZjHxXH+v0PtyNMlQlRcm16pX2HqI0ChwuWaM1x/dIMp3SHCanOD7yC98a+yEbG/Ai8hEW32jK6B+sz28tL/sTIjqZmHjhKSM/v46fKljwC0OJaLJ4HDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMyplx7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718177035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=79mN57PblL//gRfMCssaahRjclAPb9+bPKf2dv1SbGA=;
	b=FMyplx7m1W4SKGK+6N2jUwfMh5B4xXvdY5v9G8iJEK8p2nvnsq6Hp27v5sByMLs6w55ec2
	AhufmTXRDbAdugxkJ4WXd8ikzY24LAht4dH5iigr9b+8iqAuxFDAQzQfh0OwB6y7gRF0BR
	uKBuo70R+jeIpYdcHLoVBkuypYRZkgI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-93ke1z50OtmGCzACa_vj6Q-1; Wed, 12 Jun 2024 03:23:53 -0400
X-MC-Unique: 93ke1z50OtmGCzACa_vj6Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so23813135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718177032; x=1718781832;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=79mN57PblL//gRfMCssaahRjclAPb9+bPKf2dv1SbGA=;
        b=AwZiaK4aQkFIupTci9aXeCDSqhJzb2v21PSVtshUgl2cZ4wS5TfGs2vbEneAIgX318
         +ESd5WhK1CpBfTjWAsk3ZTEqt3rL7nIYeLMNIBvKfeMp22qQD1lN40r2T0x+ZbVC1ppN
         cUW1vbq1dTV933VgAYpAJSaBfcnDI3HTb8UVe7ThrHP0QCnvQygA65UzURN5b4i/DeKU
         mWMCErvkvlMci86lhi4kaXct8Ndu89iA2XBETaWa8/R2Xo+5wj37p/PDQstispKHrfda
         kqAkzIdMjOn1/Q+zGw4lCa3e4wZtFWOmDf/Ll5yzpPxn43xgXjU28Z0OM2g6iDm28vs/
         ezCg==
X-Forwarded-Encrypted: i=1; AJvYcCXuF2KaaWKGtQSNQN2Sq5q6E9SvVkwi1coL1nXfyExEZAv9PlNPu2GJ8KV/bbPgTd3B+ZiM93x8v4Sh557ns8DFUyr3wZaOJek7yd4c
X-Gm-Message-State: AOJu0YzUSwrnM8YwmL+oCn0M8eMyo6TN71urOUuSXsroZidKRkU3A3Ib
	C6eB4GulrDRQzAdEJ+ajKV6uK8sLbgHSXPs9G4tZs1Vz1jJJSQdS2bEPidM3rMtlFgV3TdtgQmW
	Zg8tUgyt4yaXDPQRbTkR96bGvLamvx4nxN2zxqKpvbFgDldDn9Xj9KSmORfm2Xq/W9uwD7g==
X-Received: by 2002:a05:600c:138d:b0:421:5966:ca40 with SMTP id 5b1f17b1804b1-422863b4838mr11414535e9.10.1718177032181;
        Wed, 12 Jun 2024 00:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtj8PBXU2plzI2QtlIeeLdg/YMNZ/9oe3xZYexWTW7W2BruHYPTtRrm2ij9fTk7U2doAjf8w==
X-Received: by 2002:a05:600c:138d:b0:421:5966:ca40 with SMTP id 5b1f17b1804b1-422863b4838mr11414285e9.10.1718177031531;
        Wed, 12 Jun 2024 00:23:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:bf00:abf6:cc3a:24d6:fa55? (p200300cbc702bf00abf6cc3a24d6fa55.dip0.t-ipconnect.de. [2003:cb:c702:bf00:abf6:cc3a:24d6:fa55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2169fc45sm8245554f8f.10.2024.06.12.00.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 00:23:51 -0700 (PDT)
Message-ID: <03f1f5a5-e2eb-4dec-9c03-5d00243ee485@redhat.com>
Date: Wed, 12 Jun 2024 09:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH unstable] mm: rmap: abstract updating per-node and
 per-memcg stats fix
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <49914517-dfc7-e784-fde0-0e08fafbecc2@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <49914517-dfc7-e784-fde0-0e08fafbecc2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.24 07:10, Hugh Dickins wrote:
> /proc/meminfo is showing ridiculously large numbers on some lines:
> __folio_remove_rmap()'s __folio_mod_stat() should be subtracting!
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> A fix for folding into mm-unstable, not needed for 6.10-rc.
> 
>   mm/rmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1567,7 +1567,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		    list_empty(&folio->_deferred_list))
>   			deferred_split_folio(folio);
>   	}
> -	__folio_mod_stat(folio, nr, nr_pmdmapped);
> +	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
>   
>   	/*
>   	 * It would be tidy to reset folio_test_anon mapping when fully

Missed that detail, thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


