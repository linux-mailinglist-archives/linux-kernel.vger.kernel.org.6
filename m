Return-Path: <linux-kernel+bounces-265061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA993EC06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E53E1F21B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ADC8121F;
	Mon, 29 Jul 2024 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oUoxZGvT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE367F7C3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225086; cv=none; b=obpb0lwNwlE97pG0aAaDjRfkj4jDoqYt2eD6cjeKEKuTfj24knIcwQgS8aIcn3FZjlarb6TKPqydDnnpjZyGZ3gmescwHNtH39aIg5Yp6vZcvCx/jsfX4ZJhE5sH2HwmG69i93ovfHcx0TLjGHmx5j982H8M9BbCvoZmTQli1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225086; c=relaxed/simple;
	bh=r/JpuUdV1/Q5QNt180mJzf5qoQlTuP5Ec5tH6UZGmZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsMK9ou9oLKJ3b/WQFg1Jo63dJC8SeO98qttVXs0qhienYj2vBW7VHCt65xRft/wmhh1Rk288ZX42Xc9XFMKXf15nw2SYlvGKPSXWE6u4qyaCgSHNfuIZ/o4kz3d5XdyF04ywal5uI0yQHNSptR1+evAxPg4u/QXUhBWWTviK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oUoxZGvT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yAJ5Bm9rr84H9SSEudLui4/PD79oow3oFLakZDURc/4=; b=oUoxZGvT69EmvgCWAJt3LNCltZ
	W5hCcF6P0/uYLx+QC78e1zrcq2iRf4jJbfIcYdzP7/tbIl4KxIzaJjlUiKnQtYmXatAYhrf4LWjod
	v1ATEaTPmsgkltgSLiYXPwCZiR7BFHXDCEG4jNqmZyLniWE39fsfd14A6pfdGF7uOr5PQOQGPhV38
	aHHceC6XOHDTAQfikenOFvCHgpN3jVsRBMkrKT1Pw8afFbdPh0AGu8en1InpEjPfS573yz4im+0/L
	eZJiTjZ5ihxhj6//mkvnkT9vAf4HjOjFCWa9n1MIalTT41wMN6EBRNYushvR5oOLJ8oSc5VEwIjnW
	DrVvFmZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYHPf-0000000D7yD-2rAD;
	Mon, 29 Jul 2024 03:51:07 +0000
Date: Mon, 29 Jul 2024 04:51:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
Message-ID: <ZqcRqxGaJsAwZD3C@casper.infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726094618.401593-4-21cnbao@gmail.com>

On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> -			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> -						vma, vmf->address, false);
> +			folio = alloc_swap_folio(vmf);
>  			page = &folio->page;

This is no longer correct.  You need to set 'page' to the precise page
that is being faulted rather than the first page of the folio.  It was
fine before because it always allocated a single-page folio, but now it
must use folio_page() or folio_file_page() (whichever has the correct
semantics for you).

Also you need to fix your test suite to notice this bug.  I suggest
doing that first so that you know whether you've got the calculation
correct.


