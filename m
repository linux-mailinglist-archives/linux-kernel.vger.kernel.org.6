Return-Path: <linux-kernel+bounces-444959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD29F0F14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416E8283354
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A661E0DE5;
	Fri, 13 Dec 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP9BQji9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995A1E0DFD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100087; cv=none; b=ToKHNZWb0IMW+oUurLspwRa46Z0JVO46TiDCdTZra2Yh9oy7rE4uiMgtnBQ//rHaq6/au30wACwchL/n5h6VHYT/kuHyg8HwAiCowW/ZNc6zWAunaQUQkBx1mv6cEt9wOvmam86rknRr1XRlrUJV6GdcOmiDpDATVwRwiEhhXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100087; c=relaxed/simple;
	bh=ScH4bkyCInfcqH/0+qEtAbv/AjGhsPAQ1SUF/Cjb9YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1l0sh21x1EAK4DLPbnDB41A7QPkgtBmHmopP02/dFZv85I5UOUVoR4zrq3VlOgzZvZzJtSU4KYir+3Mtzctcfk0Ur83U1LW4NaloreytEzAHvibWiXoubBD744W0nydMhan9KVWAmexZTrHaJda2FUXzG9uOtfMlBRf/EC1N3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MP9BQji9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1206474f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734100083; x=1734704883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/9jU9AnB7Y5dYh4ffQBQ6JeOp1AoI63hdNnuWCSoNA=;
        b=MP9BQji9V4CK3GxlANQ/hB028EiQ0oRkfk2scx21ad4vNGSNW4Z1ii19Kps9kpkPSK
         u4wYc585gI5nqFcQGn1zYiV66Fh8DUSmO5kTFRod6sxsRXcsW0/o1Q2FrBdJP3eC4iYR
         kjXUC/wC8QIxy7PvMZAQPcfVwAt8CG66Mc86VCawZT6FW0UQdZ8BtFgJbzCjxXW4Kz/r
         2WL0iEd6+3aXyyrQptbuVsLH7r6zweIHt7fdBzYQetx/3oQLUM1TUp5pugmkAndHIn0K
         AybvqaG8nG6/hAKbO6dtOkElMRqmafpyp71HaS3XbmsnPqhc084jYxHFhrcLtBdzPocU
         4mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100083; x=1734704883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/9jU9AnB7Y5dYh4ffQBQ6JeOp1AoI63hdNnuWCSoNA=;
        b=ewfUz4fS/XM+LvRe86rk9dSNMyT8hAXfjQa7/i0f0K960rn3jNwYoD/OyQBkFOhqcy
         LOaw3NwdK63K4GOJAxf8XZr71T38BZ2Ff5xsJ4mCEd0X1BykerWKzy6buZS7o6ZB2mz2
         RsnpQhTwazCWN17POJiDuHeCjXwIvuWR6s5L4PUyaGCDgqNKpzPcrU9EdwiKdSIlRl0p
         2jV3VzuRBieCFYnqXF3NPOJBq8dAu9IeYX0QOr3m9IZ0LWfRPTFh48xePCCBcPIceYER
         x2gsVuACLnaxOVUlCbKaossYBk0TXMj7D84R2th58PX80vfWtgDhGhrxuErM5sHkAKil
         OnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw+VKHLV0V5fhNQORL+fM+BplewH5JAuQ08WeP9giP27jOQwEyzlmOLeDJSsqzakH1bEbtulFVQkWVnv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxq7zxsfpzKHoD3ECYB3Tj5wZrGBoI9DaiSTWC6oGSPvuBkK0
	nWipr12DNgekfiVFfmmddFCH8F5R2D4SVdNRrI56RV4t4TrS98sp9/S1UjmMc5uMzmkhADoP4pu
	AI9pNykEMWD+eeMAhwpqoX3E13eC/KksojqK4
X-Gm-Gg: ASbGncv6jkISc9C70ZBpawmIhNvA6CE5hJUmigaBaV0qczvcNTM2g6Cb/IcygjcUJy4
	Sb+UjAwdPZpbAEhnJUGePni6bpjgJa/UPODL1/bA=
X-Google-Smtp-Source: AGHT+IHpuwhh+BOjtWh9TTURUYd+INUTVwzHOO8kzcIpj83VSOLQU675nZWAUPvOOhDAxG33KNAJUML62XldUOxxc5Q=
X-Received: by 2002:a05:6000:785:b0:386:3327:4f21 with SMTP id
 ffacd0b85a97d-388c3a8f4a9mr2131234f8f.27.1734100081554; Fri, 13 Dec 2024
 06:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com> <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 15:27:48 +0100
Message-ID: <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:16=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/dma.rs              | 223 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  3 files changed, 225 insertions(+)
>  create mode 100644 rust/kernel/dma.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 5c4dfe22f41a..49bf713b9bb6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
>  #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
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
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-=
mapping.h)
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
> +        (self & flags) =3D=3D flags
> +    }
> +}
> +
> +impl core::ops::BitOr for Attribs {
> +    type Output =3D Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Attribs {
> +    type Output =3D Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Attribs {
> +    type Output =3D Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// DMA mapping attrributes.
> +pub mod attrs {
> +    use super::Attribs;
> +
> +    /// Specifies that reads and writes to the mapping may be weakly ord=
ered, that is that reads
> +    /// and writes may pass each other.
> +    pub const DMA_ATTR_WEAK_ORDERING: Attribs =3D Attribs(bindings::DMA_=
ATTR_WEAK_ORDERING);
> +
> +    /// Specifies that writes to the mapping may be buffered to improve =
performance.
> +    pub const DMA_ATTR_WRITE_COMBINE: Attribs =3D Attribs(bindings::DMA_=
ATTR_WRITE_COMBINE);
> +
> +    /// Lets the platform to avoid creating a kernel virtual mapping for=
 the allocated buffer.
> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attribs =3D Attribs(bindings::=
DMA_ATTR_NO_KERNEL_MAPPING);
> +
> +    /// Allows platform code to skip synchronization of the CPU cache fo=
r the given buffer assuming
> +    /// that it has been already transferred to 'device' domain.
> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attribs =3D Attribs(bindings::DMA_=
ATTR_SKIP_CPU_SYNC);
> +
> +    /// Forces contiguous allocation of the buffer in physical memory.
> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attribs =3D Attribs(bindings::D=
MA_ATTR_FORCE_CONTIGUOUS);
> +
> +    /// This is a hint to the DMA-mapping subsystem that it's probably n=
ot worth the time to try
> +    /// to allocate memory to in a way that gives better TLB efficiency.
> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attribs =3D Attribs(bindings:=
:DMA_ATTR_ALLOC_SINGLE_PAGES);
> +
> +    /// This tells the DMA-mapping subsystem to suppress allocation fail=
ure reports (similarly to
> +    /// __GFP_NOWARN).
> +    pub const DMA_ATTR_NO_WARN: Attribs =3D Attribs(bindings::DMA_ATTR_N=
O_WARN);
> +
> +    /// Used to indicate that the buffer is fully accessible at an eleva=
ted privilege level (and
> +    /// ideally inaccessible or at least read-only at lesser-privileged =
levels).
> +    pub const DMA_ATTR_PRIVILEGED: Attribs =3D Attribs(bindings::DMA_ATT=
R_PRIVILEGED);
> +}
> +
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which is =
used to allocate and map
> +/// large consistent DMA regions.
> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the allocate=
d region (in the
> +/// processor's virtual address space) and the device address which can =
be given to the device
> +/// as the DMA address base of the region. The region is released once [=
`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the cpu a=
ddress is a valid pointer
> +/// to an allocated region of consistent memory and we hold a reference =
to the device.
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attribs,
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent memor=
y.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> =3D CoherentAllocation::alloc_att=
rs(dev, 4, GFP_KERNEL,
> +    ///                                                                 =
 DMA_ATTR_NO_WARN)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_attrs(
> +        dev: &Device,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attribs,
> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(core::mem::size_of::<T>() > 0,
> +                      "It doesn't make sense for the allocated type to b=
e a ZST");
> +
> +        let size =3D count.checked_mul(core::mem::size_of::<T>()).ok_or(=
EOVERFLOW)?;
> +        let mut dma_handle =3D 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on=
 `Device`.
> +        // We ensure that we catch the failure on this function and thro=
w an ENOMEM
> +        let ret =3D unsafe {
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
> +        // INVARIANT: We just successfully allocated a coherent region w=
hich is accessible for
> +        // `count` elements, hence the cpu address is valid. We also hol=
d a refcounted reference
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
> +    /// Performs the same functionality as `alloc_attrs`, except the `dm=
a_attrs` is 0 by default.
> +    pub fn alloc_coherent(dev: &Device,
> +                          count: usize,
> +                          gfp_flags: kernel::alloc::Flags) -> Result<Coh=
erentAllocation<T>> {
> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attribs(0=
))
> +    }

Please run rustfmt.

> +    /// Returns the base address to the allocated region and the dma han=
dle. The caller takes
> +    /// ownership of the returned resources.
> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
> +        let ret =3D (self.cpu_addr as _, self.dma_handle);
> +        core::mem::forget(self);
> +        ret
> +    }

Not only does this skip the destructor of `dma_free_attrs`. It also
skips the destructor of fields including the `dev` field. Did you
intend to leave the refcount on `struct device` without decrementing
it?

> +    /// Returns the base address to the allocated region in the CPU's vi=
rtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr as _

This conversion happens without needing a cast.

> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's vi=
rtual address space as
> +    /// a mutable pointer.
> +    pub fn start_ptr_mut(&mut self) -> *mut T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may given to the device as the DMA ad=
dress base of
> +    /// the region.
> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +        self.dma_handle
> +    }
> +
> +    /// Returns the CPU-addressable region as a slice.
> +    pub fn cpu_buf(&self) -> &[T]
> +    {
> +        // SAFETY: The pointer is valid due to type invariant on `Cohere=
ntAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) =
}

Immutable slices require that the data does not change while the
reference is live. Is that the case? If so, your safety comment should
explain that.

> +    }
> +
> +    /// Performs the same functionality as `cpu_buf`, except that a muta=
ble slice is returned.
> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
> +    {
> +        // SAFETY: The pointer is valid due to type invariant on `Cohere=
ntAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.cou=
nt) }

Mutable slices require that the data is not written to *or read* by
anybody else while the reference is live. Is that the case? If so,
your safety comment should explain that.

> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +        // SAFETY: the device, cpu address, and the dma handle is valid =
due to the
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
>  mod build_assert;
>  pub mod cred;
>  pub mod device;
> +pub mod dma;
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;
> --
> 2.43.0
>

