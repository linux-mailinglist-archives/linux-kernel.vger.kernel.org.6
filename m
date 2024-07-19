Return-Path: <linux-kernel+bounces-257531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEC937B74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C428254D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B11146A6C;
	Fri, 19 Jul 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmBB/wfh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E11B86D9;
	Fri, 19 Jul 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409049; cv=none; b=s+Z+zKqgEEqYcqeNrlqVdMzm54q1fBhVOv3M9eshokMd6VwWM3svRHrCHGqAAF6iJ2NE0J3GnR3LRWAr0vjoz2flq4bTl2K23JBOvkv6DI1wdZzsbdfC/s0EHajD4PMxrDBoGsTaHf7A0lwEYwSMFXwNy3bu8mqq//vq8pFqkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409049; c=relaxed/simple;
	bh=2/xCU4A+uNaa4nhyaUv1vAnUHrBUv4JRCacwDeM00h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j52rQ8/QCvuleR0lNP+VD7vTZuYKSLIJqrK6V4euJ1clpy/38j4niNJ6ypkX0C8O1CYsZmcuyAA4gGls6FTv88IEtcFetvXJq3MDzOyEKoRVjWVTY/kC+w/PBu26zvKYDJ8PskenQYJtbZ14SHXsB9wh7uoamUyKZTd3efFWVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmBB/wfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F314AC32782;
	Fri, 19 Jul 2024 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721409048;
	bh=2/xCU4A+uNaa4nhyaUv1vAnUHrBUv4JRCacwDeM00h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmBB/wfhv27dnyW6FZgqLiqQlWMhQIZNRRWWrk5eQVE4tKTe0pmfuf7/cuZ+g81gl
	 d+Cbtpaou94zahlwIEVsHGzeVqVvlGmN4fmfUkPpdsP/r/JcAEfeRmmTDsCpYZmztD
	 fD00YbR6LwHfDsV84CGJOaFVIrByojl0D8kXDN/dyUlneEZGMS5DTVTOqUgDv9jL4L
	 bJoddaNh54TpCqd1o/jtWfbluLuzgJV1Q7prg+ObORxZKLHji27lZSIaDbNouGE+mI
	 1Pz+IwAVXFpu7Rps3gUqAruVQa6EIW3lvh5guWo/mNGGuApjulzHMlnZeQl+tSzFmf
	 beQqP92jkjDIQ==
Date: Fri, 19 Jul 2024 19:10:43 +0200
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
Message-ID: <ZpqeEywGic4nIEL8@pollux>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
 <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>

On Fri, Jul 19, 2024 at 01:24:10PM -0300, Daniel Almeida wrote:
> > +The most effective way to prevent issues in ``unsafe`` code is to just not write ``unsafe`` code in
> > +the first place. That is why minimizing the amount of ``unsafe`` code is very important. For
> > +example, drivers are not allowed to directly interface with the C side. Instead of directly
> > +communicating with C functions, they interact with Rust abstractions. This concentrates the usage
> > +of ``unsafe`` code, making it easy to fix issues, since only the abstraction needs to be fixed.
> > +Abstractions also allow taking advantage of other Rust language features. Read more in
> > +:ref:`rust-abstractions`.
> 
> This is something that I think we should discuss at Kangrejos. I do not think
> that we should set in stone that the kernel crate is the only place where
> unsafe code is acceptable.
> 
> I am in no way disagreeing with the use of safe abstractions, but I think we
> should have abstractions where they make sense. This is the case in the vast
> majority of times, but not in *all* of them.
> 
> A simple example is a MMIO read or write. Should a driver be forbidden to call
> readX/writeX for an address it knows to be valid? How can you possibly write an
> abstraction for this, when the driver is the only one aware of the actual
> device addresses, and when the driver author is the person with actual access
> to the HW docs?

We can easily build abstractions that ensure that the address a driver is trying
to access is mapped properly, such that you can't have accidential out-of-bound
accesses.

Those can be implemented by the corresponding subsystem / bus that the resource
originates from.

In fact, we already have abstractions for that on the way, a generic I/O
abstraction [1] as base implementation and a specific abstraction for PCI bars
[2].

Of course, if the MMIO region comes from let's say the device tree, we still
have to assume that the information in the DT is correct, but the driver does
not need unsafe code for this.

[1] https://lore.kernel.org/rust-for-linux/20240618234025.15036-8-dakr@redhat.com/
[2] https://lore.kernel.org/rust-for-linux/20240618234025.15036-11-dakr@redhat.com/

> 
> If a driver is written partially in Rust, and partially in C, and it gets a
> pointer to some kcalloc’d memory in C, should It be forbidden to use unsafe
> in order to build a slice from that pointer? How can you possibly design a
> general abstraction for something that is, essentially, a driver-internal API?

That sounds perfectly valid to me.

