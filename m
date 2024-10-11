Return-Path: <linux-kernel+bounces-360981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5299A200
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1062A1F25368
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5A215F75;
	Fri, 11 Oct 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GDJmAqta"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F1210C3B;
	Fri, 11 Oct 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643904; cv=none; b=R9QSsj//Rw0pePlzzHfRry1YUHoZqkoEw1ccvWECfRl+4P21CoRdiEk6PkF1v2LuPIXCZCXtK8HKk1j26Rbodc0vCzPOJeeVMqQF1UOAbnti4c+3YM0Mf2XRfVw7iBpSjOQMThZSV+SHFGfHEjywK8+4KfOTD/zrtclxKIRnRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643904; c=relaxed/simple;
	bh=TIFTQ6iNfj327laayt2YjFnYxVtuWPkUg0z8YcA5Xxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBtZa5MRQlqiAJm8UzXdvnuX4JWpMqILbM6DYSG9b3ijRAWZ+2RNrUa5xU1csTo6P1iFSEVVYxBpQmnIEu5yUgiRkR/fIqz2NmxcMsK4wMYVru/Lktsb/zaQ/wTvYEgenonztM8edoIDARjqgaB7k7Oq1Jh+GEakso4Owss99uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GDJmAqta; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RFh+ifNvxIfeMOvqcH0bj2fqZ4Q/KL50BBcyRrIOPlM=; b=GDJmAqtaN6oH11wTx1qLaskHBj
	zKYQwLVIA745qR3XAZTUCnNXBWgIs98fHs0b+YRlR50Lm0umA08Iq8JsIdLAj2T+Tkqbu7LxdkgLk
	6O1X26CvtGsrd430wJE9VIEtPhffGg5N1z0vYjn+IrwRxG9XuQecXwHeokGtSSMaCM9JPQwEZJGh9
	TMDnpYZvd5YbAwdhTuTnxIbpolCuKa2bUaYZUYTy8AjkbS7UXnmFbdVw/5HPvDwC/17RFNoyknmL5
	pK3S4TsmZA7NSkcw4WgqUfjKPPYwa00xJ99bh9WK9dAUF9oGkN6i9RmoJjDsx/YznY0MH8BF7QDUC
	MHDIF74g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1szDFA-00000005reF-3H66;
	Fri, 11 Oct 2024 10:51:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C0AE300642; Fri, 11 Oct 2024 12:51:36 +0200 (CEST)
Date: Fri, 11 Oct 2024 12:51:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alice Ryhl <aliceryhl@google.com>,
	Matthew Maurer <mmaurer@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all
 architectures
Message-ID: <20241011105136.GP17263@noisy.programming.kicks-ass.net>
References: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
 <ZwbAvEnrzu6UUgGl@J2N7QTR9R3>
 <CAH5fLgipBfd5pNKqniXqFudruyGaJG=LDc5MEf3Yxq1yRMmQcw@mail.gmail.com>
 <ZwewMw8jBh6OU-L_@J2N7QTR9R3>
 <20241010110344.GL14587@noisy.programming.kicks-ass.net>
 <20241010113748.GL33184@noisy.programming.kicks-ass.net>
 <CANiq72=kT9RFcQ3h5U+wAY0pDQQqGU7BTtiPJ-oiHNUG00z3=w@mail.gmail.com>
 <20241010130421.GG17263@noisy.programming.kicks-ass.net>
 <CANiq72kbApTtdLeow5L6G6t4Q_L-0zkDwfwyWcSb_e6P=kO06g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kbApTtdLeow5L6G6t4Q_L-0zkDwfwyWcSb_e6P=kO06g@mail.gmail.com>

On Thu, Oct 10, 2024 at 04:48:41PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 10, 2024 at 3:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Also not rust-src, because for some reason you're not actually
> > freestanding :/
> 
> It is there, but it is a suggested package, so I think you would need
> e.g. `--install-suggests`:
> 
>     https://packages.debian.org/trixie/rust-all
> 
> Regarding freestanding, we use `no_std`, which one could argue is
> similar to C's freestanding. That is, we use `core`, which is a subset
> of the full (hosted) standard library, just like C requires some
> headers even in freestanding.
> 
> However, I think you mean not even using those
> headers/sources/libraries, which is fair. Rust calls that `no_core`,
> but it is currently impractical to use/maintain and there are a lot of
> useful things in `core` we want to use anyway, such as the `Result`
> type:
> 
>     https://doc.rust-lang.org/core/
> 
> There are some things that we could remove, though, which is why I
> asked long ago for ways to remove unneeded things for the kernel
> ("modularization of `core`"). We got `no_fp_fmt_parse`, implemented by
> Gary back in 2021, and we could perhaps get more in the future if
> really needed.

So you could just copy the bits from core you need into the kernel tree
and leave out those bits you do not, and ocassionally update them when
needed, right?

> > Yeah, but then you have to first know that we have this file to begin
> > with.
> 
> That is fair, but hard to fix. We try our best though: the "Rust"
> entry is in the front page of the kernel docs already, and the first
> paragraph of that page links to the "Quick Start" guide.

I'm not really a browser centric kinda guy, the front page is bash in
the source tree. Using the browser is below bitching about stuff on IRC
:-)

