Return-Path: <linux-kernel+bounces-522062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D093A3C558
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACFF173053
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34066211468;
	Wed, 19 Feb 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIcHGOIX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922420E316;
	Wed, 19 Feb 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983471; cv=none; b=Lu/GGPOZOCVzeLY36nZt82bbAvD8NdbTSMAD+4ohLeECKTKQAf0XLe7eIoZ5T7URYPZtdNK9EnaKoyoUIHiexHtJc1avPpaeCzX6mEQtY5hM2c5xdNjm0KHe0k47kSVhfTQovgH5tepNT04v5x2a3WuM6b6k4nIRoi7wnKWr2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983471; c=relaxed/simple;
	bh=coLgbb6XnDBvEfFl1LEqqygGvhtbqNub/FqaL9C1aE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gf6XV1oV2Mt4m0qfmbzVeEQSTuk1Fi7GRStnIs4Y3CgI181ACwliVHqT2GlbEH00Qf2eyfF35v0l3GrFGp6FEJoWDiCzLZseJlp5/TWrdzplE1YhmKjXjE7RDBfsdgIx2g9byWPs1B/cDHoyI6q5hwiRdyJIYJKdUw95+gVdppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIcHGOIX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2217ea6d8daso1855555ad.3;
        Wed, 19 Feb 2025 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739983469; x=1740588269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpSdI9TciDVD3f9EE6Gy3+0yUeXXFt0AqSsrZ5Y2Fdg=;
        b=LIcHGOIXc60ae2qjT5V8AazOjsmTBQLnjcnIYIK8pkYwgu6gJeJG7zr62CBlsEvNFK
         19V+WXA82/dh/8dUoBIKAmXL2BlhidYpcFix9O4AqR5lBqNuR5r1gYNz4XNWez40EiWQ
         gW2wb5TUWAC5CUI3gRLc6qlJsiTRq3Xh5d0AVWzqlOqH6HXYUrHpsEDwrvUsS7Kss+2f
         iQJnSP/5UKcUNZ7t373jVOWmEwWCLrPxQK6Yvi76LZ+A8STiMdKqh03V/sKCRQzqIGlY
         4/SKnjX6edZ4UBQ/57DFemnN5ZfRi9e4fd9ChzhBYD8biPAfOBerpPQjQbUsjA2nfidQ
         ZROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739983469; x=1740588269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpSdI9TciDVD3f9EE6Gy3+0yUeXXFt0AqSsrZ5Y2Fdg=;
        b=U7BC9KcPXjLG5w95ESn1ZRpPVs65e/amMSJV6nSgQfawVGnRZQUMH9nbRTed4EegE3
         UV7wTBcEzQT/WBBt4Ffi6hOpu8HgM/itsJsmZOD7t51YDLjyEL/lN7hQ47aBxDCpGU+7
         od3FJTpDLcTNvG/wWh4ZRvgs+jWoXkUN7q7tGuYHyUa+NL4tW0/zV+GDUXutSLVIOpuw
         z35jjTQK0ZueMMjRmmrBc78Qg/ij6yeUG2nq2HQdWXym24P3jYQnIdcT90dSSfe1YcMl
         R2cVdt1tUuqYSn8XNrQLopWI++uSYZkG2/yJnLAMGsztLd4CMsEzm297NxdDWI6Py50X
         gcxg==
X-Forwarded-Encrypted: i=1; AJvYcCVu6ilvEqj+tykulmsvrlFocftl3Fl6iGvId/WIIIiicbZdbMfSGu8TU1W4/J9q41PKSTWPtdcMrwy4gfgbwbE=@vger.kernel.org, AJvYcCXRNirJCQ8slG/7j/RxAkUTksAHAmrgoYd7Kx36P78m8KNJX5SGTctz70yOLukrmrhLYJS77/E7SLtahVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNpEHan6VpyLb21vCFBFIZBdM66OWwqIKtyXLChA59ZTO1HgN
	UFGs7E7FfBWL72gQiudYA/AlJDCDsC1aDsoOgi/a5FCW95b2XVm840+/HlJEPD07YDfh0ZYPvRn
	aaoJZDRyiopOt4agBM8Vxk6ZxFo/RG9D6
X-Gm-Gg: ASbGncuopqlLTPQ5FSluddAIOwHXmSijds9hdeG6Q/M4Cj/jLks5QLeEy8e+fdqvSvP
	kZvdSDfDOmL57UYIXndXMao57ryPxE2la3K/TaPLUBZSyqEyuFXhvrAF8LBnHdKAB8JoWzyLX
X-Google-Smtp-Source: AGHT+IGXLgEYvFdJCDw63pT8utsxHDE6tdJOZPEE2jtb7OZQYt+f9JyLUhhgOfAgeTWIaWDbUpCq8X+N1x+FdIUrOQ4=
X-Received: by 2002:a05:6a21:998d:b0:1ee:6da6:db39 with SMTP id
 adf61e73a8af0-1ee8caac940mr12393415637.2.1739983469359; Wed, 19 Feb 2025
 08:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com> <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
In-Reply-To: <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Feb 2025 17:44:16 +0100
X-Gm-Features: AWEUYZlZQz32tYaHsd-CbTAVpzCaM1AcA1wwh-dIKS5x41V3xqxA5IWgZKTqXP8
Message-ID: <CANiq72m5KB-X1zck1E43yffXOTeD4xRmZgDx_oUiNwR941ce0w@mail.gmail.com>
Subject: Re: Rust kernel policy
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:03=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Just so we're on the same page, kernel API stability can't be the goal.
> We can debate how valuable the current API instability is, but it's a
> fact of life.  The point of the proposal is not to stabilise the C API
> but to allow the instability to propagate more easily to the rust side.

Sure, I didn't mean to imply that -- I am only trying to say that,
even if you add a lot of information to the C headers, you would still
have to update callers (both C and Rust ones).

Now, there are C APIs that even if they are not guaranteed to be
stable, they are fairly stable in practice, so the pain can be fairly
low in some cases.

But please see below on what "Rust callers" mean here -- it is not
every Rust module, but rather just the "abstractions".

> This very much depends on how the callers are coded, I think.  When I
> looked at Wedson's ideas on this, the C API contracts were encoded in
> the headers, so mostly only the headers not the body of the code had to
> change (so the headers needed updating when the C API contract
> changed). If the enhanced bindgen produces new headers then code like
> this will just update without breaking (I admit not all code will work
> like that, but it's still a useful property).

Hmm... I am not sure exactly what you mean here. Are you referring to
Wedson's FS slides from LSF/MM/BPF? i.e are you referring to Rust
signatures?

If yes, those signatures are manually written, they are not the
generated bindings. We typically refer to those as "abstractions", to
differentiate from the generated stuff.

The Rust callers (i.e. the users of those abstractions) definitely do
not need to change if the C APIs change (unless they change in a major
way that you need to redesign your Rust abstractions layer, of
course).

So, for instance, if your C API gains a parameter, then you should
update all your C callers as usual, plus the Rust abstraction that
calls C (which could be just a single call). But you don't need to
update all the Rust modules that call Rust abstractions.

In other words, we do not call C directly from Rust modules, in fact,
we forbid it (modulo exceptional/justified cases). There is a bit more
on that here, with a diagram:

    https://docs.kernel.org/rust/general-information.html#abstractions-vs-b=
indings

In summary, those abstractions give you several things: the ability to
provide safe APIs for Rust modules (instead of unsafe calls
everywhere), the ability to write idiomatic Rust in your callers
(instead of FFI) and the ability to reduce breaks like I think you are
suggesting.

Now, generating those safe abstractions automatically would be quite
an achievement, and it would require more than just a few simple
annotations in the header. Typically, it requires understanding the C
implementation, and even then, it is hard for a human to do, i.e. we
are talking about an open problem.

Perhaps you could approximate it with an AI that you give the C
implementation, plus the C headers, plus the C headers and
implementations that those call, and so on, up to some layer. Even
then, it is a problem that typically has many different valid
solutions, i.e. you can design your safe Rust API in different ways
and with different tradeoffs.

I hope that clarifies.

Cheers,
Miguel

