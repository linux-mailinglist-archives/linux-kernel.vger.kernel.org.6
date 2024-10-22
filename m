Return-Path: <linux-kernel+bounces-375643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEE9A9889
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B6C2809AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4013E04C;
	Tue, 22 Oct 2024 05:32:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A714E2C0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575170; cv=none; b=klH0kLNRyKQf0Os92Ng5ReUtkzz29crFwjNZkKF3kQ9MyXnquUuc/OKB6SliYAByaxklzoeRhuuHHlJ7K1FuT6Qq2iKIwjYH7EVkMyUFFKzJGWDxVpst+ooe7Wd698qESncCOCgjHI9q+PbUNHUMGmhQcLc38sn58Di/NhNq2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575170; c=relaxed/simple;
	bh=klBGEygVzhQU/86nQVQBI+lq9rDTajBrNF5mvSu2oiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxK8MXp9abEfmrNWKQCpvoSNOezcJcrVe/JlYWVsegy7uUjoYD4oEMr8wg1Y4931l7xQ8GM/elFQv801uHb2f7kCIf9Pz9N/V1Gm4YnqWA1AJjiONye5zaP3K9AvTNXUaTMk5HM6gHYqY+fmllLp3DdCXhlNXYxPgZK7lgm3DL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4034A497;
	Mon, 21 Oct 2024 22:33:17 -0700 (PDT)
Received: from [10.163.41.149] (unknown [10.163.41.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C1E03F528;
	Mon, 21 Oct 2024 22:32:45 -0700 (PDT)
Message-ID: <30227b5e-a15a-4c77-b35e-db04fde0686d@arm.com>
Date: Tue, 22 Oct 2024 11:02:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove unused has_isolate_pageblock
To: Luoxi Li <kaixa@kiloview.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20241018092235.2764859-1-kaixa@kiloview.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241018092235.2764859-1-kaixa@kiloview.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 14:52, Luoxi Li wrote:
> has_isolate_pageblock() has been unused since commit 55612e80e722
> ("mm: page_alloc: close migratetype race between freeing and stealing")
> 
> Remove it.
> 
> Signed-off-by: Luoxi Li <kaixa@kiloview.com>
> ---
>  include/linux/page-isolation.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index c16db0067090..73dc2c1841ec 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -3,10 +3,6 @@
>  #define __LINUX_PAGEISOLATION_H
>  
>  #ifdef CONFIG_MEMORY_ISOLATION
> -static inline bool has_isolate_pageblock(struct zone *zone)
> -{
> -	return zone->nr_isolate_pageblock;
> -}
>  static inline bool is_migrate_isolate_page(struct page *page)
>  {
>  	return get_pageblock_migratetype(page) == MIGRATE_ISOLATE;
> @@ -16,10 +12,6 @@ static inline bool is_migrate_isolate(int migratetype)
>  	return migratetype == MIGRATE_ISOLATE;
>  }
>  #else
> -static inline bool has_isolate_pageblock(struct zone *zone)
> -{
> -	return false;
> -}
>  static inline bool is_migrate_isolate_page(struct page *page)
>  {
>  	return false;

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

