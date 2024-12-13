Return-Path: <linux-kernel+bounces-444965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F69F0F27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF502824E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A801E22ED;
	Fri, 13 Dec 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3+g0qIz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC081E04BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100384; cv=none; b=fuc4HiRI8p/upkitiOM7KqKOCa1lTpfIvgTvUoYDl8CpXN1vE/Tt488srzex+2ZH8nfMBd2DyIzAVbGk6mNoCj38dD1MuXfFoR/vfrG0Jya9fAXgfOUDPij6CwbPeQGSl38xfLrapZC7MsGwzcdmhJjKJEf+u4JsU7daTsFd93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100384; c=relaxed/simple;
	bh=EuJufx1aFMmSDDvNPI6DU4SHOlqB0i/fifV9p+FF0lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9P5nQa2ZV3BWZDiZ3vW+N66ez0kiAzqyD8iiRbkuNYsrIpf600DoLbPjA6qWkb+I2mnpDwde2fQBlvDzdH4AS+qfaFzSIQ5aKpYjaU4BP+KQCJ6sincMwzs1K/HZpShbiBsCXBI6fPQYL5ff4sygK6ecrBN4zPWDfkrEwJOr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3+g0qIz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so941545f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734100381; x=1734705181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS9LGudJur7kGbLspdnTQuWDC+hZFSTpArars9lBeLQ=;
        b=F3+g0qIz6g2WVi4c4BYQ3Jf/lMTVkukAyhHWqRCsKwlrIwR7vNKvprOJWrbob9UXsy
         7gaT8nGk93GuvfLctjKTMEd5N23oCuAxYCHh9bAZEe7OQTnl0QdEExFJ50e0tVKR9fit
         fVpKi0P78zCTPAPMXPLS6ULTkfJbchVZrbZRDNehNG4Vn2k16bLugou0GLYeFSYDeBxA
         C62UQwbpRrf3PYMAWpx3pEvduNZ2YcnySy/UmRVTFQLJ76RDIX3N92iPZ2nNyQh4q+j2
         Ew9Q6RsSLTLq9lFU7prhz02Ej9yfDVS5jAYKTA4cl7lvlVdYbxHiRmInQFjXKwToH82v
         eZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100381; x=1734705181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS9LGudJur7kGbLspdnTQuWDC+hZFSTpArars9lBeLQ=;
        b=kLS5p4Jtp5cpO+ego2bq9DjYcNaKBXNMo2ldhEz5HY2CHsqooAgJCQnZt122YXjN3V
         7Cva2EQEM3boWl3fF8gnRk1MesmMxYGX3TllKew7LQ55smJAewER7JGNQ2BulV54fCwz
         yRR5d3mEqEHw/13v1ofiNkMZXvNh0Vc5nKzDj+NRLPny2fMiFAvPYRjm2J7/sfkDHqf+
         gCDaWtNzrlOIkp95AkhxO4/vqH+5CpiM94P7c0IugyRse+QMSuAsjzpkof6KHBt5vcZG
         y7b3Miw1+Fb5JhHvwNKEPWz/HvCoULDzc9GNdnQ/R3SVZzzpa2PcOx8jVXcy9rtMQryr
         YQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXPmWY0wR+WXY4aXbcsYrtV3PMZhwQJsV07U3fQiiljZ62/POL5xgi72PkyuRqO7XxqgY+njoHEC7aRHBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRq5pVtaooj/g2IGnqvK+8WCVTA+B2rhA0vj0rnhJRg00w6Pt
	vHd26X2Q95i/iybi1+O1q9B+3hm+Z7gNMb93WUDQ/K+MhMictj7vBOmh3nAOZfydBYNtuUg82vw
	mHG+fM4zNBsEaMsgf4B3Wi3k/+2ZaXycwbKbU
X-Gm-Gg: ASbGnctEtaQKNxIIzLZHfeRL3aIsprjtQAdF15QlohdNkloZnHfdjWlz0/DGYDl6fCG
	j5bQzTcgD4cjS4fg1RvtdDl6JLFu/JVyil7m2OvI=
X-Google-Smtp-Source: AGHT+IGvvc8SEIVkqPspUBW11+fwBIw/V0dhqL0RuVU+1lBeUhFdbOVUzhj6j5lBdtbpP2FKdq6ekBfVUhokO3//J1Y=
X-Received: by 2002:a05:6000:2ad:b0:385:ee59:44eb with SMTP id
 ffacd0b85a97d-3888e0bd28amr2583040f8f.33.1734100380695; Fri, 13 Dec 2024
 06:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <20241101060237.1185533-5-boqun.feng@gmail.com> <CAH5fLgjhQouU=kqVx7LET2yeWt6sKt-VO5PR5SnQ8doaG4ihuQ@mail.gmail.com>
 <Z1seogLmy5H8-hXn@boqun-archlinux>
In-Reply-To: <Z1seogLmy5H8-hXn@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 15:32:47 +0100
Message-ID: <CAH5fLgjGg8_s8imOkmPb0yLAMwD1sF1aoBZWkAy-YLNh41zCuw@mail.gmail.com>
Subject: Re: [RFC v2 04/13] rust: sync: atomic: Add generic atomics
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, lkmm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:34=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Dec 12, 2024 at 11:57:07AM +0100, Alice Ryhl wrote:
> [...]
> > > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/at=
omic/generic.rs
> > > new file mode 100644
> > > index 000000000000..204da38e2691
> > > --- /dev/null
> > > +++ b/rust/kernel/sync/atomic/generic.rs
> > > @@ -0,0 +1,253 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Generic atomic primitives.
> > > +
> > > +use super::ops::*;
> > > +use super::ordering::*;
> > > +use crate::types::Opaque;
> > > +
> > > +/// A generic atomic variable.
> > > +///
> > > +/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to=
 be chosen.
> > > +///
> > > +/// # Invariants
> > > +///
> > > +/// Doing an atomic operation while holding a reference of [`Self`] =
won't cause a data race, this
> > > +/// is guaranteed by the safety requirement of [`Self::from_ptr`] an=
d the extra safety requirement
> > > +/// of the usage on pointers returned by [`Self::as_ptr`].
> > > +#[repr(transparent)]
> > > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);
> > > +
> > > +// SAFETY: `Atomic<T>` is safe to share among execution contexts bec=
ause all accesses are atomic.
> > > +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
> >
> > Surely it should also be Send?
> >
>
> It's `Send` here because `Opaque<T>` is `Send` when `T` is `Send`. And
> in patch #9, I changed the definition of `AllowAtomic`, which is not a
> subtrait of `Send` anymore, and an `impl Send` block was added there.
>
> > > +/// Atomics that support basic atomic operations.
> > > +///
> > > +/// TODO: Unless the `impl` is a `#[repr(transparet)]` new type of a=
n existing [`AllowAtomic`], the
> > > +/// impl block should be only done in atomic mod. And currently only=
 basic integer types can
> > > +/// implement this trait in atomic mod.
> >
> > What's up with this TODO? Can't you just write an appropriate safety
> > requirement?
> >
>
> Because the limited scope of types that allows atomic is an artificial
> choice, i.e. we want to start with a limited number of types and make
> forward progress, and the types that we don't want to support atomics
> for now are not because of safety reasons, but more of a lack of
> users/motivations. So I don't think this is something we should use
> safety requirement to describe.

I found the wording very confusing. Could you reword it to say
something about future possibilities?

> > > +/// # Safety
> > > +///
> > > +/// [`Self`] must have the same size and alignment as [`Self::Repr`]=
.
> > > +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> > > +    /// The backing atomic implementation type.
> > > +    type Repr: AtomicImpl;
> > > +
> > > +    /// Converts into a [`Self::Repr`].
> > > +    fn into_repr(self) -> Self::Repr;
> > > +
> > > +    /// Converts from a [`Self::Repr`].
> > > +    fn from_repr(repr: Self::Repr) -> Self;
> >
> > What do you need these methods for?
> >
>
> Converting a `AtomicImpl` value (currently only `i32` and `i64`) to a
> `AllowAtomic` value without using transmute in `impl` block of
> `Atomic<T>`. Any better idea?

You could use transmute?

Alice

