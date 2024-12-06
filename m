Return-Path: <linux-kernel+bounces-434423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E999E669B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D453A168E12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E4B194A5A;
	Fri,  6 Dec 2024 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKAlgiOD"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84517991
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733461797; cv=none; b=MACeP+XjEBy+YdgzHpJ6YOh02VjdHc54w1HETchwGKBnFttusxUzItwzYc2cG54RchdhIu3cfx5nOqbTIirrcES6e46TDqfVtFJ0wP17Nn0T031eyRcoS6FPvDg4F1TcJKt2BHFVIQh41pa0my4rIyuOfBealVJ4oZEKGDUvdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733461797; c=relaxed/simple;
	bh=ZTvg3MAnXF3FnQmppIr63+0w4AjFyXv+5q4Mt7ix0Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMhZFV5qaq/PjJIVszoqDtbulSvUzN6uScruVhaQs8lq0HRyzfDkhlay/4spz3oghMZssH9yX77yKAmyU3rgn9+7sDIfXusJMgEGLEHTwnKGGsZqvF6Yp5nXJAcASS/e0CnAeAmQe2Tmcu8WnszOO7tWFdgKSG6Wv/GgAQKxWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKAlgiOD; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85b804c0157so349138241.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733461794; x=1734066594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8xIv+n+nDGR2NlbcHUc54eH2vCVwy0Vf5TmzPNyKhM=;
        b=LKAlgiODcQsK852getJOr7PJAuSh/UWvxQulxPQwby5l6m22NtaXRHrUiZ5nKJG8kf
         OVVpwdNqdfu/o+se34QdR954bMNCAGTCPwgFpP+yBmERz79u1l2rGXrsZsK+N6SZ4VVE
         RsrZAsvEq+59N3WXFImLrNaKsCV1/wl08bn6C37DRia+SfZ2ViY/tx7cFVz25dHijivt
         PcKe+vx1T/nA68ibdzxBGwdMFpmJUMoi+mH12NUF9S34pS/L4a8/jdE6Yp9iAUb+e2ZJ
         zRccmp8ZJDKJ0YUmOlxQZjxcujjBj+MKc7QGkV51JIMmWp2f0o/OtbOl0QxuAjGgt2dU
         25Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733461794; x=1734066594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8xIv+n+nDGR2NlbcHUc54eH2vCVwy0Vf5TmzPNyKhM=;
        b=Z2KXS5TJMLVCszRMs8IXP6KOm4Lc1Ga2AoEVsaX8oph9A3wP1pWryOBVabV7k2b4wG
         JY8RUkhSKcQubu5F3XLibKHoXjIHvr7AKU2Vo0LVtX+Eh29omrbtJ0XSZ++pgcy4W+2E
         yhey99zGuzI48AgZX0LDsFvUEDp6gvQqPyw7X6IKGC8kgmLaWK74tOIXph/xu9ShcteU
         JLCk3JKETpch4eXc274yBV6ybk//Vu35OK1ta1t8tHNmD9YAw21Vb+sHaQyIbP+PEwVV
         WctTnr8eSrrH5rTfBkOzG3gEuXfcIYInN/yVdQqi9x40OZZNGLGdL9s0CcbOfI0gvXpR
         RPoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSckkIhbPfxe6SC5NiwVhiPNg/o3VyqL0zj2ccDf6tfPfp+a4Sckl4rp2TEJm+qpTrGu/7yVhOCcG6CT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Z38SAhrCEyobDHiKgAMXmCgwF2+5Z+XroV686fTbLyUs9qcx
	e/1C0G6IcfP2TksdkSzM5GJesQYd2jGgXFa11ZGcy/iZJwUiRGonYDsVi+81RE2pyh4zN8sP9yp
	GVhoZSyti4G35mfBq2DGQokfL+cc=
X-Gm-Gg: ASbGnctgTIA3t4KwNyLd2lZyD4S4+uPa8IqTbCLRcXu2hlJ/mKfBDr5Uz2t7ethq3F1
	fw8dxXUwWfu2EW5NvZIrYNSBGcORI3tiXhUbWe0QVDDeWUm9k8zZTGYeVGiitYAXVdA==
X-Google-Smtp-Source: AGHT+IEdXmm3BCnqc5bm40aVNvGcUI1BO0166flqOho2p5LFZEnRt8SQR4Ca8ljT6jPmy5mghkIGggGXvt0ueKBmS+Q=
X-Received: by 2002:a05:6102:3a13:b0:4af:a967:65c5 with SMTP id
 ada2fe7eead31-4afcaa28a8cmr2507868137.10.1733461794020; Thu, 05 Dec 2024
 21:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <480f34d0-a943-40da-9c69-2353fe311cf7@arm.com> <CAGsJ_4z8kh4Pn-TUrVq6FALR1J5j4fpvQkef2xPFYPWdWfXdxA@mail.gmail.com>
In-Reply-To: <CAGsJ_4z8kh4Pn-TUrVq6FALR1J5j4fpvQkef2xPFYPWdWfXdxA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 6 Dec 2024 18:09:43 +1300
Message-ID: <CAGsJ_4y=5xvZsWWiZoGh6eqhh+NXCsztyeLVbraUrxR=ruhWzw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache memory
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>, 
	Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's unusual that many emails sent days ago are resurfacing on LKML.
Please ignore them.
By the way, does anyone know what happened?

On Fri, Dec 6, 2024 at 5:12=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
>
> On Thu, Aug 8, 2024 at 10:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > On 17/07/2024 08:12, Ryan Roberts wrote:
> > > Hi All,
> > >
> > > This series is an RFC that adds sysfs and kernel cmdline controls to =
configure
> > > the set of allowed large folio sizes that can be used when allocating
> > > file-memory for the page cache. As part of the control mechanism, it =
provides
> > > for a special-case "preferred folio size for executable mappings" mar=
ker.
> > >
> > > I'm trying to solve 2 separate problems with this series:
> > >
> > > 1. Reduce pressure in iTLB and improve performance on arm64: This is =
a modified
> > > approach for the change at [1]. Instead of hardcoding the preferred e=
xecutable
> > > folio size into the arch, user space can now select it. This decouple=
s the arch
> > > code and also makes the mechanism more generic; it can be bypassed (t=
he default)
> > > or any folio size can be set. For my use case, 64K is preferred, but =
I've also
> > > heard from Willy of a use case where putting all text into 2M PMD-siz=
ed folios
> > > is preferred. This approach avoids the need for synchonous MADV_COLLA=
PSE (and
> > > therefore faulting in all text ahead of time) to achieve that.
> >
> > Just a polite bump on this; I'd really like to get something like this =
merged to
> > help reduce iTLB pressure. We had a discussion at the THP Cabal meeting=
 a few
> > weeks back without solid conclusion. I haven't heard any concrete objec=
tions
> > yet, but also only a luke-warm reception. How can I move this forwards?
>
> Hi Ryan,
>
> These requirements seem to apply to anon, swap, pagecache, and shmem to
> some extent. While the swapin_enabled knob was rejected, the shmem_enable=
d
> option is already in place.
>
> I wonder if it's possible to use the existing 'enabled' setting across
> all cases, as
> from an architectural perspective with cont-pte, pagecache may not differ=
 from
> anon. The demand for reducing page faults, LRU overhead, etc., also seems
> quite similar.
>
> I imagine that once Android's file systems support mTHP, we=E2=80=99ll un=
iformly enable
> 64KB for anon, swap, shmem, and page cache. It should then be sufficient =
to
> enable all of them using a single knob:
> '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled'.
>
> Is there anything that makes pagecache and shmem significantly different
> from anon? In my Android case, they all seem the same. However, I assume
> there might be other use cases where differentiating them is necessary?
>
> >
> > Thanks,
> > Ryan
> >
> >
> > >
> > > 2. Reduce memory fragmentation in systems under high memory pressure =
(e.g.
> > > Android): The theory goes that if all folios are 64K, then failure to=
 allocate a
> > > 64K folio should become unlikely. But if the page cache is allocating=
 lots of
> > > different orders, with most allocations having an order below 64K (as=
 is the
> > > case today) then ability to allocate 64K folios diminishes. By provid=
ing control
> > > over the allowed set of folio sizes, we can tune to avoid crucial 64K=
 folio
> > > allocation failure. Additionally I've heard (second hand) of the need=
 to disable
> > > large folios in the page cache entirely due to latency concerns in so=
me
> > > settings. These controls allow all of this without kernel changes.
> > >
> > > The value of (1) is clear and the performance improvements are docume=
nted in
> > > patch 2. I don't yet have any data demonstrating the theory for (2) s=
ince I
> > > can't reproduce the setup that Barry had at [2]. But my view is that =
by adding
> > > these controls we will enable the community to explore further, in th=
e same way
> > > that the anon mTHP controls helped harden the understanding for anony=
mous
> > > memory.
> > >
> > > ---
> > > This series depends on the "mTHP allocation stats for file-backed mem=
ory" series
> > > at [3], which itself applies on top of yesterday's mm-unstable (650b6=
752c8a3). All
> > > mm selftests have been run; no regressions were observed.
> > >
> > > [1] https://lore.kernel.org/linux-mm/20240215154059.2863126-1-ryan.ro=
berts@arm.com/
> > > [2] https://www.youtube.com/watch?v=3Dht7eGWqwmNs&list=3DPLbzoR-pLrL6=
oj1rVTXLnV7cOuetvjKn9q&index=3D4
> > > [3] https://lore.kernel.org/linux-mm/20240716135907.4047689-1-ryan.ro=
berts@arm.com/
> > >
> > > Thanks,
> > > Ryan
> > >
> > > Ryan Roberts (4):
> > >   mm: mTHP user controls to configure pagecache large folio sizes
> > >   mm: Introduce "always+exec" for mTHP file_enabled control
> > >   mm: Override mTHP "enabled" defaults at kernel cmdline
> > >   mm: Override mTHP "file_enabled" defaults at kernel cmdline
> > >
> > >  .../admin-guide/kernel-parameters.txt         |  16 ++
> > >  Documentation/admin-guide/mm/transhuge.rst    |  66 +++++++-
> > >  include/linux/huge_mm.h                       |  61 ++++---
> > >  mm/filemap.c                                  |  26 ++-
> > >  mm/huge_memory.c                              | 158 ++++++++++++++++=
+-
> > >  mm/readahead.c                                |  43 ++++-
> > >  6 files changed, 329 insertions(+), 41 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
>
> Thanks
> Barry
>

