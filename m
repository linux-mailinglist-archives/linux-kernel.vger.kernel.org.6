Return-Path: <linux-kernel+bounces-339575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321898672C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC361F23F75
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B797145A11;
	Wed, 25 Sep 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0S3Fn3A"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF27483
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293795; cv=none; b=hk8d68EGFWx2x+HoR9+eUyah9uGHDSCxz3AohqIXu+sYQc7rXu1UlXAFIJ4Xdf64ZRje+Nq36HFWZmzy54LYtrWddbajlOVOJvswQV+HJ2v7iZ4P2lV/CX36KJQwv5ayYaHPMhgdQxP5ynysLzXOhruhJZcCFcv/gH/N5Jps95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293795; c=relaxed/simple;
	bh=x4DdtdussbMDHS2whrljcdH70T37YBCkEKiRiXvjKHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM0ovTPK8NZKkrEaUYU8YWOoCL3gG+PoJBqOIVYgpJaZ6CmLsC4HPv6rIY6Du8smatboCXgBiq2LJbDjZPxBC2hFt6zRgtTqlH5xWLidQIz2isAhTFHFIJCRhPeKS4roTlykx64LqFv/F0wPdZf9BInxLz1ufPs5WI9ObRFi2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0S3Fn3A; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so256738266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727293792; x=1727898592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDIzP+sh/uI4eNppc+3qR6pBT/O+j/o04qIWIoM9cP4=;
        b=w0S3Fn3ACmtZ1vaV8aV9kq3IuxrCc265m8VcdNpP/sWigDWt8BKCrYsTdWs3v/jJkS
         KVotlqr2LQ8+dVJ6Y+o+RiWcK3JFJ5gXAT8ezoRxvpR70vnXxY3pPZexTuqDwlHi9kqN
         kKj6rFcrYVsBhRadWwLseBVC9VewOjiFF29UeJsdToFBjnOE2g0J65QWJU4P58lryb6m
         2+g+3SRvvtz9RabaKQyk3B3vJWfKZHI6jvBw+jwGrgQP1L+uzOdfNFqI/ktSEy7F7tWg
         9saW4XIqyv9DVcCQG8qipj+pAAYaljl1ZmUpBgDLo3Vku4gEe9oGz3LAKhVquIfQLyyl
         J0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293792; x=1727898592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDIzP+sh/uI4eNppc+3qR6pBT/O+j/o04qIWIoM9cP4=;
        b=Y1aU3/gO58t/g7g4SXrg43qUDTZz9xUfL3dagH2kLnOUcpmk6x80IxSGnTUiUz1aHK
         UlMbZggpn2+MSlyW2+bE7NscN9fPHym3EUG1Dy5G4Z+cQqB+BOfLrEJ1sQirE3n7irjx
         dXuxuryBybz30qiSbnWGDSDA17b58umyHldbf3wNn7FpxgUcfvJtXx+IXVL+9lSfMUnM
         1iCQhVQwXlO5cmPbnyT91etdj6zzVssxlABugBaQSNgvMRozxMOr5sTUmgfIukR/fSzI
         AEqaKkODNcWC4zDnn7E1SPCnCQYcic3cgWQHZgCcNCj8UAg/qMfuWCAUUrv81u+LiZsg
         aaWA==
X-Forwarded-Encrypted: i=1; AJvYcCWt9+fczBE1xDvSjx1v1nsg/EF+o2l3xsmiMUB9mjaB9rceZ5w5AnK5OhMiAZx89BeBG9mHeVKZDIoRpsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUrqgWtZXsA2FvMduR0ao/p5bLYfh3En3LliX/BiSqn6F5pbi
	6mJ2EKTtckGd5BNW9430m2az9il3TpGRbFFNVvfuX5vcNGp5UPEiP5gM5z1TEURb+ZaB5OJiWxk
	Nlo6xVmjZ/mfZG5iiNXdM2dn0ln3Pkw7MU2VM
X-Google-Smtp-Source: AGHT+IGj6Bwqln8E9y6xXVNdF13Fn9r97uuyLN+uVhMBcmBw5v8NlAuMrgaqTe5hDv61S0qWRxXL2USPDIEMZtPGH44=
X-Received: by 2002:a17:907:9728:b0:a90:34e8:6761 with SMTP id
 a640c23a62f3a-a93b157ccfbmr84071766b.6.1727293791591; Wed, 25 Sep 2024
 12:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org> <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <SJ0PR11MB56784B0D0EC2348A0ED7542CC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56784B0D0EC2348A0ED7542CC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Sep 2024 12:49:13 -0700
Message-ID: <CAJD7tkapj+Wb7BMGZ=2AGi2NTXJbZBCnoJkZuBAkkF8NDZDKjA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > > > +       /*
> > > > > +        * Check cgroup limits:
> > > > > +        *
> > > > > +        * The cgroup zswap limit check is done once at the beginning of an
> > > > > +        * mTHP store, and not within zswap_store_page() for each page
> > > > > +        * in the mTHP. We do however check the zswap pool limits at the
> > > > > +        * start of zswap_store_page(). What this means is, the cgroup
> > > > > +        * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
> > > > > +        * However, the per-store-page zswap pool limits check should
> > > > > +        * hopefully trigger the cgroup aware and zswap LRU aware global
> > > > > +        * reclaim implemented in the shrinker. If this assumption holds,
> > > > > +        * the cgroup exceeding the zswap limits could potentially be
> > > > > +        * resolved before the next zswap_store, and if it is not, the next
> > > > > +        * zswap_store would fail the cgroup zswap limit check at the start.
> > > > > +        */
> > > >
> > > > I do not really like this. Allowing going one page above the limit is
> > > > one thing, but one THP above the limit seems too much. I also don't
> > > > like relying on the repeated limit checking in zswap_store_page(), if
> > > > anything I think that should be batched too.
> > > >
> > > > Is it too unreasonable to maintain the average compression ratio and
> > > > use that to estimate limit checking for both memcg and global limits?
> > > > Johannes, Nhat, any thoughts on this?
> > >
> > > I honestly don't think it's much of an issue. The global limit is
> > > huge, and the cgroup limit is to the best of my knowledge only used as
> > > a binary switch. Setting a non-binary limit - global or cgroup - seems
> > > like a bit of an obscure usecase to me, because in the vast majority
> > > of cases it's preferable to keep compresing over declaring OOM.
> > >
> > > And even if you do have some granular limit, the workload size scales
> > > with it. It's not like you have a thousand THPs in a 10M cgroup.
> >
> > The memcg limit and zswap limit can be disproportionate, although that
> > shouldn't be common.
> >
> > >
> > > If this ever becomes an issue, we can handle it in a fastpath-slowpath
> > > scheme: check the limit up front for fast-path failure if we're
> > > already maxed out, just like now; then make obj_cgroup_charge_zswap()
> > > atomically charge against zswap.max and unwind the store if we raced.
> > >
> > > For now, I would just keep the simple version we currently have: check
> > > once in zswap_store() and then just go ahead for the whole folio.
> >
> > I am not totally against this but I feel like this is too optimistic.
> > I think we can keep it simple-ish by maintaining an ewma for the
> > compression ratio, we already have primitives for this (see
> > DECLARE_EWMA).
> >
> > Then in zswap_store(), we can use the ewma to estimate the compressed
> > size and use it to do the memcg and global limit checks once, like we
> > do today. Instead of just checking if we are below the limits, we
> > check if we have enough headroom for the estimated compressed size.
> > Then we call zswap_store_page() to do the per-page stuff, then do
> > batched charging and stats updates.
> >
> > If you think that's an overkill we can keep doing the limit checks as
> > we do today,
> > but I would still like to see batching of all the limit checks,
> > charging, and stats updates. It makes little sense otherwise.
>
> Thanks Johannes and Yosry for these suggestions and pointers.
> I think there is general agreement about the batch charging and
> zswap_stored_pages/stats updates. Yosry,  does "batching of limit
> checks" imply the same as a simple check for being over the cgroup
> limit at the start of zswap_store and not doing this check in
> zswap_store_page? Does this also imply a zswap_pool_get_many()?
> Would appreciate it if you can help clarify.

Yes I think we should batch as much as possible in zswap_store(), and
only do the things are truly per-page in zswap_store_page(). The limit
checks, stats updates, zswap_pool refs, charging etc. Batching all of
these things should be clear wins.

>
> The main question in my mind about using the EWMA checks is,
> will it add overhead to the normal zswap reclaim path; and if so,
> would a simple limit check at the start of zswap_store as suggested
> by Johannes suffice. I can run a few experiments to quantify this
> overhead, and maybe we can revisit this?

If you look at ewma_##name##_add() in include/linux/average.h, it's
really just a bunch of bit shifts, so I am not concerned about runtime
overhead. My discussion with Johannes is more about if the complexity
is justified, I'd wait for that discussion to settle.

Either way, we should check the limits once in zswap_store().

