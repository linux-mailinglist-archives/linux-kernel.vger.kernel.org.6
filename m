Return-Path: <linux-kernel+bounces-251971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75187930C60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C88E281429
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520064C70;
	Mon, 15 Jul 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC1O/S4u"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FA4C62
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721007193; cv=none; b=DN22ZoJNxTnZSc00raZw63krtmE7gMbuB6bvFSyB6rSakaPcnq+UM9LM51mGTf/AkzlnVFfbmcDTwgQ9RcMqBqZd6Dc958CDrQeDMR7pwiUxpTMh/IEYRdMs966ilpPZcFKjy7AvRC4cj3FFTuNcOfdsPxOvY6udG/HrnCct/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721007193; c=relaxed/simple;
	bh=y11oxM6FZQKiL8Gp0mXqb0AnYG5gpI1YHPDuHVBqbCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dHaJv4sQXcj0IGhXxm+if7Ww+Kqsdb2BHtjM5d3vzw377XwqvxKD3VXQ4P+KURupHvKAYS6Mw8JFc1wwzpEdgy+WR73DWAVRJINy0hdzjgauAg0ydCBiL128+5h6f/ppbfqZzJHU4m7Iz9f2v971i0INVMUG7RNPLUocgsJSNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC1O/S4u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb1c918860so33443125ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721007191; x=1721611991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQwnzP38ldU+pzsKvRMORy4OwiKshmlc+I/N7QR8eVw=;
        b=bC1O/S4up+BQp+qgOrXXAhMnlRAs6p22zEnG2jaVPLs5rI4N13r/fYRniXQpVw7kka
         NOohHQ7K/mYpcI9WhwILQkrsc2Xjez0PRmMyfVx+67XMJVeIraNJU7j2sJQtIVHjLIzU
         TgYjfFMfHM1ZEVUSVLt11DxPU4n3ERrktDK/zzd+t+X9iUe8VJVUyLPF3hMTG6UyMHTL
         G/rj8f2AgI05aEvdljF02Diih7WANfvZgGRLlFc5/vVIMJjNL1F/3RkfcpV6m+ibfwIL
         O8M/GJCu8a1/bIaQ7/KruMQBNGpBAzhEBocQ2Lir6nfeKj5pvKBTnXnWkuIUH0ThqhIm
         daXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721007191; x=1721611991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQwnzP38ldU+pzsKvRMORy4OwiKshmlc+I/N7QR8eVw=;
        b=Dvw2TcjgbPcfr0p2VmIAWxq8l4nj3TvXEDqiD/sfmQVQj0BOxRkprrixf5DoCR8DL3
         08FQiH9no4k6NtS5mG45ND1QxxlaRee05pbSCyaPM3shC6Rx6dtgBoqefCOyxC7o03H4
         176RpnWghNV3ublD9ZHYr61OZMEYS+719owPH3ciJhT97nTck2uxQRln4BNMxY1P9GrZ
         HfEeki75n7otwcQRE1Xyz2bczk2DZ+meLHl0q6Xew10GHwVKwxUYmmwLtuf0S2tkJQuu
         vi4SwoeOJ8VRo9jabmKZD2/A1CibtvtS1PzQ8IAa4D/6E8WRlO5pJbEy9R8tbkyb1jOP
         HoJw==
X-Forwarded-Encrypted: i=1; AJvYcCUeEafh8+btQqJ9rIgCsFvkPIZWVAdIwAsp+G9RFhukan/NDoIsol2x7MsiUwRzl59RCEi7e8ZwUYjhPTe6cOlE1jRVPfw4VzveiNV4
X-Gm-Message-State: AOJu0YzOZjPG+8FGz7KiMGBrcRswB8tHqDW4ImrCtqfjYuh42YNkOlUr
	Ud1NGpESiiZapilBMFdRPcppwqp74lEoHOW64WYl2NQWJXqcdwZJ
X-Google-Smtp-Source: AGHT+IGQSf1sujxfjmUCB8gGxHXz6zSqCUQIGVvQrI5FsxLcbrEG9wdkFJLYTUrk7aJFkwqLluXs5Q==
X-Received: by 2002:a17:903:234e:b0:1f9:fe14:592f with SMTP id d9443c01a7336-1fbefb911f8mr148908895ad.17.1721007191302;
        Sun, 14 Jul 2024 18:33:11 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2888csm29954665ad.146.2024.07.14.18.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 18:33:10 -0700 (PDT)
Message-ID: <8007538a-5680-4e43-b204-21ce62943eee@gmail.com>
Date: Mon, 15 Jul 2024 09:33:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240708063344.1096626-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240708063344.1096626-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/24 2:33 PM, alexs@kernel.org wrote:
> From: Alex Shi (Tencent) <alexs@kernel.org>
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
> This patachset does not increase the descriptor size nor introduce any
> functional changes, and could save about 122Kbytes zsmalloc.o size.
> 
> Thanks
> Alex
> 

Any comments for this patchset?

Thanks
Alex

> ---
> v3->v2:
> - Fix LKP reported build issue
> - Update the Usage of struct zpdesc fields.
> - Rebase onto latest mm-unstable commit 2073cda629a4
> 
> v1->v2: 
> - Take Yosry and Yoo's suggestion to add more members in zpdesc,
> - Rebase on latest mm-unstable commit 31334cf98dbd
> ---
> 
> Alex Shi (Tencent) (9):
>   mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
>   mm/zsmalloc: use zpdesc in trylock_zspage/lock_zspage
>   mm/zsmalloc: convert create_page_chain() and its users to use zpdesc
>   mm/zsmalloc: rename reset_page to reset_zpdesc and use zpdesc in it
>   mm/zsmalloc: convert SetZsPageMovable and remove unused funcs
>   mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
>   mm/zsmalloc: introduce __zpdesc_clear_movable
>   mm/zsmalloc: introduce __zpdesc_clear_zsmalloc
>   mm/zsmalloc: introduce __zpdesc_set_zsmalloc()
> 
> Hyeonggon Yoo (11):
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
> 
>  mm/zpdesc.h   | 146 ++++++++++++++++
>  mm/zsmalloc.c | 460 +++++++++++++++++++++++++++-----------------------
>  2 files changed, 398 insertions(+), 208 deletions(-)
>  create mode 100644 mm/zpdesc.h
> 

