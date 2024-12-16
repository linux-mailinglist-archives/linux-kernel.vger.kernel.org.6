Return-Path: <linux-kernel+bounces-447523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082CE9F33BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743687A39EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41AA206F25;
	Mon, 16 Dec 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKecVwFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8E206F05;
	Mon, 16 Dec 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360681; cv=none; b=cFhKkmhamgyT2+B/hI4MgDjILYTYitOGchkBF6W1XpnEsDmGiH6HhMp+OW6O3M4r3Wj8EWuspcMte8g0iSil3e1Ri3pzYdnL+k5k5bXYNdS9LdYTJSTCXi5ZvGkg4zNpHhV37yTjgcJ3Kakte5yQTM76IuIFEta+9lJo2bNXdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360681; c=relaxed/simple;
	bh=G6rSvWZlkRq/BV2Xt1BzQjLVBDeiRc/FFqaxFjTsrDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AKqh0zbIxYi3+57p066l4WVMCF1FkQSRHxZM+NR/nJTsm1TRRIumj/5R21t5Rg8KfNjdcxGj9rO5Mnq0vSD7Leuvc0gFuPzLcoy5S0d3JoKtxXPiN9ukhXyBjpylhunTn+YbLCpk42enJgTk4tHF60YPXTpLU1Eud72dGk6UfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKecVwFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A849AC4CEDF;
	Mon, 16 Dec 2024 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360679;
	bh=G6rSvWZlkRq/BV2Xt1BzQjLVBDeiRc/FFqaxFjTsrDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BKecVwFY14JZXcx4RVIDEvqaQrLitthRez+NbSnCmHHEnr656TlNfqnWpI2AssvV9
	 H7d+v+F3slh6EAaNdkArKKN6IWAy9stlUuHLAVCXx4IWhJxpbP6lbsaTD9NzFSgsca
	 VlCmb8fOq4rT49bQWIlbZfhBo/UQbnPK+9GD4U+Wov3LNd5SqbJc1VaLRlClOKkWW0
	 tH79lqXSSZOnWLQbZoQFFuwEE/imx6WqHwi+KUOQFdkFyNm2RuEWMWBrf6UELM0T7c
	 PCWVh+ltYefoI+axtGP03WS1w9+w4ibMabBAydzRgAzwzIng1RwgKok3UrUFTow+aI
	 WuKz+JXEIHJ/A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
  "Vlastimil Babka" <vbabka@suse.cz>,  "John Hubbard"
 <jhubbard@nvidia.com>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  "Andrew Morton" <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Arnd Bergmann" <arnd@arndb.de>,
  "Christian Brauner" <brauner@kernel.org>,  "Jann Horn"
 <jannh@google.com>,  "Suren Baghdasaryan" <surenb@google.com>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v11 7/8] rust: miscdevice: add mmap support
In-Reply-To: <20241211-vma-v11-7-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:11 +0000")
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<ycpHdyG93cH1pBam_CppzFvlm8csS7qz1MiKhj4OS9L1eEw4oXAD95Xk2bDFiiiM_4NDu-XdptH9h3d7YHAFjQ==@protonmail.internalid>
	<20241211-vma-v11-7-466640428fc3@google.com>
Date: Mon, 16 Dec 2024 14:53:59 +0100
Message-ID: <87jzbzag3s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Add the ability to write a file_operations->mmap hook in Rust when using
> the miscdevice abstraction. The `vma` argument to the `mmap` hook uses
> the `VmAreaNew` type from the previous commit; this type provides the
> correct set of operations for a file_operations->mmap hook.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 7e2a79b3ae26..e5366f9c6d7f 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -11,6 +11,8 @@
>  use crate::{
>      bindings,
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    fs::File,
> +    mm::virt::VmAreaNew,
>      prelude::*,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
> @@ -110,6 +112,15 @@ fn release(device: Self::Ptr) {
>          drop(device);
>      }
>
> +    /// Handle for mmap.
> +    fn mmap(
> +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _file: &File,
> +        _vma: &VmAreaNew,
> +    ) -> Result {
> +        kernel::build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
>      /// Handler for ioctls.
>      ///
>      /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
> @@ -156,6 +167,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>          const VTABLE: bindings::file_operations = bindings::file_operations {
>              open: Some(fops_open::<T>),
>              release: Some(fops_release::<T>),
> +            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
>              unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
>              #[cfg(CONFIG_COMPAT)]
>              compat_ioctl: if T::HAS_COMPAT_IOCTL {
> @@ -216,6 +228,31 @@ impl<T: MiscDevice> VtableHelper<T> {
>      0
>  }
>
> +/// # Safety
> +///
> +/// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
> +/// `vma` must be a vma that is currently being mmap'ed with this file.
> +unsafe extern "C" fn fops_mmap<T: MiscDevice>(
> +    file: *mut bindings::file,
> +    vma: *mut bindings::vm_area_struct,
> +) -> c_int {
> +    // SAFETY: The mmap call of a file can access the private data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: Mmap calls can borrow the private data of the file.

This safety comment seems unrelated to the safety requirements of `ForeignOwnable::borrow`.


Best regards,
Andreas Hindborg




