Return-Path: <linux-kernel+bounces-516914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FCCA379A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0236316B52C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC12136337;
	Mon, 17 Feb 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VINPNNsd"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7623BB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739758649; cv=none; b=QnZunPoFSdV/y1KWZKGYrUax1/gwGc+xAt6Q85hmFOE3fMoE5MRzoPs88cB4Ug+QVdSx247hNxPnYLGwySFhIENwOhbOXL017hkD2irRdSrnc8KFLiNeP0EZPFb//UjmskP+ZPB1VdeIagng/aK8VgxN+XDhrAFwQRh0zBdKsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739758649; c=relaxed/simple;
	bh=fcS+Mgpg+oMbNy7iqMYaVnBrGOridb/VFkpjgvpSpSs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD5jcvtu7WU4ixBY62C1DxwoqVoZ88/bXf0dWeIWlAmR/6qYub3y+zdSdhvGEZ4O9gikZTPmlLLM1JLcXgbVL/c7jOmPpQi8Kge7Y2O5Vdw3XxnAil+NbmZc5X2nt0uZSmSMjHo54oZvxfsxXZKUunTM34+EmA33kGoqwCLmndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VINPNNsd; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739758641; x=1740017841;
	bh=utaOgUkLbXBuqW3vs0AA1GuT20FAYEqATd7DI9YGjcM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VINPNNsdSTL+poe5JwNjgoQXyhSw3giJ3ywLM2hRMl1v9C/+At2NhJg7R+RyUiolo
	 MhyBuApPGQqSf6IDgiYyzV5KbWN9lwEnh+gRMtMMQ9l7KETq3a4ZJSAYNbhL7H89uV
	 cG6HzUvBmth9WNNIIRyeCDXPbcge6Km/AcBtqy+8+b23RZkXQus07WO1KVkaJ8mdvy
	 U5VPOGRrqv2XvN6LS16l3pqcJjkT6rHiIcscBgvGzCgyLNjscvK4/GgGs4Wd5wLe8r
	 JA9rRRSIPSaRjEv+kIfmYTMWTqJi/ll0O8KMT8+iiWuTpbGyQwsKY3Wi88KWOPtItK
	 kx3kzJgJ7TO9w==
Date: Mon, 17 Feb 2025 02:17:16 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, Charalampos Mitrodimas <charmitro@posteo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
Message-ID: <dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
In-Reply-To: <20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org> <20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a8aab86dfbf8209180fd47da4e0174a8e02d9ff5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.02.25 15:41, Andreas Hindborg wrote:
> This patch adds a rust API for configfs, thus allowing rust modules to us=
e
> configfs for configuration. The implementation is a shim on top of the C
> configfs implementation allowing safe use of the C infrastructure from
> rust.
>=20
> The patch enables the `const_mut_refs` feature on compilers before rustc
> 1.83. The feature was stabilized in rustc 1.83 and is not required to be
> explicitly enabled on later versions.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>=20
> ---
>=20
> This patch is a direct dependency for `rnull`, the rust null block driver=
.
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/mutex.c            |   5 +
>  rust/kernel/configfs.rs         | 860 ++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/lib.rs              |   2 +
>  samples/rust/Kconfig            |  11 +
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_configfs.rs   | 186 +++++++++

Can you move the sample into its own patch?

>  7 files changed, 1066 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 55354e4dec14e..d115a770306f6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> +#include <linux/configfs.h>
>  #include <linux/cred.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> index 06575553eda5c..3e9b910a88e9b 100644
> --- a/rust/helpers/mutex.c
> +++ b/rust/helpers/mutex.c
> @@ -17,3 +17,8 @@ void rust_helper_mutex_assert_is_held(struct mutex *mut=
ex)
>  {
>  =09lockdep_assert_held(mutex);
>  }
> +
> +void rust_helper_mutex_destroy(struct mutex *lock)
> +{
> +=09mutex_destroy(lock);
> +}
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> new file mode 100644
> index 0000000000000..9d4b381b9df89
> --- /dev/null
> +++ b/rust/kernel/configfs.rs
> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! `configfs` interface.
> +//!
> +//! `configfs` is an in-memory pseudo file system for configuration of k=
ernel
> +//! modules. Please see the [C documentation] for details and intended u=
se of
> +//! `configfs`.
> +//!
> +//! This module does not support the following `configfs` features:
> +//!
> +//! - Items. All group children are groups.
> +//! - Symlink support.
> +//! - `disconnect_notify` hook.
> +//! - Default groups.

For lists like this, I usually end items except the last one with a
comma instead of a period.

> +//!
> +//! See the [rust_configfs.rs] sample for a full example use of this mod=
ule.

It could also be useful to just put the example directly here into the
docs instead of/additionally to having it as a sample.

> +//!
> +//! C header: [`include/linux/configfs.h`](srctree/include/linux/configf=
s.h)
> +//!
> +//! [C documentation]: srctree/Documentation/filesystems/configfs.rst
> +//! [rust_configfs.rs]: srctree/samples/rust/rust_configfs.rs
> +
> +use crate::alloc::flags;
> +use crate::container_of;
> +use crate::page::PAGE_SIZE;
> +use crate::prelude::*;
> +use crate::str::CString;
> +use crate::sync::Arc;
> +use crate::types::ForeignOwnable;
> +use crate::types::Opaque;
> +use core::cell::UnsafeCell;
> +use core::marker::PhantomData;
> +use core::ptr::addr_of;
> +use core::ptr::addr_of_mut;

I usually would import this like so:

    use crate::{
        alloc::flags,
        container_of,
        page::PAGE_SIZE,
        prelude::*,
        str::CString,
        sync::Arc,
        types::{ForeignOwnable, Opaque},
    };
    use core::{
        cell::UnsafeCell,
        marker::PhantomData,
        ptr::{addr_of, addr_of_mut},
    };

To me this is more readable.

> +
> +/// A `configfs` subsystem.
> +///
> +/// This is the top level entrypoint for a `configfs` hierarchy. To regi=
ster
> +/// with configfs, embed a field of this type into your kernel module st=
ruct.
> +#[pin_data(PinnedDrop)]
> +pub struct Subsystem<Data> {

Usually, we don't have multi-character generics, any specific reason
that you chose `Data` here over `T` or `D`?

> +    #[pin]
> +    subsystem: Opaque<bindings::configfs_subsystem>,
> +    #[pin]
> +    data: Data,
> +}
> +
> +// SAFETY: We do not provide any operations on `Subsystem`.
> +unsafe impl<Data> Sync for Subsystem<Data> {}
> +
> +// SAFETY: Ownership of `Subsystem` can safely be transferred to other t=
hreads.
> +unsafe impl<Data> Send for Subsystem<Data> {}
> +
> +impl<Data> Subsystem<Data> {
> +    /// Create an initializer for a [`Subsystem`].
> +    ///
> +    /// The subsystem will appear in configfs as a directory name given =
by
> +    /// `name`. The attributes available in directory are specified by
> +    /// `item_type`.
> +    pub fn new(
> +        name: &'static CStr,
> +        item_type: &'static ItemType<Subsystem<Data>, Data>,
> +        data: impl PinInit<Data, Error>,
> +    ) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            subsystem <- kernel::init::zeroed().chain(
> +                |place: &mut Opaque<bindings::configfs_subsystem>| {
> +                    // SAFETY: All of `place` is valid for write.
> +                    unsafe {
> +                        addr_of_mut!((*place.get()).su_group.cg_item.ci_=
name )
> +                            .write(name.as_ptr().cast_mut().cast())
> +                    };
> +                    // SAFETY: All of `place` is valid for write.
> +                    unsafe {
> +                        addr_of_mut!((*place.get()).su_group.cg_item.ci_=
type)
> +                            .write(item_type.as_ptr())
> +                    };
> +                    // SAFETY: We initialized the required fields of `pl=
ace.group` above.
> +                    unsafe { bindings::config_group_init(&mut (*place.ge=
t()).su_group) };
> +                    // SAFETY: `place.su_mutex` is valid for use as a mu=
tex.
> +                    unsafe { bindings::__mutex_init(
> +                        &mut (*place.get()).su_mutex,
> +                        kernel::optional_name!().as_char_ptr(),
> +                        kernel::static_lock_class!().as_ptr())

Formatting for this code is weird.

(since this is inside of the `try_pin_init!` macro, rustfmt doesn't
format it, since `<-` isn't part of rust syntax, so it doesn't know what
to do. I usually fix this by replacing all `<-` with `:`, format and
then change things back)

Also, is there no function in C that does all of this initialization for
you?

> +                    }
> +                    Ok(())
> +                }),
> +            data <- data,
> +        })
> +        .pin_chain(|this| {
> +            crate::error::to_result(
> +                // SAFETY: We initialized `this.subsystem` according to =
C API contract above.
> +                unsafe { bindings::configfs_register_subsystem(this.subs=
ystem.get()) },
> +            )
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<Data> PinnedDrop for Subsystem<Data> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: We registered `self.subsystem` in the initializer ret=
urned by `Self::new`.
> +        unsafe { bindings::configfs_unregister_subsystem(self.subsystem.=
get()) };
> +        // SAFETY: We initialized the mutex in `Subsystem::new`.
> +        unsafe { bindings::mutex_destroy(addr_of_mut!((*self.subsystem.g=
et()).su_mutex)) };
> +    }
> +}
> +
> +/// Trait that allows offset calculations for structs that embed a
> +/// `bindings::config_group`.
> +///
> +/// Users of the `configfs` API should not need to implement this trait.
> +///
> +/// # Safety
> +///
> +/// - Implementers of this trait must embed a `bindings::config_group`.
> +/// - Methods must be implemented according to method documentation.
> +pub unsafe trait HasGroup<Data> {
> +    /// Return the address of the `bindings::config_group` embedded in `=
Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `this` must be a valid allocation of at least the size of `Sel=
f`.
> +    unsafe fn group(this: *const Self) -> *const bindings::config_group;
> +
> +    /// Return the address of the `Self` that `group` is embedded in.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `group` must point to the `bindings::config_group` that is emb=
edded in
> +    ///   `Self`.
> +    unsafe fn container_of(group: *const bindings::config_group) -> *con=
st Self;
> +}
> +
> +// SAFETY: `Subsystem<Data>` embeds a field of type `bindings::config_gr=
oup`
> +// within the `subsystem` field.
> +unsafe impl<Data> HasGroup<Data> for Subsystem<Data> {
> +    unsafe fn group(this: *const Self) -> *const bindings::config_group =
{
> +        // SAFETY: By impl and function safety requirement this projecti=
on is in bounds.
> +        unsafe { addr_of!((*(*this).subsystem.get()).su_group) }
> +    }
> +
> +    unsafe fn container_of(group: *const bindings::config_group) -> *con=
st Self {
> +        // SAFETY: By impl and function safety requirement this projecti=
on is in bounds.
> +        let c_subsys_ptr =3D unsafe { container_of!(group, bindings::con=
figfs_subsystem, su_group) };
> +        let opaque_ptr =3D c_subsys_ptr.cast::<Opaque<bindings::configfs=
_subsystem>>();
> +        // SAFETY: By impl and function safety requirement, `opaque_ptr`=
 and the
> +        // pointer it returns, are within the same allocation.
> +        unsafe { container_of!(opaque_ptr, Subsystem<Data>, subsystem) }
> +    }
> +}
> +
> +/// A `configfs` group.
> +///
> +/// To add a subgroup to `configfs`, pass this type as `ctype` to
> +/// [`crate::configfs_attrs`] when creating a group in [`GroupOperations=
::make_group`].
> +#[pin_data]
> +pub struct Group<Data> {

Same question about the generic name here.

> +    #[pin]
> +    group: Opaque<bindings::config_group>,
> +    #[pin]
> +    data: Data,
> +}
> +
> +impl<Data> Group<Data> {
> +    /// Create an initializer for a new group.
> +    ///
> +    /// When instantiated, the group will appear as a directory with the=
 name
> +    /// given by `name` and it will contain attributes specified by `ite=
m_type`.
> +    pub fn new(
> +        name: CString,
> +        item_type: &'static ItemType<Group<Data>, Data>,
> +        data: impl PinInit<Data, Error>,
> +    ) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            group <- kernel::init::zeroed().chain(|v: &mut Opaque<bindin=
gs::config_group>| {
> +                let place =3D v.get();
> +                let name =3D name.as_bytes_with_nul().as_ptr();
> +                // SAFETY: It is safe to initialize a group once it has =
been zeroed.
> +                unsafe {
> +                    bindings::config_group_init_type_name(place, name as=
 _, item_type.as_ptr())

Can you replace the `as _` cast with a `.cast()`?

> +                };
> +                Ok(())
> +            }),
> +            data <- data,
> +        })
> +    }
> +}
> +
> +// SAFETY: `Group<Data>` embeds a field of type `bindings::config_group`
> +// within the `group` field.
> +unsafe impl<Data> HasGroup<Data> for Group<Data> {
> +    unsafe fn group(this: *const Self) -> *const bindings::config_group =
{
> +        Opaque::raw_get(
> +            // SAFETY: By impl and function safety requirements this fie=
ld
> +            // projection is within bounds of the allocation.
> +            unsafe { addr_of!((*this).group) },
> +        )
> +    }
> +
> +    unsafe fn container_of(group: *const bindings::config_group) -> *con=
st Self {
> +        let opaque_ptr =3D group.cast::<Opaque<bindings::config_group>>(=
);
> +        // SAFETY: By impl and function safety requirement, `opaque_ptr`=
 and
> +        // pointer it returns will be in the same allocation.
> +        unsafe { container_of!(opaque_ptr, Self, group) }
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// `this` must be a valid pointer.
> +///
> +/// If `this` does not represent the root group of a `configfs` subsyste=
m,
> +/// `this` must be a pointer to a `bindings::config_group` embedded in a
> +/// `Group<Parent>`.
> +///
> +/// Otherwise, `this` must be a pointer to a `bindings::config_group` th=
at
> +/// is embedded in a `bindings::configfs_subsystem` that is embedded in =
a
> +/// `Subsystem<Parent>`.
> +unsafe fn get_group_data<'a, Parent>(this: *mut bindings::config_group) =
-> &'a Parent {
> +    // TODO

Missed this todo?

> +    // SAFETY: `this` is a valid pointer.
> +    let is_root =3D unsafe { (*this).cg_subsys.is_null() };
> +
> +    if !is_root {
> +        // SAFETY: By C API contact, `this` is a pointer to a
> +        // `bindings::config_group` that we passed as a return value in =
from
> +        // `make_group`. Such a pointer is embedded within a `Group<Pare=
nt>`.
> +        unsafe { &(*Group::<Parent>::container_of(this)).data }
> +    } else {
> +        // SAFETY: By C API contract, `this` is a pointer to the
> +        // `bindings::config_group` field within a `Subsystem<Parent>`.
> +        unsafe { &(*Subsystem::container_of(this)).data }
> +    }
> +}
> +
> +struct GroupOperationsVTable<Parent, Child>(PhantomData<(Parent, Child)>=
)

Generic names?

> +where
> +    Parent: GroupOperations<Child =3D Child>;

No need to put this where bound on the struct definition (it is only
needed if the struct impls `Drop`).

> +
> +impl<Parent, Child> GroupOperationsVTable<Parent, Child>
> +where
> +    Parent: GroupOperations<Child =3D Child>,
> +    Child: 'static,
> +{
> +    /// # Safety
> +    ///
> +    /// `this` must be a valid pointer.
> +    ///
> +    /// If `this` does not represent the root group of a `configfs` subs=
ystem,
> +    /// `this` must be a pointer to a `bindings::config_group` embedded =
in a
> +    /// `Group<Parent>`.
> +    ///
> +    /// Otherwise, `this` must be a pointer to a `bindings::config_group=
` that
> +    /// is embedded in a `bindings::configfs_subsystem` that is embedded=
 in a
> +    /// `Subsystem<Parent>`.
> +    ///
> +    /// `name` must point to a null terminated string.
> +    unsafe extern "C" fn make_group(
> +        this: *mut bindings::config_group,
> +        name: *const kernel::ffi::c_char,
> +    ) -> *mut bindings::config_group {
> +        // SAFETY: By function safety requirements of this function, thi=
s call
> +        // is safe.
> +        let parent_data =3D unsafe { get_group_data(this) };
> +
> +        let group_init =3D match Parent::make_group(
> +            parent_data,
> +            // SAFETY: By function safety requirements, name points to a=
 null
> +            // terminated string.
> +            unsafe { CStr::from_char_ptr(name) },
> +        ) {
> +            Ok(init) =3D> init,
> +            Err(e) =3D> return e.to_ptr(),
> +        };
> +
> +        let child_group =3D <Arc<Group<Child>> as InPlaceInit<Group<Chil=
d>>>::try_pin_init(
> +            group_init,
> +            flags::GFP_KERNEL,
> +        );
> +
> +        match child_group {
> +            Ok(child_group) =3D> {
> +                let child_group_ptr =3D child_group.into_foreign();
> +                // SAFETY: We allocated the pointee of `child_ptr` above=
 as a
> +                // `Group<Child>`.
> +                unsafe { Group::<Child>::group(child_group_ptr) }.cast_m=
ut()
> +            }
> +            Err(e) =3D> e.to_ptr(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// If `this` does not represent the root group of a `configfs` subs=
ystem,
> +    /// `this` must be a pointer to a `bindings::config_group` embedded =
in a
> +    /// `Group<Parent>`.
> +    ///
> +    /// Otherwise, `this` must be a pointer to a `bindings::config_group=
` that
> +    /// is embedded in a `bindings::configfs_subsystem` that is embedded=
 in a
> +    /// `Subsystem<Parent>`.
> +    ///
> +    /// `item` must point to a `bindings::config_item` within a
> +    /// `bindings::config_group` within a `Group<Child>`.
> +    unsafe extern "C" fn drop_item(
> +        this: *mut bindings::config_group,
> +        item: *mut bindings::config_item,
> +    ) {
> +        // SAFETY: By function safety requirements of this function, thi=
s call
> +        // is safe.
> +        let parent_data =3D unsafe { get_group_data(this) };
> +
> +        // SAFETY: By function safety requirements, `item` is embedded i=
n a
> +        // `config_group`.
> +        let c_child_group_ptr =3D
> +            unsafe { kernel::container_of!(item, bindings::config_group,=
 cg_item) };
> +        // SAFETY: By function safety requirements, `c_child_group_ptr` =
is
> +        // embedded within a `Group<CHLD>`.
> +        let r_child_group_ptr =3D unsafe { Group::<Child>::container_of(=
c_child_group_ptr) };
> +
> +        if Parent::HAS_DROP_ITEM {
> +            Parent::drop_item(
> +                parent_data,
> +                // SAFETY: We called `into_foreign` to produce `r_child_=
group_ptr` in
> +                // `make_group`. There are not other borrows of this poi=
nter in existence.
> +                unsafe {
> +                    <Arc<Group<Child>> as ForeignOwnable>::borrow(r_chil=
d_group_ptr.cast_mut())
> +                },
> +            );
> +        }
> +
> +        // SAFETY: By C API contract, we are required to drop a refcount=
 on
> +        // `item`.
> +        unsafe { bindings::config_item_put(item) };
> +    }
> +
> +    const VTABLE: bindings::configfs_group_operations =3D bindings::conf=
igfs_group_operations {
> +        make_item: None,
> +        make_group: Some(Self::make_group),
> +        disconnect_notify: None,
> +        drop_item: Some(Self::drop_item),
> +        is_visible: None,
> +        is_bin_visible: None,
> +    };
> +}
> +
> +struct ItemOperationsVTable<Container, Data>(PhantomData<(Container, Dat=
a)>);
> +
> +impl<Data> ItemOperationsVTable<Group<Data>, Data>
> +where
> +    Data: 'static,
> +{
> +    /// # Safety
> +    ///
> +    /// `this` must be a pointer to a `bindings::config_group` embedded =
in a
> +    /// `Group<Parent>`.
> +    ///
> +    /// This function will destroy the pointee of `this`. The pointee of=
 `this`
> +    /// must not be accessed after the function returns.
> +    unsafe extern "C" fn release(this: *mut bindings::config_item) {
> +        // SAFETY: By function safety requirements, `this` is embedded i=
n a
> +        // `config_group`.
> +        let c_group_ptr =3D unsafe { kernel::container_of!(this, binding=
s::config_group, cg_item) };
> +        // SAFETY: By function safety requirements, `c_group_ptr` is
> +        // embedded within a `Group<Data>`.
> +        let r_group_ptr =3D unsafe { Group::<Data>::container_of(c_group=
_ptr) };
> +
> +        // SAFETY: We called `into_foreign` on `r_group_ptr` in
> +        // `make_group`.
> +        let pin_self =3D
> +            unsafe { <Arc<Group<Data>> as ForeignOwnable>::from_foreign(=
r_group_ptr.cast_mut()) };
> +        drop(pin_self);
> +    }
> +
> +    const VTABLE: bindings::configfs_item_operations =3D bindings::confi=
gfs_item_operations {
> +        release: Some(Self::release),
> +        allow_link: None,
> +        drop_link: None,
> +    };
> +}
> +
> +impl<Data> ItemOperationsVTable<Subsystem<Data>, Data> {
> +    const VTABLE: bindings::configfs_item_operations =3D bindings::confi=
gfs_item_operations {
> +        release: None,
> +        allow_link: None,
> +        drop_link: None,
> +    };
> +}
> +
> +/// Operations implemented by `configfs` groups that can create subgroup=
s.
> +///
> +/// Implement this trait on structs that embed a [`Subsystem`] or a [`Gr=
oup`].
> +#[vtable]
> +pub trait GroupOperations {
> +    /// The parent data object type.
> +    ///
> +    /// The implementer of this trait is this kind of data object. Shoul=
d be set
> +    /// to `Self`.
> +    type Parent;

If it should be set to `Self`, why does this even exist? If there are
cases where it isn't supposed to be `Self`, it would be good to put them
into the docs.

> +
> +    /// The child data object type.
> +    ///
> +    /// This group will create subgroups (subdirectories) backed by this=
 kind of
> +    /// object.
> +    type Child: 'static;
> +
> +    /// The kernel will call this method in response to `mkdir(2)` in th=
e
> +    /// directory representing `this`.

This doesn't really read like a first line description of this function,
how about putting "Creates a new subgroup." as the first line?

> +    ///
> +    /// To accept the request to create a group, implementations should
> +    /// instantiate a `CHLD` and return a `CPTR` to it. To prevent creat=
ion,

Is there a typo in `CHLD`? What do you mean by "return a `CPTR` to it"?

> +    /// return a suitable error.
> +    fn make_group(
> +        this: &Self::Parent,
> +        name: &CStr,
> +    ) -> Result<impl PinInit<Group<Self::Child>, Error>>;
> +
> +    /// The kernel will call this method before the directory representi=
ng
> +    /// `_child` is removed from `configfs`.

Same thing about the one-line description, how about (with the name
changed below): "Prepares the given group for removal from configfs.".

> +    ///
> +    /// Implementations can use this method to do house keeping before
> +    /// `configfs` drops its reference to `Child`.
> +    fn drop_item(

`drop` doesn't really fit here, I think something like `unlink_item`
fits better, since the child isn't actually dropped after this function
returns.

> +        _this: &Self::Parent,
> +        _child: <Arc<Group<Self::Child>> as ForeignOwnable>::Borrowed<'_=
>,

Just write ArcBorrow<'_, Group<Self::Child>> instead of the above?

> +    ) {
> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// A `configfs` attribute.
> +///
> +/// An attribute appear as a file in configfs, inside a folder that repr=
esent

Typo: appear -> appears

> +/// the group that the attribute belongs to.
> +#[repr(transparent)]
> +pub struct Attribute<const ID: u64, O, Data> {
> +    attribute: Opaque<bindings::configfs_attribute>,
> +    _p: PhantomData<(O, Data)>,
> +}
> +
> +// SAFETY: We do not provide any operations on `Attribute`.
> +unsafe impl<const ID: u64, O, Data> Sync for Attribute<ID, O, Data> {}
> +
> +// SAFETY: Ownership of `Attribute` can safely be transferred to other t=
hreads.
> +unsafe impl<const ID: u64, O, Data> Send for Attribute<ID, O, Data> {}
> +
> +impl<const ID: u64, O, Data> Attribute<ID, O, Data>
> +where
> +    O: AttributeOperations<ID, Data =3D Data>,
> +{
> +    /// # Safety
> +    ///
> +    /// `item` must be embedded in a `bindings::config_group`.
> +    ///
> +    /// If `item` does not represent the root group of a `configfs` subs=
ystem,
> +    /// the group must be embedded in a `Group<Data>`.
> +    ///
> +    /// Otherwise, the group must be a embedded in a
> +    /// `bindings::configfs_subsystem` that is embedded in a `Subsystem<=
Data>`.
> +    ///
> +    /// `page` must point to a writable buffer of size at least [`PAGE_S=
IZE`].
> +    unsafe extern "C" fn show(
> +        item: *mut bindings::config_item,
> +        page: *mut kernel::ffi::c_char,
> +    ) -> isize {
> +        let c_group: *mut bindings::config_group =3D
> +        // SAFETY: By function safety requirements, `item` is embedded i=
n a
> +        // `config_group`.
> +            unsafe { container_of!(item, bindings::config_group, cg_item=
) }.cast_mut();
> +
> +        // SAFETY: The function safety requirements for this function sa=
tisfy
> +        // the conditions for this call.
> +        let data: &Data =3D unsafe { get_group_data(c_group) };
> +
> +        // SAFETY: By function safety requirements, `page` is writable f=
or `PAGE_SIZE`.
> +        let ret =3D O::show(data, unsafe { &mut *(page as *mut [u8; PAGE=
_SIZE]) });
> +
> +        match ret {
> +            Ok(size) =3D> size as isize,
> +            Err(err) =3D> err.to_errno() as isize,
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `item` must be embedded in a `bindings::config_group`.
> +    ///
> +    /// If `item` does not represent the root group of a `configfs` subs=
ystem,
> +    /// the group must be embedded in a `Group<Data>`.
> +    ///
> +    /// Otherwise, the group must be a embedded in a
> +    /// `bindings::configfs_subsystem` that is embedded in a `Subsystem<=
Data>`.
> +    ///
> +    /// `page` must point to a readable buffer of size at least `size`.
> +    unsafe extern "C" fn store(
> +        item: *mut bindings::config_item,
> +        page: *const kernel::ffi::c_char,
> +        size: usize,
> +    ) -> isize {
> +        let c_group: *mut bindings::config_group =3D
> +        // SAFETY: By function safety requirements, `item` is embedded i=
n a
> +        // `config_group`.
> +            unsafe { container_of!(item, bindings::config_group, cg_item=
) }.cast_mut();
> +
> +        // SAFETY: The function safety requirements for this function sa=
tisfy
> +        // the conditions for this call.
> +        let data: &Data =3D unsafe { get_group_data(c_group) };
> +
> +        let ret =3D O::store(
> +            data,
> +            // SAFETY: By function safety requirements, `page` is readab=
le
> +            // for at least `size`.
> +            unsafe { core::slice::from_raw_parts(page.cast(), size) },
> +        );
> +
> +        match ret {
> +            Ok(()) =3D> size as isize,
> +            Err(err) =3D> err.to_errno() as isize,
> +        }
> +    }
> +
> +    /// Create a new attribute.
> +    ///
> +    /// The attribute will appear as a file with name given by `name`.
> +    pub const fn new(name: &'static CStr) -> Self {
> +        Self {
> +            attribute: Opaque::new(bindings::configfs_attribute {
> +                ca_name: name as *const _ as _,
> +                ca_owner: core::ptr::null_mut(),
> +                ca_mode: 0o660,
> +                show: Some(Self::show),
> +                store: if O::HAS_STORE {
> +                    Some(Self::store)
> +                } else {
> +                    None
> +                },
> +            }),
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +/// Operations supported by an attribute.
> +///
> +/// Implement this trait on type and pass that type as generic parameter=
 when
> +/// creating an [`Attribute`]. The type carrying the implementation serv=
e no
> +/// purpose other than specifying the attribute operations.
> +#[vtable]
> +pub trait AttributeOperations<const ID: u64 =3D 0> {
> +    /// The type of the object that contains the field that is backing t=
he
> +    /// attribute for this operation.
> +    type Data;
> +
> +    /// This function is called by the kernel to read the value of an at=
tribute.

"Reads the value of an attribute.".

> +    ///
> +    /// Implementations should write the rendering of the attribute to `=
page`
> +    /// and return the number of bytes written.
> +    fn show(data: &Self::Data, page: &mut [u8; PAGE_SIZE]) -> Result<usi=
ze>;

Why is this not named `read` or `load`? If the C equivalent is `show`,
then it's fine, but otherwise I wouldn't understand why it's show/store
as opposed to load/store or read/write.

> +
> +    /// This function is called by the kernel to update the value of an =
attribute.

Again first line doc here.

> +    ///
> +    /// Implementations should parse the value from `page` and update in=
ternal
> +    /// state to reflect the parsed value. Partial writes are not suppor=
ted and
> +    /// implementations should expect the full page to arrive in one wri=
te
> +    /// operation.

I don't understand what you're trying to say with the last sentence.

> +    fn store(_data: &Self::Data, _page: &[u8]) -> Result {
> +        kernel::build_error!(kernel::error::VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// A list of attributes.
> +///
> +/// This type is used to construct a new [`ItemType`]. It represents a l=
ist of
> +/// [`Attribute`] that will appear in the directory representing a [`Gro=
up`].
> +/// Users should not directly instantiate this type, rather they should =
use the
> +/// [`kernel::configfs_attrs`] macro to declare a static set of attribut=
es for a
> +/// group.
> +#[repr(transparent)]
> +pub struct AttributeList<const N: usize, Data>(
> +    UnsafeCell<[*mut kernel::ffi::c_void; N]>,
> +    PhantomData<Data>,
> +);
> +
> +// SAFETY: Ownership of `AttributeList` can safely be transferred to oth=
er threads.
> +unsafe impl<const N: usize, Data> Send for AttributeList<N, Data> {}
> +
> +// SAFETY: We do not provide any operations on `AttributeList` that need=
 synchronization.
> +unsafe impl<const N: usize, Data> Sync for AttributeList<N, Data> {}
> +
> +impl<const N: usize, Data> AttributeList<N, Data> {
> +    #[doc(hidden)]

I normally put attributes after the documentation.

> +    /// # Safety
> +    ///
> +    /// This function can only be called by expanding the `configfs_attr=
s`

s/expanding//

> +    /// macro.
> +    pub const unsafe fn new() -> Self {
> +        Self(UnsafeCell::new([core::ptr::null_mut(); N]), PhantomData)
> +    }
> +
> +    #[doc(hidden)]
> +    /// # Safety
> +    ///
> +    /// This function can only be called by expanding the `configfs_attr=
s`

s/expanding//

> +    /// macro.
> +    pub const unsafe fn add<
> +        const I: usize,
> +        const ID: u64,
> +        O: AttributeOperations<ID, Data =3D Data>,
> +    >(
> +        &'static self,
> +        attribute: &'static Attribute<ID, O, Data>,
> +    ) {
> +        if I >=3D N - 1 {
> +            kernel::build_error!("Invalid attribute index");
> +        }
> +
> +        // SAFETY: This function is only called through `configfs_attrs`=
. This

s/through `configfs_attrs`/through the `configfs_attrs` macro/

> +        // ensures that we are evaluating the function in const context =
when
> +        // initializing a static. As such, the reference created below w=
ill be
> +        // exclusive.
> +        unsafe {
> +            (&mut *self.0.get())[I] =3D (attribute as *const Attribute<I=
D, O, Data>)
> +                .cast_mut()
> +                .cast()
> +        };
> +    }
> +}
> +
> +/// A representation of the attributes that will appear in a [`Group`] o=
r
> +/// [`Subsystem`].
> +///
> +/// Users should not directly instantiate objects of this type. Rather, =
they
> +/// should use the [`kernel::configfs_attrs`] macro to statically declar=
e the
> +/// shape of a [`Group`] or [`Subsystem`].
> +#[pin_data]
> +pub struct ItemType<Container, Data> {
> +    #[pin]
> +    item_type: Opaque<bindings::config_item_type>,
> +    _p: PhantomData<(Container, Data)>,
> +}
> +
> +// SAFETY: We do not provide any operations on `ItemType` that need sync=
hronization.
> +unsafe impl<Container, Data> Sync for ItemType<Container, Data> {}
> +
> +// SAFETY: Ownership of `ItemType` can safely be transferred to other th=
reads.
> +unsafe impl<Container, Data> Send for ItemType<Container, Data> {}
> +
> +macro_rules! impl_item_type {
> +    ($tpe:ty) =3D> {
> +        impl<Data> ItemType<$tpe, Data> {
> +            #[doc(hidden)]
> +            pub const fn new_with_child_ctor<const N: usize, Child>(
> +                owner: &'static ThisModule,
> +                attributes: &'static AttributeList<N, Data>,
> +            ) -> Self
> +            where
> +                Data: GroupOperations<Child =3D Child>,
> +                Child: 'static,
> +            {
> +                Self {
> +                    item_type: Opaque::new(bindings::config_item_type {
> +                        ct_owner: owner.as_ptr(),
> +                        ct_group_ops: (&GroupOperationsVTable::<Data, Ch=
ild>::VTABLE as *const _)
> +                            as *mut _,
> +                        ct_item_ops: (&ItemOperationsVTable::<$tpe, Data=
>::VTABLE as *const _)
> +                            as *mut _,
> +                        ct_attrs: attributes as *const _ as _,
> +                        ct_bin_attrs: core::ptr::null_mut(),
> +                    }),
> +                    _p: PhantomData,
> +                }
> +            }
> +
> +            #[doc(hidden)]
> +            pub const fn new<const N: usize>(
> +                owner: &'static ThisModule,
> +                attributes: &'static AttributeList<N, Data>,
> +            ) -> Self {
> +                Self {
> +                    item_type: Opaque::new(bindings::config_item_type {
> +                        ct_owner: owner.as_ptr(),
> +                        ct_group_ops: core::ptr::null_mut(),
> +                        ct_item_ops: (&ItemOperationsVTable::<$tpe, Data=
>::VTABLE as *const _)
> +                            as *mut _,
> +                        ct_attrs: attributes as *const _ as _,
> +                        ct_bin_attrs: core::ptr::null_mut(),
> +                    }),
> +                    _p: PhantomData,
> +                }
> +            }
> +        }
> +    };
> +}
> +
> +impl_item_type!(Subsystem<Data>);
> +impl_item_type!(Group<Data>);
> +
> +impl<Container, Data> ItemType<Container, Data> {
> +    fn as_ptr(&self) -> *const bindings::config_item_type {
> +        self.item_type.get()
> +    }
> +}
> +
> +/// Define a list of configfs attributes statically.
> +#[macro_export]
> +macro_rules! configfs_attrs {

I see you've joined the dark side of declarative macros!

This seems like a prime candidate for replacing with a proc-macro when
we have syn :)

> +    (
> +        container: $container:ty,
> +        data: $data:ty,
> +        attributes: [
> +            $($name:ident: $attr:literal,)*

This syntax always requires a trailing comma. Most (IIRC all, but not
100% sure) Rust syntax allows you to omit it, so it would be odd if it
were not the case here. You can have an optional trailing comma via:

    $($name:ident: $attr:literal),* $(,)?

But as soon as you give the tokens off to the internals of the macro, I
would recommend sticking to always having a trailing comma or no
trailing comma.

> +        ],
> +    ) =3D> {
> +        $crate::configfs_attrs!(
> +            count:
> +            @container($container),
> +            @data($data),
> +            @child(),
> +            @no_child(x),
> +            @attrs($($name $attr)*),
> +            @eat($($name $attr,)*),
> +            @assign(),
> +            @cnt(0usize),
> +        )
> +    };
> +    (
> +        container: $container:ty,
> +        data: $data:ty,
> +        child: $child:ty,
> +        attributes: [
> +            $($name:ident: $attr:literal,)*

Ditto.

> +        ],
> +    ) =3D> {
> +        $crate::configfs_attrs!(
> +            count:
> +            @container($container),
> +            @data($data),
> +            @child($child),
> +            @no_child(),
> +            @attrs($($name $attr)*),
> +            @eat($($name $attr,)*),
> +            @assign(),
> +            @cnt(0usize),
> +        )
> +    };
> +    (count:
> +     @container($container:ty),
> +     @data($data:ty),
> +     @child($($child:ty)?),
> +     @no_child($($no_child:ident)?),
> +     @attrs($($aname:ident $aattr:literal)*),
> +     @eat($name:ident $attr:literal, $($rname:ident $rattr:literal,)*),
> +     @assign($($assign:block)*),
> +     @cnt($cnt:expr),
> +    ) =3D> {
> +        $crate::configfs_attrs!(
> +            count:
> +            @container($container),
> +            @data($data),
> +            @child($($child)?),
> +            @no_child($($no_child)?),
> +            @attrs($($aname $aattr)*),
> +            @eat($($rname $rattr,)*),
> +            @assign($($assign)* {
> +                const N: usize =3D $cnt;
> +                // SAFETY: We are expanding `configfs_attrs`.

This safety comment is doing a lot of heavy lifting, since it is not at
all obvious what the below unsafe function will resolve to... Seems also
a hassle to put a full comment here explaining that
`[< $data:upper _ATTRS >]` is defined by the macro below and that it is
of type `AttributeList` etc... But maybe we should.

> +                unsafe {
> +                    $crate::macros::paste!( [< $data:upper _ATTRS >])
> +                        .add::<N, $attr, _>(
> +                            & $crate::macros::paste!( [< $data:upper _ $=
name:upper _ATTR >])
> +                        )
> +                };
> +            }),

You can merge the two `paste!` invocations into one:

    @assign($($assign)* {
        const N: usize =3D $cnt;
        $crate::macros::paste! {
            // SAFETY: see above comment
            unsafe {
                [< $data:upper _ATTRS >].add::<N, $attr, _>(
                    &[< $data:upper _ $name:upper _ATTR >]
                );
            }
        }
    }),

> +            @cnt(1usize + $cnt),
> +        )
> +    };
> +    (count:
> +     @container($container:ty),
> +     @data($data:ty),
> +     @child($($child:ty)?),
> +     @no_child($($no_child:ident)?),
> +     @attrs($($aname:ident $aattr:literal)*),
> +     @eat(),
> +     @assign($($assign:block)*),
> +     @cnt($cnt:expr),
> +    ) =3D>
> +    {
> +        $crate::configfs_attrs!(
> +            final:
> +            @container($container),
> +            @data($data),
> +            @child($($child)?),
> +            @no_child($($no_child)?),
> +            @attrs($($aname $aattr)*),
> +            @assign($($assign)*),
> +            @cnt($cnt),
> +        )
> +    };
> +    (final:
> +     @container($container:ty),
> +     @data($data:ty),
> +     @child($($child:ty)?),
> +     @no_child($($no_child:ident)?),
> +     @attrs($($name:ident $attr:literal)*),
> +     @assign($($assign:block)*),
> +     @cnt($cnt:expr),
> +    ) =3D>
> +    {
> +        {
> +            $(
> +                $crate::macros::paste!{

Again you can coalesce all of the `paste!` invocations into a single one
spanning the entire output of this macro branch.

> +                    // SAFETY: We are expanding `configfs_attrs`.
> +                    static [< $data:upper _ $name:upper _ATTR >]:
> +                      $crate::configfs::Attribute<$attr, $data, $data> =
=3D
> +                        unsafe {
> +                            $crate::configfs::Attribute::new(c_str!(::co=
re::stringify!($name)))
> +                        };
> +                }
> +            )*
> +
> +
> +            const N: usize =3D $cnt + 1usize;

Why do we need an additional copy? To have a zero entry at the end for C
to know it's the end of the list? If so, a comment here would be very
helpful.

> +            $crate::macros::paste!{
> +                // SAFETY: We are expanding `configfs_attrs`.
> +                static [< $data:upper _ATTRS >]:
> +                  $crate::configfs::AttributeList<N, $data> =3D
> +                    unsafe { $crate::configfs::AttributeList::new() };
> +            }
> +
> +            $($assign)*
> +
> +            $(
> +                $crate::macros::paste!{
> +                    const [<$no_child:upper>]: bool =3D true;
> +                };
> +
> +                $crate::macros::paste!{
> +                    static [< $data:upper _TPE >] : $crate::configfs::It=
emType<$container, $data>  =3D
> +                        $crate::configfs::ItemType::<$container, $data>:=
:new::<N>(
> +                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
> +                        );
> +                }
> +            )?
> +
> +            $(
> +                $crate::macros::paste!{
> +                    static [< $data:upper _TPE >]:
> +                      $crate::configfs::ItemType<$container, $data>  =3D
> +                        $crate::configfs::ItemType::<$container, $data>:=
:new_with_child_ctor::
> +                    <N, $child>(
> +                        &THIS_MODULE, &[<$ data:upper _ATTRS >]
> +                    );
> +                }
> +            )?
> +
> +            &$crate::macros::paste!( [< $data:upper _TPE >] )
> +        }
> +    };
> +
> +}

I tested if multiple invocations of this macro can shadow each other and
the answer is no. So wrapping a const with `{}` makes it inaccessible to
the outside which is exactly what we need here.
The macro looks quite good!

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911a..ec84653ab8c7a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,8 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +#[cfg(CONFIG_CONFIGFS_FS)]
> +pub mod configfs;
>  pub mod cred;
>  pub mod device;
>  pub mod device_id;
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 918dbead2c0b4..2f97bf9a7b4cc 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -10,6 +10,17 @@ menuconfig SAMPLES_RUST
>=20
>  if SAMPLES_RUST
>=20
> +config SAMPLE_RUST_CONFIGFS
> +=09tristate "Configfs sample"
> +=09depends on CONFIGFS_FS
> +=09help
> +=09  This option builds the Rust configfs sample.
> +
> +=09  To compile this as a module, choose M here:
> +=09  the module will be called rust_configfs.
> +
> +=09  If unsure, say N.
> +
>  config SAMPLE_RUST_MINIMAL
>  =09tristate "Minimal"
>  =09help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 5a8ab0df0567c..72122f010cafc 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)=09=09+=3D rust_misc=
_device.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)=09=09=09+=3D rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)=09=09+=3D rust_driver_pci.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)=09+=3D rust_driver_platform.o
> +obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)=09=09+=3D rust_configfs.o
>=20
>  rust_print-y :=3D rust_print_main.o rust_print_events.o
>=20
> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.r=
s
> new file mode 100644
> index 0000000000000..fe896e66efb41
> --- /dev/null
> +++ b/samples/rust/rust_configfs.rs
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust configfs sample.
> +
> +use kernel::alloc::flags;
> +use kernel::c_str;
> +use kernel::configfs;
> +use kernel::configfs_attrs;
> +use kernel::new_mutex;
> +use kernel::prelude::*;
> +use kernel::sync::Mutex;

Would merge the imports here too (rust-analyzer has a code-action for
that btw).

> +
> +module! {
> +    type: RustConfigfs,
> +    name: "rust_configfs",
> +    author: "Rust for Linux Contributors",
> +    description: "Rust configfs sample",
> +    license: "GPL",
> +}
> +
> +#[pin_data]
> +struct RustConfigfs {
> +    #[pin]
> +    config: configfs::Subsystem<Configuration>,
> +}
> +
> +#[pin_data]
> +struct Configuration {
> +    message: &'static CStr,
> +    #[pin]
> +    bar: Mutex<(KBox<[u8; 4096]>, usize)>,
> +}
> +
> +impl Configuration {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            message: c_str!("Hello World\n"),
> +            bar <- new_mutex!((KBox::new([0;4096], flags::GFP_KERNEL)?,0=
)),

s/;/; /
s/,0/, 0/

---
Cheers,
Benno

> +        })
> +    }
> +}
> +
> +impl kernel::InPlaceModule for RustConfigfs {
> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
> +        pr_info!("Rust configfs sample (init)\n");
> +
> +        let item_type =3D configfs_attrs! {
> +            container: configfs::Subsystem<Configuration>,
> +            data: Configuration,
> +            child: Child,
> +            attributes: [
> +                message: 0,
> +                bar: 1,
> +            ],
> +        };
> +
> +        try_pin_init!(Self {
> +            config <- configfs::Subsystem::new(
> +                kernel::c_str!("rust_configfs"), item_type, Configuratio=
n::new()
> +            ),
> +        })
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::GroupOperations for Configuration {
> +    type Parent =3D Self;
> +    type Child =3D Child;
> +
> +    fn make_group(
> +        _this: &Self,
> +        name: &CStr,
> +    ) -> Result<impl PinInit<configfs::Group<Child>, Error>> {
> +        let tpe =3D configfs_attrs! {
> +            container: configfs::Group<Child>,
> +            data: Child,
> +            child: GrandChild,
> +            attributes: [
> +                baz: 0,
> +            ],
> +        };
> +
> +        Ok(configfs::Group::new(name.try_into()?, tpe, Child::new()))
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for Configuration {
> +    type Data =3D Configuration;
> +
> +    fn show(container: &Configuration, page: &mut [u8; 4096]) -> Result<=
usize> {
> +        pr_info!("Show message\n");
> +        let data =3D container.message;
> +        page[0..data.len()].copy_from_slice(data);
> +        Ok(data.len())
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<1> for Configuration {
> +    type Data =3D Configuration;
> +
> +    fn show(container: &Configuration, page: &mut [u8; 4096]) -> Result<=
usize> {
> +        pr_info!("Show bar\n");
> +        let guard =3D container.bar.lock();
> +        let data =3D guard.0.as_slice();
> +        let len =3D guard.1;
> +        page[0..len].copy_from_slice(&data[0..len]);
> +        Ok(len)
> +    }
> +
> +    fn store(container: &Configuration, page: &[u8]) -> Result {
> +        pr_info!("Store bar\n");
> +        let mut guard =3D container.bar.lock();
> +        guard.0[0..page.len()].copy_from_slice(page);
> +        guard.1 =3D page.len();
> +        Ok(())
> +    }
> +}
> +
> +#[pin_data]
> +struct Child {}
> +
> +impl Child {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {})
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::GroupOperations for Child {
> +    type Parent =3D Self;
> +    type Child =3D GrandChild;
> +
> +    fn make_group(
> +        _this: &Self,
> +        name: &CStr,
> +    ) -> Result<impl PinInit<configfs::Group<GrandChild>, Error>> {
> +        let tpe =3D configfs_attrs! {
> +            container: configfs::Group<GrandChild>,
> +            data: GrandChild,
> +            attributes: [
> +                gc: 0,
> +            ],
> +        };
> +
> +        Ok(configfs::Group::new(
> +            name.try_into()?,
> +            tpe,
> +            GrandChild::new(),
> +        ))
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for Child {
> +    type Data =3D Child;
> +
> +    fn show(_container: &Child, page: &mut [u8; 4096]) -> Result<usize> =
{
> +        pr_info!("Show baz\n");
> +        let data =3D c"Hello Baz\n".to_bytes();
> +        page[0..data.len()].copy_from_slice(data);
> +        Ok(data.len())
> +    }
> +}
> +
> +#[pin_data]
> +struct GrandChild {}
> +
> +impl GrandChild {
> +    fn new() -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {})
> +    }
> +}
> +
> +#[vtable]
> +impl configfs::AttributeOperations<0> for GrandChild {
> +    type Data =3D GrandChild;
> +
> +    fn show(_container: &GrandChild, page: &mut [u8; 4096]) -> Result<us=
ize> {
> +        pr_info!("Show baz\n");
> +        let data =3D c"Hello GC\n".to_bytes();
> +        page[0..data.len()].copy_from_slice(data);
> +        Ok(data.len())
> +    }
> +}
>=20
> --
> 2.47.0
>=20
>=20


