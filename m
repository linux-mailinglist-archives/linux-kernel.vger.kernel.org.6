Return-Path: <linux-kernel+bounces-552437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B5A579DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4311898419
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1C1B85E4;
	Sat,  8 Mar 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FbKfR8K4"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A51C5F1D;
	Sat,  8 Mar 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431877; cv=none; b=FIgbGFeKIQUz7xgWz69bJTqtybTerEg1Ei3XkGB7jeSaSr+zXZ9cW/Hr7MPWXbHr21TbMYTJ6efjmdgQaaex9/Qd4MQN4vhPu8aa5K67oh3ci+mcGnVuQhs3xBDRMQbu7KTP7/ImL6V2pNQlnuiolfnr3XXKsoe5/WpTkZhWm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431877; c=relaxed/simple;
	bh=pmwEO4JJLSkNer3w1ywfkdUj3zFYjwTM/Gxa8QdJX3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTSaOyiZuXOvn1CTghqQeLW0zWWf6sF1TIFArgOwZNgT+9+7QJss/P4K8cciWHdMexvpp7r2sSNv6DIaSlIWX+9ZvRujLwmEpZ6Ly/hxWc3Fhy03fFInzkWhxh1fEfk9GDNPudueoP/maYjB8OkgSuVV07Tf0gSDER56GnmWLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FbKfR8K4; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431872; x=1741691072;
	bh=UQzjJ25TDi3SwTmECf7vyxoHOeQC1fOWO87kJl4g4gw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FbKfR8K4GqHKnmOCr4+DTPCGnN+Yfm67yMoHXA3o7fRb5cuvdyh5PhM8ZUkDPP5Ie
	 UnSEpjDS5h7dpKOKBBVKzVhwez0jPGiVsrbNqR5rNBadzyKTVibyZeeohh2BNbgHuB
	 dZ+LC3nomUK/JP75x0ZmCDbfDILMLIzyelgt/M26SpSWqsRSnrvUYkcJQqS1n+PBdn
	 qCp2jXKQuudSQljJmeU9XfXNA90pe4Z6KqsnaQzoPkmLp9ZdhNTNq7W531cuNTfL+G
	 rr2LbNIH4j87nEalC9XEIw0GMKQrsOyIlbiEQ3QGH4gWGsxY+M3fpD08eeZgpeNnYv
	 HrQPAyB+vdJ/A==
Date: Sat, 08 Mar 2025 11:04:30 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/22] rust: pin-init: move the default error behavior of `try_[pin_]init`
Message-ID: <20250308110339.2997091-8-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dc8533bd256a8b4ce46177f65e94120a274d8bf4
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
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/init.rs      | 113 +++++++++++++++++++++++++++++++++++++++
 rust/pin-init/src/lib.rs |  55 +++++--------------
 2 files changed, 126 insertions(+), 42 deletions(-)

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
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 4df5216b80d7..d2176c65b109 100644
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



