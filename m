Return-Path: <linux-kernel+bounces-518176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38302A38AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F48418929AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B6233132;
	Mon, 17 Feb 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/g9dTBH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830723237B;
	Mon, 17 Feb 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815097; cv=none; b=tLNnBXvdMFXLZxuTtmdar9DZsvG3tcVcIJOnmFQ9dk840pbNws4BPWGIqhdMRt1dFZ+I7w5FtJHZxjbOCJ+KNs4hfhfwtazFRmN24C25uUPgNWw4+JF/mes04VnbTDmQGNhcBZNQibMzmnfYzV1HRgTjArhCnauHrqQu49Cae5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815097; c=relaxed/simple;
	bh=6ltP+TZZn/20otmJZwCcwK9EYJ+AVNKcUSghHOok8bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL8F93AbfPCMGqDY/mERkBfChY4Krw+bJrj32DOPybWdEVUiPuF8wbi7xs/XLsVqYtpuETJMuwKdI+M1KrJhlTRF1faLyNePtTqmfR9ss3DADKy16nrtNRsuaoDCX04ohjD+BpE0hL0lu5MRI+n5sw241sLJlthjQWJG2qvInkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/g9dTBH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j+FzReHu2D29+ormcX1qLAUNVPWvk3sDBenwW2uljpI=; b=c/g9dTBHbqKOdkGcQONgiC74/X
	hTGvJzDd5KIPqKrOHrvLrMI11aWIFp7fWBoTdRcO+r7+uNzeAQ6rdxPaMsTyElPTfKv0jzKs7CEgE
	HpnbNLstSeXQVzzd0e7pML95czGQ0wGt4HdLw+fmr99dluOU91Mws72WrCaGMgA+yRM2k6tae66sA
	JzJistXqLkxmfE7tletLM8gQd8mZSRe9KNnPigUCOWahASqh6ko9Nq/E4D+Pj7GJUmyRxpFbd6NY6
	OHX+d4tre10IjPwag2867if4izzYjCGyHiIVaPnUmorl/WqlpRvylQ4GF5ndkH3feNwRj7qmyffGw
	mgSN2vPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk5Nk-00000001k7S-0p68;
	Mon, 17 Feb 2025 17:58:12 +0000
Date: Mon, 17 Feb 2025 17:58:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/mincore: improve performance by adding an
 unlikely hint
Message-ID: <Z7N4tLUpRA1EKfDm@casper.infradead.org>
References: <20250217170934.457266-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217170934.457266-1-colin.i.king@gmail.com>

On Mon, Feb 17, 2025 at 05:09:34PM +0000, Colin Ian King wrote:
> Adding an unlikely() hint on the masked start comparison error
> return path improves run-time performance of the mincore system call.
> 
> Benchmarking on an i9-12900 shows an improvement of 7ns on mincore calls
> on a 256KB mmap'd region where 50% of the pages we resident.
> 
> Results based on running 20 tests with turbo disabled (to reduce
> clock freq turbo changes), with 10 second run per test and comparing
> the number of mincores calls per second. The % standard deviation of
> the 20 tests was ~0.10%, so results are reliable.

I think you've elided _just_ enough information here that nobody can
judge whether your stats skills are any good ;-)  You've told us 7ns
(per call, presumably) and you've told us 0.10% standard deviation,
but you haven't told us how long the syscall takes, so nobody can tell
whether 7ns is within 0.10% or not ;-)

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  mm/mincore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mincore.c b/mm/mincore.c
> index d6bd19e520fc..832f29f46767 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -239,7 +239,7 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
>  	start = untagged_addr(start);
>  
>  	/* Check the start address: needs to be page-aligned.. */
> -	if (start & ~PAGE_MASK)
> +	if (unlikely(start & ~PAGE_MASK))
>  		return -EINVAL;

We might get even more advantage by moving the EINVAL test before
untagged_addr() since we know that the tags are all in the high bits and
we don't need to have the test be dependent on the previous arithmetic.

