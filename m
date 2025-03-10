Return-Path: <linux-kernel+bounces-554771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B029A59C81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36D7188D9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDE23236E;
	Mon, 10 Mar 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DonOVFqv"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCBF230BF6;
	Mon, 10 Mar 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626723; cv=none; b=gFr0y57+7twfS//XPHe7D6FdDtpC6iYJ6PwuBsIZSZpUVgYeFT9DfscjGFCb597oFvHKyygNFcfD5KwN9tGYAe33cXWqpxQi/QYUk+rTRooFY5MMgTLARnt/+uu1D1sFjSy8JH5IdYbG/dU4mnpqU0K0UCzjam1sbioyWXG3WtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626723; c=relaxed/simple;
	bh=B7YnL/CLbaHeb2ssGyVL8hHmP+iVDuXn+BedFvPPsMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMzD/QX/kX7y51HXHRM7Xu9zeq9/5t0PjQ3piylhfX6EBJcvG2Rpf6E6hUvUo9NGmeobin04HbsMHrEeVSyBMuw0vWINuyZ1J+jEBRBUwVyrkeVF+bZLFUB1zvMlZXFu2ShoBCx6X6cbUshQbeeuaykOXwh+Yc002fjxZ9muDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DonOVFqv; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471fe5e0a80so38102201cf.1;
        Mon, 10 Mar 2025 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741626720; x=1742231520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgrX1tRIbR2vAhEJOBU/n6a5wPS2lKaP7TvFcU68JUQ=;
        b=DonOVFqv4abFU1B+F0Utc5lMCMrQOP+hceoEoxoahfYcwtV92JOEjQugtoVnUXoMP7
         RLuWiWKjCmJit+aVusZxcPkfO52lsOmpEm0hB7SWualaurIJvnOHqdIsO0/fGPxSMhhI
         roZUA+Gv5MgCNmMyTX1GN3WU+f1hl/7lyjapmiVFLWdni+Of8bY0qQgF+vumibZQSzrR
         0Ut15BwkPMhZk0NAcpS99Yd8yK19mjQyMs8VQut/OtOmZ1i6vLY05ZaFPALPK4y9vYFj
         4vHtc/CVAaBGP/YDtin52zDtD1LB1meeOiPfA3iBGNLKMUGdNp51AM1mNdOsbIYRe1Bv
         YBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626720; x=1742231520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgrX1tRIbR2vAhEJOBU/n6a5wPS2lKaP7TvFcU68JUQ=;
        b=wQtVRq1AYeFmJ/u8hIXEKOfsMPX4FChAIZAZZgxFP0jBjlZgE9TVDFmQi7WTO2HAih
         XnMh+iJpn5dGKoQKZLMOw7hZrbIyBLvrw/UG4StDtEXVKTXJunaa+szJIYq4bhIKgXPv
         8TTQAg36q4MQ5NqrXWkvMnuQkFo52S7S6gBNXYihnmZid2adUZdQHI90pufB2c+fCiL4
         XTBvQgjPqK4qGl/NqQppAKV8HogbMIdz+8LrVzGwqY1wXOERNRs7RHaty6OLQLKsWh4R
         B0FsTF79o54jrcXDoUIf44AT/jX7K6vWFXE428vG9aNRSAiVgv1/4I8aEO4kjAXKTnqo
         Oo2w==
X-Forwarded-Encrypted: i=1; AJvYcCWCUdJp2v9uSn9YjqwCTvh1Oe3/tReg2v/fASovhdt0BSysRWIMni7c39D1MT2zVaGf1CVDVSQ5Tx5FuJLawrw=@vger.kernel.org, AJvYcCX3hCnTHxOqKysM9531QKpiFDYV/3Y7Ee9yHojk4a06SD7+6HQw3n7IhxoIt3YfBNjjHsvHhWHa0IJCLFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rh9yQzDUsu+jGHauU6SSMh77D5UHmyoC49mBhLxt13maSMqq
	CRHkllhd4tFAWbBnB43UJcXAV9ToDl+GDYy2wJu3tmB+goU/yKg4
X-Gm-Gg: ASbGncv4BVpotmVJzqfGGWIO+o+tE6SxNOLmxga49+oD38s7OzcePV4Kwgq1SpVsymx
	3C6d07obgi9HsFmdFeT+ty9PplwmDdVQwjtVDtvNxPmS14dtb22s+KfZt7G7f8r787ftZhwKab7
	DXx+Vt3jdSrgecdDCV1RMd29gvhjU2I32o5hXpEVSk1ET8aSthunDWyeUe0PYrEkw5Duy/jqqad
	+afrN6iWCdCjzMPa1ZdTPNW5+3sKsMIe/2/e1eiGpvOxNTPKJOr9stInFNLft7+84DU7/eRur2X
	IouMks68jSxloFLnBJ42sG6mMtZ7AWjJxQLDcRAGmYW5FrGsCewzMHHoGsUyc1BvZM9jdGF2EVD
	QQ0Xfj492eP5+6qyha6h4gTLLnq10GSgOv7U=
X-Google-Smtp-Source: AGHT+IH3/+bZWFwl9VEq8YBiJ/Ufd4MZqsKT1RBWdowAofnK74MwkQuUSipRo1og2JYIPFfo1zYZQg==
X-Received: by 2002:a05:622a:1a08:b0:472:f4c:e880 with SMTP id d75a77b69052e-47618af3559mr212615611cf.49.1741626719538;
        Mon, 10 Mar 2025 10:11:59 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4766ce811d7sm32001901cf.65.2025.03.10.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:11:59 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 85A761200066;
	Mon, 10 Mar 2025 13:11:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 13:11:58 -0400
X-ME-Sender: <xms:Xh3PZz2uR2i0SwM0Ig_0hmKcq5E-7JR5HEZeMh9iDktEOArM2pdHDw>
    <xme:Xh3PZyEaQpsclhzBtV8Xc6hEyaVo0eezgSqvIRheIs6vpyZ9JJgtt8tgyG0eBZQnW
    OdH16MsjuFdKmHT7w>
X-ME-Received: <xmr:Xh3PZz4eayoON7yqb4tdDF9Oqg7gFOcIcxCp8QCACObrZwKa8U-rJNleUTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegteetleduleffjedvieekheeiiefgvdej
    vddtfedutefgtdffhefffedtveegteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    gtrghsthdrrghspdhinhhsthgrnhgtvgdrihhnnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhope
    dufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhlihhvvghrrdhmrghnghho
    lhgusehpmhdrmhgvpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprh
    hothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhr
    ohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:Xh3PZ40A0zagWFb7pSJDP9AmCyvN9xOGBvIUjqzw20UJBq5ubN2Fuw>
    <xmx:Xh3PZ2Gule5Y1WZpf2fFJOK0q-jtabrOI8nTOrZHccuDoPF4OpvWog>
    <xmx:Xh3PZ58BuXBacmE1_G-9ZTdhqbGXuGKv36yVS4nKxj1hCxeeueS-5g>
    <xmx:Xh3PZzkcbAl7sLIhjtSVaEjk1LwBFwFZ76wPsrQXPrOnBNv0l6y5Rw>
    <xmx:Xh3PZyEHoJ9kPxldQKrs2QDTIaGX8djmvVwO5bXepsKaG6K9VkD3K01D>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 13:11:57 -0400 (EDT)
Date: Mon, 10 Mar 2025 10:10:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] rust: rename AlwaysRefCounted to RefCounted
Message-ID: <Z88dDkQLiecmtVgI@boqun-archlinux>
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
 <20250310-unique-ref-v7-2-4caddb78aa05@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-unique-ref-v7-2-4caddb78aa05@pm.me>

On Mon, Mar 10, 2025 at 10:57:31AM +0000, Oliver Mangold wrote:
> AlwaysRefCounted will become a marker trait to indicate that it is allowed
> to obtain an ARef from a `&`, which cannot be allowed for types which are
> also Ownable.
> 
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>

Given it's Alice's suggestion, I think a Suggested-by [1] of her would
be appropriate here.

[1]: https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Regards,
Boqun

> ---
>  rust/kernel/block/mq/request.rs | 10 ++++++---
>  rust/kernel/cred.rs             |  8 ++++++--
>  rust/kernel/device.rs           |  8 ++++++--
>  rust/kernel/fs/file.rs          | 10 ++++++---
>  rust/kernel/pid_namespace.rs    |  8 ++++++--
>  rust/kernel/task.rs             |  6 +++++-
>  rust/kernel/types.rs            | 45 ++++++++++++++++++++++++-----------------
>  7 files changed, 64 insertions(+), 31 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index 2f2bb5a04709cc90ae8971da166fc83bb53fb86b..f6bee0932499e554f88907861997f8b9d1ffd51a 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -9,7 +9,7 @@
>      block::mq::Operations,
>      error::Result,
>      sync::Refcount,
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    types::{ARef, AlwaysRefCounted, Opaque, RefCounted},
>  };
>  use core::{
>      marker::PhantomData,
> @@ -209,10 +209,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
>  unsafe impl<T: Operations> Sync for Request<T> {}
>  
>  // SAFETY: All instances of `Request<T>` are reference counted. This
> -// implementation of `AlwaysRefCounted` ensure that increments to the ref count
> +// implementation of `RefCounted` ensure that increments to the ref count
>  // keeps the object alive in memory at least until a matching reference count
>  // decrement is executed.
> -unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
> +unsafe impl<T: Operations> RefCounted for Request<T> {
>      fn inc_ref(&self) {
>          self.wrapper_ref().refcount().inc();
>      }
> @@ -234,3 +234,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>          }
>      }
>  }
> +
> +// SAFETY: we currently do not implement `Ownable`, thus it is okay to can obtain an `ARef<Request>`
> +// from a `&Request` (but this will change in the future).
> +unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index 81d67789b16f243e7832ff3b2e5e479a1ab2bf9e..e04d1021130eb1ec46fe48feb088959da7656d66 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -11,7 +11,7 @@
>  use crate::{
>      bindings,
>      task::Kuid,
> -    types::{AlwaysRefCounted, Opaque},
> +    types::{AlwaysRefCounted, Opaque, RefCounted},
>  };
>  
>  /// Wraps the kernel's `struct cred`.
> @@ -71,7 +71,7 @@ pub fn euid(&self) -> Kuid {
>  }
>  
>  // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
> -unsafe impl AlwaysRefCounted for Credential {
> +unsafe impl RefCounted for Credential {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::get_cred(self.0.get()) };
> @@ -83,3 +83,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
>          unsafe { bindings::put_cred(obj.cast().as_ptr()) };
>      }
>  }
> +
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<Credential>` from a
> +// `&Credential`.
> +unsafe impl AlwaysRefCounted for Credential {}
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index db2d9658ba47d9c492bc813ce3eb2ff29703ca31..189298518dc184405b1d62404b190d4c0b08b7ad 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -7,7 +7,7 @@
>  use crate::{
>      bindings,
>      str::CStr,
> -    types::{ARef, Opaque},
> +    types::{ARef, AlwaysRefCounted, Opaque, RefCounted},
>  };
>  use core::{fmt, ptr};
>  
> @@ -190,7 +190,7 @@ pub fn property_present(&self, name: &CStr) -> bool {
>  }
>  
>  // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for Device {
> +unsafe impl RefCounted for Device {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>          unsafe { bindings::get_device(self.as_raw()) };
> @@ -202,6 +202,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `Device<Task>` from a
> +// `&Device`.
> +unsafe impl AlwaysRefCounted for Device {}
> +
>  // SAFETY: As by the type invariant `Device` can be sent to any thread.
>  unsafe impl Send for Device {}
>  
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index e03dbe14d62a566349c4100f2f78b17d4c79aab5..a7836cc754e7927b6addc3bd06cfe8c8119f1d9f 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -11,7 +11,7 @@
>      bindings,
>      cred::Credential,
>      error::{code::*, Error, Result},
> -    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque, RefCounted},
>  };
>  use core::ptr;
>  
> @@ -190,7 +190,7 @@ unsafe impl Sync for File {}
>  
>  // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
>  // makes `ARef<File>` own a normal refcount.
> -unsafe impl AlwaysRefCounted for File {
> +unsafe impl RefCounted for File {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -205,6 +205,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<File>` from a
> +/// `&File`.
> +unsafe impl AlwaysRefCounted for File {}
> +
>  /// Wraps the kernel's `struct file`. Not thread safe.
>  ///
>  /// This type represents a file that is not known to be safe to transfer across thread boundaries.
> @@ -225,7 +229,7 @@ pub struct LocalFile {
>  
>  // SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
>  // makes `ARef<File>` own a normal refcount.
> -unsafe impl AlwaysRefCounted for LocalFile {
> +unsafe impl RefCounted for LocalFile {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
> index 0e93808e4639b37dd77add5d79f64058dac7cb87..3e45e945b7509b9607266b2e0e6ef130e7a1ed39 100644
> --- a/rust/kernel/pid_namespace.rs
> +++ b/rust/kernel/pid_namespace.rs
> @@ -9,7 +9,7 @@
>  
>  use crate::{
>      bindings,
> -    types::{AlwaysRefCounted, Opaque},
> +    types::{AlwaysRefCounted, RefCounted, Opaque},
>  };
>  use core::ptr;
>  
> @@ -44,7 +44,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
>  }
>  
>  // SAFETY: Instances of `PidNamespace` are always reference-counted.
> -unsafe impl AlwaysRefCounted for PidNamespace {
> +unsafe impl RefCounted for PidNamespace {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -58,6 +58,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<PidNamespace>`
> +// from a `&PidNamespace`.
> +unsafe impl AlwaysRefCounted for PidNamespace {}
> +
>  // SAFETY:
>  // - `PidNamespace::dec_ref` can be called from any thread.
>  // - It is okay to send ownership of `PidNamespace` across thread boundaries.
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..1cc1b02cb7fada6703da8cad77549dee578fc08d 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -327,7 +327,7 @@ pub fn wake_up(&self) {
>  }
>  
>  // SAFETY: The type invariants guarantee that `Task` is always refcounted.
> -unsafe impl crate::types::AlwaysRefCounted for Task {
> +unsafe impl crate::types::RefCounted for Task {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>          unsafe { bindings::get_task_struct(self.as_ptr()) };
> @@ -339,6 +339,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>  
> +// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an `ARef<Task>` from a
> +// `&Task`.
> +unsafe impl crate::types::AlwaysRefCounted for Task {}
> +
>  impl Kuid {
>      /// Get the current euid.
>      #[inline]
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e0ce3646a4d3b70c069322a9b0f25c00265a2af8..e6f3308f931d90718d405443c3034a216388e0af 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -402,11 +402,9 @@ pub const fn raw_get(this: *const Self) -> *mut T {
>      }
>  }
>  
> -/// Types that are _always_ reference counted.
> +/// Types that are internally reference counted.
>  ///
>  /// It allows such types to define their own custom ref increment and decrement functions.
> -/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> -/// [`ARef<T>`].
>  ///
>  /// This is usually implemented by wrappers to existing structures on the C side of the code. For
>  /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> @@ -418,9 +416,9 @@ pub const fn raw_get(this: *const Self) -> *mut T {
>  /// at least until matching decrements are performed.
>  ///
>  /// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`] keep the object
>  /// alive.)
> -pub unsafe trait AlwaysRefCounted {
> +pub unsafe trait RefCounted {
>      /// Increments the reference count on the object.
>      fn inc_ref(&self);
>  
> @@ -433,11 +431,22 @@ pub unsafe trait AlwaysRefCounted {
>      /// Callers must ensure that there was a previous matching increment to the reference count,
>      /// and that the object is no longer used after its reference count is decremented (as it may
>      /// result in the object being freed), unless the caller owns another increment on the refcount
> -    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> -    /// [`AlwaysRefCounted::dec_ref`] once).
> +    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls
> +    /// [`RefCounted::dec_ref`] once).
>      unsafe fn dec_ref(obj: NonNull<Self>);
>  }
>  
> +/// An extension to RefCounted, which declares that it is allowed to convert
> +/// from a shared reference `&T` to an owned reference [`ARef<T>`].
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that no safety invariants are violated by upgrading an `&T`
> +/// to an [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`Ownable`]
> +/// cannot be implemented for the same type, as this would allow to violate the uniqueness
> +/// guarantee of [`Owned<T>`] by derefencing it into an `&T` and obtaining an [`ARef`] from that.
> +pub unsafe trait AlwaysRefCounted: RefCounted {}
> +
>  /// An owned reference to an always-reference-counted object.
>  ///
>  /// The object's reference count is automatically decremented when an instance of [`ARef`] is
> @@ -448,7 +457,7 @@ pub unsafe trait AlwaysRefCounted {
>  ///
>  /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
>  /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> -pub struct ARef<T: AlwaysRefCounted> {
> +pub struct ARef<T: RefCounted> {
>      ptr: NonNull<T>,
>      _p: PhantomData<T>,
>  }
> @@ -457,16 +466,16 @@ pub struct ARef<T: AlwaysRefCounted> {
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
>  // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
> +unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
>  
>  // SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
>  // because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
>  // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
>  // `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
>  // example, when the reference count reaches zero and `T` is dropped.
> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
> +unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
>  
> -impl<T: AlwaysRefCounted> ARef<T> {
> +impl<T: RefCounted> ARef<T> {
>      /// Creates a new instance of [`ARef`].
>      ///
>      /// It takes over an increment of the reference count on the underlying object.
> @@ -495,12 +504,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// ```
>      /// use core::ptr::NonNull;
> -    /// use kernel::types::{ARef, AlwaysRefCounted};
> +    /// use kernel::types::{ARef, RefCounted};
>      ///
>      /// struct Empty {}
>      ///
>      /// # // SAFETY: TODO.
> -    /// unsafe impl AlwaysRefCounted for Empty {
> +    /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
>      /// }
> @@ -518,7 +527,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
>      }
>  }
>  
> -impl<T: AlwaysRefCounted> Clone for ARef<T> {
> +impl<T: RefCounted> Clone for ARef<T> {
>      fn clone(&self) -> Self {
>          self.inc_ref();
>          // SAFETY: We just incremented the refcount above.
> @@ -526,7 +535,7 @@ fn clone(&self) -> Self {
>      }
>  }
>  
> -impl<T: AlwaysRefCounted> Deref for ARef<T> {
> +impl<T: RefCounted> Deref for ARef<T> {
>      type Target = T;
>  
>      fn deref(&self) -> &Self::Target {
> @@ -543,10 +552,10 @@ fn from(b: &T) -> Self {
>      }
>  }
>  
> -impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +impl<T: RefCounted> Drop for ARef<T> {
>      fn drop(&mut self) {
> -        // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> -        // decrement.
> +        // SAFETY: The type invariants guarantee that the `ARef` owns the reference
> +        // we're about to decrement.
>          unsafe { T::dec_ref(self.ptr) };
>      }
>  }
> 
> -- 
> 2.48.1
> 
> 

