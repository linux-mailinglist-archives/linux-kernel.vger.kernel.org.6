Return-Path: <linux-kernel+bounces-279081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7791794B8B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF992834BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54847145338;
	Thu,  8 Aug 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftFzSD9t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52832139CE9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104908; cv=none; b=G80JoP8XG+GWujV2cpU17JUS/rvCUCMh8fCHP/qqMf22h98DzvN9cp7PFSkY6Otne0H3CbR6pKhJPxlfAVjJDpZH94eSX61i3kHkHTMUUU3tD9LpMiirII7A6q9B8x7sGyS2JhJ+eQuURMk9Npor/8HPD5MThch6hGYK2xH1IR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104908; c=relaxed/simple;
	bh=PjUULOVF16mrDrRsJDcYFYImZ51HZzB6GeEicEhNtik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqG7pb1u78XIlKvqPeQTvHWWwFvHQjN6rgC4CAI8gCx87C4cxlSQ7/iftFaJ6skcX/5o6elLtYFnYY0cOaEcU3B0x1pwMhdSHVLqKkpOLWf4dWQDKWet9SXufhSVcpjD2Rp6XpHb6uO6gQa/pJgELq81Okcvhp8aWr5CpARLDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftFzSD9t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723104905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oyWJ8Aj+hBX0DWngQENs2Lb+oj2ROH3TU2+agxCUIlc=;
	b=ftFzSD9tyG6dMnMoxs+h4h38VFZbtgVgRsGfkmhzEDu3CpLK4Ki6vEkXgUs+UfKNNc9ijP
	SR4VZdFTA/gpnnk3+ll00KHoLC4lF2MPrGRn9S8y+sd9/lzI8JL6C76jLRJNvhGnuSI1lF
	7jRlbU4Ok14Tzr4Vuq04+HQAHl+vh+k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-8jAJl1fTN5Wgp50H-B3fRQ-1; Thu, 08 Aug 2024 04:15:03 -0400
X-MC-Unique: 8jAJl1fTN5Wgp50H-B3fRQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-530e1f3ed95so695449e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104902; x=1723709702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oyWJ8Aj+hBX0DWngQENs2Lb+oj2ROH3TU2+agxCUIlc=;
        b=h0BB3Mlpw4k0u+F3aEO2mA70XdBsXc+8Yl+qsJt/gqunGrDk1UQVBf5q04SP2vHqns
         e6eIEswCqvsxiV8P11n6NiyLAgMCVR01yDSmUZEHINKDqxrjoruXCmcG+TD3twauCe5Y
         rKAvv9OlwRr/Uz7aOHZOWpu+YHP9Pjiw8LxU+qyAdKQaduJ6c/bSCddSvBayy6ca1duG
         r9sLHtiJfacIOG+dLWaDB1PiCwZ5+rihCcgnPUBgS4Xeg8FNO60aCsEmkN5YbXRoa+F3
         H1uSAaIMwGwW4942BXtbfAYilqLGmB0iTzRSqxqCUPrQdx/uhHWTGZNRlOciHSP2+ndU
         DEbA==
X-Forwarded-Encrypted: i=1; AJvYcCWERzjhPPNXdAyVlmseB6PJCNuNJFMESxuwNi4y4vcgQ4UHw2/plppUeUSlpKyIa0cs+/79nFo8uxgLCa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CVJp5hXOFqmBy+EIluiPlHn13wzkzWap/9XX8bigtJd/xPGH
	QdYWpZr4n+EMUZQTzBMIeTgR9jCMbROwgwLCpFINMNgG8uxFK9e0Uk23pQkNSvSKnxxzYmv0LBa
	wV6GXrwakAE4MjWF4y8fHIwkzb7/iUgwyY01VWBgM0Q+kgV4Km4Tgcm7M1d97yg==
X-Received: by 2002:a05:6512:108d:b0:52d:8f80:6444 with SMTP id 2adb3069b0e04-530e58437bemr707690e87.32.1723104902052;
        Thu, 08 Aug 2024 01:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNAYynkuqXr7H0yz8pte8Qo1+3nKFVMeza8PvT3f4ee1PcafCymAQtrrtrAwdkbWDwo9CEhQ==
X-Received: by 2002:a05:6512:108d:b0:52d:8f80:6444 with SMTP id 2adb3069b0e04-530e58437bemr707672e87.32.1723104901429;
        Thu, 08 Aug 2024 01:15:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059bdd72sm60203235e9.39.2024.08.08.01.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:15:00 -0700 (PDT)
Message-ID: <95f97482-6270-4ec1-8bd5-9af95614bd5f@redhat.com>
Date: Thu, 8 Aug 2024 10:14:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: attempt to batch free swap entries for
 zap_pte_range()
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, hughd@google.com, justinjiang@vivo.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, ying.huang@intel.com
References: <20240807215859.57491-1-21cnbao@gmail.com>
 <20240807215859.57491-3-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807215859.57491-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 23:58, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Zhiguo reported that swap release could be a serious bottleneck
> during process exits[1]. With mTHP, we have the opportunity to
> batch free swaps.
> Thanks to the work of Chris and Kairui[2], I was able to achieve
> this optimization with minimal code changes by building on their
> efforts.
> If swap_count is 1, which is likely true as most anon memory are
> private, we can free all contiguous swap slots all together.
> 
> Ran the below test program for measuring the bandwidth of munmap
> using zRAM and 64KiB mTHP:
> 
>   #include <sys/mman.h>
>   #include <sys/time.h>
>   #include <stdlib.h>
> 
>   unsigned long long tv_to_ms(struct timeval tv)
>   {
>          return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>   }
> 
>   main()
>   {
>          struct timeval tv_b, tv_e;
>          int i;
>   #define SIZE 1024*1024*1024
>          void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>          if (!p) {
>                  perror("fail to get memory");
>                  exit(-1);
>          }
> 
>          madvise(p, SIZE, MADV_HUGEPAGE);
>          memset(p, 0x11, SIZE); /* write to get mem */
> 
>          madvise(p, SIZE, MADV_PAGEOUT);
> 
>          gettimeofday(&tv_b, NULL);
>          munmap(p, SIZE);
>          gettimeofday(&tv_e, NULL);
> 
>          printf("munmap in bandwidth: %ld bytes/ms\n",
>                          SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>   }
> 
> The result is as below (munmap bandwidth):
>                  mm-unstable  mm-unstable-with-patch
>     round1       21053761      63161283
>     round2       21053761      63161283
>     round3       21053761      63161283
>     round4       20648881      67108864
>     round5       20648881      67108864
> 
> munmap bandwidth becomes 3X faster.
> 
> [1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/
> [2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/
> 
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---

All looks straight forward to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


