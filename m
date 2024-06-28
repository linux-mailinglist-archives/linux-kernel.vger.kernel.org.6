Return-Path: <linux-kernel+bounces-233494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2766E91B83D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959D128154F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54313F00A;
	Fri, 28 Jun 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNxjpojg"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4505558BB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559594; cv=none; b=GKrvhyc/CD1n7Yw2Ah//43feYS2J7rU6TaOknP7byn6awCTWXZTEB6QuX3Q6lYa9BxkTfMqj1wB22iyuimVOnJ1xH2Nemgm/i3obzFRB4xVI0C5bEzl/XiDRhbaaLl9NmqETLQm1uOk8Oknyzg3Zyep9wzcu18AtM7fHGWnV9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559594; c=relaxed/simple;
	bh=adR6d+0EKwyeVIq5GLDcxeL30REYrpQmEuVRzxuSAGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aG+Q03YGyJkDS4UiybWux2vu1h9fdIGENpFdcvK+Cd2vRM5wqhoG6vLjDHfZ3L2tv6IleW0bdwG9wa/W448y0CuRXGrij69fhnpM15Wi9tkoQOn2DMmn9go352IWMtT8y2b36JeNmXmHgXSFlGG9cskJ0+UvsCDcDHvrXW+ht8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNxjpojg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706aab1b7ffso273143b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719559592; x=1720164392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4fsXPA8V8mapSVEUxysocSmDOq0wah1u6Wk1zqZsUM=;
        b=HNxjpojghr5dAsWii76Ag6rB+HJzLuzoh1Z00S4W6mhmKGDH9IJ5R5AU5+J/MkcsZj
         6hruUnsRLJauLgeUZTNAqMTMoTKX1dLUjRc/13IGAcrOSvTw5YQHTwlgNXUq/h8o588a
         QdDGgECyJKdV+n2pEX4r8O2k4POw1v/ldC/X5X3FbLyvcozQKbBzO+Hb9Jj7OS3eufbs
         WXs6MjJ7OmRXcubeLigho8GJOa6T+B1tE1N4f1kFO6xyzDEtl5yGzhp2th1fYOac7P4u
         3KOe0SOKuu0GwcO6kZvJJcNco5mDKP6MSTOD1KvK1I8a8apm7ttfY1/nbTA/LNxBWQou
         rAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559592; x=1720164392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4fsXPA8V8mapSVEUxysocSmDOq0wah1u6Wk1zqZsUM=;
        b=kG7hVQ1yxaJOJTKGwDAavXHp1L7WkbmINikKOC4/wRQIi9j9kFF7GZl3flP3G8UCW7
         0ZWGcG30fZN9rRaWpUN9fqbX9qDV2ccO1tmCQRkMOyI7Z/m6ugFl+MUft9f8AYkwPVV1
         ZcxlaKpvRxaHyzU0MgW+PZIa9XJvbCa2+Cni2cQxj+jeByFwFwGXZIZGwcmwoTZFGXz2
         UOFPmWf6Cvz3zqzxQC7W9+o1tYcYDrYCQ/Eka5DEpS/Kf0ARSVldx4xIERmZ7SRYNSSw
         /nV+UVYy0WD5IjVyPhaPTdyNZFE1NYND4Sc78Bkhv5d8uVBxV/MrJbpm821FmFVLfwT6
         u02Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZD6ScBJILSS9OtiI4Hi1iChPxVGOae2H8O5Y9kG4JLgaxR9eUcz4qbWxC2TToQcmyddds1YR1QWfaRSKqeIE4CZEyMJCK4gk+IJzq
X-Gm-Message-State: AOJu0Yy5bBn/uvQwqVvDIrRJl8KpCIFcj2zDZyA6vncAWSy/0uy8h04O
	TrCrHCYh4iL4AZW92tNoZ8Itc+VtZUtCRJshhB1HtzUL3oAQXA92
X-Google-Smtp-Source: AGHT+IEjPesnUlLmfZnPjNF3zT/ywZ0po4AnFcw+LL+6foBH+MxpH9kowpSiLIZfkGOgc0xZnMJ33w==
X-Received: by 2002:a05:6a00:38c4:b0:706:6824:9c53 with SMTP id d2e1a72fcca58-706745b43c8mr15687883b3a.10.1719559592014;
        Fri, 28 Jun 2024 00:26:32 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045ac8b2sm890075b3a.183.2024.06.28.00.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:26:31 -0700 (PDT)
Message-ID: <22ffc2f5-4bca-4665-91f3-82840f23f33a@gmail.com>
Date: Fri, 28 Jun 2024 15:26:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com
References: <20240628031138.429622-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240628031138.429622-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/28/24 11:11 AM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> According to Metthew's plan, the page descriptor will be replace by a 8
> bytes mem_desc on destination purpose.
> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
> 
> Here is a implement on zsmalloc to replace page descriptor by 'zpdesc',
> which is still overlay on struct page now. but it's a step move forward
> above destination.
> 
> To name the struct zpdesc instead of zsdesc, since there are still 3
> zpools under zswap: zbud, z3fold, zsmalloc for now(z3fold maybe removed
> soon), and we could easyly extend it to other zswap.zpool in needs.
> 
> For all zswap.zpools, they are all using single page since often used
> under memory pressure. So the conversion via folio series helper is
> better than page's for compound_head check saving.
> 
> For now, all zpools are using some page struct members, like page.flags
> for PG_private/PG_locked. and list_head lru, page.mapping for page migration.
> 
> This patachset could save 123Kbyetes zsmalloc.o size.

This patchset is based on next/mm-unstable.

Thanks
Alex

> 
> Thanks
> Alex
> 
> Alex Shi (8):
>   mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
>   mm/zsmalloc: use zpdesc in trylock_zspage/lock_zspage
>   mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
>   mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
>   mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
>   mm/zsmalloc: introduce __zpdesc_clear_movable
>   mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
>   mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
> 
> Hyeonggon Yoo (12):
>   mm/zsmalloc: convert __zs_map_object/__zs_unmap_object to use zpdesc
>   mm/zsmalloc: add and use pfn/zpdesc seeking funcs
>   mm/zsmalloc: convert obj_malloc() to use zpdesc
>   mm/zsmalloc: convert obj_allocated() and related helpers to use zpdesc
>   mm/zsmalloc: convert init_zspage() to use zpdesc
>   mm/zsmalloc: convert obj_to_page() and zs_free() to use zpdesc
>   mm/zsmalloc: add zpdesc_is_isolated/zpdesc_zone helper for
>     zs_page_migrate
>   mm/zsmalloc: convert __free_zspage() to use zdsesc
>   mm/zsmalloc: convert location_to_obj() to take zpdesc
>   mm/zsmalloc: convert migrate_zspage() to use zpdesc
>   mm/zsmalloc: convert get_zspage() to take zpdesc
>   mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
> 
>  mm/zpdesc.h   | 134 +++++++++++++++
>  mm/zsmalloc.c | 454 +++++++++++++++++++++++++++-----------------------
>  2 files changed, 384 insertions(+), 204 deletions(-)
>  create mode 100644 mm/zpdesc.h
> 

