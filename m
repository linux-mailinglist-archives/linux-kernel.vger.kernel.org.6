Return-Path: <linux-kernel+bounces-552432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A61A579DA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF153B404F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184BE1B4257;
	Sat,  8 Mar 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ldOnfA2Q"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82C1B21B8;
	Sat,  8 Mar 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431853; cv=none; b=bqalr1CUt2k7xjWYW+KF1cqEf7A2MrDYI3KbhOIkl9CcP0e9ARBqxn8X7Ppw1DaYwztZiwbtYzILgIGTHlMmd0Oo8cqNOsE5/mORg7Sa/NYfumGzgWESjpDGW13LEJIvBBNQ5DA5gmK1isCUP1c3ovkzsWMpcpOyxO7bDK0hNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431853; c=relaxed/simple;
	bh=p8PhLZ+7mERZU+6NlqRNMcHPwKXHBR+0h5C+DqSjmYw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEgaSmlnSehk3vYR5qvdnCA9ec30T9Jgj2PtxGYEo+CuwvSkL97+jDflPL2uano3HGVxcuFLkwtHyIAZPGxt02EuxJpQ0B5jeQlwllI7y2CmJ8oQ+28Iv9om7m6TJL9hWDZlnzfUS8bta6iThci6LV+jCHsHQUVVAonWbmo+09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ldOnfA2Q; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431849; x=1741691049;
	bh=wrc7dAMq4/lYVNenkoKdjjCIkKvIznXuj/iO5UKDIr4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ldOnfA2QK22kNSlrCDlxlaqQYvpx4uq1mQNJvjnQ2yw+XgtsQT8x9DgyjtmTyw7Ct
	 ohbGQdlM6pFQhEU9MQKwhOFvTQ0OUd5T0bOvL0ItR8uH+qS6lHgNqQ9hEGwrnSYZlr
	 dzXbjdvrf5DQqgy+7gFQpjleL057fET2JTUpFyGgFzrykMw9wqBl1DZbnUls2lAF/s
	 3GVRCJ3hsFFbyLrxwBZBbjZP9iF2rKfWzqFyLBNF471si/ccZSd8WzGxspjJnpJeZs
	 ViPTvq9qbTKqgTB4N39b2iFnXwjI7hxNVGJHPCltn5Woky8LSCk54mX0dOii21WbOx
	 9ywnJvdD4rZ4Q==
Date: Sat, 08 Mar 2025 11:04:07 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 03/22] rust: add extensions to the pin-init crate and move relevant documentation there
Message-ID: <20250308110339.2997091-4-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 63fbfc773db8d6a8b7f0d450616ff290069b4d19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In preparation of splitting off the pin-init crate from the kernel
crate, move all kernel-specific documentation from pin-init back into
the kernel crate.

Also include an example from the user-space version [1] adapted to the
kernel.

The new `init.rs` file will also be populated by kernel-specific
extensions to the pin-init crate by the next commits.

Link: https://github.com/Rust-for-Linux/pin-init/blob/c1417c64c71229f0fd444=
d75e88f33e3c547c829/src/lib.rs#L161 [1]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/init.rs      | 135 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |   3 +
 rust/pin-init/src/lib.rs |  14 ----
 3 files changed, 138 insertions(+), 14 deletions(-)
 create mode 100644 rust/kernel/init.rs

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
new file mode 100644
index 000000000000..322dfd9ec347
--- /dev/null
+++ b/rust/kernel/init.rs
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Extensions to the [`pin-init`] crate.
+//!
+//! Most `struct`s from the [`sync`] module need to be pinned, because the=
y contain self-referential
+//! `struct`s from C. [Pinning][pinning] is Rust's way of ensuring data do=
es not move.
+//!
+//! The [`pin-init`] crate is the way such structs are initialized on the =
Rust side. Please refer
+//! to its documentation to better understand how to use it. Additionally,=
 there are many examples
+//! throughout the kernel, such as the types from the [`sync`] module. And=
 the ones presented
+//! below.
+//!
+//! [`sync`]: crate::sync
+//! [pinning]: https://doc.rust-lang.org/std/pin/index.html
+//! [`pin-init`]: https://rust.docs.kernel.org/pin_init/
+//!
+//! # [`Opaque<T>`]
+//!
+//! For the special case where initializing a field is a single FFI-functi=
on call that cannot fail,
+//! there exist the helper function [`Opaque::ffi_init`]. This function in=
itialize a single
+//! [`Opaque<T>`] field by just delegating to the supplied closure. You ca=
n use these in
+//! combination with [`pin_init!`].
+//!
+//! [`Opaque<T>`]: crate::types::Opaque
+//! [`Opaque::ffi_init`]: crate::types::Opaque::ffi_init
+//! [`pin_init!`]: crate::pin_init
+//!
+//! # Examples
+//!
+//! ## General Examples
+//!
+//! ```rust,ignore
+//! # #![allow(clippy::disallowed_names)]
+//! use kernel::types::Opaque;
+//! use pin_init::pin_init_from_closure;
+//!
+//! // assume we have some `raw_foo` type in C:
+//! #[repr(C)]
+//! struct RawFoo([u8; 16]);
+//! extern {
+//!     fn init_foo(_: *mut RawFoo);
+//! }
+//!
+//! #[pin_data]
+//! struct Foo {
+//!     #[pin]
+//!     raw: Opaque<RawFoo>,
+//! }
+//!
+//! impl Foo {
+//!     fn setup(self: Pin<&mut Self>) {
+//!         pr_info!("Setting up foo");
+//!     }
+//! }
+//!
+//! let foo =3D pin_init!(Foo {
+//!     raw <- unsafe {
+//!         Opaque::ffi_init(|s| {
+//!             // note that this cannot fail.
+//!             init_foo(s);
+//!         })
+//!     },
+//! }).pin_chain(|foo| {
+//!     foo.setup();
+//!     Ok(())
+//! });
+//! ```
+//!
+//! ```rust,ignore
+//! # #![allow(unreachable_pub, clippy::disallowed_names)]
+//! use kernel::{prelude::*, types::Opaque};
+//! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
+//! # mod bindings {
+//! #     #![allow(non_camel_case_types)]
+//! #     pub struct foo;
+//! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
+//! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
+//! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0=
 }
+//! # }
+//! # // `Error::from_errno` is `pub(crate)` in the `kernel` crate, thus p=
rovide a workaround.
+//! # trait FromErrno {
+//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
+//! #         // Dummy error that can be constructed outside the `kernel` =
crate.
+//! #         Error::from(core::fmt::Error)
+//! #     }
+//! # }
+//! # impl FromErrno for Error {}
+//! /// # Invariants
+//! ///
+//! /// `foo` is always initialized
+//! #[pin_data(PinnedDrop)]
+//! pub struct RawFoo {
+//!     #[pin]
+//!     foo: Opaque<bindings::foo>,
+//!     #[pin]
+//!     _p: PhantomPinned,
+//! }
+//!
+//! impl RawFoo {
+//!     pub fn new(flags: u32) -> impl PinInit<Self, Error> {
+//!         // SAFETY:
+//!         // - when the closure returns `Ok(())`, then it has successful=
ly initialized and
+//!         //   enabled `foo`,
+//!         // - when it returns `Err(e)`, then it has cleaned up before
+//!         unsafe {
+//!             pin_init::pin_init_from_closure(move |slot: *mut Self| {
+//!                 // `slot` contains uninit memory, avoid creating a ref=
erence.
+//!                 let foo =3D addr_of_mut!((*slot).foo);
+//!
+//!                 // Initialize the `foo`
+//!                 bindings::init_foo(Opaque::raw_get(foo));
+//!
+//!                 // Try to enable it.
+//!                 let err =3D bindings::enable_foo(Opaque::raw_get(foo),=
 flags);
+//!                 if err !=3D 0 {
+//!                     // Enabling has failed, first clean up the foo and=
 then return the error.
+//!                     bindings::destroy_foo(Opaque::raw_get(foo));
+//!                     return Err(Error::from_errno(err));
+//!                 }
+//!
+//!                 // All fields of `RawFoo` have been initialized, since=
 `_p` is a ZST.
+//!                 Ok(())
+//!             })
+//!         }
+//!     }
+//! }
+//!
+//! #[pinned_drop]
+//! impl PinnedDrop for RawFoo {
+//!     fn drop(self: Pin<&mut Self>) {
+//!         // SAFETY: Since `foo` is initialized, destroying is safe.
+//!         unsafe { bindings::destroy_foo(self.foo.get()) };
+//!     }
+//! }
+//! ```
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c1b781371ba3..e3933f3dfc0b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -52,6 +52,9 @@
 pub mod fs;
 #[path =3D "../pin-init/src/lib.rs"]
 pub mod init;
+// momentarily use the name `init_ext` and set the path manually
+#[path =3D "init.rs"]
+pub mod init_ext;
 pub mod io;
 pub mod ioctl;
 pub mod jump_label;
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index aa8df0595585..0307a08ccee9 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -5,9 +5,6 @@
 //! It also allows in-place initialization of big `struct`s that would oth=
erwise produce a stack
 //! overflow.
 //!
-//! Most `struct`s from the [`sync`] module need to be pinned, because the=
y contain self-referential
-//! `struct`s from C. [Pinning][pinning] is Rust's way of ensuring data do=
es not move.
-//!
 //! # Overview
 //!
 //! To initialize a `struct` with an in-place constructor you will need tw=
o things:
@@ -188,15 +185,6 @@
 //! }
 //! ```
 //!
-//! For the special case where initializing a field is a single FFI-functi=
on call that cannot fail,
-//! there exist the helper function [`Opaque::ffi_init`]. This function in=
itialize a single
-//! [`Opaque`] field by just delegating to the supplied closure. You can u=
se these in combination
-//! with [`pin_init!`].
-//!
-//! For more information on how to use [`pin_init_from_closure()`], take a=
 look at the uses inside
-//! the `kernel` crate. The [`sync`] module is a good starting point.
-//!
-//! [`sync`]: kernel::sync
 //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
@@ -205,8 +193,6 @@
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
 //! [`impl Init<T, E>`]: Init
-//! [`Opaque`]: kernel::types::Opaque
-//! [`Opaque::ffi_init`]: kernel::types::Opaque::ffi_init
 //! [`pin_data`]: ::macros::pin_data
 //! [`pin_init!`]: crate::pin_init!
=20
--=20
2.47.2



