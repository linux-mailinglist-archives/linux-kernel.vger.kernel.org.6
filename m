Return-Path: <linux-kernel+bounces-233501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540391B857
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0190287351
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F513C83C;
	Fri, 28 Jun 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg1qDH57"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B302F519
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559852; cv=none; b=tmxkc4LrVRB5WUiq2VRcIhuio1h+u4Bla3SYg2NGlTG17hxZ03oGNJ4iCsLKJ1VzG7O7SU+cOM29E0zmRXMnZY1OhpeNxhCoGgLDeoHpGWap8RykWTbpXy7DkMnclFRRuwY9Qv5ukcw0U01+cKN6ng8w5SszNNIckkwAIdE9PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559852; c=relaxed/simple;
	bh=v3O7aDvqXJ0rQTUmMXb73MtYUTy+nATehonjR7O0cFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TfFZvWzTWUI8JI4v59inxNcU3M6SCfRbVWo0K8WoGhm7DrHsyKbVPHVcItp9JQSVOZc5dAtkzcZZsiZ7tL9skBbZAdxa0IY7GdbmTPgZtFq6YRZ9RYAXkwuBntRVyxhHmsmMxTwQEl8NAMPIIKgLMtMAFi8FgQWIs8dL2hjQbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg1qDH57; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-375d22e537cso857625ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719559850; x=1720164650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3COrcGNqmtomZujIy8pN6XlwTlaJPfly7FSE+QE3l0=;
        b=bg1qDH57pVvt0NvIn1LmoaAC18Zc5zsDKVilh2uwtSYCpohGiMA+yguIvCq7bJmZQS
         pZMibJy9Bdb8Xue1m8O0xUbTYUOdXjAKPUFWN0r32lBl58dXUwKG+kD6UmILMupRZR7m
         5kXYkklupwlYWBqDoo+45mus8UBzQrQRtujjPVBASlrQQPrQvFC1MKZFhm50P5jVDpGU
         ETpnrTQUa8I9dHhp+mhZAFZDgKdwRfg7cmiufxpoZV+w5UyqHA0JfugQNaRn5XQYsKGO
         iPcqhsRyV26RNj0jAF37s7W1R4+keVSligYOWjbclDswOsl4o5WrQXuHOeC4TFqJMGMR
         opyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559850; x=1720164650;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3COrcGNqmtomZujIy8pN6XlwTlaJPfly7FSE+QE3l0=;
        b=Z6gpnfPAAskXBdf11spk02rFeHIiOByOBN+pCF60QP9R4qr2aoqhHEcJGbnzwjjneT
         AiV7UZMFU05O3vJgLRe3VXq3EZV3qmWNykLJMRZFQLWWsedScYRWjK+NHNGFM+TmHtdx
         SFr515Zz51lf1sOSIiGD6oLtY8HlT7jldG+c62SKmCrpcJ2WS5gd+Xnz7A/RTdOlDE92
         J+N2yF4Fg0rF+IBLgyH4XJI8nq6U0cu9d0V6m6JfdARvqieIdQDHl9hQhH1hWHkbQIsH
         i8iMOo+RPIdJRvZMKImzGYprc8/FANi5diNM4L6HRqvZO1mQjGyvgBcB/MqluUNd3Gf9
         Ndmg==
X-Forwarded-Encrypted: i=1; AJvYcCW7tGT1/DC6bikJWSXIFlC+st+EbCQWOjxudStDqlttYkIxOtaUU4N/b5zt6VyGliIt1sNFUn04dAVuKQANZXHbkHfWE/U9A9pRGTF/
X-Gm-Message-State: AOJu0YxOhm2s0VcGm9x/x+LCEBTnuYS3lafcEVD7L9nH9RrXoCZlm4q0
	E+4USfD73Lyu1nRv6YtdtItWTAD2f9/89QLUnTlhSgQ6BgsESpsb
X-Google-Smtp-Source: AGHT+IFvsNsB6NjUBCNs48zRCs5Ttt1AjpV03AkL5i2sMll1CEfreqAsT4UabD2ybDt/RzGa420xoA==
X-Received: by 2002:a05:6e02:13a4:b0:375:a535:f7c7 with SMTP id e9e14a558f8ab-3763f49c4c4mr240251805ab.0.1719559850479;
        Fri, 28 Jun 2024 00:30:50 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f76fbsm772447a12.73.2024.06.28.00.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:30:50 -0700 (PDT)
Message-ID: <8d128229-4b4d-44f8-b075-8cb1834636e0@gmail.com>
Date: Fri, 28 Jun 2024 15:30:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
From: Alex Shi <seakeel@gmail.com>
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com
References: <20240628031138.429622-1-alexs@kernel.org>
 <22ffc2f5-4bca-4665-91f3-82840f23f33a@gmail.com>
Content-Language: en-US
In-Reply-To: <22ffc2f5-4bca-4665-91f3-82840f23f33a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/28/24 3:26 PM, Alex Shi wrote:
> 
> On 6/28/24 11:11 AM, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> According to Metthew's plan, the page descriptor will be replace by a 8
>> bytes mem_desc on destination purpose.
>> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
>>
>> Here is a implement on zsmalloc to replace page descriptor by 'zpdesc',
>> which is still overlay on struct page now. but it's a step move forward
>> above destination.
>>
>> To name the struct zpdesc instead of zsdesc, since there are still 3
>> zpools under zswap: zbud, z3fold, zsmalloc for now(z3fold maybe removed
>> soon), and we could easyly extend it to other zswap.zpool in needs.
>>
>> For all zswap.zpools, they are all using single page since often used
>> under memory pressure. So the conversion via folio series helper is
>> better than page's for compound_head check saving.
>>
>> For now, all zpools are using some page struct members, like page.flags
>> for PG_private/PG_locked. and list_head lru, page.mapping for page migration.
>>
>> This patachset could save 123Kbyetes zsmalloc.o size.
> 
> This patchset is based on next/mm-unstable.

Sorry, just double checked, this patchset based on git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable branch. "4b17ce353e02 mm: optimization on page allocation when CMA enabled"

Thanks
Alex
> 
>>
>> Thanks
>> Alex
>>
>> Alex Shi (8):
>>   mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
>>   mm/zsmalloc: use zpdesc in trylock_zspage/lock_zspage
>>   mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
>>   mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
>>   mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
>>   mm/zsmalloc: introduce __zpdesc_clear_movable
>>   mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
>>   mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
>>
>> Hyeonggon Yoo (12):
>>   mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
>>   mm/zsmalloc: add and use pfn/zpdesc seeking funcs
>>   mm/zsmalloc: convert obj_malloc() to use zpdesc
>>   mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
>>   mm/zsmalloc: convert init_zspage() to use zpdesc
>>   mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
>>   mm/zsmalloc: add zpdesc_is_isolated/zpdesc_zone helper for
>>     zs_page_migrate
>>   mm/zsmalloc: convert __free_zspage() to use zdsesc
>>   mm/zsmalloc: convert location_to_obj() to take zpdesc
>>   mm/zsmalloc: convert migrate_zspage() to use zpdesc
>>   mm/zsmalloc: convert get_zspage() to take zpdesc
>>   mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
>>
>>  mm/zpdesc.h   | 134 +++++++++++++++
>>  mm/zsmalloc.c | 454 +++++++++++++++++++++++++++-----------------------
>>  2 files changed, 384 insertions(+), 204 deletions(-)
>>  create mode 100644 mm/zpdesc.h
>>

