Return-Path: <linux-kernel+bounces-534579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76022A468C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E3188D45B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E822A7EB;
	Wed, 26 Feb 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fp8DG3mp"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA122B8B3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592804; cv=none; b=BmCbPt4ZYuETLjmh0FuNmSoLu3B8rmC0jhaDZy6O7HxNMuVF3J6qN9ajX3I/9C7XlIKXuMw3Dnqa4gh1uE1NbUJ3sPoJ6o02m0DlQaTpGJX2ZFI8zmVF8qpHIDm/aoJvpJiFfF/NrYZPXfWXFWrYD6IHo0S5s7sWRSLgsaQhPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592804; c=relaxed/simple;
	bh=OcHOvGQB/t3qwwXBib/RirE/KtrFLYIGCcrfx/cQcj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe3rQ5u6n5LOZZYpeyRgeR3ydqiKBEWVcG7Vt6oQKWOsyNswLJPW102JxVhj8EzK938tWEGYCBpec84XWulCXB15h7vu3xf/5Pv8xqeYnfe+0yDbSEOF74r/1GWuET/Xxc/RqnBHgK29HpHTxTkc6w8YmNLtM4TLlT/6tZzgwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fp8DG3mp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaecf50578eso1414765366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740592800; x=1741197600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2pF5VtPLvizqkjhJdWgYLaGhWqd4Ef/Qdw8QfNuuuk=;
        b=Fp8DG3mpq4+AaO0TnTg0vYO6ZzCsE1EcC+M74IPo7Ae9rmopLsZyQR3j1oY09Vzs+I
         6uSDNH57szH53KmN98BLmtvI/M4TVc03GrNSFLjoC/HT0kiqPFwoww3+KfCgWmCVUAKT
         yY/Z8Kjyd3aJWO7xKiV/SnTQuVR6qe8cu+T2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592800; x=1741197600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2pF5VtPLvizqkjhJdWgYLaGhWqd4Ef/Qdw8QfNuuuk=;
        b=DdbLReR/T2whPhFjr/rQ9twYZDgkBGSuYWsnEHq0Mrr9fPeTNh91h1BhJ2ni9cZhcr
         W+WtVaUt2eY5I0pIJGwjOwG4znVDS3sBOX51ZVzCyBn/e5Gm/nR6szip4s0g8OyFDB8o
         Mv9d4hBYdB3xnu9n6BamqqOVzMeetlj3so0z2r9SPXp/94avcSAfFFjQmjf6t6bkXSaN
         wId3iZYhQfU38CB/HWoTZeBahQgBoCCJ/wrQspI/kY11yIavd0or326cdX9ZYkIi9n1l
         ruCBkNFxSq/V3YQBjRw3KdlqxMT4qt0qDcyDdMKtkhB8hG8EcQ989sx05zDXZkQuh15d
         /FKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOujdio6DMtrs+s4smNFJiKvw93MzOwACHGMgFwdpavaTRr8YUrXn7/mvtc1gL7ZetNHlb/nmIBMML5tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsNhWQ0WgAjhAJ0yDOTyAr4CmUZmoMBfQy0aO7I4XAMFSbTBb
	F81eYTZhsLCFy3tmLVP78VZ3V+s+TfcNfLtklj5YIXuBSt1cY9fHAfdG2Zdqo0ecU+mA2ubUQVg
	35Zs=
X-Gm-Gg: ASbGncuLH3WWAbZNqVt7pj+RjoEsTtCIo4V6RjC18LkE+8M843jzKJcHZ0Q+HUMWR/4
	QBD2pvxtEj7ZX+w4x+fA9zIMB906jy2ayf0mzKb60zngOyC+vM8VolLo7L5GBlV69Co5ElXow4R
	qzRWhgn7WcgErmXIhqymwtFbxQmN8r8wvMpFA+jI4INRLMIVvn2v0/siG7FEkcMwyJbUtvFe9M0
	M3zNka365jLFNr56+AKg4Mk1ACRC21HOJnnwK2G9EjVbUHe4qsfZB1llDnWXGFuT1FuFzVuut0U
	99Q8q1SId7CWM2AHapgTeRR3J2UQ8R6/mpUpitwQtAJ5/tnG2je5TlaSKWf4DYbRKastT43KacE
	w
X-Google-Smtp-Source: AGHT+IF3VYf7qIAsthu+C02irGIsYcIu00hkAND+ANmur58J3UdMCX/aLnXbHlXfR3CYIeAiBoTtcQ==
X-Received: by 2002:a17:907:7e96:b0:abc:ad5:c with SMTP id a640c23a62f3a-abc0d9956d4mr2406481366b.3.1740592800200;
        Wed, 26 Feb 2025 10:00:00 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205d7afsm367410266b.140.2025.02.26.09.59.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:59:58 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf06950db5so1135366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:59:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWMyBdm43BmQCndvFSwh4Zc2wcCmJ5gvYq54uYMoOy60VoQFFwEdWWEyJPHWqLnPjHDyb8bhYYZcvrLew=@vger.kernel.org
X-Received: by 2002:a17:906:308e:b0:ab6:511d:8908 with SMTP id
 a640c23a62f3a-abc0de19516mr1960252766b.40.1740592798401; Wed, 26 Feb 2025
 09:59:58 -0800 (PST)
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
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com> <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
In-Reply-To: <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 09:59:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
X-Gm-Features: AQ5f1JqHaF8iBdXsZjiLGeP-Wg76QW9xhjWAhICZNldwiZDCjoY2SKOw5r5wwWM
Message-ID: <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ralf Jung <post@ralfj.de>
Cc: Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 05:54, Ralf Jung <post@ralfj.de> wrote:
>
>      The only approach we know that we can actually
> pull through systematically (in the sense of "at least in principle, we can
> formally prove this correct") is to define the "visible behavior" of the source
> program, the "visible behavior" of the generated assembly, and promise that they
> are the same.

That's literally what I ask for with that "naive" code generation, you
just stated it much better.

I think some of the C standards problems came from the fact that at
some point the standards people decided that the only way to specify
the language was from a high-level language _syntax_ standpoint.

Which is odd, because a lot of the original C semantics came from
basically a "this is how the result works". It's where a lot of the
historical C architecture-defined (and undefined) details come from:
things like how integer division rounding happens, how shifts bigger
than the word size are undefined, etc. But most tellingly, it's how
"volatile" was defined.

I suspect that what happened is that the C++ people hated the volatile
definition *so* much (because of how they changed what an "access"
means), that they then poisoned the C standards body against
specifying behavior in terms of how the code *acts*, and made all
subsequent C standards rules be about some much more abstract
higher-level model that could not ever talk about actual code
generation, only about syntax.

And that was a fundamental shift, and not a good one.

It caused basically insurmountable problems for the memory model
descriptions. Paul McKenney tried to introduce the RCU memory model
requirements into the C memory model discussion, and it was entirely
impossible. You can't describe memory models in terms of types and
syntax abstractions. You *have* to talk about what it means for the
actual code generation.

The reason? The standards people wanted to describe the memory model
not at a "this is what the program does" level, but at the "this is
the type system and the syntactic rules" level. So the RCU accesses
had to be defined in terms of the type system, but the actual language
rules for the RCU accesses are about how the data is then used after
the load.

(We have various memory model documentation in
tools/memory-model/Documentation and that goes into the RCU rules in
*much* more detail, but simplified and much shortened: a
"rcu_dereference()" could be seen as a much weaker form of
"load_acquire": it's a barrier only to accesses that are
data-dependencies, and if you turn a data dependency into a control
dependency you have to then add specific barriers.

When a variable access is no longer about "this loads this value from
memory", but is something much more high-level, trying to describe
that is complete chaos. Plus the description gets to be so abstract
that nobody understands it - neither the user of the language nor the
person implementing the compiler.

So I am personally - after having seen that complete failure as a
by-stander - 100% convinced that the semantics of a language *should*
be defined in terms of behavior, not in terms of syntax and types.
Sure, you have to describe the syntax and type system *too*, but then
you use those to explain the behavior and use the behavior to explain
what the allowable optimizations are.

> So the Rust compiler promises nothing about the shape of the assembly
> you will get, only about its "visible" behavior

Oh, absolutely. That should be the basic rule of optimization: you can
do anything AT ALL, as long as the visible behavior is the same.

> (and which exact memory access occurs when is generally
> not considered "visible").

.. but this really has to be part of it. It's obviously part of it
when there might be aliases, but it's also part of it when there is
_any_ question about threading and/or memory ordering.

And just as an example: threading fundamentally introduces a notion of
"aliasing" because different *threads* can access the same location
concurrently. And that actually has real effects that a good language
absolutely needs to deal with, even when there is absolutely *no*
memory ordering or locking in the source code.

For example, it means that you cannot ever widen stores unless you
know that the data you are touching is thread-local. Because the bytes
*next* to you may not be things that you control.

It also *should* mean that a language must never *ever* rematerialize
memory accesses (again, unless thread-local).

Seriously - I consider memory access rematerialization a huge bug, and
both a security and correctness issue. I think it should be expressly
forbidden in *any* language that claims to be reliablel.
Rematerialization of memory accesses is a bug, and is *hugely* visible
in the end result. It introduces active security issues and makes
TOCTOU (Time-of-check to time-of-use) a much bigger problem than it
needs to be.

So memory accesses need to be part of the "visible" rules.

I claim that C got that right with "volatile". What C got wrong was to
move away from that concept, and _only_ have "volatile" defined in
those terms. Because "volatile" on its own is not very good (and that
"not very good" has nothing to do with the mess that C++ made of it).

              Linus

