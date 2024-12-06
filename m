Return-Path: <linux-kernel+bounces-434481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E89E6760
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCBC1883930
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A957F1DA632;
	Fri,  6 Dec 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBDHZQYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8B58222;
	Fri,  6 Dec 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467374; cv=none; b=hhRWeo5/NAgQ+Rah0ndka+1RCGb4nsUu+x4zmYd08Sthss3alAvt6/k9h6QY1lmX7fLKVgF2a0ZIHZzV5Rq4Vi6NZQF35fZ9cSOAfrM7veoC7X27B7Z4LfXYWFMnh7N14+J+F2Co69L0F3lYjkl2Vyov4zsjlDGx5nEAlLrubzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467374; c=relaxed/simple;
	bh=lc2eNUxj94J3so9pJfyH+alTtf29ra0uAXnLKam+tck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxDiVMk240Nbghc9w7QPT6SUvyZ5kvowM7vrQa7e9/KI9ndfwFlxbW+fano9Hq0NhzXKJSqQciTi1avGgTS3vJiEVgHLumNdiX6DbUtcaH7kH5MooqPjk1+j/tZe+Ad01XI2IymZnV3ql1W5wyLYa8uHK1YG76OtnU/ddNh3aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBDHZQYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2336C4CED1;
	Fri,  6 Dec 2024 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733467373;
	bh=lc2eNUxj94J3so9pJfyH+alTtf29ra0uAXnLKam+tck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBDHZQYbLHrcnuJGPuSUMI2oqAqCCS/Cww6miVgyictF7S4bHUKIQnVGTW1rZz80a
	 axVsxMrIYURovPR8PvMcTe+gksS3wo0OAcJXxHXMq2FXNVDIq2+xmbGTcAcO2NhkUc
	 1p5VjLk5f1zcNhoUys7vZU+XRQmPT0W0RXR4VPOs=
Date: Fri, 6 Dec 2024 07:42:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <2024120648-finch-shrubbery-c6f5@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205162531.1883859-2-lee@kernel.org>

On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> There are situations where a pointer to a `struct device` will become
> necessary (e.g. for calling into dev_*() functions).  This accessor
> allows callers to pull this out from the `struct miscdevice`.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  rust/kernel/miscdevice.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 7e2a79b3ae26..55340f316006 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -10,11 +10,13 @@
>  
>  use crate::{
>      bindings,
> +    device::Device,
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
>      prelude::*,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
>  };
> +
>  use core::{
>      ffi::{c_int, c_long, c_uint, c_ulong},
>      marker::PhantomData,
> @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
>      pub fn as_raw(&self) -> *mut bindings::miscdevice {
>          self.inner.get()
>      }
> +
> +    /// Returns a pointer to the current Device
> +    pub fn device(&self) -> &Device {
> +        // SAFETY: This is only accessible after a successful register() which always
> +        // initialises this_device with a valid device.
> +        unsafe { Device::as_ref((*self.as_raw()).this_device) }

A "raw" pointer that you can do something with without incrementing the
reference count of it?  Oh wait, no, it's the rust device structure.
If so, why isn't this calling the get_device() interface instead?  That
way it's properly incremented and decremented when it "leaves the scope"
right?

Or am I missing something here as to why that wouldn't work and this is
the only way to get access to the 'struct device' of this miscdevice?

thanks,

greg k-h

