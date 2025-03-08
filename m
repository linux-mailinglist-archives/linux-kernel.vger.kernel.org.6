Return-Path: <linux-kernel+bounces-552450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C4DA579EE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304E4189BB81
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16581EB5E8;
	Sat,  8 Mar 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fjZ5g0le"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8B1EB5C4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431942; cv=none; b=Y+Of689+0t3+ON252aEq4utRznwjqwX3Xc2FKHF/YvT/6zopq1Joy5Y2DtUsAlW7AxVAV73aE9kDFYKAc3Hs85ai52CUwdWEx7QGTjGSpHixg8VTZAeSc4/6/8b5hnrGfJ0zbKbPFrLZE3dIyEjIXlJYbqiKqUHPybTyaiX1soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431942; c=relaxed/simple;
	bh=XKZVHWLRqUAAkE6TAbpm4gpyXee/Mw8uHObhsLBspMo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnxPJf66Zc8WzkHK2nWbHjwnRMg0Hc9KVYp87Joivoc9GTdzKurhPB6u9z9BVJf4WgFpGzwIfn2/zCZqQmVAZbvy/wMKhJtxpq9EbsFMcdE+irvDlRLJkWJvSve+M6RVTIn3MPOy04wyDo/11uenxoif2In5rj2NA7vPDaBAEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fjZ5g0le; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431934; x=1741691134;
	bh=f45XPdmgssG2ekwG7QdRWktTb986WY+ilJOBsD6eErg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fjZ5g0letykyCL30GQpMJG/3K5fPhFzQo4JzZ4LHy8ip+ThzH6C5t/mFu34qwgZY9
	 bH6gp1cuwpeJZovbefP2PQqp5gCj9k/iG1HuuNK+qKzPnBZYJqta2OieqsSwRuYyET
	 1nVecMvmZWorPXnvl7Oz8DiU+Hn3zbz4AayTQ0xWpAJgKLkmCXbSFPToVKpW4k8Efe
	 PoNe3fHdQWsq7Mab75IQO6eoXgYrLXbOywnXlLBqIiaIzBegyuh6yvLcGKeFd78OmP
	 mqhXVfava2xiTJoA0TBJLTnGBjxmZc61IohdbkhUdtCMe8WyDbS2/Ael7hxGglUJ0f
	 Qh/jCsrpeiA5A==
Date: Sat, 08 Mar 2025 11:05:31 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 20/22] rust: pin-init: add miscellaneous files from the user-space version
Message-ID: <20250308110339.2997091-21-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 62f5c6c86707651db913e3ff5658bf0f30ec1f8d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add readme and contribution guidelines of the user-space version of
pin-init.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/CONTRIBUTING.md |  72 +++++++++++
 rust/pin-init/README.md       | 228 ++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 rust/pin-init/CONTRIBUTING.md
 create mode 100644 rust/pin-init/README.md

diff --git a/rust/pin-init/CONTRIBUTING.md b/rust/pin-init/CONTRIBUTING.md
new file mode 100644
index 000000000000..16c899a7ae0b
--- /dev/null
+++ b/rust/pin-init/CONTRIBUTING.md
@@ -0,0 +1,72 @@
+# Contributing to `pin-init`
+
+Thanks for showing interest in contributing to `pin-init`! This document o=
utlines the guidelines for
+contributing to `pin-init`.
+
+All contributions are double-licensed under Apache 2.0 and MIT. You can fi=
nd the respective licenses
+in the `LICENSE-APACHE` and `LICENSE-MIT` files.
+
+## Non-Code Contributions
+
+### Bug Reports
+
+For any type of bug report, please submit an issue using the bug report is=
sue template.
+
+If the issue is a soundness issue, please privately report it as a securit=
y vulnerability via the
+GitHub web interface.
+
+### Feature Requests
+
+If you have any feature requests, please submit an issue using the feature=
 request issue template.
+
+### Questions and Getting Help
+
+You can ask questions in the Discussions page of the GitHub repository. If=
 you're encountering
+problems or just have questions related to `pin-init` in the Linux kernel,=
 you can also ask your
+questions in the [Rust-for-Linux Zulip](https://rust-for-linux.zulipchat.c=
om/) or see
+<https://rust-for-linux.com/contact>.
+
+## Contributing Code
+
+### Linux Kernel
+
+`pin-init` is used by the Linux kernel and all commits are synchronized to=
 it. For this reason, the
+same requirements for commits apply to `pin-init`. See [the kernel's docum=
entation] for details. The
+rest of this document will also cover some of the rules listed there and a=
dditional ones.
+
+[the kernel's documentation]: https://docs.kernel.org/process/submitting-p=
atches.html
+
+Contributions to `pin-init` ideally go through the [GitHub repository], be=
cause that repository runs
+a CI with lots of tests not present in the kernel. However, patches are al=
so accepted (though not
+preferred). Do note that there are some files that are only present in the=
 GitHub repository such as
+tests, licenses and cargo related files. Making changes to them can only h=
appen via GitHub.
+
+[GitHub repository]: https://github.com/Rust-for-Linux/pin-init
+
+### Commit Style
+
+Everything must compile without errors or warnings and all tests must pass=
 after **every commit**.
+This is important for bisection and also required by the kernel.
+
+Each commit should be a single, logically cohesive change. Of course it's =
best to keep the changes
+small and digestible, but logically linked changes should be made in the s=
ame commit. For example,
+when fixing typos, create a single commit that fixes all of them instead o=
f one commit per typo.
+
+Commits must have a meaningful commit title. Commits with changes to files=
 in the `internal`
+directory should have a title prefixed with `internal:`. The commit messag=
e should explain the
+change and its rationale. You also have to add your `Signed-off-by` tag, s=
ee [Developer's
+Certificate of Origin]. This has to be done for both mailing list submissi=
ons as well as GitHub
+submissions.
+
+[Developer's Certificate of Origin]: https://docs.kernel.org/process/submi=
tting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
+
+Any changes made to public APIs must be documented not only in the commit =
message, but also in the
+`CHANGELOG.md` file. This is especially important for breaking changes, as=
 those warrant a major
+version bump.
+
+If you make changes to the top-level crate documentation, you also need to=
 update the `README.md`
+via `cargo rdme`.
+
+Some of these rules can be ignored if the change is done solely to files t=
hat are not present in the
+kernel version of this library. Those files are documented in the `sync-ke=
rnel.sh` script at the
+very bottom in the `--exclude` flag given to the `git am` command.
diff --git a/rust/pin-init/README.md b/rust/pin-init/README.md
new file mode 100644
index 000000000000..3d04796b212b
--- /dev/null
+++ b/rust/pin-init/README.md
@@ -0,0 +1,228 @@
+[![Crates.io](https://img.shields.io/crates/v/pin-init.svg)](https://crate=
s.io/crates/pin-init)
+[![Documentation](https://docs.rs/pin-init/badge.svg)](https://docs.rs/pin=
-init/)
+[![Dependency status](https://deps.rs/repo/github/Rust-for-Linux/pin-init/=
status.svg)](https://deps.rs/repo/github/Rust-for-Linux/pin-init)
+![License](https://img.shields.io/crates/l/pin-init)
+[![Toolchain](https://img.shields.io/badge/toolchain-nightly-red)](#nightl=
y-only)
+![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/s=
tatus/Rust-for-Linux/pin-init/test.yml)
+# `pin-init`
+
+<!-- cargo-rdme start -->
+
+Library to safely and fallibly initialize pinned `struct`s using in-place =
constructors.
+
+[Pinning][pinning] is Rust's way of ensuring data does not move.
+
+It also allows in-place initialization of big `struct`s that would otherwi=
se produce a stack
+overflow.
+
+This library's main use-case is in [Rust-for-Linux]. Although this version=
 can be used
+standalone.
+
+There are cases when you want to in-place initialize a struct. For example=
 when it is very big
+and moving it from the stack is not an option, because it is bigger than t=
he stack itself.
+Another reason would be that you need the address of the object to initial=
ize it. This stands
+in direct conflict with Rust's normal process of first initializing an obj=
ect and then moving
+it into it's final memory location. For more information, see
+<https://rust-for-linux.com/the-safe-pinned-initialization-problem>.
+
+This library allows you to do in-place initialization safely.
+
+### Nightly Needed for `alloc` feature
+
+This library requires the [`allocator_api` unstable feature] when the `all=
oc` feature is
+enabled and thus this feature can only be used with a nightly compiler. Wh=
en enabling the
+`alloc` feature, the user will be required to activate `allocator_api` as =
well.
+
+[`allocator_api` unstable feature]: https://doc.rust-lang.org/nightly/unst=
able-book/library-features/allocator-api.html
+
+The feature is enabled by default, thus by default `pin-init` will require=
 a nightly compiler.
+However, using the crate on stable compilers is possible by disabling `all=
oc`. In practice this
+will require the `std` feature, because stable compilers have neither `Box=
` nor `Arc` in no-std
+mode.
+
+## Overview
+
+To initialize a `struct` with an in-place constructor you will need two th=
ings:
+- an in-place constructor,
+- a memory location that can hold your `struct` (this can be the [stack], =
an [`Arc<T>`],
+  [`Box<T>`] or any other smart pointer that supports this library).
+
+To get an in-place constructor there are generally three options:
+- directly creating an in-place constructor using the [`pin_init!`] macro,
+- a custom function/macro returning an in-place constructor provided by so=
meone else,
+- using the unsafe function [`pin_init_from_closure()`] to manually create=
 an initializer.
+
+Aside from pinned initialization, this library also supports in-place cons=
truction without
+pinning, the macros/types/functions are generally named like the pinned va=
riants without the
+`pin_` prefix.
+
+## Examples
+
+Throughout the examples we will often make use of the `CMutex` type which =
can be found in
+`../examples/mutex.rs`. It is essentially a userland rebuild of the `struc=
t mutex` type from
+the Linux kernel. It also uses a wait list and a basic spinlock. Important=
ly the wait list
+requires it to be pinned to be locked and thus is a prime candidate for us=
ing this library.
+
+### Using the [`pin_init!`] macro
+
+If you want to use [`PinInit`], then you will have to annotate your `struc=
t` with
+`#[`[`pin_data`]`]`. It is a macro that uses `#[pin]` as a marker for
+[structurally pinned fields]. After doing this, you can then create an in-=
place constructor via
+[`pin_init!`]. The syntax is almost the same as normal `struct` initialize=
rs. The difference is
+that you need to write `<-` instead of `:` for fields that you want to ini=
tialize in-place.
+
+```rust
+use pin_init::{pin_data, pin_init, InPlaceInit};
+
+#[pin_data]
+struct Foo {
+    #[pin]
+    a: CMutex<usize>,
+    b: u32,
+}
+
+let foo =3D pin_init!(Foo {
+    a <- CMutex::new(42),
+    b: 24,
+});
+```
+
+`foo` now is of the type [`impl PinInit<Foo>`]. We can now use any smart p=
ointer that we like
+(or just the stack) to actually initialize a `Foo`:
+
+```rust
+let foo: Result<Pin<Box<Foo>>, AllocError> =3D Box::pin_init(foo);
+```
+
+For more information see the [`pin_init!`] macro.
+
+### Using a custom function/macro that returns an initializer
+
+Many types that use this library supply a function/macro that returns an i=
nitializer, because
+the above method only works for types where you can access the fields.
+
+```rust
+let mtx: Result<Pin<Arc<CMutex<usize>>>, _> =3D Arc::pin_init(CMutex::new(=
42));
+```
+
+To declare an init macro/function you just return an [`impl PinInit<T, E>`=
]:
+
+```rust
+#[pin_data]
+struct DriverData {
+    #[pin]
+    status: CMutex<i32>,
+    buffer: Box<[u8; 1_000_000]>,
+}
+
+impl DriverData {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            status <- CMutex::new(0),
+            buffer: Box::init(pin_init::zeroed())?,
+        }? Error)
+    }
+}
+```
+
+### Manual creation of an initializer
+
+Often when working with primitives the previous approaches are not suffici=
ent. That is where
+[`pin_init_from_closure()`] comes in. This `unsafe` function allows you to=
 create a
+[`impl PinInit<T, E>`] directly from a closure. Of course you have to ensu=
re that the closure
+actually does the initialization in the correct way. Here are the things t=
o look out for
+(we are calling the parameter to the closure `slot`):
+- when the closure returns `Ok(())`, then it has completed the initializat=
ion successfully, so
+  `slot` now contains a valid bit pattern for the type `T`,
+- when the closure returns `Err(e)`, then the caller may deallocate the me=
mory at `slot`, so
+  you need to take care to clean up anything if your initialization fails =
mid-way,
+- you may assume that `slot` will stay pinned even after the closure retur=
ns until `drop` of
+  `slot` gets called.
+
+```rust
+use pin_init::{pin_data, pinned_drop, PinInit, PinnedDrop, pin_init_from_c=
losure};
+use core::{
+    ptr::addr_of_mut,
+    marker::PhantomPinned,
+    cell::UnsafeCell,
+    pin::Pin,
+    mem::MaybeUninit,
+};
+mod bindings {
+    #[repr(C)]
+    pub struct foo {
+        /* fields from C ... */
+    }
+    extern "C" {
+        pub fn init_foo(ptr: *mut foo);
+        pub fn destroy_foo(ptr: *mut foo);
+        #[must_use =3D "you must check the error return code"]
+        pub fn enable_foo(ptr: *mut foo, flags: u32) -> i32;
+    }
+}
+
+/// # Invariants
+///
+/// `foo` is always initialized
+#[pin_data(PinnedDrop)]
+pub struct RawFoo {
+    #[pin]
+    _p: PhantomPinned,
+    #[pin]
+    foo: UnsafeCell<MaybeUninit<bindings::foo>>,
+}
+
+impl RawFoo {
+    pub fn new(flags: u32) -> impl PinInit<Self, i32> {
+        // SAFETY:
+        // - when the closure returns `Ok(())`, then it has successfully i=
nitialized and
+        //   enabled `foo`,
+        // - when it returns `Err(e)`, then it has cleaned up before
+        unsafe {
+            pin_init_from_closure(move |slot: *mut Self| {
+                // `slot` contains uninit memory, avoid creating a referen=
ce.
+                let foo =3D addr_of_mut!((*slot).foo);
+                let foo =3D UnsafeCell::raw_get(foo).cast::<bindings::foo>=
();
+
+                // Initialize the `foo`
+                bindings::init_foo(foo);
+
+                // Try to enable it.
+                let err =3D bindings::enable_foo(foo, flags);
+                if err !=3D 0 {
+                    // Enabling has failed, first clean up the foo and the=
n return the error.
+                    bindings::destroy_foo(foo);
+                    Err(err)
+                } else {
+                    // All fields of `RawFoo` have been initialized, since=
 `_p` is a ZST.
+                    Ok(())
+                }
+            })
+        }
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for RawFoo {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: Since `foo` is initialized, destroying is safe.
+        unsafe { bindings::destroy_foo(self.foo.get().cast::<bindings::foo=
>()) };
+    }
+}
+```
+
+For more information on how to use [`pin_init_from_closure()`], take a loo=
k at the uses inside
+the `kernel` crate. The [`sync`] module is a good starting point.
+
+[`sync`]: https://rust.docs.kernel.org/kernel/sync/index.html
+[pinning]: https://doc.rust-lang.org/std/pin/index.html
+[structurally pinned fields]: https://doc.rust-lang.org/std/pin/index.html=
#pinning-is-structural-for-field
+[stack]: https://docs.rs/pin-init/latest/pin_init/macro.stack_pin_init.htm=
l
+[`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Arc.html
+[`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.Box.html
+[`impl PinInit<Foo>`]: https://docs.rs/pin-init/latest/pin_init/trait.PinI=
nit.html
+[`impl PinInit<T, E>`]: https://docs.rs/pin-init/latest/pin_init/trait.Pin=
Init.html
+[`impl Init<T, E>`]: https://docs.rs/pin-init/latest/pin_init/trait.Init.h=
tml
+[Rust-for-Linux]: https://rust-for-linux.com/
+
+<!-- cargo-rdme end -->
--=20
2.47.2



