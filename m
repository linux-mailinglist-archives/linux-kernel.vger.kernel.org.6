Return-Path: <linux-kernel+bounces-201733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C438FC275
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6626128589B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BE6CDB1;
	Wed,  5 Jun 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YE1TRjGK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2174C2E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559540; cv=none; b=fbx5+Szp7H9PoVQ3oWVuT6bxt0Dcwdrgpbvfy1zJ6EtfuajUQunHCahFB4obtsYFtLq4/3p6gIyts2CQqR+f4ByX+gaVNKDX/vMI5esIvdVwkM4/jw7GuJIPzYrkusnmMEQtMhw1CDhJZ/cZ/L+WJ9wvRRg3tEmmr83mXB8V34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559540; c=relaxed/simple;
	bh=2NgcjOfWeHHjlheTm9VdnNzFvgPv6KmMCZBNLFQE1YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jte/9k/t6iH25I+4giX8w4R6r0A8rZHnK7Lh5LAehkjGciMLrRf8hGCTVg41Q9wn23wsfHRdSiMxm3H/GG1Qu9xViw2EbhS5BVNC6vzDLxZ8bySfWmzMBepk2p5PAX4cdCW+SiyBiEnaVmDtILnGRMgw+I93VYfaullZrN4260w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YE1TRjGK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3POy1FIH2RHjs/HGPJUYdvo+L8U+AxFwiVjDX3JZVoI=; b=YE1TRjGK1Uxhh0ehvyS01xTlYU
	0Hs1W+uZUdGCQC8S32VLHfwjp2qMaEVm1Eqc6dj9vQA5Vu6ZXiNygagaWAvtj5H2GFd0rij5dtvsx
	JTEeZE8dd5bidCHJO3mkLSYNIHc3dTtaNh4szhrQQCnIH104fopXN7vLiSCfLGLHbOE6oeqo/MBES
	pGPiTKBENM0OU8BZBb9w6WMxSY5MmQSOFJFpGxz5ey0jhA7/fTpLLPOkSiealVm7yjZpX7QegYwW8
	8iXgR2m3mQuJmoMC1y6qd1ZooVORjAimAzF5U19DcPw6Q0wgru5GvxKqhBSqUz9aVGko22958ZxBk
	+TJSyipA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEhh8-0000000FL2U-2fpp;
	Wed, 05 Jun 2024 03:52:14 +0000
Date: Wed, 5 Jun 2024 04:52:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
	aarcange@redhat.com, chrisw@sous-sol.org, hughd@google.com,
	david@redhat.com
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
Message-ID: <Zl_g7qmXAJDy4vKu@casper.infradead.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604042454.2012091-3-alexs@kernel.org>

On Tue, Jun 04, 2024 at 12:24:44PM +0800, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> When a folio isn't fit for KSM, the subpages are unlikely to be good,
> So let's skip the rest page checking to save some actions.

Why would you say that is true?  We have plenty of evidence that
userspace allocators can allocate large folios, then use only the first
few bytes, leaving many tail pages full of zeroes.

> @@ -2660,6 +2662,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  				cond_resched();
>  				continue;
>  			}
> +
> +			VM_WARN_ON(PageTail(*page));
> +			nr = compound_nr(*page);

And this is simply wrong.  *page can obviously be a tail page.


