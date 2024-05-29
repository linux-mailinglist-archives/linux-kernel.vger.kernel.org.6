Return-Path: <linux-kernel+bounces-194395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7BB8D3B82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891D0B2507B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119E181D02;
	Wed, 29 May 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YP0UQpve"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA22180A92
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998174; cv=none; b=McxJ6ApfdOsESGBrokp2uAsOogFE1n1WIUsvHMhwF548Rngnw7dyR2b2Qpl/ssZS7eBNU/HzXddMDEppUlf5N4raGGYWQFcE3/QEEF60xXFJP5IPLk0EM+yZ32oTL5i2jw7VJv7kdjve8RL8jkk0LMD5euWemaQlwzC01pNkEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998174; c=relaxed/simple;
	bh=IqLFaT5xdUsd0QyQOBxl0ct08tWkuwCuK9WyVJVmEkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEgkYdadRI7byPWjVeL/51N9RryOWVjExTP+FCYZ6l17YgyT9CJsWqxe2BULtiJv/z1RBwUi+ClS8SPoErbJCXlMVHlHLAUq9D3P2tCsbSdxvTVc8/osxq7GwrSVFK9VWvRFFyTlk9ksS6VyEpr0kjXZbJlxOpTFWbiz7DstA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YP0UQpve; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3dMOK
	+h64umb2Ww2HIMnnwaYpG06QZyWi58gxbbVwQ8=; b=YP0UQpvejOS+fsNjhCsDJ
	EfWBnufGbRRoqt+o3djgzVYMPcjguMs/Yj+6czMCOHfQlU8M2LTQtAoMZYlYfZuq
	hjdXd2dKFcLYYcRai5xBucL4/Nhbm90ZXHCrJRoJohRhGGZnLdySBaLJdhnOYIoT
	Cxf9q2jzix1xa6B36BxMBg=
Received: from localhost.localdomain (unknown [124.90.108.240])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wD33xXqT1dmLAKCBw--.56428S2;
	Wed, 29 May 2024 23:55:23 +0800 (CST)
From: wang wei <a929244872@163.com>
To: david@redhat.com
Cc: 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	rppt@kernel.org,
	senozhatsky@chromium.org,
	willy@infradead.org,
	wang wei <a929244872@163.com>
Subject: Re: [PATCH v1 26] mm allow reuse of the lower 16 bit of the page type with an actual type
Date: Wed, 29 May 2024 23:55:20 +0800
Message-Id: <20240529155520.33161-1-a929244872@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527141454.113132-3-david@redhat.com>
References: <20240527141454.113132-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33xXqT1dmLAKCBw--.56428S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw43ZF4xKw4UCw4DtrW5ZFb_yoW5GFWrpF
	4qkFyYkr48t3y2kw4fKwnxAr17WrsYkFWUC343WrW0yF98Kw1vgF1DKr45X34kurWkAFyY
	qFZrWw1q934DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUVGQDUUUUU=
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/1tbiLgDtpmV4JOd7rgABsv

---
> As long as the owner sets a page type first, we can allow reuse of the
> lower 18 bit: sufficient to store an offset into a 64 KiB page, which
> is the maximum base page size in *common* configurations (ignoring the
> 256 KiB variant). Restrict it to the head page.
> 
> We'll use that for zsmalloc next, to set a proper type while still
> reusing that field to store information (offset into a base page) that
> cannot go elsewhere for now.
> 
> Fear of running out of bits for storing the actual type? Actually, we
> don't need one bit per type, we could store a single value instead.
> Further, we could likely limit PAGE_TYPE_BASE to a single (highest) bit.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm_types.h   |  5 +++++
>  include/linux/page-flags.h | 20 ++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6b2aeba792c4..598cfedbbfa0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -157,6 +157,11 @@ struct page {
>  		 *
>  		 * See page-flags.h for a list of page types which are currently
>  		 * stored here.
> +		 *
> +		 * Owners of typed folios may reuse the lower 16 bit of the
> +		 * head page page_type field after setting the page type,
> +		 * but must reset these 16 bit to -1 before clearing the
> +		 * page type.
>  		 */
>  		unsigned int page_type;
>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 104078afe0b1..b43e380ffa0b 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -945,14 +945,18 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>   */
>  
>  #define PAGE_TYPE_BASE	0xf0000000
> -/* Reserve		0x0000007f to catch underflows of _mapcount */
> -#define PAGE_MAPCOUNT_RESERVE	-128
> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> -#define PG_hugetlb	0x00000800
> -#define PG_slab		0x00001000
> +/*
> + * Reserve		0x0000ffff to catch underflows of _mapcount and
> + * allow owners that set a type to reuse the lower 16 bit for their own
> + * purposes.
> + */
> +#define PAGE_MAPCOUNT_RESERVE	-65536
> +#define PG_buddy	0x00010000
> +#define PG_offline	0x00020000
> +#define PG_table	0x00040000
> +#define PG_guard	0x00080000
> +#define PG_hugetlb	0x00100800

Every PG_XX occupies one bit in my understanding.   But why PG_hugetlb occupies two bits?

> +#define PG_slab		0x00200000
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)

-- 
2.25.1


