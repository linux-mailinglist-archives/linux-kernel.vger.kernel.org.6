Return-Path: <linux-kernel+bounces-537222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57996A4894E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90097A1235
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8926F468;
	Thu, 27 Feb 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dwbpor1O"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F11E521C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686131; cv=none; b=hkQFeKWQICxl8ZVz6tUAPwfP8qTzOboRJKAyM2uabIrgi9KsOECXRKpkjrAsZMRKScvl2FindL0I+HvUvz5XKAaRz37HyWVHsVmJ8WwTY5CHVp6/R7q++WLNCCsa48dt+FQ0r6aewbg9oRmje+UTCtEALUgYuJUTONRoS3Zxrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686131; c=relaxed/simple;
	bh=dh6AWXKpkEszEPz4YVyQpNvup6p+7zmAdNbzgvhv9EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5NsyDsf0auCkyrMc2nXWXTDUhCrEyJT5p9bH8sAxmDftcy639Nzea8NtxdWvcMjBCiDKjPtD9BGRe5knlUvsX8feCuSrBMVnLj28rxPQKymcEIH/QVHJZB3zyoFS+rJ7RCSB0A/nofqfVi375+BF7Khl5I/zyVXoNJG21ECJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dwbpor1O; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 14:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740686117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0JRJ+zKtBgGfMXmc5Go/d1naIz9AvvwWoTxZiOBVyo=;
	b=dwbpor1O7I/KpMFv8pqlbDKxr2GdgB18LImezcmATBu9e9Am34MPhD6Qe2P0tKTSazh8DH
	BiaOcJ0963JmTTLFSMUyQ8b3B5D6imM7uO+Hl4GU4gRlCB5oHOLgFyEZfATDA7S2ZcFmaP
	7Yzu8tQ3LBgv6JZiiW6+82L7vdjWC6M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ralf Jung <post@ralfj.de>, Martin Uecker <uecker@tugraz.at>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <jei2vzllt5z6hufn3orqqupq3ufajcxv4zx3yfpkd2j54yr72e@vmhu4r3klvvh>
References: <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
 <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
 <0f3bc0e8-5111-4e2f-83b5-36b3aec0cbbd@ralfj.de>
 <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 11:15:54AM -0800, Linus Torvalds wrote:
> On Thu, 27 Feb 2025 at 10:33, Ralf Jung <post@ralfj.de> wrote:
> >
> > The way you do global flags in Rust is like this:
> 
> Note that I was really talking mainly about the unsafe cases, an din
> particular when interfacing with C code.

For simple bitflags (i.e. code where we use test_bit()/set_bit() we'd
probably just export it as a standard Rust atomic, no new unsafe {}
required.

> 
> Also, honestly:
> 
> > FLAG.store(true, Ordering::SeqCst); // or release/acquire/relaxed
> 
> I suspect in reality it would be hidden as accessor functions, or
> people just continue to write things in C.
> 
> Yes, I know all about the C++ memory ordering. It's not only a
> standards mess, it's all very illegible code too.

It's more explicit, and that's probably not a bad thing - compare it to
our smp_mb__after_atomic(), it's not uncommon to find code where the
barriers are missing because the person who wrote the code was assuming
x86.

