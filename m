Return-Path: <linux-kernel+bounces-527384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B4EA40A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D118907E9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A512E7F;
	Sat, 22 Feb 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOSYHbNC"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991771C860E;
	Sat, 22 Feb 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244255; cv=none; b=JCPeFCpYtIolTm1pLG6HEI2sssHkm3xnUIgQE7WFlDq16gEh7BYGYvSM9R6gXbNRKqn9ne7rsJtMPuvxndjpaim0/vGML0AzldtxdfPdwkajMW3nnbAc4si5GWNVK53+L+BQt2L+jaQoHImiJWNiIyH8WWOXQFfJEkPMVwtCs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244255; c=relaxed/simple;
	bh=9UJIlQzWEWeZaZoQkoqjfKbkSaRGgqRajh7M2GfvB8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTlHA/MpDTPxRhMqXXNNRsDbSENwUXqOkz1QW9p0IoZwPa0aPcNNWvx6gcUgbaqS/jw8fvx1uffaohOEnBO4IdpcIS/AiEJ5GoNJpMLlf8HVmkjjNw8xwZSZysBwBOs0tejZI0NVcFzvBTZn23tDVW3heDaLKmIXGWLIiiKdfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOSYHbNC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0848d475cso436775085a.2;
        Sat, 22 Feb 2025 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740244252; x=1740849052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzwOqgEVL//qbVhcL4AuzpMdPs/1QN2mFO8F6wcbkGM=;
        b=dOSYHbNCwTK+9AsYhTWvreQ618ElXQuMhYpyjFjWWOWQhKzNWRROlflNaby1LE5Upq
         oI2jFEf2DmEjxPg2GfuvKVypAqhg6K6w4AHKR640AqFWPP1/KLoENcPZ+CUa2oslXZbl
         fqZ6fXT8x4ziK/ENPrwA+Uot3qnmAwwLm8W9hOD2eohYxYCkJilhv6NqwWbeY5iAz0T2
         5AmxCFdLi37s1HcKnxbWTGjAUwN1CE3zqIMD5FZq9uiGcrURT2Lw05vWTRXdCdugoQiH
         +C9FhhWRa0AKTNEHXcKtWfgTprMqVVDTozb+Rmoblptr2WlkhfJYY+LOeIL+94DfELJP
         pD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740244252; x=1740849052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzwOqgEVL//qbVhcL4AuzpMdPs/1QN2mFO8F6wcbkGM=;
        b=w/zpWhCCYNMEwHoKMnwbnh5n1mdIHffNCkQJzSxDtn7AcA4d1EtDORoOtegGGuXAAw
         feVqFrJPMIpP1Dz+n5lQlr1l1FL/bSlSWcuBWTRHddwV3UqZ9w2j80gKUO6cKnBjOOnZ
         Zbk1SRN3WcofXpQHoDOIohwzJbTh95wT14D0qGLbjEBr7Wt/qzoFg/4FjxCmIWfJi14l
         cx1IgvQSx9qT0pOqJlYzRlyCNS6mPU6oggrlKs7n1QXq7PQ19zOe1thcFxCcuxNIJgEZ
         wQMd1aF8h6qKOyl2iATzmiE0cCMCj2gTpzBxuwCMTGlAh+j2UruKREAZ0gmGfU5u63rD
         q1wA==
X-Forwarded-Encrypted: i=1; AJvYcCV/fZNJ1rOm4O6t54hd/66gFF0oGk5KKwiwxhUw0m+CxIPdOAJpVrvG2qJXKeXOIPWHhP/353lBxIYr33nqKVM=@vger.kernel.org, AJvYcCWL81EmxBMoAxLEr9/l3PTI+qsY7ybQ5ZzGif3TU1W4njfadUmefWkRM6rKFuJvcRD5YD1t0oKuxs03DlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+sUjN5qA6LWWbX9n6cGe+bLId5Pzb9x/gm8TJxiC7tQGa2wn
	yhgM1Pe39MPY5YeBD4lwhr4cetyJc8Ay7Dnec56y3wKvKF/s/BS1h5/Ou90yidyDha5XHMKtIEt
	RNB4DTEfUh4RHiTfb/VReRLapDQ0=
X-Gm-Gg: ASbGncvNKeegnQskiYaDlwGkhsaOUdOqs95pG0lehK5wdD19a27ZXZT6pOWoNxVEVqs
	ir1WEouaXzz2NBK41/9R4g50idnsfPl+fx7EJLLDmWnRNZqPH7hqp/sBpkktDaUiit2BWQLq4dI
	wKXDIrHZDp
X-Google-Smtp-Source: AGHT+IG3Z5Iz4lpwef1CynCtc91rGerNJS68MTuIsVCOxM3rPsqmJXDIPFGp9hRRbx3/Szvrf48YKtRvmcOTzlzOEIk=
X-Received: by 2002:a05:620a:4552:b0:7c0:c0b7:32fa with SMTP id
 af79cd13be357-7c0cef55ff4mr1409883285a.36.1740244252232; Sat, 22 Feb 2025
 09:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <sbcgis4vibueieejklfvv5zgz5omirryjyiynd5kloilxfygqb@zcqrjc6snxey>
In-Reply-To: <sbcgis4vibueieejklfvv5zgz5omirryjyiynd5kloilxfygqb@zcqrjc6snxey>
From: Ventura Jack <venturajack85@gmail.com>
Date: Sat, 22 Feb 2025 10:10:40 -0700
X-Gm-Features: AWEUYZmvxQDRI0yJ0AQlCoKpdyUsYldeK1UrrTHOzTE9PafVjARATh7Pv-gzoMs
Message-ID: <CAFJgqgTFoqH8kDquHjhKXCvsXrF-uoHo=bq52Fgv+MKePy4zhA@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 9:04=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Wed, Feb 19, 2025 at 06:39:10AM +0100, Greg KH wrote:
> > Rust isn't a "silver bullet" that will solve all of our problems, but i=
t
> > sure will help in a huge number of places, so for new stuff going
> > forward, why wouldn't we want that?
>
> The big thing we run into when trying to bring this to a practical
> systems language, and the fundamental reason the borrow checker looks
> the way it does, is Rice's theorem. Rice's theorem is a direct corollary
> of the halting problem - "any nontrivial property of a program is either
> a direct consequence of the syntax or undecidable".
>

How do runtime checks play into Rice's Theorem?
As far as I know, Rust has or can have a number of
runtime checks, for instance in some of the places
where a panic can happen.

The type system holes in the Rust type system, and
the bugs in rustc's solver, grates me a bit. A lot of
hard work is done in Rust language land on
fixing the type system holes and on a new
solver for rustc without the issues of the
current solver, while maintaining as much
backwards compatibility as possible. Difficult
work as I gather. The alternative GCC Rust
compiler, gccrs, is (as I gather) planned to
also use the new solver once it is ready. There
were some versions of rustc, also in 2020,
where compile times for some production Rust
projects went from fine to exponential, and
where it took some compiler work to mitigate
the issues, due to the issues being related to
holes in the type system.

The type systems and compilers of Haskell
and Scala look more robust to me. But, they
are reliant on GCs, making them irrelevant.
They also do not have affine types and borrow
checking as far as I know, unlike Rust, though
they may have experiments with it. Scala does
have dependent types.

The more complex a type system checker and
solver, the more difficult it can be to avoid
holes in the type system and bugs in the
solver. Hindley-Milner is great, also because it
is relatively simple, and has proofs for it and
its algorithms for type checking. Mainstream
programming languages inspired by
ML/Hindley-Milner do generally extend its type
system, often to provide more flexibility.

For anyone curious about the compile times and
type system issues, there are these examples:
https://github.com/lcnr/solver-woes/issues/1
https://github.com/rust-lang/rust/issues/75992

Best,  VJ.

