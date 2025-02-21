Return-Path: <linux-kernel+bounces-525944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351CA3F7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3023BE08F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6FD210F5D;
	Fri, 21 Feb 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyph6rtQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519520FAA1;
	Fri, 21 Feb 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149284; cv=none; b=rn0QErbI+XQNIMX6eFF6tinTwoEftBqRYyudB2njohLo2Jk3ZLl78n7V17dR+HD2txnA1xOiO0CCLuxn9Q/hqLfwezThqXTPkm/JJkOdY9JIF1hGueWkZePoQKpOvhaX1PstLRSIKMOgZ2qgetF4lOLTUPwDwZFj+oMDU+Go3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149284; c=relaxed/simple;
	bh=Pydel3GDch9z7hvM8q8bAh48qo5Vb3Mw8itGDgMptC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZcX/TLmFBkIa30emInHbxtiCdEYqiDT/wSPX6jDqVNEvt91G41bmw7OzFDdH5yqi9HirA8q02+q4GBXfHue8aEOExoh8wvHMFskRZT9Y9d0ERKFWdih3ZQE118+MJnGtRN8evqCnh950eDZFwOm7CjeAst3xbBMWKzudXtYLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyph6rtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041BCC4CED6;
	Fri, 21 Feb 2025 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149283;
	bh=Pydel3GDch9z7hvM8q8bAh48qo5Vb3Mw8itGDgMptC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyph6rtQprpre7Tyd49/a/29K19NpkavMg0LywEqDU/Oyut1MviU1AJOCooSkjVnV
	 vgUpsdp4744feuGl4XEgGrZQdE6NL3sPidMF85rw49qERD++bL6fBtgcPL0LaW1scc
	 bPOkgUko76Q5egbkgxkGQuBY3xLWbqy3LFJV5OB2p5wmL2jPxT7GW5g1Z3FSX2MK0+
	 uh6jrLq3Z5SvVA70iKCKEUR+/vdxHZVVa2YvWxHpMCyo0ptQO/hKKhbPL7ivYH6+/M
	 jSmaAzTL91UHcucDaXBt59XNYXyrrCuf3CXxD4gO3DUyghNtg4IgIgizHRYq49hYHi
	 QNvl1BEfXmvGQ==
Date: Fri, 21 Feb 2025 15:47:57 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
Message-ID: <Z7iSHR0F2QpiNpMZ@pollux>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux>
 <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>

On Fri, Feb 21, 2025 at 11:29:21AM -0300, Daniel Almeida wrote:
> 
> 
> > On 21 Feb 2025, at 10:56, Danilo Krummrich <dakr@kernel.org> wrote:
> > 
> > On Fri, Feb 21, 2025 at 12:03:39PM +0530, Viresh Kumar wrote:
> >> +/// A simple implementation of `struct clk` from the C code.
> >> +#[repr(transparent)]
> >> +pub struct Clk(*mut bindings::clk);
> > 
> > I remember that Stephen explained that NULL is valid value for struct clk. As a
> > consequence, all functions implemented for `Clk` have to consider this.
> 
> I am a bit confused here. If NULL is valid, then why should we have to specifically
> consider that in the functions? No functions so far explicitly dereferences that value,
> they only pass it to the clk framework.

This was badly phrased, the current implementation does not need to consider it
indeed. What I meant is that we have to consider it potentially. Especially,
when adding new functionality later on. For instance, when accessing fields of
struct clk directly. Maybe this only becomes relevant once we write a clk driver
itself in Rust, but still.

> 
> Or are you referring to the safety comments only? In which case I do agree (sorry for
> the oversight by the way)
> 
> > 
> > I wonder if it could make sense to have a transparent wrapper type
> > `MaybeNull<T>` (analogous to `NonNull<T>`) to make this fact more obvious for
> > cases like this?
> 
> MaybeNull<T> sounds nice.

Yeah, it's probably the correct thing to do, to make things obvious.

> 
> > 
> >> +
> >> +impl Clk {
> >> +    /// Creates `Clk` instance for a device and a connection id.
> >> +    pub fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> >> +        let con_id = if let Some(name) = name {
> >> +            name.as_ptr() as *const _
> >> +        } else {
> >> +            ptr::null()
> >> +        };
> >> +
> >> +        // SAFETY: It is safe to call `clk_get()`, on a device pointer earlier received from the C
> >> +        // code.
> >> +        Ok(Self(from_err_ptr(unsafe {
> >> +            bindings::clk_get(dev.as_raw(), con_id)
> >> +        })?))
> >> +    }
> >> +
> >> +    /// Obtain the raw `struct clk *`.
> >> +    pub fn as_raw(&self) -> *mut bindings::clk {
> >> +        self.0
> >> +    }
> >> +
> >> +    /// Clock enable.
> >> +    pub fn enable(&self) -> Result<()> {
> >> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> >> +        // use it now.
> > 
> > This is not true.
> > 
> > 1. There is no type invariant documented for `Clk`.
> > 2. The pointer contained in an instance of `Clk` may be NULL, hence `self` does
> >   not necessarily own a reference.
> 
> > 
> > The same applies for all other functions in this implementation.
> > 
> 
> 

