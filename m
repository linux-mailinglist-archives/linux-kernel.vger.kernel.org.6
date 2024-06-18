Return-Path: <linux-kernel+bounces-218592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C742590C264
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719CE1F24831
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C519B3C0;
	Tue, 18 Jun 2024 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoS97ltU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523EC4D8BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680760; cv=none; b=KR63eibYu6+odXx7sEvQ8K+1TA2ltF9FQsj+e9hOkiPXbxl6CchaxawG27Agly369jcRuOEq41R3vGBWnq6SrU7pZym0OpKB99bAr4aNg9oqQiOT1NJUMTFJwpPeYNWa/Jx0hXU+1BRR6Kv5EmH51U0WgBpUcFspuqNrv/Y/NgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680760; c=relaxed/simple;
	bh=Z+oc5uRTAFhZnj7jIbg6J9oTIX0EeG2GVQTPEDuvlBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN9/kTyEOxzrD3Sa6TD+fVOrCIZ6aFWSYpRJnvxWLU3emsr6i4xtHBii3EcTmXn+kmPFZSck+Ttej87aWPOTKWMu2wOO6pUmZFaPDmX+jQLzx69yt4Eq5eQtYWPH0RN4Cfx+ynY5tasig6wFQYQyWoOYhiWG4R1j4smRjB9P1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qoS97ltU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3oANa1rrA/Me3UE+Z60RNjRWRplG3I0MnseFbw0ZTR4=; b=qoS97ltUkD4IyV7n7Bfnd1C8Ls
	NvkhkgXzguxGckgW2jFucHXzxp9tUeKc/bF+vrXTRyzbmDYaD179cERs89bk/LQtQXw953FCv8Z6R
	FYS47n2XKr5L2lsEYKpEMRG9R+oht/mWAZW1T6loMwke2wxQhjq/mQumCCBKY6yh/d4TAExid/JBe
	V4g6KZJO4FCWcEWWBqBo7j5qcUWslEykQQCsiwSdvwy6QezQhFUH+oPuDIzUwtUlwuCvx1iPwZcpT
	xybCaJXethpdZHWh9KPSWzSzi3tivb81SWB4Fbu/+X1ePCAlOvb7J3U6+EsuvKkjMUrCDJdjqfLYf
	hxBZpUZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJPNB-00000002j50-2tce;
	Tue, 18 Jun 2024 03:19:05 +0000
Date: Tue, 18 Jun 2024 04:19:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix hard lockup in __split_huge_page
Message-ID: <ZnD8qYvpyhYtWeHd@casper.infradead.org>
References: <20240618020926.1911903-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618020926.1911903-1-zhaoyang.huang@unisoc.com>

On Tue, Jun 18, 2024 at 10:09:26AM +0800, zhaoyang.huang wrote:
> Hard lockup[2] is reported which should be caused by recursive
> lock contention of lruvec->lru_lock[1] within __split_huge_page.
> 
> [1]
> static void __split_huge_page(struct page *page, struct list_head *list,
>                 pgoff_t end, unsigned int new_order)
> {
>         /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> //1st lock here
>         lruvec = folio_lruvec_lock(folio);
> 
>         for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
>                 __split_huge_page_tail(folio, i, lruvec, list, new_order);
>                 /* Some pages can be beyond EOF: drop them from page cache */
>                 if (head[i].index >= end) {
>                         folio_put(tail);
>                             __page_cache_release
> //2nd lock here
>                                folio_lruvec_relock_irqsave

Why doesn't lockdep catch this?

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..ea504df46d3b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2925,7 +2925,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  				folio_account_cleaned(tail,
>  					inode_to_wb(folio->mapping->host));
>  			__filemap_remove_folio(tail, NULL);
> +			unlock_page_lruvec(lruvec);
>  			folio_put(tail);
> +			folio_lruvec_lock(folio);

Why is it safe to drop & reacquire this lock?  Is there nothing we need
to revalidate?


