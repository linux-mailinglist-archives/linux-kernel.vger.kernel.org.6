Return-Path: <linux-kernel+bounces-209436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B49034B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C64B2D695
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F7173350;
	Tue, 11 Jun 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBxarMO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C817333E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092713; cv=none; b=YMBKLcolIOXvY1LShwuiEx4z4UDui9BfPnzcUCXKisTBGqWL05AgVSUzgQTxrTSlXcN46CDypCgAcJOs5hog8nAuNl/LPXKnogwuYUiFswOzEXVYmbYYcPRc/xyK0cwDGR9sdWdmCMFYcuLB+z6kDIYf1tg9WyfNhH5ZIGqWXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092713; c=relaxed/simple;
	bh=H99vVv9ub0DJP3qHQoowqgVv5mp0f18pTA6aACoo1to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdivActrIvmVczZ3S1z1K7WmnYJBuCo1pibYZUXuCbELbAVUBZxej4M103b2jpfEY7zynh/giVuKCcZSHqFUEyFFHXgfbAzLXhhHkZrEanZxuypUelzOet8o7QG+TgP6Pyrwd+8h7QR4+L0s7gzQweg9LpwhCvHYF1jDRwWg0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBxarMO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5D0C2BD10;
	Tue, 11 Jun 2024 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718092710;
	bh=H99vVv9ub0DJP3qHQoowqgVv5mp0f18pTA6aACoo1to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBxarMO74u6V3m/bUhzkvkCqjqvOeU19xeLvYt9ai5SYcAaD6Lpe0nm4Gm39WcI8v
	 AinF8TfI1h1ptD9gPu+vBDAh31Wkrb7PZmEPz5HV+bO6zsJ7uaddgoq6Hgm2YHjBJT
	 01l9hz4WuFEnKSTOii57qgzAGGHBpJ7kUqOfLwJAMN4aFVKLazrXHWWrwlBVHTJfRK
	 0yuTEi8/tAU8c6bjrL30Mgmug2iXUKS9ohWjdQCOCnP9wRiA3dcJhdqYxQ/PYWmQ2i
	 t2d3PVOC/rBOhQ/NGKsAV2YpBE7WJd8SDs3jHy6ukpYnUhKBWyPuelRKBi8sSfqt5I
	 T+1NtLhjIiRsA==
Date: Tue, 11 Jun 2024 10:56:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/sparse: use MEMBLOCK_ALLOC_ACCESSIBLE enum instead
 of 0
Message-ID: <ZmgDKWtrcXRL-4rs@kernel.org>
References: <20240610151528.943680-1-lsahn@wewakecorp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610151528.943680-1-lsahn@wewakecorp.com>

On Tue, Jun 11, 2024 at 12:15:28AM +0900, Leesoo Ahn wrote:
> Setting 'limit' variable to 0 might seem like it means "no limit". But
> in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
> enum, which limits the physical address range end based on
> 'memblock.current_limit'. This could be confusing.
> 
> Use the enum instead of 0 to make it clear.
> 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v1 -> v2: do not rename 'limit' to 'limit_or_flag'
> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index de40b2c73406..cf93abc542ca 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -351,7 +351,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
>  again:
>  	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
>  	if (!usage && limit) {
> -		limit = 0;
> +		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
>  		goto again;
>  	}
>  	return usage;
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

