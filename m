Return-Path: <linux-kernel+bounces-318094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6D096E84A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB76286455
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30E38384;
	Fri,  6 Sep 2024 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugOgU1hd"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED11E521
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593558; cv=none; b=TKU0lHHKORkvEPWX6T4Zu30mxAOSzvCizUW+4sSN3itMuWJhZ8qxjzv/XY9KDYrMUEHRPVYstbOpr5JbyWyB3i9VB4+Mllv3AN24cg8fcb+4MaSwxvWRRZgn9l8mrK1MeGk7YVqEEPW1cpV2vE9I4ygBLbdNo3DoZ9BAPE8FDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593558; c=relaxed/simple;
	bh=AeF1GrQlou929wSFQVEIZucVD8G3MOj3K7volvjSLWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV7pv1DsI6rp4A5J+iSV55rCTXOwkVWx0KOWK5d3GsEt/f/B+UqVF7Dp8/R26GnhnQVnxSDwZFxzFak6AYlBKbdWlOxXs6k5T6cwXaP172np+bDWZ8mOBtjaRHIZJKWr9qEGzFMFe2mQoXAgg63T2+wt2DRQUmNhFv9lrXLDfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugOgU1hd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4567fe32141so104501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725593555; x=1726198355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGD+kq844RgjIMgaWd689+bfKQO1SfZUcX5ijNslcG4=;
        b=ugOgU1hdk57SnP/p1hhiuFFHTR5bR5NC/y8QOFdgzLEbOyJlQN/RaV8G1WINT3fY46
         J5jLhg8snY3UJYAEUMeh9psjay4wM5z9Sg4jwRdGdYuIfwlcG35uxG8fj8dibh9oRYX2
         7mnzjIoC0XJdJjkWJTBcMdJ1gdTIaEFAn77lpO99sQP7fU8GKI0Fahhq8WnxHmpPMVTg
         vvlR/Fv/DwOhUhztIvETib3odA0YP+ikmXsCwQBf0i/cJ8Cb78dfMdnGSQAMZmmbt5Zb
         F7N2e5pAHUUdZ0AmcYB0cYnOazRZdSi+o14V9XBTTz/VhvB4R4qYGqR2zZmBqrZCt3PF
         Ak0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725593555; x=1726198355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGD+kq844RgjIMgaWd689+bfKQO1SfZUcX5ijNslcG4=;
        b=TWzaedpWB+9NGdSF1r/G5tVahJDizFZR84vazkLWDW3SIvs28eX1+n3qXHn2O4fhBn
         eVREW1Vl/NaoVFQVWpb1IZ5skQc2yqaIMm2N17gXvabI8f8TqATeSmDLT59l5FS/YU3y
         DbvQNwUBHXHebkemd74mYSf0nh8XLFJKUYZ7Ws1jOtNM+4+uNL6mLIAriBILUzy5eJHX
         6KUPf3nYfmKIu2qwMuP8fxLAYZOar9uDyNgZxjQ5jVufZdo4Gx96IauYmjGvD4C/HhQd
         CdioEMO6JmoukXHRFCS7pa4dajsxl6CFtBZbKQv3TpwayibawFgl96INRB3sxYsSEYYF
         N8VA==
X-Forwarded-Encrypted: i=1; AJvYcCXlVoVEYyDJ+UC1erbGiLCZ1c960kV2sP5++3wrvm/z7tfN72zA0oa8Oy77160kzdGAAhzjnR1lP8g2Uww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAoUU0GFIP9+LUeWoaGFRF4lcFwxPMk9dAmaEvy5sbs96sNnQ
	ab0sjac2nEngzekxOi6NTDWjM9b0bTiaZLvEAorUSZHCfF0t+HfxnFl4rqohP084l8U9DMcQC89
	ySNx1d7d0IxPy314zUZhKPeRTm+nKw941tqII
X-Google-Smtp-Source: AGHT+IHXptcIy8FKYGMHmjV6qcqim8ryRJ5KLZrYDWADLTHrX96IQIVT6l7HSHhb5egWqkpNygLZkIqBcszskium9es=
X-Received: by 2002:ac8:58c3:0:b0:456:780c:1d3a with SMTP id
 d75a77b69052e-4580e58bf23mr729901cf.19.1725593554976; Thu, 05 Sep 2024
 20:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906005337.1220091-1-kent.overstreet@linux.dev>
In-Reply-To: <20240906005337.1220091-1-kent.overstreet@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Sep 2024 20:32:24 -0700
Message-ID: <CAJuCfpGPAWO5M9SgTYapvtfxnK19EFbNhGZGunGK2OCxdVYNjQ@mail.gmail.com>
Subject: Re: [PATCH] mm/show_mem.c: report alloc tags in human readable units
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:53=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> We already do this when reporting slab info - more consistent and more
> readable.

Hi Kent,
I remember we discussed this before and agreed upon Pasha's suggestion
that if needed one could do:

# sort -g /proc/allocinfo|tail|numfmt --to=3Diec
        2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
        3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
        4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod]
func:ctagmod_start
        4.1M        4 net/netfilter/nf_conntrack_core.c:2567
func:nf_ct_alloc_hashtable
        6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
        8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
         13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
         14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
         15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
         55M     4887 mm/slub.c:2259 func:alloc_slab_page
        122M    31168 mm/page_ext.c:270 func:alloc_page_ext

That's even documented here:
https://elixir.bootlin.com/linux/v6.10.8/source/Documentation/mm/allocation=
-profiling.rst#L36
Did something change?

>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  mm/show_mem.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 691e1b457d04..1b448e1ebd09 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -459,15 +459,18 @@ void __show_mem(unsigned int filter, nodemask_t *no=
demask, int max_zone_idx)
>                                 struct codetag *ct =3D tags[i].ct;
>                                 struct alloc_tag *tag =3D ct_to_alloc_tag=
(ct);
>                                 struct alloc_tag_counters counter =3D all=
oc_tag_read(tag);
> +                               char bytes[10];
> +
> +                               string_get_size(counter.bytes, 1, STRING_=
UNITS_2, bytes, sizeof(bytes));
>
>                                 /* Same as alloc_tag_to_text() but w/o in=
termediate buffer */
>                                 if (ct->modname)
> -                                       pr_notice("%12lli %8llu %s:%u [%s=
] func:%s\n",
> -                                                 counter.bytes, counter.=
calls, ct->filename,
> +                                       pr_notice("%12s %8llu %s:%u [%s] =
func:%s\n",
> +                                                 bytes, counter.calls, c=
t->filename,
>                                                   ct->lineno, ct->modname=
, ct->function);
>                                 else
> -                                       pr_notice("%12lli %8llu %s:%u fun=
c:%s\n",
> -                                                 counter.bytes, counter.=
calls, ct->filename,
> +                                       pr_notice("%12s %8llu %s:%u func:=
%s\n",
> +                                                 bytes, counter.calls, c=
t->filename,
>                                                   ct->lineno, ct->functio=
n);
>                         }
>                 }
> --
> 2.45.2
>

