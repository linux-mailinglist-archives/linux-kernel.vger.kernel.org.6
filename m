Return-Path: <linux-kernel+bounces-407160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8ED9C6982
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184CF1F23D59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB017C992;
	Wed, 13 Nov 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KcFNJ+b"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F417624F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480760; cv=none; b=uB+4r2EqaREnqgvLsG0LUqDEw556do08HxNNkJDkhb0JubaZ4eVH6pcFC7CD+D4RKpeij+gPCpJ8uBUMo8IzNhRmvi5Wxub1+5QaetrYp0cIgtW6nJjgQyxAArqC/wkbz1M7NexGzvEEIPEFdxHdMUkLtKklgWpzelDAXy8qq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480760; c=relaxed/simple;
	bh=LwqiW9qJSlLHyTtWmYjgORsQC1OX5FX1F9yNKdjBNjc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EyryH8yCwerrlThXkq4xPG25xJDfyYRuxhpIFWJgMC3GlnUeB4zYWxeMGJHRVN1BZhi3SEDBDlUuOwWpdIPoRGBEHUn3vdI1CwiJTd32Tz5fOkqwVfrW/tSgiKM+M2gOVj6ipnXQAS2jiN0NoU8/6KwAKQFEWoYz7khD3tYojek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KcFNJ+b; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f533e1c2so4099855b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731480757; x=1732085557; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGhFZqKZR/ZhRGabJrEH+0qwfjhlpjiKCYeavpG2VVE=;
        b=4KcFNJ+bMp1LQHyiYmC9du5WrzEi+MRTAOV8zzWiVTxMTKlky6zBOAEJpK8+nvK4XG
         T6Ht5sF4cyvdQFnp+qWzrJbgsiTAuPJCPXr1j/m+tFbeVPA06lAx+Yjz4FHkGXougqG1
         JFQIEFGl3hbvoxIPnLwv/cLOT0+mVXJhBgBBph9CQqvWWmg4fiNLtGgdLhe16WXO1ISY
         yJek/DG3MdSO1ctx1RCmhuDoCq2qckGzMD416ZSo97sJbb3TyTPQ1JTKfTClwyEjO6Ti
         fqbPVJJeFijxlNvMeVa1SWcuwo4u621WSB+FawxMf5dECt2sa+kofQTURNQ1IeUgR0Ch
         LhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731480757; x=1732085557;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGhFZqKZR/ZhRGabJrEH+0qwfjhlpjiKCYeavpG2VVE=;
        b=g3WPrSdOsO4hRGxgWw2uSDFc6p22jdpaCa5YmLUJ2q0b2yvVxcHio/+IkMpCSbpqfK
         c1XYZm7yRisZt0R9VQhCuRebWjrBxdhV5bt1O9eLON7Pt5kgmcCdmN022JrwuLyFFmwq
         x0StyeRX/nH7FjxiBoC7l7zmZ3T6wMamLB1hy+nKaOvFp10pQD2cHKuo2UOTRA5tDK7R
         9QB0tOJd9h11xCjwk1OOnQW/Gk+mHV6yN6evTqa3AgU+gX1vq5EmvYaz+WdgXtZ4o0pD
         tUTvK/+GxciUYQ9PPEYbdmCM9TBtqSijYapP2manLNMso6PK4yA/0PMYw5fZYQQb/ymf
         JODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfcXUcOfl9CwBThzjSA3PmVtC/nG+JAb1Ljt3Iep+pJeyE/Gnqv2rvMpy66SDJhFj/5uGWslCLb6nMLhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPkJaqPKMW1GvkWLmCUnYkRPZnvpYiA/CTIjw2PtA0pKWQYk8
	vn6sFTMwoK5v1c4pGvBi+D7uYAKESu84lH2YtVhGwS/hmLeDfgqlSfkaprnvrQ==
X-Google-Smtp-Source: AGHT+IHdFbj5No4qa+yCdLxViIJNf9IDXVZV0S8fnMlAUmokHxO5o/bcmslNN/vBlSeSBSYRaX38aQ==
X-Received: by 2002:a05:6870:e99f:b0:277:f301:40d5 with SMTP id 586e51a60fabf-295602f1396mr16219291fac.31.1731480757477;
        Tue, 12 Nov 2024 22:52:37 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a60079dc4sm344747a34.56.2024.11.12.22.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 22:52:36 -0800 (PST)
Date: Tue, 12 Nov 2024 22:52:24 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Suren Baghdasaryan <surenb@google.com>
cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
    willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
    mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
    oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
    peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
    brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
    minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
    souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
In-Reply-To: <CAJuCfpEG7hhh+mHbZe_9duk2kbFvv_NeGfBqw0JBxiHK-9yWxQ@mail.gmail.com>
Message-ID: <54394536-da24-d01d-e4a7-2ece22b1ddab@google.com>
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com> <CAJuCfpFd2_7q6pi1=G9B0VW5ynCWhkkDDA3PU293FPtT_CcBQA@mail.gmail.com> <6d0c5c2d-2963-489a-2376-8edaeb064de3@google.com>
 <CAJuCfpEG7hhh+mHbZe_9duk2kbFvv_NeGfBqw0JBxiHK-9yWxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-550729047-1731480756=:2748"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-550729047-1731480756=:2748
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Nov 2024, Suren Baghdasaryan wrote:
> On Tue, Nov 12, 2024 at 9:08=E2=80=AFPM Hugh Dickins <hughd@google.com> w=
rote:
> > On Tue, 12 Nov 2024, Suren Baghdasaryan wrote:
> > >
> > > Thinking about this some more, I don't think this works. I'm relying
> > > on vma_start_read() to stabilize the vma, however the lock I'm taking
> > > is part of the vma which can be reused from under us. So, the lock I'=
m
> > > taking might be reinitialized after I take the lock...
> > > I need to figure out a way to stabilize the vma in some other manner
> > > before taking this lock.
> >
> > (I'm not paying attention and following the patches, I just happened
> > to notice this remark: forgive me if I'm out of context and have
> > misunderstood, but hope this might help:)
> >
> > But this is exactly the problem SLAB_TYPESAFE_BY_RCU was invented for.
> > You just have to be careful that the locks are initialized only when th=
e
> > slab is first created (allocated from buddy), not reinitialized wheneve=
r
> > a new object is allocated from that slab.
>=20
> Hi Hugh!
> I'm looking into SLAB_TYPESAFE_BY_RCU implementation and trying to
> figure out if initializing the lock in the ctor() of the cache as
> mentioned in the comment here:
> https://elixir.bootlin.com/linux/v6.12-rc7/source/include/linux/slab.h#L1=
27
> would help my case. I assume that's what you are hinting here?

Yes, if I'm "hinting", it's because offhand I forget the right names:
"ctor", yes, that sounds right.

Just grep around for examples of how it is used: there must be plenty
now. but anon_vma is what it was first used for.

But given the title of this patch, I'm surprised it's new to you.

Hugh
---1463770367-550729047-1731480756=:2748--

