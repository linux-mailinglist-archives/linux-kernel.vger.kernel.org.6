Return-Path: <linux-kernel+bounces-532101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04045A448A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F216F5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6219922F;
	Tue, 25 Feb 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJSv+rNn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4516130C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504983; cv=none; b=I252vuiU0cchGt21dm25eCdbhJX0HessQxRHUqWzrf2faP6m2jv8q687FHpkruP23T8fwBzpa+BOE6xHkl3iRXwHDWGfxh1+vriq/h7nSGm5HWAMPU1FaLfFH3nV88tKTk59nE+qxhquc7Uqp43zVCOyKPdMxUdhu2KufnSy6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504983; c=relaxed/simple;
	bh=gOl/36Ytrp1zDSvgkiGrHn22n77JQLii4H7PNe1Rj8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM+1L8W0qxatG4tj1t1Msr5Kb5i0798PEJyxj6fUAJkLLFkgQ+5OPBIEYX7Kx2/82xSevit42on9h+KQEdYx967rq0E/f6K2Hg5x26T0k1VruCxdtme2pyN8ihFSpW4M192XKs/6cwYWeaeF7vrYP3CLQVPQfQDwJ/SQMg3TpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJSv+rNn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso59898045e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740504979; x=1741109779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb7TDT/aVvgdtxg6kdFOwwgVqkaL6U92QY48yAXPGLY=;
        b=AJSv+rNnAStmwd6xYcjFg/j9ptQuRMvrGj5oFP2Y67J5jQNKVjx1/X3hLWpZJ1aLlZ
         kCDc0UliYwjo6nsAMVz9JsYHqYM4gqy7sJZl5AYpMjOfvBHdfqmZICEY7+VmlBzK+TXy
         xeM4QRyl4yciqbaFTuqV4JLL2X1zQ+3XXlb4u35zBszbdyuCTZLJY4BmFyq9G4uMb3Sq
         /SVQfwqALAeZ+QI66MC5jXl4SyjO1hljM1XISQgIO/U1LBwT1Vcs1xqKwlmm9GG9cDao
         DeXX9Xdzd3uCzwxU4TzyflUIR26oAW0k1tYn94TVULrcGJah6q8sKhRbxb9VSjMzxgn9
         srbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504979; x=1741109779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb7TDT/aVvgdtxg6kdFOwwgVqkaL6U92QY48yAXPGLY=;
        b=oO+MIF3YfQyKGFM+CWDPwk26/4nWaBQtkUpQzsM5fNdUINvrKmKYfOVBXc9yaTHEFZ
         van1J9euRw7nBx3Rdt+/V3uk/os00io4XAf9K7d0/7UvE8ABjkFp3qYzECW2tJi2AUge
         77+QfxFUHXLTk2UByQ9XloqQK/4qtOlXDb6edNIVuw7xaNQaDrJ8o1E8gUa/FBCVYByD
         cr5G/4DI4Mkf2Ovs2agx1qWuVVtk2Ex7h2uIcuLxGzN5CfXpt8DSgRh9q+z9uxcMLEYe
         +1ovtA2Ix9AHIYWX2TqrUcWOTcb8ue2zgqJluCOQ0/ULl37A7wQfQ1/2KIOTanfTPAkG
         nWAA==
X-Forwarded-Encrypted: i=1; AJvYcCVY2ylzerhbjfoIjBA1v/X5wk7J8o1EOMdGkuoaZ7wfgk8vd9C7ERdwwJE77fsrjkpGxAC3U/sDUZ/n4ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gpxMS2ntP819XigWH+aWsECYFchQV54amrocP2G9UrNjtcIV
	K+F7meS+gWVB5jmb7QPxq2J1hmMPyvV3UFq9pIMeRkBRCx2RQ3Ee4sF5sPcWAUSRGkKfke8u/AN
	fPj6Bnm27b8n6UNQ5igC9pgKsIJIu2aqLLCxQ
X-Gm-Gg: ASbGncvFcx6k9Os9LRoZJaJKbH5x/5u1MuIse9jr/0jbsgit0gZYdcyZ4bXtdYG09RN
	7oHE83Ee3RQNDbqsyrDhJys94ndPjdcCYLW7s4nx62/eJ8ajH+WMz8MRGg+Ug7AQUdtLpSUzhAb
	zJXp7gJQXZDF/E/JsHZ92TvqB80pPtasoSas+Pzg==
X-Google-Smtp-Source: AGHT+IEKeLbYDcWbkUCjv9WAAKpj5i9urIXFAIil9bTEvJFu6/6yC9kyIte/8TvLmHWUW8IDBAxxehZuyfy5A6xga1I=
X-Received: by 2002:a05:600c:1d8c:b0:439:98ca:e39b with SMTP id
 5b1f17b1804b1-43ab44b58c3mr31936975e9.29.1740504979330; Tue, 25 Feb 2025
 09:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com> <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
In-Reply-To: <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 18:36:07 +0100
X-Gm-Features: AQ5f1Jrk5Ircg0d1PeSghOYiJs5Q14TTxoym4eosxDvw1DHTRuGD27YpgvptUqQ
Message-ID: <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:21=E2=80=AFPM Ventura Jack <venturajack85@gmail.c=
om> wrote:
>
> On Tue, Feb 25, 2025 at 9:12=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Sun, Feb 23, 2025 at 4:30=E2=80=AFPM Ventura Jack <venturajack85@gma=
il.com> wrote:
> > >
> > > Just to be clear and avoid confusion, I would
> > > like to clarify some aspects of aliasing.
> > > In case that you do not already know about this,
> > > I suspect that you may find it very valuable.
> > >
> > > I am not an expert at Rust, so for any Rust experts
> > > out there, please feel free to point out any errors
> > > or mistakes that I make in the following.
> > >
> > > The Rustonomicon is (as I gather) the semi-official
> > > documentation site for unsafe Rust.
> > >
> > > Aliasing in C and Rust:
> > >
> > > C "strict aliasing":
> > > - Is not a keyword.
> > > - Based on "type compatibility".
> > > - Is turned off by default in the kernel by using
> > >     a compiler flag.
> > >
> > > C "restrict":
> > > - Is a keyword, applied to pointers.
> > > - Is opt-in to a kind of aliasing.
> > > - Is seldom used in practice, since many find
> > >     it difficult to use correctly and avoid
> > >     undefined behavior.
> > >
> > > Rust aliasing:
> > > - Is not a keyword.
> > > - Applies to certain pointer kinds in Rust, namely
> > >     Rust "references".
> > >     Rust pointer kinds:
> > >     https://doc.rust-lang.org/reference/types/pointer.html
> > > - Aliasing in Rust is not opt-in or opt-out,
> > >     it is always on.
> > >     https://doc.rust-lang.org/nomicon/aliasing.html
> > > - Rust has not defined its aliasing model.
> > >     https://doc.rust-lang.org/nomicon/references.html
> > >         "Unfortunately, Rust hasn't actually
> > >         defined its aliasing model.
> > >         While we wait for the Rust devs to specify
> > >         the semantics of their language, let's use
> > >         the next section to discuss what aliasing is
> > >         in general, and why it matters."
> > >     There is active experimental research on
> > >     defining the aliasing model, including tree borrows
> > >     and stacked borrows.
> > > - The aliasing model not being defined makes
> > >     it harder to reason about and work with
> > >     unsafe Rust, and therefore harder to avoid
> > >     undefined behavior/memory safety bugs.
> >
> > I think all of this worrying about Rust not having defined its
> > aliasing model is way overblown. Ultimately, the status quo is that
> > each unsafe operation that has to do with aliasing falls into one of
> > three categories:
> >
> > * This is definitely allowed.
> > * This is definitely UB.
> > * We don't know whether we want to allow this yet.
> >
> > The full aliasing model that they want would eliminate the third
> > category. But for practical purposes you just stay within the first
> > subset and you will be happy.
> >
> > Alice
>
> Is there a specification for aliasing that defines your first bullet
> point, that people can read and use, as a kind of partial
> specification? Or maybe a subset of your first bullet point, as a
> conservative partial specification? I am guessing that stacked
> borrows or tree borrows might be useful for such a purpose.
> But I do not know whether either of stacked borrows or tree
> borrows have only false positives, only false negatives, or both.

In general I would say read the standard library docs. But I don't
know of a single resource with everything in one place.

Stacked borrows and tree borrows are attempts at creating a full model
that puts everything in the two first categories. They are not
conservative partial specifications.

> For Rust documentation, I have heard of the official
> documentation websites at
>
>     https://doc.rust-lang.org/book/
>     https://doc.rust-lang.org/nomicon/
>
> And various blogs, forums and research papers.
>
> If there is no such conservative partial specification for
> aliasing yet, I wonder if such a conservative partial
> specification could be made with relative ease, especially if
> it is very conservative, at least in its first draft. Though there
> is currently no specification of the Rust language and just
> one major compiler.
>
> I know that Java defines an additional conservative reasoning
> model for its memory model that is easier to reason about
> than the full memory model, namely happens-before
> relationship. That conservative reasoning model is taught in
> official Java documentation and in books.

On the topic of conservative partial specifications, I like the blog
post "Tower of weakenings" from back when the strict provenance APIs
were started, which I will share together with a quote from it:

> Instead, we should have a tower of Memory Models, with the ones at the to=
p being =E2=80=9Cwhat users should think about and try to write their code =
against=E2=80=9D. As you descend the tower, the memory models become increa=
singly complex or vague but critically always more permissive than the ones=
 above it. At the bottom of the tower is =E2=80=9Cwhatever the compiler act=
ually does=E2=80=9D (and arguably =E2=80=9Cwhatever the hardware actually d=
oes=E2=80=9D in the basement, if you care about that).
> https://faultlore.com/blah/tower-of-weakenings/

You can also read the docs for the ptr module:
https://doc.rust-lang.org/stable/std/ptr/index.html

> On the topic of difficulty, even if there was a full specification,
> it might still be difficult to work with aliasing in unsafe Rust.
> For C "restrict", I assume that "restrict" is fully specified, and
> C developers still typically avoid "restrict". And for unsafe
> Rust, the Rust community helpfully encourages people to
> avoid unsafe Rust when possible due to its difficulty.

This I will not object to :)

Alice

