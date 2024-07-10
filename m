Return-Path: <linux-kernel+bounces-248045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1392D7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CA8283795
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC3195F00;
	Wed, 10 Jul 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePPf6o3a"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F41957E8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633399; cv=none; b=uUgumn3n/zjPXCW8QZrPOJPgnC8UbyJURCwIIbvETDM706i+nGUSJ8kK/N9v64PY+lfizq0hHv1gNJGhfY9aoBeRDg6Yc5JPLeoud6aBEp7dWDRckCtSD5yVoogqdRUl+6FeZxTLM422ZTC+QXbpjY73VpP4DqufBr8GeszxMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633399; c=relaxed/simple;
	bh=3pwkwLaawkCR2MJQLU8x68OfE8XYYqgeRHh2U1y2WpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqMdlgjleFtqp9zqq0TBCVG3+XhKpN/pTA3aDg4xJn1cPs3xtwPdJIyivhsCnnzgj7I/bMOnevyAm6K/ixvMG8C/JQHQRF/yM6NAWRIVVtwE0WnM1G7ji0tyi4GVfVc1FsobNA/P/7sXMjBmEpKEwv2dh4E+OLoT75YgDAWSlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePPf6o3a; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65465878c1fso10237b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720633396; x=1721238196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gncxGrknoXQ/IKLNR0UwrMsMKJahmerSOv55AR1WPEY=;
        b=ePPf6o3aeZPw2eFOmn59LcDSLFYlUyOIU1oTi9veMjvGfGOCJ3/+rus3U74zAWAhyF
         2JRY6EnEhro9TQQ0mZhShUD7VTrF/+ZO+n3R8DyY7W/GGTmklMw0CpWCintaHJ5iGv8Z
         ITwoc50wvcamc/so/pwS/+l195G3+RcDd5j9B9l4cTc634v2cmqCgr/qIkkPHuSBfliv
         vYJ6HRJ5iBlKubXKCzELq8oU9dKxf6ibtN6tb+16b7F4M8UaODf9v7QuhIfnAD/3WCLb
         xQs6DPI17wjtAr/Y7DH+c6yA3oKN2sExCqIxsidTVHTA5v3Uv6T4Evj3nCiQ0b0ixuuI
         D9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633396; x=1721238196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gncxGrknoXQ/IKLNR0UwrMsMKJahmerSOv55AR1WPEY=;
        b=WW2IqfvqujUq5qrClSOcqK/OrXko9gV/EJ7qJX5/AyEiiUqyp0B/6IjZQZwrtddS46
         bQh4CD5H+sH4wJoGzN9neTpoZfLN6TRzK9zTqKNKHtC3MJyts9vsy5iRX9jLn3A7ZpR5
         mhS0t5rykPREFwcKFwwTpQD7XeoVMbh+hJ2a2jYn80WtYMg7qprKKl3rmxru/P6M1gP2
         TIABk+7p4i4Hd/4GSO4vPrL1QhH12LPdN5oXTkXE6vUZdD81SEBF35hlu4cH0jwMZpza
         X/L0nb4hrZWGsVVnhF7Mx1aG35laR5MWRTc5qoUqlrj5fz+J57XhDEt5LYyfX3v93UYw
         pfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZNYjiojbFIUzmBcvsHsGGV+IdWgGeEJbSrpmlqm/tnX52XYgyPZ43JXsn/hNLOxdaAi36a9YLCBGTyQ9QBTJTR2UXPQTgCuQrrxxL
X-Gm-Message-State: AOJu0YwpjyMk2Ue+AOjB75zH/pqJp8pZd4tcGBn5qmvGz+0MPeCNTgX1
	SLBde2UR5tEqN5FiAE70SPmdRnpnd1SRHNuTLMzEWeo+NFUTA0+nETPhVHTR54IZkqOTyqxcPMd
	DdDQPHXUf/WudTujDLPdfqsUMMavzXMsSvqjT
X-Google-Smtp-Source: AGHT+IHIJGDWenq5M5Qd/Y/OfiKdzAH6ZcJ/NZ71Tll1kTz8nut2YI5oWoMv3ccd2nCKSKbM1LiuQQ6pQyn184TK99c=
X-Received: by 2002:a81:91cd:0:b0:648:bca0:1e71 with SMTP id
 00721157ae682-658f09d2be7mr62761217b3.35.1720633396300; Wed, 10 Jul 2024
 10:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-16-Liam.Howlett@oracle.com> <235952c0-0007-41ca-8399-dd388e5596e3@lucifer.local>
In-Reply-To: <235952c0-0007-41ca-8399-dd388e5596e3@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 10:43:05 -0700
Message-ID: <CAJuCfpHuvk52M1nAeS+6QH--Uypr4VdrmCLfGRe2fCgQxtg6_g@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] mm/mmap: Use vms accounted pages in mmap_region()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:43=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jul 04, 2024 at 02:27:17PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Change from nr_pages variable to vms.nr_accounted for the charged pages
> > calculation.  This is necessary for a future patch.
> >
> > This also avoids checking security_vm_enough_memory_mm() if the amount
> > of memory won't change.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Kees Cook <kees@kernel.org>
> > ---
> >  mm/mmap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b14da6bd257f..b2de26683903 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2980,6 +2980,7 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
> >       } else {
> >               /* Minimal setup of vms */
> >               vms.nr_pages =3D 0;
> > +             vms.nr_accounted =3D 0;
>
> This kind of highlights my concern about only setting some vms fields, no=
w we
> have to remember to change this in the right place or happen to know that
> init_vma_munmap() will be otherwise invoked.
>
> >               next =3D vma_next(&vmi);
> >               prev =3D vma_prev(&vmi);
> >               if (prev)
> > @@ -2991,9 +2992,10 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
> >        */
> >       if (accountable_mapping(file, vm_flags)) {
> >               charged =3D pglen;
> > -             charged -=3D nr_accounted;
> > -             if (security_vm_enough_memory_mm(mm, charged))
> > +             charged -=3D vms.nr_accounted;
> > +             if (charged && security_vm_enough_memory_mm(mm, charged))
> >                       goto abort_munmap;
> > +
> >               vms.nr_accounted =3D 0;
>
> Is setting this to zero really needed here? We may be done with this, but=
 if the
> vms value represents the 'unmap state' of this range, surely the number o=
f
> accountable pages remains the same?
>
> >               vm_flags |=3D VM_ACCOUNT;
> >       }
> > --
> > 2.43.0
> >
>
> At this point nr_accounted is no longer used, but I'm guessing a follow u=
p patch
> will remove this? :)

IMHO this and the next patch can be combined to remove this confusion.
They are both rather small, so would not be a big deal.


>
> I was wondering why you used that given the gather function also separate=
ly
> calculates it, but I guess this answers that!
>
> Generally this looks good to me, so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

