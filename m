Return-Path: <linux-kernel+bounces-515619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B5A366BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63393AB4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC81F1C863D;
	Fri, 14 Feb 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXv0vaa5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B291C84D3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564039; cv=none; b=G1GxvLH2ukQra6k4al8eFQ7vYeP1OIJf0ZFKGjWXbaZJOjWhyxgM8S99EIR69xn6L1hVockQo4/M30tC7Hxb5taqGN0VETNWseBof5JjSmZvVzVxXYIxcr3otI9vFPKJNCKRW5NIDi8h54lbfShR2PvZjb8i9VBzPZzNyWgh89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564039; c=relaxed/simple;
	bh=11yDghk3Q1KQR9dyQo5cKk3cFl9oA0lfPn4n6ZcqiOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEpr4AOWwEg7hWv+FcemO39c41cCnqrGINhXXMDs0cHODr/3kKh/p7q25C+wg8+a63XCgbpLLuskO+18p8uXPQcGZ4ATkTnaUmkZt+5ADHeIeW+kLEQeowqBxXkLX3+LbDBx98yIoUhXoliZCHsFWkd8g1/LmvzPZdjjkpJQeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rXv0vaa5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fVBh7aaxMWrgdPSRhNEUp6jby7sv5vPC7kuSsBAFoKo=; b=rXv0vaa54mCblIpaapXigfgfw0
	41pAAYZSHcUBiYziL6XmjiawVrMCkvCDnhF3+uHPURZKvrqyDxeP439DBjJl3Ky4C92EQIEVGLAVU
	VQZcI0k6puXOTRH9Fzsk2crQ8SYp6BmBeB55MgQpCtUS5u8NTALpN0z+pCXddgI8/lKuKVYVxIjby
	2ew+8Bo7j7lj6jjn+fTLGKwti7RKK9L0Kod5D1ltwDamFQEfxqDyuikQcPRof4SCqnKgpZvlebwNe
	m5j5AFRmPWW058UoPMNhXFFGIgH1Di26Qy3IwqlxeYTfV94ZmWCiNHEweF9WhuHZ5c0Wo+hjCpHTZ
	JjtxbjtA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tj24F-0000000Bzz5-0gH6;
	Fri, 14 Feb 2025 20:13:43 +0000
Date: Fri, 14 Feb 2025 20:13:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm, swap: simplify folio swap allocation
Message-ID: <Z6-j924RCEBuDFHO@casper.infradead.org>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-8-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-8-ryncsn@gmail.com>

On Sat, Feb 15, 2025 at 01:57:09AM +0800, Kairui Song wrote:
> @@ -1648,20 +1639,20 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  	if (list_empty(&info->swaplist))
>  		list_add(&info->swaplist, &shmem_swaplist);
>  
> -	if (add_to_swap_cache(folio, swap,
> -			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
> -			NULL) == 0) {
> +	if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {

add_to_swap_cache() returns 0 on success or -errno.

folio_alloc_swap returns true on success.

That would seem to indicate you should change the polarity of this test?

Or should folio_alloc_swap() return an errno?  Is there value in
distinguishing why we couldn't alloc swap (ENOMEM vs ENOSPC, perhaps?)


