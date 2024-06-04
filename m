Return-Path: <linux-kernel+bounces-200789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D548FB513
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04819B28749
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D812D1E9;
	Tue,  4 Jun 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0UCj66VX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3F12CD98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510368; cv=none; b=BW18BIPNEdESI8DwYdc00UHcd5r3Gt4BN3H9TLwtULSTI6HpfS0tMZClIbzLSO8c+/1q39YchPIJPWbZQGgOAQz1nhp/38F53AbEF92m8lhuKJ1ez3hDDkMWe92So6TUPw6W9oDg0eK3NfLNjxvJmVNREeSBalVTo46ILcRLWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510368; c=relaxed/simple;
	bh=MN+40fDm0UxkjExz8ipcSWnwCRu/VFjhn21L4UnYaOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku9KXi221EnKXNvOntd4rk1W1YV5so1Jn9D2RGiqin1iqIH+/p8wXNcS95Az5W/40V/ftbbdKtcszrtoRrWA203yxj0y9TfidJormZEuffygw5yoQ/ARfWoXyAr9ie6Ht6blIZI+O9rnRsjWIvJOKXtbv083zgRPJRDOI1w6QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0UCj66VX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB408C2BBFC;
	Tue,  4 Jun 2024 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717510367;
	bh=MN+40fDm0UxkjExz8ipcSWnwCRu/VFjhn21L4UnYaOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0UCj66VX7cXqwbrhJQ68gBoRbxBzJlKWUXCbgU8oQE/SmXNwhaIw7RraEcF9JyAjR
	 k5ujgtiY78kH5wQGGuzRZ7nkjLm41kGTYrHMItQoUDMwTUJA/X6B4WxE4WzfqLp6Ct
	 JuHOTOaZwghfrdVZeT892KNveEbxbJzTZY1+CyKY=
Date: Tue, 4 Jun 2024 16:06:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>,
	Steven Moreland <smoreland@google.com>,
	Nick Chen <chenjia3@oppo.com>
Subject: Re: [PATCH v4] binder: use bitmap for faster descriptor lookup
Message-ID: <2024060442-fedora-maybe-e857@gregkh>
References: <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>
 <20240517032849.58437-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517032849.58437-1-cmllamas@google.com>

On Fri, May 17, 2024 at 03:28:27AM +0000, Carlos Llamas wrote:
> diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
> new file mode 100644
> index 000000000000..2cf470702bbb
> --- /dev/null
> +++ b/drivers/android/dbitmap.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_DBITMAP_H
> +#define _LINUX_DBITMAP_H
> +#include <linux/bitmap.h>

No copyright line for a new file?  Somehow I doubt that's what your
corporate policy is :(


> +
> +#define NBITS_MIN	BITS_PER_TYPE(unsigned long)
> +
> +struct dbitmap {
> +	unsigned int nbits;
> +	unsigned long *map;
> +};

Some documentation about how this all works would be nice so we can
verify / validate it is doing what it should be doing.

And maybe a test?

> +
> +static inline int dbitmap_enabled(struct dbitmap *dmap)
> +{
> +	return dmap->map != NULL;
> +}
> +
> +static inline void dbitmap_free(struct dbitmap *dmap)
> +{
> +	dmap->nbits = 0;
> +	kfree(dmap->map);
> +	dmap->map = NULL;

Why are you setting this to NULL after freeing it?  What does that
signal?

> +}
> +
> +static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
> +{
> +	unsigned int bit;
> +
> +	if (dmap->nbits <= NBITS_MIN)
> +		return 0;
> +
> +	bit = find_last_bit(dmap->map, dmap->nbits);
> +	if (unlikely(bit == dmap->nbits))
> +		return NBITS_MIN;
> +
> +	if (unlikely(bit < (dmap->nbits >> 2)))
> +		return dmap->nbits >> 1;

And these unlikely() markings actually work better than not having them?
Please document that if so.


> +
> +	return 0;
> +}
> +
> +static inline void
> +dbitmap_replace(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
> +{
> +	bitmap_copy(new, dmap->map, min(dmap->nbits, nbits));
> +	kfree(dmap->map);
> +	dmap->map = new;
> +	dmap->nbits = nbits;
> +}
> +
> +static inline void
> +dbitmap_shrink(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
> +{
> +	if (unlikely(!new))
> +		return;

All unlikely/likely needs to be "proven" to be needed, otherwise the
compiler and cpu almost always does a better job over time.

> +
> +	/*
> +	 * Make sure we can still shrink to the requested nbits as
> +	 * this call might have raced with another shrink or more
> +	 * bits have been assigned. In such case, release the @new
> +	 * bitmap and move on.
> +	 */
> +	if (unlikely(!dbitmap_enabled(dmap) ||
> +		     dbitmap_shrink_nbits(dmap) != nbits)) {
> +		kfree(new);
> +		return;
> +	}
> +
> +	dbitmap_replace(dmap, new, nbits);
> +}
> +
> +static inline unsigned int
> +dbitmap_expand_nbits(struct dbitmap *dmap)
> +{
> +	return dmap->nbits << 1;
> +}
> +
> +static inline void
> +dbitmap_expand(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
> +{
> +	/*
> +	 * Determine if the expand is still valid as it might have
> +	 * raced with another expand or free. In such case, release
> +	 * the @new bitmap and move on.

Shouldn't locks protect any race?  otherwise what happens if it changes
right after you check for this?


> +	 */
> +	if (unlikely(!dbitmap_enabled(dmap) || nbits <= dmap->nbits)) {
> +		kfree(new);
> +		return;
> +	}
> +
> +	/*
> +	 * ENOMEM is checked here as we can now discard a potential
> +	 * race with another successful expand. In such case, disable
> +	 * the dbitmap and fallback to slow_desc_lookup_olocked().
> +	 */
> +	if (unlikely(!new)) {

As you control the callers, how can this happen?

> +		dbitmap_free(dmap);
> +		return;
> +	}
> +
> +	dbitmap_replace(dmap, new, nbits);
> +}
> +
> +static inline int
> +dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> +{
> +	unsigned long n;
> +
> +	n = find_first_zero_bit(dmap->map, dmap->nbits);
> +	if (unlikely(n == dmap->nbits))
> +		return -ENOSPC;
> +
> +	*bit = n;
> +	set_bit(n, dmap->map);
> +
> +	return 0;
> +}
> +
> +static inline void
> +dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
> +{
> +	clear_bit(bit, dmap->map);
> +}
> +
> +static inline int dbitmap_init(struct dbitmap *dmap)
> +{
> +	dmap->map = bitmap_zalloc(NBITS_MIN, GFP_KERNEL);
> +	if (!dmap->map) {
> +		dmap->nbits = 0;
> +		return -ENOMEM;
> +	}
> +
> +	dmap->nbits = NBITS_MIN;
> +	/* 0 is reserved for the context manager */
> +	set_bit(0, dmap->map);

Yeah, this all needs to be documented somewhere please :)

thanks,

greg k-h

