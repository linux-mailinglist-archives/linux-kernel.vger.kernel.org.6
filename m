Return-Path: <linux-kernel+bounces-438607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA879EA376
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3954D165189
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D261853;
	Tue, 10 Dec 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBeGPWpz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909D3C17;
	Tue, 10 Dec 2024 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789557; cv=none; b=i8wZCTgQnWX/cPfcWflzqrDx9uo77n1kVotvcWqDsv6+3dlv6ramivumVg85Awb4u5skebccD/MOpdsIMwaVHB8S4mvzPsABiuSpPri8bDwe6ypAsCfEu0y8+akT/BYkJqTIrf0853wWRYIg8m3def8/XXcQtmdhjVHYIANfMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789557; c=relaxed/simple;
	bh=XXXWKptAmTwRcq85PkLPTTYOgUju21z/EewxJbfa/PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXPaAC+kzFxe6vuHfyr8WbtYdpNXTyKucepsWMKUC4LH0bfH9KwMck+9pFTeoLUMWqpbzMtvi5H2qwovtGkkY2+cG/hNv4FSHDFj+26Q8ykgEwUx36pQ9VFZkaf/WPBzxb1HGkkzrp8bgrN9OlU8l3/0et8MzA57iqOqwdbuhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBeGPWpz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-540215984f0so1268307e87.1;
        Mon, 09 Dec 2024 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789554; x=1734394354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydjttIzPV3bTnYaTafALagMKlXhc79P8oTkSG55qp8s=;
        b=MBeGPWpze+E6ZDqddXYLHf0tPbypYQ426FjeC7R2NFm7S12LwPA2k5yKc91DlP0TTp
         YK9PE/uRJluJn85vW4tPRnqjPWZdA/KH64QHhSd1LCmylbbQR2VOg1+MzTtR58lBahoq
         UBKbZxmk0yD8AN/PaNo5zgiTCPdDhSVWOtxNOy97VaUbgoINjyCoeaFf035ZMNRcKnGN
         YNRH2Sjc/lR4WwmwmHnkVrCpT7vMz4ZFuqYpNgnkW798oo8wA3GP8sx6B1qAwB2V/CJO
         /eYis2QmSRxluxPXaV6qW3M62ZS7feOMBmz+xbdoQz35AlnEPfAnfVissKXf9npPS7Tn
         vCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789554; x=1734394354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydjttIzPV3bTnYaTafALagMKlXhc79P8oTkSG55qp8s=;
        b=pg7J9UnP2zFK1FGFnsc54zVbeLy8pY4URLpUcxkgOYECtoIjVawAoLh8yNtSbik2E5
         pEQAI2fi/QOdz887NM6wUUU72DJFO93LFxBfnIVymF3X9wyZLD5YuKNuc5PDD74QemQ+
         ZdqIyzOZ9TEhS/s10s75/VoTfy2c1qFEwgZKNmDAlpO31UNCCSn11V9uQ5gKqFrulS1+
         QJQNk4AQKX6/7Q5zwuzyetgtxFsc4HYl0nAWsbSZbRUP+PilOZask1ZlUBTuhB9okcGC
         dkJ290DIU8F0Mz/WPdJcNAd/uK4bxhGvLFLUOjR4yCW7EqGnb2aAzkRhBL9SV6qbRgKD
         LjGw==
X-Forwarded-Encrypted: i=1; AJvYcCWzxBXYpy4uWa4FknHZ0JEO+BNXfpmVT3rTYdRb/hH8rUZZsqG9R00VMDaKzso+upQnoK6lZ8AMdOybXcIJ@vger.kernel.org, AJvYcCXdd9X/WnFYaMK26K8rjJQ2TPEwRHYVqTCMlnr6YR29DevdlFImBl0yOOdbkd9nhl3OTJcugF1rwuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1N0LbhdKsLxHaFk/uyHZO63fm15n/lUtqyCbh2RduLTqFbJOy
	NUmVSdBhyhGqj22hL9ji2qZKUHd1/SwKy813bHC7322F0GsWQsVa
X-Gm-Gg: ASbGnctrJ2ODBmaZjugKIOXduQjH8Pptl4NEJnCv8mrY4P2jBNz9bxN/tj5dIZjrfy/
	EaudASWxSqyncnaZMbJMCqydLiXZ2qESJJ7pEjD9knLSNSx5JEEZdOY+BqRWS8L1MSTMA2dp8mv
	zsqmh3LcmLoe5iZ6j9a04p7fUxT6LrYhndkeJXhTCAZmIO8XhZWP40IpmekSoLMV9693hpYDoEj
	HF69s6/IOerW6+bL4j19kQW8PVz8GEbLGl4hZhRiPcpyWDQfCOOXzorTn6TEU7hdLp7ZF5z3a9v
	SwBcTIuRE5c923qa5mbjcWDLEXAQIzhZzk2rWys=
X-Google-Smtp-Source: AGHT+IEkgRTvfbOQFRL66kZv7c9jxP4bDxQA3ziPXEQ3Z5UPCXU/Iw8RVd1OEeT5XxFBiYJ138ho0Q==
X-Received: by 2002:a05:6512:39c4:b0:53e:2ed9:8122 with SMTP id 2adb3069b0e04-540240bd4cfmr1042449e87.22.1733789553960;
        Mon, 09 Dec 2024 16:12:33 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3c491c19sm880431e87.50.2024.12.09.16.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:12:32 -0800 (PST)
Message-ID: <10cef75e-92b9-4005-a9f6-10bc8b1dfffc@gmail.com>
Date: Tue, 10 Dec 2024 01:12:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: fix vma_copy for !CONFIG_PER_VMA_LOCK
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: oliver.sang@intel.com, willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, mjguzik@gmail.com, mgorman@techsingularity.net,
 david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
 paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
 hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com,
 shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241209221028.1644210-1-surenb@google.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20241209221028.1644210-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-09 23:10, Suren Baghdasaryan wrote:
> vma_copy() function for !CONFIG_PER_VMA_LOCK configuration copies all
> fields using memcpy() as opposed to CONFIG_PER_VMA_LOCK version which
> copies only required fields. anon_vma_chain field should not be copied
> and new vma should instead initialize it to an empty list. Fix this
> by initializing anon_vma_chain inside vma_copy() function. The version
> of vma_copy() for CONFIG_PER_VMA_LOCK is fine since it does not change
> that field and anon_vma_chain of any new vma is already initialized and
> empty.
> 
> Fixes: 85ad413389ae ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.com
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/all/d0ae7609-aca4-4497-9188-bb09e96e7768@gmail.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Applies over mm-unstable
> 
>   kernel/fork.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index fec32aa06135..d532f893e977 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -524,6 +524,7 @@ static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *de
>   	 * will be reinitialized.
>   	 */
>   	data_race(memcpy(dest, src, sizeof(*dest)));
> +	INIT_LIST_HEAD(&dest->anon_vma_chain);
>   }
>   
>   #endif /* CONFIG_PER_VMA_LOCK */
> 
> base-commit: 6e165f54437931f329d09dca6c19d99af08a36e1

This fixes the issue for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

