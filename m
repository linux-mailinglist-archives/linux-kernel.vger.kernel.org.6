Return-Path: <linux-kernel+bounces-444391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AA9F060D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF681889B68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081F19EED0;
	Fri, 13 Dec 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZs+az0W"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD71A724C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077451; cv=none; b=Aik3ObrVayd+BH//UWu764ftJoDDprMaA51UTwzpMwFb+aT9T4su+wnJYX6e5YpPzUkNQspi5vm9BJRKK/MWImkoH3NEKNbkDrRvL3OaM8c8F8XcNN2WeZ6KY2Zj1ZQj6TejmOE0IsD+K6/VOHBUvpZSphPOh9kZ5wwuaPFxgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077451; c=relaxed/simple;
	bh=z3WxWku3En1g2Q9vLxqxNomd35j6zMJzJtZtnxG9FvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8hYrBJJmByhtW7IVkU6fht9P0RHwC7c7fqX8lBbYNu/TIFu3Q7Gj3luN4SX0HWh/nlh0yMZfPPN+meuwmjJ9o2+W9Z7AufDr8J8az/H92uTXJoDzu30QkZ0AOO3FtNnEDtFTumINluURG7eNb8wayeq4HvIWyrDDQLL8FoX0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZs+az0W; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728f1c4b95aso1311596b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734077447; x=1734682247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EutDnAY7mwrSXgsBtbyoYyBKsUYR7YsmiVo+T3wjJHs=;
        b=MZs+az0WHesd9OtvK8Q/QLYoBPGL1o/02cnPKIC9DO6qvvsqqwooei40fTyoCL8Utk
         0pMrOH71PU1FylBDJBfjWAW29tSf69S0g9PUkQMPsrRXrerrSRlDu/6zzXV1vqd1VLfc
         DJU1TacFNGXkgFJMre1W/qX3QRKBvEl6PzNdMk4cykzkYSEvA4yFbxEXXgVBIy65E+r8
         j9aSNLI/l+VFQe+omxab56Bqi7Jr12YvcZMTaXLcx8hCcLvgEVhfAGv6VF6wX+ZZ5kUb
         3hfson0LjsSrWw/fa+hW8devxXouyC/qfNcmV76GDXjy/Jvt9i8Po/j/v2NPgofbxR2n
         fwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077447; x=1734682247;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EutDnAY7mwrSXgsBtbyoYyBKsUYR7YsmiVo+T3wjJHs=;
        b=FXdxkxGzzxhdI6rN3F4RFytw97l45WgQZcXw4flH+JViKhNDEIALCqto/BQ+q2FqhO
         gGnA8I6xH5qp0f7d5aHqYATpx3huuPpjmvrlteYMJdhDbBHJs1v+DItwWIxk6DpEWsFg
         JLYUHgUX9p+mmNIQUd5Qxrupb42ZMYwlb+5j6EBO/D2kA8wlDewDeR2tqm+IieKsRExr
         9trKq+raVR2jBWAHfsKtrAsRTmE+B8+2hFEfnyKnzabIZ6qVXpMs1Nb3h2fLM66Bk1Or
         XuoK7gHo6LKS6SSi3ZRPFDP49+fFgYt6nSxN5c+C7s5gBIU32L5O/iqJjHZovaMA6/Kq
         /mqg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/ZI69zdPPeHJPk+0+G96AA5f9Cw9PVDClRxceXZPSztePBA843dOBiWLtILVJuhAGtfVrO3jS1GuPeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi80E5Tee5AkgjybtxjvC2fXlUqrRwGJh6aq0zCPHJjbkJYU5K
	OI49yGAw1x7q9SzGI9Rt88WQhnYP8mj6//2rdyeTI6N4pamCpuO69Pn/rVPPwD41Vx8TNlm0Yqr
	jfZMHEKM7tA==
X-Google-Smtp-Source: AGHT+IGDiY8+0N79pRvt65uYS7KXWtzJASUKFTVyKWuq0+4SJtuOiujR82grnuUCLr/wzeFvwfC2q2i8AfacvQ==
X-Received: from pgbcz4.prod.google.com ([2002:a05:6a02:2304:b0:7fd:3f0e:ce05])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da5:b0:1e1:ae68:d900 with SMTP id adf61e73a8af0-1e1dfd61f20mr2903081637.22.1734077447635;
 Fri, 13 Dec 2024 00:10:47 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:30 +0800
In-Reply-To: <20241213081035.2069066-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213081035.2069066-2-davidgow@google.com>
Subject: [PATCH v5 1/3] rust: kunit: add KUnit case and suite macros
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
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
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

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
 rust/kernel/kunit.rs | 118 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 2 files changed, 119 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..5003282cb4c4 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -161,3 +161,121 @@ macro_rules! kunit_assert_eq {
         $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right);
     }};
 }
+
+/// Represents an individual test case.
+///
+/// The test case should have the signature
+/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)`.
+///
+/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of=
 test cases.
+/// Use `kunit_case_null` to generate such a delimeter.
+const fn kunit_case(
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
+/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of=
 test cases. This
+/// function retuns such a delimiter.
+const fn kunit_case_null() -> kernel::bindings::kunit_case {
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
+/// `test_cases` must be a NULL terminated array of test cases.
+///
+/// # Examples
+///
+/// ```ignore
+/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit) {
+///     let actual =3D 1 + 1;
+///     let expected =3D 2;
+///     assert_eq!(actual, expected);
+/// }
+///
+/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case =3D crate::kun=
it_case(name, test_fn);
+/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case =3D crate::kun=
it_case_null();
+/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] =3D uns=
afe {
+///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
+/// };
+/// crate::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
+/// ```
+#[macro_export]
+macro_rules! kunit_unsafe_test_suite {
+    ($name:ident, $test_cases:ident) =3D> {
+        const _: () =3D {
+            static KUNIT_TEST_SUITE_NAME: [i8; 256] =3D {
+                let name_u8 =3D core::stringify!($name).as_bytes();
+                let mut ret =3D [0; 256];
+
+                if name_u8.len() > 255 {
+                    panic!(concat!(
+                        "The test suite name `",
+                        core::stringify!($name),
+                        "` exceeds the maximum length of 255 bytes."
+                    ));
+                }
+
+                let mut i =3D 0;
+                while i < name_u8.len() {
+                    ret[i] =3D name_u8[i] as i8;
+                    i +=3D 1;
+                }
+
+                ret
+            };
+
+            static mut KUNIT_TEST_SUITE: $crate::bindings::kunit_suite =3D
+                $crate::bindings::kunit_suite {
+                    name: KUNIT_TEST_SUITE_NAME,
+                    // SAFETY: User is expected to pass a correct `test_ca=
ses`, hence this macro
+                    // named 'unsafe'.
+                    test_cases: unsafe { $test_cases.as_mut_ptr() },
+                    suite_init: None,
+                    suite_exit: None,
+                    init: None,
+                    exit: None,
+                    attr: $crate::bindings::kunit_attributes {
+                        speed: $crate::bindings::kunit_speed_KUNIT_SPEED_N=
ORMAL,
+                    },
+                    status_comment: [0; 256usize],
+                    debugfs: core::ptr::null_mut(),
+                    log: core::ptr::null_mut(),
+                    suite_init_err: 0,
+                    is_init: false,
+                };
+
+            #[used]
+            #[link_section =3D ".kunit_test_suites"]
+            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::ku=
nit_suite =3D
+                // SAFETY: `KUNIT_TEST_SUITE` is static.
+                unsafe { core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
+        };
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e1065a7551a3..02a70c5ad8ee 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 #![feature(unsize)]
+#![feature(const_mut_refs)]
=20
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
--=20
2.47.1.613.gc27f4b7a9f-goog


