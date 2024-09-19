Return-Path: <linux-kernel+bounces-333234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D2497C5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3ED1F2176F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAD1990A1;
	Thu, 19 Sep 2024 08:21:05 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EF198E7E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734065; cv=none; b=arScp9NZKwFVSXdKFH5kcYE5CKItEsdOgoLDMFZmr99F5gaSbVyVlj58/UnuEBjZGUpikTT4Pw8CA+mLWRjR+53U7/4SSe9RtZIhOpbEeKKpT99bQfY+zRc1aU/3CKTkczve+4MwHS+qLb46rCmt4LexGQpCqltkkMbi8rLjZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734065; c=relaxed/simple;
	bh=x7NFQjMJTuJ7KPBaJ/BlLoZEhnwsENOyGWgiAvTAd1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/DnVbpFrYJxb+NFucqVO7QouyVZ+8JcWCDPY7IkIWRheB4TaPNXQoOooxpOTosj6Xy57rEQNrUozN2VtqYZl9jMAfgXeL7hHfvNsfiSWAxo/eteMUMjyhm6ASn7Rp2bpMM2+a0alW199Mos/UdatejpO72IOvcFhHpb2SA3yCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5019d48b1aaso152325e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734062; x=1727338862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCUADm2kQU1BkGTZ1Hi0HjFkl5o/V1S+V/Jkh5Y1Shw=;
        b=UAZBQbu3H5xcpHpc4rUY6nPZcDR5HqXd23QVfVjYPqXD8T9Z6c8aP3LOczrLyNa2Ly
         8/D3y8cYIKNs/yj+VbiR/yQhnexyk5wGYcuWeZEonb1lwQ/QRKsURB7OSdUUB1ZZbbLt
         NST1JDacuBR9jExJ/wnkkCztcHYMzvfo7JLGYkTNzreB9K8iLcgo0nXisVmfJI33kYvW
         v+LH08Ty9sO+YwIeTRC9+6yZ+f1J6rDSC5J1cGh45yMAtJAlgTTbu1+qIvXpTBmN9rV2
         j0v6pNc1vzgd+Sy1GKg5Uq9sposBF76zQLuHvTaiBvU+E1Rrzp/sUjIPBvVEp9XREc0D
         Up3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnH2rHbIESTE/ygM8r5CPwVw5uYuRrEgSC656XXaqtJWB1ymF9fs4PhhzTC/u72fTkM91rQwKAo6Yt/kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTHWvZWDC3n+DQAL8VaZCxmY25kASxcZWB6e+0RY2/JzNAMPc
	9pQJQ1dM09W0GEKtoMH2znIBo80LJwMfJE0OIvhV2DhhisATbw6xejDmKNZdAtkKvnUkmmf2w2N
	8vEy71OIOt6JFORknTarj283sWSw=
X-Google-Smtp-Source: AGHT+IHW3DqaYFPw1emnm6M8nQHlmFNRqPvM4237wW2Jv3qXhBHNV1VCOVQmIToKbRZbnVZVyyA3NMh22oTwXb0AF2w=
X-Received: by 2002:a05:6122:3119:b0:501:1c74:bfc9 with SMTP id
 71dfb90a1353d-5032d73c3femr13927643e0c.12.1726734062336; Thu, 19 Sep 2024
 01:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717071257.4141363-1-ryan.roberts@arm.com> <480f34d0-a943-40da-9c69-2353fe311cf7@arm.com>
In-Reply-To: <480f34d0-a943-40da-9c69-2353fe311cf7@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 19 Sep 2024 20:20:51 +1200
Message-ID: <CAGsJ_4z8kh4Pn-TUrVq6FALR1J5j4fpvQkef2xPFYPWdWfXdxA@mail.gmail.com>
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

On Thu, Aug 8, 2024 at 10:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 17/07/2024 08:12, Ryan Roberts wrote:
> > Hi All,
> >
> > This series is an RFC that adds sysfs and kernel cmdline controls to co=
nfigure
> > the set of allowed large folio sizes that can be used when allocating
> > file-memory for the page cache. As part of the control mechanism, it pr=
ovides
> > for a special-case "preferred folio size for executable mappings" marke=
r.
> >
> > I'm trying to solve 2 separate problems with this series:
> >
> > 1. Reduce pressure in iTLB and improve performance on arm64: This is a =
modified
> > approach for the change at [1]. Instead of hardcoding the preferred exe=
cutable
> > folio size into the arch, user space can now select it. This decouples =
the arch
> > code and also makes the mechanism more generic; it can be bypassed (the=
 default)
> > or any folio size can be set. For my use case, 64K is preferred, but I'=
ve also
> > heard from Willy of a use case where putting all text into 2M PMD-sized=
 folios
> > is preferred. This approach avoids the need for synchonous MADV_COLLAPS=
E (and
> > therefore faulting in all text ahead of time) to achieve that.
>
> Just a polite bump on this; I'd really like to get something like this me=
rged to
> help reduce iTLB pressure. We had a discussion at the THP Cabal meeting a=
 few
> weeks back without solid conclusion. I haven't heard any concrete objecti=
ons
> yet, but also only a luke-warm reception. How can I move this forwards?

Hi Ryan,

These requirements seem to apply to anon, swap, pagecache, and shmem to
some extent. While the swapin_enabled knob was rejected, the shmem_enabled
option is already in place.

I wonder if it's possible to use the existing 'enabled' setting across
all cases, as
from an architectural perspective with cont-pte, pagecache may not differ f=
rom
anon. The demand for reducing page faults, LRU overhead, etc., also seems
quite similar.

I imagine that once Android's file systems support mTHP, we=E2=80=99ll unif=
ormly enable
64KB for anon, swap, shmem, and page cache. It should then be sufficient to
enable all of them using a single knob:
'/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled'.

Is there anything that makes pagecache and shmem significantly different
from anon? In my Android case, they all seem the same. However, I assume
there might be other use cases where differentiating them is necessary?

>
> Thanks,
> Ryan
>
>
> >
> > 2. Reduce memory fragmentation in systems under high memory pressure (e=
.g.
> > Android): The theory goes that if all folios are 64K, then failure to a=
llocate a
> > 64K folio should become unlikely. But if the page cache is allocating l=
ots of
> > different orders, with most allocations having an order below 64K (as i=
s the
> > case today) then ability to allocate 64K folios diminishes. By providin=
g control
> > over the allowed set of folio sizes, we can tune to avoid crucial 64K f=
olio
> > allocation failure. Additionally I've heard (second hand) of the need t=
o disable
> > large folios in the page cache entirely due to latency concerns in some
> > settings. These controls allow all of this without kernel changes.
> >
> > The value of (1) is clear and the performance improvements are document=
ed in
> > patch 2. I don't yet have any data demonstrating the theory for (2) sin=
ce I
> > can't reproduce the setup that Barry had at [2]. But my view is that by=
 adding
> > these controls we will enable the community to explore further, in the =
same way
> > that the anon mTHP controls helped harden the understanding for anonymo=
us
> > memory.
> >
> > ---
> > This series depends on the "mTHP allocation stats for file-backed memor=
y" series
> > at [3], which itself applies on top of yesterday's mm-unstable (650b675=
2c8a3). All
> > mm selftests have been run; no regressions were observed.
> >
> > [1] https://lore.kernel.org/linux-mm/20240215154059.2863126-1-ryan.robe=
rts@arm.com/
> > [2] https://www.youtube.com/watch?v=3Dht7eGWqwmNs&list=3DPLbzoR-pLrL6oj=
1rVTXLnV7cOuetvjKn9q&index=3D4
> > [3] https://lore.kernel.org/linux-mm/20240716135907.4047689-1-ryan.robe=
rts@arm.com/
> >
> > Thanks,
> > Ryan
> >
> > Ryan Roberts (4):
> >   mm: mTHP user controls to configure pagecache large folio sizes
> >   mm: Introduce "always+exec" for mTHP file_enabled control
> >   mm: Override mTHP "enabled" defaults at kernel cmdline
> >   mm: Override mTHP "file_enabled" defaults at kernel cmdline
> >
> >  .../admin-guide/kernel-parameters.txt         |  16 ++
> >  Documentation/admin-guide/mm/transhuge.rst    |  66 +++++++-
> >  include/linux/huge_mm.h                       |  61 ++++---
> >  mm/filemap.c                                  |  26 ++-
> >  mm/huge_memory.c                              | 158 +++++++++++++++++-
> >  mm/readahead.c                                |  43 ++++-
> >  6 files changed, 329 insertions(+), 41 deletions(-)
> >
> > --
> > 2.43.0
> >
>

Thanks
Barry

