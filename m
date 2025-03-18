Return-Path: <linux-kernel+bounces-566685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319DFA67B37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA68E3B15F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8037211A1D;
	Tue, 18 Mar 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM4jJOMU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6D2116F4;
	Tue, 18 Mar 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319809; cv=none; b=lFeZB5kpsmoFjEBgZAwhKYZez3smj+MQ2i1ZD94KpXV1BmD/Km4tp0FJwGcoJjL1v3Hs0Q0jzvNDqxalO4fCXmSyFMOr6dSkO0fj9tDt6xrp9fA6MtNoDLxeuxkF189Qy7AsOVyOOZ3SKRrlTy8UvmjWWw0za56ycdobquiIfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319809; c=relaxed/simple;
	bh=47Ycp1Nlhp7V6+NNuDMWVA6BAGjQI5KKeYT/n9q3CdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABaEHok5lxE9npbmrIozg0tLJ2k2azdERey6jwH0rIlJQ0KqUsvivULAd2co3IrbMotogq7ecP5U6cD77P7C2ugNkawUbgL0qAeF6bkLdWBeKNtR1lOXSp8WlRlrvHIEWVXW5zjbs8PzaHssXf2ASRtDk5lsqTCEqi+lItoy8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM4jJOMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E9C4CEDD;
	Tue, 18 Mar 2025 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319808;
	bh=47Ycp1Nlhp7V6+NNuDMWVA6BAGjQI5KKeYT/n9q3CdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WM4jJOMUgXGzfleK8oXsRZQ5C1EgOnSkUR4zyadYASPw1dy5v1UIrPOnPxnyqlPc+
	 xno29ZSnYs6Z9TyjKydauyKWXAWH7HTBhPePZzmjaNsNrbexkkXF5/DG+VZvGtAc9P
	 crQuCEM52RcwMAl8wUYx+8WmapF9NNTZUwc5mkqh+tHvYe8Bc1ASbIobrR0GudVhiW
	 +UuNH0B/HQnO9DUL0RN8GPpDOVHUsTt4xhRXGgpGCgWiqZBxc71SrOnaULGADOXbHm
	 tXtcbJOACiHfmBYcuZLKRMS1YBOSZqWzENovLaLZLYtfUCTjqCK7XXCVaD52kh93pL
	 goQxoyafNM8PA==
Date: Tue, 18 Mar 2025 18:43:23 +0100
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
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v7 3/3] rust: platform: allow ioremap of platform
 resources
Message-ID: <Z9mwu-RHwZ8qwcbH@cassiopeiae>
References: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com>
 <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com>

Hi Daniel,

On Tue, Mar 18, 2025 at 02:20:43PM -0300, Daniel Almeida wrote:
> The preceding patches added support for resources, and for a general
> IoMem abstraction, but thus far there is no way to access said IoMem
> from drivers, as its creation is unsafe and depends on a resource that
> must be acquired from some device first.
> 
> Now, allow the ioremap of platform resources themselves, thereby making
> the IoMem available to platform drivers.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/platform.rs | 123 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)

You need to rebase this onto driver-core-next.

> 
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 1297f5292ba9b7ca9784f84979efbeccb0768bd3..56f3d7c0d536d77082d7f8d2407de17ee3e95ffa 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -5,8 +5,14 @@
>  //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
>  
>  use crate::{
> -    bindings, container_of, device, driver,
> +    bindings, container_of, device,
> +    devres::Devres,
> +    driver,
>      error::{to_result, Result},
> +    io::{
> +        mem::{ExclusiveIoMem, IoMem},
> +        resource::Resource,
> +    },
>      of,
>      prelude::*,
>      str::CStr,
> @@ -191,6 +197,121 @@ fn as_raw(&self) -> *mut bindings::platform_device {
>          // embedded in `struct platform_device`.
>          unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
>      }
> +
> +    /// Maps a platform resource through ioremap() where the size is known at
> +    /// compile time.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::{bindings, c_str, platform};
> +    ///
> +    /// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
> +    ///     let offset = 0; // Some offset.
> +    ///
> +    ///     // If the size is known at compile time, use `ioremap_resource_sized`.
> +    ///     // No runtime checks will apply when reading and writing.
> +    ///     let resource = pdev.resource(0).ok_or(ENODEV)?;
> +    ///     let iomem = pdev.ioremap_resource_sized::<42>(&resource)?;
> +    ///
> +    ///     // Read and write a 32-bit value at `offset`. Calling `try_access()` on
> +    ///     // the `Devres` makes sure that the resource is still valid.
> +    ///     let data = iomem.try_access().ok_or(ENODEV)?.readl(offset);
> +    ///
> +    ///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);

I'd probably write this as

	|| -> Result {
		let iomem = iomem.try_access().ok_or(ENODEV)?;

		iomem.read32(offset);
		iomem.write32(data, offset);

		Ok(())
	}()?;

There's also a patch [1] in progress that makes this more convenient.

[1] https://lore.kernel.org/rust-for-linux/20250313-try_with-v1-1-adcae7ed98a9@nvidia.com/

