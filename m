Return-Path: <linux-kernel+bounces-387050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E259B4B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876DEB22079
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F86206949;
	Tue, 29 Oct 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qhcjg3/a"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9429CF4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209632; cv=none; b=G0swmBX4xzTZHJVWVLnDxiVvxtrxdeAnjP90ezYyP/YpJPXDqDf2FUDaKho3pR0V/Z56tziVNpC3CurFMJFMnpLoJI4FYhjmYTa74aoVJEuqNXh31iXq5UMiPUEVKxN71sGiu7ZQ29EFwFQd7dJ8nSbT53LNLwKbVUly+8GX3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209632; c=relaxed/simple;
	bh=cq27wZz7dVLJMOmm0mkBoV4a/SvFeK1Ra68XlDGi/tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0jPZuaie1nxxrWmiQgQWkQznxMF9TPDzniW18dcRKg9dwbxX53tPmFpDqyk2vfPW+WIxn+zCX/lgzR8AfP050tWXA9xDEtm+S3m7AAFQWD3g7mXchTcrCSopsbBwn+2o+6h9AUgYFia5pbv3YtT3jjfBuoOMn3OVh4olf9KalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qhcjg3/a; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so6226982e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730209628; x=1730814428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LArg21E2WXO5e66MBAzgbobynxnG6RwUCWHJ6JjyJPU=;
        b=Qhcjg3/aDoweAWAyVByWPgYgyRut5tEtZmbwL/1P2M76JLq5sYQOnIvhBwLtzlfQM3
         PZODjYtiNtOTgD1GK3eyHRxOYlI1sXWeVZeIDkJkTiYmmLcMXHbMPtL+q6lC8voQZ+6u
         gEu2wVemehCgZdgiRsZHjAL5U5OMBfVKs1gzLicpta7+DVW/5ik9pKnbJpjOkrO0X4kD
         u43R5t6zhZzpPTzNK9TTNE0G9fRznDXqdFJuLtjlRs1f1poF4AxRBipzIC8j/wBWkUBk
         cLTCSQvVwmGJXeLPtL3k2AIAK1HIpLtvl7RJ15fVqR6KNQ7HOnhY7aIVwroTX4UenIqM
         I/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209628; x=1730814428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LArg21E2WXO5e66MBAzgbobynxnG6RwUCWHJ6JjyJPU=;
        b=QJVnncd24hqZsPpiQrrYwqxNlMetqDacvd08Wx/4XLAmJ34lxKDEcA6zlYlM5oOHVn
         uM6flfBrf5c44DnfpSK7xThpNDpRCendFh4rwUtdv3db+5/etKpB04yDFpuhoOC4FO0q
         odvq2Fs8XED07g0qEt17fHAT5BSeGGzw3AkUQ2f+RS7Qz/YdwLLCaZDegHXD/0vgfFrc
         6y//wjqW9sOZIY0DdYJFBU3uJsaXwVirwCN6IPRmoYnfacKju0ORfC1kWrAvcsSUhrbG
         nxrhJg2BKI4OqEupityGokbqLnE7Xr3p9E4MuNGg0xzMRe9At1lBGHY7TqU1Ur9vc+dq
         i7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJcXWboN/Vu01GHF4NkT811rtT4hotsdQf16FBpapW4uGXJA66xpubfpZ3SjD5XEMYb93A/UoMbtpNKYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxju7PfEQuS+QT7T6JDGcbO2UlxGB/YMFIbnfMbptSZ6cESotJW
	FhFyExvL/GopSvYJQtAMIxqbzOsKR9XWAc0Y8agQ/WuvrHqk6hDow3sGpoft/mcYuwtsOzu8DhE
	n6FBdQpRsqfDicXJ31UlLXlVoO4TCvy2L2fPl
X-Google-Smtp-Source: AGHT+IHItb9FX0fWN2MM4pYj544OpUsB66WeSfDGuaODqOudecBLf5ATg6AZ/ngQWd3qN6yPQtudPVotEpB8Jmx0lps=
X-Received: by 2002:a05:6512:3d22:b0:539:f6c4:c29d with SMTP id
 2adb3069b0e04-53b34b39798mr5839187e87.54.1730209627512; Tue, 29 Oct 2024
 06:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
 <CAH5fLgjdDm3nNvR8g-a6Z8UsSnEDygLJ8i3u63aCrpG5ambQ3A@mail.gmail.com> <BC47085B-4160-4D9B-89F4-06EDE706CD5A@collabora.com>
In-Reply-To: <BC47085B-4160-4D9B-89F4-06EDE706CD5A@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 14:46:55 +0100
Message-ID: <CAH5fLghv3cBGO0HEH-5GXiDZZWyKSJYxQu8s0fi8D=eneS-OXw@mail.gmail.com>
Subject: Re: [PATCH] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:23=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Alice,
>
> > On 28 Oct 2024, at 12:37, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> The IoMem is backed by ioremap_resource()
> >>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> ---
> >> The PCI/Platform abstractions are in-flight and can be found at:
> >>
> >> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
> >> ---
> >> rust/bindings/bindings_helper.h |  1 +
> >> rust/helpers/io.c               | 11 ++++++
> >> rust/kernel/platform.rs         | 88 +++++++++++++++++++++++++++++++++=
++++++++
> >> 3 files changed, 100 insertions(+)
> >>
> >> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_=
helper.h
> >> index 217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b=
4cc7f8232fef5eed17 100644
> >> --- a/rust/bindings/bindings_helper.h
> >> +++ b/rust/bindings/bindings_helper.h
> >> @@ -13,6 +13,7 @@
> >> #include <linux/errname.h>
> >> #include <linux/ethtool.h>
> >> #include <linux/firmware.h>
> >> +#include <linux/ioport.h>
> >> #include <linux/jiffies.h>
> >> #include <linux/mdio.h>
> >> #include <linux/of_device.h>
> >> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
> >> index f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29=
ef22ebaa2bf51d82a9 100644
> >> --- a/rust/helpers/io.c
> >> +++ b/rust/helpers/io.c
> >> @@ -1,6 +1,7 @@
> >> // SPDX-License-Identifier: GPL-2.0
> >>
> >> #include <linux/io.h>
> >> +#include <linux/ioport.h>
> >>
> >> u8 rust_helper_readb(const volatile void __iomem *addr)
> >> {
> >> @@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, volatile=
 void __iomem *addr)
> >>        writeq_relaxed(value, addr);
> >> }
> >> #endif
> >> +
> >> +resource_size_t rust_helper_resource_size(struct resource *res)
> >> +{
> >> +       return resource_size(res);
> >> +}
> >> +
> >> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned long=
 size)
> >> +{
> >> +       return ioremap(addr, size);
> >> +}
> >> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> >> index addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30dd=
aebe8d87a9679bfa97 100644
> >> --- a/rust/kernel/platform.rs
> >> +++ b/rust/kernel/platform.rs
> >> @@ -4,11 +4,15 @@
> >> //!
> >> //! C header: [`include/linux/platform_device.h`](srctree/include/linu=
x/platform_device.h)
> >>
> >> +use core::ops::Deref;
> >> +
> >> use crate::{
> >>     bindings, container_of, device,
> >>     device_id::RawDeviceId,
> >> +    devres::Devres,
> >>     driver,
> >>     error::{to_result, Result},
> >> +    io::Io,
> >>     of,
> >>     prelude::*,
> >>     str::CStr,
> >> @@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut bindings::platform_devic=
e {
> >>         // embedded in `struct platform_device`.
> >>         unsafe { container_of!(self.0.as_raw(), bindings::platform_dev=
ice, dev) }.cast_mut()
> >>     }
> >> +
> >> +    /// Maps a platform resource through ioremap() where the size is =
known at
> >> +    /// compile time.
> >> +    pub fn ioremap_resource_sized<const SIZE: usize>(
> >> +        &self,
> >> +        resource: u32,
> >> +    ) -> Result<Devres<IoMem<SIZE>>> {
> >> +        let res =3D self.resource(resource)?;
> >> +        let size =3D self.resource_len(resource)? as usize;
> >
> > You're calling platform_get_resource twice here? Can you be sure that
> > it returns the same pointer each time?
>
> This comes from the DT. Yes, it will be the same pointer (so long as we
> pass the same index).
>
> Although, I did not see where it is being called twice?

The `resource_len` function calls `resource`, so you call `resource`
twice. Each call to `resource` results in a call to
`platform_get_resource`.

> >> +        // SAFETY: `res` is guaranteed to be a valid MMIO address and=
 the size
> >> +        // is given by the kernel as per `self.resource_len()`.
> >> +        let io =3D unsafe { IoMem::new(res as _, size) }?;
> >
> > Why do we know that `res` is a valid MMIO address? Is it because
> > platform_get_resource always does so?
>
> Again, if there=E2=80=99s a problem, the DT itself should be fixed. Also =
the C code would be broken too.

Sorry if I was unclear. I just wanted you to elaborate in the safety commen=
t :)

> >> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;
> >> +
> >> +        Ok(devres)
> >> +    }
> >> +
> >> +    /// Maps a platform resource through ioremap().
> >> +    pub fn ioremap_resource(&self, resource: u32) -> Result<Devres<Io=
Mem>> {
> >> +        self.ioremap_resource_sized::<0>(resource)
> >> +    }
> >
> > I guess size zero is special?
> >
>
> `ioremap_resource_sized` is used when you know the size at compile time. =
Setting SIZE =3D=3D 0
> means that you get runtime checks on whether your reads and writes are wi=
thin bounds,
> because you will have to use try_read() and try_write() instead of read()=
 and write() or your build
> will fail.
>
> This is not related to this patch in particular, but to a preceding one t=
hat introduces struct Io.
>
> We merely expose the same API from Io to users here.
>
> Although I do agree it=E2=80=99s a bit confusing that SIZE 0 is special-c=
ased. It took me a while and
> several read-throughs to understand what was going on.
>
> Note that it=E2=80=99s common to have to read the size from the DT, so de=
ferring to runtime checks
> seems to be unavoidable in a lot of cases if we want to have a safe API.
>
> Here=E2=80=99s the relevant code from that commit:
>
> ```
> +macro_rules! define_write {
> + ($(#[$attr:meta])* $name:ident, $try_name:ident, $type_name:ty) =3D> {
> + /// Write IO data from a given offset known at compile time.
> + ///
> + /// Bound checks are performed on compile time, hence if the offset is =
not known at compile
> + /// time, the build will fail.
> + $(#[$attr])*
> + #[inline]
> + pub fn $name(&self, value: $type_name, offset: usize) {
> +       let addr =3D self.io_addr_assert::<$type_name>(offset);
> +
> +       // SAFETY: By the type invariant `addr` is a valid address for MM=
IO operations.
> +        unsafe { bindings::$name(value, addr as _, ) }
> + }
> +
> + /// Write IO data from a given offset.
> + ///
> + /// Bound checks are performed on runtime, it fails if the offset (plus=
 the type size) is
> + /// out of bounds.
> + $(#[$attr])*
> + pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
> +       let addr =3D self.io_addr::<$type_name>(offset)?;
> +
> +       // SAFETY: By the type invariant `addr` is a valid address for MM=
IO operations.
> +       unsafe { bindings::$name(value, addr as _) }
> +       Ok(())
> + }
> ```
>
> Where,
>
> ```
> + #[inline]
> + fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> +       if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +               return Err(EINVAL);
> + }
> +
> + // Probably no need to check, since the safety requirements of `Self::n=
ew` guarantee that
> + // this can't overflow.
> + self.base_addr().checked_add(offset).ok_or(EINVAL)
> + }
> + #[inline]
> + fn io_addr_assert<U>(&self, offset: usize) -> usize {
> +       build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +
> +       self.base_addr() + offset
> + }
> ```
>
> And
>
> ```
> + #[inline]
> + const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +       let type_size =3D core::mem::size_of::<U>();
> +       if let Some(end) =3D offset.checked_add(type_size) {
> +               end <=3D size && offset % type_size =3D=3D 0
> +       } else {
> +               false
> +       }
> + }
> ```

Acknowledged.

> >> +    /// Returns the resource len for `resource`, if it exists.
> >> +    pub fn resource_len(&self, resource: u32) -> Result<bindings::res=
ource_size_t> {
> >
> > Should this just return usize? Should we have a type alias for this siz=
e type?
>
>
> I guess usize would indeed be a better fit, if we consider the code below=
:
>
> ```
> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> typedef u64 phys_addr_t;
> #else
> typedef u32 phys_addr_t;
> #endif
>
> typedef phys_addr_t resource_size_t;

Hmm. I guess they probably do that because phys_addr_t could differ
from size_t? Sounds like we may want a typedef called phys_addr_t
somewhere on the Rust side?

> >> +        match self.resource(resource) {
> >> +            // SAFETY: if a struct resource* is returned by the kerne=
l, it is valid.
> >> +            Ok(resource) =3D> Ok(unsafe { bindings::resource_size(res=
ource) }),
> >> +            Err(e) =3D> Err(e),
> >> +        }
> >> +    }
> >> +
> >> +    fn resource(&self, resource: u32) -> Result<*mut bindings::resour=
ce> {
> >> +        // SAFETY: By the type invariants, we know that `self.ptr` is=
 non-null and valid.
> >> +        let resource =3D unsafe {
> >> +            bindings::platform_get_resource(self.as_raw(), bindings::=
IORESOURCE_MEM, resource)
> >> +        };
> >> +        if !resource.is_null() {
> >> +            Ok(resource)
> >> +        } else {
> >> +            Err(EINVAL)
> >> +        }
> >> +    }
> >> }
> >>
> >> impl AsRef<device::Device> for Device {
> >> @@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
> >>         &self.0
> >>     }
> >> }
> >> +
> >> +/// A I/O-mapped memory region for platform devices.
> >> +///
> >> +/// See also [`kernel::pci::Bar`].
> >> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
> >> +
> >> +impl<const SIZE: usize> IoMem<SIZE> {
> >> +    /// Creates a new `IoMem` instance.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// The caller must make sure that `paddr` is a valid MMIO addres=
s.
> >> +    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {
> >
> > What happens if `size !=3D SIZE`?
>
>
> ```
> +impl<const SIZE: usize> Io<SIZE> {
> + ///
> + ///
> + /// # Safety
> + ///
> + /// Callers must ensure that `addr` is the start of a valid I/O mapped =
memory region of size
> + /// `maxsize`.
> + pub unsafe fn new(addr: usize, maxsize: usize) -> Result<Self> {
> +       if maxsize < SIZE {
> +               return Err(EINVAL);
> +        }
> ```
>
> As we=E2=80=99ve seen in the other code snippets I pasted, it=E2=80=99s S=
IZE that is used in the try_read and
> try_write checks.

Ok.

Alice

