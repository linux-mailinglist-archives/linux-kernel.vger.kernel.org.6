Return-Path: <linux-kernel+bounces-568682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C564A69942
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCDB8A5331
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595E2139C7;
	Wed, 19 Mar 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuo2ra76"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549E20FAAB;
	Wed, 19 Mar 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412421; cv=none; b=XWQXuFY7TdrwpNkkX4oxEzJPq/7TrCws0Cb9E8GxecuHrcFeEqc2yAl1UEvXPRcYaO13MjLXCos0pUdJq/kPmiZ0FWWkbvvRjxa4rbZV/5w7s8Owt06fKjUnYV5nt6P7s7tkCyC+KLEFgLwGhqYD9YxNaelrK6puq/eWQgEuwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412421; c=relaxed/simple;
	bh=/QKaDuRJnlxL0TGJLLlj5aHX6ezbEtZjYvMJY51WpL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAAfui5+ajsPpNFVyJpYhgvERGsdn+2hhLisyjjHAIrpNEDVwJVEq9IxbsgyHKlFNTalkBfma7H5kZ5+9EfyCLjfEusr5D3dLlNeq01Virx5WwqdmB7A4v+N6ASA2CdbSvxft8Club/ZJldfCFNYM88m39stQNIOt+LWDWXUd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuo2ra76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5C5C4CEE4;
	Wed, 19 Mar 2025 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742412421;
	bh=/QKaDuRJnlxL0TGJLLlj5aHX6ezbEtZjYvMJY51WpL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Yuo2ra76miz4C/Qqz3zPUVXpfBvlwRZU5hqSsVjkEnYrP+M8+zrLmSN+tB1Ezq/gG
	 7yIomuGACz2Wj18vM7112kPAxcpkwjrItnSf2J3xu2tl+OhZZ0kwokvLe5ffyTRQCV
	 QuDZioqM/VzsBuERI3+MQ6b5m6jvNUwFoysWcANr7S3L6+re6be8rgxWHFnPvGfMYD
	 RTRqgI3cmCbCgNML98Fdi0/TNZYcL7fPIJbi7sao/xCCrpSuamcfWTib/tijHXJ/jQ
	 764k6WlyiP8voCmpoIEXZA+iRNhss82xXn+tzoTeqMSPcC0Ajl9czCToyZO+pC2Doa
	 u/hRkdkGL3a5g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Matthew
 Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] rust: miscdevice: Provide additional abstractions
 for iov_iter and kiocb structures
In-Reply-To: <20250311-iov-iter-v1-3-f6c9134ea824@google.com> (Alice Ryhl's
	message of "Tue, 11 Mar 2025 14:25:14 +0000")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<F1M8U62rghdw4RaELLHxMh1meevFz5toqtnX_01OqcA8NYebCaSWdHqSlVPBu8XNTWqI9_bRF10kDbWJnzvDBA==@protonmail.internalid>
	<20250311-iov-iter-v1-3-f6c9134ea824@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 20:26:50 +0100
Message-ID: <87plicg6th.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> These will be used for the read_iter() and write_iter() callbacks, which
> are now the preferred back-ends for when a user operates on a char device
> with read() and write() respectively.
>
> Co-developed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index fa9ecc42602a477328a25b5d357db90b59dc72ae..8daafdc7f3e47aef3c90507082d35ad6819598eb 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -14,12 +14,13 @@
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
>      ffi::{c_int, c_long, c_uint, c_ulong},
>      fs::File,
> +    iov::{IovIterDest, IovIterSource},
>      prelude::*,
>      seq_file::SeqFile,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
>  };
> -use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
> +use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin, ptr::NonNull};
>
>  /// Options for creating a misc device.
>  #[derive(Copy, Clone)]
> @@ -119,6 +120,16 @@ fn release(device: Self::Ptr, _file: &File) {
>          drop(device);
>      }
>
> +    /// Read from this miscdevice.
> +    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterDest<'_>) -> Result<usize> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Write to this miscdevice.
> +    fn write_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterSource<'_>) -> Result<usize> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
>      /// Handler for ioctls.
>      ///
>      /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
> @@ -160,6 +171,36 @@ fn show_fdinfo(
>      }
>  }
>
> +/// Wrapper for the kernel's `struct kiocb`.

Could you give more context? Please describe the purpose for the type
and intended use. Perhaps give an example that can be compile tested.


> +///
> +/// The type `T` represents the private data of the file.
> +pub struct Kiocb<'a, T> {
> +    inner: NonNull<bindings::kiocb>,
> +    _phantom: PhantomData<&'a T>,
> +}

An abstraction for `kiocb` does not belong here. It should go into kernel/fs.


Best regards,
Andreas Hindborg



