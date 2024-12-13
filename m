Return-Path: <linux-kernel+bounces-444444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112C9F06FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA116A056
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C491A0AF7;
	Fri, 13 Dec 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiYNgE9X"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1D1AB6FF;
	Fri, 13 Dec 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080017; cv=none; b=m1J3NtbOt7qwLdqFlMEFdzK2RYLoxdgR3/g+EmFd6zgu2wqefwtwZuBOr+2TJ3n/XzhLsbdKJEFvZ7FpSKvHo/yKkTJYn4t10e0a0QBAdbv7m+ejvMEFvv+zFtGsvkvy2GnCq9g290CPgwHXAwytPQxgn/fkU9v0enMjxtXInOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080017; c=relaxed/simple;
	bh=8LOKMXTGfojs0kpZhd8FW+s1DH5SqC1qYL9gaBIWQ8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlsehqZhKLjNDSeYfxs2S0ADcSitAhLPybPVzRY09bsieje7XkKiDnZnytY8ZZ/MW/2vFPFV4xuQAsqoqWrDTBgvDZvZcAhJqkflOjv930NILBfYy6alj9SUcDVcL/S16+cjNvOp6mXSsoXsA01PkuqHtgJEOxaSKuf3oixn74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiYNgE9X; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c52000fso1480251e87.2;
        Fri, 13 Dec 2024 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734080014; x=1734684814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wO+IqWaAE/QQthJs4hKylnhkuEpahrZWHhBprwS5+qI=;
        b=DiYNgE9Xb73lOftmuhsdwQg3+eg9vxzz9TSYhKF4E+c0l/IZzQ353Jts8SlDvaOikj
         2KFUFrXtUkJGNdm8H064xTqJHmaC5s9t2+EguJo/tYhBuMmT1XHfwIyDeAizlrdUFb8z
         uG5QX30geLOi/SydQWHgSW6+6nwxeTQdRY/26mjAamkSbCUBOtQo8HilE5eFRZ1FA2N0
         V/h0qVFs44uy9XmKa6EVg2kKGXUQuIi/4vK2YZEaT3pJilwpCQq2GG87O6bGpoQCg2RA
         7bGaZAH/uCzC5E0ffuqyk1Np0GDCRpm5+AhP/j8UKq56IS4Qa/pC+zmcHCNAXmmyb4xV
         sUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734080014; x=1734684814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wO+IqWaAE/QQthJs4hKylnhkuEpahrZWHhBprwS5+qI=;
        b=Dx4puHcdQaO2mQo70XpcunmsEJV4KqnQuP3YQE7RKO+DngZbjB5yCNypCa/5tJpjJD
         GoC3HDJk3VFYiM1PHL4pbTC2btrBZx8javZ9rJaG0LBV2VrLK4AWG+zWDCdCsYInpClc
         kjNBPZh7G6wFFD9cQRt8SQH9PiGiWBdWZa0JyUofaSInshbGnhZ96Y3MO6MLeZQFVL85
         OZuivWk5diWPtjOVwv0BWV+feQM0pxm0QwH1BJA1Iu3crqXQDvKd0qsxrdWNYlei9xxx
         7VpmIo8UxXLBePXC/gaG2vLX32kRQHDAw1vjyR9ETrp19E1J4RsaPN6DjuzjozLzQVMA
         rQDw==
X-Forwarded-Encrypted: i=1; AJvYcCUuQypnCWV0gXr9EjzP5nnPdX3KdLMaNgMfEaTBN8Xo0PvenKe+iJvw8aCPyjplwajw/PL50t6YEgdHHWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOSDQpXpKmXMqF157NLSWAPoSf9sK+Pq/X6aukne3fnZGpV62
	N1dBs0XLhNa7Zwk8Qg/NB9m5JB22dhbsDsC5rQnAr5ri/nyWVLkxQ0evGQ==
X-Gm-Gg: ASbGncvXl9Y33A8znPRpzVznoPanSMRmBt+pzJDSR1l2510dm7J7cox9wlqc0cAnaMD
	8NzlU84VB1CwXHdDEyJ4xfY6mue9JfP08DxxdIg9CF916G4wEDHk+L52XvWNwjugK06s8ofweID
	IrnMVDiilVEbvggoeWIc8S8uwhogonPsJE6X/AwFrvPx+bnFP2T1Jv8wA6s8Ju56lVksTI4fRSp
	EO+TX8F897jp1MgFcQi9LagLKRxEPeHT48ByAw4sSCBJaMULiXP5BI2K5XfXc3PL6N54SomJ4qm
	g6+aaFMDU3k0zHKIkdT2lFiKfL4=
X-Google-Smtp-Source: AGHT+IHVuG9Jrb6uGHGXN5ZUs8Bvsew+npxqQM7foiXUZEFOxvSQYmQKNUPmZg5If2Gealc+H/bnbQ==
X-Received: by 2002:a05:6512:3e17:b0:53e:362e:ed6 with SMTP id 2adb3069b0e04-54099b69b54mr446247e87.50.1734080013417;
        Fri, 13 Dec 2024 00:53:33 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54019d12d08sm1848431e87.59.2024.12.13.00.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 00:53:31 -0800 (PST)
Message-ID: <7c8e84e7-a212-445f-bc4e-ef65dae7fb29@gmail.com>
Date: Fri, 13 Dec 2024 10:53:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: rust-for-linux@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping. Does this approach make sense? :)

On 11/12/2024 00:14, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/kernel/dma.rs              | 223 ++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs              |   1 +
>   3 files changed, 225 insertions(+)
>   create mode 100644 rust/kernel/dma.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 5c4dfe22f41a..49bf713b9bb6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>   #include <linux/blk_types.h>
>   #include <linux/blkdev.h>
>   #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
>   #include <linux/file.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..29ae744d6f2b
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
> +
> +use crate::{
> +    bindings,
> +    build_assert,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    types::ARef,
> +    transmute::{AsBytes, FromBytes},
> +};
> +
> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`attrs`] module.
> +#[derive(Clone, Copy, PartialEq)]
> +pub struct Attribs(u32);
> +
> +impl Attribs {
> +    /// Get the raw representation of this attribute.
> +    pub(crate) fn as_raw(self) -> u64 {
> +        self.0.into()
> +    }
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Attribs) -> bool {
> +        (self & flags) == flags
> +    }
> +}
> +
> +impl core::ops::BitOr for Attribs {
> +    type Output = Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Attribs {
> +    type Output = Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Attribs {
> +    type Output = Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// DMA mapping attrributes.
> +pub mod attrs {
> +    use super::Attribs;
> +
> +    /// Specifies that reads and writes to the mapping may be weakly ordered, that is that reads
> +    /// and writes may pass each other.
> +    pub const DMA_ATTR_WEAK_ORDERING: Attribs = Attribs(bindings::DMA_ATTR_WEAK_ORDERING);
> +
> +    /// Specifies that writes to the mapping may be buffered to improve performance.
> +    pub const DMA_ATTR_WRITE_COMBINE: Attribs = Attribs(bindings::DMA_ATTR_WRITE_COMBINE);
> +
> +    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attribs = Attribs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
> +
> +    /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
> +    /// that it has been already transferred to 'device' domain.
> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attribs = Attribs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
> +
> +    /// Forces contiguous allocation of the buffer in physical memory.
> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attribs = Attribs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
> +
> +    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
> +    /// to allocate memory to in a way that gives better TLB efficiency.
> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attribs = Attribs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
> +
> +    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
> +    /// __GFP_NOWARN).
> +    pub const DMA_ATTR_NO_WARN: Attribs = Attribs(bindings::DMA_ATTR_NO_WARN);
> +
> +    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
> +    /// ideally inaccessible or at least read-only at lesser-privileged levels).
> +    pub const DMA_ATTR_PRIVILEGED: Attribs = Attribs(bindings::DMA_ATTR_PRIVILEGED);
> +}
> +
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
> +/// large consistent DMA regions.
> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
> +/// processor's virtual address space) and the device address which can be given to the device
> +/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the cpu address is a valid pointer
> +/// to an allocated region of consistent memory and we hold a reference to the device.
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attribs,
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent memory.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL,
> +    ///                                                                  DMA_ATTR_NO_WARN)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_attrs(
> +        dev: &Device,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attribs,
> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(core::mem::size_of::<T>() > 0,
> +                      "It doesn't make sense for the allocated type to be a ZST");
> +
> +        let size = count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
> +        let mut dma_handle = 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +        // We ensure that we catch the failure on this function and throw an ENOMEM
> +        let ret = unsafe {
> +            bindings::dma_alloc_attrs(
> +                dev.as_raw(),
> +                size,
> +                &mut dma_handle, gfp_flags.as_raw(),
> +                dma_attrs.as_raw(),
> +            )
> +        };
> +        if ret.is_null() {
> +            return Err(ENOMEM)
> +        }
> +        // INVARIANT: We just successfully allocated a coherent region which is accessible for
> +        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
> +        // to the device.
> +        Ok(Self {
> +            dev: dev.into(),
> +            dma_handle,
> +            count,
> +            cpu_addr: ret as *mut T,
> +            dma_attrs,
> +        })
> +    }
> +
> +    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
> +    pub fn alloc_coherent(dev: &Device,
> +                          count: usize,
> +                          gfp_flags: kernel::alloc::Flags) -> Result<CoherentAllocation<T>> {
> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attribs(0))
> +    }
> +
> +    /// Returns the base address to the allocated region and the dma handle. The caller takes
> +    /// ownership of the returned resources.
> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
> +        let ret = (self.cpu_addr as _, self.dma_handle);
> +        core::mem::forget(self);
> +        ret
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's virtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr as _
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's virtual address space as
> +    /// a mutable pointer.
> +    pub fn start_ptr_mut(&mut self) -> *mut T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may given to the device as the DMA address base of
> +    /// the region.
> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +        self.dma_handle
> +    }
> +
> +    /// Returns the CPU-addressable region as a slice.
> +    pub fn cpu_buf(&self) -> &[T]
> +    {
> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
> +    }
> +
> +    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
> +    {
> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size = self.count * core::mem::size_of::<T>();
> +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
> +        // type invariants on `CoherentAllocation`.
> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
> +                                          self.cpu_addr as _,
> +                                          self.dma_handle,
> +                                          self.dma_attrs.as_raw(),) }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e1065a7551a3..6e90ebf5a130 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -35,6 +35,7 @@
>   mod build_assert;
>   pub mod cred;
>   pub mod device;
> +pub mod dma;
>   pub mod error;
>   #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>   pub mod firmware;


