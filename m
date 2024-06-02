Return-Path: <linux-kernel+bounces-198067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B58D7300
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8F1F21859
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5561C06;
	Sun,  2 Jun 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwZBQsx8"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73384370
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291837; cv=none; b=MrS4RFdcdbc22SOW237j0naNojc/cHcAxA7JXGlapUHp+tr9rC8Ycdqyb0mRCqLS8FFJe3TJhNrZ4XJ0gpRsFV2arqEijdMJ0lII/tRNvd+ZqSnINgZeJTjh3qkRfJrMnbKqpf2HUt4T+Qucl8BxKayyh1WyxzJ+V6XMVmnw+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291837; c=relaxed/simple;
	bh=BgPXaw0EnRP5OfqmUujXxB96G+bdensT29YHjvxGOTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaXi+kU7rUxFa4YhOcwGFimBchO49o4AV8FfSWhiw/GQcF0QluzB3QC4HbfRNWCfo0xMr4cPDatm4vUOKlY6qOmu62p+Zynk/zNzq3K97Lu+fot4TbwJ6KC3ZIJW3ntNRcW7FNRjUV2ASw2r5Km7v4RcMWudwOEkzGCyT9mVuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwZBQsx8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a0c011d53so33345467b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717291834; x=1717896634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ1gCPwC65c3cMl7vP99XEeMRRhkHaJFqWTOSEyeuz8=;
        b=kwZBQsx8vk7VHcixWqCGL845UI5MMc7aOqdeyQnLurVoI4KcVDSj4C4ktHcSDW3tEM
         hGbPa518VUgSa6mAd2fzEBsvu5rygIM+MPaiBE3ZGtzA5qxRzgKTIS4yqYuJ9ddv5tRd
         3aQ5YPoBCPROlD1d44wS1BQPhPnXhqVSHuPg7oUxg2WElEHKbRRYO9FSXbe4Td3FEzNx
         vDX8hcILAVLJskAUPC2fO8Ivg5CY2xxMD7+cvlcIRPWhm/ZguiOQxbSPHTaXyZgCaC8r
         X6UX8pcc7mcaAMJfxaRKeZ76PuMjnS7OrUfoujR56zK0x2wGtPGbehamlAGBVP16NnTN
         EvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717291834; x=1717896634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ1gCPwC65c3cMl7vP99XEeMRRhkHaJFqWTOSEyeuz8=;
        b=d7f1Zv3St/aAzryGIehVCbe3Uw8ei4gkXZfUM4vBsRjmhE7oDFxamQK2r/TpvuGJ2v
         UFwbVHUzq3fUrNEtnd5f9ITRyI08D4dB0vOUg6mvtC1gGHUCasQ3l1eAXDbNToIvI3S2
         NLvRu7m4DcgLlhzKOQdNsqzREruj8W1LQhGW2mgGpaNiCUmVI4N86sJnXjXHXrigOqzV
         s2CFb3/ALx1g7J1bhjud2j7azWk7+byRyoTkW+HdYukx4V5TNyM/AK5wmbPTZCE0TGgh
         tK8FuE9dh1/Xcu3AXoqqTVW8Cbi3dfz02GI4jHAaZVDKaxdbNHtue7srzgf0g4Dq39oS
         8uoA==
X-Forwarded-Encrypted: i=1; AJvYcCVhfMRYEKqwUgxHlrwcDaxIb4e3JmT3EharIB4SVLz+EUrAFb4pbT8p8HzAcbLTD/3+2zTU9lTy4lbcZSjjaEdE4oueF/UNKrpwwVLL
X-Gm-Message-State: AOJu0YwzBxu6L9uNL7/rjnO1Dg86VCIcKL2cRBD6VqYIaXySYbgBcw6Y
	HavBPSIjEv0z+jRVBIVAu3IbcjbeLHFEhPK245vJf62xKpXt4x5sgjeDn/Jb519daBklP1h8VGw
	W/b+IXCLA5x0SagD/j+KAhKV9oMM=
X-Google-Smtp-Source: AGHT+IHKxiyZFijWNkk5tIO42eVIbE6xzWLhiJux2pBF/L01KS63eVliz62tniOqmGg1DMpFtl3lKQPoBxo9g2pjfqk=
X-Received: by 2002:a0d:c987:0:b0:622:f785:5499 with SMTP id
 00721157ae682-62c7acd2385mr58593317b3.37.1717291832826; Sat, 01 Jun 2024
 18:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <ZlAQo0P4Z-dgVHn6@casper.infradead.org> <CAJD7tkaVFa24Yty=8J01OKkaFB-TDiKq1tj0GuOD2_TbU+13SQ@mail.gmail.com>
 <CAJD7tkaQQAje_jGLwnPp3xAaYcvXiXQBLHC19h=xbZwgSeVrQA@mail.gmail.com> <CAKEwX=NFsLA67p1+Eev9SdeTpM8yycM44N21gFzYjjEZuMyhvA@mail.gmail.com>
In-Reply-To: <CAKEwX=NFsLA67p1+Eev9SdeTpM8yycM44N21gFzYjjEZuMyhvA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 2 Jun 2024 13:30:21 +1200
Message-ID: <CAGsJ_4x4LdA-vo5gLd9CS4gTDPMW=PV7oKitKU294D3zwg890Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 7:08=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Fri, May 24, 2024 at 4:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, May 24, 2024 at 12:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > On Thu, May 23, 2024 at 8:59=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Fri, May 24, 2024 at 03:38:15AM +0000, Yosry Ahmed wrote:
> > > > > Some trivial folio conversions in zswap code.
> > > >
> > > > The three patches themselves look good.
> > > >
> > > > > The mean reason I included a cover letter is that I wanted to get
> > > > > feedback on what other trivial conversions can/should be done in
> > > > > mm/zswap.c (keeping in mind that only order-0 folios are supporte=
d
> > > > > anyway).  These are the things I came across while searching for =
'page'
> > > > > in mm/zswap.c, and chose not to do anything about for now:
> > > >
> > > > I think there's a deeper question to answer before answering these
> > > > questions, which is what we intend to do with large folios and zswa=
p in
> > > > the future.  Do we intend to split them?  Compress them as a large
> > > > folio?  Compress each page in a large folio separately?  I can see =
an
> > > > argument for choices 2 and 3, but I think choice 1 is going to be
> > > > increasingly untenable.
> > >
> > > Yeah I was kinda getting the small things out of the way so that zswa=
p
> > > is fully folio-ized, before we think about large folios. I haven't
> > > given it a lot of thought, but here's what I have in mind.
> > >
> > > Right now, I think most configs enable zswap will disable
> > > CONFIG_THP_SWAP (otherwise all THPs will go straight to disk), so
> > > let's assume that today we are splitting large folios before they go
> > > to zswap (i.e. choice 1).
> > >
> > > What we do next depends on how the core swap intends to deal with
> > > large folios. My understanding based on recent developments is that w=
e
> > > intend to swapout large folios as a whole, but I saw some discussions
> > > about splitting all large folios before swapping them out, or leaving
> > > them whole but swapping them out in order-0 chunks.
> > >
> > > I assume the rationale is that there is little benefit to keeping the
> > > folios whole because they will most likely be freed soon anyway, but =
I
> > > understand not wanting to spend time on splitting them, so swapping
> > > them out in order-0 chunks makes some sense to me. It also dodges the
> > > whole fragmentation issue.
> > >
> > > If we do either of these things in the core swap code, then I think
> > > zswap doesn't need to do anything to support large folios. If not,
> > > then we need to make a choice between 2 (compress large folios) &
> > > choice 3 (compress each page separately) as you mentioned.
> > >
> > > Compressing large folios as a whole means that we need to decompress
> > > them as a whole to read a single page, which I think could be very
> > > inefficient in some cases or force us to swapin large folios. Unless
> > > of course we end up in a world where we mostly swapin the same large
> > > folios that we swapped out. Although there can be additional
> > > compression savings from compressing large folios as a whole.
> > >
> > > Hence, I think choice 3 is the most reasonable one, at least for the
> > > short-term. I also think this is what zram does, but I haven't
> > > checked. Even if we all agree on this, there are still questions that
> > > we need to answer. For example, do we allocate zswap_entry's for each
> > > order-0 chunk right away, or do we allocate a single zswap_entry for
> > > the entire folio, and then "split" it during swapin if we only need t=
o
> > > read part of the folio?
> > >
> > > Wondering what others think here.
> >
> > More thoughts that came to mind here:
> >
> > - Whether we go with choice 2 or 3, we may face a latency issue. Zswap
> > compression happens synchronously in the context of reclaim, so if we
> > start handling large folios in zswap, it may be more efficient to do
> > it asynchronously like swap to disk.
>
> We've been discussing this in private as well :)
>
> It doesn't have to be these two extremes right? I'm perfectly happy
> with starting with compressing each subpage separately, but perhaps we
> can consider managing larger folios in bigger chunks (say 64KB). That
> way, on swap-in, we just have to bring a whole chunk in, not the
> entire folio, and still take advantage of compression efficiencies on
> bigger-than-one-page chunks. I'd also check with other filesystems
> that leverage compression, to see what's their unit of compression is.
>
> I believe this is the approach Barry is suggesting for zram:
>
> https://lore.kernel.org/linux-block/20240327214816.31191-2-21cnbao@gmail.=
com/T/
>
> Once the zsmalloc infrastructure is there, we can play with this :)
>
> Barry - what's the progress regarding this front?

Thanks for reaching out.

Not too much. It depends on large folios swap-in because we need to swap in
large folios if we compress them as a whole. For example, if we swap out
64KiB but only swap in 4KiB, we still need to decompress the entire 64KiB
but copy only 4KiB.

Recently, we=E2=80=99ve only addressed the large folio swap-in refault case=
s in
the mm-unstable branch[1].
[1] https://lore.kernel.org/linux-mm/20240529082824.150954-1-21cnbao@gmail.=
com/

Currently, swap-in is not allocating large folios in any mm branch.

A major debate is that my original patch[2] started from SYNC_IO case for z=
RAM
and embedded devices first, while Ying argue we should start from non-SYNC
IO and decide swapin sizes based on read-ahead window but not based on
the original sizes of how folios are swapped out.
[2] https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.=
com/

So I guess we need more work to get large folios swap-in ready, and it
won't happen
shortly.

>
> >
> > - Supporting compression of large folios depends on zsmalloc (and
> > maybe other allocators) supporting it. There have been patches from
> > Barry to add this support to some extent, but I didn't take a close
> > look at those.
> >
> > Adding other folks from the mTHP swap discussions here in case they
> > have other thoughts about zswap.

Thanks
Barry

