Return-Path: <linux-kernel+bounces-286530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11120951C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357B11C22752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF71B143C;
	Wed, 14 Aug 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bl/HFab3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E611DFDE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643112; cv=none; b=lMUSYDjmlGt2o4B5fjzJ25pQd0peTzUvUlH5/joKW5gpHZH3eKriKKzbyt9HI5MBN+0G2T3joFJNmmyicUKSHua+S4xiF7WSHEiy2jjB9EtOZiFLNFk5GP0wei4da8Y9wW5G8dP50Egmht5wy0bcyzZXV850o+H4I57XeN5rJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643112; c=relaxed/simple;
	bh=VOkOGS/LrtvRQAV/Z5HK+kmieatu1ugfN6RR8reyDNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsiUY/Q8+cQhGC+f1fVT7jzhSRiKK8P/XBl3M905vuSwcn0TmZKZPVPo7MPuu+e+PGT4GZl7pAsgpP95V/b9ALAvNmJGrHZkVU0Wy/EgNJoqzmbYXy5Zd7tQ9X9q0QOkeEDwWIwBGzh5qpInQNfQqcGlgjp3su3N+NU9fdAdnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bl/HFab3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428141be2ddso49036815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723643109; x=1724247909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Tm7ietP2DEbsHclGJs+zY/mhyO7abDSx+hwPgbHPxQ=;
        b=bl/HFab3DTY21+pe0lT51f7Bd41i9jJGXpx9BJ6wAx7kSNmLxqscldMTPJKM9gkxDr
         alFwxh3iQk+urC4mKxbYvXEpDGukmST3Ynuks+Spzrj7vgl7sV5sxwAfeRoYu4E1TJYo
         oPXuccj4IPrqgunDW5h+wu4x5FeZrdYWu9fvlBVTExrmb/IeHB0uoe5n1RMF8ZDyj2qs
         lehhzC7Xbrj8aO5BM5Gpn5owrNquShhOSCc96voqLScRLU0WK1C361Fon+nu9Fi6OF2D
         fg/QpmYFbj+U070dc3m5b9TJfsZ3ojIOcRQFA2IjOsN+XGmLlbASp/2WVOMjeCW4sK3C
         FWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723643109; x=1724247909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Tm7ietP2DEbsHclGJs+zY/mhyO7abDSx+hwPgbHPxQ=;
        b=v/v+0lhGl6mQ2Rx4AjGvjuCgO6LPYW6JVTM8rKwkRbWqeyFwtJLzt3dVJ85WvGRwci
         pQZshaPW6TuGzxAPLSk+2bnsNpq/ttQqDojIwZ4devL02zF+ADYyCTftFo7Az3cZ++C/
         p5Mj2Sa1H0rWcS7CE+Vbhv6ARgVbdFtsdrL0ph4KlqOX98tSFdqFMBPl2MdQ92bWCBr+
         PXsMKKzIL8LMdXIWU6Gu26V3+/1kBMLoJK4XbodigusdqA1/C29OPm2sW21krqiqLorE
         HbCyc6dMLo8Istxwk85KVuzFcEkgyvq/ZIvEV2jZhQshD5YQIoyFCwtl0JQSH3wHpIwd
         JDdA==
X-Forwarded-Encrypted: i=1; AJvYcCWtx0h10t8DfK/TQTucXXMU6h4YPOHpnOBzBycQjJNpvVNpeyhUxuTaj0ZMSvNQCJvBFNHAb7ykE2s7yC7ywQzguUWUnkv9nFPSh284
X-Gm-Message-State: AOJu0YzytFUMURr2P33NMzCZJ3HuD4bryqwmnP+zYp4OMoApEyVI7qcr
	VImW5dD7Z2pJuGR25Avqbdw0lT5ywLvtBrXSxDZNtPdV5cuY2Dyrq4ZgykCbAtvnMcRQBHG2tp3
	iT+C9ftXr9oaz0Gkl4lTQXOaMryZdqWUlnm1W
X-Google-Smtp-Source: AGHT+IHQij7pFO3R9kwgjAYPf6467NH0BDlaDCLUFTSKxJTM2pMmM4ro5SVAftofS/83QLU/Ih24zY/k2aFjkewsXVo=
X-Received: by 2002:a05:600c:1990:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-429dd2374d5mr22536475e9.13.1723643108692; Wed, 14 Aug 2024
 06:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org>
 <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com> <Zryy04DvEsnxsRCj@pollux>
In-Reply-To: <Zryy04DvEsnxsRCj@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 15:44:56 +0200
Message-ID: <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com>
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Aug 14, 2024 at 09:51:34AM +0200, Alice Ryhl wrote:
> > On Mon, Aug 12, 2024 at 8:24=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> > > typically used for objects smaller than page size.
> > >
> > > All memory allocations made with `Kmalloc` end up in `krealloc()`.
> > >
> > > It serves as allocator for the subsequently introduced types `KBox` a=
nd
> > > `KVec`.
> > >
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/helpers.c                 |  3 +-
> > >  rust/kernel/alloc.rs           |  2 +-
> > >  rust/kernel/alloc/allocator.rs | 63 ++++++++++++++++++++++++++++++++=
+-
> > >  3 files changed, 64 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > index 92d3c03ae1bd..9f7275493365 100644
> > > --- a/rust/helpers.c
> > > +++ b/rust/helpers.c
> > > @@ -193,8 +193,7 @@ void rust_helper_init_work_with_key(struct work_s=
truct *work, work_func_t func,
> > >  }
> > >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> > >
> > > -void * __must_check __realloc_size(2)
> > > -rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> > > +void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t =
flags)
> > >  {
> > >         return krealloc(objp, new_size, flags);
> > >  }
> >
> > Why are the various annotations on this helper being removed?
>
> rust_helper_krealloc() is only called from Rust, hence neither __must_che=
ck nor
> __realloc_size() should have any effect.
>
> I also do not apply them in subsequent commits for the vrealloc() and
> kvrealloc() helpers for this reason and removed them here for consistency=
.
>
> > This deserves an explanation in the commit message.
>
> I can also add a separate commit for that.

I think your change would be more obviously correct if you keep them.

Alice

