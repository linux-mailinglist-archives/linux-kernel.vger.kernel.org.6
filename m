Return-Path: <linux-kernel+bounces-377442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E29ABEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31ED1C23181
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D6A14A09C;
	Wed, 23 Oct 2024 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSSC4W6A"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42213BC11
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665447; cv=none; b=pVP1HazWrl3QM6fdtcM+CmvVhaiYqXYgOCekrFeHMlvAnflbiee2gft0p4L+OuXAZLvRsihAufgtBMXIifO1LxSsQR2Gcv1dzyj8vh8oOqmezb4J28Owz+LKyLiywI/5JtVlXASGVm5j2HeEvwcPn/255NNFO6+WFJMOcpDwP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665447; c=relaxed/simple;
	bh=hK6aO6xWFWAX1AmLrmaGviN7d8UU64ABCZAto+OG8LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE2Ls84PByqM/JSNKSFloCi9Qyd/cP3355OR5xrP6q+JLs7AXaGhFgZo+CQsnGNnkyY2FOxrVnPsgO3aEUYg3zILiYayB02hK/05EsuAAGxFweQJ2c/Dya4fjuRiSAK+AP3nzF+zNJBVXkxzs+/OUqVBLe6Fn1PYmWrYjxFKD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSSC4W6A; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a46b6affeaso2100564137.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729665444; x=1730270244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RwGWVZWgUL28jOJ2ZorbzjGVGR4NAagIvpYUFNtjGU=;
        b=aSSC4W6AtZEk8qnuj7Z4LvpooWYoDMfYBuYBjGcJPn4jerh98l5JnIAwngUnyY0L75
         uAWFnSq5m+eZ512qugdL/KIwtTaqWxFG2uhirNn6uwRfw4TfcJzSCtM+Y3+sPPo9GMi2
         YWWXPUX95RTazfQg7JxbSbfPEOpXIzmNCostMXoZmpYYQcFFXpT3upXmJGSj7yCEKaGd
         x6tjUEijw6vt5ntz+R4lPx8s+cB53Y0UH4/lrWdHp4+2ShsYu0IaLDNGUwnE4QUCAusY
         oJrcvK5D/92y0HiCkzSR7UMaYDe2/p7Gk0p1DOYodPkv/2K/w5lnr1RFCWpo7wBwOrrG
         DGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729665444; x=1730270244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RwGWVZWgUL28jOJ2ZorbzjGVGR4NAagIvpYUFNtjGU=;
        b=nCyi72Sj5Y6gpC8tgoYvpSGNHVmeoRq3T3Fo3wyEo3FzredAYDc/GelypZVmWam0Iz
         mM4RsZXwGvSpxXDClIs5R8fGWKp9VCyR20lUbiwdNOMacpaABVWbUmMglMQdPPnFnpz5
         VJVe6EdZbLPAvlrLKoNuaBjW5LGnseQUIatib8snzUZMz2krNxL1xSolvLIPlfVpdhRE
         jqR8Rwm7irhLK9NHd5xFg3WSoEKaKL5o2Rln93uQJtEMGco3BUGo1RLo9+BOohHM66O5
         iOEIMIbG063BR4T8fwinOhi8+Llbi0ExJI6ePThw845JXB6AWLLWLiSamLKmA+7PLO1g
         yDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSC7VXAgU+YhvNVpZkeMyrBw8Jo9tn3I0ke+IJKehI9ejKoAhVAoLPdePMB4+icktBya3yVxH1A1gE0RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJqkgs9pRtaqtQ3DB14EpcIogqulr3hNhzb5lM2fAU/Wk3zgc
	ryJIjnYjKq6IJQ+UIsUsUfwk8ZKjufjaQ+MiWfAfg0VlsTouLxxIrbVF1h2G6hDwWAIkOusiSBV
	N+UJ61unixxWGkl9hPoaMZ9oPpoQwANFDQkrD
X-Google-Smtp-Source: AGHT+IH/ZsPlxgBddWsHfy39It0obvWBL67n4AK9/EC/iSAclsEp52smPUSwcD1dGZTcT4IWFQe34vwo7pjm/KxvH9g=
X-Received: by 2002:a05:6102:5113:b0:4a4:6a8a:d2dd with SMTP id
 ada2fe7eead31-4a751c94356mr1642162137.21.1729665444011; Tue, 22 Oct 2024
 23:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020051315.356103-1-yuzhao@google.com> <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
 <ZxaOo59ZwXoCduhG@tiehlicka> <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
In-Reply-To: <82e6d623-bbf3-4dd8-af32-fdfc120fc759@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 23 Oct 2024 00:36:46 -0600
Message-ID: <CAOUHufanF3VaLzq6o_V+-+iPvB4Oj-xHwD+Rm-gmKS02h8Dw=g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Rientjes <rientjes@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Link Lin <linkl@google.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 4:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> +Cc Mel and Matt
>
> On 10/21/24 19:25, Michal Hocko wrote:
> > On Mon 21-10-24 11:10:50, Yu Zhao wrote:
> >> On Mon, Oct 21, 2024 at 2:13=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> >> >
> >> > On Sat 19-10-24 23:13:15, Yu Zhao wrote:
> >> > > OOM kills due to vastly overestimated free highatomic reserves wer=
e
> >> > > observed:
> >> > >
> >> > >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE=
), order=3D0 ...
> >> > >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB=
 high:1068392kB reserved_highatomic:1073152KB ...
> >> > >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB=
 (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (=
M) 0*2048kB 0*4096kB =3D 1477408kB
> >> > >
> >> > > The second line above shows that the OOM kill was due to the follo=
wing
> >> > > condition:
> >> > >
> >> > >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784KB =
< min (410416kB)
> >> > >
> >> > > And the third line shows there were no free pages in any
> >> > > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as ty=
pe
> >> > > 'H'. Therefore __zone_watermark_unusable_free() overestimated free
> >> > > highatomic reserves. IOW, it underestimated the usable free memory=
 by
> >> > > over 1GB, which resulted in the unnecessary OOM kill.
> >> >
> >> > Why doesn't unreserve_highatomic_pageblock deal with this situation?
> >>
> >> The current behavior of unreserve_highatomic_pageblock() seems WAI to
> >> me: it unreserves highatomic pageblocks that contain *free* pages so
>
> Hm I don't think it's completely WAI. The intention is that we should be
> able to unreserve the highatomic pageblocks before going OOM, and there
> seems to be an unintended corner case that if the pageblocks are fully
> exhausted, they are not reachable for unreserving.

I still think unreserving should only apply to highatomic PBs that
contain free pages. Otherwise, it seems to me that it'd be
self-defecting because:
1. Unreserving fully used hightatomic PBs can't fulfill the alloc
demand immediately.
2. More importantly, it only takes one alloc failure in
__alloc_pages_direct_reclaim() to reset nr_reserved_highatomic to 2MB,
from as high as 1% of a zone (in this case 1GB). IOW, it makes more
sense to me that highatomic only unreserves what it doesn't fully use
each time unreserve_highatomic_pageblock() is called, not everything
it got (except the last PB).

Also not reachable from free_area[] isn't really a big problem. There
are ways to solve this without scanning the PB bitmap.

> The nr_highatomic is then
> also fully misleading as it prevents allocations due to a limit that does
> not reflect reality.

Right, and the comments warn about this.

> Your patch addresses the second issue, but there's a
> cost to it when calculating the watermarks, and it would be better to
> address the root issue instead.

Theoretically, yes. And I don't think it's actually measurable
considering the paths (alloc/reclaim) we are in -- all the data
structures this patch accesses should already have been cache-hot, due
to unreserve_highatomic_pageblock(), etc.

Also, we have not agreed on the root cause yet.

> >> that those pages can become usable to others. There is nothing to
> >> unreserve when they have no free pages.
>
> Yeah there are no actual free pages to unreserve, but unreserving would f=
ix
> the nr_highatomic overestimate and thus allow allocations to proceed.

Yes, but honestly, I think this is going to cause regression in
highatomic allocs.

> > I do not follow. How can you have reserved highatomic pages of that siz=
e
> > without having page blocks with free memory. In other words is this an
> > accounting problem or reserves problem? This is not really clear from
> > your description.
>
> I think it's the problem of finding the highatomic pageblocks for
> unreserving them once they become full. The proper fix is not exactly
> trivial though. Either we'll have to scan for highatomic pageblocks in th=
e
> pageblock bitmap, or track them using an additional data structure.

Assuming we want to unreserve fully used hightatomic PBs, we wouldn't
need to scan for them or track them. We'd only need to track the delta
between how many we want to unreserve (full or not) and how many we
are able to do so. The first page freed in a PB that's highatomic
would need to try to reduce the delta by changing the MT.

To summarize, I think this is an estimation problem, which I would
categorize as a lesser problem than accounting problems. But it sounds
to me that you think it's a policy problem, i.e., the highatomic
unreserving policy is wrong or not properly implemented?

