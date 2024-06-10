Return-Path: <linux-kernel+bounces-208213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069C902268
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE961C2039A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71E81AAA;
	Mon, 10 Jun 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZPcokS3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B932DDC0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024893; cv=none; b=Q8+8WcsfpP+kOo+UCCl6fr39FXd834ftlhCxaNbAG6FlIDBrdCUTcyN4L4fSL/qoWtHQpFuQXVhG64zMwYm38y1R5KCSNGe+CC584TsiET3FjNf1x3+/MotJU+kg3OZX7v7j71LEa3NU1wX9KL0dxFgZHsbWl9EMWQ8QdCAIZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024893; c=relaxed/simple;
	bh=vracCK0VNWSOKtwr48iUSsEQ4cLhIjq+bZMlZQavCbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSB0wXhuMCN2Ugeo+4zl5zR6pEi7fTr9KkMx5/7Oo8aJK55CulXYg4WOUFHVKj7beAT0MeeDKSLQmajYZb7nG8tT58IY6bmcGup7cI59TA4bBsWM0EQD/6HhpCGgdjM3tbFhfs2R7tbmDlT6FojFWAEYHlxr41nH31ronabuukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MZPcokS3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zrYKWWmw4V/ZlIEgWmnUno7t+ZXz7+GHNrH3l1iVN3o=; b=MZPcokS35qGlIRGdqJbwCnA6K0
	sk/6bbeZ/oFPqrTkuYcUEvvG7+4Ln0FyGd1e306YZu13Xg8U+NQSK+VztfZcSu2CQuYHwEYk0Qreh
	yDKHr1ki1A8EI2ztLt9EwUkDuR+wCdOEQ32Oo86FaNFe8A+mWadz71E06+a3hzT/Si4DYyA3h+F/k
	xFe86x0mjZDUsSEQdhR2zAUDjCjUiOGXvFUYMKeU03gvHP0uPHKETGE9j+Jl9RLe8LeNxAiaET8dF
	vC5Iji/qcXZvKbwfqs9r2QYUfPazIrFw3hdinC6U1MTcw6iYW/9AH4CPoYgKAEng4RCQxRlD5kXQD
	EDQKywNw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGekh-0000000989e-0ZeJ;
	Mon, 10 Jun 2024 13:07:59 +0000
Date: Mon, 10 Jun 2024 14:07:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	ying.huang@intel.com, hughd@google.com, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
Message-ID: <Zmb6r6vrP2UTDQrK@casper.infradead.org>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610121820.328876-2-usamaarif642@gmail.com>

On Mon, Jun 10, 2024 at 01:15:59PM +0100, Usama Arif wrote:
> +	if (is_folio_zero_filled(folio)) {
> +		swap_zeromap_folio_set(folio);
> +		folio_start_writeback(folio);
> +		folio_unlock(folio);
> +		folio_end_writeback(folio);

What's the point?  As far as I can see, the only thing this is going to
do is spend a lot of time messing with various counters only to end up
with incrementing NR_WRITTEN, which is wrong because you didn't actually
write it.


