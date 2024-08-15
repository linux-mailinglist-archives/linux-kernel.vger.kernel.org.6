Return-Path: <linux-kernel+bounces-288391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436EF95399C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7E4285F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45B43AD2;
	Thu, 15 Aug 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqTqUiDk"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A715CB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745086; cv=none; b=cA8BAXnLbXlW8czHmluMqo3pDHGtScxkut9eq1reNhpShytcORFUPQAbAXpfI8kweHzF4RwTzt1RuhYxcnge8jQXk8i2BO4jdglAXf2+IhA5hVxLb3kvpqtKkXPuUBGEb9OYyv4Z/uy2i7tSQhm8r1PZxy0KkWsaIVKLJBvCrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745086; c=relaxed/simple;
	bh=b8T+M9azKHegNkwqtwt2ul9dloAL6igr759NzMvc124=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuroEKYYR/O4w4pLCmwIJbLVNbrVligWtJLLqX4Ft8VQFRHNV+rZ59nBUzvBmK/d4XmkJ30QZMoTAAZkcJyfEMAq3jyd3DYegI4ZMRlJnG9DnjGRpgb23ZCxT1PhhaZaySJJzVcznjAgMuwpb8p1CSf2NNkLUMwodWzO95n5fQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqTqUiDk; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0be2978a0fso1117977276.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723745084; x=1724349884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5ULcUR5IzUEbFCx2TddqIkAP4y49Tv/vG1UVjDgY8g=;
        b=CqTqUiDkzG9fQxcEUH1eksqMG0KA929CCHZc24HnsoCHYx5GjHWaBis2rXkonoF9aH
         5JF3iEKIEvtnF5zEjJU+CHMNRPcPqyXAO8JKbdvXa9UDkkpNGH64jiWIoPMcSqCSoXMS
         IqXVpbxlNUcjy103vPSQLj7t5KYu8cPplUK+Z/qabqPozi8u9YfBkJXFa5rZXhcKGR/3
         PZbYZJmWPXGxOqh9vNsv10tPMVaN2VkvXsPVfhCjLOFXELb76kDBS6vvgCYTb44h8Oir
         +fKyMz+BJFaS3/YpS2jPFHvJ1XxY+4PeuQme/eRfy3u5ymmPX5X+QPGQZIe5NasbJcfY
         50bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745084; x=1724349884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5ULcUR5IzUEbFCx2TddqIkAP4y49Tv/vG1UVjDgY8g=;
        b=EkoA14+DH/prlJq1T5XoRcxmvYJ8WMykjQbi7+O/0+8/9n0ycjvfoQqKTicN/Rxxfe
         mbaDDM3gLrICVkCxwX8tVzvLttGYZBJuQ7G4XOiGWMnl1BjTFPTQLdasiZBRoT0AOG1D
         mO1BfwvjdgluPj5QEjpaEid95pUiOd5d2F4oefvhlTWpvn6s8QuDCSHisNRBr2GXr6QT
         yo1KzBVY4AkDVKCPcPNfcTPlDYnoDgrl78wBv/Y3JWr8iSQFrQYQolWvMDinX4u0DObD
         hxnBAKg9ZVUW6bqDIakSht1g3mbkH3d7Q9578mZAukVvRidnEU65vP+RaRUnSrMuU3R2
         iQjw==
X-Forwarded-Encrypted: i=1; AJvYcCXcS2OOIEvQykqQrM92IugTS+fqg/GO+wJpoi57rCngbEKMHdu/gBo+Exvl/7Bl9orLvlLFqxAZJhQnSd5ESxGyAxg16nF92YtcmxqS
X-Gm-Message-State: AOJu0YzXiwHsH9sn/QqRfu+AdDHk/jVaxRoZ0ZFmkQUgyDpho/ghlssc
	bLdpzqYRHidikzEwm70vEf5169zI+evR/dvlLBpbpSzRaHDRbTLbRyLPPLHtV1sEVkhJVjEnfq3
	5Ig1dr+gh2BdyhZnfvi0ARM1Bl6Dq/zKpt04I
X-Google-Smtp-Source: AGHT+IEHZ4aqXuT/wNXL98dHYfWurrnb7OEDVqi2GhnghdJaUI9+8I31F8oLPURFKXgHJiAbMKMgSCgndgenZUkhxDA=
X-Received: by 2002:a05:690c:f94:b0:6ae:1e27:c994 with SMTP id
 00721157ae682-6b1b6ebe997mr5055047b3.3.1723745083770; Thu, 15 Aug 2024
 11:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815090324.36065-1-hao.ge@linux.dev> <e6357e8e-5dd4-47a1-b7a4-603d32633692@redhat.com>
In-Reply-To: <e6357e8e-5dd4-47a1-b7a4-603d32633692@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Aug 2024 11:04:31 -0700
Message-ID: <CAJuCfpEArs7qr=QJE6+RiV2GTK+q4_UCHaAEQK_7coARuJj_dw@mail.gmail.com>
Subject: Re: [PATCH] codetag: debug: mark codetags for cma pages as empty
To: David Hildenbrand <david@redhat.com>
Cc: Hao Ge <hao.ge@linux.dev>, rppt@kernel.org, akpm@linux-foundation.org, 
	babka@suse.cz, kent.overstreet@linux.dev, kees@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:39=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.08.24 11:03, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > Here are some warnning
> >
> > [    1.342603] ------------[ cut here ]------------
> > [    1.342608] alloc_tag was not set
> > [    1.342623] WARNING: CPU: 0 PID: 1 at ./include/linux/alloc_tag.h:13=
0 __free_pages+0x1a4/0x1b4
> > [    1.342633] Modules linked in:
> > [    1.342639] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-=
rc3+ #12
> > [    1.342645] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [    1.342650] pc : __free_pages+0x1a4/0x1b4
> > [    1.342654] lr : __free_pages+0x1a4/0x1b4
> > [    1.342658] sp : ffff8000833dbcb0
> > [    1.342661] x29: ffff8000833dbcb0 x28: ffff000b34d9dac0 x27: ffff800=
08175f000
> > [    1.342669] x26: 00000000000fc000 x25: ffff800082ac6028 x24: ffff800=
08252e000
> > [    1.342675] x23: ffff0000c0660000 x22: 0000000000000000 x21: 0000000=
000000009
> > [    1.342681] x20: 0000000000000000 x19: fffffd7fc3ac0000 x18: fffffff=
fffffffff
> > [    1.342688] x17: ffff80008105bf68 x16: ffff800081841bb4 x15: 0720072=
007200720
> > [    1.342694] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072=
007200720
> > [    1.342700] x11: 0720072007200720 x10: 0720072007200720 x9 : 0720072=
007200720
> > [    1.342706] x8 : 0720072007200720 x7 : ffff80008237bad0 x6 : c000000=
0ffff7fff
> > [    1.342712] x5 : ffff80008237ba78 x4 : ffff8000820bbad0 x3 : 0000000=
000000001
> > [    1.342719] x2 : 13c63f521095dc00 x1 : 13c63f521095dc00 x0 : 0000000=
000000000
> > [    1.342725] Call trace:
> > [    1.342728]  __free_pages+0x1a4/0x1b4
> > [    1.342732]  init_cma_reserved_pageblock+0x5c/0xac
> > [    1.342739]  cma_init_reserved_areas+0x2b4/0x3f4
> > [    1.342744]  do_one_initcall+0x54/0x368
> > [    1.342749]  kernel_init_freeable+0x23c/0x450
> > [    1.342755]  kernel_init+0x2c/0x144
> > [    1.342760]  ret_from_fork+0x10/0x20
> > [    1.342764] ---[ end trace 0000000000000000 ]---
> >
> > To avoid debug warnings while freeing cma pages which were not
> > allocated with usual allocators, mark their codetags as empty before
> > freeing.
> >
> > Reference commit d224eb0287fb ("codetag: debug: mark codetags
> > for reserved pages as empty")
> >
> > Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allo=
cation and free paths")
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > ---
> >   mm/mm_init.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 75c3bd42799b..d7d40a8d738f 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2243,6 +2243,16 @@ void __init init_cma_reserved_pageblock(struct p=
age *page)
> >               set_page_count(p, 0);
> >       } while (++p, --i);
> >
> > +     /* pages were reserved and not allocated */
> > +     if (mem_alloc_profiling_enabled()) {
> > +             union codetag_ref *ref =3D get_page_tag_ref(page);
> > +
> > +             if (ref) {
> > +                     set_codetag_empty(ref);
> > +                     put_page_tag_ref(ref);
> > +             }
> > +     }
> > +
> >       set_pageblock_migratetype(page, MIGRATE_CMA);
> >       set_page_refcounted(page);
> >       __free_pages(page, pageblock_order);
>
> See https://lkml.kernel.org/r/20240813150758.855881-2-surenb@google.com

Good timing! Yes, it's the same issue.

>
> --
> Cheers,
>
> David / dhildenb
>

