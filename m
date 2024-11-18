Return-Path: <linux-kernel+bounces-412380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B769D0846
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F1BB2183A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C17F460;
	Mon, 18 Nov 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Urob7bVg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69E5A79B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902619; cv=none; b=IgOJ65xueEmvI7R6NTALSpILsmpXh/RRoKMEWI5hG1E2fZZ951qxkiTWoevxiHd1B/qMtBxAHz7GNnv0QYjONuPD10KkUSN8s72gFIAsumXdIG9+si/iw4KY+Kg2K5Sj67jEV4ocUX/QeGjwzHdD2NyEL+dq6JmEucJUl0TxYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902619; c=relaxed/simple;
	bh=3ePLqGtatfVfIXxTI/YnUsPYUbSVrlG+0tHZfXL92sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQJIUh5n5miAfX1D1CJa40ELNhkxuuh5PZ9lt7dfk4btp1RX8nR56sjX6v7u+Y+gsBZQQIeAmNEEBqqZAkfZa9+koq0mfN09QwBOQ83LECxQ19SUWKnnC59oEqJTAEJ5+ibaUPH3ORbtNV8oHFXIg+2ZoXWFmnmbNkCTYRkXa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Urob7bVg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=boSi3xL7VHuzHznVUUgFDFV80UsWJg2EYGUK1On7fzw=; b=Urob7bVg3BZ/R/LRt0nMuI51xt
	DFTOd4yr6ZB8hD3AWIi4adqmPrOjGfEhyIGDN01gHbE+dxDnRb24Mtg4wGGnszVjxznoXl2NHPk1t
	gC7iMnTyR5Y8afI6DKblS8iLqr9iFv/3FDuX/hu8T1P2cWnZ7BCVHMjb7iLd5J8JQM/NfSVru3ltl
	ElZilL5gFpsC/LSiX64Fg7CyvTUXw/zRQGsiuUaVrZRn82Ur2mB51pzL2iGAK7OMx0yZ8k+wMiesv
	ICyt970f6KwRb+vwJj2ZesGTTV/2vm+jBTWuYZPtYtZYwKoKnsABqVbHUUk4Dp3lEQD6G3kRYP0uV
	q9mg3EsA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCsz1-00000002Y00-06LG;
	Mon, 18 Nov 2024 04:03:27 +0000
Date: Mon, 18 Nov 2024 04:03:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com,
	ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to
 the tail of LRU after shrinking
Message-ID: <Zzq8jsAQNYgDKSGN@casper.infradead.org>
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116091658.1983491-2-chenridong@huaweicloud.com>

On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
>    and added to swap cache folio by folio. After adding to swap cache,
>    it will submit io to writeback folio to swap, which is asynchronous.
>    When shrink_page_list is finished, the isolated folios list will be
>    moved back to the head of inactive lru. The inactive lru may just look
>    like this, with 512 filioes have been move to the head of inactive lru.

I was hoping that we'd be able to stop splitting the folio when adding
to the swap cache.  Ideally. we'd add the whole 2MB and write it back
as a single unit.

This is going to become much more important with memdescs.  We'd have to
allocate 512 struct folios to do this, which would be about 10 4kB pages,
and if we're trying to swap out memory, we're probably low on memory.

So I don't like this solution you have at all because it doesn't help us
get to the solution we're going to need in about a year's time.

