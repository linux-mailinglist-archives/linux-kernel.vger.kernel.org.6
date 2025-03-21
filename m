Return-Path: <linux-kernel+bounces-571639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56C6A6BFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2631893C65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAA22B59C;
	Fri, 21 Mar 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6+X2JCF"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B71C5D4B;
	Fri, 21 Mar 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574852; cv=none; b=jKTNOQkCe0KZ3IwHbbFGOjRYSGQbuKTH5EmQ5MpFpM6kADqTVS/CHDqHtJO4QhmUhI2+xdnDNkZ1XfvpMlvPMJW3kTpXIFg8blbtlbAXSWB+OErb8nvtkv07loo9ZjO9y5tkr84MFGZfeJSHflsi3h84+VDS3sFDw9misDaXkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574852; c=relaxed/simple;
	bh=M0OKj+ce4F9U9P6bYDM+vRH1npCNfPQhfKBGlJhtR2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/N+czeo0IFEoidDuMbIA3+LZi0Ji3vId9x5Ftuof0HHIPfkGJt62X40uBicZfRogptjqbDKejWaj5vSv48JCqe4NU5FiwxIZ21RBkQwZVXY2IyToK2Nvrcu11XKaclZ41Db2jVy53Ivxi7q4IuFJNmx7jmCmFCa2ZeAnvT3Kqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6+X2JCF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso12930135ad.2;
        Fri, 21 Mar 2025 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742574850; x=1743179650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM132i4Ks5WMZt44WDaU0g5VqipyBJD+7DJYgbF06Sg=;
        b=X6+X2JCFGlDqEpY878neDSkYEvp6d0UAj9iCfm8eFH6Bl9dm/diqIf+MfJnVNH/NAN
         ndvgQceufegVz1pFACRwRvhBSvXRUsXaTlG0mwRQEJZQSsER3eow3Q8idx8iTOjASfNs
         maPecKitl2yrdEeXSWHTT9QBdbw5rtCsQI8UigN5Ueq/QelxdUAT83xwx4eWMNM7JwrL
         EDpn6TCmj3LbN74mr1Vjzmf/2hIIwHGJA1eK0MUQhob4dTAIQk4/i8wAZz39wncLm+24
         pBRNQqCEmvSXuUQf+1Q7ixnhiJv35m44XZlFvfHCmTJ+xZq7UUpI/e81/L/pwbs1Hz3r
         Zq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574850; x=1743179650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM132i4Ks5WMZt44WDaU0g5VqipyBJD+7DJYgbF06Sg=;
        b=k7Vtg6ZAPT2iGoSW6a0jJy0BiaIR9ed625Vnwy0T7SkGoT9p1L1bUVZSjUW1l+uTn7
         6Tds+K72eumWNsXPSk5gi5larUEhIBw9TW1br1gvmv9MyiJAppNuh8J8IXeP68P3+/mM
         K4xVcNu0FB/FTwEDuQ/YuQJ7W0tdWpbEhtGognpd0tAd9jzY5GP7zBgWq975MwNuQXxZ
         GG70KHURPOu4hvZSINGMYl3reDrNMOl3URCG/pqKYOhpYtOuTb+1G1Kx70TVj+qiSCK/
         OSoC617GsgBNp2ACnlZ2VNiQM0/RM5m3OqRyH8XLhwnI1IPb3/y/dPhLTUZyQNhFaDBy
         xoOA==
X-Forwarded-Encrypted: i=1; AJvYcCUUOjB4fE+lWc70aP/4yYqEcDQKIDtLhcmdCjfjYR3cM7UyebOMqHzhMQiwisr0F9oFWaA2oKMvnZoc960=@vger.kernel.org, AJvYcCX8yfLXyo5LL4qSFQOVm/dFxbgyFm2uSh+ardugA7XHessfTWesNFdsa++yyiyWo4GwWO/9buc251w8b0nMTDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXPT0u+ytz34uSu0YWIEtE0/7z8ts5Ksjuras/QiaFbXpodf+
	t3ommuNeXdNieRu67Nj/ql8AnbqIWZ6e9DljyKJj4nL5n3yrx9nH
X-Gm-Gg: ASbGncsL4G7kPRk0EcyxZrWTnOnWwHSgmSHy6aGNe8mkYfnT7FzQaemz5h77lxCCbIo
	ME/0cwAKCAFm2ntjtCf//9dyUpojmAzN13iAbS18TBagEfk3rgLzBY1s0K8x5VvUC3/uiTbuobw
	hoUSAbIqUwzt4mtQkuLITk+PSPw8mCPy68vywDlgb2aATayBrGoDCyEw1ydLA3sEzh5437T4gB1
	VvISbmR7lNVlTtYakbcOjOtlVzVE30v+ooR893RQob32OxOZwE+A/NfaOZ4UOQpC1SRFYQFbrvV
	O9UtkUbbjZGpQ+M4J0TiBMP9/BcpQmsfvWxKm1ZNaX8i
X-Google-Smtp-Source: AGHT+IHZvapsjFpePLVoGJ7Nv/p6LD5lXCIZ0qG1SvceU3fUSN6HVSEucpLF2ei1deHHxuv6IjYNVw==
X-Received: by 2002:a17:903:234d:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22780db7783mr54865375ad.28.1742574849582;
        Fri, 21 Mar 2025 09:34:09 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4a541sm19184265ad.77.2025.03.21.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:34:08 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:34:06 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] rust: add dynamic ID pool abstraction for bitmap
Message-ID: <Z92U_odgJztRik2o@thinkpad>
References: <20250321111535.3740332-1-bqe@google.com>
 <20250321111535.3740332-5-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321111535.3740332-5-bqe@google.com>

On Fri, Mar 21, 2025 at 11:15:32AM +0000, Burak Emir wrote:
> This is a port of the Binder data structure introduced in commit
> 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> Rust.
> 
> Like drivers/android/dbitmap.h, the ID pool abstraction lets
> clients acquire and release IDs. The implementation uses a bitmap to
> know what IDs are in use, and gives clients fine-grained control over
> the time of allocation. This fine-grained control is needed in the
> Android Binder. We provide an example that release a spinlock for
> allocation and unit tests (rustdoc examples).
> 
> The implementation is not aware that the underlying Bitmap abstraction
> handles lengths below BITS_PER_LONG without allocation.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>

Before I'll dig into this, can you describe the usecase? Is this just
a dynamic array of bits, or something more unusual? What's your desired
complexity for an acquire_id() - O(n) strictly, or amortized? Are you
going to use it in IRQ or similar restricted contexts?

> ---
>  MAINTAINERS            |   1 +
>  rust/kernel/id_pool.rs | 201 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  3 files changed, 203 insertions(+)
>  create mode 100644 rust/kernel/id_pool.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc8f05431689..61ac5da0dfbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4120,6 +4120,7 @@ M:	Burak Emir <bqe@google.com>
>  R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	rust/kernel/bitmap.rs
> +F:	rust/kernel/id_pool.rs
>  
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> new file mode 100644
> index 000000000000..8f07526bb580
> --- /dev/null
> +++ b/rust/kernel/id_pool.rs
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for an ID pool backed by a `Bitmap`.
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bitmap::Bitmap;
> +
> +/// Represents a dynamic ID pool backed by a `Bitmap`.
> +///
> +/// Clients acquire and release IDs from zero bits in a bitmap.
> +///
> +/// The ID pool can grow or shrink as needed. It has been designed
> +/// to support the scenario where users need to control the time
> +/// of allocation of a new backing bitmap, which may require release
> +/// of locks.
> +/// These operations then, are verified to determine if the grow or
> +/// shrink is sill valid.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
> +/// ```
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
> +/// for i in 0..64 {
> +///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
> +/// }
> +///
> +/// pool.release_id(23);
> +/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> +///
> +/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
> +/// let resizer = pool.grow_alloc().alloc(GFP_KERNEL)?;
> +/// pool.grow(resizer);
> +///
> +/// assert_eq!(pool.acquire_next_id(0), Some(64));
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// Releasing spinlock to grow the pool
> +///
> +/// ```no_run
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::sync::{new_spinlock, SpinLock};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// fn get_id_maybe_alloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
> +///   let mut pool = guarded_pool.lock();
> +///   loop {
> +///     match pool.acquire_next_id(0) {
> +///       Some(index) => return Ok(index),
> +///       None => {
> +///         let alloc_request = pool.grow_alloc();
> +///         drop(pool);
> +///         let resizer = alloc_request.alloc(GFP_KERNEL)?;
> +///         pool = guarded_pool.lock();
> +///         pool.grow(resizer)
> +///       }
> +///     }
> +///   }
> +/// }
> +/// ```
> +pub struct IdPool {
> +    map: Bitmap,
> +}
> +
> +/// Returned when the `IdPool` should change size.
> +pub struct AllocRequest {
> +    nbits: usize,
> +}
> +
> +/// Contains an allocated `Bitmap` for resizing `IdPool`.
> +pub struct PoolResizer {
> +    new: Bitmap,
> +}
> +
> +impl AllocRequest {
> +    /// Allocates a new `Bitmap` for `IdPool`.
> +    pub fn alloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
> +        let new = Bitmap::new(self.nbits, flags)?;
> +        Ok(PoolResizer { new })
> +    }
> +}
> +
> +impl IdPool {
> +    /// Constructs a new `[IdPool]`.
> +    #[inline]
> +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
> +        let map = Bitmap::new(nbits, flags)?;
> +        Ok(Self { map })
> +    }
> +
> +    /// Returns how many IDs this pool can currently have.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        self.map.len()
> +    }
> +
> +    /// Returns an [`AllocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::id_pool::{AllocRequest, IdPool};
> +    ///
> +    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
> +    /// let alloc_request = pool.shrink_alloc().ok_or(AllocError)?;
> +    /// let resizer = alloc_request.alloc(GFP_KERNEL)?;
> +    /// pool.shrink(resizer);
> +    /// assert_eq!(pool.len(), kernel::bindings::BITS_PER_LONG as usize);
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn shrink_alloc(&self) -> Option<AllocRequest> {
> +        let len = self.map.len();
> +        if len <= bindings::BITS_PER_LONG as usize {
> +            return None;
> +        }
> +        /*
> +         * Determine if the bitmap can shrink based on the position of
> +         * its last set bit. If the bit is within the first quarter of
> +         * the bitmap then shrinking is possible. In this case, the
> +         * bitmap should shrink to half its current size.
> +         */
> +        match self.map.last_bit() {
> +            Some(bit) => {
> +                if bit < (len >> 2) {
> +                    Some(AllocRequest { nbits: len >> 1 })
> +                } else {
> +                    None
> +                }
> +            }
> +            None => Some(AllocRequest {
> +                nbits: bindings::BITS_PER_LONG as usize,
> +            }),
> +        }
> +    }
> +
> +    /// Shrinks pool by using a new `Bitmap`, if still possible.
> +    #[inline]
> +    pub fn shrink(&mut self, mut resizer: PoolResizer) {
> +        // Verify that shrinking is still possible. The `resizer`
> +        // bitmap might have been allocated without locks, so this call
> +        // could now be outdated. In this case, drop `resizer` and move on.
> +        if let Some(AllocRequest { nbits }) = self.shrink_alloc() {
> +            if nbits <= resizer.new.len() {
> +                resizer.new.copy_and_extend(&self.map);
> +                self.map = resizer.new;
> +                return;
> +            }
> +        }
> +    }
> +
> +    /// Returns an `AllocRequest` for growing this `IdPool`.
> +    #[inline]
> +    pub fn grow_alloc(&self) -> AllocRequest {
> +        AllocRequest {
> +            nbits: self.map.len() << 1,
> +        }
> +    }
> +
> +    /// Grows pool by using a new `Bitmap`, if still necessary.
> +    #[inline]
> +    pub fn grow(&mut self, mut resizer: PoolResizer) {
> +        // `resizer` bitmap might have been allocated without locks,
> +        // so this call could now be outdated. In this case, drop
> +        // `resizer` and move on.
> +        if resizer.new.len() <= self.map.len() {
> +            return;
> +        }
> +
> +        resizer.new.copy_and_extend(&self.map);
> +        self.map = resizer.new;
> +    }
> +
> +    /// Acquires a new ID by finding and setting the next zero bit in the
> +    /// bitmap. Upon success, returns its index. Otherwise, returns `None`
> +    /// to indicate that a `grow_alloc` is needed.
> +    #[inline]
> +    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
> +        match self.map.next_zero_bit(offset) {
> +            res @ Some(nr) => {
> +                self.map.set_bit(nr);
> +                res
> +            }
> +            None => None,
> +        }
> +    }
> +
> +    /// Releases an ID.
> +    #[inline]
> +    pub fn release_id(&mut self, id: usize) {
> +        self.map.clear_bit(id);
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 9f675c0841e6..d77a27bee388 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -51,6 +51,7 @@
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;
>  pub mod fs;
> +pub mod id_pool;
>  pub mod init;
>  pub mod io;
>  pub mod ioctl;
> -- 
> 2.49.0.395.g12beb8f557-goog

