Return-Path: <linux-kernel+bounces-224019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D8911C07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137AD2817E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9F1649A8;
	Fri, 21 Jun 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haNqaWHy"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601A15624C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952246; cv=none; b=A/q58H0t6yxZYorPNBKbOPGD2lQPIRvJQobt2I/gyKOz50CIpaBBPsV+YfctXnRRwY8Qtdp5LZHkDo0R8BiSpKVAjEoda3KC0azmIUdCPD+egawIs7df3EaEYHoSPHjhgfTuNcYSstPdTQPPYMkvj4ixs3bDhy9CFiGjTCVudHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952246; c=relaxed/simple;
	bh=nhcmvGnnHEuaHFzQcYbt3CTcyyYu6sUbA+s1f3pVEdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OKSUSk3YDqYD1eTmn9/dVUAvbwQneDPsId1C0eyzkQJgU4h/dvq3mGvKNUSgQBoIDe+rDMwxQei/SwYfR0/CdDaMDgAdSbQ1qs3u/JVlvpfRHgj2QiBrseQ7vIQr8awh+VfWqsne0d4q14zdMmEqasOB/1sJ+lDFciV2vJ2pxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haNqaWHy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70436ac8882so1400890b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718952244; x=1719557044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+594vb27iUnZDSTatKmhnwO59pI3iB7FBBFD3X7DeM=;
        b=haNqaWHygW/r30iv/gn04mXfjvS9iXr/K62A3o/C7Z8sEpucsTiro5I5PuV+r255TG
         kIBLkdh05Vw6rusgqiInWwqHYHUDYTr/OCKAO78PrqHhEVKg66OzZ4kVfuPT6DQ5xV+v
         rSU+GdDlRYbsZrZavobPGm+oNtB60vnf+mDZwJ9wS07Ssmd906XjVwbcTBjRAp5Mao1X
         yxry/XgofwjnyNEylgB/Q+hmi6KiPDawVhrCe+6w3EH2nNNgiIeybqv6CFCG8e/b99qu
         avXLHykeO8C67KHrMXnjaBcTiRZ7lZs00GX94yFGeerCKU6cmGMu8g05313SFFx2Ce7/
         a1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718952244; x=1719557044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+594vb27iUnZDSTatKmhnwO59pI3iB7FBBFD3X7DeM=;
        b=GC+drq3FDZrxZUN+62ybJL72ZoDdapjMNV8db9/gJ1JkXSQdGE8MjtsezBauL0gDYd
         mW0wzoQ49SXs65fr9BAgje7k+ih/S56nxw/6bqAkIHOqVdrmCJ/8PEFHcZzJOEESPq7L
         eGpcnWgXLeK9ziMSO3p2L4MGIYPeAf4mSXrc3hyOSTuFkkmE0oE11KCc7Df2Zd4rSalB
         W/t1okjr8bGGw2ubBeuwduABgLYoUnHXb4mxZ9JXNelkV8kwq9laxzMO9vs8QpddcKVs
         BP+0oLHh+fJytBrW3loLsTrgQZkR6w0OagNdMiwVC381k8LrN6OVG07Oy79zxQouxX83
         +Xog==
X-Forwarded-Encrypted: i=1; AJvYcCXJPYXN4+t3e6X9KdR7gR7lNnY6kAfWFnPn9K16YgY1Yq9/ZwF3x6gZ3TjQI0XGeiFafwilvm7TCuYl8pAH/uSW1SUxfzcAB/sOBnLF
X-Gm-Message-State: AOJu0YxAS3H80FIwCTb11vpAMie92in7Iav5cbvDtwZTncJH6rDezW/M
	qP9ZChuhnOT6HayEgFFkoCd05Xwqi7PxgFMexotsIU7Aka4uFr/1
X-Google-Smtp-Source: AGHT+IGgsSAAAnAcSy1xgA+1CUqQn4IDFTUITGxa3vybVMINzCpds9LRH6QWvTUCgq4LfXHEKULh/g==
X-Received: by 2002:a05:6a20:4881:b0:1b0:1a02:4136 with SMTP id adf61e73a8af0-1bcbb386b43mr7134680637.8.1718952244412;
        Thu, 20 Jun 2024 23:44:04 -0700 (PDT)
Received: from [192.168.255.10] ([101.87.0.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ec6595ebsm6653055ad.25.2024.06.20.23.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 23:44:03 -0700 (PDT)
Message-ID: <15ee2753-a3f6-4b41-8afa-344ce9154161@gmail.com>
Date: Fri, 21 Jun 2024 14:43:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com
References: <20240621054658.1220796-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/21/24 1:46 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> According to Metthew's plan, the page descriptor will be replace by a 8
> bytes mem_desc on destination purpose.
> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
> 
> Here is a implement on z3fold to replace page descriptor by zpdesc,
> which is still overlay on struct page now. but it's a step move forward
> above destination.
> 
> To name the struct zpdesc instead of z3fold_desc, since there are 3 zpool
> usages under zswap, zbud, z3fold, zsmalloc. It looks like we may extend the
> zpdesc to zbud and zsmalloc, combined their usage into one.
BTW, 
Thanks for David and Willy's suggestion!
Since all zpool candidates are single page users, then we could use zpdesc to
descript them all in future.

Thanks

> 
> For zpdesc(page), z3fold just uses the 5th member zppage_flag, which
> match with page.private. Potentially uses the first member flags for
> headless PG_locked, list_head lru and page.mapping|PAGE_MAPPING_MOVABLE
> for page migration.> 
> This patachset could save 26Kbyetes z3fold.o size, basely saving come
> from the page to folio conversion.
> 
> Thanks a lot!
> Alex
> 
> Alex Shi (15):
>   mm/z3fold: add zpdesc struct and helper and use them in
>     z3fold_page_isolate
>   mm/z3fold: use zpdesc in z3fold_page_migrate
>   mm/z3fold: use zpdesc in z3fold_page_putback
>   mm/z3fold: use zpdesc in get/put_z3fold_header funcs
>   mm/z3fold: use zpdesc in init_z3fold_page
>   mm/z3fold: use zpdesc in free_z3fold_page
>   mm/z3fold: convert page to zpdesc in __release_z3fold_page
>   mm/z3fold: use zpdesc free_pages_work
>   mm/z3fold: use zpdesc in z3fold_compact_page and do_compact_page
>   mm/z3fold: use zpdesc in __z3fold_alloc
>   mm/z3fold: use zpdesc in z3fold_alloc
>   mm/z3fold: use zpdesc in free_z3fold_page and z3fold_free
>   mm/z3fold: use zpdesc in z3fold_map/z3fold_unmap
>   mm/z3fold: introduce __zpdesc_set_movable
>   mm/z3fold: introduce __zpdesc_clear_movable
> 
>  mm/z3fold.c | 190 +++++++++++++++++++++++++++-------------------------
>  mm/zpdesc.h |  87 ++++++++++++++++++++++++
>  2 files changed, 184 insertions(+), 93 deletions(-)
>  create mode 100644 mm/zpdesc.h
> 

