Return-Path: <linux-kernel+bounces-577640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF05A71FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515953B4AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD67254857;
	Wed, 26 Mar 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coz3br1C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C1137930;
	Wed, 26 Mar 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019233; cv=none; b=Y2Ambe/gWxH3a1vVtsWy4WMds47n3VP4feQO1RUjqQI2Dw9ly5UtJLrn443G+EbJOp2qsSS3pMEhNYeA4HKB7+YyWpmjZknOylOiaViHVUMoSj9Ugry4hCOaPrZ+F9FCEnl5II0Wj35G9sHa0Z8qcTsqZctzIeO/Rn1repo6vFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019233; c=relaxed/simple;
	bh=bvMdOWoWq0TBIL9gpxTw+jRmtDhjTC4zq9zMiMKAk0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecXqZGIpcRY1K8/2J2ckihFzMgw4x0/WmMjVRWIQTxsQ9DFX/Qk72N8lNFfVbxzrFd9P/QfWXe8fcUJ2u1551wRe9cWcfqNSErudu2qb/JdnvMXVZk5kuAP2J9Br84hvKtREmh5rSVy21tuzv1vDh8PpYKLNhAUXJw2O0c8FLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coz3br1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9D8C4CEE2;
	Wed, 26 Mar 2025 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019232;
	bh=bvMdOWoWq0TBIL9gpxTw+jRmtDhjTC4zq9zMiMKAk0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Coz3br1C085AjKg3xpEu3rqJOSHK4+9FHNRPrwigy2X+ZSLurJxOOx8bi6irynCeN
	 Jk3QfzJoZpmz7BnBy2Fyj7sU68qAZhxCpbCrsDPouLni+XXcl5sN8xFHotAEy5IeBf
	 N4SC0tRAJNR34XzWtelXMe5InrO3ipA2XNQdyrtb6bBU5MiSDw1u6pBmzEb0MKSu0F
	 /4FOGMFT+bbQyqe1HaWzkhP66gSQMUbYhjc3fd4cbKvvhgxeLLbMdcM1n4Om0kojCo
	 c3oeg0tPGGladfi9fiQIPJx4I5NZmS9M/IOt9vpyjkuOD++cmRNNSUsiI9GSWAYy9S
	 3kF2HnsBEUJWg==
Date: Wed, 26 Mar 2025 15:00:31 -0500
From: Rob Herring <robh@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] rust: Add an Integer trait
Message-ID: <20250326200031.GA2787672-robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-3-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-3-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:41PM +0100, Remo Senekowitsch wrote:
> From: "Rob Herring (Arm)" <robh@kernel.org>
> 
> Add an "Integer" trait similar to crate::num::Integer. This is useful
> for implementing generic methods which operate on different sizes of
> integers. One example is reading DT/ACPI firmware properties.
> 
> This was originally proposed by Alice Ryhl[1].
> 
> [1] https://lore.kernel.org/rust-for-linux/CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com/
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

This needs your Signed-off-by too because you are sending it.

> ---
>  rust/kernel/types.rs | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 2bbaab83b..21647b7ba 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -3,10 +3,11 @@
>  //! Kernel types.
>  
>  use crate::init::{self, PinInit};
> +use crate::transmute::{AsBytes, FromBytes};
>  use core::{
>      cell::UnsafeCell,
>      marker::{PhantomData, PhantomPinned},
> -    mem::{ManuallyDrop, MaybeUninit},
> +    mem::{size_of, ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
>      ptr::NonNull,
>  };
> @@ -553,6 +554,25 @@ pub enum Either<L, R> {
>      Right(R),
>  }
>  
> +/// Trait defined for all integer types similar to `crate::num::Integer`
> +pub trait Integer: FromBytes + AsBytes + Copy {
> +    /// Size of the integer in bytes
> +    const SIZE: usize;
> +}
> +
> +macro_rules! impl_int {
> +    ($($typ:ty),* $(,)?) => {$(
> +        impl Integer for $typ {
> +            const SIZE: usize = size_of::<Self>();
> +        }
> +    )*};
> +}
> +
> +impl_int! {
> +    u8, u16, u32, u64, usize,
> +    i8, i16, i32, i64, isize,
> +}
> +
>  /// Zero-sized type to mark types not [`Send`].
>  ///
>  /// Add this type as a field to your struct if your type should not be sent to a different task.
> -- 
> 2.49.0
> 

