Return-Path: <linux-kernel+bounces-557690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A945CA5DC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E681899602
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F6242900;
	Wed, 12 Mar 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+p+Plm7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56E23E25B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782058; cv=none; b=hpwnlHdDOsNJLJ/CFMZOl8ihkj3zO2qjn6ltKH4tzS7Bmobu/X1rpvMwmdKSEy78gxk5cNCeoVu5nMzLyd0P71Q9kQMO0IM3lOtgcQkCVizHBNyShEOlJvy46hmxbB89B6F1UFzQt2P3wQL4wrxDvs9g01xXJW9y/xs0fykS7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782058; c=relaxed/simple;
	bh=67xZuLHotnhQwEJFiUlmD4EqG2gjxg+udrp/nbfJBok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNHOjvVxTO/hRXPPICvtw4JrdyMPjhL3Eh3SKxgqYk3PRXpTLKuUSaofeG5dEjnXCLPWKv9P+P8l907erlmvJOlIOhmfituWzo1HqxrA6gKzGZEtqVkJ9jOMYtlIrU7euyHJrp2u3UiEkURNd8JngFkm9nwYzCMZ19UekfMnB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y+p+Plm7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h+unGnlI6eXA2qo6dr4HD/w8OSOg2geZ8GiQ3pINjjs=; b=Y+p+Plm7ovbuRdP2zdu15NqCyH
	VbRRoxAAS8UVc+mbzKisYqAjrcycqRlnmCIH+CDSoH7OdEqZA+40IQ6XlXYD7Ly7lP92fDWsk8CZ6
	T6NvKnFLSy4ophBOKW14vTVKTQhZ5Sx/Nnc2WB4B49ez51YDCWdVNO9GnmMXNoT1jrjiTpUI2HyBF
	X5LhZqebuv8hXHM0yCbKmBddM97ajjLAEE4VscvDj8eus0ijjZLx1QS8381Q489UbYZaccUL2LLbW
	vNvdoNZsuCBp2vGjPqomGJfQS58FOvrqzWGSGhtBkIeaqAZcX99PLG/0j/tT25ErwHWLM8M+FAanz
	FhTu1tWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsL4w-0000000Cofs-04QB;
	Wed, 12 Mar 2025 12:20:54 +0000
Date: Wed, 12 Mar 2025 12:20:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/debug: Fix minor issues in mm
Message-ID: <Z9F8JYitsY9viNg4@casper.infradead.org>
References: <20250312032344.297946-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312032344.297946-1-liuye@kylinos.cn>

On Wed, Mar 12, 2025 at 11:23:44AM +0800, Liu Ye wrote:
> - Simplify compound page judgment conditions.

> @@ -132,15 +132,15 @@ static void __dump_page(const struct page *page)
>  again:
>  	memcpy(&precise, page, sizeof(*page));
>  	head = precise.compound_head;
> -	if ((head & 1) == 0) {
> +	if (head & 1) {
> +		foliop = (struct folio *)(head - 1);
> +		idx = folio_page_idx(foliop, page);
> +	} else {
>  		foliop = (struct folio *)&precise;
>  		idx = 0;
>  		if (!folio_test_large(foliop))
>  			goto dump;
>  		foliop = (struct folio *)page;
> -	} else {
> -		foliop = (struct folio *)(head - 1);
> -		idx = folio_page_idx(foliop, page);
>  	}
>  
>  	if (idx < MAX_FOLIO_NR_PAGES) {

How is this "simpler"?  It seems like churn for the sake of churn.
NACK.

