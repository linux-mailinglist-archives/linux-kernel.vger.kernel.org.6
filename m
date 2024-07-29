Return-Path: <linux-kernel+bounces-265829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8C93F68B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01981F22403
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB925148FFF;
	Mon, 29 Jul 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+K5YFp9"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF613C24
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259151; cv=none; b=cg6lEVNCmqJ/mcRcUHp0bT13JwK7btUFni3JkTHRyemxyuixypf8uH+KHDFYEY7IGhoVwYiyQL/7XsYiCtcQjdLKjRqlosO0ltNUvUk2Gt+J2l1haOZQioENFmdlYYX9+TrENLXuY7wri8LpiVJ3HFan2v5btEphYsb/Y8SFsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259151; c=relaxed/simple;
	bh=OMtP3bkPrwxN/J2YRTtIr0trYIMbzIPDcrKLOzq9GdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9w4zmdPHT1iqvnin2V8ehWEmYwEcUaODGukH8SQN8UPWFLCzLqZ0mb3Ik6qXpOQNUIZh28D+8qs5JpIApzr3JJRKay49xBBwDwWDZHhBEQH0rFG1VpjBa0N26WcWbLj1mlSBA/DmaqXg+tpeCUkB+Ijnl3NmNO1BEE/DifMU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+K5YFp9; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-827113c1fb4so767502241.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259149; x=1722863949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FKqt1eAYH+cXItv06HLC2cMI0VWfumC8x6ilbI+Xd4=;
        b=m+K5YFp9QQAMGSq9avsL3iIqCwH3MM4tFRghGzd4l0m5fKHamBp+QJS8UG1rLe7Mq2
         jwSj7hyGLrDxdbezLhW6OgW6IRIHkGfZp+6c/nPxkMKuWtQQc1FWa5rrQo6NAPlR2Uyr
         HFcXlIMEuTsFGN6YabCNwwoIA5X/LjlPJFL/l/aCX/kWR5vujkjut1r2kvgFEDPiHqeq
         48OTOD2ZYvnsESSlczXDUcoyiDfMCkV1FpMIV9GKYXRjHhL+/KR1sc5O+16WRxZ83df7
         Sya6tnj+P+FmWqOeQKlOiV8+6S0VufMh5lriXU9tt2QUQ5107orq5TAmFUeBPaiIjpHa
         CIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259149; x=1722863949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FKqt1eAYH+cXItv06HLC2cMI0VWfumC8x6ilbI+Xd4=;
        b=g01kX1XtRL+mxYxlydNe1Qjtegf/qlCbW/BX+zyNMJS8w+DcUmf1NnAUl/Oxt8t7bd
         ix2EdzztLB8vSo/4AlKNilx5rbElRu2AQjLZ+DfYbuuY0gN6nkGmVginTS5OEySKc2Sq
         xB89plgDJ5dvf+N1vGVMofGqYtffphyL3rLowDZO9isWT6B/iMqKoqvm6UVYUh+arGWG
         aRgkWkSuUo38nqC4OtAD+G/I94wCgGguCS/jYikyBWoOCVUe09TpxdxXyJ9skReAcHJs
         0Kx+6AzBI7YrkWpaOboNlgGRY73iv1cmINUPyE/tcCMIt/anyHVwGjy8RSXmCZhBEQM+
         GRJA==
X-Forwarded-Encrypted: i=1; AJvYcCW+jcRV0qm05gVerbNhkbrFbgwhXvLUF94vQhQhcNj2GcATLhBGbEI+zRaTPQU7Fs7AVjX6bWxkXACgf/XhdgrlUdTE59F1LlwbFZY3
X-Gm-Message-State: AOJu0YzK5AgSYs6hal7PkUUy+N3p22TZ0DGrA16ykdKdOwDgYbfdkeTy
	i3VYTQykzBxBG+dMHQfNWxORytxHI0lco9ob+G4CetmIsQ8zRuOirXN+ZFBvpWUTIZwAhrVwy5x
	U5rpohIFIYcKxAjD88MFIy0Twaek=
X-Google-Smtp-Source: AGHT+IEF18gRGBcRm4C2kzP2XjuH+DByJ08XwKjCthRsd4n2o8QZHHrtx5+4QCyH3NI1V/tSbZZ+RscfNcLpmtBHWv0=
X-Received: by 2002:a05:6122:208d:b0:4f3:2b42:b4ad with SMTP id
 71dfb90a1353d-4f6e69aab77mr8488375e0c.14.1722259149100; Mon, 29 Jul 2024
 06:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org> <CANzGp4J3et+yo8v8iDngvAb3nrn-gSDh0_j0=65OEiw9jKJbPQ@mail.gmail.com>
 <ZqeRO9gedIPcbm3E@casper.infradead.org>
In-Reply-To: <ZqeRO9gedIPcbm3E@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 30 Jul 2024 01:18:58 +1200
Message-ID: <CAGsJ_4zJ519W4GYFo=KF7DUcS+fDhhBCKP7TQz0V-xhR8qiCSw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: Chuanhua Han <chuanhuahan@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	ying.huang@intel.com, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:55=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jul 29, 2024 at 02:36:38PM +0800, Chuanhua Han wrote:
> > Matthew Wilcox <willy@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=B8=80 11:51=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > > > -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABL=
E, 0,
> > > > -                                             vma, vmf->address, fa=
lse);
> > > > +                     folio =3D alloc_swap_folio(vmf);
> > > >                       page =3D &folio->page;
> > >
> > > This is no longer correct.  You need to set 'page' to the precise pag=
e
> > > that is being faulted rather than the first page of the folio.  It wa=
s
> > > fine before because it always allocated a single-page folio, but now =
it
> > > must use folio_page() or folio_file_page() (whichever has the correct
> > > semantics for you).
> > >
> > > Also you need to fix your test suite to notice this bug.  I suggest
> > > doing that first so that you know whether you've got the calculation
> > > correct.
> >
> > >
> > >
> > This is no problem now, we support large folios swapin as a whole, so
> > the head page is used here instead of the page that is being faulted.
> > You can also refer to the current code context, now support large
> > folios swapin as a whole, and previously only support small page
> > swapin is not the same.
>
> You have completely failed to understand the problem.  Let's try it this
> way:
>
> We take a page fault at address 0x123456789000.
> If part of a 16KiB folio, that's page 1 of the folio at 0x123456788000.
> If you now map page 0 of the folio at 0x123456789000, you've
> given the user the wrong page!  That looks like data corruption.
>
> The code in
>         if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> as Barry pointed out will save you -- but what if those conditions fail?
> What if the mmap has been mremap()ed and the folio now crosses a PMD
> boundary?  mk_pte() will now be called on the wrong page.

Chuanhua understood everything correctly. I think you might have missed
that we have very strict checks both before allocating large folios and bef=
ore
mapping them for this new allocated mTHP swap-in case.

to allocate a large folio, we check all alignment requirements;  PTEs have
aligned swap offset and all physically contiguous, that is how mTHP
is swapped out. if a mTHP has been mremap() to be unaligned, we won't
swap them in as mTHP.  two reasons: 1. we have no way to figure out
what is the start address of a previous mTHP for non-swapcache case;
2. mremap() to unaligned addresses is rare.

to map a large folio, we check all PTEs are still there by double confirmin=
g
can_swapin_thp() is true. if PTEs have changed, this is a "goto out_nomap"
case.

        /* allocated large folios for SWP_SYNCHRONOUS_IO */
        if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
                unsigned long nr =3D folio_nr_pages(folio);
                unsigned long folio_start =3D ALIGN_DOWN(vmf->address,
nr * PAGE_SIZE);
                unsigned long idx =3D (vmf->address - folio_start) / PAGE_S=
IZE;
                pte_t *folio_ptep =3D vmf->pte - idx;

                if (!can_swapin_thp(vmf, folio_ptep, nr))
                        goto out_nomap;

                page_idx =3D idx;
                address =3D folio_start;
                ptep =3D folio_ptep;
                goto check_folio;
        }

Thanks
Barry

