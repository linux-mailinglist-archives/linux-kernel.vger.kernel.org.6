Return-Path: <linux-kernel+bounces-315895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD896C84D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23BB2824C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068A1482E3;
	Wed,  4 Sep 2024 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWoiDhuO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D41EBFEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481338; cv=none; b=SxKWLLtrOZN2oEVZ35LtoG+srE8jP3ny5nnc0pD6YKqni3kYj9MRwlFSulMEOtiq2cs5aNmt6xd+WQrG0y2rH6c40MTW2B8fjYD6yOLFmgNthIei7yEjuCtBsRqzmCHCSVCyXICjQHT8UA3hhky91KWOFfF6FtviY8stwVSxJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481338; c=relaxed/simple;
	bh=CI0Ye0Ykt18W8ybMIFOw0VfNEQu4OrVqrLoLvNBnXzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPIZCX1Gyz2V7Sm7wkfto9TakZ37BmN3vdnrFFQawk6zm0dg3ZvjmZ5N8vOFKI7lw/g1X1AvkAeRrxnzppyA+kUQGzVtOg4x0nfGr5rL24kpUyn3UwAIfO+rOl48yBRfzEcg8OITS0hKbOpcurF7RysPFwHbX3DhTx+j6s8KpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWoiDhuO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so9916466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725481335; x=1726086135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KYWai7lvMoDFEhU+xx5+nV1ssYUW6kimYz3gbj4Z0c=;
        b=dWoiDhuOaeMsKTwBFz1sy6tjmyzbctXdp5US2Rn/+hWvxCC53TQ4Eme+I/8+3BPGmt
         DulYs+XFbRWKYAQZ+zF7ki4fGirt190RlZwNdWvD8TjAKS6GB5pJxWKhH0Jlkm8KytP8
         gidbmSpX5nFb0ITgSSQ4Y00HUsjrousB+d/m9vkmd3NdSq4iGHVbsLAXzmDTrRmMiwaC
         040Dj912bWiqOUKiScFr80oyls3NhGE4Tbcv2CK5Itdh6mGYvqg8GIPmeqAe692FjNq4
         fyVbX2U6WzqgFYN1tRuO7MGW3Iber+eDm/2Ks5bgN0qoI/te8c1kObUxnOICIif1EEht
         OsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481335; x=1726086135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KYWai7lvMoDFEhU+xx5+nV1ssYUW6kimYz3gbj4Z0c=;
        b=uJb1+AGHTHrgSDehoYkyIrB/D4n8TjlSpgNcexKem2vUwRCGjC3Gl0aWggiYc9nful
         TZ2spDLYgBqvDa/nnr2tudjKATbn9SoCNOJRl24XlnoQ+UuUlMmWL2djdAIA9b+2CtYY
         VpwHD7R/SZyYsGg3+xwGSMeFWFQaul2MV2YPl52IdcnVhjlicSvWCWTHWokE2kypmGS9
         FVvZb/uRMGDNbwbqrkTAgq1vFDfUQIWadHEIFnXuffxfKuB4F6dyhHmxNGwNqxAL+TWR
         LyYSx/QIP8v6Gaje4alUiiM3dxzsO3bSiXXuHdWSgxzDAzoc7PszzNabcxff65t496I6
         0Mig==
X-Forwarded-Encrypted: i=1; AJvYcCWCmi2WOUdzGRxEw//vnnkE8lDGB9b0658+G6nLaZl4BW8SeiNfVuciVtlZaXMAvdOPrLQCi1fYJxYEcbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCg5NX1K/TKOmM4C1qsDAs7nHaZs7zAp/vZD9bA6OIp0ocpdd
	cgSotlRxJ1aYsQ8PYOlLf+lqduQCGsYrcp6+H/gvA/midq/H5GsaVU2XPPk1SK8JNmslQlw8KAT
	lxqWWUErEjxKi6Vp8XnfeAM8is3gd0f69rOme
X-Google-Smtp-Source: AGHT+IH2wXEm2ptjpL0NyJhUhgpSVjK/53CRuIdDgwa1w3tyzQo0CK7tIUyh2/pxABvFX0hfTbK0aaVC8u1kY8gJFg4=
X-Received: by 2002:a17:906:f590:b0:a7a:adac:57d5 with SMTP id
 a640c23a62f3a-a8a32e6dd9emr465468066b.18.1725481334134; Wed, 04 Sep 2024
 13:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022143.3924396-1-alexs@kernel.org> <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com> <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <20240814060354.GC8686@google.com> <66ce5eed.170a0220.387c4d.276d@mx.google.com>
 <9a6e3169-2ebd-47a5-b2e6-953a8a6730db@gmail.com> <66d8ba53.170a0220.844a7.1d81@mx.google.com>
In-Reply-To: <66d8ba53.170a0220.844a7.1d81@mx.google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 13:21:36 -0700
Message-ID: <CAJD7tkb113u0GWffvMJTJcWS+CqmvEAwwja+2nBivkS_s61tiA@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Alex Shi <seakeel@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, 
	david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com, 
	Dan Streetman <ddstreet@ieee.org>, Seth Jennings <sjenning@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 12:51=E2=80=AFPM Vishal Moola <vishal.moola@gmail.co=
m> wrote:
>
> On Thu, Aug 29, 2024 at 05:42:06PM +0800, Alex Shi wrote:
> >
> >
> > On 8/28/24 7:19 AM, Vishal Moola wrote:
> > > On Wed, Aug 14, 2024 at 03:03:54PM +0900, Sergey Senozhatsky wrote:
> > >> On (24/08/08 04:37), Matthew Wilcox wrote:
> > >> [..]
> > >>>> So I guess if we have something
> > >>>>
> > >>>> struct zspage {
> > >>>>  ..
> > >>>>  struct zpdesc *first_desc;
> > >>>>  ..
> > >>>> }
> > >>>>
> > >>>> and we "chain" zpdesc-s to form a zspage, and make each of them po=
int to
> > >>>> a corresponding struct page (memdesc -> *page), then it'll resembl=
e current
> > >>>> zsmalloc and should work for everyone? I also assume for zspdesc-s=
 zsmalloc
> > >>>> will need to maintain a dedicated kmem_cache?
> > >>>
> > >>> Right, we could do that.  Each memdesc has to be a multiple of 16 b=
ytes,
> > >>> sp we'd be doing something like allocating 32 bytes for each page.
> > >>> Is there really 32 bytes of information that we want to store for
> > >>> each page?  Or could we store all of the information in (a somewhat
> > >>> larger) zspage?  Assuming we allocate 3 pages per zspage, if we all=
ocate
> > >>> an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.
> > >>
> > >> I certainly like (and appreciate) the approach that saves us
> > >> some bytes here and there.  zsmalloc page can consist of 1 to
> > >> up to CONFIG_ZSMALLOC_CHAIN_SIZE (max 16) physical pages.  I'm
> > >> trying to understand (in pseudo-C code) what does a "somewhat larger
> > >> zspage" mean.  A fixed size array (given that we know the max number
> > >> of physical pages) per-zspage?
> > >
> > > I haven't had the opportunity to respond until now as I was on vacati=
on.
> > >
> > > With the current approach in a memdesc world, we would do the followi=
ng:
> > >
> > > 1) kmem_cache_alloc() every single Zpdesc
> > > 2) Allocate a memdesc/page that points to its own Zpdesc
> > > 3) Access/Track Zpdescs directly
> > > 4) Use those Zpdescs to build a Zspage
> > >
> > > An alternative approach would move more metadata storage from a Zpdes=
c
> > > into a Zspage instead. That extreme would leave us with:
> > >
> > > 1) kmem_cache_alloc() once for a Zspage
> > > 2) Allocate a memdesc/page that points to the Zspage
> > > 3) Use the Zspage to access/track its own subpages (through some magi=
c
> > > we would have to figure out)
> > > 4) Zpdescs are just Zspages (since all the information would be in a =
Zspage)
> > >
> > > IMO, we should introduce zpdescs first, then start to shift
> > > metadata from "struct zpdesc" into "struct zspage" until we no longer
> > > need "struct zpdesc". My big concern is whether or not this patchset =
works
> > > towards those goals. Will it make consolidating the metadata easier? =
And are
> > > these goals feasible (while maintaining the wins of zsmalloc)? Or sho=
uld we
> > > aim to leave zsmalloc as it is currently implemented?
> >
> > Uh, correct me if I am wrong.
> >
> > IMHO, regarding what this patchset does, it abstracts the memory descri=
ptor usage
> > for zswap/zram.
>
> Sorry, I misunderstood the patchset. I thought it was creating a
> descriptor specifically for zsmalloc, when it seems like this is supposed=
 to
> be a generic descriptor for all zpool allocators. The code comments and c=
ommit
> subjects are misleading and should be changed to reflect that.
>
> I'm onboard for using zpdesc for zbud and z3fold as well (or we'd have to=
 come
> up with some other plan for them as well). Once we have a plan all the
> maintainers agree on we can all be on our merry way :)
>
> The questions for all the zpool allocator maintainers are:
> 1) Does your allocator need the space its using in struct page (aka
> would it need a descriptor in a memdesc world)?
>
> 2) Is it feasible to store the information elsewhere (outside of struct
> page)? And how much effort would that code conversion be?
>
> Thoughts? Seth/Dan, Vitaly/Miahoe, and Sergey?

I would advise against spending effort on z3fold and zbud tbh, we want
to deprecate them.

