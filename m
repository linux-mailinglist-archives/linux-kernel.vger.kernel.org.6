Return-Path: <linux-kernel+bounces-577053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B576A717BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DC3188D1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10601EEA59;
	Wed, 26 Mar 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGNxvXV5"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290031E5B96
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996884; cv=none; b=c0ow9gIkKmsQV9OIIbJP2b8UPnLYML7NBo1Lpul5kozj+jE6NGGLXJmlgpGhc6thPYF9alVrHo9OBiIe4F2h6VaWBInL2sNlk/jD2QQq8QkfZZaNx6dFvBlA4aFzl2dzZLNfdEQdt39HTd3jJ8u5h9C6ct0mWRnhf3jr3EP2UCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996884; c=relaxed/simple;
	bh=jh7jltZ0TL82geu3pwoRxx7NSA3ad7amVPFL5zvX4uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO9ebcoo/I7o1dcmQj20AoR/CviFnbjw3quHS55dsGQfW/EMjWwGeL4o2g11IxiP9qT33+Q90k7ZgtLBbAvR0qwZM6IJBEhGQPzWQuKS/EoNQyabUl++nGXePwgQMW03utCSgbjX/ya9T5lyQ7ub3NoB/wJnE6PMOuy6hUz5Vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PGNxvXV5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so332488a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742996880; x=1743601680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9sT5gYMVXxegd6ePB7XNS/u3ZsbMZydYpHA0nFGyi0=;
        b=PGNxvXV5jXU+X1Mx/BHNbpEZaAt8G18eCR1b7Kc+zJ+o01Rxk8+//CVeIFl+epKDlD
         efhZikQPmkuqOiDJ6aEuWYxw0PwtY9jwujmGhCJPjk50wkjJjj+BHOSkdWluVJ4/r4NA
         934wUzicdjHV2o2ViBW5vq2PY8tyz1XYiNRcRBwKXwTa0rXNKK3jar+55q0FKaBUtaa4
         JxMftMjkJHgPhDtRbj5ReD7Xs3kBmpn/P76wz89HKmKMGhvGd6twCIolFpLHIg4YPfcL
         1X1t7VGqevOmviCmuFu13zUyeHbMAfd2eoYc+UVC/nsQ8yieFtd6hR6nVD4z25ulxnzO
         KShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742996880; x=1743601680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9sT5gYMVXxegd6ePB7XNS/u3ZsbMZydYpHA0nFGyi0=;
        b=ZaCzlAegEMRAfGrcG6Czd5Z237uhCKWB7vmjEcZlPjQx4EU3WKkNLvH8nXsXPEhG2a
         3cbJUz04pbELU9HGl0p0vTskntmL9m0oErOSmEAtmYY0h2V/7oFVfft6emXx1G94xIEr
         lmhIuNYrjsDpAw7Z5LaDF1ribNsxjjRtXiZF1iXGNsnI9jVMVMwhA9YnBApoj0oaEy4+
         Z9W+isWlP4rjubY7iofmqXpKiQJKiFzP4h+e9Ygl7JeF+phbT5PekWqT802Nf/PkD2yC
         xANP50OTogPGGi7c7X+2PRSG1c5FLHKq7BDIs9vkT7fUWmaFRqYwrWpjLpGNVGahjtGz
         Bu7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4859maY4H60ioZvEUGEwnqrDTmjwn8ngQKSgKHmYunvWDMAZTVvv7TXancv31HgDZeosconWK2w5Z/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZwbrE8AB+UrsROKEdB3faY2NOMfe2X97ouCjbB9+SuN1aHj+
	EY17hewRuvEto+iEemDFc3yKfHop2+olg9BDvP0GPjcxSP8KzdA2AMioaZevPIUUDMccDEXkSd+
	E+WNA6dRZA6EAyogGi6rpPDAOvENsctuS8KO5Gw==
X-Gm-Gg: ASbGnctKOp4HgV12e1LXJ0Foie+1BwTIVYBCGuokbmhADxZDGSKs9vSP6qgwyUdq1sw
	V9X1yWYh2DJHS60b2n68Iun4W1QtjrgcrEC1YqCeYQjdfC34LAnnj91UVcNHdeNa+1ttei7vfSW
	kqJp8CNo/dgRvRUEwKbxfE3IRLfp/m+qkBTFSXXQ==
X-Google-Smtp-Source: AGHT+IEGSuYC4bKSUuP+CAwNwXG++bb6dx5rZNBEpA4UsLdcOk6cHr5Psu1CDRSptNtuO+3Eu1NGzt7joB7V/dpX/1E=
X-Received: by 2002:a05:6402:520c:b0:5ed:1841:18c5 with SMTP id
 4fb4d7f45d1cf-5ed1841200amr5524723a12.30.1742996880315; Wed, 26 Mar 2025
 06:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org> <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
In-Reply-To: <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 26 Mar 2025 14:47:46 +0100
X-Gm-Features: AQ5f1JrG9ZILdyykC_tS8t95UZ2cSs2k_HAmhl1CAgx9Sf_jLK7aZpBeM1uOp1g
Message-ID: <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>, sumit.garg@kernel.org, vbabka@suse.cz, 
	akpm@linux-foundation.org, kernel@pengutronix.de, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 12:07=E2=80=AFPM Marco Felsch <m.felsch@pengutronix=
.de> wrote:
>
> On 25-03-26, Matthew Wilcox wrote:
> > On Tue, Mar 25, 2025 at 09:07:39PM +0100, Marco Felsch wrote:
> > > Skip manipulating the refcount in case of slab pages according commit
> > > b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page"=
).
> >
> > This almost certainly isn't right.  I know nothing about TEE, but that
> > you are doing this indicates a problem.  The hack that we put into
> > networking should not be blindly replicated.
> >
> > Why are you taking a reference on the pages to begin with?  Is it copy
> > and pasted from somewhere else, or was there actual thought put into it=
?
>
> Not sure, this belongs to the TEE maintainers.

I don't know. We were getting the user pages first, so I assume we
just did the same thing when we added support for kernel pages.

>
> > If it's "prevent the caller from freeing the allocation", well, it neve=
r
> > accomplished that with slab allocations.  So for callers that do kmallo=
c
> > (eg setup_mm_hdr()  in drivers/firmware/efi/stmm/tee_stmm_efi.c), you
> > have to rely on them not freeing the allocation while the TEE driver
> > has it.
> >
> > And if that's your API contract, then there's no point in taking
> > refcounts on other kinds of pages either; it's just unnecessary atomic
> > instructions.  So the right patch might be something like this:
> >
> > +++ b/drivers/tee/tee_shm.c
> > @@ -15,29 +15,11 @@
> >  #include <linux/highmem.h>
> >  #include "tee_private.h"
>
> I had the same diff but didn't went this way since we can't be sure that
> iov's are always slab backed. As far as I understood IOVs. In
> 'worst-case' scenario an iov can be backed by different page types too.

We're only using kvec's. Briefly, before commit 7bdee4157591 ("tee:
Use iov_iter to better support shared buffer registration") we checked
with is_vmalloc_addr() || is_kmap_addr(). I like Matthew's suggestion,
it's nice to fix problems by deleting code. :-)

Sumit, you know the callers better. What do you think?

Cheers,
Jens

>
> Regards,
>   Marco
>
> > -static void shm_put_kernel_pages(struct page **pages, size_t page_coun=
t)
> > -{
> > -       size_t n;
> > -
> > -       for (n =3D 0; n < page_count; n++)
> > -               put_page(pages[n]);
> > -}
> > -
> > -static void shm_get_kernel_pages(struct page **pages, size_t page_coun=
t)
> > -{
> > -       size_t n;
> > -
> > -       for (n =3D 0; n < page_count; n++)
> > -               get_page(pages[n]);
> > -}
> > -
> >  static void release_registered_pages(struct tee_shm *shm)
> >  {
> >         if (shm->pages) {
> >                 if (shm->flags & TEE_SHM_USER_MAPPED)
> >                         unpin_user_pages(shm->pages, shm->num_pages);
> > -               else
> > -                       shm_put_kernel_pages(shm->pages, shm->num_pages=
);
> >
> >                 kfree(shm->pages);
> >         }
> > @@ -321,13 +303,6 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >                 goto err_free_shm_pages;
> >         }
> >
> > -       /*
> > -        * iov_iter_extract_kvec_pages does not get reference on the pa=
ges,
> > -        * get a reference on them.
> > -        */
> > -       if (iov_iter_is_kvec(iter))
> > -               shm_get_kernel_pages(shm->pages, num_pages);
> > -
> >         shm->offset =3D off;
> >         shm->size =3D len;
> >         shm->num_pages =3D num_pages;
> > @@ -341,10 +316,8 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >
> >         return shm;
> >  err_put_shm_pages:
> > -       if (!iov_iter_is_kvec(iter))
> > +       if (iter_is_uvec(iter))
> >                 unpin_user_pages(shm->pages, shm->num_pages);
> > -       else
> > -               shm_put_kernel_pages(shm->pages, shm->num_pages);
> >  err_free_shm_pages:
> >         kfree(shm->pages);
> >  err_free_shm:
> >
> >

