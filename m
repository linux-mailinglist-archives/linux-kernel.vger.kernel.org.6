Return-Path: <linux-kernel+bounces-404670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41AC9C4670
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65F4B21333
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D31AAE1A;
	Mon, 11 Nov 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqoaqqR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7701BC4E;
	Mon, 11 Nov 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356209; cv=none; b=G1wzDqyRfpAxl67R3eMbyASuqyqMgcJKU6zNDU2ZBZPENwktfuv40W0C7125+jRSuwH92OE0l8XWLECs8CqFWSPDxmlL+EleOUpzfLMlkmBySUigET53hfs3iZuW0pAVtvkN50Cpo0FmEbUX4+MS7aQUVH1plyQjtH6kkqwHRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356209; c=relaxed/simple;
	bh=CwAXbOxrmH689Ea3tdgf8f02pWsjJIlJAoVkv53F2ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ay8kNfWaKRdVTg+YtciTPHbMnRHx/9EimC0xc6a/P13ssD9cbFt/FPg/3foOR5wWPf+IXSz/cvRU1vUs0JEFA3o9+RCB+BuEHsnhdZhkXj+YjtStYNytEteG+NqoIIkNo468uzwVcTXQLyTWdRjoOc1awwKQXm+9hN7KeJXrlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqoaqqR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB4EC4CECF;
	Mon, 11 Nov 2024 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731356209;
	bh=CwAXbOxrmH689Ea3tdgf8f02pWsjJIlJAoVkv53F2ug=;
	h=From:To:Cc:Subject:Date:From;
	b=gqoaqqR5q9K0BDuMuxpM8V7JvQAm/5HzvsjRVtt88NBcpQSadZWWoAb1onaMePqU4
	 J2TGClTRxzydahccp+si7LOvMnJGZ3RE2Ihvc1xt3kSca9Z2tPwSlImzruo5QlXcoy
	 hhav0/18c53T8d+yFMD93wX4me9lSvaLCwOYpggeqpYEgwy9lqdJSW+nxeBsK9JgYm
	 fLx1x9ZUE48DuKFOThVfnA1aT2vy/pb5XLCZFPI3+KtkmH3aSuEskWYMJM9n5+qQcY
	 8mU0XLzmIBsFp5IcOYzgdkTlS6cKRc/8/+YyE5BzYVYtvj7EaKRLemhxU4OgB2MYM1
	 +Yq8cDMS1Q20w==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Ben Beasley <code@musicinmybrain.net>,
	NoisyCoil <noisycoil@tutanota.com>,
	Matthias Geiger <werdahias@riseup.net>
Subject: [PATCH v2] rust: warn on bindgen < 0.69.5 and libclang >= 19.1
Date: Mon, 11 Nov 2024 21:16:07 +0100
Message-ID: <20241111201607.653149-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing a `clang` upgrade with Rust Binder, Alice encountered [1] a
build failure caused by `bindgen` not translating some symbols related to
tracepoints. This was caused by commit 2e770edd8ce1 ("[libclang] Compute
the right spelling location") changing the behavior of a function exposed
by `libclang`. `bindgen` fixed the regression in commit 600f63895f73
("Use clang_getFileLocation instead of clang_getSpellingLocation").

However, the regression fix is only available in `bindgen` versions
0.69.5 or later (it was backported for 0.69.x). This means that when
older bindgen versions are used with new versions of `libclang`, `bindgen`
may do the wrong thing, which could lead to a build failure.

Alice encountered the bug with some header files related to tracepoints,
but it could also cause build failures in other circumstances. Thus,
always emit a warning when using an old `bindgen` with a new `libclang`
so that other people do not have to spend time chasing down the same
bug.

However, testing just the version is inconvenient, since distributions
do patch their packages without changing the version, so I reduced the
issue into the following piece of code that can trigger the issue:

    #define F(x) int x##x
    F(foo);

In particular, an unpatched `bindgen` will ignore the macro expansion
and thus not provide a declaration for the exported `int`.

Thus add a build test to `rust_is_available.sh` using the code above
(that is only triggered if the versions appear to be affected), following
what we did for the 0.66.x issue.

Moreover, I checked the status in the major distributions we have
instructions for:

  - Fedora 41 was affected but is now OK, since it now ships `bindgen`
    0.69.5.

    Thanks Ben for the quick reply on the updates that were ongoing.

    Fedora 40 and earlier are OK (older `libclang`, and they also now
    carry `bindgen` 0.69.5).

  - Debian Sid was affected but is now OK, since they now ship a patched
    `bindgen` binary (0.66.1-7+b3). The issue was reported to Debian by
    email and then as a bug report [2].

    Thanks NoisyCoil and Matthias for the quick replies. NoisyCoil handled
    the needed updates. Debian may upgrade to `bindgen` 0.70.x, too.

    Debian Testing is OK (older `libclang` so far).

  - Ubuntu non-LTS (oracular) is affected. The issue was reported to Ubuntu
    by email and then as a bug report [3].

    Ubuntu LTS is not affected (older `libclang` so far).

  - Arch Linux, Gentoo Linux and openSUSE should be OK (newer `bindgen` is
    provided). Nix as well (older `libclang` so far).

This issue was also added to our "live list" that tracks issues around
distributions [4].

Cc: Ben Beasley <code@musicinmybrain.net>
Cc: NoisyCoil <noisycoil@tutanota.com>
Cc: Matthias Geiger <werdahias@riseup.net>
Link: https://lore.kernel.org/rust-for-linux/20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com/ [1]
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1086510 [2]
Link: https://bugs.launchpad.net/ubuntu/+source/rust-bindgen-cli/+bug/2086639 [3]
Link: https://github.com/Rust-for-Linux/linux/issues/1127 [4]
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
We would like to put this into the merge window, or ideally very soon after as a
"fix" (it is not really a fix, but it is very convenient for people wondering
why their toolchain may not work, especially if tracepoints land in the merge
window as expected).

v2 (based on Alice's v1):
  - Fixed libclang version number (we use a different `get_canonical_version`
    that returns one more digit).
  - Added build test -- now we can detect binaries like Debian's that are
    patched but do not change the version number.
  - Added tests.
  - Explained the current status of the distributions in the commit message.

 scripts/rust_is_available.sh                  | 15 ++++++++
 ...ust_is_available_bindgen_libclang_concat.h |  3 ++
 scripts/rust_is_available_test.py             | 34 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 scripts/rust_is_available_bindgen_libclang_concat.h

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 5262c56dd674..93c0ef7fb3fb 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -225,6 +225,21 @@ if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
 	exit 1
 fi

+if [ "$bindgen_libclang_cversion" -ge 1900100 ] &&
+	[ "$rust_bindings_generator_cversion" -lt 6905 ]; then
+	# Distributions may have patched the issue (e.g. Debian did).
+	if ! "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang_concat.h | grep -q foofoo; then
+		echo >&2 "***"
+		echo >&2 "*** Rust bindings generator '$BINDGEN' < 0.69.5 together with libclang >= 19.1"
+		echo >&2 "*** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),"
+		echo >&2 "*** unless patched (like Debian's)."
+		echo >&2 "***   Your bindgen version:  $rust_bindings_generator_version"
+		echo >&2 "***   Your libclang version: $bindgen_libclang_version"
+		echo >&2 "***"
+		warning=1
+	fi
+fi
+
 # If the C compiler is Clang, then we can also check whether its version
 # matches the `libclang` version used by the Rust bindings generator.
 #
diff --git a/scripts/rust_is_available_bindgen_libclang_concat.h b/scripts/rust_is_available_bindgen_libclang_concat.h
new file mode 100644
index 000000000000..efc6e98d0f1d
--- /dev/null
+++ b/scripts/rust_is_available_bindgen_libclang_concat.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define F(x) int x##x
+F(foo);
diff --git a/scripts/rust_is_available_test.py b/scripts/rust_is_available_test.py
index 413741037fb3..4fcc319dea84 100755
--- a/scripts/rust_is_available_test.py
+++ b/scripts/rust_is_available_test.py
@@ -54,7 +54,7 @@ else:
 """)

     @classmethod
-    def generate_bindgen(cls, version_stdout, libclang_stderr, version_0_66_patched=False):
+    def generate_bindgen(cls, version_stdout, libclang_stderr, version_0_66_patched=False, libclang_concat_patched=False):
         if libclang_stderr is None:
             libclang_case = f"raise SystemExit({cls.bindgen_default_bindgen_libclang_failure_exit_code})"
         else:
@@ -65,12 +65,19 @@ else:
         else:
             version_0_66_case = "raise SystemExit(1)"

+        if libclang_concat_patched:
+            libclang_concat_case = "print('pub static mut foofoo: ::std::os::raw::c_int;')"
+        else:
+            libclang_concat_case = "pass"
+
         return cls.generate_executable(f"""#!/usr/bin/env python3
 import sys
 if "rust_is_available_bindgen_libclang.h" in " ".join(sys.argv):
     {libclang_case}
 elif "rust_is_available_bindgen_0_66.h" in " ".join(sys.argv):
     {version_0_66_case}
+elif "rust_is_available_bindgen_libclang_concat.h" in " ".join(sys.argv):
+    {libclang_concat_case}
 else:
     print({repr(version_stdout)})
 """)
@@ -268,6 +275,31 @@ else:
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
         self.assertIn(f"libclang (used by the Rust bindings generator '{bindgen}') is too old.", result.stderr)

+    def test_bindgen_bad_libclang_concat(self):
+        for (bindgen_version, libclang_version, expected_not_patched) in (
+            ("0.69.4", "18.0.0", self.Expected.SUCCESS),
+            ("0.69.4", "19.1.0", self.Expected.SUCCESS_WITH_WARNINGS),
+            ("0.69.4", "19.2.0", self.Expected.SUCCESS_WITH_WARNINGS),
+
+            ("0.69.5", "18.0.0", self.Expected.SUCCESS),
+            ("0.69.5", "19.1.0", self.Expected.SUCCESS),
+            ("0.69.5", "19.2.0", self.Expected.SUCCESS),
+
+            ("0.70.0", "18.0.0", self.Expected.SUCCESS),
+            ("0.70.0", "19.1.0", self.Expected.SUCCESS),
+            ("0.70.0", "19.2.0", self.Expected.SUCCESS),
+        ):
+            with self.subTest(bindgen_version=bindgen_version, libclang_version=libclang_version):
+                cc = self.generate_clang(f"clang version {libclang_version}")
+                libclang_stderr = f"scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version {libclang_version} [-W#pragma-messages], err: false"
+                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr)
+                result = self.run_script(expected_not_patched, { "BINDGEN": bindgen, "CC": cc })
+                if expected_not_patched == self.Expected.SUCCESS_WITH_WARNINGS:
+                    self.assertIn(f"Rust bindings generator '{bindgen}' < 0.69.5 together with libclang >= 19.1", result.stderr)
+
+                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr, libclang_concat_patched=True)
+                result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen, "CC": cc })
+
     def test_clang_matches_bindgen_libclang_different_bindgen(self):
         bindgen = self.generate_bindgen_libclang("scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version 999.0.0 [-W#pragma-messages], err: false")
         result = self.run_script(self.Expected.SUCCESS_WITH_WARNINGS, { "BINDGEN": bindgen })

base-commit: ae7851c29747fa3765ecb722fe722117a346f988
--
2.47.0

