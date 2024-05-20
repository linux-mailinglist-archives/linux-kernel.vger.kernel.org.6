Return-Path: <linux-kernel+bounces-184200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EC8CA3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD31F22658
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3515C139580;
	Mon, 20 May 2024 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1JjLReq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876581847
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241585; cv=none; b=qblIjevqen4BT1hTb5fFK3f8CGA6N2lzPSgdYfGnBGwrNJzVis5V77z71xVbYL0vJvvrOrhIQWJxlSblVuI72CwvU3oVRqmQ8ezoYHASVmT3yAGC4MkCWOKbFFxS2WfDz+SitBSXBGDvcl2b8hR/Hhs6Fz01sT/ir4P1kDYUnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241585; c=relaxed/simple;
	bh=KQDTWd1zWt7BnRrAMEwqQyxOs0X2hSXknq8dCRM1SEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpZ3YoZUvCSAAm4c9HatazPXplDC+lXqesEfr1dypRKbzJijtE49ID/xLPe9i0gF/UPn5beTNgXgo/vo3OVt126znXMd190svFDWUOsW1SPqjkF/az2JnFR2IUQqC0YCF/B0U+v7MSi/1VoyaJa+09r3sJ1pXqPLSv155y0HVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A1JjLReq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9eZPpYZJ8iy/NNjYCCupfftHLCCO8p5oJKHb/HLE+Lg=; b=A1JjLReqArNhLPm0IIoqbg9xfF
	AAobZTEtxfDYYQiD2EQ3E8+dbyajyX1LHfqBclnDgPJ5Ev9fv9I2QFGk6c/vjb4as08937mjvgbcQ
	9SmFqFA9k50XRg+mId9dCmHRGStY4WTiWfiMNME1E5QMMXoANXUzdCKjFs68ssglKRnYjmyJNrpSc
	TQMQbTY6wdj7JPGDfnlj/JbbZUMIx0RW9sd0GgYPUvuwuNcdYJGRB+jZgMq9niLtSu6Jyw8GBRPqt
	r2HmQWuHeWgbZzn281FWOIM2S5AC1+2/lxxqsRoDYKQPm6VReigPeMZvaemAf7vdeGvV0OYehp/S0
	JaLGg3mA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Apo-0000000GPNJ-40T3;
	Mon, 20 May 2024 21:46:20 +0000
Date: Mon, 20 May 2024 22:46:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert __unmap_hugepage_range() to folios
Message-ID: <ZkvErLsj8Ngj4qM3@casper.infradead.org>
References: <20240520194749.334896-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520194749.334896-1-vishal.moola@gmail.com>

On Mon, May 20, 2024 at 12:47:49PM -0700, Vishal Moola (Oracle) wrote:
> Replaces 4 calls to compound_head() with one. Also converts
> unmap_hugepage_range() and unmap_ref_private() to take in folios.

This is great!

>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			    unsigned long start, unsigned long end,
> -			    struct page *ref_page, zap_flags_t zap_flags)
> +			    struct folio *ref_folio, zap_flags_t zap_flags)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address;
>  	pte_t *ptep;
>  	pte_t pte;
>  	spinlock_t *ptl;
> -	struct page *page;
> +	struct folio *folio;
>  	struct hstate *h = hstate_vma(vma);
>  	unsigned long sz = huge_page_size(h);

I would appreciate some further cleanup ...

	size_t sz = folio_size(folio);

I think there are further cleanups along those lines, eg
pages_per_huge_page(), hugetlb_mask_last_page(), huge_page_mask().


