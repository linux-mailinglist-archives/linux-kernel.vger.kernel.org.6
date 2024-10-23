Return-Path: <linux-kernel+bounces-378624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DD9AD357
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4740F1F21AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47E1D079C;
	Wed, 23 Oct 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tq0VON76"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E141CFED4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705958; cv=none; b=js+PN5U/Fhd2nnufdJLYCoaeX6RoPWKOmYzYAWDKhKiFev1LRqFYcfQrj9pRTkQqvmE8bYwGxSa5B6sIriZ9YJ0/drA1HRUUCUd1gem5cYDkGgmM1uCC5vL4F1sueHrPGXyqIEdEDcCoMPQG+Cp3lIsxqwa0oeVqd9YukX4Z1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705958; c=relaxed/simple;
	bh=A5+8sBlIb1ZNt44ESdYFCJS7xJRUZ00NTJDcHm6uh7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNzJON8Mle6JDMh7TDknKxZbuyytPDLmHft6s/Ya7EWqmuk40WgCBAM90OHo/npEOPVldcup5seui9lsyYInPYmXvqZquaYOi84d8P1wgtZtpBqhUiHPF3iorks7D/4HNvctYMms5qf/Ligq4Lyl6+bIRtBFCs0SBzsss2+eHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tq0VON76; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so5327689f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729705955; x=1730310755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBqgi4VDMBAlTqVP0H5QHEUKjlARJMIz3uADQ7P28XA=;
        b=Tq0VON76vc1MO1XmGylPhsEG5TE9svckXO23GDAJedArDuktEJrHz+zgoAeeF9ATEN
         R8jhM0Rywp88rIE92Ij6ERZVzAMxA7GEvBflaUq8cxMQ8zPvAhSdbFWpxsPqh9RGcU4L
         l62IagQ30Nuhrc4l58VdVtBaxZFFpufiv5w+AE3Cus2nVL/jWW+n+Kuf/Rxahoof1bff
         e61U95699BIT70CND2hz6eQZ2kHu3BJr+bApKdx6GWgd/z6KUc3uDuPwnop1pQf0aMGr
         vM8RBkGeMpOeL0o1SiFZDw7SP/VgolyGNkp4lnUKjEIHdNYC1bFzYD8iTe/+SzccMvMR
         PQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705955; x=1730310755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBqgi4VDMBAlTqVP0H5QHEUKjlARJMIz3uADQ7P28XA=;
        b=o0fBJMhpibcK8T3O7SsNhOZSRrijCNdfRE3wh8g07sy/gjryLo2E/ZEereGwC+fpx1
         juqMGiSpknY4DYQpHOORNrwkN6Hc77BuLb4OZBlvH5awTghlJnRtYk69zUQJHI2DatDM
         bmrR952v33ohv1TCssJmooyVmHXNFuUhtyaIeMU8O6mqf6tXOy4WKT5111m6xmiXA4aE
         +DbhkbLcY3RuPYGaQ/GcqmX6qTzUBqRxw00vvkIMkLsFi/1QpmTv2eRd80buaNGC8vS1
         01eYpBactCtNykmLctGeRjt8GSergr5oI4eDhXMDLQv6An4clCQmGpT4cl76URdthnBS
         ZfZw==
X-Forwarded-Encrypted: i=1; AJvYcCXPcwVCnGJsaOySBjary8G5XovjJf9yDdRnDmR307UNa/oxNcOcMCkyHGpN3c/SX9l7d2/xn27xpnW98bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56iWd3UHBSdLnC+ephkXy9u5CmQTiXAGnCaYPB0h5XnmUmBGP
	xmQY2lISAdBKI3vevEIK+Qg666z4VXlr3a75e5yDgAfaKpJL6gn7m6KHMurtqzLHFU1QduZM1sx
	zfzmK1j1Jaw7YQdc4+h4RtI382AWLZ0RCxb5M
X-Google-Smtp-Source: AGHT+IHEC6RrPWVdwE47hhc5ylIuECiJjw7EVoXZWFa5G2Oz6TMdW+KOd+xue2n1r7s3mpRvAX/96gXO6gBmsrjuPVY=
X-Received: by 2002:a5d:5223:0:b0:37d:33a3:de14 with SMTP id
 ffacd0b85a97d-37efcf00deamr2275403f8f.7.1729705954866; Wed, 23 Oct 2024
 10:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-2-abdiel.janulgue@gmail.com> <CAH5fLgjZ91xFo4hV4dPnDXLFr9jX3na60tVt_KuNU_c6WhhzAA@mail.gmail.com>
 <b154dd13-8cd8-4066-ba3d-6597959ca5c5@gmail.com> <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
In-Reply-To: <ZxkPC-dLRBqBKZ5J@Boquns-Mac-mini.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Oct 2024 19:52:23 +0200
Message-ID: <CAH5fLggEGMVspJoO6CE-gTa3-OHfkUnS=L1X-VNC8Cp57GYVkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: types: add `Owned` type and `Ownable` trait
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	dakr@redhat.com, linux-kernel@vger.kernel.org, airlied@redhat.com, 
	miguel.ojeda.sandonis@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:58=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Oct 23, 2024 at 01:26:14PM +0300, Abdiel Janulgue wrote:
> >
> >
> > On 23/10/2024 12:28, Alice Ryhl wrote:
> > > On Wed, Oct 23, 2024 at 12:49=E2=80=AFAM Abdiel Janulgue
> > > <abdiel.janulgue@gmail.com> wrote:
> > > >
> > > > Add the 'Owned' type, a simple smart pointer type that owns the
> > > > underlying data.
> > > >
> > > > An object implementing `Ownable' can constructed by wrapping it in
> > > > `Owned`, which has the advantage of allowing fine-grained control
> > > > over it's resource allocation and deallocation.
> > > >
> > > > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > > > ---
> > > >   rust/kernel/types.rs | 62 +++++++++++++++++++++++++++++++++++++++=
+++++
> > > >   1 file changed, 62 insertions(+)
> > > >
> > > > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > > > index ced143600eb1..3f632916bd4d 100644
> > > > --- a/rust/kernel/types.rs
> > > > +++ b/rust/kernel/types.rs
> > > > @@ -429,3 +429,65 @@ pub enum Either<L, R> {
> > > >       /// Constructs an instance of [`Either`] containing a value o=
f type `R`.
> > > >       Right(R),
> > > >   }
> > > > +
> > > > +/// A smart pointer that owns the underlying data `T`.
> > > > +///
> > > > +/// This is a simple smart pointer that owns the underlying data. =
Typically, this would be
> > > > +/// returned as a wrapper for `T` in `T`'s constructor.
> > > > +/// When an object adds an option of being constructed this way, i=
n addition to implementing
> > > > +/// `Drop`, it implements `Ownable` as well, thus having finer-gra=
ined control in where
> > > > +/// resource allocation and deallocation happens.
> > > > +///
> > > > +/// # Invariants
> > > > +///
> > > > +/// The pointer is always valid and owns the underlying data.
> > > > +pub struct Owned<T: Ownable> {
> > > > +    ptr: NonNull<T>,
> > > > +}
> > > > +
> > > > +impl<T: Ownable> Owned<T> {
> > > > +    /// Creates a new smart pointer that owns `T`.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    /// `ptr` needs to be a valid pointer, and it should be the un=
ique owner to the object,
> > > > +    /// in other words, no other entity should free the underlying=
 data.
> > > > +    pub unsafe fn to_owned(ptr: *mut T) -> Self {
> > >
> > > Please rename this function to from_raw to match the name used by
> > > other similar functions.
> > >
> > > Also, I don't love this wording. We don't really want to guarantee
> > > that it is unique. For example, pages have one primary owner, but
> > > there can be others who also have refcounts to the page, so it's not
> > > really unique. I think you just want to say that `ptr` must point at =
a
>
> But then when `Owned<Page>` dropped, it will call __free_pages() which
> invalidate any other existing users. Do you assume that the users will
> use pointers anyway, so it's their unsafe responsiblity to guarantee
> that they don't use an invalid pointer?
>
> Also I assume you mean the others have refcounts to the page *before* an
> `Owned<Page>` is created, right? Because if we really have a use case
> where we want to have multiple users of a page after `Owned<Page>`
> created, we should better provide a `Owned<Page>` to `ARef<Page>`
> function.

The __free_pages function just decrements a refcount. If there are
other references to it, it's not actually freed.

Alice

