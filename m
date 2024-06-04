Return-Path: <linux-kernel+bounces-200574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCAE8FB1FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196341F21987
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65475145B3C;
	Tue,  4 Jun 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8JcCSx2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74A15E8B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503509; cv=none; b=I0QSyf4IlqGaoJnEcamk8oeGY0Jo3qESCcEv6ASdtL4i9dSEVjH7LyPEb2WBNnt0hN3C6gGms5pl50eXw87tObKH+U1Yjq6xhhPM6ENa0vu4aZ1umiIIfndo/J6TL6U7evtgZBMqJoISlhPCM9Pxi+1DGULelZUHKm7E7Of36SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503509; c=relaxed/simple;
	bh=koi+eA2OVKj7kcTmnp29vrfYEoN22Tgf5em0FAJliKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSADgpN1nrK3QsVV5LI9hSR7a7VIhS+hiVXthNzUEuHwWMRq399vlvqEwtjDKomHTSVaxy/0X9DHqgfXsHNhNcn0653IkyaeNGGLBxug3oDI63GD0jZC3TnuC3i8MOlnNmoYiPPw7hCu/GrR4tdpRySyq/uaskUzNpYWxIuhB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D8JcCSx2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WsZvmPHfN7fPNZg3H2FzpVxdFXo8damEw8Ch/6pQZpc=; b=D8JcCSx2q6237GVwshIIDw2PHf
	Flo5GVWU0AsstlVbVZfhj1nVe4WFAc+8tCIi7pRJkiM8zlT7x3a0UTtE0Ql2Ix52MRUcT5ynSGXKo
	NHlOrCIDu8j/fpdUe9te7kj2Or6UtaCLoMDIzX9ttNQ9fbqIb2PjfjP4dXfEvyKUIGfnLdWGrok1I
	y13oMWL3B/zugTcdOMvI2VnSwU+4BQ9BPIep0VWKcg7WZ90s3YkJrXxRuvQ9/is5Prd7eJMoIKX+q
	19f8BDyFIaGzLOKaQBCk1FiXUt9Ko2e25pgLLjkQqV4SyzyyiT5I343JIVueIrMJ3bW0C2D2TbfgO
	2RuT8UmA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sET7O-0000000EoxQ-0f7w;
	Tue, 04 Jun 2024 12:18:22 +0000
Date: Tue, 4 Jun 2024 13:18:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
Message-ID: <Zl8GDlOSh56VgRtj@casper.infradead.org>
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
 <20240604105950.1134192-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604105950.1134192-2-usamaarif642@gmail.com>

On Tue, Jun 04, 2024 at 11:58:24AM +0100, Usama Arif wrote:
> +++ b/mm/rmap.c
> @@ -1819,96 +1819,101 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  			dec_mm_counter(mm, mm_counter(folio));
>  		} else if (folio_test_anon(folio)) {
> -			swp_entry_t entry = page_swap_entry(subpage);
> -			pte_t swp_pte;
> -			/*
> -			 * Store the swap location in the pte.
> -			 * See handle_pte_fault() ...
> -			 */
> -			if (unlikely(folio_test_swapbacked(folio) !=
> -					folio_test_swapcache(folio))) {
> +			if (flags & TTU_ZERO_FOLIO) {
> +				pte_clear(mm, address, pvmw.pte);
> +				dec_mm_counter(mm, MM_ANONPAGES);
> +			} else {

This is very hard to review.  Is what you've done the same as:

			if (flags & TTU_ZERO_FOLIO) {
				pte_clear(mm, address, pvmw.pte);
				dec_mm_counter(mm, MM_ANONPAGES);
				goto discard;
			}

?  I genuinely can't tell.


