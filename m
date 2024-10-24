Return-Path: <linux-kernel+bounces-379170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F959ADAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EC3B215CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5B16DEA2;
	Thu, 24 Oct 2024 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZinnkY1Z"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF62158862
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744579; cv=none; b=rSrjpRLwjJ8LABJT2hHxErlvO6PYoHTrdWhJnK1IhV8nzP/meG4MrrVMZ+UQ3aaueIXLm5dmoR+9Hy6Fj6S2HDlammfIrFaKU+44Lt8cL+p/DU41PdePtOsz+yARE7ns0HjUrdYevYEdCWemQEmcTNgZ6WW/k30FTMlBQA/c3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744579; c=relaxed/simple;
	bh=avlCzmmB8PfQC7kDQ8NwPIoKMZQSR11VMQQBsE2zggA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+0zi638cl1CrVGxverHn0H9WJAEDTTcC6QycB90+8ti9hgOh6ZE6h4CBsY8NJuqj5/Ys2XNGHGYalUgAWL+IGJgdxV22K2FE3NihiOCI2dx1UfJC5FXt8jF7/NT7NgF6ERbTu4WqNaHiVRXsWjIOAzhnBPq6BM1K1aAIYYWNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZinnkY1Z; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a46a25545aso152363137.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729744576; x=1730349376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ewr3HuDmhbonYbWbM1qZPgVLnVPcDLg9+uev5FKUIE=;
        b=ZinnkY1Z27gUCTkdQwfYMZLMKFes9EqaZ2u26btEKaWpLP4e0wneEz7buoAyew0lo2
         iPjl2fjHJ29qiEOV7PnzjqwrghL5t9Xes/O5QLIEs348Q20UON56UBPN9kPc2+bb3hHz
         VVukpKFrUVEryIXncEQ2gsnOMowjiPMIex275GVhhIgCePmADk/40FSzWJLxr5YnpTaR
         v0RKLpsgyIkSoFeCbxpqEqDerm+isTNkl9qdsPzvRpA1hdJVN5YCWT5YirQ6ikUFN3y7
         lZEtfpuMaTsMcsg6dCVvx4EjNuURvlCV6TOqaU+CVLgD25mx5D5ZnDHyuHrTik3epGCq
         2FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729744576; x=1730349376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ewr3HuDmhbonYbWbM1qZPgVLnVPcDLg9+uev5FKUIE=;
        b=gknRAsizol0cKkwJVeXTGR/w+8ZAWBtUtEJbcvqLlhb5BvHZZism0URvd6fFj0+g2D
         b2HinLVbaashC8wJfX6nPBMGcPpR95Ch81UDeWHHIklmc3M9c5H66naeFN2eaF8i21To
         BSLGKideSI3dR4E9af5Xn8QkYhhro8qAOHS7s3vppcj3qDtTEu/jCMUMZBYe0dXr2uxY
         MfiYMS2DXOuQoJRU65oK93E4Sv56lytZJRwwQaOhiB1nhaS6AE8JaA1/drJlcABa/O5i
         tT9D4+/o4JZprXAy/acafM3w2TXIVjT78TfPAyM3MqxU97hAtfGPyvwHJOMJISY+89gy
         iFjw==
X-Forwarded-Encrypted: i=1; AJvYcCV03HndwMWRs67A50MneCw0m+hNIwbnaFIY0O6uKqamw9UvqVMeVlOasuvVqJQysJJkumckMAEUiWBDKUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4yE67wT3hpab2+/DvUBWnqNul4Q7ZDV2og7T8guV4iUDnuc2
	aXeETUkjBYjOdUBqmkKu0jtITnNstPxQfRIvYPcmfr9YUrQMcfUcEvVEypNIOaD9N7KIvRhi+0I
	wY4bE7ApLRXBe67+AfZiDWmFXYanjVRri52Ym
X-Google-Smtp-Source: AGHT+IEjwwD9qCiVlq+xTEfIc8kjrodOvAiOtDnf1Fg8xPI7qGul6zZvdCWU9IWh0lEu0GpcEj+Oz/AdHQCTd7rDjIE=
X-Received: by 2002:a05:6102:4411:b0:4a3:cce7:8177 with SMTP id
 ada2fe7eead31-4a751c07bddmr6211099137.16.1729744575768; Wed, 23 Oct 2024
 21:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020051315.356103-1-yuzhao@google.com> <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka> <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
 <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com> <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz>
In-Reply-To: <97ccf48e-f30c-4abd-b8ff-2b5310a8b60f@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 23 Oct 2024 22:35:38 -0600
Message-ID: <CAOUHufb=Ze1pj2BeasCLYpAvOhBQfKXcz678Zo_==9DeMbgT9Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Rientjes <rientjes@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Link Lin <linkl@google.com>, Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/23/24 08:36, Yu Zhao wrote:
> > On Tue, Oct 22, 2024 at 4:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> +Cc Mel and Matt
> >>
> >> On 10/21/24 19:25, Michal Hocko wrote:
> >> > On Mon 21-10-24 11:10:50, Yu Zhao wrote:
> >> >> On Mon, Oct 21, 2024 at 2:13=E2=80=AFAM Michal Hocko <mhocko@suse.c=
om> wrote:
> >> >> >
> >> >> > On Sat 19-10-24 23:13:15, Yu Zhao wrote:
> >> >> > > OOM kills due to vastly overestimated free highatomic reserves =
were
> >> >> > > observed:
> >> >> > >
> >> >> > >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVA=
BLE), order=3D0 ...
> >> >> > >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:73940=
4kB high:1068392kB reserved_highatomic:1073152KB ...
> >> >> > >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*3=
2kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024k=
B (M) 0*2048kB 0*4096kB =3D 1477408kB
> >> >> > >
> >> >> > > The second line above shows that the OOM kill was due to the fo=
llowing
> >> >> > > condition:
> >> >> > >
> >> >> > >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784=
KB < min (410416kB)
> >> >> > >
> >> >> > > And the third line shows there were no free pages in any
> >> >> > > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as=
 type
> >> >> > > 'H'. Therefore __zone_watermark_unusable_free() overestimated f=
ree
> >> >> > > highatomic reserves. IOW, it underestimated the usable free mem=
ory by
> >> >> > > over 1GB, which resulted in the unnecessary OOM kill.
> >> >> >
> >> >> > Why doesn't unreserve_highatomic_pageblock deal with this situati=
on?
> >> >>
> >> >> The current behavior of unreserve_highatomic_pageblock() seems WAI =
to
> >> >> me: it unreserves highatomic pageblocks that contain *free* pages s=
o
> >>
> >> Hm I don't think it's completely WAI. The intention is that we should =
be
> >> able to unreserve the highatomic pageblocks before going OOM, and ther=
e
> >> seems to be an unintended corner case that if the pageblocks are fully
> >> exhausted, they are not reachable for unreserving.
> >
> > I still think unreserving should only apply to highatomic PBs that
> > contain free pages. Otherwise, it seems to me that it'd be
> > self-defecting because:
> > 1. Unreserving fully used hightatomic PBs can't fulfill the alloc
> > demand immediately.
>
> I thought the alloc demand is only blocked on the pessimistic watermark
> calculation. Usable free pages exist, but the allocation is not allowed t=
o
> use them.

I think we are talking about two different problems here:
1. The estimation problem.
2. The unreserving policy problem.

What you said here is correct w.r.t. the first problem, and I was
talking about the second problem.

> > 2. More importantly, it only takes one alloc failure in
> > __alloc_pages_direct_reclaim() to reset nr_reserved_highatomic to 2MB,
> > from as high as 1% of a zone (in this case 1GB). IOW, it makes more
> > sense to me that highatomic only unreserves what it doesn't fully use
> > each time unreserve_highatomic_pageblock() is called, not everything
> > it got (except the last PB).
>
> But if the highatomic pageblocks are already full, we are not really
> removing any actual highatomic reserves just by changing the migratetype =
and
> decreasing nr_reserved_highatomic?

If we change the MT, they can be fragmented a lot faster, i.e., from
the next near OOM condition to upon becoming free. Trying to persist
over time is what actually makes those PBs more fragmentation
resistant.

> In fact that would allow the reserves
> grow with some actual free pages in the future.

Good point. I think I can explain it better along this line.

If highatomic is under the limit, both your proposal and the current
implementation would try to grow, making not much difference. However,
the current implementation can also reuse previously full PBs when
they become available. So there is a clear winner here: the current
implementation.

If highatomic has reached the limit, with your proposal, the growth
can only happen after unreserve, and unreserve only happens under
memory pressure. This means it's likely that it tries to grow under
memory pressure, which is more difficult than the condition where
there is plenty of memory. For the current implementation, it doesn't
try to grow, rather, it keeps what it already has, betting those full
PBs becoming available for reuse. So I don't see a clear winner
between trying to grow under memory pressure and betting on becoming
available for reuse.

> > Also not reachable from free_area[] isn't really a big problem. There
> > are ways to solve this without scanning the PB bitmap.
>
> Sure, if we agree it's the way to go.
>
> >> The nr_highatomic is then
> >> also fully misleading as it prevents allocations due to a limit that d=
oes
> >> not reflect reality.
> >
> > Right, and the comments warn about this.
>
> Yes and explains it's to avoid the cost of searching free lists. Your fix
> introduces that cost and that's not really great for a watermark check fa=
st
> path. I'd rather move the cost to highatomic unreserve which is not a fas=
t path.
>
> >> Your patch addresses the second issue, but there's a
> >> cost to it when calculating the watermarks, and it would be better to
> >> address the root issue instead.
> >
> > Theoretically, yes. And I don't think it's actually measurable
> > considering the paths (alloc/reclaim) we are in -- all the data
> > structures this patch accesses should already have been cache-hot, due
> > to unreserve_highatomic_pageblock(), etc.
>
> __zone_watermark_unusable_free() will be executed from every allocation's
> fast path, and not only after we recently did
> unreserve_highatomic_pageblock(). AFAICS as soon as nr_reserved_highatomi=
c
> is over pageblock_nr_pages we'll unconditionally start counting precisely
> and the design wanted to avoid this.
>
> > Also, we have not agreed on the root cause yet.
> >
> >> >> that those pages can become usable to others. There is nothing to
> >> >> unreserve when they have no free pages.
> >>
> >> Yeah there are no actual free pages to unreserve, but unreserving woul=
d fix
> >> the nr_highatomic overestimate and thus allow allocations to proceed.
> >
> > Yes, but honestly, I think this is going to cause regression in
> > highatomic allocs.
>
> I think not as having more realistic counter of what's actually reserved
> (and not already used up) can also allow reserving new pageblocks.
>
> >> > I do not follow. How can you have reserved highatomic pages of that =
size
> >> > without having page blocks with free memory. In other words is this =
an
> >> > accounting problem or reserves problem? This is not really clear fro=
m
> >> > your description.
> >>
> >> I think it's the problem of finding the highatomic pageblocks for
> >> unreserving them once they become full. The proper fix is not exactly
> >> trivial though. Either we'll have to scan for highatomic pageblocks in=
 the
> >> pageblock bitmap, or track them using an additional data structure.
> >
> > Assuming we want to unreserve fully used hightatomic PBs, we wouldn't
> > need to scan for them or track them. We'd only need to track the delta
> > between how many we want to unreserve (full or not) and how many we
> > are able to do so. The first page freed in a PB that's highatomic
> > would need to try to reduce the delta by changing the MT.
>
> Hm that assumes we're adding some checks in free fastpath, and for that t=
o
> work also that there will be a freed page in highatomic PC in near enough
> future from the decision we need to unreserve something. Which is not so
> much different from the current assumption we'll find such a free page
> already in the free list immediately.
>
> > To summarize, I think this is an estimation problem, which I would
> > categorize as a lesser problem than accounting problems. But it sounds
> > to me that you think it's a policy problem, i.e., the highatomic
> > unreserving policy is wrong or not properly implemented?
>
> Yeah I'd say not properly implemented, but that sounds like a mechanism, =
not
> policy problem to me :)

What about adding a new counter to keep track of the size of free
pages reserved for highatomic?

Mel?

