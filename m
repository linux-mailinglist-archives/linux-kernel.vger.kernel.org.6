Return-Path: <linux-kernel+bounces-236066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D1291DD09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB0F1F21D61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36E12D752;
	Mon,  1 Jul 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqk+dthW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83484D13
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831015; cv=none; b=PRACJlNYAWLIbfqfx1pXpHfnt8j/Mze1OmLtkZPXtuaa0OHH3hyZWaF+CcMGtQMYeQ5wa+s4ncB950VQ8mQjk2nVhb2BvP4Y+wPxoyASTEP5ZKlb4oM/GcwlT5ron3XiVxk856RGwuiiy327vNus/tmI6+MjvEbk2o3V6DT7KtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831015; c=relaxed/simple;
	bh=A2zmUJ2Il2xPZR4jx+tTDB4JmIkk6o8kfjCPLjUM7p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqjwql3R9pUjw8X5H0zcEZUZlFAQTw82Ycy/Jn16C4icDWabFd3JyMTyrQ0lyR/S5jUXBq/0q8T8PZIsNPmDeSQC4nc2b++YSk57523WBlYffJMatEYy28mJ2YkRXHNjsS5cjDThA9QZXX1G5CTRqH8/0jslICvy4RMzIvnGorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqk+dthW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo94115a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831012; x=1720435812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RwE0Uc+Rpz0HPvWM83+KzFdVZnVYgrPLcO1XXEmyMw=;
        b=Yqk+dthWHsZFbQAvPeRi4shS/TUXlMcuVszvR8XSEGYMSM9sJIl/ZUKhxNIAF6DLWX
         lABMuie51enHib0mNGrmOAOv9jV9HW5CyBCc+nABvM3jvlzf7WFzHMS/wyqgZsRsOKqG
         Qstn+eon4EOokfVWJG1pft6oq3b3kFqIUKdvbEbsBsgMlu0ueumGkAEEwEa9ZFiDTJ5Z
         EO+5du2LWAn3ivQIsKURKm+1lYrje+uiyB8QW5t1yPWV111mQRSouFqZv2VvpDGwhucc
         QU2uYkDazvB1uchibG/HfDDODmK3CXsmZyfPF9I2Hzh25h2RYTs2RBZHoEmoR33VaZpZ
         tRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831012; x=1720435812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RwE0Uc+Rpz0HPvWM83+KzFdVZnVYgrPLcO1XXEmyMw=;
        b=jb7p0c+8F8cpX4PfL7gKBNy8t/s7izQtGZEIepxyqFmP5xquMko882yb1s/8hgGbPX
         /XJ2OtGBrQ0UhSjXSbgc2qFVCQA9Rb4Ta+1gfGVKFddU2XFao27W4oYhJntPIpmyBaT/
         Tu6Gw6eJ7Fd5iE+wwlE9vaeXkXDkBKGtOS5j18NBbHyEhPulfCdZaIxfhtguFJyPc/U4
         4q1f/7OJxMHMrG/AZq+8esjpepykUWmCYYBSgs2K+95mP+GDvTJcxXC+SOS458mhkabL
         uWY8K5zTWaprK36RCSEreHdJYT8bD+uhtHNaBz7saRuD1zB0U8RKFb5ksoGxe27bGqqU
         PEWw==
X-Forwarded-Encrypted: i=1; AJvYcCXN0GZKxjo2RR/6arPKLFYocB/EgeWKfZqlbKNjxcbLxovXZVJt3r4zWecYtal4cIsHy+achs035bqJ2Klv07BaGzc1PK+okzSGkV8J
X-Gm-Message-State: AOJu0YzkBVvdhJkO6mN9jzf+U96uwlh4agIJAsjhbOhHv1FcATVJOgHj
	LDqUml7aAhtS5NlZwDIXpI9yq8IcR8VleEIWmYVA0f7C97nlheSiLdFAODlQESH9tKHCtZSrAjU
	DmlHOzrJW8H0VVIt+Cz9lWaiHDt0=
X-Google-Smtp-Source: AGHT+IECkZ8whp4dApFE6haHXPl6o6J/n2sgKKnGRcec3Us/8UVBfSO1i0cA3VdpBEEwUrJ74+g0EWlnbSr9V9tRA1g=
X-Received: by 2002:aa7:c502:0:b0:57c:677a:a941 with SMTP id
 4fb4d7f45d1cf-587a0bfe1famr2478831a12.40.1719831011547; Mon, 01 Jul 2024
 03:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-3-ioworker0@gmail.com>
 <13dcf4be-8c5f-4697-adc1-b68c3da82d78@arm.com>
In-Reply-To: <13dcf4be-8c5f-4697-adc1-b68c3da82d78@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Jul 2024 18:50:00 +0800
Message-ID: <CAK1f24msC9T2vN6wJPNfMFgG7RsXf7CML-P2fxwkY73969ZAhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: add docs for per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, 21cnbao@gmail.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:31=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 28/06/2024 14:07, Lance Yang wrote:
> > This commit introduces documentation for mTHP split counters in
> > transhuge.rst.
> >
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 1f72b00af5d3..709fe10b60f4 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -514,6 +514,22 @@ file_fallback_charge
> >       falls back to using small pages even though the allocation was
> >       successful.
>
>
> I note at the top of this section there is a note:
>
> Monitoring usage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> .. note::
>    Currently the below counters only record events relating to
>    PMD-sized THP. Events relating to other THP sizes are not included.
>
> Which is out of date, now that we support mTHP stats. Perhaps it should b=
e removed?

Good catch! Let's remove that in this patch ;)

>
> >
> > +split
> > +     is incremented every time a huge page is successfully split into
> > +     base pages. This can happen for a variety of reasons but a common
> > +     reason is that a huge page is old and is being reclaimed.
> > +     This action implies splitting any block mappings into PTEs.
>
> Now that I'm reading this, I'm reminded that Yang Shi suggested at LSFMM =
that a
> potential aid so solving the swap-out fragmentation problem is to split h=
igh
> orders to lower (but not 0) orders. I don't know if we would take that ro=
ute,
> but in principle it sounds like splitting mTHP to smaller mTHP might be
> something we want some day. I wonder if we should spec this counter to al=
so
> include splits to smaller orders and not just splits to base pages?
>
> Actually looking at the code, I think split_huge_page_to_list_to_order(or=
der>0)
> would already increment this counter without actually splitting to base p=
ages.
> So the documantation should probably just reflect that.

Yep, you're right.

It=E2=80=99s important that the documentation reflects that to ensure consi=
stency.

How about "...  is successfully split into smaller orders. This can..."?

Thanks,
Lance

>
> > +
> > +split_failed
> > +     is incremented if kernel fails to split huge
> > +     page. This can happen if the page was pinned by somebody.
> > +
> > +split_deferred
> > +     is incremented when a huge page is put onto split
> > +     queue. This happens when a huge page is partially unmapped and
> > +     splitting it would free up some memory. Pages on split queue are
> > +     going to be split under memory pressure.
> > +
> >  As the system ages, allocating huge pages may be expensive as the
> >  system uses memory compaction to copy data around memory to free a
> >  huge page for use. There are some counters in ``/proc/vmstat`` to help
>

