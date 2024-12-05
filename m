Return-Path: <linux-kernel+bounces-433120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571C9E540D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9376167FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED2202C30;
	Thu,  5 Dec 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCP+vdC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D591FAC34;
	Thu,  5 Dec 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398529; cv=none; b=u4AG6fr068nrXnKLmmLcQyoyYcxIhIZD8ngwkVDTgWtD5cljl0qbD1PSMa9udKbieMayBMEZrbM8E4htXux/do2aJ7uLGM0tdkxYIjCmTYRqIQPIjS1hfi5w2UXiZlQzFwF0WSFHMZL9dHynkbtbG+eg043Bx/huQMOj3CYpvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398529; c=relaxed/simple;
	bh=jvPCGrHqObr38SBHGilmOh0r7dHyawWF8/PKpw7i7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiEhjIy+xxo57eo3RoHkhJJdidvh2l/eDDUD0lmqmB9WXb/Z6z4x3LloSWJsq8ZNmcZsiZu3e9IJmNQRdbj267mDZILUKUKAGk4Ta8VzuJpD5Mu9OdzjDNEUAZH5bE45+hDPFB2RwS5ksnHXV/xCI4QmckLNuC7Ws+Kl9YGdvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCP+vdC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389CBC4CEDF;
	Thu,  5 Dec 2024 11:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733398527;
	bh=jvPCGrHqObr38SBHGilmOh0r7dHyawWF8/PKpw7i7wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCP+vdC4RQuVuKxQD/1sPzEN/A8BMURz+RF0p3pfcqGOPFfVe7jEgY0DGSRgKpEPt
	 /x9xA+dyYuKs6zG7QfLFTzwok0IZclIwtb51WfiuHMN5lir1wwpbatqivgJTXzJOdL
	 Aw/oN5m3q13qqW9eXIVBj5xphYKSMcnpezMJ3ILtHe2SNRqFDIRryQ48pEYHtZMcMz
	 m/qeVKdl5YHw1UfdKosvc2nn6EGC8uYhG4GSKzwX8+bOBwO/8dsLiy7ooOu0ED/nCg
	 z9rowWVy/sBf5Xl4WqIrNMrlvH6fNhoNdonGBPb/KfCGfOuauq33ZqVxZkrULBoZmQ
	 D0yJhUW+S5lbg==
Date: Thu, 5 Dec 2024 12:35:21 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jimmy Ostler <jtostler1@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Filipe Xavier <felipe_life@live.com>,
	Valentin Obst <kernel@valentinobst.de>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: alloc: Add doctest for `ArrayLayout`
Message-ID: <Z1GP-QPDFDjS6qLo@cassiopeiae>
References: <20241205105627.992587-1-jtostler1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205105627.992587-1-jtostler1@gmail.com>

Hi Jimmy,

Thanks for the patch!

On Thu, Dec 05, 2024 at 02:56:27AM -0800, Jimmy Ostler wrote:
> Add a rustdoc example and Kunit test to the `ArrayLayout` struct's
> `ArrayLayout::new()` function.
> 
> Add an implementation of `From<LayoutError> for Error` for the
> `kernel::alloc::LayoutError`. This is necessary for the new test to
> compile.

Please split this into a separate patch.

> 
> Change the `From` implementation on `core::alloc::LayoutError` to avoid
> collisions with `kernel::alloc::LayoutError`, and modify imports to
> explicitly import `kernel::alloc::LayoutError` instead.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1131
> Signed-off-by: Jimmy Ostler <jtostler1@gmail.com>
> ---
> v1: https://lore.kernel.org/lkml/20241203051843.291729-1-jtostler1@gmail.com/T/#u
> v1 -> v2 changes:
> - Add third assert where length is smaller but still overflows
> - Remove rustdoc markdown codeblock languge signifier
> - Change tests to return results using `?` instead of panic
> - Remove `#[derive(Debug)]` for `LayoutError`
> - Add `From<LayoutError> for Error` implementation
> ---
>  rust/kernel/alloc/layout.rs | 19 +++++++++++++++++++
>  rust/kernel/error.rs        | 13 ++++++++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
> index 4b3cd7fdc816..0e053dcc7941 100644
> --- a/rust/kernel/alloc/layout.rs
> +++ b/rust/kernel/alloc/layout.rs
> @@ -43,6 +43,25 @@ pub const fn empty() -> Self {
>      /// # Errors
>      ///
>      /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::alloc::layout::{ArrayLayout, LayoutError};
> +    /// let layout = ArrayLayout::<i32>::new(15)?;
> +    /// assert_eq!(layout.len(), 15);
> +    ///
> +    /// // Errors because `len * size_of::<T>()` overflows
> +    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize);
> +    /// assert!(layout.is_err());
> +    ///
> +    /// // Errors because `len * size_of::<i32>() > isize::MAX`,
> +    /// // even though `len < isize::MAX`
> +    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize / 2);
> +    /// assert!(layout.is_err());
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
>      pub const fn new(len: usize) -> Result<Self, LayoutError> {
>          match len.checked_mul(core::mem::size_of::<T>()) {
>              Some(size) if size <= ISIZE_MAX => {
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 52c502432447..ac8526140d7a 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -4,9 +4,10 @@
>  //!
>  //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
>  
> -use crate::{alloc::AllocError, str::CStr};
> -
> -use core::alloc::LayoutError;
> +use crate::{
> +    alloc::{layout::LayoutError, AllocError},
> +    str::CStr,
> +};

I think this part of the change would be enough, since we don't make use of the
`From` implementation of `core::alloc::LayoutError` anywhere.

I think we can add it (again), once it's needed.

>  
>  use core::fmt;
>  use core::num::NonZeroI32;
> @@ -223,6 +224,12 @@ fn from(_: LayoutError) -> Error {
>      }
>  }
>  
> +impl From<core::alloc::LayoutError> for Error {
> +    fn from(_: core::alloc::LayoutError) -> Error {
> +        code::ENOMEM
> +    }
> +}
> +
>  impl From<core::fmt::Error> for Error {
>      fn from(_: core::fmt::Error) -> Error {
>          code::EINVAL
> 
> base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
> -- 
> 2.47.1
> 

