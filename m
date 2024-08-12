Return-Path: <linux-kernel+bounces-282784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C394E888
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8803D1C21673
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0B16B3B4;
	Mon, 12 Aug 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aX95ch9s"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846716ABF3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451229; cv=none; b=Udu2rvw7jM4GHYXmtpd0FgYDo5kmyaZDCYGKSnfPENz9CX+VqcxoeWVOsIa/YsDMdlZ9McRn5QfxbDtgMp4VQI99p1U7RrStgRbqUzWOJIB7z5fIhteSIADj/nQW8MWu4UVaGOC9O8t8EVYVya3gn7qXGDHcCYgoPGWXK/PV+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451229; c=relaxed/simple;
	bh=QlM8uuXC9O1Mt4nbWS19tHKQxRoKLas9zuNRdsYpcTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzu1uvgaozVp8whuVSUabOdkY0moQQ5GQKUfAST7sLdbDD+2tUgfysl6T78c9L8OLQ6VqJC96/ARC5NFazl3NiLYZXR/R5mZ0JtgAQLfB9RPJGGubxxf8GcBYzhQYtuNnas1tCrLt5KMbQuUUE9fhd0WEX2HvC7k1XfCW/Bs53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aX95ch9s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DzGPShZj/dAovMXyzcD3HCKI8PXy5jIutKKEn0gvgMU=; b=aX95ch9sjUJT8OsFzryyicDq6N
	CkNe6JUGbjUCe7UBtNFotHej386ZlqBI9PHKRaYu6PzFZkICt2wO81cAsRvJqZgvCui/VVXWI/fPg
	CJ8QzAwVve3iaokbyTdkbfF8KYUy0I5Jfc0UwIVTnoozIyeWSq9GlXSPI4bkoH0fHO4qogozDMSaL
	W/1ZJZMb4FJB+Fa6iUwBF8lKjh+Qq8gqmVVXIC/fBoOw1hPnxteDaAJQJsTDtIMeIneSc9InNpC7V
	/O3zlyp4zKX8YAj6MpNrD5QHaydegq7CdEJH5ITXny7XJeBsvW3UXy3UsnlhjbjR8FjNTqOznsWtU
	l+KMg5eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQOE-0000000HGuh-13nD;
	Mon, 12 Aug 2024 08:26:54 +0000
Date: Mon, 12 Aug 2024 01:26:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
	yosryahmed@google.com, hch@infradead.org,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like
 devices
Message-ID: <ZrnHTpzp65iZqTJ5@infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240802122031.117548-1-21cnbao@gmail.com>
 <20240802122031.117548-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802122031.117548-3-21cnbao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The subject feels wrong.  Nothing particular about zram, it is all about
SWP_SYNCHRONOUS_IO, so the Subject and commit log should state that.

On Sat, Aug 03, 2024 at 12:20:31AM +1200, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> Currently, we have mTHP features, but unfortunately, without support for large
> folio swap-ins, once these large folios are swapped out, they are lost because
> mTHP swap is a one-way process. The lack of mTHP swap-in functionality prevents

Please wrap your commit logs after 73 characters to make them readable.

> +/*
> + * check a range of PTEs are completely swap entries with
> + * contiguous swap offsets and the same SWAP_HAS_CACHE.
> + * ptep must be first one in the range
> + */

Please capitalize the first character of block comments, make them full
sentences and use up all 80 characters.

> +	for (i = 1; i < nr_pages; i++) {
> +		/*
> +		 * while allocating a large folio and doing swap_read_folio for the

And also do not go over 80 characters for them, which renders them
really hard to read.

> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE

Please stub out the entire function.



