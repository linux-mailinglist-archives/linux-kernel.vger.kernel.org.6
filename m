Return-Path: <linux-kernel+bounces-339521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4598664F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC931C2272B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277078B50;
	Wed, 25 Sep 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tABxU0Ny"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EA4D8BF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289074; cv=none; b=F1XwS8ZsKQ1wLS9uelmdg/pgEUdhRdzzAAGfam5wn7hBZF9pOKBfF5bgB/hv9tWZefUvKyU9L74dC4iivEyD+L3DymPFCOEAYpvd2nAk/iqnvy1cyWxa3zKyh79Bt/T/KTMqSeBIl+LPgixFAUUzrZ54Acr10UvHR8dYsvFgyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289074; c=relaxed/simple;
	bh=LYdLXSUrJXRDqqcpEE1+1SQR8ZanTN9oiSk3QKCSDTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaIFKu5zyl25x1dyv0nBT3M+VfH3QXuA8Wbnh0P4ZVZcJAzHJL1DIAirhKL7Snsl3MfWDYY5awRhClGPmH3oaRlX/Ne7zAXGTwhXdACf5pLSV14L4pwrPzY9lDrkolLEPn0elGAB2u8236y3WbMHQer5B3uvJ8u2IungWCPx9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tABxU0Ny; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8ce5db8668so23976966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727289071; x=1727893871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6+i/7mcDfuzEJiw3xSsDAEL4FTrEvTwh7sTExEl5Jg=;
        b=tABxU0NyHEds7SvociGZYHvKh6h60F3tAEQHoZYqExr8MGWI1U4j7vR3pFhLLNBquO
         Wb+9b4kaUNHTfGNVw92GC1G8cf7n2GNnRUhGq8GOI7vL6E8rd6c3H/8nCUkXjdt5p38a
         V0nINnQMMoD7NqDUNq1ZfFPK1H/KCapmJQ+AhRU2MWr3yB+v3GDfBmAtL4Dztr8sqYdJ
         4LqCkcvdTugCIx880BE0aI+8EBLV3QVUZz3iWWyKPIb4fHnPZ8dgq3UWwf7MLpyolNUl
         pWwTrpAsFzcVanyrAW8w+TEtp+U+CiCXS5PWi8/ODSHS7sv5/HET6okCs+zTMQABr5+m
         /dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289071; x=1727893871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6+i/7mcDfuzEJiw3xSsDAEL4FTrEvTwh7sTExEl5Jg=;
        b=IGcC2fw1B8v/VJaTNwgOrP2dJsGF26Ih1TFJzfwc3VKHP0ojZ916jP450a+dcWsMBw
         Y1TH2IycEhJjlgrXiPmSVjWHkkpCx5fOtQjrElZ11cFE45N+yP9gVYvL5v8ILRYN8xL9
         Hhec1nIDWlA940148UtYxqyog0dLN5z244jS2sUANKdA/WnPjGLLyRoj+ikrbXu/T2an
         2lLq4EJ9TBH5Uxe9cp9kQe3khMQcrHmdnte3rgNpcn9ZYydwcgKLsH5lzrakeP133s7O
         kNTh7xNrJrwj0anvH8qBWzfSo3Wlu2x2wFsmD5OkmkXNG4egxzIyW1Gbdww1RTan9Wl+
         V8ww==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZE/eKaXmJ3QZOo8NGt5qkeTEA6rebjhTZHA4FeIFjYKxo84UFUyzAxPosV6wNkf5lHZ1Y4cNEo37KpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9m3NfckBDwe/Gow8kA7XCKibj8LzoQbXJQ8tCAnyp9mEFzu5a
	KV1K/YpbMtNL1XNfSqj0Da1nLl3v7wwoNHP/XBCPnE7JBTszAodVPl9qcIKngDaaD1qx9N72rbL
	IxctGe7bVwuTIdwQ1JjO0gqQrDf39DgpETyiN
X-Google-Smtp-Source: AGHT+IH0U/Sj/v3RDFLKDFGHHDOUO1yFKD7gU9F+YCdLZqdw2Vcxx9QjbEcC92mesiGInr9j/gAI39Tn6vVe50TjVNA=
X-Received: by 2002:a17:907:3d8d:b0:a91:158a:a900 with SMTP id
 a640c23a62f3a-a93a069bf67mr391239166b.58.1727289070910; Wed, 25 Sep 2024
 11:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
In-Reply-To: <20240925134008.GA875661@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Sep 2024 11:30:34 -0700
Message-ID: <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"

[..]
> > > +       /*
> > > +        * Check cgroup limits:
> > > +        *
> > > +        * The cgroup zswap limit check is done once at the beginning of an
> > > +        * mTHP store, and not within zswap_store_page() for each page
> > > +        * in the mTHP. We do however check the zswap pool limits at the
> > > +        * start of zswap_store_page(). What this means is, the cgroup
> > > +        * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
> > > +        * However, the per-store-page zswap pool limits check should
> > > +        * hopefully trigger the cgroup aware and zswap LRU aware global
> > > +        * reclaim implemented in the shrinker. If this assumption holds,
> > > +        * the cgroup exceeding the zswap limits could potentially be
> > > +        * resolved before the next zswap_store, and if it is not, the next
> > > +        * zswap_store would fail the cgroup zswap limit check at the start.
> > > +        */
> >
> > I do not really like this. Allowing going one page above the limit is
> > one thing, but one THP above the limit seems too much. I also don't
> > like relying on the repeated limit checking in zswap_store_page(), if
> > anything I think that should be batched too.
> >
> > Is it too unreasonable to maintain the average compression ratio and
> > use that to estimate limit checking for both memcg and global limits?
> > Johannes, Nhat, any thoughts on this?
>
> I honestly don't think it's much of an issue. The global limit is
> huge, and the cgroup limit is to the best of my knowledge only used as
> a binary switch. Setting a non-binary limit - global or cgroup - seems
> like a bit of an obscure usecase to me, because in the vast majority
> of cases it's preferable to keep compresing over declaring OOM.
>
> And even if you do have some granular limit, the workload size scales
> with it. It's not like you have a thousand THPs in a 10M cgroup.

The memcg limit and zswap limit can be disproportionate, although that
shouldn't be common.

>
> If this ever becomes an issue, we can handle it in a fastpath-slowpath
> scheme: check the limit up front for fast-path failure if we're
> already maxed out, just like now; then make obj_cgroup_charge_zswap()
> atomically charge against zswap.max and unwind the store if we raced.
>
> For now, I would just keep the simple version we currently have: check
> once in zswap_store() and then just go ahead for the whole folio.

I am not totally against this but I feel like this is too optimistic.
I think we can keep it simple-ish by maintaining an ewma for the
compression ratio, we already have primitives for this (see
DECLARE_EWMA).

Then in zswap_store(), we can use the ewma to estimate the compressed
size and use it to do the memcg and global limit checks once, like we
do today. Instead of just checking if we are below the limits, we
check if we have enough headroom for the estimated compressed size.
Then we call zswap_store_page() to do the per-page stuff, then do
batched charging and stats updates.

If you think that's an overkill we can keep doing the limit checks as
we do today,
but I would still like to see batching of all the limit checks,
charging, and stats updates. It makes little sense otherwise.

