Return-Path: <linux-kernel+bounces-537148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E011A4888A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B21E188BC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0F26B979;
	Thu, 27 Feb 2025 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPKm1jVx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDD21858D;
	Thu, 27 Feb 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683229; cv=none; b=Mj0mbqiMdCn9sP8YCwlbxX3vwnBq1HxG5eSJtnQQdi69G/Rb8KhJI8Sy/0Xp6YhqsTZY6ImQxC39o8zb2cLWr/ST5PSwnVDw6hF62N4wbqOuLu8oc9kvwbUWRf3BmuHReaqLq5SxKukLbQN3ZUa5ZYhgHnQWuRcGTpAw5GmV61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683229; c=relaxed/simple;
	bh=wJ7LS04maCw8spcI4TrOxqyLwpxqVVvP5R5S2mwqQbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRzE9GQe5E5XJZlethSGWVoEq2mpry6snl8GroWiFcYOEOJY2o6OOCt4IRbrN3IHXQAtkzGS3XFSQY0wFOIA2okHndaTMrqGS24Zt6HHnwCnd7zn1wlftZoaHZGFMyN8hyMaGSj5QpLZHLUP0P99ir9z5oOm0fdQQBDyy+FglEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPKm1jVx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54524740032so1280924e87.3;
        Thu, 27 Feb 2025 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740683224; x=1741288024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xy3Oj2ldzTgrhOEQY5Rr8+ha+y2IXOarnF1z09Z2lU=;
        b=lPKm1jVx8yo7uOLho9SHh1n6wKk1jxKX4v9hzPzVEj3/BnoVQesOjJ0BtKj8uIYvtg
         uAbO7gwvUYuEhlhX0cf9YTaaSLkVnNQtrQwcADUqZDmEcpY7SUZWynmlJCUaxbIFb4ey
         HcJcrA3SFjrzzREN8USES0TxomaybTCzUfjOS7bFdnADLdTOgC2DT/fTapz0JYOrKSWu
         67DYIxnFdDphsSaL/w5ag+EMEQdlJbtgZkshrT3MS2kEl0g+DsJmPAaptbVImI8dHTjw
         k2NY0MhiU2nCw1uul2d0hmmleToI8+zuPYRjSaqjgoHeE5lzG/m6i2D73VcnZRQbDVmR
         kjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740683224; x=1741288024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xy3Oj2ldzTgrhOEQY5Rr8+ha+y2IXOarnF1z09Z2lU=;
        b=kZgMj22DQKzbVK/eX4NmlqVoQ3C31COGpapjr52M8vK2H8GYMVPcVmFY7sy8r123PL
         77nZgkN7ZY1KyMq+RXRpfroVGFhLyi8rvceqNb6y6qnFyuda6+bMT+sHvokfXz6jylCz
         5o0MLzfNS+l9+EnKtqhGXDt3waPAwG6y8NFHazK+vbXl+Utb3/EijlQHxv0/mWkkspWf
         KDrZEIUf9BVm/JfwQoGq4V/D6FvDv9ndNYF04Gzf37zUbcUzNpgX6YwAlQoxefy4yk8Q
         QmYxEik6PYxBimR3rHyMAmIhWMR29Zv/EigCgZHhuGt2Ap9m6FkUDj5PLUCSWjE1+1dB
         OgWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVB65KRHrIIXZ6/O5+kedujXAB2c6aZF6xVedsjT+Fegqn7ZD5P+g13klVx2IL3fVvYK4V0PZgy3jFB6U=@vger.kernel.org, AJvYcCXiFLkkI5oODWx7lJ1/qW3+/6DZQ/wsIFn/8gj/USh5owak9vdHfvR9DHhY7VmDwxCuS8lmQ6vc7zj7h0avLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBU4cyHNK6nP00d5IzpBOs4rfHLq5mKhKHz/9MoP2RVAxVpVP
	G13gSvZ9bEFIoyzgJt/YgImlQGG+hilhIkF7mgIM8AkPN7XzKjkow2TyRRRb7ZxsVBkzomH+S2E
	EAkw81IuBA1zsFWfgH7be0bQAi4o=
X-Gm-Gg: ASbGncuL6jBGKQWlVKP+TqkBOXpgu7E8GsqhhI58vzs0soIMsarO0tcaBE7xL30aOVZ
	+oROHhUBNzF3aX1U16pSjXAGeaEdgpSSmK5UXkYzA1t5vNqHtAXP5RhU4hTprJ9s4txoh73YMeH
	FdYrFYf55N
X-Google-Smtp-Source: AGHT+IHUshUoYHkR9uVcI3jDioRWIALbex8qiEz8jjAKgU/6UJe7mUJOpyTCm2OKbQMksLIjSmuA73tf1gj4Os1F0qc=
X-Received: by 2002:a05:6512:2820:b0:545:5a5:b69f with SMTP id
 2adb3069b0e04-5494c107e18mr305357e87.9.1740683224218; Thu, 27 Feb 2025
 11:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de> <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de> <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de> <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
In-Reply-To: <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 12:06:50 -0700
X-Gm-Features: AQ5f1JrjxNgL0EUlJ7aAqjswwz9TyAVgr8OSzI_jWIv3Ro6Vgwf5kx2j5898JCg
Message-ID: <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ralf Jung <post@ralfj.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:58=E2=80=AFAM Ralf Jung <post@ralfj.de> wrote:
> >> https://godbolt.org/z/rjaWc6EzG
> >
> > That example uses a compiler-specific attribute AFAIK, namely
> >
> >      __attribute__((noinline))
> >
> > When using compiler-specific attributes and options, the
> > original language is arguably no longer being used, depending
> > on the attribute. Though a language being inexpressive and
> > possibly requiring compiler extensions to achieve some goals,
> > possibly like in this C example, can be a disadvantage in itself.
>
> That attribute just exists to make the example small and fit in a single =
file.
> If you user multiple translation units, you can achieve the same effect w=
ithout
> the attribute. Anyway compilers promise (I hope^^) that that particular
> attribute has no bearing on whether the code has UB. So, the question of =
whether
> the program without the attribute has UB is still a very interesting one.
>
> At least clang treats this code as having UB, and one can construct a sim=
ilar
> example for gcc. IMO this is not backed by the standard itself, though it=
 can be
> considered backed by some defect reports -- but those were for earlier ve=
rsions
> of the standard so technically, they do not apply to C23.

That is fair. For C++26, I suspect that the behavior will actually
be officially defined as "erroneous behavior". For C, it is very
unfortunate if the compilers are more strict than the standard
in this case.

I wonder why if that is the case here. C and C++ (also before C++26)
differ on that subject. The differences between C and C++ have
likely caused bugs and issues for both compilers and users.
Though the cause could also be something else.

I am surprised that the C standard is lax on this point in some
cases. It is related to values that are or are not trap representations/
non-value representations, and variables that could or could
not be registers, as I understand one explanation I found.

> > Rust is more willing to break existing code in projects, causing
> > previously compiling projects to no longer compile. rustc does this
> > rarely, but it has happened, also long after Rust 1.0.
> >
> >  From last year, 2024.
> >
> >      https://internals.rust-lang.org/t/type-inference-breakage-in-1-80-=
has-not-been-handled-well/21374
> >          "Rust 1.80 broke builds of almost all versions of the
> >          very popular time crate (edit: please don't shoot the
> >          messenger in that GitHub thread!!!)
> >
> >          Rust has left only a 4-month old version working.
> >          That was not enough time for the entire Rust
> >          ecosystem to update, especially that older
> >          versions of time were not yanked, and users
> >          had no advance warning that it will stop working.
> >
> >          A crater run found a regression in over 5000 crates,
> >          and that has just been accepted as okay without
> >          any further action! This is below the level of stability
> >          and reliability that Rust should have."
> >
> > If C was willing to break code as much as Rust, it would be easier to
> > clean up C.
>
> Is that true? Gcc updates do break code.

Surely not as much as Rust, right? From what I hear from users
of Rust and of C, some Rust developers complain about
Rust breaking a lot and being unstable, while I instead
hear complaints about C and C++ being unwilling to break
compatibility.

Rust does admittedly a lot of the time have tools to
mitigate it, but Rust sometimes go beyond that.
C code from 20 years ago can often be compiled
without modification on a new compiler, that is a common
experience I hear about. While I do not know if that
would hold true for Rust code. Though Rust has editions.
The time crate breaking example above does not
seem nice.

> > A fear I have is that there may be hidden reliance in
> > multiple different ways on LLVM, as well as on rustc.
> > Maybe even very deeply so. The complexity of Rust's
> > type system and rustc's type system checking makes
> > me more worried about this point. If there are hidden
> > elements, they may turn out to be very difficult to fix,
> > especially if they are discovered to be fundamental.
> > While having one compiler can be an advantage in
> > some ways, it can arguably be a disadvantage
> > in some other ways, as you acknowledge as well
> > if I understand you correctly.
>
> The Rust type system has absolutely nothing to do with LLVM. Those are
> completely separate parts of the compiler. So I don't see any way that LL=
VM
> could possibly influence our type system.

Sorry for the ambiguity, I packed too much different
information into the same block.

> > You mention ossifying, but the more popular Rust becomes,
> > the more painful breakage will be, and the less suited
> > Rust will be as a research language.
>
> I do not consider Rust a research language. :)

It reminds me of Scala, in some ways, and some complained
about Scala having too much of a research and experimental
focus. I have heard similar complaints about Rust being
too experimental, and that was part of why they did not
wish to adopt it in some organizations. On the other hand,
Amazon Web Services and other companies already
use Rust extensively. AWS might have more than 300
Rust developer employed. The more usage and code,
the more painful breaking changes might be.

> > I hope that any new language at least has its
> > language developers ensure that they have a type
> > system that is formalized and proven correct
> > before that langauge's 1.0 release.
> > Since fixing a type system later can be difficult or
> > practically impossible. A complex type system
> > and complex type checking can be a larger risk in this
> > regard relative to a simple type system and simple
> > type checking, especially the more time passes and
> > the more the language is used and have code
> > written in it, making it more difficult to fix the language
> > due to code breakage costing more.
>
> Uff, that's a very high bar to pass.^^ I think there's maybe two language=
s ever
> that meet this bar? SML and wasm.

You may be right about the bar being too high.
I would have hoped that it would be easier to achieve
with modern programming language research and
advances.

> >>> There are some issues in Rust that I am curious as to
> >>> your views on. rustc or the Rust language has some type
> >>> system holes, which still causes problems for rustc and
> >>> their developers.
> >>>
> >>>       https://github.com/lcnr/solver-woes/issues/1
> >>>       https://github.com/rust-lang/rust/issues/75992
> >>>
> >>> Those kinds of issues seem difficult to solve.
> >>>
> >>> In your opinion, is it accurate to say that the Rust language
> >>> developers are working on a new type system for
> >>> Rust-the-language and a new solver for rustc, and that
> >>> they are trying to make the new type system and new solver
> >>> as backwards compatible as possible?
> >>
> >> It's not really a new type system. It's a new implementation for the s=
ame type
> >> system. But yes there is work on a new "solver" (that I am not involve=
d in) that
> >> should finally fix some of the long-standing type system bugs. Specifi=
cally,
> >> this is a "trait solver", i.e. it is the component responsible for dea=
ling with
> >> trait constraints. Due to some unfortunate corner-case behaviors of th=
e old,
> >> organically grown solver, it's very hard to do this in a backwards-com=
patible
> >> way, but we have infrastructure for extensive ecosystem-wide testing t=
o judge
> >> the consequences of any given potential breaking change and ensure tha=
t almost
> >> all existing code keeps working. In fact, Rust 1.84 already started us=
ing the
> >> new solver for some things
> >> (https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html) -- did you no=
tice?
> >> Hopefully not. :)
> >
> > If it is not a new type system, why then do they talk about
> > backwards compatibility for existing Rust projects?
>
> If you make a tiny change to a type system, is it a "new type system"? "n=
ew type
> system" sounds like "from-scratch redesign". That's not what happens.

I can see your point, but a different type system would be
different. It may be a matter of definition. In practice, the
significance and consequences would arguably depend on
how much backwards compatibility it has, and how many and
how much existing projects are broken.

So far, it appears to require a lot of work and effort for
some of the Rust language developers, and my impression
at a glance is that they have significant expertise, yet have
worked on it for years.

Best, VJ.

