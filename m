Return-Path: <linux-kernel+bounces-314758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C496B80D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD91CB23581
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848FA1CF5DC;
	Wed,  4 Sep 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quOWyWhm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C6126C08
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444940; cv=none; b=kt832nvpEp22J111EFbM6a4p/q3KWwkWwquCJKkF4xTgsorfZZpuzSj7NeKkVob99RJwuHdxwnk+1ezohZCfVWCushs84ckF6E0HYFJ5smxJyuKc7Nw/ZKabjsKzz7Le0wMrFmekuqRiUy34IHIY+HW/UHf81O/eVosUlNO2rt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444940; c=relaxed/simple;
	bh=wMRgd+zwB0aXoTGxwXzh3t2qA3Lqhwut8iVdWmvlx8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI/uigxYkaCmkR9vlxtepH29U2vAbUrWLTUaeyavp222iWOrw/hDjlkgqixzVq9tyaoa5EChKqWfnafQ65yJ3BksyrX0q10BiykvDCMKG96a0lfMbdAVh6VNHRl7OR+pYWKgKYHPPt2/EoXYka4zUzqWi0R9XfGfwuLT2FThK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quOWyWhm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so43754375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725444934; x=1726049734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpjVKN5cWQhj45jb1EGlvgKVJ/zrno7xEZ0+EzIrPcA=;
        b=quOWyWhmGBln/H0u2I6G6WBgqWiWlNoGxPRjIh1VqjR7ubNhHDhWbfECy3+F8ckrPG
         pFsIyvelG5xI5QG3Bo9O/iJeOdtClhKXQDoi2/ZsO+175ip19rfyClRfWqNWGAklQsmg
         O9i1jObq+/mS0RXsnCQNPPnSPDWNsOyOi5gduumIC/PxXkWGdb7nXo3i1dln+3M4IfjC
         F9/QBUYwNrcFl/0XiCHhttItnZz5PJgdMI52+GuGVM8JqxK47SLgsMdC+EGJtMQxkgwE
         qq2RviTRkf4BNYF4qO8tnDVshwCcA9cAvUJmba+O9QHSCFCK9kPh9gI5UUWof3SAqpZT
         XplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725444934; x=1726049734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpjVKN5cWQhj45jb1EGlvgKVJ/zrno7xEZ0+EzIrPcA=;
        b=UR5B59MDfK6ZYk9vdpLE/65mP1USJyOQstImJnUxdF1L5pdpVzFNGPcNtqvo3WVFcX
         gB5RwVpUrCr2GKyvv3U+D0m+3gQ5yRuq1SgnXTAP6DkoC9NvxEPVOa8dMulf24O0wx5L
         MwOa70VUGkkm/8t6EXr01SFvyieWx058BXG2Vr/mjbGqtjiEEKKXY3ExYnw4tsRbM0/3
         nDuEPn2xuOOLVurX+Ox1uQBt9qqFUHQH+HC4rD5llT95N7sVuUML757ZxhNbX8Bfz4tU
         sdcJLuT/U0ifjsZFIT96f7YhQFJNeTx72lQGIs47pdciU+meZW2Pp8q6N3AMRUNLN6qL
         g7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUG1rHS6XfHBo+VcSoY8WRhzlOTbxV6AcB8ze9NuscSRPI66a2ELakJk4oYwOiYP2RdIFDw6+RBf4LGo88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78PmYcc9VcNgz47AAZbuBKvHRAhkU/6TreqfE4ElvarN3hPQ+
	+OZTJKJ0lTVC5WwZjrzghrtf+mM6eZgJ3uL+hluJNmM6ZmDviaXxhGHfuzq7oS9pIBJKD706DOq
	gvPnAcE5SkF/RQR+xe762xohUpGmVozMUL2d/
X-Google-Smtp-Source: AGHT+IFvgcolurGoupUJmeWy+d85GiYNEpCVqFra1ZIgUnTNUb7A0YTAJ4BFYzV8MAI5ROTmbcvMlPgqAZlqbhn09Pk=
X-Received: by 2002:a05:600c:3509:b0:426:62c5:473e with SMTP id
 5b1f17b1804b1-42c8de9deb8mr25799725e9.26.1725444933762; Wed, 04 Sep 2024
 03:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-27-dakr@kernel.org>
 <20240831135712.0d7366b6.gary@garyguo.net> <Ztb6_XW3ccnHQDmw@pollux>
In-Reply-To: <Ztb6_XW3ccnHQDmw@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 4 Sep 2024 12:15:21 +0200
Message-ID: <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com>
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc` module
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Sat, Aug 31, 2024 at 01:57:12PM +0100, Gary Guo wrote:
> > On Fri, 16 Aug 2024 02:11:08 +0200
> > Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > > Add maintainers entry for the Rust `alloc` module.
> > >
> > > Currently, this includes the `Allocator` API itself, `Allocator`
> > > implementations, such as `Kmalloc` or `Vmalloc`, as well as the kerne=
l's
> > > implementation of the primary memory allocation data structures, `Box=
`
> > > and `Vec`.
> > >
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  MAINTAINERS | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 42decde38320..560516b3aaf4 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19925,6 +19925,13 @@ F: scripts/*rust*
> > >  F: tools/testing/selftests/rust/
> > >  K: \b(?i:rust)\b
> > >
> > > +RUST [ALLOC]
> > > +M: Danilo Krummrich <dakr@kernel.org>
> > > +L: rust-for-linux@vger.kernel.org
> > > +S: Maintained
> > > +F: rust/kernel/alloc.rs
> > > +F: rust/kernel/alloc/
> >
> > It feels like we should use `mod.rs`.
>
> The same would be true for:
>
> - rust/kernel/sync.rs
> - rust/kernel/net.rs
> - rust/kernel/init.rs
> - rust/kernel/fs.rs
> - ...
>
> Do you propose to change it for all of them?

I do actually think `mod.rs` is superior in general, but it's probably
not worth changing it right now.

Alice

