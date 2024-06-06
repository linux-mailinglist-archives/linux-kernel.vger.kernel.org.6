Return-Path: <linux-kernel+bounces-204918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03D8FF4F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230C21C25ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AED4DA14;
	Thu,  6 Jun 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwS00qxt"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903D45023
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699822; cv=none; b=GYN0Qg4dGmKdWVRieb0QZGGqtbTHSuAPagTR8FckPmP7X5ddzHjsYd8iVo8uHIybftTL45t0j2cQu5JR2w11/UKRW5hx1XcLMGVBo9bXD2jI1qoWra+zpBbJV7MS6H9cK/sM+xZ85+pedvspnpGSC00ew3bOfPhkz5B5dupCjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699822; c=relaxed/simple;
	bh=OYrpDWvh+sz1afnL30MOsHvf23gGbV1sXCH9poiRVt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC7qnO+7i6nYG8fmfvZRspjRqxf4K1YOxLOICEczHvmTKXhdDzg7MUfeREszeOFtdQkhn9dYZOfQrs+S1CMy+mmMkbvIUg0x+J1lCuwXqQKBlIBCS+Aa5LTY8xiNRTln7axu1fifLA6kRXW07ctA9W/1Ss7sbq2gye150c6C3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwS00qxt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so907011a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717699820; x=1718304620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXIg42Q4PtddA3akVwpr+MhdVyrrzaiaO18W2LCI5gY=;
        b=BwS00qxtUcAnHqLZPKjMQqhAKwD5Qqi8p5O0+ZRdN8etqsSIAzJ8IdtsPJIhyjB09M
         B54V93QZBscAW7zr6+sQXnVixhER6coW7J8KvLgAyoeJ3+iKaHlv+omFMJ9oTBzVn0pU
         I0V4iagzoqXv4wycrK4wsry+YzVtV6UWIcW6Gn5nKT8Qqj9EbiId43dosfEwlt/8Dr/a
         b1vOBXZh6Hu8dCs9lNkJ/N/TT+W2ZVxigt+fWsy+hZIyYzsB9BZ2RmFf1tOaRaTpHmD9
         NlKSAZ/0sxipAB5Kc82DMC262Bz4HO6zA5b6bIc6SEOvCxmRB9QRLeiZ6bK8u8V+stGF
         DJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699820; x=1718304620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXIg42Q4PtddA3akVwpr+MhdVyrrzaiaO18W2LCI5gY=;
        b=wKfkWYPQMTgIkmh3BEmr+yowT5/pKclh3b0C46GCVZkEzLPRv3z62rvDbIw3nw/sxu
         q2qJ4oXWDjQHEDNdMciZveT7xShBBXBHoadH6tVsERYvY1iZ0OpHEdCFFtKs+sV/Q7Ku
         LAZl6zU66xyjatJiso+X6m2H2zNIzo4MQzG98ZRckKNXLvfnufwxwuEaVqcBRD0fmLnB
         SGhe66GT2KH/JYyqteoygY/+kxf1q7rEF4uoSaPYB5uyzcCX0mkS4NpIoPxvnBK/ohQX
         Uzw+3XtPWwvEKucWb9k0s4PcqBVxrQTB0xqj0PauDgqfxx69fZ13HM5Q8SA6oZFCrr9D
         SLUg==
X-Forwarded-Encrypted: i=1; AJvYcCWETrLg3xWoJq1OWR0EsH5hrvkpaYRAXbx6RNuzX3yBef/lVs52jm0iQ1os16VR1VIRyB2HrhH/ISUJJkjCR2n/Lo66vUFLACUA1BOJ
X-Gm-Message-State: AOJu0YwXdarA8zc9s7H4TJSqRUAJL965AStEjzWiMbdwL5SFM1Hi+d3b
	bWCklBsyvcLfcAPeXAuHuGu+LiIj4dcoPK/bfi28axu0cOACuovQTWImEuwk6Q==
X-Google-Smtp-Source: AGHT+IEiZ8MVS6KAl6HLH59uHgWQfvalsP7K5TelR9uyzGhKZsbOBXNDUnwafw8P3oYGWAwcKYzlGQ==
X-Received: by 2002:a17:90a:4b87:b0:2c1:a9d9:67be with SMTP id 98e67ed59e1d1-2c2bcb02581mr378874a91.13.1717699819359;
        Thu, 06 Jun 2024 11:50:19 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c20d7f4sm2005950a91.6.2024.06.06.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:50:18 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:50:11 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <ZmIE4-acswjWoZ21@google.com>
References: <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>
 <20240517032849.58437-1-cmllamas@google.com>
 <2024060442-fedora-maybe-e857@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024060442-fedora-maybe-e857@gregkh>

On Tue, Jun 04, 2024 at 04:06:16PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 17, 2024 at 03:28:27AM +0000, Carlos Llamas wrote:
> > diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
> > new file mode 100644
> > index 000000000000..2cf470702bbb
> > --- /dev/null
> > +++ b/drivers/android/dbitmap.h
> > @@ -0,0 +1,139 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _LINUX_DBITMAP_H
> > +#define _LINUX_DBITMAP_H
> > +#include <linux/bitmap.h>
> 
> No copyright line for a new file?  Somehow I doubt that's what your
> corporate policy is :(

It is not, sorry I'll fix it.

> 
> 
> > +
> > +#define NBITS_MIN	BITS_PER_TYPE(unsigned long)
> > +
> > +struct dbitmap {
> > +	unsigned int nbits;
> > +	unsigned long *map;
> > +};
> 
> Some documentation about how this all works would be nice so we can
> verify / validate it is doing what it should be doing.
> 
> And maybe a test?
> 
> > +
> > +static inline int dbitmap_enabled(struct dbitmap *dmap)
> > +{
> > +	return dmap->map != NULL;
> > +}
> > +
> > +static inline void dbitmap_free(struct dbitmap *dmap)
> > +{
> > +	dmap->nbits = 0;
> > +	kfree(dmap->map);
> > +	dmap->map = NULL;
> 
> Why are you setting this to NULL after freeing it?  What does that
> signal?

The signal is on dbitmap_enabled(). I'll either add a comment to this or
create a dbitmap_disable() to pair with it in the next version.

> 
> > +}
> > +
> > +static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
> > +{
> > +	unsigned int bit;
> > +
> > +	if (dmap->nbits <= NBITS_MIN)
> > +		return 0;
> > +
> > +	bit = find_last_bit(dmap->map, dmap->nbits);
> > +	if (unlikely(bit == dmap->nbits))
> > +		return NBITS_MIN;
> > +
> > +	if (unlikely(bit < (dmap->nbits >> 2)))
> > +		return dmap->nbits >> 1;
> 
> And these unlikely() markings actually work better than not having them?
> Please document that if so.
> 
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static inline void
> > +dbitmap_replace(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
> > +{
> > +	bitmap_copy(new, dmap->map, min(dmap->nbits, nbits));
> > +	kfree(dmap->map);
> > +	dmap->map = new;
> > +	dmap->nbits = nbits;
> > +}
> > +
> > +static inline void
> > +dbitmap_shrink(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
> > +{
> > +	if (unlikely(!new))
> > +		return;
> 
> All unlikely/likely needs to be "proven" to be needed, otherwise the
> compiler and cpu almost always does a better job over time.

Ok, I'll drop all these unlikely/likely and let the compiler and cpu do
their thing.

> 
> > +
> > +	/*
> > +	 * Make sure we can still shrink to the requested nbits as
> > +	 * this call might have raced with another shrink or more
> > +	 * bits have been assigned. In such case, release the @new
> > +	 * bitmap and move on.
> > +	 */
> > +	if (unlikely(!dbitmap_enabled(dmap) ||
> > +		     dbitmap_shrink_nbits(dmap) != nbits)) {
> > +		kfree(new);
> > +		return;
> > +	}
> > +
> > +	dbitmap_replace(dmap, new, nbits);
> > +}
> > +
> > +static inline unsigned int
> > +dbitmap_expand_nbits(struct dbitmap *dmap)
> > +{
> > +	return dmap->nbits << 1;
> > +}
> > +
> > +static inline void
> > +dbitmap_expand(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
> > +{
> > +	/*
> > +	 * Determine if the expand is still valid as it might have
> > +	 * raced with another expand or free. In such case, release
> > +	 * the @new bitmap and move on.
> 
> Shouldn't locks protect any race?  otherwise what happens if it changes
> right after you check for this?

Yes, there are locks protecting this call. However, these are spinlocks
so the bitmap gets alloc'ed outside of them. e.g.

	nbits = dbitmap_expand_nbits(dmap);
	spin_unlock(&proc->lock);
	new = bimap_zalloc(nbits, GFP_KERNEL);
	spin_lock(&proc->lock);
	dbitmap_expand(dmap, new, nbits);

Thus why we need to check if other task beat us to the expand.
Sorry, I now realize this needs to be documented.

> 
> 
> > +	 */
> > +	if (unlikely(!dbitmap_enabled(dmap) || nbits <= dmap->nbits)) {
> > +		kfree(new);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * ENOMEM is checked here as we can now discard a potential
> > +	 * race with another successful expand. In such case, disable
> > +	 * the dbitmap and fallback to slow_desc_lookup_olocked().
> > +	 */
> > +	if (unlikely(!new)) {
> 
> As you control the callers, how can this happen?

Delaying this check has the advantage that we can rely on another
successful expand call. So in this case the "race" is good. The comment
above the check has these details.

> 
> > +		dbitmap_free(dmap);
> > +		return;
> > +	}
> > +
> > +	dbitmap_replace(dmap, new, nbits);
> > +}
> > +
> > +static inline int
> > +dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> > +{
> > +	unsigned long n;
> > +
> > +	n = find_first_zero_bit(dmap->map, dmap->nbits);
> > +	if (unlikely(n == dmap->nbits))
> > +		return -ENOSPC;
> > +
> > +	*bit = n;
> > +	set_bit(n, dmap->map);
> > +
> > +	return 0;
> > +}
> > +
> > +static inline void
> > +dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
> > +{
> > +	clear_bit(bit, dmap->map);
> > +}
> > +
> > +static inline int dbitmap_init(struct dbitmap *dmap)
> > +{
> > +	dmap->map = bitmap_zalloc(NBITS_MIN, GFP_KERNEL);
> > +	if (!dmap->map) {
> > +		dmap->nbits = 0;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dmap->nbits = NBITS_MIN;
> > +	/* 0 is reserved for the context manager */
> > +	set_bit(0, dmap->map);
> 
> Yeah, this all needs to be documented somewhere please :)

Yeah ok, I'll add the documentation.

> 
> thanks,
> 
> greg k-h

Thanks,
Carlos Llamas

