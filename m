Return-Path: <linux-kernel+bounces-550710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8AA5632F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EE616B64A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F511ACECD;
	Fri,  7 Mar 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXEDfFSm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EB1AA1F6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338302; cv=none; b=dhbCImSE5FdXkZ+kk1IS124lYVMxCYbi4yOw3oGeTsdf1Yuv+AoIdXxyqVyp8AbL31nWf2dGYPRo0RZ+CedKPQfsoQQ3/3T2ZG1oUMPZgz5uum4jqMg+e6lNOglOw+ibzOn8gTOM6d6tgMfAuQlRB/qaOSuSzrBdcryqQb6wwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338302; c=relaxed/simple;
	bh=/v0FINfUcKs0aBAwBxg3vwJ5pNIrZo+GaIDCyrGvEto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gde5sNesD+aurAt767H266O32Fb63AtTL00f+Yl1XiYufAYwqw73pQKhkr3tg2ezQDDNgerJPbig1vK3I787+2sd6mfXC6Ppn1HagpmTF6g+zVGQcjP7A1xm+H2+hYoQWZ6TnYc/kcKX2fcRYdrrSgZ8kBuJfsjdMqeEjlZx+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXEDfFSm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso3154419a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741338299; x=1741943099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtZApx7cCKxvZMminQ8QPHHKlq0rpnkGg8T1aFGkgmc=;
        b=OXEDfFSmsMAuvOLbHBI1VY94Znm7/3Xs+d06oUv2jFvxH2qwE0VNFAKaHqbKFmSw/u
         TerRYhlXThdntyrFPMuYewt3u+WJ7tcsxTEQQyGAqBaFajTEJdKVufL9HR4flmTYbCEo
         cdLiD43yI7HVG0I0P876ib4mMoUH4n17YtT/GbVEJqdydMaWnXk7VlwCN3kO9skGxiBz
         WzTW1n/sZnvsD7htwwzvyFFVjZbNqHbXQQ/nji3iMa63e8vtXit5kM/nVlxwsK57F7CA
         0Q277wcj41vZH/FJtIiDpx9U/r67DJ8z8C5H6k8r5biJLfC1/lg0WQcdc9SdA0FYzQYk
         cWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338299; x=1741943099;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CtZApx7cCKxvZMminQ8QPHHKlq0rpnkGg8T1aFGkgmc=;
        b=BWSEkgSDtMYXjG2pflL8ZEjtcAiCRuk9uXqGxmgnZ0usvI7YV7W5CIb0aNYJ5/ZODD
         Sxfr0CAmPLV7O9S6ERxAme0zIP2BnDbIfBeTRmrvBDqZDFchGOpQ/G4Itg759Eh2M6UH
         2CF6T6INKsSdxQOwl5f8yReDppxppLhWprcJdcK8HNYYZaJyc17a0cruR+ME2BqcEIZT
         LbmFhkSa0sWhv8+36Sa9PGSu2/6GrrhOPu6DE7ZGW63AFlnb7EdZq0Rd4L2SZtSsQ5I2
         yNqlWjBTYIwLnhP0b5s2S95aD98GUHmBgEYBbwFaQ0yXGo7R5AiuPFlm++fou1GOD9b3
         BiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaxs9SIdWIG00moZi20qO9u1F9qu3NxO0Bi8Bt1fcYTfe41ykY8Apgu83bqZPms4Os3yJGzNJ4Porcyj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhrukZSLHdG/ircuBK92W/nUS4lMoqMQ/XlV9dwB8JRso//4Y
	QZstWox3EVVIymK655ACD6bOtDgUk1qIylmP4eqakHTQLr+bEFzCaPCRpMqIGruysAVTueeCj7D
	c0QVRUu/SnQ==
X-Google-Smtp-Source: AGHT+IHewsU9GoD2/xmBGNKJh0npTswD3mXJ2HVKYb60tXxi5UHDzB/LH6tpJyEhpzm9D8JTreLuNonnklb02g==
X-Received: from pjbsv12.prod.google.com ([2002:a17:90b:538c:b0:2ff:5516:6add])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:180c:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-2ff7ce8cfccmr4487004a91.9.1741338299572;
 Fri, 07 Mar 2025 01:04:59 -0800 (PST)
Date: Fri,  7 Mar 2025 17:00:56 +0800
In-Reply-To: <20250307090103.918788-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307090103.918788-1-davidgow@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307090103.918788-2-davidgow@google.com>
Subject: [PATCH v8 1/3] rust: kunit: add KUnit case and suite macros
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Tamir Duberstein <tamird@gmail.com>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Add a couple of Rust const functions and macros to allow to develop
KUnit tests without relying on generated C code:

 - The `kunit_unsafe_test_suite!` Rust macro is similar to the
   `kunit_test_suite` C macro. It requires a NULL-terminated array of
   test cases (see below).
 - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C macro.
   It generates as case from the name and function.
 - The `kunit_case_null` Rust function generates a NULL test case, which
   is to be used as delimiter in `kunit_test_suite!`.

While these functions and macros can be used on their own, a future
patch will introduce=C2=A0another macro to create KUnit tests using a
user-space like syntax.

Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
Co-developed-by: Matt Gilbride <mattgilbride@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v7:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-2-davidgow@go=
ogle.com/
- Reworked the SAFETY comment for addr_of_mut! use with statics in
  kunit_unsafe_test_suite!() (again).
- Equally, updated the macro documentation to make the safety
  precondition (that $test_cases should be static) clearer.

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-2-davidgow@go=
ogle.com/
- Fixed an [allow(unused_unsafe)] which ended up in patch 2 instead of
  patch 1. (Thanks, Tamir!)
- Doc comments now have several useful links. (Thanks, Tamir!)
- Fix a potential compile error under macos. (Thanks, Tamir!)
- Several small tidy-ups to limit unsafe usage. (Thanks, Tamir!)

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@google.com/
- Rebased against 6.14-rc1
- Several documentation touch-ups, including noting that the example
  test function need not be unsafe. (Thanks, Miguel)
- Remove the need for static_mut_refs, by using core::addr_of_mut!()
  combined with a cast. (Thanks, Miguel)
  - While this should also avoid the need for const_mut_refs, it seems
    to have been enabled for other users anyway.
- Use ::kernel::ffi::c_char for C strings, rather than i8 directly.
  (Thanks, Miguel)

Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- Allowed an unused_unsafe warning after the behaviour of addr_of_mut!()
  changed in Rust 1.82. (Thanks Boqun, Miguel)
- Fix a couple of minor rustfmt issues which were triggering checkpatch
  warnings.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-davidgow@g=
oogle.com/
- The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
  too long, triggering a compile error. (Thanks, Alice!)

Changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davidgow@g=
oogle.com/
- The kunit_unsafe_test_suite!() macro will truncate the name of the
  suite if it is too long. (Thanks Alice!)
- We no longer needlessly use UnsafeCell<> in
  kunit_unsafe_test_suite!(). (Thanks Alice!)

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google.com=
/
- Rebase on top of rust-next
- As a result, KUnit attributes are new set. These are hardcoded to the
  defaults of "normal" speed and no module name.
- Split the kunit_case!() macro into two const functions, kunit_case()
  and kunit_case_null() (for the NULL terminator).

---

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-2-davidgow@go=
ogle.com/
- Fixed an [allow(unused_unsafe)] which ended up in patch 2 instead of
  patch 1. (Thanks, Tamir!)
- Doc comments now have several useful links. (Thanks, Tamir!)
- Fix a potential compile error under macos. (Thanks, Tamir!)
- Several small tidy-ups to limit unsafe usage. (Thanks, Tamir!)

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@google.com/
- Rebased against 6.14-rc1
- Several documentation touch-ups, including noting that the example
  test function need not be unsafe. (Thanks, Miguel)
- Remove the need for static_mut_refs, by using core::addr_of_mut!()
  combined with a cast. (Thanks, Miguel)
  - While this should also avoid the need for const_mut_refs, it seems
    to have been enabled for other users anyway.
- Use ::kernel::ffi::c_char for C strings, rather than i8 directly.
  (Thanks, Miguel)

Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- Allowed an unused_unsafe warning after the behaviour of addr_of_mut!()
  changed in Rust 1.82. (Thanks Boqun, Miguel)
- Fix a couple of minor rustfmt issues which were triggering checkpatch
  warnings.

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-davidgow@g=
oogle.com/
- The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
  too long, triggering a compile error. (Thanks, Alice!)

Changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davidgow@g=
oogle.com/
- The kunit_unsafe_test_suite!() macro will truncate the name of the
  suite if it is too long. (Thanks Alice!)
- We no longer needlessly use UnsafeCell<> in
  kunit_unsafe_test_suite!(). (Thanks Alice!)

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google.com=
/
- Rebase on top of rust-next
- As a result, KUnit attributes are new set. These are hardcoded to the
  defaults of "normal" speed and no module name.
- Split the kunit_case!() macro into two const functions, kunit_case()
  and kunit_case_null() (for the NULL terminator).

---
 rust/kernel/kunit.rs | 124 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..1b9b52892562 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -161,3 +161,127 @@ macro_rules! kunit_assert_eq {
         $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right);
     }};
 }
+
+/// Represents an individual test case.
+///
+/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list =
of valid test cases.
+/// Use [`kunit_case_null`] to generate such a delimiter.
+#[doc(hidden)]
+pub const fn kunit_case(
+    name: &'static kernel::str::CStr,
+    run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
+) -> kernel::bindings::kunit_case {
+    kernel::bindings::kunit_case {
+        run_case: Some(run_case),
+        name: name.as_char_ptr(),
+        attr: kernel::bindings::kunit_attributes {
+            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
+        },
+        generate_params: None,
+        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
+        module_name: core::ptr::null_mut(),
+        log: core::ptr::null_mut(),
+    }
+}
+
+/// Represents the NULL test case delimiter.
+///
+/// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated list =
of test cases. This
+/// function returns such a delimiter.
+#[doc(hidden)]
+pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
+    kernel::bindings::kunit_case {
+        run_case: None,
+        name: core::ptr::null_mut(),
+        generate_params: None,
+        attr: kernel::bindings::kunit_attributes {
+            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
+        },
+        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
+        module_name: core::ptr::null_mut(),
+        log: core::ptr::null_mut(),
+    }
+}
+
+/// Registers a KUnit test suite.
+///
+/// # Safety
+///
+/// `test_cases` must be a NULL terminated array of valid test cases,
+/// whose lifetime is at least that of the test suite (i.e., static).
+///
+/// # Examples
+///
+/// ```ignore
+/// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
+///     let actual =3D 1 + 1;
+///     let expected =3D 2;
+///     assert_eq!(actual, expected);
+/// }
+///
+/// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] =3D [
+///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
+///     kernel::kunit::kunit_case_null(),
+/// ];
+/// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
+/// ```
+#[doc(hidden)]
+#[macro_export]
+macro_rules! kunit_unsafe_test_suite {
+    ($name:ident, $test_cases:ident) =3D> {
+        const _: () =3D {
+            const KUNIT_TEST_SUITE_NAME: [::kernel::ffi::c_char; 256] =3D =
{
+                let name_u8 =3D ::core::stringify!($name).as_bytes();
+                let mut ret =3D [0; 256];
+
+                if name_u8.len() > 255 {
+                    panic!(concat!(
+                        "The test suite name `",
+                        ::core::stringify!($name),
+                        "` exceeds the maximum length of 255 bytes."
+                    ));
+                }
+
+                let mut i =3D 0;
+                while i < name_u8.len() {
+                    ret[i] =3D name_u8[i] as ::kernel::ffi::c_char;
+                    i +=3D 1;
+                }
+
+                ret
+            };
+
+            static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_suite =
=3D
+                ::kernel::bindings::kunit_suite {
+                    name: KUNIT_TEST_SUITE_NAME,
+                    #[allow(unused_unsafe)]
+                    // SAFETY: $test_cases is passed in by the user, and
+                    // (as documented) must be valid for the lifetime of
+                    // the suite (i.e., static).
+                    test_cases: unsafe {
+                        ::core::ptr::addr_of_mut!($test_cases)
+                            .cast::<::kernel::bindings::kunit_case>()
+                    },
+                    suite_init: None,
+                    suite_exit: None,
+                    init: None,
+                    exit: None,
+                    attr: ::kernel::bindings::kunit_attributes {
+                        speed: ::kernel::bindings::kunit_speed_KUNIT_SPEED=
_NORMAL,
+                    },
+                    status_comment: [0; 256usize],
+                    debugfs: ::core::ptr::null_mut(),
+                    log: ::core::ptr::null_mut(),
+                    suite_init_err: 0,
+                    is_init: false,
+                };
+
+            #[used]
+            #[allow(unused_unsafe)]
+            #[cfg_attr(not(target_os =3D "macos"), link_section =3D ".kuni=
t_test_suites")]
+            static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindings::=
kunit_suite =3D
+                // SAFETY: `KUNIT_TEST_SUITE` is static.
+                unsafe { ::core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
+        };
+    };
+}
--=20
2.49.0.rc0.332.g42c0ae87b1-goog


