Return-Path: <linux-kernel+bounces-297746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7519795BD09
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBDB283B90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B491CEAC0;
	Thu, 22 Aug 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/UpIzV4"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11E1CE71E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347399; cv=none; b=PDDf/VOUTs+4CRRQREqJFlr2B9lDhdZcyXbhALV7bsncF1HkXhvTovb4Ew/Vj0QEkzk0uVIXtIRt9AlGDrHmh5fS2v5AUTPxdHuPKobsSFScpenjCpH/9j3AmebaqXB0+3mNHaPbYkGcnfRo/B8mIHa54fw8l4yJ5muvjoNruaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347399; c=relaxed/simple;
	bh=k6QEc4zY2srk7rGY1fFy672V0KiYP4bWyDatHsgO9sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHTXuzzqOdE9LZAO/DNoCiFZTxJmbd/p6Nz+3qWX5nkD5H2Q2ScJT198UPwWUcdV+OfAnWgmhaX51Q7vqm60wCK2prE61ikijkC5Bkp9uafutXSzVBN2g9gzbAisKgSH4HeR3WgXC4R5/IACv/VHZkBfIYqsnnP41hG8IVFx3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/UpIzV4; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d4161c398so4962305ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724347397; x=1724952197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuUhWaS+3oHxDlI8mH6LZSbKLa5ZcNr2XMJJpylbs80=;
        b=k/UpIzV4rMPQCw2+rmmbXHBTZnT6x1nVpoBuhN2bDHVup/ILeqmxsyUCutGUkAJETh
         uvhTUiXy52l/gpaoqbTAVfGjgs4nnO96w5mvI/DKlqIoLGLuGcTp0wNqLTIvQG2IGfxb
         qKKK2Vl7/D2mjelrF/GvONw+bKNOyA01ry+3/AC5W09jZuCEwysmS2xb0/0pxNzr2d+T
         DqlQi8QJeusX7kJHuoTKsuch6BFUjrAgjAdnc5RzCaju9lxRKqilueHBjY51dh9p538v
         jaxtF4Ddqqm+DQBmNAT5Ub3bJz1JllGa/XFYIZy4k2BGdePuHJtdHiUuNiFesBhI9OwL
         OZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347397; x=1724952197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuUhWaS+3oHxDlI8mH6LZSbKLa5ZcNr2XMJJpylbs80=;
        b=Ka0yZpEHSbmi93ZLiHk5Himxzkg7msetiz043q/cDM5xTOmtqsdGfCusHCqZjY3kXM
         tDICJbV6MSwGVzO6lSX0+LU9nOkbunlhDEbYSN+Kdy/AGstsnD9cTjX7t79+UwvhYCw2
         5mldW04LvF5B3ELTx3BC48y78IlFt4U10/30J+cs0iCYx8JvMbQdQV/IdTMPBJJjs+yU
         6r/D9abC981lMphpYZNDw9xjkTMPYU+kXl9wU9YsPzEhi+Z9RwymJnOJ1uJYmbVcATdu
         tDvtYIuIz3uOlp2xbbMUQ76excWiF2UpUT/4jJYZbu/7mZFFnB8KAx0MwmrEgtswwmKZ
         aP+A==
X-Forwarded-Encrypted: i=1; AJvYcCXRQ/V9HdVVjbv8OrZ3igW9A+2Zm4Ash9MAydTf1RK/sOgzsMFM99yPBAA+Cs0DRCYDSg68PzCJbn8zS6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxa66X3anTj4Bao+ZEy4blZE59hiUbfevkwdMXZW2OfYI7XqrT
	VHaBAwHtvHzdOShI5Jg37AoR2flWqAWZ31yjlgVm0kupAaae35JhPwPq7SaKDg==
X-Google-Smtp-Source: AGHT+IHRZnUZrELwxvZZaKGvLcI8LjG2TFQ9AVQ/pgzYZwY6BbkMvj56DSEjWVBINSwQLcMjsmtEDQ==
X-Received: by 2002:a05:6e02:1aa5:b0:39b:389d:f7ce with SMTP id e9e14a558f8ab-39d6c3500f9mr69831235ab.2.1724347396442;
        Thu, 22 Aug 2024 10:23:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e28:6:b7cf:b486:59da:5224])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce711082dbsm571819173.142.2024.08.22.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:23:15 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:23:04 -0600
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Message-ID: <Zsdz-NFl4oqZ37_h@google.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814035451.773331-2-yuzhao@google.com>

On Tue, Aug 13, 2024 at 09:54:49PM -0600, Yu Zhao wrote:
> Support __GFP_COMP in alloc_contig_range(). When the flag is set, upon
> success the function returns a large folio prepared by
> prep_new_page(), rather than a range of order-0 pages prepared by
> split_free_pages() (which is renamed from split_map_pages()).
> 
> alloc_contig_range() can be used to allocate folios larger than
> MAX_PAGE_ORDER, e.g., gigantic hugeTLB folios. So on the free path,
> free_one_page() needs to handle that by split_large_buddy().
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/gfp.h |  23 +++++++++
>  mm/compaction.c     |  41 ++--------------
>  mm/page_alloc.c     | 111 +++++++++++++++++++++++++++++++-------------
>  3 files changed, 108 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index f53f76e0b17e..59266df56aeb 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -446,4 +446,27 @@ extern struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_
>  #endif
>  void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>  
> +#ifdef CONFIG_CONTIG_ALLOC
> +static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
> +							int nid, nodemask_t *node)
> +{
> +	struct page *page;
> +
> +	if (WARN_ON(!order || !(gfp | __GFP_COMP)))

Andrew, could you patch up the line above? This is what it's supposed
to check:

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 59266df56aeb..03ba9563c6db 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -452,7 +452,7 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
 {
 	struct page *page;
 
-	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
+	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
 		return NULL;
 
 	page = alloc_contig_pages_noprof(1 << order, gfp, nid, node);

