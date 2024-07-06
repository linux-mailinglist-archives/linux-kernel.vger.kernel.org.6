Return-Path: <linux-kernel+bounces-243098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B608E92919B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7696C2838AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C893BBD7;
	Sat,  6 Jul 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="acdeXE6f"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520636B0D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252265; cv=none; b=r3lhIIljhD6wNJguYNPKMGYC2bzfGuZJBCtr6UPp1O+pWttCfhbkGBxahOBsqaJd4Z6ULUN+LuP/gbekbxoY0nL/S33tGK/ZSN7+pHWqtQAzHWmzFJHguOw9bWz8IMFx+piaR1qZgXb/wgIl8jwr8+Eny9YCDrSOP3LcYNz1KZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252265; c=relaxed/simple;
	bh=fwGGZdv1Ia0nzDzoHbUh/ORyBKBBm+8VRQiqXirf1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5B25SuwjpmUo2KXKnQUanaQA2jSkQbYAlPBm11rEYryZBwWzcbQcRN3mAsTCTgEuEZb3aE7hIUvmFYYiOBf2bmkWujO0fTgc6QcsLVbVGuLvgmBjj/pVzAmOY1hUTRZXV08xGbca/ymNMNXAFF7xSgHedZQ4urVuqyydEVyJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=acdeXE6f; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720252258;
	bh=fwGGZdv1Ia0nzDzoHbUh/ORyBKBBm+8VRQiqXirf1AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acdeXE6fnVHz6+6me83Wsn7hfi99PJCn2Frz4uTsy7mtPH2VYYdsLVFE6A/7JVnYg
	 XZY1/ciwMls9NIVzeG/3mdQvJh9AMxzEzBoI6ncRdaI26yznNpZl6qinGfmZz4Rcds
	 CbL2/UZpI90agEtS5n9spCrPrgzQBJi8VFpQSzJc=
Date: Sat, 6 Jul 2024 09:50:57 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 04/23] zram: introduce custom comp backends API
Message-ID: <8fe873d4-b9c4-47ad-b779-e1012677011e@t-8ch.de>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
 <20240706045641.631961-5-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706045641.631961-5-senozhatsky@chromium.org>

On 2024-07-06 13:56:06+0000, Sergey Senozhatsky wrote:
> Moving to custom backends implementation gives us ability to
> have our own minimalistic and extendable API, and algorithms
> tunings becomes possible.
> 
> The list of compression backends is empty at this point,
> we will add backends in the followup patches.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/Kconfig    |  39 +--------
>  drivers/block/zram/zcomp.c    | 151 +++++++++++-----------------------
>  drivers/block/zram/zcomp.h    |  29 ++++---
>  drivers/block/zram/zram_drv.c |   9 +-
>  4 files changed, 76 insertions(+), 152 deletions(-)

<snip>

> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (C) 2014 Sergey Senozhatsky.
> - */
>  
>  #ifndef _ZCOMP_H_
>  #define _ZCOMP_H_
> @@ -12,13 +9,26 @@ struct zcomp_strm {
>  	local_lock_t lock;
>  	/* compression/decompression buffer */
>  	void *buffer;
> -	struct crypto_comp *tfm;
> +	void *ctx;
> +};
> +
> +struct zcomp_ops {
> +	int (*compress)(void *ctx, const unsigned char *src, size_t src_len,
> +			unsigned char *dst, size_t *dst_len);
> +
> +	int (*decompress)(void *ctx, const unsigned char *src, size_t src_len,
> +			  unsigned char *dst, size_t dst_len);
> +
> +	void *(*create_ctx)(void);
> +	void (*destroy_ctx)(void *ctx);
> +
> +	const char *name;
>  };
>  
>  /* dynamic per-device compression frontend */
>  struct zcomp {
>  	struct zcomp_strm __percpu *stream;
> -	const char *name;
> +	struct zcomp_ops *ops;

If this is "const struct zcomp_ops *ops" then all the backend struct
zcomp_ops definitions could be constified, improving security.

"zcomp_ops" could also be added to scripts/const_structs.checkpatch,
but there probably won't be many of them anyways.

>  	struct hlist_node node;
>  };

<snip>

