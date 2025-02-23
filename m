Return-Path: <linux-kernel+bounces-527810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F769A40FB9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5373B6885
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4B757F3;
	Sun, 23 Feb 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIeuIeRh"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF277F11;
	Sun, 23 Feb 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328126; cv=none; b=k36Z6BsKecP85T7s4vGkkCXPzYOsZjkPIKFhtC9RsnsRC+5jEVfYn0pw85VhaOc3kry5nMnM+cRp1waBZiHDqnzPQV/qg/fd31pbY6Tf5VUZA49YxWZR0MKMzAhO+Np1i2Qza5TsfTXF4tZHQe0Dbou0/nc9iMGX+KUTGqjA1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328126; c=relaxed/simple;
	bh=9V+q/vBhZA/s0rwHpz4hQbZg0+tfZt1XibbKoMbOltE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJ798GLPncnYHXC+arP7wYcvbVNp4DUNluhafrkmpilPDY87mSyErq9kKfG/PsgTJt2LxOtiZgIGyWwY9n9Y0ncz0MR8HpcTrwlVYOkmUydUvFK+NZ976JLCOPkQz9pUyDsyTecbEaUbYKcNrw43Z3yefdT+0hmVEFYlnSiQI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIeuIeRh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so21144995e9.1;
        Sun, 23 Feb 2025 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740328123; x=1740932923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxe4W98+89Vo2TYux7Hk7SbR8tooZt/k4ugumN31cEY=;
        b=aIeuIeRhtPcdiZyugG/0t5udXfnK5E6uPQoQgD3RDL7cSfZbE6la/gqCCp4beMbgD1
         ztYOgUBiaSSCjibungLcmvGPzWtlJ3X8CndasYc8pnkugD14Bq5SC5WIwWwj33xCQsF5
         GbhmGb4VjzpVEMmYNZy7c0dc7qbdHSTWRgfApJVIRNsKg0O9fBY7KhWSePegUIF/0ZiG
         TvgjbXXNzDbdLnQ2jfADTvGU1gXVZRmsQkQKT1tq+NOiDox3QjYuQ2sEwip3orV9AMWF
         MGkl/lOYYSg9hempG5WqltWoanWn8/9IIs53mVHEwUkdhj8KXpTVAjcM8xvEShPTgiiu
         ZDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328123; x=1740932923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxe4W98+89Vo2TYux7Hk7SbR8tooZt/k4ugumN31cEY=;
        b=L5zPocEsYVl8V7b8OF/vo8a8JVykbm1q3EOuE/6zgvLiG34gQKtUZsSKD15b0Zlcd3
         xLhOjpvX9tMk6IpWDcz+XsMy530LdoS2oqQcFthO98bZrAzbZp7Vjl+2QuWEjyo7J2eT
         6PFJv2q8fRFpMTcZKtQeTQpza1k8ieMePgB0jvazbPNXdl60S0QmIyiwug4nCYRRZBmD
         dLZ4r9gfrjGLXDAYTyNF4rmyIg9szb+lfw/F0Z/B2oYQx0wyICz7Ku+xPoVyGAFpWlqG
         hXNooruskwSdGUC0e3iv4A/44ubwfRvi74gtq/YhiXaaYIfXa+vQi5tPjMrgo3H2NAIW
         /hhw==
X-Forwarded-Encrypted: i=1; AJvYcCU7rNk6+A/4NoIOo31rbrA97xHZ5FphkcWC+q3U+vbvP/NoHEihBIE7837utJ6txZ/k7n16324zFz4gFkTPhgA=@vger.kernel.org, AJvYcCUk0C6j6azseXpU6wJfrg6e4LMtT4H1uGnXYmYqNDoIYn3SOVf1lLZPvhI+yhBvdd2wQ4VCgORNVC919C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIl5Y79zZitoC3C/DSnJh0jZcaCgtFiL7cOrMzI78Yf9dMInz3
	70BOTOmPriyiceeqGccz2+0Du9sYfX3vaP+GugBXNAD0tGuRb6zk
X-Gm-Gg: ASbGncsm/e4eiF9UZkbs15rDN8gsvb38MnS45Bg8qS/Y0y611bHT6gxih0Lqkk3LNg0
	mXoQbk8I55ULBRh7bJT3Y1KPSRapJv+ulo8rIjPaC2wYtXPuYd/FbfKqPte+9V6ZScXG8sxjtTZ
	mMmok/62OiQkM1EJPguOE6ktFD4FrVaq2JgsrGq/uBTP5VrtSnnR77bktRvH+ngrMrcjlWkEppw
	397JfpVQuNi2AUTwNOCO0ny0kPARnikmjMHBgCG7f9ZwKGEh8/zJPZiMXxw5M49PB0Tmb6UMssm
	BOHX3bhacw5dX55oexAyBXgJ8gT4GM2EhE7qoKT8zyozZdGqaQlQ6jUspvYjGOus
X-Google-Smtp-Source: AGHT+IHusnDhMfezBKa1GaRoQDGxJIaOIolVe9haNHnmrDScQCnxTZ3ixg6XiD7yYrKMnNBX4CJ1Bg==
X-Received: by 2002:a7b:cb48:0:b0:439:9384:7d08 with SMTP id 5b1f17b1804b1-439a2eb3e29mr118890165e9.2.1740328122319;
        Sun, 23 Feb 2025 08:28:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d6837sm80730105e9.13.2025.02.23.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:28:41 -0800 (PST)
Date: Sun, 23 Feb 2025 16:28:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ventura Jack <venturajack85@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, ej@inai.de,
 gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250223162839.056f75d5@pumpkin>
In-Reply-To: <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2025 08:30:06 -0700
Ventura Jack <venturajack85@gmail.com> wrote:

> Just to be clear and avoid confusion, I would
> like to clarify some aspects of aliasing.
> In case that you do not already know about this,
> I suspect that you may find it very valuable.
>=20
> I am not an expert at Rust, so for any Rust experts
> out there, please feel free to point out any errors
> or mistakes that I make in the following.
>=20
> The Rustonomicon is (as I gather) the semi-official
> documentation site for unsafe Rust.
>=20
> Aliasing in C and Rust:
>=20
> C "strict aliasing":
> - Is not a keyword.
> - Based on "type compatibility".
> - Is turned off by default in the kernel by using a compiler flag.

My understanding is that 'strict aliasing' means that the compiler can
assume that variables of different types do not occupy the same memory.
The exception is that all single byte accesses can alias any other
data (unless the compiler can prove otherwise [1]).
The kernel sets no-strict-aliasing to get the historic behaviour where
the compiler has to assume that any two memory accesses can overlap.

Consider an inlined memcpy() copying a structure containing (say) double.
If it uses char copies all is fine.
If it uses int copies the compiler can re-order the 'int' accesses w.r.t
the 'double' ones (and can entirely optimise away some writes).
This is just plain broken.

You also get the reverse problem trying to populate byte sized fields in
one structure from another, the accesses don't get interleaved because
the writes have to be assumed to be writing into the source structure.
I've tried using int:8 - doesn't help.
"restrict" might help, but I remember something about it not working
when a function is inlined - it is also the most stupid name ever.

[1] I have some code where there are two static arrays that get
indexed by the same value (they are separated by the linker).
If you do:
	b =3D a->b;
the compiler assumes that a and b might alias each other.
OTOH take the 'hit' of the array multiply and do:
	b =3D &static_b[a->b_index];
and it knows they are separate.
(In my case it might know that 'a' is also static data.)
But there is no way to tell the compiler that 'a' and 'b' don't overlap.

	David

>=20
> C "restrict":
> - Is a keyword, applied to pointers.
> - Is opt-in to a kind of aliasing.
> - Is seldom used in practice, since many find
>     it difficult to use correctly and avoid
>     undefined behavior.
>=20
> Rust aliasing:
> - Is not a keyword.
> - Applies to certain pointer kinds in Rust, namely
>     Rust "references".
>     Rust pointer kinds:
>     https://doc.rust-lang.org/reference/types/pointer.html
> - Aliasing in Rust is not opt-in or opt-out,
>     it is always on.
>     https://doc.rust-lang.org/nomicon/aliasing.html
> - Rust has not defined its aliasing model.
>     https://doc.rust-lang.org/nomicon/references.html
>         "Unfortunately, Rust hasn't actually
>         defined its aliasing model.
>         While we wait for the Rust devs to specify
>         the semantics of their language, let's use
>         the next section to discuss what aliasing is
>         in general, and why it matters."
>     There is active experimental research on
>     defining the aliasing model, including tree borrows
>     and stacked borrows.
> - The aliasing model not being defined makes
>     it harder to reason about and work with
>     unsafe Rust, and therefore harder to avoid
>     undefined behavior/memory safety bugs.
> - Rust "references" are common and widespread.
> - If the aliasing rules are broken, undefined
>     behavior and lack of memory safety can
>     happen.
> - In safe Rust, if aliasing rules are broken,
>     depending on which types and functions
>     are used, a compile-time error or UB-safe runtime
>     error occurs. For instance, RefCell.borrow_mut()
>     can panic if used incorrectly. If all the unsafe Rust
>     code and any safe Rust code the unsafe Rust
>     code relies on is implemented correctly, there is
>     no risk of undefined behavior/memory safety bugs
>     when working in safe Rust.
>=20
>     With a few caveats that I ignore here, like type
>     system holes allowing UB in safe Rust, and no
>     stack overflow protection if #![no_std] is used.
>     Rust for Linux uses #![no_std].
> - The correctness of unsafe Rust code can rely on
>     safe Rust code being correct.
>     https://doc.rust-lang.org/nomicon/working-with-unsafe.html
>         "Because it relies on invariants of a struct field,
>         this unsafe code does more than pollute a whole
>         function: it pollutes a whole module. Generally,
>         the only bullet-proof way to limit the scope of
>         unsafe code is at the module boundary with privacy."
> - In unsafe Rust, it is the programmer's responsibility
>     to obey the aliasing rules, though the type system
>     can offer limited help.
> - The aliasing rules in Rust are possibly as hard or
>     harder than for C "restrict", and it is not possible to
>     opt out of aliasing in Rust, which is cited by some
>     as one of the reasons for unsafe Rust being
>     harder than C.
> - It is necessary to have some understanding of the
>     aliasing rules for Rust in order to work with
>     unsafe Rust in general.
> - Many find unsafe Rust harder than C:
>     https://chadaustin.me/2024/10/intrusive-linked-list-in-rust/
>     https://lucumr.pocoo.org/2022/1/30/unsafe-rust/
>     https://youtube.com/watch?v=3DDG-VLezRkYQ
>     Unsafe Rust being harder than C and C++ is a common
>     sentiment in the Rust community, possibly the large
>     majority view.
> - Some Rust developers, instead of trying to understand
>     the aliasing rules, may try to rely on MIRI. MIRI is
>     similar to a sanitizer for C, with similar advantages and
>     disadvantages. MIRI uses both the stacked borrow
>     and the tree borrow experimental research models.
>     MIRI, like sanitizers, does not catch everything, though
>     MIRI has been used to find undefined behavior/memory
>     safety bugs in for instance the Rust standard library.
>=20
> So if you do not wish to deal with aliasing rules, you
> may need to avoid the pieces of code that contains unsafe
> Rust.
>=20
> Best, VJ.
>=20
> On Sat, Feb 22, 2025 at 12:18=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, 22 Feb 2025 at 10:54, Kent Overstreet <kent.overstreet@linux.de=
v> wrote: =20
> > >
> > > If that work is successful it could lead to significant improvements =
in
> > > code generation, since aliasing causes a lot of unnecessary spills and
> > > reloads - VLIW could finally become practical. =20
> >
> > No.
> >
> > Compiler people think aliasing matters. It very seldom does. And VLIW
> > will never become practical for entirely unrelated reasons (read: OoO
> > is fundamentally superior to VLIW in general purpose computing).
> >
> > Aliasing is one of those bug-bears where compiler people can make
> > trivial code optimizations that look really impressive. So compiler
> > people *love* having simplistic aliasing rules that don't require real
> > analysis, because the real analysis is hard (not just expensive, but
> > basically unsolvable).
> >
> > And they matter mainly on bad CPUs and HPC-style loads, or on trivial
> > example code. And for vectorization.
> >
> > And the sane model for those was to just have the HPC people say what
> > the aliasing rules were (ie the C "restrict" keyword), but because it
> > turns out that nobody wants to use that, and because one of the main
> > targets was HPC where there was a very clear type distinction between
> > integer indexes and floating point arrays, some "clever" person
> > thought "why don't we use that obvious distinction to say that things
> > don't alias". Because then you didn't have to add "restrict" modifiers
> > to your compiler benchmarks, you could just use the existing syntax
> > ("double *").
> >
> > And so they made everything worse for everybody else, because it made
> > C HPC code run as fast as the old Fortran code, and the people who
> > cared about DGEMM and BLAS were happy. And since that was how you
> > defined supercomputer speeds (before AI), that largely pointless
> > benchmark was a BigDeal(tm).
> >
> > End result: if you actually care about HPC and vectorization, just use
> > 'restrict'. If you want to make it better (because 'restrict'
> > certainly isn't perfect either), extend on the concept. Don't make
> > things worse for everybody else by introducing stupid language rules
> > that are fundamentally based on "the compiler can generate code better
> > by relying on undefined behavior".
> >
> > The C standards body has been much too eager to embrace "undefined beha=
vior".
> >
> > In original C, it was almost entirely about either hardware
> > implementation issues or about "you got your pointer arithetic wrong,
> > and the source code is undefined, so the result is undefined".
> > Together with some (very unfortunate) order of operations and sequence
> > point issues.
> >
> > But instead of trying to tighten that up (which *has* happened: the
> > sequence point rules _have_ actually become better!) and turning the
> > language into a more reliable one by making for _fewer_ undefined or
> > platform-defined things, many C language features have been about
> > extending on the list of undefined behaviors.
> >
> > The kernel basically turns all that off, as much as possible. Overflow
> > isn't undefined in the kernel. Aliasing isn't undefined in the kernel.
> > Things like that.
> >
> > And making the rules stricter makes almost no difference for code
> > generation in practice. Really. The arguments for the garbage that is
> > integer overflow or 'strict aliasing' in C were always just wrong.
> >
> > When 'integer overflow' means that you can _sometimes_ remove one
> > single ALU operation in *some* loops, but the cost of it is that you
> > potentially introduced some seriously subtle security bugs, I think we
> > know it was the wrong thing to do.
> >
> >              Linus =20


