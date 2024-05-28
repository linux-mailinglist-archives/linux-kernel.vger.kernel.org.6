Return-Path: <linux-kernel+bounces-192922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3068D245B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4903C1C26DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB6177991;
	Tue, 28 May 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfmEAzNT"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3F171E59
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923336; cv=none; b=LIy55N+rXPAK9UyyC+RpCJZ5ByiMoWcZKAwGxJJ8EYuPYZ5GkwAmwJdDXfvF3j892ZNPVjU6knn5EpaBAsvinqRrDp5uUJtBqa0S6TjgdtplL7PG2j5VOQlAbRVszgYW63iY+GJnXy0ht9snSJCJbX4VA7mTtegJ9JPuHkI+54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923336; c=relaxed/simple;
	bh=ENRdU3dF1CTdvP18KYGIHUeVi2xSE7kVsJl1begsEnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhcQ36J3/+k9PnKh6RUYK3XkPAn2sbWQ4VcTrICx9epKB56QM1vercb50Q4B+Rt/N9TZD3aV8C2QpXtFPIr07Xg0b3qTid/Z4xKmDAxZk3TL53KDBRBZXGhxEJlZyw4qQgZ8zkFolggHx+mTVXP2qIo2UShJ9rtPWzc2Kopsg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfmEAzNT; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-804cb027cc6so354588241.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716923334; x=1717528134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2puTWOFR02t9GANatBeEi0mPqoxXCcVIPKBqGJyHdVU=;
        b=VfmEAzNTrB++s4FdbsTXKl3eGZ3U/1pqHzHoW9JIp9eWzyacPI+5lOtt1d/M5TWfgM
         hQH2Gqka1Xupoqf05WjDM+1F6QDAAUvkdGVk6iPLr5Nst05uis1MbMjKvVo8haQKmIbw
         CgWz/6nVBh5iyoQscvTYl1iF5gJ2Z3A1nvd+T7qhRJfSjwElBrBuSBdAwtKnegjn/txI
         dSNhsl9oPLeKW+pst4QghOX0ldTp+kMlg67wp/XWsbEBJtZj761Ss1Zuyp0LKhEhzAWN
         CDPeittih6TfomC9da5qPzbkOCRm1/CLxM8FulBLwPunE7TW4Hew7TonLpzvN8ruDTZ1
         yBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923334; x=1717528134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2puTWOFR02t9GANatBeEi0mPqoxXCcVIPKBqGJyHdVU=;
        b=FoXuS6056fcSYvlFjsRWQUPOJtG/EmmO7oGh+GxJRcW3trI3Pft4yFPydbukXuHE8p
         3JGPfFWRrrXE4wzzqr7ju2PYlRN1RJfSDg30kNgM876nSaRuxl1Y8gVc/z184os3rWSJ
         tCgj9h3+r5OTFQQK+GVq52alC8z4Ctrap85CX+YMf2F5w0J59pIvCEsui4hRWdmWDfIC
         4RcKOSqKMSN4Du7AvCWCNyut0m3NEgfcP3GMd14Ic26fY9N+XR3RObS8GjUnkZQwga9r
         ErKzvJA2NHlQP1K7mv/+N82YwwvtOLKzdpfKqB1K+KsmHMOuiEVwfRknCSDeSiHsB1xy
         gDmA==
X-Forwarded-Encrypted: i=1; AJvYcCXc/Ek4BfVM1mki9GEc5tUU307nSxS3ntX1QKACAq1k+6F7gIX0Zqa5NVUr0A99TshLgv5bY0i/WMMjAWmzM78vgBiOg92Hs7mapjNY
X-Gm-Message-State: AOJu0YyXIyhjAp8d8jE2NSRi7WRLirrtTX5jYEBSMhAHaJfApwGszvU1
	zeFBHIQq0leREjZphr+EzQooSJ3JUi4a3B/oZIpE6P4PZjywz9Tslk3u3cN94uEwB3SRS1cl+mX
	o+QvAYIaBZxyE5BHGNkgha+6vW1Lm95RY
X-Google-Smtp-Source: AGHT+IFXwhrLaG4z51INBmphQW4cBoyTz028xIBeiZ5b0lQTKmcxCKOCR6N1+uG2fG0S3j+O8u/xckZgpN8fyNff+zI=
X-Received: by 2002:a05:6122:c91:b0:4e4:e9db:6b10 with SMTP id
 71dfb90a1353d-4e4f021c79fmr12673028e0c.2.1716923333865; Tue, 28 May 2024
 12:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com>
 <ZlAQo0P4Z-dgVHn6@casper.infradead.org> <CAJD7tkaVFa24Yty=8J01OKkaFB-TDiKq1tj0GuOD2_TbU+13SQ@mail.gmail.com>
 <CAJD7tkaQQAje_jGLwnPp3xAaYcvXiXQBLHC19h=xbZwgSeVrQA@mail.gmail.com>
In-Reply-To: <CAJD7tkaQQAje_jGLwnPp3xAaYcvXiXQBLHC19h=xbZwgSeVrQA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 12:08:42 -0700
Message-ID: <CAKEwX=NFsLA67p1+Eev9SdeTpM8yycM44N21gFzYjjEZuMyhvA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 4:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, May 24, 2024 at 12:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Thu, May 23, 2024 at 8:59=E2=80=AFPM Matthew Wilcox <willy@infradead=
org> wrote:
> > >
> > > On Fri, May 24, 2024 at 03:38:15AM +0000, Yosry Ahmed wrote:
> > > > Some trivial folio conversions in zswap code.
> > >
> > > The three patches themselves look good.
> > >
> > > > The mean reason I included a cover letter is that I wanted to get
> > > > feedback on what other trivial conversions can/should be done in
> > > > mm/zswap.c (keeping in mind that only order-0 folios are supported
> > > > anyway).  These are the things I came across while searching for 'p=
age'
> > > > in mm/zswap.c, and chose not to do anything about for now:
> > >
> > > I think there's a deeper question to answer before answering these
> > > questions, which is what we intend to do with large folios and zswap =
in
> > > the future.  Do we intend to split them?  Compress them as a large
> > > folio?  Compress each page in a large folio separately?  I can see an
> > > argument for choices 2 and 3, but I think choice 1 is going to be
> > > increasingly untenable.
> >
> > Yeah I was kinda getting the small things out of the way so that zswap
> > is fully folio-ized, before we think about large folios. I haven't
> > given it a lot of thought, but here's what I have in mind.
> >
> > Right now, I think most configs enable zswap will disable
> > CONFIG_THP_SWAP (otherwise all THPs will go straight to disk), so
> > let's assume that today we are splitting large folios before they go
> > to zswap (i.e. choice 1).
> >
> > What we do next depends on how the core swap intends to deal with
> > large folios. My understanding based on recent developments is that we
> > intend to swapout large folios as a whole, but I saw some discussions
> > about splitting all large folios before swapping them out, or leaving
> > them whole but swapping them out in order-0 chunks.
> >
> > I assume the rationale is that there is little benefit to keeping the
> > folios whole because they will most likely be freed soon anyway, but I
> > understand not wanting to spend time on splitting them, so swapping
> > them out in order-0 chunks makes some sense to me. It also dodges the
> > whole fragmentation issue.
> >
> > If we do either of these things in the core swap code, then I think
> > zswap doesn't need to do anything to support large folios. If not,
> > then we need to make a choice between 2 (compress large folios) &
> > choice 3 (compress each page separately) as you mentioned.
> >
> > Compressing large folios as a whole means that we need to decompress
> > them as a whole to read a single page, which I think could be very
> > inefficient in some cases or force us to swapin large folios. Unless
> > of course we end up in a world where we mostly swapin the same large
> > folios that we swapped out. Although there can be additional
> > compression savings from compressing large folios as a whole.
> >
> > Hence, I think choice 3 is the most reasonable one, at least for the
> > short-term. I also think this is what zram does, but I haven't
> > checked. Even if we all agree on this, there are still questions that
> > we need to answer. For example, do we allocate zswap_entry's for each
> > order-0 chunk right away, or do we allocate a single zswap_entry for
> > the entire folio, and then "split" it during swapin if we only need to
> > read part of the folio?
> >
> > Wondering what others think here.
>
> More thoughts that came to mind here:
>
> - Whether we go with choice 2 or 3, we may face a latency issue. Zswap
> compression happens synchronously in the context of reclaim, so if we
> start handling large folios in zswap, it may be more efficient to do
> it asynchronously like swap to disk.

We've been discussing this in private as well :)

It doesn't have to be these two extremes right? I'm perfectly happy
with starting with compressing each subpage separately, but perhaps we
can consider managing larger folios in bigger chunks (say 64KB). That
way, on swap-in, we just have to bring a whole chunk in, not the
entire folio, and still take advantage of compression efficiencies on
bigger-than-one-page chunks. I'd also check with other filesystems
that leverage compression, to see what's their unit of compression is.

I believe this is the approach Barry is suggesting for zram:

https://lore.kernel.org/linux-block/20240327214816.31191-2-21cnbao@gmail.co=
m/T/

Once the zsmalloc infrastructure is there, we can play with this :)

Barry - what's the progress regarding this front?

>
> - Supporting compression of large folios depends on zsmalloc (and
> maybe other allocators) supporting it. There have been patches from
> Barry to add this support to some extent, but I didn't take a close
> look at those.
>
> Adding other folks from the mTHP swap discussions here in case they
> have other thoughts about zswap.

