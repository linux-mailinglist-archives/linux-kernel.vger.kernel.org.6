Return-Path: <linux-kernel+bounces-287318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF6B952651
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335C6285A78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9213D530;
	Wed, 14 Aug 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDmvp0ms"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3439FE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679363; cv=none; b=c7/aeOcNx6fTu8kmA69FL10Ujb0piqQ70m2dv8NR0qvW5XOrU3PMJLVyk0npP4n+dijWzjL6ryRggJnuf7ljFCeCrO4af4Szeb87V5qG/oLOzcZS8v48YYnPGsSOHkeX211HRPi5oUse+DV3ignYIA2/YA3wUBDPJN3fLfRGO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679363; c=relaxed/simple;
	bh=cb/o6chSPTzdRgz6gMapK3784sGMbBBzEtc69McXxac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmjW1XcaimKEg+EQTf+/pF16lH10Y2dTveVLnwMuuEDNs61x0wwtVGaRWJ3aU84WGIvDlpNFd3TGV5MViMxpdgX+NN00/7zeo7oX32n9dw8lbJ67K9kKUV2wsli1u4cvbOQ4Ke7SOZCt73diPIxiT/rD+zeu6dqDPWoSXvMq6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDmvp0ms; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so640621a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723679360; x=1724284160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR9toIBu65OWjI9Foi4Md7PGhS/0hqYEv1lXZk/IfmI=;
        b=YDmvp0msCDVAOJiS11mwPhigpaIxIGH1SOV4MoArn+RCWL7fbgJ9lkpTCcyqzseyXx
         XbZHPBoor5XcIFn7oi8bVVoRRRMp1Kqy3LPdrfyy9FE1JnrpwiR9jlUjYBle7gV9UWZY
         aTb6nl4aL7VOUVpLZ8KC+q6/o1AtxK8zdaY09tLWYvwzeImnRXDCOhiLqg7QtD+M3o/9
         D7LIAkna3rdlo2eHEXjEt1Rw6D0psZOwSbbhQFR0gDrT2IsbeYSK+yp5VICa1k6dvxeA
         uKqbzvsadD60TV6KjvOEuYM04MdOz4QR/6dx05lvqlZMaf5yQ1UN5fYtjn1yRiGelVGa
         k2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723679360; x=1724284160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR9toIBu65OWjI9Foi4Md7PGhS/0hqYEv1lXZk/IfmI=;
        b=tmEtlBIL4rQYnCvZfZ2zQM7+Mg1ZdLRYrAAu1Uz/kxlGir9C74aF6w9bAK1zNZ+VPA
         hcmh5xJgRbzNejV5VGOFlclgPGw/0KeHmuaNbjisaJxWug6Z/b8TWBbyH+7KFVcAgIk7
         vhzgvvjgVNxSkC7TId+y6iDZzjrNV3MgnpVQ26i7rwWp1vv18yX4VF8p0kCUFjjhK4L9
         SIZf6/pP696rckW0xsES6DQoubdBlvR9Hphogxtq5M7KYvrgoKA6zRh8Uq3LtQZkVc/d
         2e4Lz6cBg6KnbgiLi5Ils0zUpsXzDXcbrPF+f3eBaio2z39vsorxX6L/KbPlNjcTqCgx
         qj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8ClzkK6s7ZD1+IsVJqIe2kRgvNLm3kLWVM1IORnmXp7+rXEpkXrUZDCZv7aUYLrRI0N4PZJhEdbYAcQx23nrmcqEPrFuxh/Jw9sf
X-Gm-Message-State: AOJu0YwhdwLxYqNRqc/ZSrFB4Eel/S1AH5K6AuGEXQ/AdSHQ7ufNAED0
	zSzhXB3mgL1kIRjQND7WnHEpNDhtn7JlSOMVj0/+tSbk8dijXH9J7h7lTuLATTniJxJ3VpgCDH7
	izxnTxVZw1Bo1eigZUEWccWpFW+a73UudEC3K
X-Google-Smtp-Source: AGHT+IFzAxfVcguQ92qXWa0puGpF0cYBqQh/zL+5WNiS/bI9UofldFxVGZQ+xQOXBxga06UZFh7sI+CLQDrboiRxSD8=
X-Received: by 2002:a17:907:e697:b0:a7a:a2e3:3734 with SMTP id
 a640c23a62f3a-a8366d4424fmr281247866b.28.1723679359618; Wed, 14 Aug 2024
 16:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
 <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
 <kneukn6m4dhuxxfl3yymrtilvjfmtkxmxz35wothcflxs5btwv@nsgywqvpdn76>
 <edf4f619-8735-48a3-9607-d24c33c8e450@kernel.org> <vyi7d5fw4d3h5osolpu4reyhcqylgnfi6uz32z67dpektbc2dz@jpu4ob34a2ug>
 <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com> <5psrsuvzabh2gwj7lmf6p2swgw4d4svi2zqr4p6bmmfjodspcw@fexbskbtchs7>
In-Reply-To: <5psrsuvzabh2gwj7lmf6p2swgw4d4svi2zqr4p6bmmfjodspcw@fexbskbtchs7>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 14 Aug 2024 16:48:42 -0700
Message-ID: <CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:42=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Aug 14, 2024 at 04:03:13PM GMT, Nhat Pham wrote:
> > On Wed, Aug 14, 2024 at 9:32=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > >
> > > Ccing Nhat
> > >
> > > On Wed, Aug 14, 2024 at 02:57:38PM GMT, Jesper Dangaard Brouer wrote:
> > > > I suspect the next whac-a-mole will be the rstat flush for the slab=
 code
> > > > that kswapd also activates via shrink_slab, that via
> > > > shrinker->count_objects() invoke count_shadow_nodes().
> > > >
> > >
> > > Actually count_shadow_nodes() is already using ratelimited version.
> > > However zswap_shrinker_count() is still using the sync version. Nhat =
is
> > > modifying this code at the moment and we can ask if we really need mo=
st
> > > accurate values for MEMCG_ZSWAP_B and MEMCG_ZSWAPPED for the zswap
> > > writeback heuristic.
> >
> > You are referring to this, correct:
> >
> > mem_cgroup_flush_stats(memcg);
> > nr_backing =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> > nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
> >
> > It's already a bit less-than-accurate - as you pointed out in another
> > discussion, it takes into account the objects and sizes of the entire
> > subtree, rather than just the ones charged to the current (memcg,
> > node) combo. Feel free to optimize this away!
> >
> > In fact, I should probably replace this with another (atomic?) counter
> > in zswap_lruvec_state struct, which tracks the post-compression size.
> > That way, we'll have a better estimate of the compression factor -
> > total post-compression size /  (length of LRU * page size), and
> > perhaps avoid the whole stat flushing path altogether...
> >
>
> That sounds like much better solution than relying on rstat for accurate
> stats.

We can also use such atomic counters in obj_cgroup_may_zswap() and
eliminate the rstat flush there as well. Same for zswap_current_read()
probably.

Most in-kernel flushers really only need a few stats, so I am
wondering if it's better to incrementally move these ones outside of
the rstat framework and completely eliminate in-kernel flushers. For
instance, MGLRU does not require the flush that reclaim does as
Shakeel pointed out.

This will solve so many scalability problems that all of us have
observed at some point or another and tried to optimize. I believe
using rstat for userspace reads was the original intention anyway.

