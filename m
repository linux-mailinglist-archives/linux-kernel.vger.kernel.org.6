Return-Path: <linux-kernel+bounces-191094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA28D0685
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F304A282947
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5961FF9;
	Mon, 27 May 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vSEUfjl8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32173462
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824867; cv=none; b=Y+rQvEzxTj96LRIiGC6aMSxFjojwaXinC7/nFMaAl2d3gLQn7su6TghzzpznoCl8xYBoGyhBQflh+J2G+NO8Tj5Zp8HqYzE0sXnWWNHlfffksoCqtDeYJzJYswUFYxQk3vZworSWKYft4XJvWAENjBrbSLuelOjOKoRQul0kyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824867; c=relaxed/simple;
	bh=1G6biT5jM53hXfPGfNxY89AZ0sAXmbX1w22HLsxZ5BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFaK1Q1TsegN+NL35dtAvWZh24ZThfKQhiPu5FhAjlCoPM+QuMHVCC/QAjGzLT9WMtFzu+bRUm0/Wfa06EOQklKhqfT9W3B9Foha2rvPvMKeCSxLNIGCaiFOGhGnnVO2LK+lnLSuSBqEy8G+JYs8/7qnXCOmCH9xlFGv+7AQGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vSEUfjl8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u3fQhom/2PMZIi3mCUIS3hdWg4hX3jYiIfgerxDXhV8=; b=vSEUfjl8y4/F0glaDVw1jAScRD
	d9Zduww7cYjXKRbukNjwLRCwhq6ObJgz5YT5nU9IhhwUxaQmeGxyeP8Mcu+TasBaqHaJcY6J5q0bO
	/Dgs9GdrcGGHeoluVfAVqCLh+ahJ8TvwGV+emc0E8hAKizWgBM3T2KJjwufaHA8jO6aJghvz3t4SA
	PvAhgUlqyF4YuX4Cj3JzC1Xeg56+ZtFBq8Z8OMxIQW+W2xOBieJ4eJ/d0fkmWcCWiI14R0DV8dQb7
	kMlnagjhCab8m6G2Dml6eOt9PK1SLZqBqdl9R+TeCoTq01rqro/Cys+P66xGYwokqrvYMEFjvAszP
	iccxh9nA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBcFL-00000007l8p-3jVO;
	Mon, 27 May 2024 15:26:47 +0000
Date: Mon, 27 May 2024 16:26:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v1 2/6] mm: allow reuse of the lower 16 bit of the page
 type with an actual type
Message-ID: <ZlSmNzgkeYaCrPWc@casper.infradead.org>
References: <20240527141454.113132-1-david@redhat.com>
 <20240527141454.113132-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527141454.113132-3-david@redhat.com>

On Mon, May 27, 2024 at 04:14:50PM +0200, David Hildenbrand wrote:
> As long as the owner sets a page type first, we can allow reuse of the
> lower 18 bit: sufficient to store an offset into a 64 KiB page, which

You say 18 here and 16 below.

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

We could, but it's more instructions to check.

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

I think my original comment was misleading.  This should be:

 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflow.

How about we start at the top end and let people extend down?  ie:

#define PAGE_TYPE_BASE	0x80000000
#define PG_buddy	0x40000000
#define PG_offline	0x20000000
#define PG_table	0x10000000
#define PG_guard	0x08000000
#define PG_hugetlb	0x04000000
#define PG_slab		0x02000000
#define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)

Now we can see that we have 9 flags remaining, which should last until
we can have proper memdesc typing.

