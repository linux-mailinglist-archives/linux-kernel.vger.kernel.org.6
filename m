Return-Path: <linux-kernel+bounces-261471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E893B7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D05A28619C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFE415FA76;
	Wed, 24 Jul 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELIfEZvw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2174EED8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851331; cv=none; b=PJbNktUzN5EkVnZlhQiiSoN/RCH1Xo38TW2WhA2UBirxL5VtyJ0rCv+vLaUqdXxq4vLbzfUxz0SOO+2CAICuussq/gXI5AGGfoHjzcT6dl4elzrXfpZvol/2c6azsRwSrwrcxKKFH77NAZdkaMdZrbTSBpaYHpTlM1iBusL1llM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851331; c=relaxed/simple;
	bh=AnAbb5dmG5VfcU6B4Yn+5Mrfjo8HWyP8YyXss+Ds3ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4AWJKVVwmJKNEGvyAGtyEx++8ZLcvxo7ID7QxC/tnnM05vWVu6PUIo4LoF48uzRt4fBE6s5CCOlwTTrz+dstR1WdN3jtyhp4sszuyQrD1Ht9zGEqcNOkZv7A+k+2syCs/onrYY3lKV4C5A0uOFroUFbedakCqa1aj65V4HSvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ELIfEZvw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RNDXkPq/hLVDx0ibhbMTtzI+6SBozY+rsScaYjX/r/k=; b=ELIfEZvwq5q99yWUqNEI7+YrKF
	VH8lYBG42hPEtkpp9jkc/fKCnIICDaTA4MkXcfal34pQoSQTS2a+2HI2DlTSmHr6fdFGfEGaJkOBo
	m34xy/earl4muLqQHMWmoLHj164+oXrgzAQ1o4llbznxPAC1rcKsIY8ty1w9clUVNGxynQMS19FNI
	Vf8qCPb8eGPjMYgZt+PdI3JUssHjYVXj8cjl5hetjW0IpIf6akOPEC8hsFiw2/a9UiSU+BCgGsucH
	SEkw24fgv/uzOTlYUwG3Ub0CCEUg59h1z7X0ibp3aPWSWfCI2rWznCGmSukcCHJ2bYKKNfqw1e31Y
	K651tnKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWiBX-000000088Px-3sDa;
	Wed, 24 Jul 2024 20:02:03 +0000
Date: Wed, 24 Jul 2024 21:02:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Hailong.Liu" <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>,
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <ZqFdu73H3BguX4QG@casper.infradead.org>
References: <20240724181916.31776-1-hailong.liu@oppo.com>
 <20240724182827.nlgdckimtg2gwns5@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724182827.nlgdckimtg2gwns5@oppo.com>

On Thu, Jul 25, 2024 at 02:28:27AM +0800, Hailong.Liu wrote:
> >  	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> > -			page_shift == PAGE_SHIFT)
> > -		return vmap_small_pages_range_noflush(addr, end, prot, pages);
> > +			page_shift == PAGE_SHIFT ||
> > +			page_private(pages[0]) == VM_AREA_ALLOC_PAGES_FALLBACK) {
> > +		int ret = vmap_small_pages_range_noflush(addr, end, prot, pages);
> > +
> > +		set_page_private(pages[0], 0);
> > +		return ret;
> > +	}
> >
> >  	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> >  		int err;
> > @@ -3583,6 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >
> >  			/* fall back to the zero order allocations */
> >  			alloc_gfp |= __GFP_NOFAIL;
> > +			fallback = true;
> Sry for my mistake, I forget define fallback here.
> BTW, This is not the optimal solution. Does anyone have a better idea? Glad to
> hear:)

Yeah, I really don't like this approach.  You could return a small
struct indicating both nr_allocated and whether you had to fall back.
Or you could pass a bool * parameter.  They're both pretty nasty.

