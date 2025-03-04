Return-Path: <linux-kernel+bounces-545431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B176BA4ED11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD07A189078B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0D255252;
	Tue,  4 Mar 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irJ7QdaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D1237180;
	Tue,  4 Mar 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115835; cv=none; b=Voku5Zp9etGFG4Xt6tiEOdiijJleyzqOHxKhgh8OlqBPAJoKSV48SN0wI5AkReN6oh7b61KOvVSmAiSAYR/7G4hiq8xpxT0rUukgXfRPcoYW/AlGbXmXjIWPBxmZDztrwDaMaH59ZY3MLZqep2ynBLrRI94OhfjpO1N0/bohEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115835; c=relaxed/simple;
	bh=PMboUH21QxSZynvmqYXTsJlCbDsI3wUH1QQCqbJpVC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItyCo3NgCdoax2kft9IA3z5X4Sfd1fn4XFQMssMjJizNbXQp0BpvX0MICzpBZPnCTOcaDRl6ohS+LhlG5wW37oBtfmbR6bThoAiZ9UP+FHGMEp7wPpaE63gK0IowX3SNTRhUDoZ+lWyLfpHhEWIlNLQSci1OyDicLWiUYI+pLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irJ7QdaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEB2C4CEE5;
	Tue,  4 Mar 2025 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115835;
	bh=PMboUH21QxSZynvmqYXTsJlCbDsI3wUH1QQCqbJpVC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irJ7QdaR0K0c04nUp9b2wT+j89G4yrbHif+hu8lFO/egIAVdxMP+68HZBNcVhAMHn
	 553GEYa/+Ppt5fcaxYJZ+jysAIxz7DNKriXV9R7mF1UFoFFGOvm2SicSkZYdK3GFKv
	 hEAEg+m+bSXQQrCt/lrjDaRsbdtWmpLSnnJFCvu6RHx1nmBNpzctDhvx+b/x4dBSh0
	 6/n3Uv+kvpFYtCW0XCXTp6HyhthA5/jBPGZ8vz/J3/ZkjYOk77t5IzWNubNl4Exr9k
	 oV6k2bNSI/Iad/IPd+AWmbx7KHy7rwxVdd9igchCOuWhAkHqkJVD1oSE8muqq2z7CX
	 ZBbbYaYOgTZWg==
Date: Tue, 4 Mar 2025 21:17:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, mcgrof@kernel.org,
	russ.weight@linux.dev, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/5] rust: firmware: add `module_firmware!` macro
Message-ID: <Z8dRtiUaS_Yrv8-K@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304173555.2496-4-dakr@kernel.org>

On Tue, Mar 04, 2025 at 06:34:50PM +0100, Danilo Krummrich wrote:
> Analogous to the `module!` macro `module_firmware!` adds additional
> firmware path strings to the .modinfo section.
> 
> In contrast to `module!`, where path strings need to be string literals,
> path strings can be composed with the `firmware::ModInfoBuilder`.
> 
> Some drivers require a lot of firmware files (such as nova-core) and
> hence benefit from more flexibility composing firmware path strings.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/firmware.rs | 79 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 6e6972d94597..5d1ac8287171 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -116,6 +116,85 @@ unsafe impl Send for Firmware {}
>  // be used from any thread.
>  unsafe impl Sync for Firmware {}
>  
> +/// Create firmware .modinfo entries.
> +///
> +/// This macro is the counterpart of the C macro `MODULE_FIRMWARE()`, but instead of taking a
> +/// simple string literals, which is already covered by the `firmware` field of
> +/// [`crate::prelude::module!`], it allows the caller to pass a builder type (e.g.
> +/// [`ModInfoBuilder`]) which can create the firmware modinfo strings in a more flexible way.
> +///
> +/// Drivers should extend the [`ModInfoBuilder`] with their own driver specific builder type.
> +///
> +/// The `builder` argument must be a type which implements the following function.
> +///
> +/// `const fn create(module_name: &'static CStr) -> ModInfoBuilder`
> +///
> +/// `create` should pass the `module_name` to the [`ModInfoBuilder`] and, with the help of
> +/// it construct the corresponding firmware modinfo.
> +///
> +/// Typically, such contracts would be enforced by a trait, however traits do not (yet) support
> +/// const functions.
> +///
> +/// # Example
> +///
> +/// ```
> +/// # mod module_firmware_test {
> +/// # use kernel::firmware;
> +/// # use kernel::prelude::*;
> +/// #
> +/// # struct MyModule;
> +/// #
> +/// # impl kernel::Module for MyModule {
> +/// #     fn init(_module: &'static ThisModule) -> Result<Self> {
> +/// #         Ok(Self)
> +/// #     }
> +/// # }
> +/// #
> +/// #
> +/// struct Builder<const N: usize>;
> +///
> +/// impl<const N: usize> Builder<N> {
> +///     const fn create(module_name: &'static kernel::str::CStr) -> firmware::ModInfoBuilder<N> {
> +///         firmware::ModInfoBuilder::new(module_name)
> +///             .prepare()
> +///             .push("vendor/foo.bin")
> +///             .prepare()
> +///             .push("vendor/bar.bin")
> +///     }
> +/// }
> +///
> +/// module! {
> +///    type: MyModule,
> +///    name: "module_firmware_test",
> +///    author: "Rust for Linux",
> +///    description: "module_firmware! test module",
> +///    license: "GPL",
> +/// }
> +///
> +/// kernel::module_firmware!(Builder);
> +/// # }
> +/// ```
> +#[macro_export]
> +macro_rules! module_firmware {
> +    ($($builder:tt)*) => {
> +
> +        #[cfg(not(MODULE))]
> +        const fn __module_name() -> &'static kernel::str::CStr {
> +            <LocalModule as kernel::ModuleMetadata>::NAME
> +        }
> +
> +        #[cfg(MODULE)]
> +        const fn __module_name() -> &'static kernel::str::CStr {
> +            kernel::c_str!("")
> +        }
> +
> +        #[link_section = ".modinfo"]
> +        #[used]
> +        static __MODULE_FIRMWARE: [u8; $($builder)*::create(__module_name()).build_length()] =
> +            $($builder)*::create(__module_name()).build();
> +    };
> +}
> +
>  /// Builder for firmware module info.
>  ///
>  /// [`ModInfoBuilder`] is a helper component to flexibly compose firmware paths strings for the
> -- 
> 2.48.1
> 
> 
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

