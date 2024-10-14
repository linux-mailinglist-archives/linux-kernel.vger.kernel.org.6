Return-Path: <linux-kernel+bounces-364783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36A99D94D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DD9B20CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747461D1F73;
	Mon, 14 Oct 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3LEmWi6K"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D41D150D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941987; cv=none; b=nODnxgKDYywsPHj3dDDtjKt5099/gAXJAPRKsDYn/VcJtH+bklgD1GuZ8aViNdfTH6aSEXYecGwIVwamxKyEn8xR7fLacy1GxQ8r3X2oOWF46l3Pqhx3G9iPhH1rpNP95+038XAQqIU+GAe5QJFalksm0IHMpfA9E2nG5yA2TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941987; c=relaxed/simple;
	bh=N4ubeMxtZYY3hoTRTFgbOjAyVC5gCI706GptvR2plVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBGhU/u27NZRdH9WtHLiFlW971QTghfjzOYpWEjYSx78AxsbPFCvOhBcUeNiINmaSjBHneZKorHHe4FISBOviVTzOo6RsXF+phfAUiDkdbrijix1whB5cSGJL8WP5nPDwemIops+9XhhaDcjwhseg8SknTDvNWC/O9ZZjwJPqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3LEmWi6K; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f629a7aaso347105266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728941984; x=1729546784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9csY8Ut29tVJGEmLpxfSFZpuKt+NBF5m2ROuPwTQCh4=;
        b=3LEmWi6K1eY3vNA3/AhfRVMD3UNv9cvK7yAxSPZNhuQAyy8KBc6lPl7l/8vCz529aC
         So5XuMVe8j3XvyX1wcZKtFHTHitW94D861hr9BMz+tz1WO/345NG8byIZNHs6YiXrGUt
         oc0Sl4Elm1U0gWSbiJBzHug20B2nOUmsh1eNJFbulcerl+NE11+jHZyfhrMRojii8Xga
         uogPedcgjGYyKYU9hzyO8kYWYj/zziKhrHjWZIPvFkEQ7ML/yPLJDzmo9cyIcjj/ElDm
         BsVwtUU9Y3nL6gGOklGqwvue/CvzHh1GM1KMQexto/zZ7BqctW3WcBXcGn3f87ty62aF
         JFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941984; x=1729546784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9csY8Ut29tVJGEmLpxfSFZpuKt+NBF5m2ROuPwTQCh4=;
        b=ZWcaWP1bOG0HCO4/02vOeP8H4hzZ4+iZ8eE++8N1s4RTwqSeyP3CJXKIpH74VGp8Pa
         NpbXjYpX6kh3h+VfdDLGD3J2GaYwOpqUfhpo/o1AsyjDDdXc6GAv0n8mNSt22YQ3DlVl
         Nd/s1inOU0tDjD5FdhQUIi5Gd9z/xWxqwvMyVd1oSICtU6xAk831x4VnMpL1SB1tJAbQ
         4BkCEt0A5nS69Zgx9+U3E1qYdQPbe0gFrpRM8QTNbC6uiskp3wyb6uyysHxSDYL5mLjk
         +RzFd6Qiu75iRP2/nnRUeOxUFxb1e9gKmProLFS6Jsqobz2TfJnpzmU77FmpfmXvCHf1
         hvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWgLYatWqApj067KL2A4JXoGj23YYp9RUv1ZTKGPkolxeh/fSU5EVROw/xsn5hNV1ghbcQ5mKkDKynAvK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UFj371evQtjhoUKHFOD4vUoJM7OdeHbrF2nfEtMy1AbtiOvH
	8oXy7Vq8VMfk4dEzA4Z2ciYbUtK04hRRGRk2CbVtGMgOkEAm57HDtWCqbegnZRH+jOQxtkLYp/P
	UDUsr8+pr8T6ehJwptn8vtYAiQssEy1kXdzg=
X-Google-Smtp-Source: AGHT+IFezu5CuG2wy6vTwMe51sB4ras/WO24nsNQmzs/ECPU2E5UBEHIWzUwNkN76hqWAt+exwA5Vo+oEQmkGwO5hUQ=
X-Received: by 2002:a17:907:7ba9:b0:a99:4566:cd42 with SMTP id
 a640c23a62f3a-a99a0d092efmr1482503866b.0.1728941984105; Mon, 14 Oct 2024
 14:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com> <Zvg-mDsvvOueGpzs@archlinux>
 <202409281331.1F04259@keescook> <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux> <E8E64A72-3C1C-40D2-9F07-415F6B8F476E@toblux.com>
 <Zv61dCaxScXuOjZg@archlinux> <202410031424.45E5D19@keescook>
 <Zv8RIs-htdc-PtXB@archlinux> <202410040958.C19D3B9E48@keescook>
In-Reply-To: <202410040958.C19D3B9E48@keescook>
From: Bill Wendling <morbo@google.com>
Date: Mon, 14 Oct 2024 14:39:26 -0700
Message-ID: <CAGG=3QWw40ARPp9nPT5QEgkKMZ0i_Un_BBT7Th0nruizCRORtw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in bch2_xattr_validate
To: Kees Cook <kees@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Thorsten Blum <thorsten.blum@toblux.com>, kent.overstreet@linux.dev, 
	regressions@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:13=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Thu, Oct 03, 2024 at 11:48:18PM +0200, Jan Hendrik Farr wrote:
> > On 03 14:28:01, Kees Cook wrote:
> > > On Thu, Oct 03, 2024 at 05:17:08PM +0200, Jan Hendrik Farr wrote:
> > > > gcc currently says that the __bdos of struct containing a flexible =
array
> > > > member is:
> > > >
> > > > sizeof(<whole struct>) + sizeof(<flexible array element>) * <count>
> > > >
> > > > clang however does the following:
> > > >
> > > > max(sizeof(<whole struct>), offsetof(<flexible array member>) + siz=
eof(<flexible array element>) * <count>)
> > >
> > > Clang's calculation seems very wrong. I would expect it to match GCC'=
s.
> > >
> >
> > I was on the very same train of thought, but I have since changed my
> > mind a bit. A struct containing a flexible array member can be allocate=
d in
> > two ways:
> >
> > (1):
> >
> > struct posix_acl *acl =3D malloc(sizeof(struct posix_acl) + sizeof(stru=
ct posix_acl_entry) * 1);
> > acl.a_count =3D 1;
> >
> > or (2):
> >
> > struct posix_acl *acl =3D malloc(offsetof(struct posix_acl, a_entries) =
+ sizeof(struct posix_acl_entry) * 1);
> > acl.a_count =3D 1;
> >
> > Both are valid ways to allocate it. __bdos does not know which of these
> > methods was used to allocate the struct whose size it has to determine,
> > so it's giving the lower bound that doesn't include the (potential)
> > padding at the end.
>
Slightly off topic: while I was looking at the definition for
struct_size, I noticed this:

#define flex_array_size(p, member, count)                               \
        __builtin_choose_expr(__is_constexpr(count),                    \
                (count) * sizeof(*(p)->member) +
__must_be_array((p)->member),  \
                size_mul(count, sizeof(*(p)->member) +
__must_be_array((p)->member)))

In particular the 'size_mul' line. I realize that '__must_be_array'
will return a '0' or static compiler error, but it seems inconsistent
that it's included as part of 'size_mul'. Maybe something like this
instead (notice the parens on the last line)?

#define flex_array_size(p, member, count)                               \
        __builtin_choose_expr(__is_constexpr(count),                    \
                (count) * sizeof(*(p)->member) +
__must_be_array((p)->member),  \
                size_mul(count, sizeof(*(p)->member)) +
__must_be_array((p)->member))


> I want to separate several easily confused issues. Instead of just
> saying __bdos, let's clearly refer to what calculation within bdos is
> being used. There are 3 choices currently:
> - alloc_size attribute
> - counted_by attribute
> - fallback to __bos (which is similar to sizeof(), except that FAMs are 0=
 sized)
>
> Additionally there are (for all intents and purposes) 2 size
> determinations to be made by __bos and __bdos, via argument 2:
> - containing object size (type 0) ("maximum size")
> - specific object size (type 1) ("minimum size")
>
> For example, consider:
>
> struct posix_acl *acl =3D malloc(1024);
> acl->a_count =3D 1;
>
> what should these return:
>
>         __bos(acl, 0)
>         __bos(acl, 1)
>         __bdos(acl, 0)
>         __bdos(acl, 1)
>         __bos(acl->a_entries, 0)
>         __bos(acl->a_entries, 1)
>         __bdos(acl->a_entries, 0)
>         __bdos(acl->a_entries, 1)
>
> > So it comes down to false positives vs false negatives...
> > More details here:
> > https://github.com/llvm/llvm-project/pull/111015
> >
> > Clangs current behavior would essentially force kernel code to always
> > assume option (2) is used. So
> >
> > struct posix_acl *
> > posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
> > {
> >       struct posix_acl *clone =3D NULL;
> >
> >       if (acl) {
> >               int size =3D sizeof(struct posix_acl) + acl->a_count *
> >                          sizeof(struct posix_acl_entry);
> >               clone =3D kmemdup(acl, size, flags);
> >               if (clone)
> >                       refcount_set(&clone->a_refcount, 1);
> >       }
> >       return clone;
> > }
> > EXPORT_SYMBOL_GPL(posix_acl_clone);
> >
> > from linux/fs/posix_acl.c would have to turn into something like:
> >
> > struct posix_acl *
> > posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
> > {
> >       struct posix_acl *clone =3D NULL;
> >
> >       if (acl) {
> >               int size =3D offsetof(struct posix_acl, a_entries) + acl-=
>a_count *
> >                          sizeof(struct posix_acl_entry);
> >               clone =3D kmemdup(acl, size, flags);
> >               if (clone)
> >                       refcount_set(&clone->a_refcount, 1);
> >       }
> >       return clone;
> > }
> > EXPORT_SYMBOL_GPL(posix_acl_clone);
> >
> > Which is actually safer, because can you actually be sure this posix_ac=
l
> > wasn't allocated using method (2)?
>
> First, this should not be using an open coded calculation at all; it
> should use the struct_size() macro.
>
> Secondly, if we want to change struct_size(), then we must (via
> allmodconfig builds) determine all the places in the kernel
> where the calculated size changes, and audit those for safety.
>
> Right now, struct_size() over-estimates in the face of padding.
>
> We're already moving the kernel toward not even calling struct_size()
> externally from the allocation, and instead using the it within the
> allocation macros themselves:
> https://lore.kernel.org/lkml/20240822231324.make.666-kees@kernel.org/
>
> > After looking at the assembly produced by gcc more, it actually looks
> > like it's using the allocation size if it's known in the current contex=
t
> > (for example if the struct was just malloced in the same function)
> > and otherwise returns INT_MAX for the __bdos of a struct containing a
> > flexible array member. It's only returning the size based on the
> > __counted_by attribute of you ask it for the __bdos of the flexible
> > array member itself.
>
> Here is my test case for all the corner cases we've found so far:
> https://github.com/kees/kernel-tools/blob/trunk/fortify/array-bounds.c
>
> I'd prefer we add cases there so we can all be talking about the same
> things. :)
>
> -Kees
>
> --
> Kees Cook

