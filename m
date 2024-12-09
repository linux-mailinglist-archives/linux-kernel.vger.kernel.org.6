Return-Path: <linux-kernel+bounces-437818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78B9E9927
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AC61888552
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813CA1B0430;
	Mon,  9 Dec 2024 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4235raN"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129111A239E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755148; cv=none; b=un1bNgbmiw6d/ntB7uYPkMsvNuGOQj61icz1xEmDPhcK3iYNxPRcWbIDI9AFjHC8v5liaWdK7BFvOaDItZk2OjLNFAWuF6oZ1FRQjNJ6PfIykHYdmuFkIsmZDCHrpxiKuUwh8U+Dh4eWFyLsktZTve3pqd/kcP6kym9AbMLiw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755148; c=relaxed/simple;
	bh=Y0JL+EnneY+wshsRsH3bqsi5Eooc7q24GY855v97les=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmHOl8eKuOVrK0b7FzLDRtgtu3cXWBMB9Ncs1yhpKOXAKaTWaM5JoqYFJP/nGL0INnhuXTSfy6jvvcw0GhWk7LjH1awrc5ZFj0IuzqCM6wjZThOaV5W4pIdFSEbsv/9dUy8cs1xMkmC0g/KMq3wYq8ww29Z/c5gCulpddkgOUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4235raN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so9257a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733755145; x=1734359945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0HUgDioPZP8r9lR0mhX1U3yWLjjLAk+xygWg9c9gYE=;
        b=E4235raN6mbBPdEPjD2eynwRz563A3wKQPPXR3aCTFudp4zEks7UwvqpAkdJGS8vjJ
         h56urULEzwv1nyAYuUrKa8TWy/pvW0jrxIcE3i2o1B8IzYPHcsS9juUK6kfMZx382L9q
         zqbRc/zeKB/PRE+lSWBW7Qh9yPP758GPnIJsTKx71R1/vvNgkbRVQ9YeRcI3PB9u2h1H
         0QlaHdY7y3j2vezgvdox2Sch/8uswLbNaO4f/OoRQocZPtbeIywyP4z2YNwxC3T1NA8m
         CJfzx5OreGIRUhFTdxUlv0ICf9qF4uQBD2vmqoya8E0bRVDMgZThyOCmYy1klUpEfTjB
         Fi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755145; x=1734359945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0HUgDioPZP8r9lR0mhX1U3yWLjjLAk+xygWg9c9gYE=;
        b=Ea/OmGR3385pPCm5yko+42qSfDVuJ6Lq8qTE+5BwEk3KNGAWrlr/WS9YHuZX4mCQyX
         tYdwJrbUJe8MWKgfUopIlwhcf4iupAB0sLFKOfI3/l5lFNP2/Jsr6Dh37EILpUGX9C0q
         GY4EMRYCRByyJm/uoeRrrmqcvPtePv+TP6hX0N7BvZ/02/8Ry8IPL7KydggTivtFpooa
         vHXxuDuukZz0A8AE751GIuYB7PygE7Avv9U8TcRDFstruhMqqca9J8a32htOwBSKZb+d
         Q8D/TseNQfzWmwq5raiGl3w7jLBk5tyHUOEYWAUQbdS3SDb70EOe/5LNAoGDivp59BGv
         33Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUhcwnMB7GdSaBZGFZWgTv7yzNlDfw33HTdtAYZuJFqy6x0gCd5OjFwEvT7i961i5ZIQ8Yvf7yB5ImwLJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuWUJ2dplwz3yvWiVjk47fDVO3C8MkPTDUdwZ+Dq9f9U5vyHU
	lYR5dE+G4yDs7yOoQeaM+fOJBJr0jSK9vjf+VjnX4luQdbrhfmpBiwADPQPjJDJrquIBDspW/T4
	VmrHuT7BGpm6TV7dkzcQ2nKF1ckIhzJmA3BAu
X-Gm-Gg: ASbGnctNi/XWBXbcmupxA+wxjqphU5oywvhwyg4fnAy6/jTrNfSI0OZ/SmpuEOt/9d2
	xoOBcb1EJRdCs/Q8BcMisV3yxr/dAZXIxgErrmDu/KruO93wen2AkYGLwCNc=
X-Google-Smtp-Source: AGHT+IGttMIbSXRcwbOzyv+s/N1tg8+a5C9j4EQR50flx6las7dboUBXcq3fmF5gfAB4rcz9OaVcYN7/1a+LIhwykhA=
X-Received: by 2002:a50:cd19:0:b0:5d0:b029:e2b4 with SMTP id
 4fb4d7f45d1cf-5d3dd9c511dmr127165a12.3.1733755145049; Mon, 09 Dec 2024
 06:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com> <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com> <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
In-Reply-To: <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Dec 2024 15:38:28 +0100
Message-ID: <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Mon, Dec 09, 2024 at 03:00:08PM +0100, David Hildenbrand wrote:
> > On 09.12.24 14:25, Vlastimil Babka wrote:
> > > On 12/9/24 10:16, David Hildenbrand wrote:
> > > > On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > > > > There are a number of means of interacting with VMA operations wi=
thin mm,
> > > > > and we have on occasion not been made aware of impactful changes =
due to
> > > > > these sitting in different files, most recently in [0].
> > > > >
> > > > > Correct this by bringing all VMA operations under the same sectio=
n in
> > > > > MAINTAINERS. Additionally take the opportunity to combine MEMORY =
MAPPING
> > > > > with VMA as there needn't be two entries as they amount to the sa=
me thing.
> > > > >
> > > > > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZA=
kL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > ---
> > > > >    MAINTAINERS | 19 +++++++------------
> > > > >    1 file changed, 7 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 1e930c7a58b1..95db20c26f5f 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -15060,18 +15060,6 @@ F:     tools/mm/
> > > > >    F:   tools/testing/selftests/mm/
> > > > >    N:   include/linux/page[-_]*
> > > > >
> > > > > -MEMORY MAPPING
> > > > > -M:     Andrew Morton <akpm@linux-foundation.org>
> > > > > -M:     Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > -M:     Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > -R:     Vlastimil Babka <vbabka@suse.cz>
> > > > > -R:     Jann Horn <jannh@google.com>
> > > > > -L:     linux-mm@kvack.org
> > > > > -S:     Maintained
> > > > > -W:     http://www.linux-mm.org
> > > > > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > -F:     mm/mmap.c
> > > > > -
> > > > >    MEMORY TECHNOLOGY DEVICES (MTD)
> > > > >    M:   Miquel Raynal <miquel.raynal@bootlin.com>
> > > > >    M:   Richard Weinberger <richard@nod.at>
> > > > > @@ -25028,6 +25016,13 @@ L:     linux-mm@kvack.org
> > > > >    S:   Maintained
> > > > >    W:   https://www.linux-mm.org
> > > > >    T:   git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > +F:     mm/madvise.c
> > > > > +F:     mm/mlock.c
> > > > > +F:     mm/mmap.c
> > > > > +F:     mm/mprotect.c
> > > > > +F:     mm/mremap.c
> > > > > +F:     mm/mseal.c
> > > > > +F:     mm/msync.c
> > > >
> > > > Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim=
 that
> > > > the real "magic" they perform is in page table handling and not
> > > > primarily VMA handling (yes, both do VMA changes, but they are the
> > > > "easy" part ;) ).
> > >
> > > I'd think that moving vma files into MEMORY MAPPING (and not the othe=
r way)
> > > would result in a better overal name, that would be a better fit for =
the
> > > newly added files too?
> >
> > Maybe. I think vma.c should likely have a different set of maintainers =
than
> > madvise.c and mprotect.c. (again, the magic is in page table modificati=
ons)
>
> The bulk of the logic in mremap.c is related to page tables so by this
> logic then, that is out too, right?

FWIW, I think technically you can have multiple entries in MAINTAINERS
that cover the same file, maybe that would make sense for files that
belong to multiple parts of the kernel? Or maybe I'm making things too
complicated and it'd be simpler to have some kind of more generic
"core MM for userspace mappings" entry or such.

