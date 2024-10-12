Return-Path: <linux-kernel+bounces-362152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782099B1A0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9748F1C218A0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913D145A1C;
	Sat, 12 Oct 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syJwBIs/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59461143C5D;
	Sat, 12 Oct 2024 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718615; cv=none; b=cjur2r+DZL7WpN7P5YMOVvtc25z1A5zftBMSD1oZH9PbwVKZts/21arbsady7GUT8F29n1pZesVEra9/AS0dWnOpNoctu4GsTSnlD74i8sOAd08dAMKmxCSYEJKp8YXtNVvFsBNKTLSvcEmPSakyDvQ2J+M0Ia7h1PAra358S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718615; c=relaxed/simple;
	bh=znh8M+Vi4h4Vs2XjJK9TQcknl3nfVfbVm/t+AuBIrP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOoh3XUmUFjh21dT0LLfTCQmYJbfB6QdvZUXK8Xux3m6KxPYd6L23klylFhIhILvB6foKVtEchU8ubyOQxf8WiJ4BzHfgp9bMD/oLd0CjiL7FLjrz7yA6ee9SVNW2L/ZpZnsOXeE4Csl3i4s0dVRgtLTc5Ggye38kRYceimXMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syJwBIs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE02C4CEC6;
	Sat, 12 Oct 2024 07:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728718614;
	bh=znh8M+Vi4h4Vs2XjJK9TQcknl3nfVfbVm/t+AuBIrP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syJwBIs/amyGJ7TyTjg1aqG5PcoeDrjIDfglGvlpyylCzg/FzfxXaXuWBnuHDShSb
	 84XxK+S/kluyA3g/YaGP8llGIb9YeMbWQI85Msw5+Zia0ZNhp36SrDgvM1MOhqafAb
	 rXra2gtJ9FVr2qE8TH+Vfcxa8Zs4TvjfduWpcM8I=
Date: Sat, 12 Oct 2024 09:36:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Josef Zoller <josef@walterzollerpiano.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: char_dev: add character device abstraction
Message-ID: <2024101253-golf-detonator-592c@gregkh>
References: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
 <20241011-rust-char-dev-v1-1-350225ae228b@walterzollerpiano.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-rust-char-dev-v1-1-350225ae228b@walterzollerpiano.com>

On Fri, Oct 11, 2024 at 08:55:42PM +0200, Josef Zoller wrote:
> +unsigned int rust_helper_MAJOR(dev_t dev)
> +{
> +	return MAJOR(dev);
> +}

I don't think you use this function in the code anywhere.

> +unsigned int rust_helper_MINOR(dev_t dev)
> +{
> +	return MINOR(dev);
> +}

Is this really needed?  No driver should care about their minor number,
except to possibly set it, not read it.

> +dev_t rust_helper_MKDEV(unsigned int major, unsigned int minor)
> +{
> +	return MKDEV(major, minor);
> +}

If you are only doing dynamic creation, as your initial text said, I
don't think you need this either as the kernel should create it for you.


> diff --git a/rust/kernel/char_dev.rs b/rust/kernel/char_dev.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..b81c0d55ab60f18dc82a99991318a5ae0a26e560
> --- /dev/null
> +++ b/rust/kernel/char_dev.rs
> @@ -0,0 +1,976 @@
> +// SPDX-License-Identifier: GPL-2.0

Minor nit, you forgot a copyright line :)

> +
> +//! Character device support.
> +//!
> +//! C headers: [`include/linux/cdev.h`](srctree/include/linux/cdev.h) and
> +//! [`include/linux/fs.h`](srctree/include/linux/fs.h)
> +
> +use crate::{
> +    bindings, container_of,
> +    error::{to_result, VTABLE_DEFAULT_ERROR},
> +    fs::{File, LocalFile},
> +    ioctl::IoctlCommand,
> +    prelude::*,
> +    types::{ForeignOwnable, Opaque},
> +    uaccess::{UserPtr, UserSlice, UserSliceReader, UserSliceWriter},
> +};
> +use core::{ffi, mem, ops::Deref};
> +
> +/// Character device ID.
> +///
> +/// This is a wrapper around the kernel's `dev_t` type and identifies a
> +/// character device by its major and minor numbers.
> +#[derive(Clone, Copy, Default, PartialEq, Eq, PartialOrd, Ord, Hash)]
> +#[repr(transparent)]
> +pub struct CharDeviceID(bindings::dev_t); // u32
> +
> +impl CharDeviceID {
> +    /// Creates a new device ID from the given major and minor numbers.
> +    ///
> +    /// This corresponds to the kernel's `MKDEV` macro.
> +    pub fn new(major: u32, minor: u32) -> Self {
> +        // SAFETY: The kernel's `MKDEV` macro is safe to call with any values.
> +        Self(unsafe { bindings::MKDEV(major, minor) })
> +    }
> +
> +    /// Returns the major number of the device ID.
> +    ///
> +    /// This corresponds to the kernel's `MAJOR` macro.
> +    pub fn major(&self) -> u32 {
> +        // SAFETY: The kernel's `MAJOR` macro is safe to call with any value.
> +        unsafe { bindings::MAJOR(self.0) }
> +    }
> +
> +    /// Returns the minor number of the device ID.
> +    ///
> +    /// This corresponds to the kernel's `MINOR` macro.
> +    pub fn minor(&self) -> u32 {
> +        // SAFETY: The kernel's `MINOR` macro is safe to call with any value.
> +        unsafe { bindings::MINOR(self.0) }
> +    }
> +}
> +
> +/// Seek mode for the `llseek` method.
> +///
> +/// This enum corresponds to the `SEEK_*` constants in the kernel.
> +#[repr(u32)]
> +pub enum Whence {
> +    /// Set the file position to `offset`.
> +    Set = bindings::SEEK_SET,
> +    /// Set the file position to the current position plus `offset`.
> +    Cur = bindings::SEEK_CUR,
> +    /// Set the file position to the end of the file plus `offset`.
> +    End = bindings::SEEK_END,
> +    /// Set the file position to the next location in the file greater than or
> +    /// equal to `offset` containing data.
> +    Data = bindings::SEEK_DATA,
> +    /// Set the file position to the next hole in the file greater than or
> +    /// equal to `offset`.
> +    Hole = bindings::SEEK_HOLE,
> +}
> +
> +// Make sure at compile time that the `Whence` enum can be safely converted
> +// from integers up to `SEEK_MAX`.
> +const _: () = assert!(Whence::Hole as u32 == bindings::SEEK_MAX);
> +
> +/// Trait implemented by a registered character device.
> +///
> +/// A registered character device just handles the `open` operation on the
> +/// device file and returns an open device type (which implements the
> +/// [`OpenCharDevice`] trait) that handles the actual I/O operations on the
> +/// device file. Optionally, the `release` operation can be implemented to
> +/// handle the final close of the device file, but simple cleanup can also be
> +/// done in the `Drop` implementation of the open device type.

release is traditionally where you handle cleaning up what was allocated
for this "open", and then drop can handle any "global" state for the
device associated with this specific instance.  So "simple cleanup"
might not be possible in both places, as they are different parts of the
lifecycle of a device.

thanks,

greg k-h

