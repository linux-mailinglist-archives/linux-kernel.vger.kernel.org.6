Return-Path: <linux-kernel+bounces-514558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544EA35885
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C61692AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B5221D8E;
	Fri, 14 Feb 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwEoIHJJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04B22155B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520506; cv=none; b=F4RMotyBoQ2O/rA7vE84yiv7ptDoVoN3tjE/3JLXKGLR+zXubh7VJJSFvCWKGVeIVeZnkZMD9tdwDs7e/1t6TynURCCTGxi9AZX1qpYRYFFQHuku8mu/r7WZTwTnjYpjOmuJluZpmZJ1JmDJcE5cEyWAhwm4T1yN0pvfkOx/81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520506; c=relaxed/simple;
	bh=BH+R3DeaVEFkeBBM6A+bBYTJgrlpDE3DtYh3x94HZks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkaKKu4zRwFGhO4+vEoIWxIQBUubreKdJoerQ3MpGap3FXOG4Lzr7LEBQveljwd2Q2ByJ+2oFPcPmPTovNmQDo76OkcsLdaRQ9wi3nffrSGneIZ/+KU1irBflDTq6JW8q9/c8MwlDWvYWT7G6Jcm6kBMkvlbczTnNeKTcFhrSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwEoIHJJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739520503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ALk/+QsFRqtPl0vuqEBrVk2BlK5oNcB8f3FY4atPu5g=;
	b=hwEoIHJJlq/5e2luGZH+QgXdTJaaXP8jEcXd8Abvm6kTGzHZfbNHqGHG0CJPxwEtn+/pHM
	v0GDq5Qwe4QoxtVVy8sCq51K/Uq8qBmnzzi2egCz4Zf71RRB2JS+Cm5g4isx4zxxWDhkdc
	CM0EkSwmfHS7QsxesF53VsTs7BRJrLU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-4JK_CAMNMv2q_RvJyVJCPg-1; Fri, 14 Feb 2025 03:08:22 -0500
X-MC-Unique: 4JK_CAMNMv2q_RvJyVJCPg-1
X-Mimecast-MFC-AGG-ID: 4JK_CAMNMv2q_RvJyVJCPg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dcc9653caso918154f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739520501; x=1740125301;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALk/+QsFRqtPl0vuqEBrVk2BlK5oNcB8f3FY4atPu5g=;
        b=NaYUiFM7dsjQlE7JAq7w+8/o8vWYkxMghPK6VPtZS/XVu2E+bDIRDJMNhCB5oxDnTH
         p3AEOoLGtcKF3BUDhwCgGuUAW5TgpD2VR5GGJQGx/Wl1cH0ni2OajaqUibwgi/YSjh1H
         vg/vhtTg38yI5lnx6DuxY658a4QeDjeRqMRtHbWk1DjO6dXcT7YOyFfHLbHMICy9BAKL
         5jbL6Ti1xIe6oKBDwSWywJsySy4g5IpO7O6qVhlXVXK97qSgRKT13QcVU0gIBymJ5j0e
         UuScsdjbkde4HnDI+h7lk2DJ8GKg5I5a+qsd971bh1CwTeQ5SpUyKB5Bjs5PLvOixIlA
         SzuA==
X-Forwarded-Encrypted: i=1; AJvYcCXcq5v9ddy9kV/tkWQMSFitqlyISrkig7IG0oFlj0S+onxOV7FsoQb8+1EANe4TUXEg0uez8AjEzY+DwQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTVu3cYgO06w5llYQXOZkwkdfaXg2lC3AbvJjtUAbeJdssQE/
	KDLMfpg4hVxNCxorzn5K2vjpU/4s2iZMMTuOXj7q1X0iH/FCBTwnic0OvZvUTPICFLiv4bv68YD
	IN8jnHgXXh1jWnvmIa0Tg1NGi/EEf1iD+hBuWAXDF5FxqydrUzPKbRWZnQU04kg==
X-Gm-Gg: ASbGncvi+xL8z2GUPtSM1E6V9mnNiy/hJdCkBT3H8H3JkOQ2aV+ZkptnMW6aTd4B8IB
	5xZT95uNiK2dMB0A45IgqRwQbkckP+hAfxBJRg5kur4Dx2q9p+xKrOymJTqgayxGUFiruNqb9aW
	5F61Tqn9l3qytInVPyHqtYUXS4XT2xSIWepn8H8rtgvnQ9G1+1/Z/BmOf+2rnVdnk0uf6GBVP+8
	2bn4MShkv1SAj3uckQTNsvnn6QRI+RnE7cEJtLdvztY6vEjXLbjSZKGPsdSxYkguUB2kfJBSP3O
	wFU2HqTp/fSVSc+Vwi9vX/m7v7+h0LKd72VggXyED+dH6guDEuCe9ovutz2hnKfvCfXAXiuAQLp
	8ZO3STuLfJoWb54+qU9jXG5i8vgjyrQ==
X-Received: by 2002:a5d:64e4:0:b0:38d:e584:e944 with SMTP id ffacd0b85a97d-38f244e7b39mr7640409f8f.25.1739520501131;
        Fri, 14 Feb 2025 00:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF88OUJBIRdGRmRlZpdC9r3dGoNyEx2raYg4TWW28uJG4QVHn2dmMATX6H9nKtGJhgZv1oquw==
X-Received: by 2002:a5d:64e4:0:b0:38d:e584:e944 with SMTP id ffacd0b85a97d-38f244e7b39mr7640377f8f.25.1739520500760;
        Fri, 14 Feb 2025 00:08:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a00:7d7d:3665:5fe4:7127? (p200300cbc7090a007d7d36655fe47127.dip0.t-ipconnect.de. [2003:cb:c709:a00:7d7d:3665:5fe4:7127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fe1efsm3976063f8f.97.2025.02.14.00.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:08:19 -0800 (PST)
Message-ID: <37363b17-88b0-4ccc-a115-8c9f1d83a1b5@redhat.com>
Date: Fri, 14 Feb 2025 09:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: wait for hugepage folios to be freed
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739514729-21265-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1739514729-21265-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 07:32, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer freeing
> of HugeTLB pages"), which supports deferring the freeing of HugeTLB pages,
> the allocation of contiguous memory through cma_alloc() may fail
> probabilistically.
> 
> In the CMA allocation process, if it is found that the CMA area is occupied
> by in-use hugepage folios, these in-use hugepage folios need to be migrated
> to another location. When there are no available hugepage folios in the
> free HugeTLB pool during the migration of in-use HugeTLB pages, new folios
> are allocated from the buddy system. A temporary state is set on the newly
> allocated folio. Upon completion of the hugepage folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it is
> directly released back to the buddy system. However, due to the deferred
> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
> to the failure of cma_alloc().
> 
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>      ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>          ->unmap_and_move_huge_page()
>              ->folio_putback_hugetlb() // Free old folios
>      ->test_pages_isolated()
>          ->__test_page_isolated_in_pageblock()
>               ->PageBuddy(page) // Check if the page is in buddy
> 
> To resolve this issue, we have implemented a function named
> wait_for_hugepage_folios_freed(). This function ensures that the hugepage
> folios are properly released back to the buddy system after their migration
> is completed. By invoking wait_for_hugepage_folios_freed() following the
> migration process, we guarantee that when test_pages_isolated() is
> executed, it will successfully pass.

Okay, so after every successful migration -> put of src, we wait for the 
src to actually get freed.

When migrating multiple hugetlb folios, we'd wait once per folio.

It reminds me a bit about pcp caches, where folios are !buddy until the 
pcp was drained.

I wonder if that waiting should instead be done exactly once after 
migrating multiple folios? For example, at the beginning of 
test_pages_isolated(), to "flush" that state from any previous migration?

Thanks for all your effort around making CMA allocations / migration 
more reliable.

-- 
Cheers,

David / dhildenb


