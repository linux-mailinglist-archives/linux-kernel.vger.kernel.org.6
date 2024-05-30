Return-Path: <linux-kernel+bounces-195841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBEC8D52A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7848A1F23FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAEA6A016;
	Thu, 30 May 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz9G4chk"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414574D8A0
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098618; cv=none; b=jakSo/CQeUAR0dA+sodjQxyuJz24OO6QvLwjYyZQelqEWSi5E0MZltME8LGDqtKWr2W1p1uUB03xaHID+Cwd/gu2O3XQSL2ut0LEo66h/EYHq/1PMmt/l+gvyUSuzdpTMddyLzSQ+sBeiPETAEpXjnffJ12mhCTxlX/wKIFm89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098618; c=relaxed/simple;
	bh=bhuSS6mmp7DUP0HCSY8qYZEvft2ONd9WcIq8daKw6BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMxEOCtP5cohFyy6zW1SWAyouW5lbkQ7iUd3eSJzI1hQLMRQhvkuLasRe/6n8yQZBzOjr40x/XcsDdmarS0918zWQoTym2lO35os6h/h0BRaDuq2eojpEmbP7BmKw2BFoaXXwcNPaRlsU1XSwpbM/7efokUI8fRXRcY4ouFkxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz9G4chk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a63036f2daaso137413066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717098614; x=1717703414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6wRNe3Cnz+DyCo7wP/3ZRDce4Mvllz18ZChzx9cU4c=;
        b=Kz9G4chkhIPuUv7ZVgmxWx3xceEa0EA7nxJn/0WAzAzaaGg0bP16hiqykOo5dBC8uv
         Rn3c6/jgV+pOP/so42aJOAT/A9DwivofAGO7Kn/Tlk5KdaXcxmL0u1RgrgJLnRVYN6Kq
         MuhhB7O5lkr5tIw+BRIgT2WTJwV2wAhXonYuoYup393oaabV4rS660ULTYn1hTw4yif4
         TJvqHs92Whx9KwJtOSA9OOjfFzkqy+dK1FlF4fKBIhQmUMXNavO/R/odyStQUCaL4TiY
         NOw5sitDMpfuCiFMKE7Gbq/V7ugj+e+bsvJhLeUr/B8tE1vL8Mik5YrIJlxRww7tNDDN
         vITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717098614; x=1717703414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6wRNe3Cnz+DyCo7wP/3ZRDce4Mvllz18ZChzx9cU4c=;
        b=YBvwJbxn58XuGX3JCYnqDoQZfHDDickggMBFg+IhIg1U6AkFgpVoV8sm9oSD+OEU0u
         tInHz7LJsmBhw5QS2td+XoX2pO06vUuYGLFOSWRRuGz8WG4O+4f8eEgso1Fu3y850BaV
         3HcKWUhE2wi0om+aHdrQ9G5L2alZMGvtafKQoY++widvZdEyEG0Neb/IpNOMKed9D5Lp
         vCmbusOUSPMQ7dCKyVGYD1Xm1nlG6xTrpKbp0HplMK+WwnSIdZ/3twXpfAkoqo8dWZEV
         Y0vlFsqGZc7I4TFhNJBiTtl/DxvrKaYiH/vqQTBxI0zY8fWPXA84yObqY9nIhbhKY3Qg
         b6qA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZCAKj8jTiuybrQJLMXHIC6ODVyrE3N1Ma7Ii5/s3pAmFLcmhb2Na/MaPdjNAi4vjSyLe6885/As2dZYS2sB+DW7dqNWuOmS6h1jt
X-Gm-Message-State: AOJu0YykVcIytgBpU18FnHW+apwPtw4wwpoqdD8RSZen9bn9YpsvZMGR
	Y5mq4spK6oLE/xvyzkIbunrQgGW/9tokPA3wwurSUFEvKv2lJfG/DQbOWjQb4b2rmEsTkJXsiqm
	FdRkJvqzqw15eKgBOE5Slkv1AIEyTyqRDAWYh
X-Google-Smtp-Source: AGHT+IF1c1eWKrOm8daSYlxTJweKPmwyeDE632pzkKk1rxsIUu5gUd8ChEDGZNeFvJNrqUFCwlz77fCk9SnWFf3XsQs=
X-Received: by 2002:a17:906:3b98:b0:a67:6bdb:10bf with SMTP id
 a640c23a62f3a-a676bdb1519mr60256266b.16.1717098613679; Thu, 30 May 2024
 12:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com> <20240530122715.GB1222079@cmpxchg.org>
 <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com> <CAKEwX=NX-4dbietxy-25F-OotuGGL0F9h+hwV76b9Ap5nSy9uw@mail.gmail.com>
In-Reply-To: <CAKEwX=NX-4dbietxy-25F-OotuGGL0F9h+hwV76b9Ap5nSy9uw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 30 May 2024 12:49:35 -0700
Message-ID: <CAJD7tkYDjmMLnH_2sQuuMLE0FE5YqZEppNsprCnm5RdaSkGEBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Usama Arif <usamaarif642@gmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 12:18=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Thu, May 30, 2024 at 9:24=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, May 30, 2024 at 5:27=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > On Thu, May 30, 2024 at 11:19:07AM +0100, Usama Arif wrote:
> > > > Approximately 10-20% of pages to be swapped out are zero pages [1].
> > > > Rather than reading/writing these pages to flash resulting
> > > > in increased I/O and flash wear, a bitmap can be used to mark these
> > > > pages as zero at write time, and the pages can be filled at
> > > > read time if the bit corresponding to the page is set.
> > > > With this patch, NVMe writes in Meta server fleet decreased
> > > > by almost 10% with conventional swap setup (zswap disabled).
> > > >
> > > > [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258d=
e3d03d1344dde9fce0@epcms5p1/
> > > >
> > > > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > >
> > > This is awesome.
> > >
> > > > ---
> > > >  include/linux/swap.h |  1 +
> > > >  mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++=
++--
> > > >  mm/swapfile.c        | 10 ++++++
> > > >  3 files changed, 95 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > index a11c75e897ec..e88563978441 100644
> > > > --- a/include/linux/swap.h
> > > > +++ b/include/linux/swap.h
> > > > @@ -299,6 +299,7 @@ struct swap_info_struct {
> > > >       signed char     type;           /* strange name for an index =
*/
> > > >       unsigned int    max;            /* extent of the swap_map */
> > > >       unsigned char *swap_map;        /* vmalloc'ed array of usage =
counts */
> > > > +     unsigned long *zeromap;         /* vmalloc'ed bitmap to track=
 zero pages */
> > >
> > > One bit per swap slot, so 1 / (4096 * 8) =3D 0.003% static memory
> > > overhead for configured swap space. That seems reasonable for what
> > > appears to be a fairly universal 10% reduction in swap IO.
> > >
> > > An alternative implementation would be to reserve a bit in
> > > swap_map. This would be no overhead at idle, but would force
> > > continuation counts earlier on heavily shared page tables, and AFAICS
> > > would get complicated in terms of locking, whereas this one is pretty
> > > simple (atomic ops protect the map, swapcache lock protects the bit).
> > >
> > > So I prefer this version. But a few comments below:
> >
> > I am wondering if it's even possible to take this one step further and
> > avoid reclaiming zero-filled pages in the first place. Can we just
> > unmap them and let the first read fault allocate a zero'd page like
> > uninitialized memory, or point them at the zero page and make them
> > read-only, or something? Then we could free them directly without
> > going into the swap code to begin with.
> >
> > That's how I thought about it initially when I attempted to support
> > only zero-filled pages in zswap. It could be a more complex
> > implementation though.
>
> We can aim for this eventually, but yeah the implementation will be
> more complex. We'll need to be careful in handling shared zero pages,
> synchronizing accesses and maintaining reference counts. I think we
> will need to special-case swap cache and swap map for these zero pages
> (a ghost zero swap device perhaps), or reinvent the wheel to manage
> these pieces of information.

Isn't there an existing mechanism to have read-only mappings pointing
at the shared zero page, and do COW? Can't we just use that?

I think this is already what we do for mapped areas that were never
written in some cases (see do_anonymous_page()), so it would be just
like that (i.e. as if the mappings were never written). Someone with
more familiarity with this would know better though.

>
> Not impossible, but annoying :) For now, I think Usama's approach is
> clean enough and does the job.

Yeah, I am not against Usama's approach at all. I just want us to
consider both options before we commit to one. If they are close
enough in complexity, it may be worth avoiding swap completely.

