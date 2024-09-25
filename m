Return-Path: <linux-kernel+bounces-339569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02998670F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5211F21183
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A21459E0;
	Wed, 25 Sep 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/92CD1p"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185A145324
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293184; cv=none; b=Xsk9ERUvc5oePUVVYLfp4xDums7YH3+QeNrF6l5OI4BWJdPDNBmsYkJS3hpljD6FQPxixCU+LD6ox7bjBzZxRXqhqIQYfPlqmSg/2vEUPMPJguV0yh51P24+Zk49PVlDD+kPXaADv0Zm1anjGPoYGLDferOBhdM8BYj4KkhcElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293184; c=relaxed/simple;
	bh=BRf5FDL3l16TNNr46xYNgg62gse3t2K9YAHdsVBG9xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL1qp+sWuI46Q1QsEElW55D3A2BIVwt/d47GlSeIfFLpSXjofshKq6RrdHcpD6Mr5sluZi7Cq3AmGyMhhicZxvDJSXLq6SJ7fen08TRhsh9P70qHcLLLq21c2WvWGbiFsj1ilfHeVGAHTqdRr7j7svTqeE568i2xhGLwWS5bfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/92CD1p; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso30746066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727293181; x=1727897981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRf5FDL3l16TNNr46xYNgg62gse3t2K9YAHdsVBG9xo=;
        b=W/92CD1pK97SCG6Lc15LejBD7P0WU1cVGVnFHDyi0rKmmhXj654/JTUKK0X2mFEW70
         0k7hAsnvw1C82LkdD3OtjphatlRqVoFPU3oK3S5fH2uItcnTKLWCaXjhGcmgMQbWnUiJ
         RdVgvWE/JQCXk/jDKQyisJhXNeuj20yG+DEteVfotTsp/5kfDKGQE5BaESxqbTkizStp
         7soO+UPTZYABTi//nLczWtvl0WJ55PPgxEG1LfQp9V0dqAGtRizCf1yTCTG47VWqCw24
         mSsYjiT3oKkNAurVS0866maarqQP4+ntbxAVKJCTUXlZmtpb7zZ0DSeaffgze6ubUcMS
         o/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727293181; x=1727897981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRf5FDL3l16TNNr46xYNgg62gse3t2K9YAHdsVBG9xo=;
        b=KFnGdp33i7M/ewW5qelFWzIkswdFeOByHG3HbIM3jqP468aDO5krWeyJNCVdMOL8Tf
         YENevmRbdIa2QBDJvPCWfaAvis7VnB0qOw66cOUnYZvVb/CkuaadALVIXJxDfeT7vBiF
         6j+wJF2FHE6vN3q3ztFIiuEjaeN4mv0iVRh9ijc4Rb1vtmGvSl5xrhhjT48/5ZnAFAui
         QmjBhKFRqRvf3Us9sf8jrLiviF54qgeNTKhChk+DKw+CVsReuk1PQ2iadHDBAWVH9iZ1
         VjAU3qOu2mWXc5YkN8v/Rr27NQJCG0d0+yB6syQ0RO0wkIO3z1Je0k/7WRvvBtS5107T
         it6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr49VLddNp6k+xWSEE3Jq2oAlw310lw5tLrcUiE4qQ4LLQ09gO5g9hDwus4okYhNiR3PrgPbM5Vvlk49A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklKIgrYBGTQThuZQa1wVTh0H6i/5O7LcC6Yheb9kX7RxMTc2K
	8ZKwuHr1K/A0QTAEueFJaUTfX545MIiADWvPko/LNjYCrJzkhHVpdLSsqDKP+fm/Xx5rU0p1vJl
	3Guj8N7ENn+v4ACBXgx6w2sX7iRjCcs/PZ6/p
X-Google-Smtp-Source: AGHT+IGsm5WipEoFgkl2AHqllylYtlPz5oLoODHf4tgs9ZcjlV4TgkbXAbGUS9vIGnKjvEe+YdDhV3kbUTwueNKFDgc=
X-Received: by 2002:a17:907:7f20:b0:a8a:cc5a:7f3c with SMTP id
 a640c23a62f3a-a93a06bd943mr380451066b.58.1727293180940; Wed, 25 Sep 2024
 12:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org> <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org>
In-Reply-To: <20240925192006.GB876370@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Sep 2024 12:39:02 -0700
Message-ID: <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:20=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Wed, Sep 25, 2024 at 11:30:34AM -0700, Yosry Ahmed wrote:
> > Johannes wrote:
> > > If this ever becomes an issue, we can handle it in a fastpath-slowpat=
h
> > > scheme: check the limit up front for fast-path failure if we're
> > > already maxed out, just like now; then make obj_cgroup_charge_zswap()
> > > atomically charge against zswap.max and unwind the store if we raced.
> > >
> > > For now, I would just keep the simple version we currently have: chec=
k
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
>
> I'm not sure what you gain from making a non-atomic check precise. You
> can get a hundred threads determining down precisely that *their*
> store will fit exactly into the last 800kB before the limit.

We just get to avoid overshooting in cases where we know we probably
can't fit it anyway. If we have 4KB left and we are trying to compress
a 2MB THP, for example. It just makes the upfront check to avoid
pointless compression a little bit more meaningful.

>
> > If you think that's an overkill we can keep doing the limit checks as
> > we do today,
>
> I just don't see how it would make a practical difference.
>
> What would make a difference is atomic transactional charging of the
> compressed size, and unwinding on failure - with the upfront check to
> avoid pointlessly compressing (outside of race conditions).
>
> And I'm not against doing that in general, I am just against doing it
> per default.
>
> It's a lot of complexity, and like I said, the practical usecase for
> limiting zswap memory to begin with is quite unclear to me. Zswap is
> not a limited resource. It's just memory. And you already had the
> memory for the uncompressed copy. So it's a bit strange to me to say
> "you have compressed your memory enough, so now you get sent to disk
> (or we declare OOM)". What would be a reason to limit it?

Technically speaking if we have a global zswap limit, it becomes a
limited resource and distributing it across workloads can make sense.
That being said, I am not aware of any existing use cases for that.

The other use case is controlling when writeback kicks in for
different workloads. It may not make sense for limit-based reclaim,
because as you mentioned the memory is limited anyway and workloads
should be free to compress their own memory within their limit as they
please. But it may make sense for proactive reclaim, controlling how
much memory we compress vs how much memory we completely evict to
disk.

Again, not aware of any existing use cases for this as well.

>
> It sort of makes sense as a binary switch, but I don't get the usecase
> for a granular limit. (And I blame my own cowardice for making the
> cgroup knob a limit, to keep options open, instead of a switch.)
>
> All that to say, this would be better in a follow-up patch. We allow
> overshooting now, it's not clear how overshooting by a larger amount
> makes a categorical difference.

I am not against making this a follow-up, if/when the need arises. My
whole point was that using EWMA (or similar) we can make the upfront
check a little bit more meaningful than "We have 1 byte of headroom,
let's go compress a 2MB THP!". I think it's not a lot of complexity to
check for headroom based on an estimated compression size, but I
didn't try to code it, so maybe I am wrong :)

>
> > but I would still like to see batching of all the limit checks,
> > charging, and stats updates. It makes little sense otherwise.
>
> Definitely. One check, one charge, one stat update per folio.

