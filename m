Return-Path: <linux-kernel+bounces-527785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4EA40F73
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251F6188C8B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A522612;
	Sun, 23 Feb 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj4rfZ8e"
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784E250EC;
	Sun, 23 Feb 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740324622; cv=none; b=bgiRikkyBgAKsK5K6T7CMS7uUqpCsN76w+/gWdlYg5dMMsbIUAAyTOr1SePwtqqzEq6q0Ggoj3rF5T0GtYz50zaM9Xy1KGOxZTo6hOYReh7vvIdkBPawPR7xfHK7GHccr6IAdbCh2EpiOjrmsnSseqApKTqLJq0RGobtbOe29H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740324622; c=relaxed/simple;
	bh=W/+HdFCp0Wm3kBZ3uJhoiiNndHLg5cZr3jbvblrGjIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha8fx0lS0N2k2WTf3UkS6czsKiglr88GkYu3BgIZ93B88MTvKs5gRHFKsy0PFYXiLqPWe4MNrdgItl0Gecg3IYsXbt9cMane5LizQVDQWQIOIhSHyUS+P7QmJ6Tc1BJV5KbIutXlzXoOYdM7jK4KXHW6cMISBZ5yCcswNYXWE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj4rfZ8e; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-472242b0da5so24948791cf.1;
        Sun, 23 Feb 2025 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740324619; x=1740929419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktXdwipRa22g1NOcTaL8DjwNU8y90d7l1/3pSHmXnxc=;
        b=dj4rfZ8efQzyg609mqRwGj7f0y3XRuafJsZumOKzVIVDY4ymvr8dA5afRdAoSLT5iu
         KFbqGei8zCY9GxmE7s70DGN6sDg7nj44gZbdNYmI8o+YE5isdZYW28VfFhYcOovSTNGu
         t2KlwPbexaj7bsMIIKiyksLRuhzQy3CYZo3OCZGyWO9pX4gsc20CkpzJ+YyG8+eYbH2S
         m5VedjTIpnNdKtkMh+x5T/x65RYA8sLkt02cd2ImJH4/lXA4SJwo5jsijnLav+EbOHqq
         /K5+qEwaeKumBMOtbdxcp2XQK8ZG8NiPicx35NNrVdrEbBfmikpPO3rViC4gvM6+X2gm
         k7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740324619; x=1740929419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktXdwipRa22g1NOcTaL8DjwNU8y90d7l1/3pSHmXnxc=;
        b=hXnuWFGn18BTvr6EfKbiuEG4xuNBaJ/lD6JQyuNsfsygVvnz9h+P7WBveOdn3Qmeoz
         g7XeAsTh2cb9BbPxTOKZuf2fCM3ejCcsdDu/jNaTtzksV20Jv6RFtxVMmQKCE6QkRZZ8
         pPcgx1aVmlzCzbdJCprwZLgdg3qqmGabvjw/C+8BOXN64eU11RI7+VYg/0WC3kzyKNpX
         zxtugSv/OFEKtQeO1zBzz99TqKs8ANpZRqVWuubT9pXgsS8MTL/nCfaPAbYMF5LDHMHu
         H0MdrIZ97C5GtS0FIl4amUH0FVPlDoYa4j68/qJUSgnEuOYK/EN+t/eX9CsTmMnnxeYr
         wfxw==
X-Forwarded-Encrypted: i=1; AJvYcCVDHPh3/cnjAGzxRl2jCMeADMH4UAsyLN9W8hCi321NbS9tb+nxqR7MI61Ik8MbhN1SmcWMg7szDSR7xRU=@vger.kernel.org, AJvYcCXmzgH/05tybK3XdSt+AsNbPYaCxHRU4WTFH7bfCAjkh49kZeYttNjENsEGAKJkiRCmREa11ep+pHAhI6TfDok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdlUdayzAp9nrgd1o7uD9zRMprzNU1m/lU2mXGqnaX+EtdUvE
	cuHvAeLp2ClGPvYwzS8xDDDLLtSgvaTN2z0vkfxS01q+d52jrC8bLNRRFPMWQ+NW9vcajiAunno
	D+VKt1iETzGZg70+LOr8KC6W5sTs=
X-Gm-Gg: ASbGncsGKaQe7XyL2e8QQtBLIsUXvloVc2/gBGkugxW3vU/bXx+oC+PE+V20KE2WmOD
	0XPHZCCYzkA0aRYbjysH12m2Ay7AYIM3n3Qt0XQl8WK/Fm8J1NRc7yGXZbXOvzdS32zs4FY9wk1
	aXOjEqIxQF
X-Google-Smtp-Source: AGHT+IF1n3fN2ASWrPZBSwUEo4qIfv66oYZFTGse8TtW5hVVr/95CU6EXUQvIe2Mei+F4OXKAABNRBxXAucgxYx8zS8=
X-Received: by 2002:a05:622a:1388:b0:471:c042:7757 with SMTP id
 d75a77b69052e-472228e124cmr158323171cf.31.1740324619451; Sun, 23 Feb 2025
 07:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
In-Reply-To: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Sun, 23 Feb 2025 08:30:06 -0700
X-Gm-Features: AWEUYZlx0t9TgnsWN0eRB0PYZAyBItH9gFhBdJZwmRJt-uVzfXRYzRyM6k94nIk
Message-ID: <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just to be clear and avoid confusion, I would
like to clarify some aspects of aliasing.
In case that you do not already know about this,
I suspect that you may find it very valuable.

I am not an expert at Rust, so for any Rust experts
out there, please feel free to point out any errors
or mistakes that I make in the following.

The Rustonomicon is (as I gather) the semi-official
documentation site for unsafe Rust.

Aliasing in C and Rust:

C "strict aliasing":
- Is not a keyword.
- Based on "type compatibility".
- Is turned off by default in the kernel by using
    a compiler flag.

C "restrict":
- Is a keyword, applied to pointers.
- Is opt-in to a kind of aliasing.
- Is seldom used in practice, since many find
    it difficult to use correctly and avoid
    undefined behavior.

Rust aliasing:
- Is not a keyword.
- Applies to certain pointer kinds in Rust, namely
    Rust "references".
    Rust pointer kinds:
    https://doc.rust-lang.org/reference/types/pointer.html
- Aliasing in Rust is not opt-in or opt-out,
    it is always on.
    https://doc.rust-lang.org/nomicon/aliasing.html
- Rust has not defined its aliasing model.
    https://doc.rust-lang.org/nomicon/references.html
        "Unfortunately, Rust hasn't actually
        defined its aliasing model.
        While we wait for the Rust devs to specify
        the semantics of their language, let's use
        the next section to discuss what aliasing is
        in general, and why it matters."
    There is active experimental research on
    defining the aliasing model, including tree borrows
    and stacked borrows.
- The aliasing model not being defined makes
    it harder to reason about and work with
    unsafe Rust, and therefore harder to avoid
    undefined behavior/memory safety bugs.
- Rust "references" are common and widespread.
- If the aliasing rules are broken, undefined
    behavior and lack of memory safety can
    happen.
- In safe Rust, if aliasing rules are broken,
    depending on which types and functions
    are used, a compile-time error or UB-safe runtime
    error occurs. For instance, RefCell.borrow_mut()
    can panic if used incorrectly. If all the unsafe Rust
    code and any safe Rust code the unsafe Rust
    code relies on is implemented correctly, there is
    no risk of undefined behavior/memory safety bugs
    when working in safe Rust.

    With a few caveats that I ignore here, like type
    system holes allowing UB in safe Rust, and no
    stack overflow protection if #![no_std] is used.
    Rust for Linux uses #![no_std].
- The correctness of unsafe Rust code can rely on
    safe Rust code being correct.
    https://doc.rust-lang.org/nomicon/working-with-unsafe.html
        "Because it relies on invariants of a struct field,
        this unsafe code does more than pollute a whole
        function: it pollutes a whole module. Generally,
        the only bullet-proof way to limit the scope of
        unsafe code is at the module boundary with privacy."
- In unsafe Rust, it is the programmer's responsibility
    to obey the aliasing rules, though the type system
    can offer limited help.
- The aliasing rules in Rust are possibly as hard or
    harder than for C "restrict", and it is not possible to
    opt out of aliasing in Rust, which is cited by some
    as one of the reasons for unsafe Rust being
    harder than C.
- It is necessary to have some understanding of the
    aliasing rules for Rust in order to work with
    unsafe Rust in general.
- Many find unsafe Rust harder than C:
    https://chadaustin.me/2024/10/intrusive-linked-list-in-rust/
    https://lucumr.pocoo.org/2022/1/30/unsafe-rust/
    https://youtube.com/watch?v=3DDG-VLezRkYQ
    Unsafe Rust being harder than C and C++ is a common
    sentiment in the Rust community, possibly the large
    majority view.
- Some Rust developers, instead of trying to understand
    the aliasing rules, may try to rely on MIRI. MIRI is
    similar to a sanitizer for C, with similar advantages and
    disadvantages. MIRI uses both the stacked borrow
    and the tree borrow experimental research models.
    MIRI, like sanitizers, does not catch everything, though
    MIRI has been used to find undefined behavior/memory
    safety bugs in for instance the Rust standard library.

So if you do not wish to deal with aliasing rules, you
may need to avoid the pieces of code that contains unsafe
Rust.

Best, VJ.

On Sat, Feb 22, 2025 at 12:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 22 Feb 2025 at 10:54, Kent Overstreet <kent.overstreet@linux.dev>=
 wrote:
> >
> > If that work is successful it could lead to significant improvements in
> > code generation, since aliasing causes a lot of unnecessary spills and
> > reloads - VLIW could finally become practical.
>
> No.
>
> Compiler people think aliasing matters. It very seldom does. And VLIW
> will never become practical for entirely unrelated reasons (read: OoO
> is fundamentally superior to VLIW in general purpose computing).
>
> Aliasing is one of those bug-bears where compiler people can make
> trivial code optimizations that look really impressive. So compiler
> people *love* having simplistic aliasing rules that don't require real
> analysis, because the real analysis is hard (not just expensive, but
> basically unsolvable).
>
> And they matter mainly on bad CPUs and HPC-style loads, or on trivial
> example code. And for vectorization.
>
> And the sane model for those was to just have the HPC people say what
> the aliasing rules were (ie the C "restrict" keyword), but because it
> turns out that nobody wants to use that, and because one of the main
> targets was HPC where there was a very clear type distinction between
> integer indexes and floating point arrays, some "clever" person
> thought "why don't we use that obvious distinction to say that things
> don't alias". Because then you didn't have to add "restrict" modifiers
> to your compiler benchmarks, you could just use the existing syntax
> ("double *").
>
> And so they made everything worse for everybody else, because it made
> C HPC code run as fast as the old Fortran code, and the people who
> cared about DGEMM and BLAS were happy. And since that was how you
> defined supercomputer speeds (before AI), that largely pointless
> benchmark was a BigDeal(tm).
>
> End result: if you actually care about HPC and vectorization, just use
> 'restrict'. If you want to make it better (because 'restrict'
> certainly isn't perfect either), extend on the concept. Don't make
> things worse for everybody else by introducing stupid language rules
> that are fundamentally based on "the compiler can generate code better
> by relying on undefined behavior".
>
> The C standards body has been much too eager to embrace "undefined behavi=
or".
>
> In original C, it was almost entirely about either hardware
> implementation issues or about "you got your pointer arithetic wrong,
> and the source code is undefined, so the result is undefined".
> Together with some (very unfortunate) order of operations and sequence
> point issues.
>
> But instead of trying to tighten that up (which *has* happened: the
> sequence point rules _have_ actually become better!) and turning the
> language into a more reliable one by making for _fewer_ undefined or
> platform-defined things, many C language features have been about
> extending on the list of undefined behaviors.
>
> The kernel basically turns all that off, as much as possible. Overflow
> isn't undefined in the kernel. Aliasing isn't undefined in the kernel.
> Things like that.
>
> And making the rules stricter makes almost no difference for code
> generation in practice. Really. The arguments for the garbage that is
> integer overflow or 'strict aliasing' in C were always just wrong.
>
> When 'integer overflow' means that you can _sometimes_ remove one
> single ALU operation in *some* loops, but the cost of it is that you
> potentially introduced some seriously subtle security bugs, I think we
> know it was the wrong thing to do.
>
>              Linus

