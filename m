Return-Path: <linux-kernel+bounces-434518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6E9E67C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8901631C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA951DC745;
	Fri,  6 Dec 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUKb12ZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B381DA2E5;
	Fri,  6 Dec 2024 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469413; cv=none; b=qQWOIJUgqA67aOftuoRJ6Qef4ZC3mvC+RKt0nOASjCdqHiz/+dW4r9+HEbmGQN4+e7pvJ5RDR+LnGAE/U+jH90rtt3iPp3jy9MOWcVsHEVAqurRdDSo73cvSYXMAUB0tFaFon4raGU4TYVgu5WteHysS5eq85x2c/VpMqrJUoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469413; c=relaxed/simple;
	bh=81OXjo7kJ2OaE6XEp45+wpZs729H7hk4+IYRJuLsisE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEtlcxt6FtPnjSSIoY0pmsffHRemIkGcmczMfJolVW0A7/96rkErWboNGb1joYQ7FTf71dKS6DtIeigqAfYgYn5HBbJqCynpztjfaLNPflQu6o5Y/cuU9ItQVeTx4DRDpm4fltSuxENQxQrcP3cLhUo1mgeDZ/uT2rO1XkPrLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUKb12ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8E8C4CED1;
	Fri,  6 Dec 2024 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469412;
	bh=81OXjo7kJ2OaE6XEp45+wpZs729H7hk4+IYRJuLsisE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUKb12ZHyOeKfrlCxp6OIZ9xQzLOU5xXYJLukgE+DNQHzWms2ZkGDOH/+7vufQLHt
	 os/rhAxBt7OiLhf/xkBKc1d6xuVJyUAGu+ZJYqsEzWYLrMV1oNVjSzGBRKeVKrmTfD
	 gkDCac8MyKGWv+TngRPeX396l90TnZFtqPTEAiZBhc8zqdIl6AVgsL+K6TvSHrnaT0
	 vE0ayolfsgnjNo1NwxrMnhmYmoBoGY6hUQw7mEpKTek2ijTErlX/waJo7nfX/NAvw3
	 +uItH9Y+Lx6wqSNhJq7XsaHdy7JJA1wWBiTIpROdn0/A8+GCma4NpXuSAhDP3vGm6X
	 EaZOpu7GiG+LA==
Date: Fri, 6 Dec 2024 07:16:46 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <20241206071646.GE8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120648-finch-shrubbery-c6f5@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > There are situations where a pointer to a `struct device` will become
> > necessary (e.g. for calling into dev_*() functions).  This accessor
> > allows callers to pull this out from the `struct miscdevice`.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  rust/kernel/miscdevice.rs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 7e2a79b3ae26..55340f316006 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -10,11 +10,13 @@
> >  
> >  use crate::{
> >      bindings,
> > +    device::Device,
> >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> >      prelude::*,
> >      str::CStr,
> >      types::{ForeignOwnable, Opaque},
> >  };
> > +
> >  use core::{
> >      ffi::{c_int, c_long, c_uint, c_ulong},
> >      marker::PhantomData,
> > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> >          self.inner.get()
> >      }
> > +
> > +    /// Returns a pointer to the current Device
> > +    pub fn device(&self) -> &Device {
> > +        // SAFETY: This is only accessible after a successful register() which always
> > +        // initialises this_device with a valid device.
> > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> 
> A "raw" pointer that you can do something with without incrementing the
> reference count of it?  Oh wait, no, it's the rust device structure.
> If so, why isn't this calling the get_device() interface instead?  That
> way it's properly incremented and decremented when it "leaves the scope"
> right?
> 
> Or am I missing something here as to why that wouldn't work and this is
> the only way to get access to the 'struct device' of this miscdevice?

Fair point.  I'll speak to Alice.

Another reason why using dev_info() is not possible at the moment.

-- 
Lee Jones [李琼斯]

