Return-Path: <linux-kernel+bounces-339626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4D986811
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3CBB229DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B19161902;
	Wed, 25 Sep 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVvERCOi"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A9156677
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298431; cv=none; b=DS3KL9/EEsyseMqnX/azNa0AtSmMv+0qNGytKnJOkLgbj9QLLSXZpJgFRqgKros2XJNy9EjLIoc5DHqUM4PPuUZOZss+NpfvOZ/ptPEwNz78L+GvyWEM1rEhPtRRpWd58TfeMpOFCDN8HMOoM32uVYT4cQlnDwkjAC4xKvTb3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298431; c=relaxed/simple;
	bh=QZt3yVSc/qlXYirdmv6SC1bTfBp6NhD7W4RMDsAzbzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqUndJGWU/KqsU5FuxT2qH9sN4OqKWuH2YKtU2o0dJonof5/xeSvjDW2vhUW/IU3GeIXZTsZA5l2u/QPgGQsAVTT6V0D+51hQ0w435Herj0qRSz43u0B+zQ6J4e7NjeJVM2vMmbk6+rKZ0HrJgNCl+ck+vrWkGPAcgtyw21pTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVvERCOi; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49bbbebc26dso146930137.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727298429; x=1727903229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZt3yVSc/qlXYirdmv6SC1bTfBp6NhD7W4RMDsAzbzQ=;
        b=IVvERCOih+7Wx/r+aAkaSfYsAMlTTMYbqluUJCoyiK9LpCYW0UUtPn56wvAsffLQkc
         21KsJ7ClEQagEvRGkB9TX3pXaMzXzZioFPu1QWaWvfnK+SAT2ohGU4e6zyQt5iGSJKe9
         GCUJC85/Xt6BnehrIcRWO/t9lpcHw1xKlXwXs7p9nyaVDyAWyDUGrXvlrNzfi4stCfUB
         h5bjkJ80IMsUaWgfIBU/wSa9yhnSj8JGpYejNVbLw4fusWQ1GorV9ORbv5n34t0/cQfX
         F8p2W1TUDf5PyfHZdWu8CGJCK6qMYrqFvslBIY6xZGIwTFxCRewQfGPg+jSB/bS3cjys
         7Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727298429; x=1727903229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZt3yVSc/qlXYirdmv6SC1bTfBp6NhD7W4RMDsAzbzQ=;
        b=tGuY3klQx2AT6OnmMCknJJtqsIpJVuJs25ohMZ4qsAXzGaFmT229YUfUZXeT3K1CNo
         Te7XU23JDGYedtAsZkQYmdjglF7o/3TBBiUG3HNreVE5WhueGxokAlegq5ilIMCjN6nw
         JnZgbdu1mITB25UTKzdeeL6clyUy8lEhrEzriyXNksbapRrfBnOwtsQMHxZeZM2aBRUA
         IlxL6MKeXPg8nQV8vCodRCN8FcLkCwjJqZWrI9bCMPX21ltJjKmRyv6XMmtbo/FnU+cm
         NMVb3DelcaSrffAGL9vuF0iMv+KDRJ2XEXE8vpA8gxzKdcreiZmxrwAWt7VdUem4XKdN
         SvRg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgEVwU5UI1PfEkd6EQ4Eq4Ui3TIRzrsbZRnzap8/h65CFpqKti80yztxSN28T+l1m/7g3g1vO+HwJpng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCkk2NKeVf683aw+0nswx9K6Sg0vMv+65rJrPn0yv9DptKEUN
	wnW29xGrrSifJtXiyxFBdF4jV1gd/wItItYyN9147kEIYX7Aq0EfcDSMc51KCOQc4Z62bfMhAW6
	M2tw3QMLNXaF1Mnh7DhdN5zhgN1GTN/O7luKK
X-Google-Smtp-Source: AGHT+IH5Qx2Vu4JNrzIicNZyArgUk6lXzguvXh21h7MSJEkhP162Yp8vlp61GgsBSUkazmamPLIqPYRnxTVCyHD123o=
X-Received: by 2002:a05:6102:304f:b0:49e:94ef:4759 with SMTP id
 ada2fe7eead31-4a15dc3bc76mr4802779137.4.1727298428417; Wed, 25 Sep 2024
 14:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org> <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org> <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
In-Reply-To: <20240925201323.GA880690@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Sep 2024 14:06:26 -0700
Message-ID: <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:13=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Sep 25, 2024 at 12:39:02PM -0700, Yosry Ahmed wrote:
> > On Wed, Sep 25, 2024 at 12:20=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Wed, Sep 25, 2024 at 11:30:34AM -0700, Yosry Ahmed wrote:
> > > > Johannes wrote:
> > > > > If this ever becomes an issue, we can handle it in a fastpath-slo=
wpath
> > > > > scheme: check the limit up front for fast-path failure if we're
> > > > > already maxed out, just like now; then make obj_cgroup_charge_zsw=
ap()
> > > > > atomically charge against zswap.max and unwind the store if we ra=
ced.
> > > > >
> > > > > For now, I would just keep the simple version we currently have: =
check
> > > > > once in zswap_store() and then just go ahead for the whole folio.
> > > >
> > > > I am not totally against this but I feel like this is too optimisti=
c.
> > > > I think we can keep it simple-ish by maintaining an ewma for the
> > > > compression ratio, we already have primitives for this (see
> > > > DECLARE_EWMA).
> > > >
> > > > Then in zswap_store(), we can use the ewma to estimate the compress=
ed
> > > > size and use it to do the memcg and global limit checks once, like =
we
> > > > do today. Instead of just checking if we are below the limits, we
> > > > check if we have enough headroom for the estimated compressed size.
> > > > Then we call zswap_store_page() to do the per-page stuff, then do
> > > > batched charging and stats updates.
> > >
> > > I'm not sure what you gain from making a non-atomic check precise. Yo=
u
> > > can get a hundred threads determining down precisely that *their*
> > > store will fit exactly into the last 800kB before the limit.
> >
> > We just get to avoid overshooting in cases where we know we probably
> > can't fit it anyway. If we have 4KB left and we are trying to compress
> > a 2MB THP, for example. It just makes the upfront check to avoid
> > pointless compression a little bit more meaningful.
>
> I think I'm missing something. It's not just an upfront check, it's
> the only check. The charge down the line doesn't limit anything, it
> just counts. So if this check passes, we WILL store the folio. There
> is no pointless compression.

I got confused by what you said about the fast-slow path, I thought
you were suggesting we do this now, so I was saying it's better to use
an estimate of the compressed size in the fast path to avoid pointless
compression.

I missed the second paragraph.

>
> We might overshoot the limit by about one folio in a single-threaded
> scenario. But that is negligible in comparison to the overshoot we can
> get due to race conditions.
>
> Again, I see no no practical, meaningful difference in outcome by
> making that limit check any more precise. Just keep it as-is.

> Sorry to be blunt, but "precision" in a non-atomic check like this?
> makes no sense. The fact that it's not too expensive is irrelevant.
> This discussion around this honestly has gone off the rails.

Yeah I thought we were talking about the version where we rollback
compressions if we overshoot, my bad. We discussed quite a few things
and I managed to confuse myself.

> Just leave the limit checks exactly as they are. Check limits and
> cgroup_may_zswap() once up front. Compress the subpages. Acquire
> references and bump all stats in batches of folio_nr_pages(). You can
> add up the subpage compressed bytes in the for-loop and do the
> obj_cgroup_charge_zswap() in a single call at the end as well.

We can keep the limit checks as they are for now, and revisit as needed.

