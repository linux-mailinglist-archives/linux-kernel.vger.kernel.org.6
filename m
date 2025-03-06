Return-Path: <linux-kernel+bounces-549938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15DA558D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065BC1899471
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A2C207676;
	Thu,  6 Mar 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dnXNe3gT"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E9249E5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296764; cv=none; b=aE0NUNcHP+O4PlCtw3p7uipKTD1QO9Phs8UypzJGvB/xqZwES4ZHq7pbrf2h8eYAS9eIz+RB5TzFU1dQbvK+aeJMp3M6Ty0LfYGLncAsG6lFAFHRQ+pMsiZ74mxATJh02drbUnpRypICs/cYx4BR5W3qaMwEubc6N3stEy0G+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296764; c=relaxed/simple;
	bh=jJ3H4jXJLbPslm4aNVbcg9Psbslza6a935iP7NUl1pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhzlN4t1m4PNPfoZo7TOWB7MKmB3ri0eFntYZqp+kkCfAuflomPSS/WjqrYbXFcxxqQ7rTe8e5+ycQAvKtTNeMWYz6/FH0Be5y2ByC6XFq1GfZNLTcUe2D/yoxb9fiScOGpvdA372IoYs++yJpgXqz81EpTP6VT8I8vAYQXNRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dnXNe3gT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 21:32:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741296760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/7x1oVZ9Su1f8eDZ7E7mAnws0/aWydnFGOtXeW9HjM=;
	b=dnXNe3gTZartsLN4Z9r+R1hCWfqnEsyeErHQB+UFtyVbFQxr/lzOkHl/V+Vd1Dlr98Yn48
	qo4sSd/XZL2W81K/WbYQWNgCDFm4zJSrg5HrOnMAR0oGMyJVtLJTl+8gJABnux4hHHGdbM
	08UDJOENHpAvM07wU1AJim+jwvHge3I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] page_io: zswap: do not crash the kernel on
 decompression failure
Message-ID: <Z8oUbUQrE5zlpezC@google.com>
References: <20250306205011.784787-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306205011.784787-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 12:50:10PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.
> 
> See [1] for a recent upstream discussion about this.
> 
> The zswap writeback case is relatively straightforward to fix. For the
> zswap_load() case, we change the return behavior:
> 
> * Return 0 on success.
> * Return -ENOENT (with the folio locked) if zswap does not own the
>   swapped out content.
> * Return -EIO if zswap owns the swapped out content, but encounters a
>   decompression failure for some reasons. The folio will be unlocked,
>   but not be marked up-to-date, which will eventually cause the process
>   requesting the page to SIGBUS (see the handling of not-up-to-date
>   folio in do_swap_page() in mm/memory.c), without crashing the kernel.
> * Return -EINVAL if we encounter a large folio, as large folio should
>   not be swapped in while zswap is being used. Similar to the -EIO case,
>   we also unlock the folio but do not mark it as up-to-date to SIGBUS
>   the faulting process.
> 
> As a side effect, we require one extra zswap tree traversal in the load
> and writeback paths. Quick benchmarking on a kernel build test shows no
> performance difference:
> 
> With the new scheme:
> real: mean: 125.1s, stdev: 0.12s
> user: mean: 3265.23s, stdev: 9.62s
> sys: mean: 2156.41s, stdev: 13.98s
> 
> The old scheme:
> real: mean: 125.78s, stdev: 0.45s
> user: mean: 3287.18s, stdev: 5.95s
> sys: mean: 2177.08s, stdev: 26.52s
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Couple of nits below, but otherwise LGTM:

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

(I did expect the swap zeromap change in the same series, so if you send
it separately make sure to mention it's on top of this one because they
will conflict otherwise)

[..]
> @@ -1606,7 +1628,26 @@ bool zswap_store(struct folio *folio)
>  	return ret;
>  }
>  
> -bool zswap_load(struct folio *folio)
> +/**
> + * zswap_load() - load a page from zswap

nit: folio

> + * @folio: folio to load
> + *
> + * Return: 0 on success, or one of the following error codes:

nit: Maybe worth mentioning that the folio is unlocked and marked
uptodate on success for completeness.

> + *
> + *  -EIO: if the swapped out content was in zswap, but could not be loaded
> + *  into the page due to a decompression failure. The folio is unlocked, but
> + *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swap_page()
> + *  will SIGBUS).
> + *
> + *  -EINVAL: if the swapped out content was in zswap, but the page belongs
> + *  to a large folio, which is not supported by zswap. The folio is unlocked,
> + *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
> + *  do_swap_page() will SIGBUS).
> + *
> + *  -ENOENT: if the swapped out content was not in zswap. The folio remains
> + *  locked on return.
> + */
> +int zswap_load(struct folio *folio)
[..]

