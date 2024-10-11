Return-Path: <linux-kernel+bounces-361016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E799A267
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEBF286F70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EA215F63;
	Fri, 11 Oct 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="X5mii5su"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4620ADF4;
	Fri, 11 Oct 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644836; cv=none; b=DRCxQ/q1PXJKW+h+QrqG4rxrSNA0Gn1wIkMj08Qpnt335RTNwOaZFw7Pyvmhlazfy3zATFIQUFub1+JBo/7p1sRtCNVnJfR3EjaUb+mLeTqPt4UB1e3JWt2QQrwDmdF5hvurTsaHNy3P/Y0GfmXumyO9CGP5pxT4LhRIMoT18r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644836; c=relaxed/simple;
	bh=M/IjkJBR2BtWNfMw7P8y4T+/ylydS1CJe6qVdFG0bEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0Jmv1DST+CDjjALV5A7gOQc4MDObmjgT/rH655eUxF8ZWhye4RQw5d3P9sCJFUuBa2l/+RZCOpyXrS/5dn4qX9bOxMHdKI1XbYixBOMWGCQiEQXYsZlMScvLYc28En3K320km1/B4rqehH01h5Fvsm6aTiZAMQB+g0l3lUb20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=X5mii5su; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1728644821; bh=Tq37ereFE4PrmtCrRyi97dZnnR7i737bmhgmm5gNjJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X5mii5suzTWLjbFedp1Pqtqf5s+n88QBt7XbwbO66a6MG4u1zsbN3V5vQfAtqQvUh
	 aQ9Xrf4ctJcDzYhA6yBoAP8+YOVAoXFMPGA2VnvVNgfBpdg/gM3tsZ/XtBzYjW2XPt
	 34d7Ia47zKIbhlcISFJfbQb6/YoOJIVR3GTKvMdI=
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
 linux-kernel@vger.kernel.org, lyude@redhat.com, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH 1/3] rust: page: replace the page pointer wrapper with
 Opaque
Date: Fri, 11 Oct 2024 13:07:00 +0200
Message-ID: <065A20A8-EB66-4350-965C-2456841D03A1@kloenk.dev>
In-Reply-To: <20241007202752.3096472-2-abdiel.janulgue@gmail.com>
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
 <20241007202752.3096472-2-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 7 Oct 2024, at 22:27, Abdiel Janulgue wrote:

> Replace NonNull with Opaque to make it possible to cast to a Page point=
er
> from a raw struct page pointer.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/page.rs | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 208a006d587c..08ff09a25223 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -8,8 +8,9 @@
>      error::code::*,
>      error::Result,
>      uaccess::UserSliceReader,
> +    types::Opaque,
>  };
> -use core::ptr::{self, NonNull};
> +use core::ptr::{self};
>
>  /// A bitwise shift for the page size.
>  pub const PAGE_SHIFT: usize =3D bindings::PAGE_SHIFT as usize;
> @@ -25,8 +26,9 @@
>  /// # Invariants
>  ///
>  /// The pointer is valid, and has ownership over the page.
> +#[repr(transparent)]
>  pub struct Page {
> -    page: NonNull<bindings::page>,
> +    page: Opaque<bindings::page>,

Still not to sure where to encode pinning in the type api. Looking into t=
he C struct I see a union that sometimes holds a list head, should this t=
hen be a pinned thing in this type?

 Fiona

>  }
>
>  // SAFETY: Pages have no logic that relies on them staying on a given =
thread, so moving them across
> @@ -65,15 +67,20 @@ pub fn alloc_page(flags: Flags) -> Result<Self, All=
ocError> {
>          // SAFETY: Depending on the value of `gfp_flags`, this call ma=
y sleep. Other than that, it
>          // is always safe to call this method.
>          let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), 0)=
 };
> -        let page =3D NonNull::new(page).ok_or(AllocError)?;
> +        if page.is_null() {
> +            return Err(AllocError);
> +        }
> +        // CAST: Self` is a `repr(transparent)` wrapper around `bindin=
gs::page`.
> +        let ptr =3D page.cast::<Self>();
>          // INVARIANT: We just successfully allocated a page, so we now=
 have ownership of the newly
>          // allocated page. We transfer that ownership to the new `Page=
` object.
> -        Ok(Self { page })
> +        // SAFETY: According to invariant above ptr is valid.
> +        Ok(unsafe { ptr::read(ptr) })
>      }
>
>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        self.page.get()
>      }
>
>      /// Runs a piece of code with this page mapped to an address.
> @@ -245,6 +252,6 @@ pub unsafe fn copy_from_user_slice_raw(
>  impl Drop for Page {
>      fn drop(&mut self) {
>          // SAFETY: By the type invariants, we have ownership of the pa=
ge and can free it.
> -        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> +        unsafe { bindings::__free_pages(self.page.get(), 0) };
>      }
>  }
> -- =

> 2.34.1

