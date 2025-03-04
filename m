Return-Path: <linux-kernel+bounces-545730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7983A4F0C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B587A9D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA527817D;
	Tue,  4 Mar 2025 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PtGOrsmm"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DB278170
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128856; cv=none; b=VktG0jM9m7AZWaMdCVumeXbiKhn2ekSdbo5MstF7W7hquwkyx1ZJEOjvJGn+w/xHlafsftHdv0MayvoxHmVPBMBgZO9mBQAbery9QqqmtZoFvmcJOpvOPL6fBAPu/QfwSYUPS92QJVNGCzJGS8rH1Fs5rFZop1gbLjVL03c2eW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128856; c=relaxed/simple;
	bh=G67IBuXuH2U3Dv/2DQYj4uAqt2L9tSIPAivcUrz1r40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa3LMphY05vqKZFZ8U7SVcXZYYJAa6bTwV2Ge6EaBiiext+7QYyUpJwydSkBkuiSR1E+TWghZLDJAro+GcET9Ef5aCBi41lP/Zn9WqYJrOgQUYrbBchIT0ZHjPAAR3V/xHixi5mF9bbJgAW6grDHn6GRCqqmOExz4GGnNs6GybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PtGOrsmm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128848; x=1741388048;
	bh=lDlW9NulOJORexsTW3WyG8fZI+eFSz6GL4t/is6yj8k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PtGOrsmmeF3PblUCOpuGcPzYuzDPPHKQknp+nxhKoAXQITyoIN1P+GFTGR7QhUyav
	 wXgiwTAgk6lBtsWYTXPnZd3WnU6ER8UXXhuFRtqLaEHAh92WRLYXC+VNyNT+nIPyOh
	 3d6h3RGtv4bDp+jpp+FYHegQt/deNPbMwOjWH2wYsRIDUg/YJzZbee12iI0oJrhGI/
	 7JJGB10DDvHQ3fjVNTU623wNVGaRRBh0nl2TCIEqbP6fcemKPy6wjA9eaqg3gOWmNH
	 hHhllGzAoMGrruGvaXAaTK2CK1dqncrFWQCrLo2PjaByEJPew51qa0XsNbR3TymYSh
	 0ursXlOANuCAg==
Date: Tue, 04 Mar 2025 22:53:46 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 05/22] rust: pin-init: change examples to the user-space version
Message-ID: <20250304225245.2033120-6-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6437250b940604fb0a30091c092caf9ce86ef90a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace the examples in the documentation by the ones from the
user-space version and introduce the standalone examples from the
user-space version such as the `CMutex<T>` type.

The `CMutex<T>` example from the pinned-init repository [1] is used in
several documentation examples in the user-space version instead of the
kernel `Mutex<T>` type (as it's not available). In order to split off
the pin-init crate, all examples need to be free of kernel-specific
types.

Link: https://github.com/rust-for-Linux/pinned-init [1]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/examples/big_struct_in_place.rs |  39 ++
 rust/pin-init/examples/error.rs               |  27 ++
 rust/pin-init/examples/linked_list.rs         | 161 ++++++++
 rust/pin-init/examples/mutex.rs               | 209 ++++++++++
 rust/pin-init/examples/pthread_mutex.rs       | 178 +++++++++
 rust/pin-init/examples/static_init.rs         | 122 ++++++
 rust/pin-init/src/lib.rs                      | 365 +++++++++---------
 7 files changed, 915 insertions(+), 186 deletions(-)
 create mode 100644 rust/pin-init/examples/big_struct_in_place.rs
 create mode 100644 rust/pin-init/examples/error.rs
 create mode 100644 rust/pin-init/examples/linked_list.rs
 create mode 100644 rust/pin-init/examples/mutex.rs
 create mode 100644 rust/pin-init/examples/pthread_mutex.rs
 create mode 100644 rust/pin-init/examples/static_init.rs

diff --git a/rust/pin-init/examples/big_struct_in_place.rs b/rust/pin-init/=
examples/big_struct_in_place.rs
new file mode 100644
index 000000000000..30d44a334ffd
--- /dev/null
+++ b/rust/pin-init/examples/big_struct_in_place.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use pin_init::*;
+
+// Struct with size over 1GiB
+#[derive(Debug)]
+pub struct BigStruct {
+    buf: [u8; 1024 * 1024 * 1024],
+    a: u64,
+    b: u64,
+    c: u64,
+    d: u64,
+    managed_buf: ManagedBuf,
+}
+
+#[derive(Debug)]
+pub struct ManagedBuf {
+    buf: [u8; 1024 * 1024],
+}
+
+impl ManagedBuf {
+    pub fn new() -> impl Init<Self> {
+        init!(ManagedBuf { buf <- zeroed() })
+    }
+}
+
+fn main() {
+    // we want to initialize the struct in-place, otherwise we would get a=
 stackoverflow
+    let buf: Box<BigStruct> =3D Box::init(init!(BigStruct {
+        buf <- zeroed(),
+        a: 7,
+        b: 186,
+        c: 7789,
+        d: 34,
+        managed_buf <- ManagedBuf::new(),
+    }))
+    .unwrap();
+    println!("{}", core::mem::size_of_val(&*buf));
+}
diff --git a/rust/pin-init/examples/error.rs b/rust/pin-init/examples/error=
.rs
new file mode 100644
index 000000000000..e0cc258746ce
--- /dev/null
+++ b/rust/pin-init/examples/error.rs
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+#![cfg_attr(feature =3D "alloc", feature(allocator_api))]
+
+use core::convert::Infallible;
+
+#[cfg(feature =3D "alloc")]
+use std::alloc::AllocError;
+
+#[derive(Debug)]
+pub struct Error;
+
+impl From<Infallible> for Error {
+    fn from(e: Infallible) -> Self {
+        match e {}
+    }
+}
+
+#[cfg(feature =3D "alloc")]
+impl From<AllocError> for Error {
+    fn from(_: AllocError) -> Self {
+        Self
+    }
+}
+
+#[allow(dead_code)]
+fn main() {}
diff --git a/rust/pin-init/examples/linked_list.rs b/rust/pin-init/examples=
/linked_list.rs
new file mode 100644
index 000000000000..6d7eb0a0ec0d
--- /dev/null
+++ b/rust/pin-init/examples/linked_list.rs
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+#![allow(clippy::undocumented_unsafe_blocks)]
+#![cfg_attr(feature =3D "alloc", feature(allocator_api))]
+
+use core::{
+    cell::Cell,
+    convert::Infallible,
+    marker::PhantomPinned,
+    pin::Pin,
+    ptr::{self, NonNull},
+};
+
+use pin_init::*;
+
+#[expect(unused_attributes)]
+mod error;
+use error::Error;
+
+#[pin_data(PinnedDrop)]
+#[repr(C)]
+#[derive(Debug)]
+pub struct ListHead {
+    next: Link,
+    prev: Link,
+    #[pin]
+    pin: PhantomPinned,
+}
+
+impl ListHead {
+    #[inline]
+    pub fn new() -> impl PinInit<Self, Infallible> {
+        try_pin_init!(&this in Self {
+            next: unsafe { Link::new_unchecked(this) },
+            prev: unsafe { Link::new_unchecked(this) },
+            pin: PhantomPinned,
+        }? Infallible)
+    }
+
+    #[inline]
+    pub fn insert_next(list: &ListHead) -> impl PinInit<Self, Infallible> =
+ '_ {
+        try_pin_init!(&this in Self {
+            prev: list.next.prev().replace(unsafe { Link::new_unchecked(th=
is)}),
+            next: list.next.replace(unsafe { Link::new_unchecked(this)}),
+            pin: PhantomPinned,
+        }? Infallible)
+    }
+
+    #[inline]
+    pub fn insert_prev(list: &ListHead) -> impl PinInit<Self, Infallible> =
+ '_ {
+        try_pin_init!(&this in Self {
+            next: list.prev.next().replace(unsafe { Link::new_unchecked(th=
is)}),
+            prev: list.prev.replace(unsafe { Link::new_unchecked(this)}),
+            pin: PhantomPinned,
+        }? Infallible)
+    }
+
+    #[inline]
+    pub fn next(&self) -> Option<NonNull<Self>> {
+        if ptr::eq(self.next.as_ptr(), self) {
+            None
+        } else {
+            Some(unsafe { NonNull::new_unchecked(self.next.as_ptr() as *mu=
t Self) })
+        }
+    }
+
+    #[allow(dead_code)]
+    pub fn size(&self) -> usize {
+        let mut size =3D 1;
+        let mut cur =3D self.next.clone();
+        while !ptr::eq(self, cur.cur()) {
+            cur =3D cur.next().clone();
+            size +=3D 1;
+        }
+        size
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for ListHead {
+    //#[inline]
+    fn drop(self: Pin<&mut Self>) {
+        if !ptr::eq(self.next.as_ptr(), &*self) {
+            let next =3D unsafe { &*self.next.as_ptr() };
+            let prev =3D unsafe { &*self.prev.as_ptr() };
+            next.prev.set(&self.prev);
+            prev.next.set(&self.next);
+        }
+    }
+}
+
+#[repr(transparent)]
+#[derive(Clone, Debug)]
+struct Link(Cell<NonNull<ListHead>>);
+
+impl Link {
+    /// # Safety
+    ///
+    /// The contents of the pointer should form a consistent circular
+    /// linked list; for example, a "next" link should be pointed back
+    /// by the target `ListHead`'s "prev" link and a "prev" link should be
+    /// pointed back by the target `ListHead`'s "next" link.
+    #[inline]
+    unsafe fn new_unchecked(ptr: NonNull<ListHead>) -> Self {
+        Self(Cell::new(ptr))
+    }
+
+    #[inline]
+    fn next(&self) -> &Link {
+        unsafe { &(*self.0.get().as_ptr()).next }
+    }
+
+    #[inline]
+    fn prev(&self) -> &Link {
+        unsafe { &(*self.0.get().as_ptr()).prev }
+    }
+
+    #[allow(dead_code)]
+    fn cur(&self) -> &ListHead {
+        unsafe { &*self.0.get().as_ptr() }
+    }
+
+    #[inline]
+    fn replace(&self, other: Link) -> Link {
+        unsafe { Link::new_unchecked(self.0.replace(other.0.get())) }
+    }
+
+    #[inline]
+    fn as_ptr(&self) -> *const ListHead {
+        self.0.get().as_ptr()
+    }
+
+    #[inline]
+    fn set(&self, val: &Link) {
+        self.0.set(val.0.get());
+    }
+}
+
+#[allow(dead_code)]
+#[cfg_attr(test, test)]
+fn main() -> Result<(), Error> {
+    let a =3D Box::pin_init(ListHead::new())?;
+    stack_pin_init!(let b =3D ListHead::insert_next(&a));
+    stack_pin_init!(let c =3D ListHead::insert_next(&a));
+    stack_pin_init!(let d =3D ListHead::insert_next(&b));
+    let e =3D Box::pin_init(ListHead::insert_next(&b))?;
+    println!("a ({a:p}): {a:?}");
+    println!("b ({b:p}): {b:?}");
+    println!("c ({c:p}): {c:?}");
+    println!("d ({d:p}): {d:?}");
+    println!("e ({e:p}): {e:?}");
+    let mut inspect =3D &*a;
+    while let Some(next) =3D inspect.next() {
+        println!("({inspect:p}): {inspect:?}");
+        inspect =3D unsafe { &*next.as_ptr() };
+        if core::ptr::eq(inspect, &*a) {
+            break;
+        }
+    }
+    Ok(())
+}
diff --git a/rust/pin-init/examples/mutex.rs b/rust/pin-init/examples/mutex=
.rs
new file mode 100644
index 000000000000..073bb79341d1
--- /dev/null
+++ b/rust/pin-init/examples/mutex.rs
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+#![allow(clippy::undocumented_unsafe_blocks)]
+#![cfg_attr(feature =3D "alloc", feature(allocator_api))]
+#![allow(clippy::missing_safety_doc)]
+
+use core::{
+    cell::{Cell, UnsafeCell},
+    marker::PhantomPinned,
+    ops::{Deref, DerefMut},
+    pin::Pin,
+    sync::atomic::{AtomicBool, Ordering},
+};
+use std::{
+    sync::Arc,
+    thread::{self, park, sleep, Builder, Thread},
+    time::Duration,
+};
+
+use pin_init::*;
+#[expect(unused_attributes)]
+#[path =3D "./linked_list.rs"]
+pub mod linked_list;
+use linked_list::*;
+
+pub struct SpinLock {
+    inner: AtomicBool,
+}
+
+impl SpinLock {
+    #[inline]
+    pub fn acquire(&self) -> SpinLockGuard<'_> {
+        while self
+            .inner
+            .compare_exchange(false, true, Ordering::Acquire, Ordering::Re=
laxed)
+            .is_err()
+        {
+            while self.inner.load(Ordering::Relaxed) {
+                thread::yield_now();
+            }
+        }
+        SpinLockGuard(self)
+    }
+
+    #[inline]
+    #[allow(clippy::new_without_default)]
+    pub const fn new() -> Self {
+        Self {
+            inner: AtomicBool::new(false),
+        }
+    }
+}
+
+pub struct SpinLockGuard<'a>(&'a SpinLock);
+
+impl Drop for SpinLockGuard<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        self.0.inner.store(false, Ordering::Release);
+    }
+}
+
+#[pin_data]
+pub struct CMutex<T> {
+    #[pin]
+    wait_list: ListHead,
+    spin_lock: SpinLock,
+    locked: Cell<bool>,
+    #[pin]
+    data: UnsafeCell<T>,
+}
+
+impl<T> CMutex<T> {
+    #[inline]
+    pub fn new(val: impl PinInit<T>) -> impl PinInit<Self> {
+        pin_init!(CMutex {
+            wait_list <- ListHead::new(),
+            spin_lock: SpinLock::new(),
+            locked: Cell::new(false),
+            data <- unsafe {
+                pin_init_from_closure(|slot: *mut UnsafeCell<T>| {
+                    val.__pinned_init(slot.cast::<T>())
+                })
+            },
+        })
+    }
+
+    #[inline]
+    pub fn lock(&self) -> Pin<CMutexGuard<'_, T>> {
+        let mut sguard =3D self.spin_lock.acquire();
+        if self.locked.get() {
+            stack_pin_init!(let wait_entry =3D WaitEntry::insert_new(&self=
.wait_list));
+            // println!("wait list length: {}", self.wait_list.size());
+            while self.locked.get() {
+                drop(sguard);
+                park();
+                sguard =3D self.spin_lock.acquire();
+            }
+            // This does have an effect, as the ListHead inside wait_entry=
 implements Drop!
+            #[expect(clippy::drop_non_drop)]
+            drop(wait_entry);
+        }
+        self.locked.set(true);
+        unsafe {
+            Pin::new_unchecked(CMutexGuard {
+                mtx: self,
+                _pin: PhantomPinned,
+            })
+        }
+    }
+
+    #[allow(dead_code)]
+    pub fn get_data_mut(self: Pin<&mut Self>) -> &mut T {
+        // SAFETY: we have an exclusive reference and thus nobody has acce=
ss to data.
+        unsafe { &mut *self.data.get() }
+    }
+}
+
+unsafe impl<T: Send> Send for CMutex<T> {}
+unsafe impl<T: Send> Sync for CMutex<T> {}
+
+pub struct CMutexGuard<'a, T> {
+    mtx: &'a CMutex<T>,
+    _pin: PhantomPinned,
+}
+
+impl<T> Drop for CMutexGuard<'_, T> {
+    #[inline]
+    fn drop(&mut self) {
+        let sguard =3D self.mtx.spin_lock.acquire();
+        self.mtx.locked.set(false);
+        if let Some(list_field) =3D self.mtx.wait_list.next() {
+            let wait_entry =3D list_field.as_ptr().cast::<WaitEntry>();
+            unsafe { (*wait_entry).thread.unpark() };
+        }
+        drop(sguard);
+    }
+}
+
+impl<T> Deref for CMutexGuard<'_, T> {
+    type Target =3D T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        unsafe { &*self.mtx.data.get() }
+    }
+}
+
+impl<T> DerefMut for CMutexGuard<'_, T> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        unsafe { &mut *self.mtx.data.get() }
+    }
+}
+
+#[pin_data]
+#[repr(C)]
+struct WaitEntry {
+    #[pin]
+    wait_list: ListHead,
+    thread: Thread,
+}
+
+impl WaitEntry {
+    #[inline]
+    fn insert_new(list: &ListHead) -> impl PinInit<Self> + '_ {
+        pin_init!(Self {
+            thread: thread::current(),
+            wait_list <- ListHead::insert_prev(list),
+        })
+    }
+}
+
+#[cfg(not(any(feature =3D "std", feature =3D "alloc")))]
+fn main() {}
+
+#[allow(dead_code)]
+#[cfg_attr(test, test)]
+#[cfg(any(feature =3D "std", feature =3D "alloc"))]
+fn main() {
+    let mtx: Pin<Arc<CMutex<usize>>> =3D Arc::pin_init(CMutex::new(0)).unw=
rap();
+    let mut handles =3D vec![];
+    let thread_count =3D 20;
+    let workload =3D if cfg!(miri) { 100 } else { 1_000 };
+    for i in 0..thread_count {
+        let mtx =3D mtx.clone();
+        handles.push(
+            Builder::new()
+                .name(format!("worker #{i}"))
+                .spawn(move || {
+                    for _ in 0..workload {
+                        *mtx.lock() +=3D 1;
+                    }
+                    println!("{i} halfway");
+                    sleep(Duration::from_millis((i as u64) * 10));
+                    for _ in 0..workload {
+                        *mtx.lock() +=3D 1;
+                    }
+                    println!("{i} finished");
+                })
+                .expect("should not fail"),
+        );
+    }
+    for h in handles {
+        h.join().expect("thread panicked");
+    }
+    println!("{:?}", &*mtx.lock());
+    assert_eq!(*mtx.lock(), workload * thread_count * 2);
+}
diff --git a/rust/pin-init/examples/pthread_mutex.rs b/rust/pin-init/exampl=
es/pthread_mutex.rs
new file mode 100644
index 000000000000..9164298c44c0
--- /dev/null
+++ b/rust/pin-init/examples/pthread_mutex.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+// inspired by https://github.com/nbdd0121/pin-init/blob/trunk/examples/pt=
hread_mutex.rs
+#![allow(clippy::undocumented_unsafe_blocks)]
+#![cfg_attr(feature =3D "alloc", feature(allocator_api))]
+#[cfg(not(windows))]
+mod pthread_mtx {
+    #[cfg(feature =3D "alloc")]
+    use core::alloc::AllocError;
+    use core::{
+        cell::UnsafeCell,
+        marker::PhantomPinned,
+        mem::MaybeUninit,
+        ops::{Deref, DerefMut},
+        pin::Pin,
+    };
+    use pin_init::*;
+    use std::convert::Infallible;
+
+    #[pin_data(PinnedDrop)]
+    pub struct PThreadMutex<T> {
+        #[pin]
+        raw: UnsafeCell<libc::pthread_mutex_t>,
+        data: UnsafeCell<T>,
+        #[pin]
+        pin: PhantomPinned,
+    }
+
+    unsafe impl<T: Send> Send for PThreadMutex<T> {}
+    unsafe impl<T: Send> Sync for PThreadMutex<T> {}
+
+    #[pinned_drop]
+    impl<T> PinnedDrop for PThreadMutex<T> {
+        fn drop(self: Pin<&mut Self>) {
+            unsafe {
+                libc::pthread_mutex_destroy(self.raw.get());
+            }
+        }
+    }
+
+    #[derive(Debug)]
+    pub enum Error {
+        #[expect(dead_code)]
+        IO(std::io::Error),
+        Alloc,
+    }
+
+    impl From<Infallible> for Error {
+        fn from(e: Infallible) -> Self {
+            match e {}
+        }
+    }
+
+    #[cfg(feature =3D "alloc")]
+    impl From<AllocError> for Error {
+        fn from(_: AllocError) -> Self {
+            Self::Alloc
+        }
+    }
+
+    impl<T> PThreadMutex<T> {
+        pub fn new(data: T) -> impl PinInit<Self, Error> {
+            fn init_raw() -> impl PinInit<UnsafeCell<libc::pthread_mutex_t=
>, Error> {
+                let init =3D |slot: *mut UnsafeCell<libc::pthread_mutex_t>=
| {
+                    // we can cast, because `UnsafeCell` has the same layo=
ut as T.
+                    let slot: *mut libc::pthread_mutex_t =3D slot.cast();
+                    let mut attr =3D MaybeUninit::uninit();
+                    let attr =3D attr.as_mut_ptr();
+                    // SAFETY: ptr is valid
+                    let ret =3D unsafe { libc::pthread_mutexattr_init(attr=
) };
+                    if ret !=3D 0 {
+                        return Err(Error::IO(std::io::Error::from_raw_os_e=
rror(ret)));
+                    }
+                    // SAFETY: attr is initialized
+                    let ret =3D unsafe {
+                        libc::pthread_mutexattr_settype(attr, libc::PTHREA=
D_MUTEX_NORMAL)
+                    };
+                    if ret !=3D 0 {
+                        // SAFETY: attr is initialized
+                        unsafe { libc::pthread_mutexattr_destroy(attr) };
+                        return Err(Error::IO(std::io::Error::from_raw_os_e=
rror(ret)));
+                    }
+                    // SAFETY: slot is valid
+                    unsafe { slot.write(libc::PTHREAD_MUTEX_INITIALIZER) }=
;
+                    // SAFETY: attr and slot are valid ptrs and attr is in=
itialized
+                    let ret =3D unsafe { libc::pthread_mutex_init(slot, at=
tr) };
+                    // SAFETY: attr was initialized
+                    unsafe { libc::pthread_mutexattr_destroy(attr) };
+                    if ret !=3D 0 {
+                        return Err(Error::IO(std::io::Error::from_raw_os_e=
rror(ret)));
+                    }
+                    Ok(())
+                };
+                // SAFETY: mutex has been initialized
+                unsafe { pin_init_from_closure(init) }
+            }
+            try_pin_init!(Self {
+            data: UnsafeCell::new(data),
+            raw <- init_raw(),
+            pin: PhantomPinned,
+        }? Error)
+        }
+
+        pub fn lock(&self) -> PThreadMutexGuard<'_, T> {
+            // SAFETY: raw is always initialized
+            unsafe { libc::pthread_mutex_lock(self.raw.get()) };
+            PThreadMutexGuard { mtx: self }
+        }
+    }
+
+    pub struct PThreadMutexGuard<'a, T> {
+        mtx: &'a PThreadMutex<T>,
+    }
+
+    impl<T> Drop for PThreadMutexGuard<'_, T> {
+        fn drop(&mut self) {
+            // SAFETY: raw is always initialized
+            unsafe { libc::pthread_mutex_unlock(self.mtx.raw.get()) };
+        }
+    }
+
+    impl<T> Deref for PThreadMutexGuard<'_, T> {
+        type Target =3D T;
+
+        fn deref(&self) -> &Self::Target {
+            unsafe { &*self.mtx.data.get() }
+        }
+    }
+
+    impl<T> DerefMut for PThreadMutexGuard<'_, T> {
+        fn deref_mut(&mut self) -> &mut Self::Target {
+            unsafe { &mut *self.mtx.data.get() }
+        }
+    }
+}
+
+#[cfg_attr(test, test)]
+fn main() {
+    #[cfg(all(any(feature =3D "std", feature =3D "alloc"), not(windows)))]
+    {
+        use core::pin::Pin;
+        use pin_init::*;
+        use pthread_mtx::*;
+        use std::{
+            sync::Arc,
+            thread::{sleep, Builder},
+            time::Duration,
+        };
+        let mtx: Pin<Arc<PThreadMutex<usize>>> =3D Arc::try_pin_init(PThre=
adMutex::new(0)).unwrap();
+        let mut handles =3D vec![];
+        let thread_count =3D 20;
+        let workload =3D 1_000_000;
+        for i in 0..thread_count {
+            let mtx =3D mtx.clone();
+            handles.push(
+                Builder::new()
+                    .name(format!("worker #{i}"))
+                    .spawn(move || {
+                        for _ in 0..workload {
+                            *mtx.lock() +=3D 1;
+                        }
+                        println!("{i} halfway");
+                        sleep(Duration::from_millis((i as u64) * 10));
+                        for _ in 0..workload {
+                            *mtx.lock() +=3D 1;
+                        }
+                        println!("{i} finished");
+                    })
+                    .expect("should not fail"),
+            );
+        }
+        for h in handles {
+            h.join().expect("thread panicked");
+        }
+        println!("{:?}", &*mtx.lock());
+        assert_eq!(*mtx.lock(), workload * thread_count * 2);
+    }
+}
diff --git a/rust/pin-init/examples/static_init.rs b/rust/pin-init/examples=
/static_init.rs
new file mode 100644
index 000000000000..3487d761aa26
--- /dev/null
+++ b/rust/pin-init/examples/static_init.rs
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+#![allow(clippy::undocumented_unsafe_blocks)]
+#![cfg_attr(feature =3D "alloc", feature(allocator_api))]
+
+use core::{
+    cell::{Cell, UnsafeCell},
+    mem::MaybeUninit,
+    ops,
+    pin::Pin,
+    time::Duration,
+};
+use pin_init::*;
+use std::{
+    sync::Arc,
+    thread::{sleep, Builder},
+};
+
+#[expect(unused_attributes)]
+mod mutex;
+use mutex::*;
+
+pub struct StaticInit<T, I> {
+    cell: UnsafeCell<MaybeUninit<T>>,
+    init: Cell<Option<I>>,
+    lock: SpinLock,
+    present: Cell<bool>,
+}
+
+unsafe impl<T: Sync, I> Sync for StaticInit<T, I> {}
+unsafe impl<T: Send, I> Send for StaticInit<T, I> {}
+
+impl<T, I: PinInit<T>> StaticInit<T, I> {
+    pub const fn new(init: I) -> Self {
+        Self {
+            cell: UnsafeCell::new(MaybeUninit::uninit()),
+            init: Cell::new(Some(init)),
+            lock: SpinLock::new(),
+            present: Cell::new(false),
+        }
+    }
+}
+
+impl<T, I: PinInit<T>> ops::Deref for StaticInit<T, I> {
+    type Target =3D T;
+    fn deref(&self) -> &Self::Target {
+        if self.present.get() {
+            unsafe { (*self.cell.get()).assume_init_ref() }
+        } else {
+            println!("acquire spinlock on static init");
+            let _guard =3D self.lock.acquire();
+            println!("rechecking present...");
+            std::thread::sleep(std::time::Duration::from_millis(200));
+            if self.present.get() {
+                return unsafe { (*self.cell.get()).assume_init_ref() };
+            }
+            println!("doing init");
+            let ptr =3D self.cell.get().cast::<T>();
+            match self.init.take() {
+                Some(f) =3D> unsafe { f.__pinned_init(ptr).unwrap() },
+                None =3D> unsafe { core::hint::unreachable_unchecked() },
+            }
+            self.present.set(true);
+            unsafe { (*self.cell.get()).assume_init_ref() }
+        }
+    }
+}
+
+pub struct CountInit;
+
+unsafe impl PinInit<CMutex<usize>> for CountInit {
+    unsafe fn __pinned_init(
+        self,
+        slot: *mut CMutex<usize>,
+    ) -> Result<(), core::convert::Infallible> {
+        let init =3D CMutex::new(0);
+        std::thread::sleep(std::time::Duration::from_millis(1000));
+        unsafe { init.__pinned_init(slot) }
+    }
+}
+
+pub static COUNT: StaticInit<CMutex<usize>, CountInit> =3D StaticInit::new=
(CountInit);
+
+#[cfg(not(any(feature =3D "std", feature =3D "alloc")))]
+fn main() {}
+
+#[cfg(any(feature =3D "std", feature =3D "alloc"))]
+fn main() {
+    let mtx: Pin<Arc<CMutex<usize>>> =3D Arc::pin_init(CMutex::new(0)).unw=
rap();
+    let mut handles =3D vec![];
+    let thread_count =3D 20;
+    let workload =3D 1_000;
+    for i in 0..thread_count {
+        let mtx =3D mtx.clone();
+        handles.push(
+            Builder::new()
+                .name(format!("worker #{i}"))
+                .spawn(move || {
+                    for _ in 0..workload {
+                        *COUNT.lock() +=3D 1;
+                        std::thread::sleep(std::time::Duration::from_milli=
s(10));
+                        *mtx.lock() +=3D 1;
+                        std::thread::sleep(std::time::Duration::from_milli=
s(10));
+                        *COUNT.lock() +=3D 1;
+                    }
+                    println!("{i} halfway");
+                    sleep(Duration::from_millis((i as u64) * 10));
+                    for _ in 0..workload {
+                        std::thread::sleep(std::time::Duration::from_milli=
s(10));
+                        *mtx.lock() +=3D 1;
+                    }
+                    println!("{i} finished");
+                })
+                .expect("should not fail"),
+        );
+    }
+    for h in handles {
+        h.join().expect("thread panicked");
+    }
+    println!("{:?}, {:?}", &*mtx.lock(), &*COUNT.lock());
+    assert_eq!(*mtx.lock(), workload * thread_count * 2);
+}
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index df6962460874..92027e2f60f5 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -33,19 +33,23 @@
 //!
 //! ```rust,ignore
 //! # #![expect(clippy::disallowed_names)]
-//! use kernel::sync::{new_mutex, Mutex};
+//! # #![feature(allocator_api)]
+//! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 //! # use core::pin::Pin;
+//! use pin_init::*;
+//!
 //! #[pin_data]
 //! struct Foo {
 //!     #[pin]
-//!     a: Mutex<usize>,
+//!     a: CMutex<usize>,
 //!     b: u32,
 //! }
 //!
 //! let foo =3D pin_init!(Foo {
-//!     a <- new_mutex!(42, "Foo::a"),
+//!     a <- CMutex::new(42),
 //!     b: 24,
 //! });
+//! # let _ =3D Box::pin_init(foo);
 //! ```
 //!
 //! `foo` now is of the type [`impl PinInit<Foo>`]. We can now use any sma=
rt pointer that we like
@@ -53,19 +57,23 @@
 //!
 //! ```rust,ignore
 //! # #![expect(clippy::disallowed_names)]
-//! # use kernel::sync::{new_mutex, Mutex};
-//! # use core::pin::Pin;
+//! # #![feature(allocator_api)]
+//! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+//! # use core::{alloc::AllocError, pin::Pin};
+//! # use pin_init::*;
+//! #
 //! # #[pin_data]
 //! # struct Foo {
 //! #     #[pin]
-//! #     a: Mutex<usize>,
+//! #     a: CMutex<usize>,
 //! #     b: u32,
 //! # }
+//! #
 //! # let foo =3D pin_init!(Foo {
-//! #     a <- new_mutex!(42, "Foo::a"),
+//! #     a <- CMutex::new(42),
 //! #     b: 24,
 //! # });
-//! let foo: Result<Pin<KBox<Foo>>> =3D KBox::pin_init(foo, GFP_KERNEL);
+//! let foo: Result<Pin<Box<Foo>>, AllocError> =3D Box::pin_init(foo);
 //! ```
 //!
 //! For more information see the [`pin_init!`] macro.
@@ -76,28 +84,34 @@
 //! above method only works for types where you can access the fields.
 //!
 //! ```rust,ignore
-//! # use kernel::sync::{new_mutex, Arc, Mutex};
-//! let mtx: Result<Arc<Mutex<usize>>> =3D
-//!     Arc::pin_init(new_mutex!(42, "example::mtx"), GFP_KERNEL);
+//! # #![feature(allocator_api)]
+//! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+//! # use pin_init::*;
+//! # use std::sync::Arc;
+//! # use core::pin::Pin;
+//! let mtx: Result<Pin<Arc<Mutex<usize>>>, _> =3D Arc::pin_init(CMutex::n=
ew(42));
 //! ```
 //!
 //! To declare an init macro/function you just return an [`impl PinInit<T,=
 E>`]:
 //!
 //! ```rust,ignore
-//! # use kernel::{sync::Mutex, new_mutex, init::PinInit, try_pin_init};
+//! # #![feature(allocator_api)]
+//! # use pin_init::*;
+//! # #[path =3D "../examples/error.rs"] mod error; use error::Error;
+//! # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
 //! #[pin_data]
 //! struct DriverData {
 //!     #[pin]
-//!     status: Mutex<i32>,
-//!     buffer: KBox<[u8; 1_000_000]>,
+//!     status: CMutex<i32>,
+//!     buffer: Box<[u8; 1_000_000]>,
 //! }
 //!
 //! impl DriverData {
 //!     fn new() -> impl PinInit<Self, Error> {
 //!         try_pin_init!(Self {
-//!             status <- new_mutex!(0, "DriverData::status"),
-//!             buffer: KBox::init(kernel::init::zeroed(), GFP_KERNEL)?,
-//!         })
+//!             status <- CMutex::new(0),
+//!             buffer: Box::init(pin_init::zeroed())?,
+//!         }? Error)
 //!     }
 //! }
 //! ```
@@ -117,60 +131,61 @@
 //!   `slot` gets called.
 //!
 //! ```rust,ignore
-//! # #![expect(unreachable_pub, clippy::disallowed_names)]
-//! use kernel::{init, types::Opaque};
-//! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
-//! # mod bindings {
-//! #     #![expect(non_camel_case_types)]
-//! #     #![expect(clippy::missing_safety_doc)]
-//! #     pub struct foo;
-//! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
-//! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
-//! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0=
 }
-//! # }
-//! # // `Error::from_errno` is `pub(crate)` in the `kernel` crate, thus p=
rovide a workaround.
-//! # trait FromErrno {
-//! #     fn from_errno(errno: kernel::ffi::c_int) -> Error {
-//! #         // Dummy error that can be constructed outside the `kernel` =
crate.
-//! #         Error::from(core::fmt::Error)
-//! #     }
-//! # }
-//! # impl FromErrno for Error {}
+//! # #![feature(extern_types)]
+//! use pin_init::*;
+//! use core::{
+//!     ptr::addr_of_mut,
+//!     marker::PhantomPinned,
+//!     cell::UnsafeCell,
+//!     pin::Pin,
+//!     mem::MaybeUninit,
+//! };
+//! mod bindings {
+//!     extern "C" {
+//!         pub type foo;
+//!         pub fn init_foo(ptr: *mut foo);
+//!         pub fn destroy_foo(ptr: *mut foo);
+//!         #[must_use =3D "you must check the error return code"]
+//!         pub fn enable_foo(ptr: *mut foo, flags: u32) -> i32;
+//!     }
+//! }
+//!
 //! /// # Invariants
 //! ///
 //! /// `foo` is always initialized
 //! #[pin_data(PinnedDrop)]
 //! pub struct RawFoo {
 //!     #[pin]
-//!     foo: Opaque<bindings::foo>,
-//!     #[pin]
 //!     _p: PhantomPinned,
+//!     #[pin]
+//!     foo: UnsafeCell<MaybeUninit<bindings::foo>>,
 //! }
 //!
 //! impl RawFoo {
-//!     pub fn new(flags: u32) -> impl PinInit<Self, Error> {
+//!     pub fn new(flags: u32) -> impl PinInit<Self, i32> {
 //!         // SAFETY:
 //!         // - when the closure returns `Ok(())`, then it has successful=
ly initialized and
 //!         //   enabled `foo`,
 //!         // - when it returns `Err(e)`, then it has cleaned up before
 //!         unsafe {
-//!             init::pin_init_from_closure(move |slot: *mut Self| {
+//!             pin_init_from_closure(move |slot: *mut Self| {
 //!                 // `slot` contains uninit memory, avoid creating a ref=
erence.
 //!                 let foo =3D addr_of_mut!((*slot).foo);
+//!                 let foo =3D UnsafeCell::raw_get(foo).cast::<bindings::=
foo>();
 //!
 //!                 // Initialize the `foo`
-//!                 bindings::init_foo(Opaque::raw_get(foo));
+//!                 bindings::init_foo(foo);
 //!
 //!                 // Try to enable it.
-//!                 let err =3D bindings::enable_foo(Opaque::raw_get(foo),=
 flags);
+//!                 let err =3D bindings::enable_foo(foo, flags);
 //!                 if err !=3D 0 {
 //!                     // Enabling has failed, first clean up the foo and=
 then return the error.
-//!                     bindings::destroy_foo(Opaque::raw_get(foo));
-//!                     return Err(Error::from_errno(err));
+//!                     bindings::destroy_foo(foo);
+//!                     Err(err)
+//!                 } else {
+//!                     // All fields of `RawFoo` have been initialized, s=
ince `_p` is a ZST.
+//!                     Ok(())
 //!                 }
-//!
-//!                 // All fields of `RawFoo` have been initialized, since=
 `_p` is a ZST.
-//!                 Ok(())
 //!             })
 //!         }
 //!     }
@@ -180,7 +195,7 @@
 //! impl PinnedDrop for RawFoo {
 //!     fn drop(self: Pin<&mut Self>) {
 //!         // SAFETY: Since `foo` is initialized, destroying is safe.
-//!         unsafe { bindings::destroy_foo(self.foo.get()) };
+//!         unsafe { bindings::destroy_foo(self.foo.get().cast::<bindings:=
:foo>()) };
 //!     }
 //! }
 //! ```
@@ -235,35 +250,39 @@
 /// # Examples
 ///
 /// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use std::{sync::Mutex, process::Command};
-/// # use kernel::macros::pin_data;
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// use pin_init::pin_data;
+///
+/// enum Command {
+///     /* ... */
+/// }
+///
 /// #[pin_data]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
+///     queue: CMutex<Vec<Command>>,
+///     buf: Box<[u8; 1024 * 1024]>,
 /// }
 /// ```
 ///
 /// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use std::{sync::Mutex, process::Command};
-/// # use core::pin::Pin;
-/// # pub struct Info;
-/// # mod bindings {
-/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
-/// # }
-/// use kernel::macros::{pin_data, pinned_drop};
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # mod bindings { pub struct info; pub unsafe fn destroy_info(_: *mut i=
nfo) {} }
+/// use core::pin::Pin;
+/// use pin_init::{pin_data, pinned_drop, PinnedDrop};
+///
+/// enum Command {
+///     /* ... */
+/// }
 ///
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-///     raw_info: *mut Info,
+///     queue: CMutex<Vec<Command>>,
+///     buf: Box<[u8; 1024 * 1024]>,
+///     raw_info: *mut bindings::info,
 /// }
 ///
 /// #[pinned_drop]
@@ -272,7 +291,6 @@
 ///         unsafe { bindings::destroy_info(self.raw_info) };
 ///     }
 /// }
-/// # fn main() {}
 /// ```
 ///
 /// [`pin_init!`]: crate::pin_init
@@ -285,21 +303,22 @@
 /// # Examples
 ///
 /// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use macros::{pin_data, pinned_drop};
-/// # use std::{sync::Mutex, process::Command};
-/// # use core::pin::Pin;
-/// # mod bindings {
-/// #     pub struct Info;
-/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
-/// # }
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # mod bindings { pub struct info; pub unsafe fn destroy_info(_: *mut i=
nfo) {} }
+/// use core::pin::Pin;
+/// use pin_init::{pin_data, pinned_drop, PinnedDrop};
+///
+/// enum Command {
+///     /* ... */
+/// }
+///
 /// #[pin_data(PinnedDrop)]
 /// struct DriverData {
 ///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-///     raw_info: *mut bindings::Info,
+///     queue: CMutex<Vec<Command>>,
+///     buf: Box<[u8; 1024 * 1024]>,
+///     raw_info: *mut bindings::info,
 /// }
 ///
 /// #[pinned_drop]
@@ -318,7 +337,7 @@
 /// # Examples
 ///
 /// ```ignore
-/// use kernel::macros::Zeroable;
+/// use pin_init::Zeroable;
 ///
 /// #[derive(Zeroable)]
 /// pub struct DriverData {
@@ -335,12 +354,14 @@
 ///
 /// ```rust,ignore
 /// # #![expect(clippy::disallowed_names)]
-/// # use kernel::{init, macros::pin_data, pin_init, stack_pin_init, init:=
:*, sync::Mutex, new_mutex};
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # use pin_init::*;
 /// # use core::pin::Pin;
 /// #[pin_data]
 /// struct Foo {
 ///     #[pin]
-///     a: Mutex<usize>,
+///     a: CMutex<usize>,
 ///     b: Bar,
 /// }
 ///
@@ -350,13 +371,13 @@
 /// }
 ///
 /// stack_pin_init!(let foo =3D pin_init!(Foo {
-///     a <- new_mutex!(42),
+///     a <- CMutex::new(42),
 ///     b: Bar {
 ///         x: 64,
 ///     },
 /// }));
 /// let foo: Pin<&mut Foo> =3D foo;
-/// pr_info!("a: {}", &*foo.a.lock());
+/// println!("a: {}", &*foo.a.lock());
 /// ```
 ///
 /// # Syntax
@@ -387,70 +408,56 @@ macro_rules! stack_pin_init {
 ///
 /// ```rust,ignore
 /// # #![expect(clippy::disallowed_names)]
-/// # use kernel::{
-/// #     init,
-/// #     pin_init,
-/// #     stack_try_pin_init,
-/// #     init::*,
-/// #     sync::Mutex,
-/// #     new_mutex,
-/// #     alloc::AllocError,
-/// # };
-/// # use macros::pin_data;
-/// # use core::pin::Pin;
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # use pin_init::*;
 /// #[pin_data]
 /// struct Foo {
 ///     #[pin]
-///     a: Mutex<usize>,
-///     b: KBox<Bar>,
+///     a: CMutex<usize>,
+///     b: Box<Bar>,
 /// }
 ///
 /// struct Bar {
 ///     x: u32,
 /// }
 ///
-/// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> =3D pin=
_init!(Foo {
-///     a <- new_mutex!(42),
-///     b: KBox::new(Bar {
+/// stack_try_pin_init!(let foo: Foo =3D try_pin_init!(Foo {
+///     a <- CMutex::new(42),
+///     b: Box::try_new(Bar {
 ///         x: 64,
-///     }, GFP_KERNEL)?,
-/// }));
+///     })?,
+/// }? Error));
 /// let foo =3D foo.unwrap();
-/// pr_info!("a: {}", &*foo.a.lock());
+/// println!("a: {}", &*foo.a.lock());
 /// ```
 ///
 /// ```rust,ignore
 /// # #![expect(clippy::disallowed_names)]
-/// # use kernel::{
-/// #     init,
-/// #     pin_init,
-/// #     stack_try_pin_init,
-/// #     init::*,
-/// #     sync::Mutex,
-/// #     new_mutex,
-/// #     alloc::AllocError,
-/// # };
-/// # use macros::pin_data;
-/// # use core::pin::Pin;
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # use pin_init::*;
 /// #[pin_data]
 /// struct Foo {
 ///     #[pin]
-///     a: Mutex<usize>,
-///     b: KBox<Bar>,
+///     a: CMutex<usize>,
+///     b: Box<Bar>,
 /// }
 ///
 /// struct Bar {
 ///     x: u32,
 /// }
 ///
-/// stack_try_pin_init!(let foo: Pin<&mut Foo> =3D? pin_init!(Foo {
-///     a <- new_mutex!(42),
-///     b: KBox::new(Bar {
+/// stack_try_pin_init!(let foo: Foo =3D? try_pin_init!(Foo {
+///     a <- CMutex::new(42),
+///     b: Box::try_new(Bar {
 ///         x: 64,
-///     }, GFP_KERNEL)?,
-/// }));
-/// pr_info!("a: {}", &*foo.a.lock());
-/// # Ok::<_, AllocError>(())
+///     })?,
+/// }? Error));
+/// println!("a: {}", &*foo.a.lock());
+/// # Ok::<_, Error>(())
 /// ```
 ///
 /// # Syntax
@@ -480,7 +487,7 @@ macro_rules! stack_try_pin_init {
 /// The syntax is almost identical to that of a normal `struct` initialize=
r:
 ///
 /// ```rust,ignore
-/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use pin_init::*;
 /// # use core::pin::Pin;
 /// #[pin_data]
 /// struct Foo {
@@ -503,7 +510,7 @@ macro_rules! stack_try_pin_init {
 ///     },
 /// });
 /// # initializer }
-/// # KBox::pin_init(demo(), GFP_KERNEL).unwrap();
+/// # Box::pin_init(demo()).unwrap();
 /// ```
 ///
 /// Arbitrary Rust expressions can be used to set the value of a variable.
@@ -524,7 +531,7 @@ macro_rules! stack_try_pin_init {
 /// To create an initializer function, simply declare it like this:
 ///
 /// ```rust,ignore
-/// # use kernel::{init, pin_init, init::*};
+/// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
 /// # struct Foo {
@@ -551,7 +558,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// ```rust,ignore
 /// # #![expect(clippy::disallowed_names)]
-/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
 /// # struct Foo {
@@ -572,13 +579,13 @@ macro_rules! stack_try_pin_init {
 /// #         })
 /// #     }
 /// # }
-/// let foo =3D KBox::pin_init(Foo::new(), GFP_KERNEL);
+/// let foo =3D Box::pin_init(Foo::new());
 /// ```
 ///
 /// They can also easily embed it into their own `struct`s:
 ///
 /// ```rust,ignore
-/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use pin_init::*;
 /// # use core::pin::Pin;
 /// # #[pin_data]
 /// # struct Foo {
@@ -637,7 +644,7 @@ macro_rules! stack_try_pin_init {
 /// For instance:
 ///
 /// ```rust,ignore
-/// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
+/// # use pin_init::*;
 /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
 /// #[pin_data]
 /// #[derive(Zeroable)]
@@ -700,10 +707,12 @@ macro_rules! pin_init {
 /// # Examples
 ///
 /// ```rust,ignore
-/// use kernel::{init::{self, PinInit}, error::Error};
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/error.rs"] mod error; use error::Error;
+/// use pin_init::*;
 /// #[pin_data]
 /// struct BigBuf {
-///     big: KBox<[u8; 1024 * 1024 * 1024]>,
+///     big: Box<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 ///     ptr: *mut u8,
 /// }
@@ -711,12 +720,13 @@ macro_rules! pin_init {
 /// impl BigBuf {
 ///     fn new() -> impl PinInit<Self, Error> {
 ///         try_pin_init!(Self {
-///             big: KBox::init(init::zeroed(), GFP_KERNEL)?,
+///             big: Box::init(init::zeroed())?,
 ///             small: [0; 1024 * 1024],
 ///             ptr: core::ptr::null_mut(),
 ///         }? Error)
 ///     }
 /// }
+/// # let _ =3D Box::pin_init(BigBuf::new());
 /// ```
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
@@ -803,18 +813,20 @@ macro_rules! init {
 /// # Examples
 ///
 /// ```rust,ignore
-/// use kernel::{alloc::KBox, init::{PinInit, zeroed}, error::Error};
+/// # #![feature(allocator_api)]
+/// # use core::alloc::AllocError;
+/// use pin_init::*;
 /// struct BigBuf {
-///     big: KBox<[u8; 1024 * 1024 * 1024]>,
+///     big: Box<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
 /// }
 ///
 /// impl BigBuf {
-///     fn new() -> impl Init<Self, Error> {
+///     fn new() -> impl Init<Self, AllocError> {
 ///         try_init!(Self {
-///             big: KBox::init(zeroed(), GFP_KERNEL)?,
+///             big: Box::init(zeroed())?,
 ///             small: [0; 1024 * 1024],
-///         }? Error)
+///         }? AllocError)
 ///     }
 /// }
 /// ```
@@ -859,7 +871,7 @@ macro_rules! try_init {
 ///
 /// This will succeed:
 /// ```ignore
-/// use kernel::assert_pinned;
+/// use pin_init::assert_pinned;
 /// #[pin_data]
 /// struct MyStruct {
 ///     #[pin]
@@ -870,9 +882,8 @@ macro_rules! try_init {
 /// ```
 ///
 /// This will fail:
-// TODO: replace with `compile_fail` when supported.
-/// ```ignore
-/// use kernel::assert_pinned;
+/// ```compile_fail,ignore
+/// use pin_init::assert_pinned;
 /// #[pin_data]
 /// struct MyStruct {
 ///     some_field: u64,
@@ -885,7 +896,7 @@ macro_rules! try_init {
 /// work around this, you may pass the `inline` parameter to the macro. Th=
e `inline` parameter can
 /// only be used when the macro is invoked from a function body.
 /// ```ignore
-/// use kernel::assert_pinned;
+/// use pin_init::assert_pinned;
 /// #[pin_data]
 /// struct Foo<T> {
 ///     #[pin]
@@ -963,35 +974,13 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>=
: Sized {
     /// # Examples
     ///
     /// ```rust,ignore
-    /// # #![expect(clippy::disallowed_names)]
-    /// use kernel::{types::Opaque, init::pin_init_from_closure};
-    /// #[repr(C)]
-    /// struct RawFoo([u8; 16]);
-    /// extern "C" {
-    ///     fn init_foo(_: *mut RawFoo);
-    /// }
-    ///
-    /// #[pin_data]
-    /// struct Foo {
-    ///     #[pin]
-    ///     raw: Opaque<RawFoo>,
-    /// }
-    ///
-    /// impl Foo {
-    ///     fn setup(self: Pin<&mut Self>) {
-    ///         pr_info!("Setting up foo");
-    ///     }
-    /// }
-    ///
-    /// let foo =3D pin_init!(Foo {
-    ///     // SAFETY: TODO.
-    ///     raw <- unsafe {
-    ///         Opaque::ffi_init(|s| {
-    ///             init_foo(s);
-    ///         })
-    ///     },
-    /// }).pin_chain(|foo| {
-    ///     foo.setup();
+    /// # #![feature(allocator_api)]
+    /// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+    /// # use pin_init::*;
+    /// let mtx_init =3D CMutex::new(42);
+    /// // Make the initializer print the value.
+    /// let mtx_init =3D mtx_init.pin_chain(|mtx| {
+    ///     println!("{:?}", mtx.get_data_mut());
     ///     Ok(())
     /// });
     /// ```
@@ -1076,7 +1065,7 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: P=
inInit<T, E> {
     ///
     /// ```rust,ignore
     /// # #![expect(clippy::disallowed_names)]
-    /// use kernel::{types::Opaque, init::{self, init_from_closure}};
+    /// use pin_init::{init_from_closure, zeroed};
     /// struct Foo {
     ///     buf: [u8; 1_000_000],
     /// }
@@ -1088,7 +1077,7 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: P=
inInit<T, E> {
     /// }
     ///
     /// let foo =3D init!(Foo {
-    ///     buf <- init::zeroed()
+    ///     buf <- zeroed()
     /// }).chain(|foo| {
     ///     foo.setup();
     ///     Ok(())
@@ -1187,11 +1176,10 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, =
E> {
 /// # Examples
 ///
 /// ```rust,ignore
-/// use kernel::{alloc::KBox, error::Error, init::init_array_from_fn};
-/// let array: KBox<[usize; 1_000]> =3D
-///     KBox::init::<Error>(init_array_from_fn(|i| i), GFP_KERNEL)?;
+/// # use pin_init::*;
+/// use pin_init::init_array_from_fn;
+/// let array: Box<[usize; 1_000]> =3D Box::init(init_array_from_fn(|i| i)=
).unwrap();
 /// assert_eq!(array.len(), 1_000);
-/// # Ok::<(), Error>(())
 /// ```
 pub fn init_array_from_fn<I, const N: usize, T, E>(
     mut make_init: impl FnMut(usize) -> I,
@@ -1232,11 +1220,15 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 /// # Examples
 ///
 /// ```rust,ignore
-/// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mut=
ex};
-/// let array: Arc<[Mutex<usize>; 1_000]> =3D
-///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i)), GFP_KERNE=
L)?;
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # use pin_init::*;
+/// # use core::pin::Pin;
+/// use pin_init::pin_init_array_from_fn;
+/// use std::sync::Arc;
+/// let array: Pin<Arc<[CMutex<usize>; 1_000]>> =3D
+///     Arc::pin_init(pin_init_array_from_fn(|i| CMutex::new(i))).unwrap()=
;
 /// assert_eq!(array.len(), 1_000);
-/// # Ok::<(), Error>(())
 /// ```
 pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
     mut make_init: impl FnMut(usize) -> I,
@@ -1421,19 +1413,20 @@ fn write_pin_init<E>(mut self, init: impl PinInit<T=
, E>) -> Result<Pin<Self::Ini
 /// Use [`pinned_drop`] to implement this trait safely:
 ///
 /// ```rust,ignore
-/// # use kernel::sync::Mutex;
-/// use kernel::macros::pinned_drop;
+/// # #![feature(allocator_api)]
+/// # #[path =3D "../examples/mutex.rs"] mod mutex; use mutex::*;
+/// # use pin_init::*;
 /// use core::pin::Pin;
 /// #[pin_data(PinnedDrop)]
 /// struct Foo {
 ///     #[pin]
-///     mtx: Mutex<usize>,
+///     mtx: CMutex<usize>,
 /// }
 ///
 /// #[pinned_drop]
 /// impl PinnedDrop for Foo {
 ///     fn drop(self: Pin<&mut Self>) {
-///         pr_info!("Foo is being dropped!");
+///         println!("Foo is being dropped!");
 ///     }
 /// }
 /// ```
--=20
2.47.2



