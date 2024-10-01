Return-Path: <linux-kernel+bounces-346381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08D98C41C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3737E1F25B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110A1CBE96;
	Tue,  1 Oct 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSPifnfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D511A3A80;
	Tue,  1 Oct 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802100; cv=none; b=PE8rIES66WO0LTWeu8IRwi3Y8E6fiYaXhp/8M5b4v5Gy3G8Z108l/w8JbRvfUtp+PeNLmPGQhJR35VW65zxb+X9SxVgqVMmqbgsDWZm+SCnA6ZLo6Grhovhj8UrZ7q3X1VdsjSUqpIrNdJyWTVHUpnD2nSTDE5ABf7ASs4A8/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802100; c=relaxed/simple;
	bh=teSRd6Ope2DM1P70Vhor8hV4zEZunc3MBpZztCPf6/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ4UE6QEZsm/Uqjkf+tD/HbyG1TZJkMfsglKSxG+8IAjl9Uwnl+rilSGdpmTuzQYmLX6j+J5r9BzUMH0VKTzqxn+o6MwQ6fGBCSK6mN5ojgvNNcuwjKnJk0O4uLG50szPtrJ6oGPH2YZ6EFLgm8EFlgqkeQf8ZH24Ln5THxv9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSPifnfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3552C4CEC7;
	Tue,  1 Oct 2024 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727802100;
	bh=teSRd6Ope2DM1P70Vhor8hV4zEZunc3MBpZztCPf6/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSPifnfKeiEM9VuZQsBfEGNVmWslyQGIsKySPeluxkX7A6zJ6oGrmibGVLIEhr9I8
	 t2NQRTLMU5WIZHlXADkAm8RL3Q4oZIh8Xd8Ik/qa45wTO6NMZMliujIAJ5HaCv2Hhb
	 qdQssS4RdQgTS+C57bSoHnQ2cVCvaDpCjNez3MeM=
Date: Tue, 1 Oct 2024 19:01:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: device: change the from_raw() function
Message-ID: <2024100150-panther-human-0a46@gregkh>
References: <20241001164355.104918-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001164355.104918-1-trintaeoitogc@gmail.com>

On Tue, Oct 01, 2024 at 01:43:38PM -0300, Guilherme Giacomo Simoes wrote:
> The function Device::from_raw() increments a refcount by a call to
> bindings::get_device(ptr). This can be confused because usually
> from_raw() functions don't increment a refcount.
> Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
> semantics.
> 
> The new name of function should be "get_device" to be consistent with
> the function get_device() already exist in .c files.
> 
> This function body also changed, because the `into()` will convert the
> `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
> `AlwaysRefCounted` trait implemented for Device.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  rust/kernel/device.rs   | 15 +++------------
>  rust/kernel/firmware.rs |  2 +-
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 851018eef885..c8199ee079ef 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -51,18 +51,9 @@ impl Device {
>      ///
>      /// It must also be ensured that `bindings::device::release` can be called from any thread.
>      /// While not officially documented, this should be the case for any `struct device`.
> -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> -        // SAFETY: By the safety requirements, ptr is valid.
> -        // Initially increase the reference count by one to compensate for the final decrement once
> -        // this newly created `ARef<Device>` instance is dropped.
> -        unsafe { bindings::get_device(ptr) };
> -
> -        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
> -        let ptr = ptr.cast::<Self>();
> -
> -        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
> -        // `bindings::get_device` we also own a reference to the underlying `struct device`.
> -        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> +        // SAFETY: By the safety requirements ptr is valid
> +        unsafe { Self::as_ref(ptr) }.into()
>      }
>  
>      /// Obtain the raw `struct device *`.
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index dee5b4b18aec..13a374a5cdb7 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
>  ///
>  /// # fn no_run() -> Result<(), Error> {
>  /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> -/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> +/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
>  ///
>  /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
>  /// let blob = fw.data();
> -- 
> 
> differences from v1:
> - this version don't have 0/1 patch anymore.
> - this version contains a refactor get_device() function
> 
> The motivation from this change was will discussion in:
> https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E
> 
> I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
> <dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
> patch.

This information goes below the _first_ --- line, not down here at the
bottom of the patch.  The documentation should explain all of this, you
did read that, right?  :)

v3 please?

thanks,

greg k-h

