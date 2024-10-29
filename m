Return-Path: <linux-kernel+bounces-386601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB59B45A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1381C20F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B01E7676;
	Tue, 29 Oct 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHi61SHZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED92038A3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193879; cv=none; b=MocDPS0Rq3kofAQg40/BE0dS8cR93Tgwvsnd2IiWFoDn2g5bXTD9YhhK8Of0r8qatLtkF1M+1kbxgpxtqBMVI410vqgvSWD+04MsbrX/yTTmjm4dD8qoMRVA0zltbgFX+XQEd8T9bwwPkQ0X47Eqj7NdbyCxeMqqQBPPV1t1yBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193879; c=relaxed/simple;
	bh=PUMO2JTw0uvnOJgP4Hq9WzubmyTpwyBsUVVr5ZHXO6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ts8hPeoo+PgM2MowNK1OUElUxcRAzLsbjDXkphjMc88/dDoFHAk5IwBjtWoZHvVPUGPpRRKrQaJ3PitCPYnL+bqT7PEl+xSEuW+tAycZDY34wAKBfobXp3uipq0BcNUWigVVpT6QuDqwIwIEc7IbrVB2GRitvtISCWUnrpSO834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHi61SHZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7f633af02so74848797b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730193876; x=1730798676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZuhMQVPTPymU7myQUR1VYa3MCKqa4irr2PmBoZb9nA=;
        b=gHi61SHZ+007DRjWvu+k5lukOjNH1Bc9XKV4l3DYfPbwVfQgeOOYdgpOiyDlAcPUWY
         XX0vVU6Xt/EnmZH4o/Ep+4O5dacZb4q7bQyWwh1nwtf5oFcfcN6Yg2VTj7MbjUTvv7wv
         gn7JQj50DA7C9YxC3qIB9P8JB1S1tmPXNwxOPGHePzB7V/6i6y7Uc+aJmDKVeWRSdwN3
         ctNj5j/x6If0n2mVe1k6kSxy2cil1ur/DCqjILauIL0MmK0o9EMRGyZisi5TYdRPZfCt
         RUYUMLGPF9yaXqA7vbMDDC49kP+ySlbQHnNoquk46ZMVf95WGPQnSiNizNjm1mkHeZDj
         4QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193876; x=1730798676;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZuhMQVPTPymU7myQUR1VYa3MCKqa4irr2PmBoZb9nA=;
        b=NCrA2KVTtuy8eQWpw3LmHwECeUdpn4Uc4RPyMe/SQFX++yNUOwQP6FJIThY/LANPZM
         Il4LmsJ1XNn1Siaj7VGS38xuZF6JTrs6ooWLyCnB91xj55/2gjjLkYgwDRTpQxfMdcc0
         64z/dK6QV/W04gED1COXLsP+5rUuPC5oUb5ZB9fnSMohqz8kAOYuLzlw5poCHMjoyblH
         d2I2iZE/eNE5rfqiCKLnGwwljMwuyh6tn/mg2OWAQhzK99w/ehJ6ikOyAJej1VFeHpij
         ahPcI4yksajblx1SMV2/MEPeT/aWGZwCou5YF8zo06utQCfERlc55ZglsZu22h07kUcd
         rbVw==
X-Forwarded-Encrypted: i=1; AJvYcCXw/HZBfDS9BEnRgyJOhCYTl2LR14HdFY+Ewmoq9QzY2og09j26w291ezCEBqrXZZFmyvLgjwvKWvQ0wFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIYAuqqs4KA/qRCqW7xGYaa0wBiMfDY04PyZzgkWFuBRVFheK
	Vb3sQ8BA08gBttj6TW27iaCvdY2tbefQp8Lq2XipYIn16+9SZpnnJQ2LrArZsDYSFmjuP+9fKHe
	6aU7M6pUl+g==
X-Google-Smtp-Source: AGHT+IHK8ryBZsvSi4wvFVc+Ay6NDJsB7SRCJCku/YEE0/wdui/z1CUXbVkxSDodtLGAZ8vJdEdaFz5r5Ory0A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:6902:b02:b0:e30:b820:dd14 with SMTP
 id 3f1490d57ef6-e30b820defemr117546276.9.1730193875754; Tue, 29 Oct 2024
 02:24:35 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:24:17 +0800
In-Reply-To: <20241029092422.2884505-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029092422.2884505-2-davidgow@google.com>
Subject: [PATCH v2 1/3] rust: kunit: add KUnit case and suite macros
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
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
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google.com=
/
- Rebase on top of rust-next
- As a result, KUnit attributes are new set. These are hardcoded to the
  defaults of "normal" speed and no module name.
- Split the kunit_case!() macro into two const functions, kunit_case()
  and kunit_case_null() (for the NULL terminator).

---
 rust/kernel/kunit.rs | 108 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 2 files changed, 109 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..fc2d259db458 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -161,3 +161,111 @@ macro_rules! kunit_assert_eq {
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
+const fn kunit_case(name: &kernel::str::CStr, run_case: unsafe extern "C" =
fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_case {
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
+                let mut i =3D 0;
+                while i < name_u8.len() {
+                    ret[i] =3D name_u8[i] as i8;
+                    i +=3D 1;
+                }
+
+                ret
+            };
+
+            static mut KUNIT_TEST_SUITE: core::cell::UnsafeCell<$crate::bi=
ndings::kunit_suite> =3D
+                core::cell::UnsafeCell::new($crate::bindings::kunit_suite =
{
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
+                });
+
+            #[used]
+            #[link_section =3D ".kunit_test_suites"]
+            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::ku=
nit_suite =3D
+                // SAFETY: `KUNIT_TEST_SUITE` is static.
+                unsafe { KUNIT_TEST_SUITE.get() };
+        };
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b62451f64f6e..d662aa37070f 100644
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
2.47.0.163.g1226f6d8fa-goog


