Return-Path: <linux-kernel+bounces-545731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739CEA4F0C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D07F188EEC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78955278116;
	Tue,  4 Mar 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TBbsOVre"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9327933B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128860; cv=none; b=oqdeGJmMzK4+StXzKe08a2MeifIS5UCoI5VOOkLWl3+mOB7/PjBnakUBSrD+6SWnygAtflwKYqGQoQXpNJreanNnYhfvzAT739UXbXAGgaAi0M9fXJiMr362mQaLE69zJDM356ltk0m/lkivBLb3/GJ2R++WekXswDyTIHRBSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128860; c=relaxed/simple;
	bh=crXyyWBjIuGFhabJx+mbpOMdeEf7oQgectRScfm2HpE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs0SdIgkJs3PnFJ8bgHhWfcjS8j934sUau4vRLeWKUC2YPh1/MZQ5r58J6NoPIVED1JCnpI30uK9Bgqq8TMMsPJVh6LGCUgHRMRC7C4fbCyOBkvcfAK0YVZTzAo6Cam8edrMlMPPhVG7ZxuV74rLDDNKxSGT32waxnbktWotDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TBbsOVre; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128854; x=1741388054;
	bh=hjS+Gb3n3DzLMl56LyQO/eL4ZDjZlceVNftXygaKsLY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TBbsOVrevRCEy/FZv6/7+Oi7Yf43h0It3YV201oZPijYp2ZmWhiSGdh7uozHR4EKI
	 1oHc0sEQBuGujhLqFIsKD1FhCFdnL/F4wWkN32BTcMzpqt4auLIu/pFpOZ9xDGVtbC
	 lUL5fDbK/ZqrotbrW05O8KRc4+cBxiWVMG2E/f+WEMd1jKaf+BbReDcUc3+Tvzcrhw
	 uq8JcqaSuUYaHzcuspwUfcPYsKA7vaOnsHtHyMEj0jB6pO1snOsADdBzeXvYFiJwAt
	 mG8MlazYXxlClqFYy9jMkdNeqByNJEwpHAtbzU96F4Zl/vBpOXtLczZZIdU333q54g
	 5LAofGfBcl6LQ==
Date: Tue, 04 Mar 2025 22:54:07 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/22] rust: pin-init: move the default error behavior of `try_[pin_]init`
Message-ID: <20250304225245.2033120-8-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 375c48dc24d2c9c5be263fea787ff581b05eea90
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Move the ability to just write `try_pin_init!(Foo { a <- a_init })`
(note the missing `? Error` at the end) into the kernel crate.
Remove this notation from the pin-init crate, since the default when no
error is specified is the kernel-internal `Error` type. Instead add two
macros in the kernel crate that serve this default and are used instead
of the ones from `pin-init`.

This is done, because the `Error` type that is used as the default is
from the kernel crate and it thus prevents making the pin-init crate
standalone.

In order to not cause a build error due to a name overlap, the macros in
the pin-init crate are renamed, but this change is reverted in a future
commit when it is a standalone crate.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs      | 113 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs   |   3 +-
 rust/pin-init/src/lib.rs |  55 +++++--------------
 3 files changed, 128 insertions(+), 43 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 322dfd9ec347..d80eccf29100 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -133,3 +133,116 @@
 //!     }
 //! }
 //! ```
+
+/// Construct an in-place fallible initializer for `struct`s.
+///
+/// This macro defaults the error to [`Error`]. If you need [`Infallible`]=
, then use
+/// [`init!`].
+///
+/// The syntax is identical to [`try_pin_init!`]. If you want to specify a=
 custom error,
+/// append `? $type` after the `struct` initializer.
+/// The safety caveats from [`try_pin_init!`] also apply:
+/// - `unsafe` code must guarantee either full initialization or return an=
 error and allow
+///   deallocation of the memory.
+/// - the fields are initialized in the order given in the initializer.
+/// - no references to fields are allowed to be created inside of the init=
ializer.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::{init::zeroed, error::Error};
+/// struct BigBuf {
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
+///     small: [u8; 1024 * 1024],
+/// }
+///
+/// impl BigBuf {
+///     fn new() -> impl Init<Self, Error> {
+///         try_init!(Self {
+///             big: KBox::init(zeroed(), GFP_KERNEL)?,
+///             small: [0; 1024 * 1024],
+///         }? Error)
+///     }
+/// }
+/// ```
+///
+/// [`Infallible`]: core::convert::Infallible
+/// [`init!`]: crate::init!
+/// [`try_pin_init!`]: crate::try_pin_init!
+/// [`Error`]: crate::error::Error
+#[macro_export]
+macro_rules! try_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::_try_init!($(&$this in)? $t $(::<$($generics),* $(,)?>)? {
+            $($fields)*
+        }? $crate::error::Error)
+    };
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }? $err:ty) =3D> {
+        $crate::_try_init!($(&$this in)? $t $(::<$($generics),* $(,)?>)? {
+            $($fields)*
+        }? $err)
+    };
+}
+
+/// Construct an in-place, fallible pinned initializer for `struct`s.
+///
+/// If the initialization can complete without error (or [`Infallible`]), =
then use [`pin_init!`].
+///
+/// You can use the `?` operator or use `return Err(err)` inside the initi=
alizer to stop
+/// initialization and return the error.
+///
+/// IMPORTANT: if you have `unsafe` code inside of the initializer you hav=
e to ensure that when
+/// initialization fails, the memory can be safely deallocated without any=
 further modifications.
+///
+/// This macro defaults the error to [`Error`].
+///
+/// The syntax is identical to [`pin_init!`] with the following exception:=
 you can append `? $type`
+/// after the `struct` initializer to specify the error type you want to u=
se.
+///
+/// # Examples
+///
+/// ```rust
+/// # #![feature(new_uninit)]
+/// use kernel::{init::zeroed, error::Error};
+/// #[pin_data]
+/// struct BigBuf {
+///     big: KBox<[u8; 1024 * 1024 * 1024]>,
+///     small: [u8; 1024 * 1024],
+///     ptr: *mut u8,
+/// }
+///
+/// impl BigBuf {
+///     fn new() -> impl PinInit<Self, Error> {
+///         try_pin_init!(Self {
+///             big: KBox::init(zeroed(), GFP_KERNEL)?,
+///             small: [0; 1024 * 1024],
+///             ptr: core::ptr::null_mut(),
+///         }? Error)
+///     }
+/// }
+/// ```
+///
+/// [`Infallible`]: core::convert::Infallible
+/// [`pin_init!`]: crate::pin_init
+/// [`Error`]: crate::error::Error
+#[macro_export]
+macro_rules! try_pin_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::_try_pin_init!($(&$this in)? $t $(::<$($generics),* $(,)?>=
)? {
+            $($fields)*
+        }? $crate::error::Error)
+    };
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }? $err:ty) =3D> {
+        $crate::_try_pin_init!($(&$this in)? $t $(::<$($generics),* $(,)?>=
)? {
+            $($fields)*
+        }? $err)
+    };
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index dde2e0649790..4123d478c351 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -28,7 +28,8 @@
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info=
, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr=
_notice, pr_warn};
=20
-pub use super::{init, pin_init, try_init, try_pin_init};
+pub use super::{init, pin_init};
+pub use super::{try_init, try_pin_init};
=20
 pub use super::static_assert;
=20
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 4c492efeb5cd..1308b7af7ec9 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -481,7 +481,7 @@ macro_rules! stack_try_pin_init {
=20
 /// Construct an in-place, pinned initializer for `struct`s.
 ///
-/// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
+/// This macro defaults the error to [`Infallible`]. If you need a differe=
nt error, then use
 /// [`try_pin_init!`].
 ///
 /// The syntax is almost identical to that of a normal `struct` initialize=
r:
@@ -676,7 +676,7 @@ macro_rules! pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
+        $crate::_try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
             $($fields)*
         }? ::core::convert::Infallible)
     };
@@ -692,9 +692,7 @@ macro_rules! pin_init {
 /// IMPORTANT: if you have `unsafe` code inside of the initializer you hav=
e to ensure that when
 /// initialization fails, the memory can be safely deallocated without any=
 further modifications.
 ///
-/// This macro defaults the error to [`Error`].
-///
-/// The syntax is identical to [`pin_init!`] with the following exception:=
 you can append `? $type`
+/// The syntax is identical to [`pin_init!`] with the following exception:=
 you must append `? $type`
 /// after the `struct` initializer to specify the error type you want to u=
se.
 ///
 /// # Examples
@@ -724,21 +722,7 @@ macro_rules! pin_init {
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
-macro_rules! try_pin_init {
-    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
-        $($fields:tt)*
-    }) =3D> {
-        $crate::__init_internal!(
-            @this($($this)?),
-            @typ($t $(::<$($generics),*>)? ),
-            @fields($($fields)*),
-            @error($crate::error::Error),
-            @data(PinData, use_data),
-            @has_data(HasPinData, __pin_data),
-            @construct_closure(pin_init_from_closure),
-            @munch_fields($($fields)*),
-        )
-    };
+macro_rules! _try_pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
@@ -752,12 +736,12 @@ macro_rules! try_pin_init {
             @construct_closure(pin_init_from_closure),
             @munch_fields($($fields)*),
         )
-    };
+    }
 }
=20
 /// Construct an in-place initializer for `struct`s.
 ///
-/// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
+/// This macro defaults the error to [`Infallible`]. If you need a differe=
nt error, then use
 /// [`try_init!`].
 ///
 /// The syntax is identical to [`pin_init!`] and its safety caveats also a=
pply:
@@ -777,7 +761,7 @@ macro_rules! init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::try_init!($(&$this in)? $t $(::<$($generics),*>)? {
+        $crate::_try_init!($(&$this in)? $t $(::<$($generics),*>)? {
             $($fields)*
         }? ::core::convert::Infallible)
     }
@@ -785,11 +769,11 @@ macro_rules! init {
=20
 /// Construct an in-place fallible initializer for `struct`s.
 ///
-/// This macro defaults the error to [`Error`]. If you need [`Infallible`]=
, then use
+/// If the initialization can complete without error (or [`Infallible`]), =
then use
 /// [`init!`].
 ///
-/// The syntax is identical to [`try_pin_init!`]. If you want to specify a=
 custom error,
-/// append `? $type` after the `struct` initializer.
+/// The syntax is identical to [`try_pin_init!`]. You need to specify a cu=
stom error
+/// via `? $type` after the `struct` initializer.
 /// The safety caveats from [`try_pin_init!`] also apply:
 /// - `unsafe` code must guarantee either full initialization or return an=
 error and allow
 ///   deallocation of the memory.
@@ -816,24 +800,11 @@ macro_rules! init {
 ///     }
 /// }
 /// ```
+/// [`try_pin_init!`]: crate::try_pin_init
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
-macro_rules! try_init {
-    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
-        $($fields:tt)*
-    }) =3D> {
-        $crate::__init_internal!(
-            @this($($this)?),
-            @typ($t $(::<$($generics),*>)?),
-            @fields($($fields)*),
-            @error($crate::error::Error),
-            @data(InitData, /*no use_data*/),
-            @has_data(HasInitData, __init_data),
-            @construct_closure(init_from_closure),
-            @munch_fields($($fields)*),
-        )
-    };
+macro_rules! _try_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
@@ -847,7 +818,7 @@ macro_rules! try_init {
             @construct_closure(init_from_closure),
             @munch_fields($($fields)*),
         )
-    };
+    }
 }
=20
 /// Asserts that a field on a struct using `#[pin_data]` is marked with `#=
[pin]` ie. that it is
--=20
2.47.2



