Return-Path: <linux-kernel+bounces-399477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C99BFF6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280D71C2142D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937F19ABC6;
	Thu,  7 Nov 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiLz1lvG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3A17DE36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966175; cv=none; b=fVn2RcYvqoFZFYSZALrHobipBO8+ZpkPY0Qmo3JqDfuYtwZuYyOmzVqmkIZurgFuB14NAEblkPbBlVnUfuesCNcOF5k8nMHRHq09rdslKFDyArQlyX08oLLNskoGlMWGaeiMoB2VqzgxRY5x1QGXEPfRLHgfV/a7Rh58O82NA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966175; c=relaxed/simple;
	bh=jDomde3/iUFvIfJ3iganah2LEQ63z2Z0sAm6v1RGRhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJA8Q6CdsqQO22X9+Cfhs/YJvJtWCrOL/u2tYBa5MlxCqBsYokJ+iyehtrvvlZ1TyW0C0sTeVG6sOa7DHcjABKrszWpXTMi3P80q6uDI8EmgFYaatAiXq6nuqVr/Vz+cwiu+q5jKrHw43fjmHRTc1HwvUJWK2oUW3BoNTed8qC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiLz1lvG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314b316495so5597395e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730966172; x=1731570972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izGbQDZbA5gZiVbrG2xjhpkYo/HP9m4/wsr5q1Biwlw=;
        b=AiLz1lvGYLKNJi6NMD8lNzlso28koZajZdvc0mvjljoKIBQQKb+DumbX7YkVLcUBaO
         wdZ2YTNwj775cGQbWV0s3hcCn7tq5b75CWqz3vdKutciggp0cOfGKfzVTbaivDaLCFF9
         etwLF8OlrrKQgiGiuVmj6oNX7meICP8qQ4ws77TJa+N75xKjlSLFXixxawOjuk8fsiQk
         y3htjjbu9dyq1u0qXb8CofBb/k66wNG/255MGT/Y2k+5k/BrdiRNcO4C1Lb2pKgSz+Kc
         3fwqRkXhfxm0TDKRlK+tgWGOabkHKBprIBcBe09L9pEJalH7eK2eTXoQo7T3CE5tj8xh
         aQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966172; x=1731570972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izGbQDZbA5gZiVbrG2xjhpkYo/HP9m4/wsr5q1Biwlw=;
        b=L3LN1OWuiIlznaLhGpH6w1r21K6fJkKpneo0f7J7p2ZPgRsLutxaUVFVA+L80n+LxF
         nuDB6a/rCKNCex/OJCG8DVAsYX/XSWEOGOKRX978i0BKlHdaLOYfiWKxQVolthxa58gc
         0sBXziB22fpHDTzYt362QUbp1/smhWGqmOwOQtjbB1eDY42/znydLlgPyYdU2I9hh8hS
         mSuWgxdsz0TJgD1Jeq8rpHn04kMKMu3W5ZRLzY9WD2q+pQIu0lHp7cARdqb3g9Bkxftz
         0zvGqGF81+mn8yuToT4h4SPFP/EstuQsDX7F4+y3j+z8R0+YLIML3DkhA4oWxIFqtNBa
         Ldzw==
X-Forwarded-Encrypted: i=1; AJvYcCWLtdIw9VzX7BsVajio0uF3E+XxFNfX5VJUUwji0YR3eLtPr0qfB5DZmubPy4fiSFmK/lED0Ksff5Ol7qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFCel3fQBrQqnKF81SrzXTBL2U+087VW13A4ovacvI/5WZHCo
	E0vjbYcPF6ZN7o12Kg2FOfwnmKduFVCSo9ZQ07zAqKGvEvLB5lkqvFJh4wb+GJw/QmS+1hjgP/0
	P8yf0nrLusXxcet9Z4Easvm+YTSiVOthJB8T5
X-Google-Smtp-Source: AGHT+IFe1EMbcnGrMkjttOt1av9g+20rXev7NSCpetyPrTr+VYaK1t65Ogth97wIOCnGytVqSGvqJpUgTuD3IfRKLBE=
X-Received: by 2002:a5d:5982:0:b0:37d:3e8b:846f with SMTP id
 ffacd0b85a97d-381ef6a1bddmr190822f8f.24.1730966172361; Wed, 06 Nov 2024
 23:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CANiq72=9XiYOMQ9ttDrgqTt=mPZnWJuCL0EgQBjFObfqVmr1UA@mail.gmail.com>
 <CAJ-ks9kNmH2t2Lo2PdLuH5rwSC3UQRGWd-cTAX9-Q2FE6oGHiQ@mail.gmail.com>
 <CANiq72k3AJgMq_US7MYGpzKRqOXZQKpOkBXAd8DwBKyE+Bz3Jg@mail.gmail.com> <CAJ-ks9kKtGkBmjQCfM-idP6uYas_wOqMq7q-oPxZ=+MkS8XVqg@mail.gmail.com>
In-Reply-To: <CAJ-ks9kKtGkBmjQCfM-idP6uYas_wOqMq7q-oPxZ=+MkS8XVqg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 7 Nov 2024 08:55:58 +0100
Message-ID: <CAH5fLgjgKmAOEdofTR-ZnqcLa1D_KJ9C3fs4PchYyzZjBBYG_A@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Nov 6, 2024 at 2:20=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Wed, Nov 6, 2024 at 5:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> > >
> > > I would be happy to add the relevant details to the commit message bu=
t
> > > this is one citation that I haven't been able to locate. The closest
> > > mention I could find[0] only vaguely mentions that this change was
> > > made, but does not reference a commit (and certainly not an RFC).
> >
> > In Boqun's first link, there is a reference to the nomicon with
> > details, and the section:
> >
> >     https://doc.rust-lang.org/nomicon/phantom-data.html#generic-paramet=
ers-and-drop-checking
> >
> > explains the change, including:
> >
> >     "But ever since RFC 1238, this is no longer true nor necessary."
> >
> > There was another RFC (1327) after that, for a finer-grained approach
> > (`may_dangle`). The name of the feature gate was also changed.
> >
> > Anyway, I don't think we need to add any of that to the commit message
> > though. Perhaps linking the latest RFC is good for context, so if you
> > think it is a good idea, of course please go for it -- but in case you
> > are referring to what I said, I didn't say that we should add the RFC
> > bits into the commit message.
> >
> > Cheers,
> > Miguel
>
> Thanks a lot for all the hand-holding here. I think the sensible thing
> to do here is to add a comment rather than remove the PhantomData.
> I'll send that as v2 shortly if no-one objects.

Adding a comment and keeping PhantomData SGTM.

Alice

