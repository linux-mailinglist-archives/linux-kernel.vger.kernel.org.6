Return-Path: <linux-kernel+bounces-512080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E6A333D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C925D188A3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515F23B0;
	Thu, 13 Feb 2025 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SVY1aBb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A9800
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405311; cv=none; b=Q7chuDKKFmjTCzKBN0LWV+ZfrV6Yjq8sXw2n0CsH2URKERG3lxXrylaT6qcEtt65Vdcxf8XINWtIm7qnLrVOO9DAsT3aQ5Ckl9PnS1JoWvAgZFzXV+EaNXUIqHHH8cgfP1SJs7SvoYDoQVO2sQFGPkWdt5d2hbJBn5CrJ5pTO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405311; c=relaxed/simple;
	bh=Ay+MnAffsrmvsH0jD18LAzU0xxhWGvUHK+WQwsePY6Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M5MsLbLPlo2DNNsnchvug2Fgm1fZQpC0CAnPiVtGdFKuqs8ufh1VQ8H2WYMpBoKBGnh8MJb0nznPDamKk9XXP87ZwEdDxszilvI2HJPICOjOJUqKTY8eJ8Q/PZR71Efad43KLpZkbenWKp0xJrsvjmgA3g2nUibr9/VMwy+tBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SVY1aBb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCB4C4CEDF;
	Thu, 13 Feb 2025 00:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739405311;
	bh=Ay+MnAffsrmvsH0jD18LAzU0xxhWGvUHK+WQwsePY6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVY1aBb6LEGP+BLLUb9e1t0E+T6a9dZEnhZT4qrJVl6AZYNSujmiVCG8ZKfvXa3yx
	 L5VSfGoXpKjdgSk7Th/9B7s7iTSeXVuUvtIgP3kas0YHu3ssHPfwpMY0ijFddQISbQ
	 /Xx8+oLsr+K+s+XbJxWS7SNuC23ClYeflmZ+GdlI=
Date: Wed, 12 Feb 2025 16:08:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>,
 Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/18] zram: sleepable entry locking
Message-Id: <20250212160830.730a199935e907c2498b28d4@linux-foundation.org>
In-Reply-To: <20250212063153.179231-2-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
	<20250212063153.179231-2-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:26:59 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Concurrent modifications of meta table entries is now handled
> by per-entry spin-lock.  This has a number of shortcomings.
> 
> First, this imposes atomic requirements on compression backends.
> zram can call both zcomp_compress() and zcomp_decompress() under
> entry spin-lock, which implies that we can use only compression
> algorithms that don't schedule/sleep/wait during compression and
> decompression.  This, for instance, makes it impossible to use
> some of the ASYNC compression algorithms (H/W compression, etc.)
> implementations.
> 
> Second, this can potentially trigger watchdogs.  For example,
> entry re-compression with secondary algorithms is performed
> under entry spin-lock.  Given that we chain secondary
> compression algorithms and that some of them can be configured
> for best compression ratio (and worst compression speed) zram
> can stay under spin-lock for quite some time.
> 
> Having a per-entry mutex (or, for instance, a rw-semaphore)
> significantly increases sizeof() of each entry and hence the
> meta table.  Therefore entry locking returns back to bit
> locking, as before, however, this time also preempt-rt friendly,
> because if waits-on-bit instead of spinning-on-bit.  Lock owners
> are also now permitted to schedule, which is a first step on the
> path of making zram non-atomic.
> 
> ...
>
> -static int zram_slot_trylock(struct zram *zram, u32 index)
> +static void zram_slot_lock_init(struct zram *zram, u32 index)
>  {
> -	return spin_trylock(&zram->table[index].lock);
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_init_map(&zram->table[index].lockdep_map, "zram-entry->lock",
> +			 &zram->table_lockdep_key, 0);
> +#endif
> +}
> +
>  
> ...
>
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	lockdep_register_key(&zram->table_lockdep_key);
> +#endif
> +

Please check whether all the ifdefs are needed - some of these things
have CONFIG_LOCKDEP=n stubs.

