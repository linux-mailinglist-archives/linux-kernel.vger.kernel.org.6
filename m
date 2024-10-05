Return-Path: <linux-kernel+bounces-351821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF5991695
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C6C1C21A18
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3D14D283;
	Sat,  5 Oct 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQoRkPvG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1E2B9AA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728129600; cv=none; b=NSSzeDjYMAlHp70/WVxnP+Pohd2d7O38lavEm/HOM5K6yf3yHZfNzkiBDSDKM/bjxNt6d6ig6d3Hydc8UF3tt5fV0BxZ6/yVcVTb88sTS7mY+mzXRTA0jSEO56VVRskbdM7OyWHEIcxhPIUy6Cr8AZr3sImajfxHFEoqlv5AiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728129600; c=relaxed/simple;
	bh=B9ie2ibbvUeA8qv7/cm4Mu4ucpj9+ZbfFtIGNqzy5lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUyML+xULs3jRzNvbrs6nmMuOhCdBre95QYSIguAcukf0+d+6pqNpuoPrCEWfMx/R8GKRdc4XSRB1mSu+UczeDunjghx0IsDvO7H26QC5nPyXupSexo+8g7gx1PlSzbBlL1OjyPUCQmzIMtiboMeygufHVTOIPMnVN052SfyEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQoRkPvG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccfada422so1794163f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728129597; x=1728734397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT4JN1wYGFSh5zRwCmPA1K5txyLYW2kiaQGQVe7qZpc=;
        b=ZQoRkPvG8JYddDJBRt1qZ38fVwhdKC5m//WrmJu5ZOWPtAtLyjs4sxFS5kXawJ97q/
         nzz/AWRjq5M0z39UXuMmMoRg7wAbxjkZJtsrcw5/TKhObIT2rRWrBAhBQCfhC6HpsqFb
         id0afgsOdwJUt7IoUVYPRLy5DdvfZzpOVVWRQQqnKD9Hyzcixe5iOl/bQ42nWCSV8qA/
         g4Z6RgF/M5XVuI+blhveRscLNBWMY7pcviPsZkKJqfmGofxQeq2tG39NeiFHnKjwtw9f
         Fk8C7GnHKt+bp5haZo0+sRirrhzi4WgQzTOZu/Hz5MS+dLhdxC3ksz4LE0nRiYNzjY14
         VzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728129597; x=1728734397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT4JN1wYGFSh5zRwCmPA1K5txyLYW2kiaQGQVe7qZpc=;
        b=K587Cvy1IRORmDGIp2dgu6KSwolmeNW95zALAIrImkDrTnIRf55SKTNH5spI4bPFhU
         fjQByFRYQ+CO4l6Qtfp9EvLd0ieyOwHW3cfKSUWC+YeFS9C00A1TAHJDPoMUjm1KSMEs
         S3sOtNfGlvDuTat1BfTVCZMv9KnRzMIMgKu7ebjRlY1tGxYi9XMHCYxhuQJWbOdJpzxK
         /2sko5h/p9f+WokztYPwFvsY+FMAiOEXr4eEH3ck5JTEVnYZ1vc3YkdzCbDxJ/L99ylN
         xcu0DEbsDgVPLrJHvyNBQHYLLqOilKOV0PJlzhdo1bsr8W+3eqS7peyyLwvUBoO16jEj
         5hYw==
X-Forwarded-Encrypted: i=1; AJvYcCW6XZzSyupyJpLUWlaHzbY45a4xeiFIKSrYNHSzXwVxuNOtpI4w6umvpgQKyPtaKShoOoIP+vpAL2+2hc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQMPXWAzDoyEWe0Hj766U2Ffgcpg/niYenhKSnlH60BAGoYEG
	Do+Sl/SWwHcAuvKZsJamZXfTP9HKQhSxKrHm9fsV3PlJlSzn7LTp8TXBbMJoqrDavKAQiBdYVh+
	dbrFWK/E5bgQSdTp/49qpU3VuMdHRZV/ck3G3
X-Google-Smtp-Source: AGHT+IG31cBDoRhFPWScbaQzOpQcmmZdOGEaWuSuXkGk1VAZd2FBlgLkb0o49Dh412K3nfiMQSovCDPdJDa1N7PAv9c=
X-Received: by 2002:adf:fdd2:0:b0:37c:c5da:eaf7 with SMTP id
 ffacd0b85a97d-37d0e7a18dcmr4568091f8f.31.1728129597120; Sat, 05 Oct 2024
 04:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004155247.2210469-1-gary@garyguo.net> <20241004155247.2210469-4-gary@garyguo.net>
 <OKHi9uP1uJD59N2oYRk1OfsxsrGlqiupMsgcvrva9_IPnEI9wpoxmabHQo1EYen96ClDBRQyrJWxb7WJxiMiAA==@protonmail.internalid>
 <2024100507-percolate-kinship-fc9a@gregkh> <87zfniop6i.fsf@kernel.org>
In-Reply-To: <87zfniop6i.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 5 Oct 2024 13:59:44 +0200
Message-ID: <CAH5fLghK1dtkF5bRpcRcu2SXZ6vgPoHGLRqW2=r0J3-2T3ALwQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Gary Guo <gary@garyguo.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Hi Greg,
>
> "Greg KH" <gregkh@linuxfoundation.org> writes:
>
> > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
> >> There is an operation needed by `block::mq`, atomically decreasing
> >> refcount from 2 to 0, which is not available through refcount.h, so
> >> I exposed `Refcount::as_atomic` which allows accessing the refcount
> >> directly.
> >
> > That's scary, and of course feels wrong on many levels, but:
> >
> >
> >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<S=
elf>) {
> >>      /// C `struct request`. If the operation fails, `this` is returne=
d in the
> >>      /// `Err` variant.
> >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request=
, ARef<Self>> {
> >> -        // We can race with `TagSet::tag_to_rq`
> >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_ex=
change(
> >> -            2,
> >> -            0,
> >> -            Ordering::Relaxed,
> >> -            Ordering::Relaxed,
> >> -        ) {
> >> +        // To hand back the ownership, we need the current refcount t=
o be 2.
> >> +        // Since we can race with `TagSet::tag_to_rq`, this needs to =
atomically reduce
> >> +        // refcount to 0. `Refcount` does not provide a way to do thi=
s, so use the underlying
> >> +        // atomics directly.
> >> +        if this
> >> +            .wrapper_ref()
> >> +            .refcount()
> >> +            .as_atomic()
> >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Rela=
xed)
> >> +            .is_err()
> >
> > Why not just call rust_helper_refcount_set()?  Or is the issue that you
> > think you might not be 2 here?  And if you HAVE to be 2, why that magic
> > value (i.e. why not just always be 1 and rely on normal
> > increment/decrement?)
> >
> > I know some refcounts are odd in the kernel, but I don't see where the
> > block layer is caring about 2 as a refcount anywhere, what am I missing=
?
>
> It is in the documentation, rendered version available here [1]. Let me
> know if it is still unclear, then I guess we need to update the docs.
>
> Also, my session from Recipes has a little bit of discussion regarding
> this refcount and it's use [2].
>
> Best regards,
> Andreas
>
>
> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#impl=
ementation-details
> [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685

So it sounds like there is one refcount from the C side, and some
number of references from the Rust side. The function checks whether
there's only one Rust reference left, and if so, takes ownership of
the value, correct?

In that case, the CAS should have an acquire ordering to synchronize
with dropping the refcount 3->2 on another thread. Otherwise, you
might have a data race with the operations that happened just before
the 3->2 refcount drop.

Alice

On Sat, Oct 5, 2024 at 11:49=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Hi Greg,
>
> "Greg KH" <gregkh@linuxfoundation.org> writes:
>
> > On Fri, Oct 04, 2024 at 04:52:24PM +0100, Gary Guo wrote:
> >> There is an operation needed by `block::mq`, atomically decreasing
> >> refcount from 2 to 0, which is not available through refcount.h, so
> >> I exposed `Refcount::as_atomic` which allows accessing the refcount
> >> directly.
> >
> > That's scary, and of course feels wrong on many levels, but:
> >
> >
> >> @@ -91,13 +95,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<S=
elf>) {
> >>      /// C `struct request`. If the operation fails, `this` is returne=
d in the
> >>      /// `Err` variant.
> >>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request=
, ARef<Self>> {
> >> -        // We can race with `TagSet::tag_to_rq`
> >> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_ex=
change(
> >> -            2,
> >> -            0,
> >> -            Ordering::Relaxed,
> >> -            Ordering::Relaxed,
> >> -        ) {
> >> +        // To hand back the ownership, we need the current refcount t=
o be 2.
> >> +        // Since we can race with `TagSet::tag_to_rq`, this needs to =
atomically reduce
> >> +        // refcount to 0. `Refcount` does not provide a way to do thi=
s, so use the underlying
> >> +        // atomics directly.
> >> +        if this
> >> +            .wrapper_ref()
> >> +            .refcount()
> >> +            .as_atomic()
> >> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Rela=
xed)
> >> +            .is_err()
> >
> > Why not just call rust_helper_refcount_set()?  Or is the issue that you
> > think you might not be 2 here?  And if you HAVE to be 2, why that magic
> > value (i.e. why not just always be 1 and rely on normal
> > increment/decrement?)
> >
> > I know some refcounts are odd in the kernel, but I don't see where the
> > block layer is caring about 2 as a refcount anywhere, what am I missing=
?
>
> It is in the documentation, rendered version available here [1]. Let me
> know if it is still unclear, then I guess we need to update the docs.
>
> Also, my session from Recipes has a little bit of discussion regarding
> this refcount and it's use [2].
>
> Best regards,
> Andreas
>
>
> [1] https://rust.docs.kernel.org/kernel/block/mq/struct.Request.html#impl=
ementation-details
> [2] https://youtu.be/1LEvgkhU-t4?si=3DB1XnJhzCCNnUtRsI&t=3D1685
>

