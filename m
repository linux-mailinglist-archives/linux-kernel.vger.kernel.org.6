Return-Path: <linux-kernel+bounces-373634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29509A599B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95D11C20FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497C191F60;
	Mon, 21 Oct 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9ttUxhR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512DF28F7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729486505; cv=none; b=FzTPzLAe52dOHcd4fRdED1hvCGMQS1kFdE7jiPxM36vgG/4SDCRB1jl/VX8NzmFvYqyzhLCQ0YbC4WGAdjASjgABZiWkOLF7xxqL18IgAbRRBEtdJwh4R0ThzYcbKMIVxapwG6h1INWTQ0XOUSEyqxNjr9bc7QchBTTygVf0juE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729486505; c=relaxed/simple;
	bh=QqNMwzKW8TqDU6N5Vst1qs1/ZnqGmuJVjkMYt3zhPFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioZk7TZVXLYNsHCkE+g9rZ3bAocCaW/aworKSVE9brO1By/i8EFtZkrY6ji6Sn6ZY2rb1MXbEwZc51W8Bncwfr5du76g0cnMK8FbLhqZe4ZUX/6jSC6OILw3fQIK92QR55OaN0813opBO6vDHhu2StEwmLxSdmoNwk8g64vAYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9ttUxhR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a0c160b94so1893082e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729486501; x=1730091301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U1RWkDpBLtv6ScO5BY3mmJK87haac1ESyN1ito8E4s=;
        b=V9ttUxhRL6WwKY/k2WsgxHmJ+ocxEl3J/jtSI0Nafr8SxDgj2TcPnTmN3++b1RNnJ9
         KuJ9ikWHVwVIY5XUae5glbRV407xktTvC+UqZMXV1iP/8LPs1F7LIAsXmBfpuht7vleu
         YGnlNBPZlBxL1kpuxJHj3rvDqIYMOz6y5R3E9HIF44bYXIA5mz8znplNoLbajL1Hscgy
         xThbGTZXL7Y0X9L2ruBaiZocQyogKgYjyZU7SBnK78TQrc/8kt/VJgQcNzBlpacAc+Xs
         LwkZUqS+Qe1rnGs0Cksr5iWoqeO0E3B6LT6J7THCLOMWVpOiXwX0PdR3KeK3POY8GMLE
         iGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729486501; x=1730091301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6U1RWkDpBLtv6ScO5BY3mmJK87haac1ESyN1ito8E4s=;
        b=KkvnVTVR2IQTeQcC9avQie/NHrAUSxnjb/fdF/98kIPW7N0JrhsAmu9ZyoJdAEE2rZ
         STpAsCu1zvfGmqBf3V5herziRYjQbo6KQs1TTdzQnmE/xBcQHibbuohsRFqsRb69pUip
         MPOSt/GbLxmii/eLbptjyePLwt19tTFgT0o2VZFjdIugGwSWopnB/g+p8hJ0vKkZAjyC
         bH44VdRQfw8+b/0UwgjS/Gf3BtR+SeKyU0SNqJNw5Hj/ENLkZ9IQVMx+Ci1vehu2GFhF
         N7DZmiz+va4SB/KUK3j9+00lF/JrNI9xcMq71pIOvPlGjlcokT9NxDnPGpx7xmwrjyeT
         27gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICuZXsOwQGfKUsaQLWwmglcX7aRBFbHicSvUQa7krU5r/s+k8h+lYaEMoP4Xlwj1cX/2dYzB7zcWeLtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3WRV7IzJFkciLzU7IFS6cZNjkfKIJsPf3U0kFTf7w2+4gq+g
	p6iMrP9x9TP6vQZKoUa7eTk1NeQAJ8EkIS5AGgP6iZRjA+gtTeozISjzE3TexwwNTG2dIAzHbJ6
	eY6d+3mCJ5mhQfv47uv4VmRJeV1BRpS+Q
X-Google-Smtp-Source: AGHT+IFGKjEPPKjASZcUAhSNC04pzwZ3RqX0DEVh4g5m3w9MumFRPT4Zo938Qm08ENXRqMBRBcFN8UQi2Nh4ABOg2HI=
X-Received: by 2002:a05:6512:12cb:b0:539:9594:b226 with SMTP id
 2adb3069b0e04-53a1522dba5mr4307322e87.34.1729486500871; Sun, 20 Oct 2024
 21:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017064449.5235-1-suhua1@kingsoft.com> <ZxStKvw6HwminDub@kernel.org>
In-Reply-To: <ZxStKvw6HwminDub@kernel.org>
From: Su Hua <suhua.tanke@gmail.com>
Date: Mon, 21 Oct 2024 12:54:23 +0800
Message-ID: <CALe3CaDuZ9Ehd=csC9h-GnJ0PgLT11AKvSWpFBvUxNfTkUyrxQ@mail.gmail.com>
Subject: Re: [PATCH] memblock: Uniform initialization all reserved pages to MIGRATE_MOVABLE
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, suhua <suhua1@kingsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, Oct 17, 2024 at 02:44:49PM +0800, suhua wrote:
> > Subject: memblock: Uniform initialization all reserved pages to MIGRATE=
_MOVABLE
>
> I'd suggest:
>
> memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE

Thanks for the correction.

> > Currently when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the reserve=
d
> > pages are initialized to MIGRATE_MOVABLE by default in memmap_init.
> >
> > Reserved memory mainly stores the metadata of struct page. When
> > HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=3DY and hugepages are allocate=
d,
> > the memory occupied by the struct page metadata will be freed.
>
> The struct page metadata is not freed with HVO, it is rather pages used f=
or
> vmemmap.

Yes, I will update the description.

> > Before this patch:
> > when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the freed memory was
> > placed on the Movable list;
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT=3DY, the freed memory was placed =
on
> > the Unmovable list.
> >
> > After this patch, the freed memory is placed on the Movable list
> > regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT is set.
> >
> > Eg:
>
> Please add back the description of the hardware used for this test and ho=
w
> much huge pages were allocated at boot.

Well, the new patch will add this information.

> > echo 500000 > /proc/sys/vm/nr_hugepages
> > cat /proc/pagetypeinfo
> >
> > before=EF=BC=9A
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > =E2=80=A6
> > Node    0, zone   Normal, type    Unmovable     51      2      1     28=
     53     35     35     43     40     69   3852
> > Node    0, zone   Normal, type      Movable   6485   4610    666    202=
    200    185    208     87     54      2    240
> > Node    0, zone   Normal, type  Reclaimable      2      2      1     23=
     13      1      2      1      0      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    0, zone   Normal, type      Isolate      0      0      0      0=
      0      0      0      0      0      0      0
> > Unmovable =E2=89=88 15GB
> >
> > after=EF=BC=9A
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > =E2=80=A6
> > Node    0, zone   Normal, type    Unmovable      0      1      1      0=
      0      0      0      1      1      1      0
> > Node    0, zone   Normal, type      Movable   1563   4107   1119    189=
    256    368    286    132    109      4   3841
> > Node    0, zone   Normal, type  Reclaimable      2      2      1     23=
     13      1      2      1      0      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    0, zone   Normal, type      Isolate      0      0      0      0=
      0      0      0      0      0      0      0
> >
> > Signed-off-by: suhua <suhua1@kingsoft.com>
>
> checkpatch.pl gives this warning:
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: suhua <suhua=
.tanke@gmail.com>' !=3D 'Signed-off-by: suhua <suhua1@kingsoft.com>'
> Please update the commit authorship or signed-off to match.
>
> Also, Signed-off-by should use a known identity, i.e. Name Lastname.

Oh, this is my oversight.

> > ---
> >  mm/mm_init.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 4ba5607aaf19..6dbf2df23eee 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -722,6 +722,10 @@ static void __meminit init_reserved_page(unsigned =
long pfn, int nid)
> >               if (zone_spans_pfn(zone, pfn))
> >                       break;
> >       }
> > +
> > +     if (pageblock_aligned(pfn))
> > +             set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVAB=
LE);
> > +
> >       __init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> >  }
> >  #else
> > --
> > 2.34.1
> >

Sincerely yours,
Su

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=8820=E6=97=
=A5=E5=91=A8=E6=97=A5 15:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 17, 2024 at 02:44:49PM +0800, suhua wrote:
> > Subject: memblock: Uniform initialization all reserved pages to MIGRATE=
_MOVABLE
>
> I'd suggest:
>
> memblock: uniformly initialize all reserved pages to MIGRATE_MOVABLE
>
> > Currently when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the reserve=
d
> > pages are initialized to MIGRATE_MOVABLE by default in memmap_init.
> >
> > Reserved memory mainly stores the metadata of struct page. When
> > HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=3DY and hugepages are allocate=
d,
> > the memory occupied by the struct page metadata will be freed.
>
> The struct page metadata is not freed with HVO, it is rather pages used f=
or
> vmemmap.
>
> > Before this patch:
> > when CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set, the freed memory was
> > placed on the Movable list;
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT=3DY, the freed memory was placed =
on
> > the Unmovable list.
> >
> > After this patch, the freed memory is placed on the Movable list
> > regardless of whether CONFIG_DEFERRED_STRUCT_PAGE_INIT is set.
> >
> > Eg:
>
> Please add back the description of the hardware used for this test and ho=
w
> much huge pages were allocated at boot.
>
> > echo 500000 > /proc/sys/vm/nr_hugepages
> > cat /proc/pagetypeinfo
> >
> > before=EF=BC=9A
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > =E2=80=A6
> > Node    0, zone   Normal, type    Unmovable     51      2      1     28=
     53     35     35     43     40     69   3852
> > Node    0, zone   Normal, type      Movable   6485   4610    666    202=
    200    185    208     87     54      2    240
> > Node    0, zone   Normal, type  Reclaimable      2      2      1     23=
     13      1      2      1      0      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    0, zone   Normal, type      Isolate      0      0      0      0=
      0      0      0      0      0      0      0
> > Unmovable =E2=89=88 15GB
> >
> > after=EF=BC=9A
> > Free pages count per migrate type at order       0      1      2      3=
      4      5      6      7      8      9     10
> > =E2=80=A6
> > Node    0, zone   Normal, type    Unmovable      0      1      1      0=
      0      0      0      1      1      1      0
> > Node    0, zone   Normal, type      Movable   1563   4107   1119    189=
    256    368    286    132    109      4   3841
> > Node    0, zone   Normal, type  Reclaimable      2      2      1     23=
     13      1      2      1      0      1      0
> > Node    0, zone   Normal, type   HighAtomic      0      0      0      0=
      0      0      0      0      0      0      0
> > Node    0, zone   Normal, type      Isolate      0      0      0      0=
      0      0      0      0      0      0      0
> >
> > Signed-off-by: suhua <suhua1@kingsoft.com>
>
> checkpatch.pl gives this warning:
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: suhua <suhua=
.tanke@gmail.com>' !=3D 'Signed-off-by: suhua <suhua1@kingsoft.com>'
> Please update the commit authorship or signed-off to match.
>
> Also, Signed-off-by should use a known identity, i.e. Name Lastname.
>
> > ---
> >  mm/mm_init.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 4ba5607aaf19..6dbf2df23eee 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -722,6 +722,10 @@ static void __meminit init_reserved_page(unsigned =
long pfn, int nid)
> >               if (zone_spans_pfn(zone, pfn))
> >                       break;
> >       }
> > +
> > +     if (pageblock_aligned(pfn))
> > +             set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVAB=
LE);
> > +
> >       __init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> >  }
> >  #else
> > --
> > 2.34.1
> >
>
> --
> Sincerely yours,
> Mike.

