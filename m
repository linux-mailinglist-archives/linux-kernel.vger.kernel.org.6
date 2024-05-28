Return-Path: <linux-kernel+bounces-192945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247B8D24AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA64B27B52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE38171E65;
	Tue, 28 May 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MGWla9ao"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC744C7B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924821; cv=none; b=raTnn8LFSmy8If5raucH8mwjwI3IU9TcePSJ8ccvxfYA5/0hLlA5OqbJuxrwEeO5Aq8wpc8mZfkCvaMAWRVc9t8EPKw6xTzOYOLvmnsrcg1MmNqvNOQ5fNpfP0gXlHyLj2ctVoNrFag6k7G51eB6h1Uc7KNdaxE3ySvijtUwXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924821; c=relaxed/simple;
	bh=W8PEkkieHP3/VvZGgsrKQ/xgR336+SDrtNFwe30V/yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEtj9vmiJytkil9g+m+3AcyB7WFr2KXn8LO6aC126ImNgkJ1DeZEM72T3SV0AYosT1+Ywtwk3B/2acP0nlglcdSSxjcW+7lpBkPleJhWu1jWbdE0LCbTg6pnGdipBBqNHJBOtdPjJARPy0OLbepo4DmwE9B0EAlsiC8gQf5XG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGWla9ao; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a62ef52e837so142744666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716924818; x=1717529618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nndAkULklMmF966l0By5SKV5vIz2VJ0sZL6bYUx2uU=;
        b=MGWla9ao4kjTTBUa7PPnQ8P8Nekggci+SvjvjAO1nR3Y5tVx7UgR318cyJQiRzOoPT
         QsCCitKpI3lJDkEoSblTdKNmB6Ugi1ObANj4YiVsLKxdUS57M0H0vhQ70KIZHr0ynSHz
         myvGqbz4h/15nWkwIpae96w7Mrw870wJ4m0qaMrUSoh/1WEVGp7I98LuKkVtlrDGXCg+
         EP4WDTWRT57lTQvrADyxptW1GoewMJK9DdVQ5dh7TiqmKgpW0r1xxTgsGLkUzUEB2pma
         eY8AdFzEZ2cxshzk8eMM3//QQrAvXPMoCiHV98qTqkU887yqIsp/nIXlzLkgc7LKRPcK
         Y15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716924818; x=1717529618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nndAkULklMmF966l0By5SKV5vIz2VJ0sZL6bYUx2uU=;
        b=edfx/ifOslgYYuViF/Lb2zg85IGp7tIYWVun3X/hzoutDoqfGvstXVK4vd3g9HLR1i
         Ak0ICVJbWOe2LNoMMbHleKdPNOAbHNpwpCSNpkADVYdpkzuCtYdiJih7DmkwxBv/eXac
         KLfccMtIHKnxzCElUV4C/um4w83C68jTdU1hSWaZMc5lQaSyMo39BTHvmFgP4DuuMYxD
         SiBVcuv8EXQV7srSq4e/oGp8oTwpj5h8gd/npHVesvOYEY7LW3jPlzc+2ri0Y0wIoEbV
         ECWbdXed021HtiGje/3+hyoSXy7GmW0W3nfYmqEkSNznGNic0vg0iIdxFaUJtwXaCsXZ
         KYZA==
X-Forwarded-Encrypted: i=1; AJvYcCXXmut6Q1cY2z8khMy3kNcCFsx8r7p2w3UVjSyFbGdAnDT4Qne/QLKuJfbXkpp7e+86AiQNS8n+6gRzBkxmXXPo2qsm6YHY54X68jJI
X-Gm-Message-State: AOJu0YyL8BSY2T843q8r9hKXutz6VCi3QInQQ2m3z4l1YAOp4Pg03Lr7
	Qo0JRh5H9ywebGE/TF5LT3GLrUIhVHYB/COuRIhEgEfBZnluGsZZkDZlq8nHhB4TCkpwguKbP9c
	PfQacGoViVpiMDwqsFx6GB0HhPmi4ZpiXJpv0
X-Google-Smtp-Source: AGHT+IHqGLGt3dTQAFd9KY3oTJ8YDtoM1LCiiQflMR8BF9JDKdt+ZQhmDfZocB+SZeE4pJ/FzvAVoF4Z2VdeB/HPW6o=
X-Received: by 2002:a17:906:a14f:b0:a62:2cef:95e6 with SMTP id
 a640c23a62f3a-a626408547emr949969366b.14.1716924817521; Tue, 28 May 2024
 12:33:37 -0700 (PDT)
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
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 28 May 2024 12:32:59 -0700
Message-ID: <CAJD7tkYz1-nsoDrjLfNoYaKp5R5QShpzPirKWrY-PSqRtXswtg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: zswap: trivial folio conversions
To: Nhat Pham <nphamcs@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:08=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Fri, May 24, 2024 at 4:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, May 24, 2024 at 12:53=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
com> wrote:
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

Right. But I think it will be a clearer win to start with compressing
each subpage separately, and it avoids splitting folios during reclaim
to zswap. It also doesn't depend on the zsmalloc work.

Once we have that, we can experiment with compressing folios in larger
chunks. The tradeoffs become less clear at that point, and the number
of variables you can tune goes up :)

