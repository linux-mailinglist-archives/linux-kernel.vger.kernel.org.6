Return-Path: <linux-kernel+bounces-244952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2592AC24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26ED1F225AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8041509B0;
	Mon,  8 Jul 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYekUXxU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52FBA46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478214; cv=none; b=FnXJsHfCpngkWyTj3PI17uG2Yo+NLbgcXejnQzrr77BhOnnQFyotNOiYT3wPhW0YCuDwLpuse1CB9ikV0JLTp+RwzzU277l+FG+SvxPn7xD/c1icHImucOgVc5FxCIg5BTUENleGaj6AyGhb84BkMOXNyKE7n+Q02qTwU7YOlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478214; c=relaxed/simple;
	bh=HZS+F0Vn4EJKAMnwP9VbmLmmEK+7KHkGnCeot2LlaY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKixlz2nPqIykjakVP+u7hzD7hO79PpYEsm6UVBmZ7Nv85/avtlNdiRNv+HxV8TijpVvzM3qIPRlKXL/WjiXXkoWAfbkj59yMYKVxC6/YzqY6uusF/uQpbvtD/kVo2X7ctwwNpt79mB1zChb9mVzLtoyqyok9N0s0utsYIVJwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jYekUXxU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vExNcDqVQfvKTJvQscaouDwcx4jomkck9MJGjvfkkTY=; b=jYekUXxUwqekTTVUALjCXiuOMv
	Il4SQGIbCUk2xq36vPTqTQ4QX1tKweis0UIj913Fr7lJpRX0CgwQ4m6ZMG8MBnppqbsfTfStRsK8O
	7mDdmsWNEp6m5c9SlMle+BY0lDwhzQiRm+ENqHlng+luAETQtiefhyxVFbZoO22r8pRGGBzmySivV
	IQOuEmUH6R+N/pacv+ZOmHw6WA1rWSyZMhkx3ApjRxNeKyY/wwQku8oCg2nB+EPZf8wzPUSfsWoT/
	jjVoCqJkmdiCzvyzfUJk70eGLbl9Hh1CGq8IVagM0qBnkkpw4/p16rHW2boMFgKSW543lTg7O47G+
	Rpop5P5g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQwyX-00000007Ed7-3rvF;
	Mon, 08 Jul 2024 22:36:49 +0000
Date: Mon, 8 Jul 2024 23:36:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1] mm/truncate: batch-clear shadow entries
Message-ID: <ZoxqAW5_GjbesrW5@casper.infradead.org>
References: <20240708212753.3120511-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708212753.3120511-1-yuzhao@google.com>

On Mon, Jul 08, 2024 at 03:27:53PM -0600, Yu Zhao wrote:
> Make clear_shadow_entry() clear shadow entries in `struct folio_batch`
> so that it can reduce contention on i_lock and i_pages locks, e.g.,

I think it needs to be renamed, perhaps to clear_shadow_entries().

> @@ -503,8 +486,8 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
>  			/* We rely upon deletion not changing folio->index */
>  
>  			if (xa_is_value(folio)) {
> -				count += invalidate_exceptional_entry(mapping,
> -							     indices[i], folio);
> +				xa_has_values = true;
> +				count++;

Mmm.  This is awkward.  It's supposed to return the number of pages,
not the number of folios (or shadow entries) invalidated.


