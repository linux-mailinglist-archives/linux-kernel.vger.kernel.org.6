Return-Path: <linux-kernel+bounces-548909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63505A54AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D497F7A584C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0720B803;
	Thu,  6 Mar 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1g5NbEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEC1EDA1F;
	Thu,  6 Mar 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264429; cv=none; b=WTZ4+X564LW3ZaDtqE0eqZUJzX6WIWW7Xrgx7xalUmn85LTW5Rdn15RjM1zdJCSz9v/fslz+fsbOAp18vi/C7/4kTFTxS8OPWgkmpiZlEUHfrfgcNr9DNPENh1LHxJrjrL4rBshabC+4GjSskVe8bP9E9LH29J2JhUuqoa/h9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264429; c=relaxed/simple;
	bh=P5/bQBujci4UcWFgDKpxgC7L6tOL6QdQ90C1u/6ZuWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUf5mF/4Db4jbhLvniyR1vMGKZFCO4Ry7UImS6KYwuSkYTApaseNBfRThqrOzDD1KWehsBVp2GWubi+iwTTzK32Pr8SXdIqrF6yTgMnMkhnanmRcSY55GNbMAbkJw2TW7cNmr8DiOUHsXXxf6zjCOh9Ks88fRbMeyBgNyX4HQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1g5NbEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24169C4CEE4;
	Thu,  6 Mar 2025 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264428;
	bh=P5/bQBujci4UcWFgDKpxgC7L6tOL6QdQ90C1u/6ZuWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1g5NbEl7bkSKYa7caiviUHuN6Lyuqm0/Qep0kyaOrJs7oMLo/CdWuOXYMO9ZJp02
	 8HjTStp7fZPtK3ZhYZzrUaDkBxMUjtXFj+zxBL0SeE6MGjeUWwn+ByCTs33+BWuQPa
	 hmRup15H4PeRfDBD+a9vitj0bivxiSIuqHLMKBFN+Zak7+kwtz1eIGgOIS/9esC6Ni
	 o7NEG7xqW2WUC0QNEHPH2q5FHEWB4ZHGNTMLriPau/f89AWycPObq9NXFI5I8WWHMS
	 s0cl+lnWOAhKCU9hyeOC3ZoW5Iey8aNuzjzMey8thWBe/zkZC9NuATaLG0p3pLCUGy
	 XWhQuaFAhhVbQ==
Date: Thu, 6 Mar 2025 13:33:42 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
Message-ID: <Z8mWJox-0IyP1uUo@cassiopeiae>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
 <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304085351.inrvjgixvxla4yn3@vireshk-i7>

On Tue, Mar 04, 2025 at 02:23:51PM +0530, Viresh Kumar wrote:
> +/// This structure represents the Rust abstraction for a C [`struct clk`].
> +///
> +/// # Invariants
> +///
> +/// A [`Clk`] instance always corresponds to a valid [`struct clk`] created by the C portion of the
> +/// kernel.
> +///
> +/// Instances of this type are reference-counted. Calling `get` ensures that the allocation remains
> +/// valid for the lifetime of the [`Clk`].
> +///
> +/// ## Example
> +///
> +/// The following example demonstrates how to obtain and configure a clock for a device.
> +///
> +/// ```
> +/// use kernel::clk::{Clk, Hertz};
> +/// use kernel::device::Device;
> +/// use kernel::error::Result;
> +///
> +/// fn configure_clk(dev: &Device) -> Result {
> +///     let clk = Clk::get(dev, "apb_clk")?;
> +///
> +///     clk.prepare_enable()?;
> +///
> +///     let expected_rate = Hertz::new(1_000_000_000);
> +///
> +///     if clk.rate() != expected_rate {
> +///         clk.set_rate(expected_rate)?;
> +///     }
> +///
> +///     clk.disable_unprepare();
> +///     Ok(())
> +/// }
> +/// ```
> +///
> +/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
> +#[repr(transparent)]
> +pub struct Clk(*mut bindings::clk);
> +
> +impl Clk {
> +    /// Gets `Clk` corresponding to a [`Device`] and a connection id.
> +    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> +        let con_id = if let Some(name) = name {
> +            name.as_ptr() as *const _
> +        } else {
> +            ptr::null()
> +        };
> +
> +        // SAFETY: It is safe to call `clk_get()` for a valid device pointer.
> +        Ok(Self(from_err_ptr(unsafe {
> +            bindings::clk_get(dev.as_raw(), con_id)
> +        })?))
> +    }
> +
> +    /// Obtain the raw `struct clk *`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::clk {
> +        self.0
> +    }
> +
> +    /// Enable the clock.
> +    #[inline]
> +    pub fn enable(&self) -> Result {
> +        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
> +        // by `clk_get()`.

You may want to add an invariant for this, i.e. something along the lines of
"Clk always holds either a pointer to a valid struct clk or a NULL pointer".

In this safety comment you can then say that by the type invariant of Clk
self.as_raw() is a valid argument for $func.

Not that your type invariant needs the NULL case, since OptionalClk may set Clk
to hold a NULL pointer.

I still think that a new type MaybeNull<T> would be nice to encapsulate this
invariant, but we can also wait until we get another use-case for it.

