Return-Path: <linux-kernel+bounces-516081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6AA36CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D841895B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBC19F495;
	Sat, 15 Feb 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdh97DW+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4494119E994
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610399; cv=none; b=o/jfNevPnWVwhNedjCYkSeF4JYrvddzbKQA/FnHViJUsEajLLpvoMs1l+dDQYKramqLa/fTJdCUQYT0YFbtsyTVbibEk7OAcLeqMTfAevsXsCbkontkzISdPdj6x7LQ/uyX4cdws8IPcSg6k46H+g3HDjEMfqSDkelrSZkqtCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610399; c=relaxed/simple;
	bh=GagErhGsHpp3IGT4h4dC4/7to7kdouV1RwL8jKYaTjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gKBVi2pH1V5bGQGnYpqQ4aJd/UD1o1wvU3xN7tkIRElqGZOX7Y99qkerii7xfPW528827ikxpPBKlJbHTEIRdMjEFLLgaS4vGiWzm1vKlXz6Qph9jSjSTcA8Vpi0lutyd0uT275bS9heBr2UBJ0ny83lHPDWSFpJYo+Y25M4Rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdh97DW+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a70935fso5055110a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610395; x=1740215195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWQaqrhkGlaLBfu/rmr596S3UsF7HKNYDc8qgpOE2V4=;
        b=hdh97DW+ZpAMDWHFpoJUQzWy7OqpKfaFXuq0vGNyM6Rkwfho/XpPaS1Vn81SCnOWg2
         jgnHK8bmAplbKZ+nSAuLA/g09J5vdwr6zpsP58THTliffmkD22S3NHbpq44/eA/n0NXV
         BX9UL32vnTtU7G04JX7TILKCAymK2TGc9NhukwWglqvlgDN3nWZqn7HOmOpanBHxDYsZ
         C/l1P7KXzWflI1Dl4+tMc3MoYwGxYGUXZHLlcKJsJBmZPg1SiNwcv6l+8k+NziI3d/uB
         gjMerlGecu8y9cVEjWx/s5gwA64xtHdk/TV/bbEHPu4UTRM6/V482eiqswraMc+nXO/i
         0hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610395; x=1740215195;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mWQaqrhkGlaLBfu/rmr596S3UsF7HKNYDc8qgpOE2V4=;
        b=tLGDmVgQE0FwvTP4zy5JQ/8oRuHqtTS6O+xPajIXHtS5l6GqjkhCCZ45WDYs8FQ+2a
         KCaFOG1p2dMlyCImuULVMNG7SY3zfnkF8SzWHPB/tbSwMs/IaaggI8pFpbU9V0JLxbZI
         TS07XOLJwcFSxe9xSiG+7eq6EHnbh/f8UYtYqAcNp3VDM3ItWHL5sIK7Q54dBruV16qM
         3s5qbM9UMgQZzSK97S7Jf7FJjQivClMEpqA+lyUK65P3Wnd6Hr0nXGamsjTDXg/v5Y5n
         Hg1P01/vd8PRDPoMd9Y7COZYkJEqOLWKwsGRhCpkrlOCEvplWQ6t1z+pQBG9SMFl8iz0
         AsNg==
X-Forwarded-Encrypted: i=1; AJvYcCWvAy8KwaBSy/EI6cFTcYC1eZvxev32He8feprHHt+U4UHsOYb0iQZSyZ6Hew3ZbQVLO8LdfsQgFubEHRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yk81+U1M1pPacYF755LpBWOmBJNcDEBxEma6l4IJHwqruPO+
	Lrlt+axWqoZqldAaSZQrQOZMvjWH/FDhUwodabkFy/47HFk6RLIv2FSDk5m2CaiMqWqoFbjCug2
	9z13EKdMOAQ==
X-Google-Smtp-Source: AGHT+IFHDTbfpLDgjvBT6wwAVZ9QgzzcV5wj0a+ddj4HjyXvsLUa35Bhrp84KvOB0nJ7on+IsQR7ktnFyZK72g==
X-Received: from pjbnd14.prod.google.com ([2002:a17:90b:4cce:b0:2fb:fa62:d40])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f06:b0:2ee:c91a:ad05 with SMTP id 98e67ed59e1d1-2fc40d14c84mr3609691a91.3.1739610395592;
 Sat, 15 Feb 2025 01:06:35 -0800 (PST)
Date: Sat, 15 Feb 2025 17:06:18 +0800
In-Reply-To: <20250215090622.2381038-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215090622.2381038-1-davidgow@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215090622.2381038-2-davidgow@google.com>
Subject: [PATCH v7 1/3] rust: kunit: add KUnit case and suite macros
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
 rust/kernel/kunit.rs | 122 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..ffb3606f748c 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -161,3 +161,125 @@ macro_rules! kunit_assert_eq {
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
+/// `test_cases` must be a NULL terminated array of valid test cases.
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
+                    // SAFETY: User is expected to pass a correct `test_ca=
ses`, given the safety
+                    // precondition; hence this macro named `unsafe`.
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
2.48.1.601.g30ceb7b040-goog


