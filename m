Return-Path: <linux-kernel+bounces-278462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1D94B092
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8825B1F21E30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F5139CE9;
	Wed,  7 Aug 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KhBoVmRP"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67103225A2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059921; cv=none; b=LhOLS6czvxHYZq4g08hGj02AsZKo/vRAxOVxdGDkCymZM4XePetagyH6B6c6QBO2Vf7TTmJzDjC0x4jeTpnz8SnJuDzDafgKS70qUjwQnGwADxoGO0vZroJ2m4fd6IjlahS3PA9pIitiZiQi51gz7DaTgfARPL9PMvlNlAi0kIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059921; c=relaxed/simple;
	bh=U2SSjnCwU5uxHzJ4FKAti46QRVg2gxVgb+l/Prl5Ej0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7SddsrdC5r7H/6hk7XQv4cR2/ofzqDSo3Gpo8Nije3gac25LMbbq5P1b4QLqP4rTfWlF0aTXk0QSoSIQfKhlmaN9Y5mjzQ2i8iyUlBUA4vfCr0ujBsUdOO968Q+W4xhCH+XFafHG5zCfBZ5jBOlSg4hpbxI5z38W1zY5Dg7wUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KhBoVmRP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4503ccbc218so10436511cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1723059918; x=1723664718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRNP8+j9JNXJhSIfP3j/Nd6wBo1Mo57840nXTuLt/sI=;
        b=KhBoVmRPgt3YBX+hOqU7tZ4SYyPsDvvpstVZYi9fPuxIiEFtPRu65Aj94g7KRDBmfx
         7fK6VjJ59MFxHusKsi61ogbJVFLJEP99c5Ts74ioEEEXYDpm6LCTa+zvqOcxHt06xb4D
         23Ct5G/eBotDRBYz3I/KXqCzqNhevxKp5n6ZLOryK63Mok5Ko6NEvnafftFFLwKZd92N
         NtuSSglR0aQbbi3n8hWxgTd95g4gVNH3dV/3fHswz9JVpgmtBj7cf3s9F0sXfAfjVxGR
         LWsKC1+zM1InLLGYIti06sFS5RQUp5InB7oqK+FY+SADmw4k9r3MAi236VWI7AJShu3X
         NNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723059918; x=1723664718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRNP8+j9JNXJhSIfP3j/Nd6wBo1Mo57840nXTuLt/sI=;
        b=nRNhvlBq/N61JB1BICiKzZi7xee/qsXWwNIZlaZ+3jtoZDr9FOPs3w402W7/V4KQQY
         nymdf0gCMbgOPfJWmXHPUa6D9Jsef4yWr+FTnOfc/hZeTBQt/T2KiY9B0zQyGvcjHpEd
         fgH2BTlbt5oWf4d/9KhwMpgRP3eLAGJRxSA9TigIPJUxo59kqWs5098PM624IauQhxUz
         mXOwSYc1dwo/AXAVNdlNQ9zdZmSVPkKmBxH2yuzInn2pMCReATsRIqYF6niqm5nnwZIr
         Ds5uQUPl4zZSmcWlV5venYmNNv/RDYCVfmra8JInJgbITLhN7ITpTDkXy0lZl8THLU+U
         7Vog==
X-Forwarded-Encrypted: i=1; AJvYcCUbxONLsqFoi8Q+QgFaC2SsI30cit9B8VmxyfR6FlXbyZk7WKuqhb0Y0lSKKwv4Uv5UDnTzqS6LiPtWNC7bO6xPP69EBNYTgFdsIeY9
X-Gm-Message-State: AOJu0Yy3MvMmWRXp9im1/IBXjPDhmELo90heCFFsvO5Vtn+zLZmZJxHc
	lD+E+LCqaoHvt0p9D5d6FjPGnxTP4/087ZvL9HK31VirV4DrRnkcezSVUGk/u94=
X-Google-Smtp-Source: AGHT+IHxkvIL2FAAY54SivCXgMtmsqj2mnEIMCmKHWRVWpL7/1o640SX7BuEYBZRFoull+Z5qHCSog==
X-Received: by 2002:a05:622a:4086:b0:451:8b27:381c with SMTP id d75a77b69052e-451c7999460mr66238771cf.14.1723059918151;
        Wed, 07 Aug 2024 12:45:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870066csm7215251cf.4.2024.08.07.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:45:17 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:45:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, riel@surriel.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yuzhao@google.com,
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com,
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH v2 1/4] mm: free zapped tail pages when splitting
 isolated thp
Message-ID: <20240807194512.GA1828817@cmpxchg.org>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807134732.3292797-2-usamaarif642@gmail.com>

On Wed, Aug 07, 2024 at 02:46:46PM +0100, Usama Arif wrote:
> From: Yu Zhao <yuzhao@google.com>
> 
> If a tail page has only two references left, one inherited from the
> isolation of its head and the other from lru_add_page_tail() which we
> are about to drop, it means this tail page was concurrently zapped.
> Then we can safely free it and save page reclaim or migration the
> trouble of trying it.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Shuang Zhai <zhais@google.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  mm/huge_memory.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0167dc27e365..35c1089d8d61 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2923,7 +2923,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	unsigned int new_nr = 1 << new_order;
>  	int order = folio_order(folio);
>  	unsigned int nr = 1 << order;
> +	struct folio_batch free_folios;
>  
> +	folio_batch_init(&free_folios);
>  	/* complete memcg works before add pages to LRU */
>  	split_page_memcg(head, order, new_order);
>  
> @@ -3007,6 +3009,26 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		if (subpage == page)
>  			continue;
>  		folio_unlock(new_folio);
> +		/*
> +		 * If a folio has only two references left, one inherited
> +		 * from the isolation of its head and the other from
> +		 * lru_add_page_tail() which we are about to drop, it means this
> +		 * folio was concurrently zapped. Then we can safely free it
> +		 * and save page reclaim or migration the trouble of trying it.
> +		 */
> +		if (list && page_ref_freeze(subpage, 2)) {

folio_ref_freeze(new_folio, 2)?

Otherwise looks good to me

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

