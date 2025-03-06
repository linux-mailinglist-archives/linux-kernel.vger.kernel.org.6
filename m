Return-Path: <linux-kernel+bounces-548043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF67A53F24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A668B170255
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD41AAC9;
	Thu,  6 Mar 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fvFai9fn"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084F3A27B;
	Thu,  6 Mar 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221083; cv=none; b=McB8zV6fBdkMa720/ViuwKQKz7+wfunatZnjvS3vniCSVVdl3bLkOvbCS5UgHJOa9tohtAu80wxOzCjG6wlVaYyCDbT459AKDonuKbItk3mT9ABqjqrEjxJtTcHtDwnXq/1BqX/ry0iHd8cA3rB/Q18TOtzOSbm6L9juvJHfmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221083; c=relaxed/simple;
	bh=2eTpU73UttkO0jkIPP4GbgcPgAsJ8wIZ2p+tYFXfN+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr2RWGU/N0n0q0RCpU5xU4V5pdhUKqQdy2AJWWuZdC21fFjkj54E6g8gSNwUokiVm38Ppq26XqHcIBQ32EmaPZiIfp9ViH1QaM9wUo4EzAok81xqvh9rYC9GhK1IV/7NpTU2q7zOrEqqII3KHNrcqHYT1QXdF2lrc+9RUMrHsWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fvFai9fn; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741221079; x=1741480279;
	bh=lP7zxDTbeyDZl0Ryw9P4Uxud5cGW/sqewezSoPeHTi8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fvFai9fnStR80Ck8q5ZbNYGtkk79SqF9sDYjImm1MpaSN6RDOS+8lhTcu4HXf7pz9
	 T9lMedaRW741aWPMQu6x1qkNz8rYkPnDMz8G+InK+mr5ym8Z7os07oaG3k52xycWtO
	 +408J6O0lf8KRisg58hDagab57rMVaK1CGz5b/l+UPFxpmr3J+3NZ3e10uo9jLU0bF
	 e2JszLzwZOYc+Xly3hL/osA3FiNUHbd1RsjCl90QuuRVXxUg+QnvleEhOwJPKkukQY
	 Ids9xB5ZbQEABna8Y5ccztGCUDGX4jSYLlVeOdFw4VApoGE/t2yucj2hckmCuoSGHR
	 318twzUTdMVGw==
Date: Thu, 06 Mar 2025 00:31:14 +0000
To: Danilo Krummrich <dakr@kernel.org>, airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/5] rust: firmware: add `module_firmware!` macro
Message-ID: <D88RCQTNVD7B.3RIN253F8LODY@proton.me>
In-Reply-To: <20250304173555.2496-4-dakr@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-4-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8d1ff6c103cb6cc8c060a13e03d39356aa065e1c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
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
> +/// This macro is the counterpart of the C macro `MODULE_FIRMWARE()`, bu=
t instead of taking a
> +/// simple string literals, which is already covered by the `firmware` f=
ield of
> +/// [`crate::prelude::module!`], it allows the caller to pass a builder =
type (e.g.
> +/// [`ModInfoBuilder`]) which can create the firmware modinfo strings in=
 a more flexible way.
> +///
> +/// Drivers should extend the [`ModInfoBuilder`] with their own driver s=
pecific builder type.
> +///
> +/// The `builder` argument must be a type which implements the following=
 function.
> +///
> +/// `const fn create(module_name: &'static CStr) -> ModInfoBuilder`
> +///
> +/// `create` should pass the `module_name` to the [`ModInfoBuilder`] and=
, with the help of
> +/// it construct the corresponding firmware modinfo.
> +///
> +/// Typically, such contracts would be enforced by a trait, however trai=
ts do not (yet) support
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
> +///     const fn create(module_name: &'static kernel::str::CStr) -> firm=
ware::ModInfoBuilder<N> {
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

Would be nice to see a more complex example here like the one from nova
you sent in the other thread. So with "dynamic" string interpolation and
multiple pushes.

> +#[macro_export]
> +macro_rules! module_firmware {
> +    ($($builder:tt)*) =3D> {

This should probably be `$builder:expr` instead.

> +
> +        #[cfg(not(MODULE))]
> +        const fn __module_name() -> &'static kernel::str::CStr {
> +            <LocalModule as kernel::ModuleMetadata>::NAME

Please either use `::kernel::` or `$crate::` instead of `kernel::`.

Hmm, I am not 100% comfortable with the `LocalModule` way of accessing
the current module for some reason, no idea if there is a rational
argument behind that, but it just doesn't sit right with me.

Essentially you're doing this for convenience, right? So you don't want
to have to repeat the name of the module type every time?

> +        }
> +
> +        #[cfg(MODULE)]
> +        const fn __module_name() -> &'static kernel::str::CStr {
> +            kernel::c_str!("")

Ditto.

> +        }

Are these two functions used outside of the `static` below? If no, then
you can just move them into the static? You can also probably use a
`const` instead of a function, that way you only have 4 lines instead
of 8.

---
Cheers,
Benno

> +
> +        #[link_section =3D ".modinfo"]
> +        #[used]
> +        static __MODULE_FIRMWARE: [u8; $($builder)*::create(__module_nam=
e()).build_length()] =3D
> +            $($builder)*::create(__module_name()).build();
> +    };
> +}
> +
>  /// Builder for firmware module info.
>  ///
>  /// [`ModInfoBuilder`] is a helper component to flexibly compose firmwar=
e paths strings for the
> --
> 2.48.1



