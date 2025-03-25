Return-Path: <linux-kernel+bounces-575239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F792A6FA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E6318905D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A56E2566EE;
	Tue, 25 Mar 2025 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OQ1u5HEM"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AD2566ED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903834; cv=none; b=ro9WVsIe7qXrGDR/782Bnw+I81VfHfqE50tLgjQ+iXuVBaO3TB3izWPQ71XTCIcZ35ipP4FzcInhX81B9tX/YZ7m7T3F6pRnbyTtUXBXdNfyZ7TAaBcJHLTmpZaNp10tcOwFGXj4octFeJeImtVc2oS9OlCBYiulWLAsi6FWNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903834; c=relaxed/simple;
	bh=C0RwrWGOGxfVYV0ZG6ke5fAapyZFN2+Z6PniXzJrneM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0Ex7NeiAfdlbJITeu/PswOD1dBarIUKXmgtLvxPRnY5CnRjKwyaTfShKH2f5SsKm3ISuUzrZL1MZMEkNApmse3PPoAc7SYqdZL+zhjQeV7iIQKu+ojaoveiN7uM9vnsFXCHoNEQ+plPuSbh52yVe7vsT3t6C5vY/YfjzpmdA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OQ1u5HEM; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1742903828; x=1743163028;
	bh=plqB4STdtbnS+5Ca9rypCcPrWoObRt1eRhm7vBhyeac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OQ1u5HEMCzPLzsdQ1wInuZl0L76UFr3nDWBfQqLaGuFke6zyeAK8IMenOEFrPFv4P
	 U1CiFmgtZW2T5YyRmUcxZUc82bam7fAzGrx9qvfRGjQ7ZUQSS94qLOqUi75iAufmjN
	 LV3mzctjH53G/9nO+HqeFjyJrEzBH4Oymu65RdfPvwo9cTB1djdMqoq0+qm2PowT+2
	 MXSCimEeMJl0nowsupXXKfhGlUSr+mjSpTefFbLIQa5zpUXjkkI/9nSXjkpfJubOtI
	 QDJRkuepWgp/gcti6dNex8FKOPzw8P+SzEOrFmRK5Xuz1mwx7UsufRXNDAsB5Gu4OQ
	 ALnUEOmwaQ+gQ==
Date: Tue, 25 Mar 2025 11:57:01 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Subject: [PATCH v9 2/5] rust: Rename AlwaysRefCounted to RefCounted
Message-ID: <20250325-unique-ref-v9-2-e91618c1de26@pm.me>
In-Reply-To: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
References: <20250325-unique-ref-v9-0-e91618c1de26@pm.me>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 52e1f0a16bef519039adc580640563f32e61c020
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

AlwaysRefCounted will become a marker trait to indicate that it is allowed
to obtain an ARef from a `&`, which cannot be allowed for types which are
also Ownable.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Suggested-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/block/mq/request.rs | 10 +++++++---
 rust/kernel/cred.rs             |  8 ++++++--
 rust/kernel/device.rs           |  8 ++++++--
 rust/kernel/fs/file.rs          | 10 +++++++---
 rust/kernel/pid_namespace.rs    |  8 ++++++--
 rust/kernel/task.rs             |  6 +++++-
 rust/kernel/types.rs            | 41 ++++++++++++++++++++++++-------------=
----
 7 files changed, 61 insertions(+), 30 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request=
.rs
index 7943f43b957532749f5a95eee5546bf4f2b6cc5a..f47a13de1e073d564ae224d2e0d=
5cfb875f04da6 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,7 +8,7 @@
     bindings,
     block::mq::Operations,
     error::Result,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::{ARef, AlwaysRefCounted, Opaque, RefCounted},
 };
 use core::{
     marker::PhantomData,
@@ -227,10 +227,10 @@ fn atomic_relaxed_op_unless(target: &AtomicU64, op: i=
mpl Fn(u64) -> u64, pred: u
 }
=20
 // SAFETY: All instances of `Request<T>` are reference counted. This
-// implementation of `AlwaysRefCounted` ensure that increments to the ref =
count
+// implementation of `RefCounted` ensure that increments to the ref count
 // keeps the object alive in memory at least until a matching reference co=
unt
 // decrement is executed.
-unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+unsafe impl<T: Operations> RefCounted for Request<T> {
     fn inc_ref(&self) {
         let refcount =3D &self.wrapper_ref().refcount();
=20
@@ -260,3 +260,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         }
     }
 }
+
+// SAFETY: We currently do not implement `Ownable`, thus it is okay to can=
 obtain an `ARef<Request>`
+// from a `&Request` (but this will change in the future).
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 81d67789b16f243e7832ff3b2e5e479a1ab2bf9e..e04d1021130eb1ec46fe48feb08=
8959da7656d66 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -11,7 +11,7 @@
 use crate::{
     bindings,
     task::Kuid,
-    types::{AlwaysRefCounted, Opaque},
+    types::{AlwaysRefCounted, Opaque, RefCounted},
 };
=20
 /// Wraps the kernel's `struct cred`.
@@ -71,7 +71,7 @@ pub fn euid(&self) -> Kuid {
 }
=20
 // SAFETY: The type invariants guarantee that `Credential` is always ref-c=
ounted.
-unsafe impl AlwaysRefCounted for Credential {
+unsafe impl RefCounted for Credential {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
         unsafe { bindings::get_cred(self.0.get()) };
@@ -83,3 +83,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
     }
 }
+
+// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an=
 `ARef<Credential>` from a
+// `&Credential`.
+unsafe impl AlwaysRefCounted for Credential {}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47d9c492bc813ce3eb2ff29703ca31..189298518dc184405b1d62404b1=
90d4c0b08b7ad 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -7,7 +7,7 @@
 use crate::{
     bindings,
     str::CStr,
-    types::{ARef, Opaque},
+    types::{ARef, AlwaysRefCounted, Opaque, RefCounted},
 };
 use core::{fmt, ptr};
=20
@@ -190,7 +190,7 @@ pub fn property_present(&self, name: &CStr) -> bool {
 }
=20
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the=
 refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -202,6 +202,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an=
 `Device<Task>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 // SAFETY: As by the type invariant `Device` can be sent to any thread.
 unsafe impl Send for Device {}
=20
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index e03dbe14d62a566349c4100f2f78b17d4c79aab5..a7836cc754e7927b6addc3bd06c=
fe8c8119f1d9f 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,7 +11,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque, RefCounted},
 };
 use core::ptr;
=20
@@ -190,7 +190,7 @@ unsafe impl Sync for File {}
=20
 // SAFETY: The type invariants guarantee that `File` is always ref-counted=
. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for File {
+unsafe impl RefCounted for File {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -205,6 +205,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an=
 `ARef<File>` from a
+/// `&File`.
+unsafe impl AlwaysRefCounted for File {}
+
 /// Wraps the kernel's `struct file`. Not thread safe.
 ///
 /// This type represents a file that is not known to be safe to transfer a=
cross thread boundaries.
@@ -225,7 +229,7 @@ pub struct LocalFile {
=20
 // SAFETY: The type invariants guarantee that `LocalFile` is always ref-co=
unted. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for LocalFile {
+unsafe impl RefCounted for LocalFile {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 0e93808e4639b37dd77add5d79f64058dac7cb87..3e45e945b7509b9607266b2e0e6=
ef130e7a1ed39 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -9,7 +9,7 @@
=20
 use crate::{
     bindings,
-    types::{AlwaysRefCounted, Opaque},
+    types::{AlwaysRefCounted, RefCounted, Opaque},
 };
 use core::ptr;
=20
@@ -44,7 +44,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_name=
space) -> &'a Self {
 }
=20
 // SAFETY: Instances of `PidNamespace` are always reference-counted.
-unsafe impl AlwaysRefCounted for PidNamespace {
+unsafe impl RefCounted for PidNamespace {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
@@ -58,6 +58,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an=
 `ARef<PidNamespace>`
+// from a `&PidNamespace`.
+unsafe impl AlwaysRefCounted for PidNamespace {}
+
 // SAFETY:
 // - `PidNamespace::dec_ref` can be called from any thread.
 // - It is okay to send ownership of `PidNamespace` across thread boundari=
es.
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 38da555a2bdbb71d698c671ad1a7a337e50c6600..5bdc0a348e6d549d66b002aa6b8=
92b61ce31214a 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -327,7 +327,7 @@ pub fn wake_up(&self) {
 }
=20
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::types::AlwaysRefCounted for Task {
+unsafe impl crate::types::RefCounted for Task {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refc=
ount is nonzero.
         unsafe { bindings::get_task_struct(self.as_ptr()) };
@@ -339,6 +339,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
=20
+// SAFETY: We do not implement `Ownable`, thus it is okay to can obtain an=
 `ARef<Task>` from a
+// `&Task`.
+unsafe impl crate::types::AlwaysRefCounted for Task {}
+
 impl Kuid {
     /// Get the current euid.
     #[inline]
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2cddbd3a2873b601419f7628c386431a63cb9692..c8b78bcad259132808cc38c56b9=
f2bd525a0b755 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -388,11 +388,9 @@ pub const fn raw_get(this: *const Self) -> *mut T {
     }
 }
=20
-/// Types that are _always_ reference counted.
+/// Types that are internally reference counted.
 ///
 /// It allows such types to define their own custom ref increment and decr=
ement functions.
-/// Additionally, it allows users to convert from a shared reference `&T` =
to an owned reference
-/// [`ARef<T>`].
 ///
 /// This is usually implemented by wrappers to existing structures on the =
C side of the code. For
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to c=
reate reference-counted
@@ -404,9 +402,8 @@ pub const fn raw_get(this: *const Self) -> *mut T {
 /// at least until matching decrements are performed.
 ///
 /// Implementers must also ensure that all instances are reference-counted=
. (Otherwise they
-/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_r=
ef`] keep the object
-/// alive.)
-pub unsafe trait AlwaysRefCounted {
+/// won't be able to honour the requirement that [`RefCounted::inc_ref`] k=
eep the object alive.)
+pub unsafe trait RefCounted {
     /// Increments the reference count on the object.
     fn inc_ref(&self);
=20
@@ -419,11 +416,21 @@ pub unsafe trait AlwaysRefCounted {
     /// Callers must ensure that there was a previous matching increment t=
o the reference count,
     /// and that the object is no longer used after its reference count is=
 decremented (as it may
     /// result in the object being freed), unless the caller owns another =
increment on the refcount
-    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
-    /// [`AlwaysRefCounted::dec_ref`] once).
+    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls [`RefCou=
nted::dec_ref`] once).
     unsafe fn dec_ref(obj: NonNull<Self>);
 }
=20
+/// An extension to RefCounted, which declares that it is allowed to conve=
rt
+/// from a shared reference `&T` to an owned reference [`ARef<T>`].
+///
+/// # Safety
+///
+/// Implementers must ensure that no safety invariants are violated by upg=
rading an `&T`
+/// to an [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and=
 [`Ownable`]
+/// cannot be implemented for the same type, as this would allow to violat=
e the uniqueness
+/// guarantee of [`Owned<T>`] by derefencing it into an `&T` and obtaining=
 an [`ARef`] from that.
+pub unsafe trait AlwaysRefCounted: RefCounted {}
+
 /// An owned reference to an always-reference-counted object.
 ///
 /// The object's reference count is automatically decremented when an inst=
ance of [`ARef`] is
@@ -434,7 +441,7 @@ pub unsafe trait AlwaysRefCounted {
 ///
 /// The pointer stored in `ptr` is non-null and valid for the lifetime of =
the [`ARef`] instance. In
 /// particular, the [`ARef`] instance owns an increment on the underlying =
object's reference count.
-pub struct ARef<T: AlwaysRefCounted> {
+pub struct ARef<T: RefCounted> {
     ptr: NonNull<T>,
     _p: PhantomData<T>,
 }
@@ -443,16 +450,16 @@ pub struct ARef<T: AlwaysRefCounted> {
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`)=
; additionally, it needs
 // `T` to be `Send` because any thread that has an `ARef<T>` may ultimatel=
y access `T` using a
 // mutable reference, for example, when the reference count reaches zero a=
nd `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
=20
 // SAFETY: It is safe to send `&ARef<T>` to another thread when the underl=
ying `T` is `Sync`
 // because it effectively means sharing `&T` (which is safe because `T` is=
 `Sync`); additionally,
 // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may =
clone it and get an
 // `ARef<T>` on that thread, so the thread may ultimately access `T` using=
 a mutable reference, for
 // example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
=20
-impl<T: AlwaysRefCounted> ARef<T> {
+impl<T: RefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///
     /// It takes over an increment of the reference count on the underlyin=
g object.
@@ -481,12 +488,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// ```
     /// use core::ptr::NonNull;
-    /// use kernel::types::{ARef, AlwaysRefCounted};
+    /// use kernel::types::{ARef, RefCounted};
     ///
     /// struct Empty {}
     ///
     /// # // SAFETY: TODO.
-    /// unsafe impl AlwaysRefCounted for Empty {
+    /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
     /// }
@@ -504,7 +511,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
     }
 }
=20
-impl<T: AlwaysRefCounted> Clone for ARef<T> {
+impl<T: RefCounted> Clone for ARef<T> {
     fn clone(&self) -> Self {
         self.inc_ref();
         // SAFETY: We just incremented the refcount above.
@@ -512,7 +519,7 @@ fn clone(&self) -> Self {
     }
 }
=20
-impl<T: AlwaysRefCounted> Deref for ARef<T> {
+impl<T: RefCounted> Deref for ARef<T> {
     type Target =3D T;
=20
     fn deref(&self) -> &Self::Target {
@@ -529,7 +536,7 @@ fn from(b: &T) -> Self {
     }
 }
=20
-impl<T: AlwaysRefCounted> Drop for ARef<T> {
+impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the =
reference we're about to
         // decrement.

--=20
2.49.0



