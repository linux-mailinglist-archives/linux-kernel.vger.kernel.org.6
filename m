Return-Path: <linux-kernel+bounces-433960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4C9E5F5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BEF1884FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500A1B393B;
	Thu,  5 Dec 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="HoMJJviQ"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34541193;
	Thu,  5 Dec 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430195; cv=none; b=sWp/7nYnlm+rdvjBu0dI2fIXsDeFoPqfvsBYrbg3bEiXaMZK/K/XBUCF+0lu2TeUv9k9vX/B5diXL85nOoJS7yrC97a9YCtC+tRclYbVJ74ctYh9cYY57xlhfbu5v+NooJOFNZsD3rWCauvPnpW2qJsSJH8DpKgzdiLv8XVvVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430195; c=relaxed/simple;
	bh=ZQc7NSJKN882uTQwwCRETACHGtBZJCvANfM3h3m8DOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgAMYi2+307zkdQ/pjhUkIydWqWfUCRqZGUhsy1WuFBBLiFeGAtN3MB7KrzdtBbvdv7dNBKaCUc6/0vVOK5kW75KabD8IJpi5bYWX3nugPeZd/9HIXgu6BHkAwqXyQ5gflBH/a33DKzM+McjNyKOttVy1ojDY1XtzSwcgII53hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=HoMJJviQ; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1733430186; bh=bAbantaMJVIqqDIIM1WewBZ5qc3NDwPXnp4lVgepfAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HoMJJviQ7l4/0b9uKwTaFOnnCPeCn89j9EsZUBl03XXeGRF504yFDxpRKW3+vQJlK
	 9iA0lrKR85CPa1tOHEzcX4dSX0EqnHSYD2F79ub4qhsK/OfJ5+aEKp1IW8qSEnAbLb
	 xuuDfx3DUtzKUcoIpCq0l7Ms3+D5AlkiAgroSkXY=
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Date: Thu, 05 Dec 2024 21:23:03 +0100
Message-ID: <F599F062-5519-4DC4-8303-7630BE0B900A@kloenk.dev>
In-Reply-To: <20241205162531.1883859-2-lee@kernel.org>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 5 Dec 2024, at 17:25, Lee Jones wrote:

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
> @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl Pin=
Init<Self, Error> {
>      pub fn as_raw(&self) -> *mut bindings::miscdevice {
>          self.inner.get()
>      }
> +
> +    /// Returns a pointer to the current Device

I would not call this pointer but rather reference? Pointer is usually as=
sociated with *mut or *const, and this is a reference to the Device abstr=
action


Thanks,
 - Fiona

> +    pub fn device(&self) -> &Device {
> +        // SAFETY: This is only accessible after a successful register=
() which always
> +        // initialises this_device with a valid device.
> +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> +    }
>  }
>
>  #[pinned_drop]
> -- =

> 2.47.0.338.g60cca15819-goog

