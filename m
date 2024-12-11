Return-Path: <linux-kernel+bounces-442178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042D69ED903
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606BD16538F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC01EC4F0;
	Wed, 11 Dec 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS7zsrRJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B81D8DFE;
	Wed, 11 Dec 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953771; cv=none; b=WhGUzHfTP2fFNnSSaa7OYLLOtMJ+0SWoQby4pqGXPtQoxR2vU1boW9Hlmo7b8IYC1Q8QIqvsMz67VtfvUcGyP+vvNa5ZOAISqIvwqjzAiKB/XBR8qA6gxf7mkOZNmi+a+Vg2+8f/mF+dsiRsPmHpo89I2fhmMi3P0KARphDRXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953771; c=relaxed/simple;
	bh=LMgevCQ5N/CnT/QEPN2NC0QGREgKKkesG5Lwe03JUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONpZVYbXQWtfs1McnxtbI+rHA1ybArrodSZIvajkZA0cjAzcnEELO7ki/N7zfmclyC9unk/J/NpWMK2OpFVil85OKvQbGV9Xjw/S25YiLJu8/nLj7akTh+3yBK8dbONg8kTp960G4lpvmJhcLnbZ1ag/iC8yCfY5tBl6ZwnwwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS7zsrRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D80EC4CED2;
	Wed, 11 Dec 2024 21:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733953770;
	bh=LMgevCQ5N/CnT/QEPN2NC0QGREgKKkesG5Lwe03JUPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IS7zsrRJ2pfoHUC8c1Htiiw5DGSrXlMutxWMdKVpdbs4dC460extVwes5E7HboSAk
	 bQZNPQ3U24FJ5iUJVAyBlsxQ+E6YhQ4H16/wYyq0nNrwn5d+WqCSySV7+QK9j6dGhH
	 wXHW/27gRxO12lR6rYfisLpsepqUn05c/wie4DfzqsUfLD2pignQaRrbW7TGIkAE2j
	 Lq+SOALtN6BqsDFQpHC31DV03CrzqqtSpLRK61Md95YY9zi3lfnsEybsXBt/4p/Wl0
	 pfvf342edeqsRPNxcXy2pejVvXMrssRz7m7EA9TVHSqMbXBHySdahw1px0Ve97ZMuu
	 cvaJnMrDS8Nfw==
Date: Wed, 11 Dec 2024 22:49:24 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: platform: add Io support
Message-ID: <Z1oI5JwExd1stnT-@pollux.localdomain>
References: <20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com>
 <Z1nbsNyOBvFTL1-6@pollux.localdomain>
 <A3F6B6C6-33B3-4522-8240-15421F240D3A@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3F6B6C6-33B3-4522-8240-15421F240D3A@collabora.com>

On Wed, Dec 11, 2024 at 06:00:31PM -0300, Daniel Almeida wrote:
> Hi Danilo,
> 
> > On 11 Dec 2024, at 15:36, Danilo Krummrich <dakr@kernel.org> wrote:
> >> +///
> >> +///     // Read and write a 32-bit value at `offset`. Calling `try_access()` on
> >> +///     // the `Devres` makes sure that the resource is still valid.
> >> +///     let data = iomem.try_access().ok_or(ENODEV)?.readl(offset);
> >> +///
> >> +///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
> >> +///
> >> +///     // Unlike `ioremap_resource_sized`, here the size of the memory region
> >> +///     // is not known at compile time, so only the `try_read*` and `try_write*`
> >> +///     // family of functions are exposed, leading to runtime checks on every
> >> +///     // access.
> >> +///     let iomem = pdev.ioremap_resource(0, None)?;
> >> +///
> >> +///     let data = iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
> >> +///
> >> +///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
> >> +///
> >> +///     # Ok::<(), Error>(())
> >> +/// }
> >> +/// ```
> >> +///
> >> +pub struct IoMem<const SIZE: usize = 0> {
> >> +    io: IoRaw<SIZE>,
> >> +    res_start: u64,
> >> +    exclusive: bool,
> >> +}
> > 
> > I think both the `Resource` and `IoMem` implementation do not belong into
> > platform.rs. Neither of those depends on any platform bus structures. They're
> > only used by platform structures.
> > 
> > I think we should move this into files under rust/kernel/io/ and create separate
> > commits out of this one.
> 
> Just to be clear, one commit with the boilerplate to create rust/kernel/io, and another one with
> kernel::io::Resource and kernel::io::IoMem?

I don't think there will be much boilerplate. I was thinking of one for
io/resource.rs and one for io/mem.rs. Does that make sense?

> 
> > 
> >> +
> >> +impl<const SIZE: usize> IoMem<SIZE> {
> >> +    /// Creates a new `IoMem` instance.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// The caller must ensure that `IoMem` does not outlive the device it is
> >> +    /// associated with, usually by wrapping the `IoMem` in a `Devres`.
> > 
> > More precisely, `Devres` revokes when the device is unbound from the matched
> > driver, i.e. the driver should not be able to control the device anymore. This
> > may be much earlier than when the device disappears.
> > 
> >> +    unsafe fn new(resource: &Resource<'_>, exclusive: bool) -> Result<Self> {
> >> +        let size = resource.size();
> >> +        if size == 0 {
> >> +            return Err(ENOMEM);
> >> +        }
> >> +
> >> +        let res_start = resource.start();
> >> +
> >> +        // SAFETY:
> >> +        // - `res_start` and `size` are read from a presumably valid `struct resource`.
> >> +        // - `size` is known not to be zero at this point.
> >> +        // - `resource.name()` returns a valid C string.
> >> +        let mem_region =
> >> +            unsafe { bindings::request_mem_region(res_start, size, resource.name().as_char_ptr()) };
> > 
> > This should only be called if exclusive == true, right?
> 
> Yes (oops)
> 
> > 
> > Btw. what's the use-case for non-exclusive access? Shouldn't we rather support
> > partial exclusive mappings?
> 
> Rob pointed out that lots of drivers do not call `request_mem_region` in his review for v2, which
> Is why I added support for non-exclusive access.
> 
> What do you mean by `partial exclusive mappings` ?

I was assuming that the reason for non-exclusive access would be that a single
resource contains multiple hardware interfaces, hence multiple mappings.

If we allow partial mappings of the resource and make them exclusive instead it
would be a better solution IMHO.

But this presumes that we don't need non-exclusive access for different reasons.

If not for the reason of having multiple hardware interfaces in the same
resource, which reasons do we have (in Rust) to have multiple mappings of the
same thing?

