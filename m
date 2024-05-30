Return-Path: <linux-kernel+bounces-195818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587A8D5232
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DEB1C23ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8EA7F47D;
	Thu, 30 May 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3iCZymH"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89B7EEED
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096706; cv=none; b=uiy6EWuLVH8MA0pPwkxzADBW7CSQsTIaKJ34EgFy5erbnpfUKSnexaKbli6hjjq405FvKzrULhR4QrlN0jsOpaPyECw4KilfsgA23DQAyHA0HlC+ovybLyyd+LUS2vzH36r0PZcjeBBVrNds3nnBO88h2WpCyo2zVQUIz2axN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096706; c=relaxed/simple;
	bh=ViefEXUUZjmS9hRUfAInfSvM4sOcJviF0qfDzjnPK2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUIOZeM2Fi22XEtnbeLZ42vUuOP0cY6O91VEIYBnff4GAVkw3e+LgCyOsqd5SvI53KPTujFcnpL25MKp/4CjZGydsHQtQB0tTMpnKyiiYWsF9ZlpufFkleqKu6oNXTFFGo0WRgdJ9gMhwr5ZW40sVjLtc1p1zw5IrWtPf8az9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3iCZymH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79476195696so81894685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717096704; x=1717701504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65JI8ToZio6BOSyQlC9ku0hs9U2pN1DWvQ/o96iLw7Y=;
        b=l3iCZymHsVERNPJqcmtYnja8wcemAWaQ4jjo5Smji6i5zf9AIPJUftONEhwaOb+8zF
         YxUZWNO00V4kw4/feEOVoqvxZ+tCg7mYPOG47yshN3GzlDWkJXpCWYpl3XsWeXY9np3P
         EqxUrK2W9vCzrAObK+hakTb8TlmpXyi7uzCBNEnSkr88QcWr8iTYHuHdHBt9ZbGfXmtS
         tCikDvfTZ/i9PoTitTwoaj+8if5QelYkivVLYlH3x95IzqHv+Z7hTFpfCmaRXl0Ivg8C
         WJ1S/P0k9NF608lo5Gn5c6jNqFxVpGEaPbQGOBGMfKz/L37iy0rY8HUxB+K+qLIJB96C
         Q+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717096704; x=1717701504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65JI8ToZio6BOSyQlC9ku0hs9U2pN1DWvQ/o96iLw7Y=;
        b=TJ+tWwzMtqJSyqb4li4q+JErKiJ3ew+GCewNA86uR7vTKqJde2nnlhLhPiZelCqMjE
         JmPBf4F6eDmmVSVc/kRtJ7ENN3yEk5c5kly6BI8RxTQFD6cq2OL3PVTer2i/t+24nw3M
         ihbB1qT4fee0tTxi7rY9llYdcErWHBPzhemMPNSu6yP0OS37xWLdmU1uxCUR0I+ixv9o
         x8xgx9OOKrgEmPqLz4SMVYHoT7CWoCl5yipYmd1g3ie7fo7SE6dDOnzc82V/VmWe6kEe
         XmbvuJQbm8u2ua7Ho77kh9Sqk4QyFDRpUZBQkNceFvCmIeHx+IKD9tbqMcPxcGuDAHj2
         KM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX12DAwo4BhBGXOy+0GbUvkxLFV9GiPTnFpyQbig8fG+dVzUEat5fAj4CGKYMqJ2ooE9IHgJsmI/HBqj+5VaqFMvSM/MejUz5tVk77L
X-Gm-Message-State: AOJu0Yz2hrldTOuDErnhUhECfamvpzc0bvzYL+rHBqufMj2/t0bOVY91
	axK3Y/4mV6xUmOxHjoIrkmEhLPsJc54PN8bfQCdUdl3aJrMqKcaTB0XF0oZZL2xtSxSCE+AdX/r
	UxGpB6USu1NFpRBClms+YJIG+Nww=
X-Google-Smtp-Source: AGHT+IEWiwV/N1eKCUtd5lUrfHlt6xQcUtAJI7t+Fy+OVbSQXqv/r8POOph1CO+LGgwz1v/i1F/EE6kWI+qQL8Eeoc0=
X-Received: by 2002:a05:6214:4488:b0:6ab:9142:3b26 with SMTP id
 6a1803df08f44-6ae0cb5a42dmr34267576d6.19.1717096704187; Thu, 30 May 2024
 12:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com> <20240530122715.GB1222079@cmpxchg.org>
 <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com>
In-Reply-To: <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 30 May 2024 12:18:13 -0700
Message-ID: <CAKEwX=NX-4dbietxy-25F-OotuGGL0F9h+hwV76b9Ap5nSy9uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Usama Arif <usamaarif642@gmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:24=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, May 30, 2024 at 5:27=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, May 30, 2024 at 11:19:07AM +0100, Usama Arif wrote:
> > > Approximately 10-20% of pages to be swapped out are zero pages [1].
> > > Rather than reading/writing these pages to flash resulting
> > > in increased I/O and flash wear, a bitmap can be used to mark these
> > > pages as zero at write time, and the pages can be filled at
> > > read time if the bit corresponding to the page is set.
> > > With this patch, NVMe writes in Meta server fleet decreased
> > > by almost 10% with conventional swap setup (zswap disabled).
> > >
> > > [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3=
d03d1344dde9fce0@epcms5p1/
> > >
> > > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >
> > This is awesome.
> >
> > > ---
> > >  include/linux/swap.h |  1 +
> > >  mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++++=
--
> > >  mm/swapfile.c        | 10 ++++++
> > >  3 files changed, 95 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index a11c75e897ec..e88563978441 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -299,6 +299,7 @@ struct swap_info_struct {
> > >       signed char     type;           /* strange name for an index */
> > >       unsigned int    max;            /* extent of the swap_map */
> > >       unsigned char *swap_map;        /* vmalloc'ed array of usage co=
unts */
> > > +     unsigned long *zeromap;         /* vmalloc'ed bitmap to track z=
ero pages */
> >
> > One bit per swap slot, so 1 / (4096 * 8) =3D 0.003% static memory
> > overhead for configured swap space. That seems reasonable for what
> > appears to be a fairly universal 10% reduction in swap IO.
> >
> > An alternative implementation would be to reserve a bit in
> > swap_map. This would be no overhead at idle, but would force
> > continuation counts earlier on heavily shared page tables, and AFAICS
> > would get complicated in terms of locking, whereas this one is pretty
> > simple (atomic ops protect the map, swapcache lock protects the bit).
> >
> > So I prefer this version. But a few comments below:
>
> I am wondering if it's even possible to take this one step further and
> avoid reclaiming zero-filled pages in the first place. Can we just
> unmap them and let the first read fault allocate a zero'd page like
> uninitialized memory, or point them at the zero page and make them
> read-only, or something? Then we could free them directly without
> going into the swap code to begin with.
>
> That's how I thought about it initially when I attempted to support
> only zero-filled pages in zswap. It could be a more complex
> implementation though.

We can aim for this eventually, but yeah the implementation will be
more complex. We'll need to be careful in handling shared zero pages,
synchronizing accesses and maintaining reference counts. I think we
will need to special-case swap cache and swap map for these zero pages
(a ghost zero swap device perhaps), or reinvent the wheel to manage
these pieces of information.

Not impossible, but annoying :) For now, I think Usama's approach is
clean enough and does the job.

