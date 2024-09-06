Return-Path: <linux-kernel+bounces-319432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D912896FC88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A01B2461D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599F31D54FE;
	Fri,  6 Sep 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkBcAFx2"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92E2BCF5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653424; cv=none; b=jkn2uIQLaqFJ+9HpSaZxMb9vVm+Vc2OCedDovND7fGXR789JE0tPf1Dy2f4MhiqzbgDwiz++Hj2rQzun5Z/8SEL27qMGOJq4yprpXbVGSJEH4veltUYvulQ5LAnF5xE7s6+QAfYgNCUevt0g38c0CS/A7Enbb1QVrVMja8yc8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653424; c=relaxed/simple;
	bh=2mv9pO+lXOhcoC7BSkN4CvF/TrAJTr5NyfG0nCFJJ1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAhpmepoaKEIwBFSwbT+Vf8jkt2SfOVt7Eeb9kKXUkCuiK1YP9XvraXVK3J3egWgPsBVA/dTmnP1hmgvjE4ywEeNXUuxRRDbm6OxsQj06HPOOyc1tcocPfGql7OWZxbmvpqk3urj3f4tcHqR4yWZODbWaPwvomNQo2EiPKrodgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkBcAFx2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4567deb9f9dso18211cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725653422; x=1726258222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEVr4TQkWM51xSQ1EU645Vg/YgcR1Wzb2pslXzJntnI=;
        b=GkBcAFx2+MwAx8muDyFJebH0t0+/gZKivP6T7sYYfpp4ux8fxhmwvZ1+nD/m8/quaY
         q9yO8wx46qwI0AKpKdKlkOaz7XngVOaQNVuLwGDjRif4WnlETOZZ5vrP0TrRqiq7Q3MZ
         PJbA6xv7r6AwaS+1UqjKXZoREsi9bJAwocZgaOgzqJoOQ8V6xpjtWh8ZlXX68rVIBBYa
         JJNCao3jvsF4CKlQx5iy7pNOLIQoqkaCUaEkqmEJ7gXng5Kk+FlxHSaWMFbvbk+1ZNb0
         f07BtU4URSmmBYIOzapeLy8V+DemBeAgzBqlBJIgRN+u1ke9WVd0GuxFI/62KtgQhrpG
         P5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725653422; x=1726258222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEVr4TQkWM51xSQ1EU645Vg/YgcR1Wzb2pslXzJntnI=;
        b=OmaLfS9t8wBOlgDtwQqX1ygw0UudCArEd3xv8sBJLiRvCqxijtfwv67nQgEubBvlIJ
         sz7IB+NdYhXmYO6PgvV6Up77zv/z2a/QFjB2cc6MeNVKyV04iJ14peOeO0mIlwb241H1
         OKjZTsFphApyMMCSnqrO4S0SKUCeMvK4kQwNR6WWAakol2farsxsRjmSZmoH6WJ0hciv
         YIipZGBFPSq2vPTPBrKx6YB0fROUESZXQjb8FaidaQVyRxc8xw6X19EKv4Eld01TmXup
         2xxQzm5n9aFcq3oJajB/s7lhBrCHmFl4eX8rV+ZYOiZh65s96tOlJUibVVtJSVP3DK83
         bj7w==
X-Forwarded-Encrypted: i=1; AJvYcCXLjS3BlhlhrDa89QNnlP78AZV86lVqE+WBpPFF2cxqFpYJpjGQQIEo+xPGxleUY/QtW+RKAGeNG35tuWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqyb5Qodrnra+fF+AdET4zdT89KuiulX6k70Ar+wTB5p1ageR9
	An1jn+lLkBh1XqjiJKDplsoiAM3/yIfBhQ+7o/jCwnpDyF86D2p+omD5dqurRE+LhTmrCiDf+4T
	ulIh5ePhtleSKeh135uGxoA4Kh4MQ2e6r1TIU
X-Google-Smtp-Source: AGHT+IEo+r/We55eTGzcfC1iyZnRWX+TItqds5VrqS5smVNhWNm7RrYLphczY6W0yAOsJe3xgdzYYWoda4BvzISrzBg=
X-Received: by 2002:ac8:7f91:0:b0:451:caa6:bcd8 with SMTP id
 d75a77b69052e-4581fa8f3f1mr579461cf.21.1725653421753; Fri, 06 Sep 2024
 13:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906005337.1220091-1-kent.overstreet@linux.dev>
 <CAJuCfpGPAWO5M9SgTYapvtfxnK19EFbNhGZGunGK2OCxdVYNjQ@mail.gmail.com> <cu62ykkqsnuef45qn44wucsqqmpexx2isadwwuu26rny6femip@ptdf3u6zgcqp>
In-Reply-To: <cu62ykkqsnuef45qn44wucsqqmpexx2isadwwuu26rny6femip@ptdf3u6zgcqp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 6 Sep 2024 13:10:07 -0700
Message-ID: <CAJuCfpHQUaSzkOFpj-XHSbTVuOgykkbS8Rj42QFtSUdk7s8rWg@mail.gmail.com>
Subject: Re: [PATCH] mm/show_mem.c: report alloc tags in human readable units
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:52=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Sep 05, 2024 at 08:32:24PM GMT, Suren Baghdasaryan wrote:
> > On Thu, Sep 5, 2024 at 5:53=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > We already do this when reporting slab info - more consistent and mor=
e
> > > readable.
> >
> > Hi Kent,
> > I remember we discussed this before and agreed upon Pasha's suggestion
> > that if needed one could do:
> >
> > # sort -g /proc/allocinfo|tail|numfmt --to=3Diec
> >         2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
> >         3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
> >         4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod]
> > func:ctagmod_start
> >         4.1M        4 net/netfilter/nf_conntrack_core.c:2567
> > func:nf_ct_alloc_hashtable
> >         6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
> >         8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
> >          13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
> >          14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
> >          15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
> >          55M     4887 mm/slub.c:2259 func:alloc_slab_page
> >         122M    31168 mm/page_ext.c:270 func:alloc_page_ext
> >
> > That's even documented here:
> > https://elixir.bootlin.com/linux/v6.10.8/source/Documentation/mm/alloca=
tion-profiling.rst#L36
> > Did something change?
>
> That's for /proc/allocinfo, which this patch doesn't change - this is
> the oom report.

Ah, got it! Looks reasonable to me.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

