Return-Path: <linux-kernel+bounces-257637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441FC937CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39C52825EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C596148316;
	Fri, 19 Jul 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQBQbope"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E50383AE;
	Fri, 19 Jul 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416827; cv=none; b=P3j7p/4dozfCdGXb9r95JZm8NFd6wyJj6rMo3mmcNzrY7fmUKc7tskqbA4d3YhFqp/7KwNRsiVNQptBW1GW+i9aAjADF1SJZ76yVXGAvIsWctWN7Q+SHXOW2OgN8nYGiPTPtx9b+l8pg5qFHM8jndaarruJMaC73ApthxZKkqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416827; c=relaxed/simple;
	bh=CEWqSygAKH9ACrMNsXOlxzuZ9KSCSifLeDh3gU6Y12Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C75kQi3txAjrLa+ac8CzAOK3AXOgvv7he4J16nd0AQFldrO6FUArAK/hRVU+nNN8H9WwYE1jtwX/DFgs/T3h3gCzDFK7KetSXFFn3G3r41TaGfc1Z7jGGZyinn/ezSNlG+pDtGeyXKdvpMZ8rRV1mj0RmPmc590HIOg2nq/vSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQBQbope; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3B5C32782;
	Fri, 19 Jul 2024 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721416827;
	bh=CEWqSygAKH9ACrMNsXOlxzuZ9KSCSifLeDh3gU6Y12Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQBQbope4oCHits71W7SPkK0aF3yHcjBzdufqlJPKdJtLIAAl+Us0f8oXc2dV9jwH
	 2RDyAZ4W6v1ADQkIXWpgrQsW/52YCVGaiFKXcFF0K0dM2lLxuRh0ua0JaXXNDd5Hu1
	 ErDRBhggUZqyMIdJI1UL5qRf2WAUpgcDNntJOM7eJTgVryfs4punZ80SpGnnMeBCUi
	 YdH4Clnxf1QhdQ1CPE9YVKb2NHP7LG8lTacfopnVQOS0j9hHerxTsJWcCALW9UN66J
	 Y5m2u9hiCIOxuZ3GRpkAGlIEFxUZ6jUDbWNJdDBSw3vc0m9u2jqjU+mKn1Ewa+GAMM
	 S5vPsrqMMjsNw==
Date: Fri, 19 Jul 2024 21:20:15 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Jonathan Corbet <corbet@lwn.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <Zpq8b0I2kYeAh2qm@pollux>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
 <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
 <ZpqeEywGic4nIEL8@pollux>
 <5E1B12C1-1ACD-4A26-AC89-CC32327B51F5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E1B12C1-1ACD-4A26-AC89-CC32327B51F5@collabora.com>

On Fri, Jul 19, 2024 at 03:09:09PM -0300, Daniel Almeida wrote:
> Hi Danilo,
> 
> 
> > 
> > We can easily build abstractions that ensure that the address a driver is trying
> > to access is mapped properly, such that you can't have accidential out-of-bound
> > accesses.
> > 
> > Those can be implemented by the corresponding subsystem / bus that the resource
> > originates from.
> > 
> > In fact, we already have abstractions for that on the way, a generic I/O
> > abstraction [1] as base implementation and a specific abstraction for PCI bars
> > [2].
> > 
> > Of course, if the MMIO region comes from let's say the device tree, we still
> > have to assume that the information in the DT is correct, but the driver does
> > not need unsafe code for this.
> > 
> > [1] https://lore.kernel.org/rust-for-linux/20240618234025.15036-8-dakr@redhat.com/
> > [2] https://lore.kernel.org/rust-for-linux/20240618234025.15036-11-dakr@redhat.com/
> > 
> 
> Thanks for pointing that out. So from this:
> 
> +impl<const SIZE: usize> Io<SIZE> {
> + ///
> + ///
> + /// # Safety
> + ///
> + /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
> + /// `maxsize`.
> + pub unsafe fn new(addr: usize, maxsize: usize) -> Result<Self> {
> + if maxsize < SIZE {
> + return Err(EINVAL);
> + }
> +
> + Ok(Self { addr, maxsize })
> + }
> 
> It looks like one can do this:
> 
> let io = unsafe { Io::new(<some address>, <some size>)? }; 
> let value = io.readb(<some offset>)?;
> 
> Where <some address> has already been mapped for <some size> at an earlier point?

Yes, but (at least for full Rust drivers) this shouldn't be called by the driver
directly, but the corresponding subsystem / bus should provide a `Devres`
wrapped `Io` instance, like the PCI abstraction in [2] does.

Example:

```
// Get a `Devres` managed PCI bar mapping
let bar: Devres<pci::Bar> = pdev.iomap_region(0);

let reg = bar.try_readl(0x42)?;
```
You can also let the driver assert that the requested resource must have a
minimum size:

```
// Only succeeds if the PCI bar has at least a size of 0x1000
let bar = pdev.iomap_region_size::<0x1000>(0);

// Note: `readl` does not need to return a `Result`, since the boundary checks
// can be done on compile time due to the driver specified minimal mapping size.
let reg = bar.readl(0x42);
```

> 
> That’s fine, as I said, if an abstraction makes sense, I have nothing
> against it. My point is more that we shouldn’t enact a blanket ban on
> 'unsafe' in drivers because corner cases do exist. But it’s good to know that this
> particular example I gave does not apply.
> 
> 
> >> 
> >> If a driver is written partially in Rust, and partially in C, and it gets a
> >> pointer to some kcalloc’d memory in C, should It be forbidden to use unsafe
> >> in order to build a slice from that pointer? How can you possibly design a
> >> general abstraction for something that is, essentially, a driver-internal API?
> > 
> > That sounds perfectly valid to me.
> > 
> 
> 
> — Daniel
> 
> 

