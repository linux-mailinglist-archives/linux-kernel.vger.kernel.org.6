Return-Path: <linux-kernel+bounces-287352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23C9526D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10C8B211E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF518D628;
	Thu, 15 Aug 2024 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMeintoi"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDEA32
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681394; cv=none; b=fyMKUBLCK1N6972tU3tSnJh0KjdTs6YzRLGWeigk4Eo9+j8CxuDwwmrr428P8eet+2hScVizcm0PM5APpK5Q/BfrP2nXGu0szG0Smoc/PqVLZJC2IZ2bmi/ziJL8sKRKhrpldYD8xJZxYNyobq2s/wlmeqTubMIJf+TSUVi5vRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681394; c=relaxed/simple;
	bh=Cw5dTcrztz9RxH0G8Zi6diIKTPcCBLS7HGD6iPgP970=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRrxZqsJxWuekLUo+dbRJh0pB3ecK+h9GYFA1cYMqGw0cZc0qXCA0YKoakYv+M75P7zCmMn1FjH2VJOrjH53SpAHluSgCtZFXLSqpqe8uv4MkI5nbg/Qa1IDd+40WX8vAR7o17Ax72e1ib6M8KvYdTeNnFMxBlMty1t26Ppb008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aMeintoi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so490471a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723681392; x=1724286192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw5dTcrztz9RxH0G8Zi6diIKTPcCBLS7HGD6iPgP970=;
        b=aMeintoiZPJW5ahLtBXM0iTbq12UV+IcakjFFPczg4x1yrbXS/7SKvwbK0/3BgGwtk
         O5mszJk9VAHphOdZXEkEddYfYKQ1/nwML/OuAgczqAjbXM1EzVHegX8ZlE0SBdrMFDR4
         j97k6eB2QGmQLtPdTmVDkrUmD18u5KBlygM1GO1FGGPRGelrGGT2eMPpUlYt+4xldJBz
         MLI100NYrX4rW6ZiGaBrutZFZokzNbv0Blgfvy+yH+gczVsYc1Wrhy0spjM5EeaOYqyR
         6RE7/tH3h8QioEMmUayRH3+8mEnbyYTcmMDBhCvK+8YoYPmoNiKIbyegQeeutoyoyWAR
         thIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681392; x=1724286192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw5dTcrztz9RxH0G8Zi6diIKTPcCBLS7HGD6iPgP970=;
        b=E79NO1G4HHTgXoy4ByWHCLVFzdWcqEZb32RFFXSwN392PCyQFWp+4hn08XV9JZ+6AP
         XgJZlQsf7YBtKilC01/rrdjZm7aZtt7cUSXY1Ra9BmXjYXFH5y+BMPbzl4qG9jYipKAb
         qxHgxhnk20TwrbWSQYHwUgIdBdjQjrvaEVlXgr8xTsi5KPexMMLfNwjvzzwCsBIRZVJO
         dEY1rC8Zs7VjXwBZkrPTXxA1DWSewdQLhcSTYDqMjiMAicFJziftX+yCqh9aar6aPrs9
         orGQGc7tM1w6RCKXo4ykQh90o1anVFdaadpTpFLn/JfD92M4rq/HLS/kAD3wY3GUIR/E
         FkWw==
X-Forwarded-Encrypted: i=1; AJvYcCX1NdNAop5G0kdyby4t1kR9XUGBeDEeR2c+e52f8iPdImECCjZqoFH+v7i37StGvmBHU1M7xAz5sWoY1is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NYbq8+Ov6NM8fj2nex/SuuX650mA/271Vc6vxVPs3dZwVLyO
	OV9CEAlq13G/fBAD9NtjDD1M+OzjGwgESWc82/iEbVuwEsanJ+ftrwStEufFYfvkjhLzcfQ1S8Q
	ITNO3cD9jA6tZ1AfYDwqfkQYkZLSJVtVvDa/e
X-Google-Smtp-Source: AGHT+IFC8o5Im21DbR7Qp6xSk6tS/o5FfXLkW+ffmjOKbSdKahoh7dxx/T2U9kLhB/4n9tKpI7wufDxH7YS9G+dYQZA=
X-Received: by 2002:a17:907:d2d3:b0:a7a:8bf9:a6e8 with SMTP id
 a640c23a62f3a-a8366d5bcf8mr350627066b.35.1723681391168; Wed, 14 Aug 2024
 17:23:11 -0700 (PDT)
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
 <CAKEwX=Mc9U_eEqoEYtwdfOUZTa=gboLtbF5FGy4pL--A54JJDw@mail.gmail.com>
 <5psrsuvzabh2gwj7lmf6p2swgw4d4svi2zqr4p6bmmfjodspcw@fexbskbtchs7>
 <CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com> <CAKEwX=M7sWx94nJ0zK-46Xn8ZZHhcHQtb37qR0Jxit+8sAaQWg@mail.gmail.com>
In-Reply-To: <CAKEwX=M7sWx94nJ0zK-46Xn8ZZHhcHQtb37qR0Jxit+8sAaQWg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 14 Aug 2024 17:22:33 -0700
Message-ID: <CAJD7tkZW8OYrEHkuONFt4wGiYSAsyVsA30zroOxc=opi5r5iBQ@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
To: Nhat Pham <nphamcs@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:19=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Aug 14, 2024 at 4:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> >
> > We can also use such atomic counters in obj_cgroup_may_zswap() and
> > eliminate the rstat flush there as well. Same for zswap_current_read()
> > probably.
>
> zswap/zswapped are subtree-cumulative counters. Would that be a problem?

For obj_cgroup_may_zswap() we iterate the parents anyway, so I think
it should be fine. We will also iterate the nodes on each level, but
this is usually a small number and is probably cheaper than an rstat
flush (but I can easily be wrong).

For zswap_current_read() we need to iterate the children, not the
parents. At this point the rstat flush is probably much better, so we
can leave this one alone. It's a userspace read anyway, so it
shouldn't be causing problems.

>
> >
> > Most in-kernel flushers really only need a few stats, so I am
> > wondering if it's better to incrementally move these ones outside of
> > the rstat framework and completely eliminate in-kernel flushers. For
> > instance, MGLRU does not require the flush that reclaim does as
> > Shakeel pointed out.
> >
> > This will solve so many scalability problems that all of us have
> > observed at some point or another and tried to optimize. I believe
> > using rstat for userspace reads was the original intention anyway.
>
> But yeah, the fewer in-kernel flushers we have, the fewer
> scalability/lock contention issues there will be. Not an expert in
> this area, but sounds like a worthwhile direction to pursue.

