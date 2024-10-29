Return-Path: <linux-kernel+bounces-386603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2E9B45AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA599281941
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA61E3DE3;
	Tue, 29 Oct 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWsuspQ4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68BA204923
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193887; cv=none; b=GI8uPk+9wnd/ypW7qVKcOKiB99/PsGtv3NhU00HySN/MHWAUM+X1oxDYoZHVmKHQW1gH1LLcfuez715cC4Pdrs2Q4IFH5Gfn2BN/sNXh3rYuBnf7UBpFNcqvpyYtn/lqEFL6z5eV8Y9vuWFohkN7nrSb+K/DSnt1GIPt32PZBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193887; c=relaxed/simple;
	bh=lvKDYgMcSvvhTyIBb6ECAc1q865WqLsWsBgNoK5wF70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qjw/47Hv9jfEdGrgDECXHYnTjWV/y4W3bSmEA4FUL3zcFQ++81MXUj212iukXmf3PI3p/0XoAkEty6kuxSF8HJUFTTZAJ98U7IYn0XkQVZ3O4M/94mRSqAJ4uiarM/zoM9URptqeNC0OwgNZGGPGLF115KQ6NSX7d9GbeHwpryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWsuspQ4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so105725477b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730193885; x=1730798685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci1oKFH7l7WT9pl4IwsUJvvMv23hze9L/lrXNyoJlVo=;
        b=NWsuspQ4VW5XaQgZXor47tgDVdnrt9Fq80ycCRpfD4phtzLiR/T7C2X4JImcNhwsTY
         o93zF+dQUTDr5VD+m7UgKWfEzLfoSmmug8FCtLOgeMkrAhxpRH6FcZ8IT7sW/lVxrqUv
         wonhjgnHysSjYPah294jE28LVB/cNcEe1jTCr1ZwDWQj69d/uS9vDjUxTi+7C6OCYfV7
         tIxTnnDOsaVuoVKHZHXyF0HPx1l0X2SE37DzSJz7Vfy8Ss39IUMsykztOfBrX1/n/Z35
         8+AAKLoo39AznLENhwdD80zIFr3pIlaALJuNeBWA6cvwRfZiFfeBSPZIXP4ljG041Mda
         lk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193885; x=1730798685;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ci1oKFH7l7WT9pl4IwsUJvvMv23hze9L/lrXNyoJlVo=;
        b=CwFElws5igZjSXlQ4xE08LRKCi05swjER+i2M+Ga6Ec2PdQSsXR0JfQswVcHTF8XN2
         iYrrFDfn7xDPc+LLXZVLbg6Eo30zK90KWgkmftLP3NlbKZ54FF0Rspm6i2SFDnTOvQDK
         GW9GuT/JWv2cy9nhc8iVWdOvrWknk5Te9GZFCQd+NqanWDJO8sH84QP6dUBOkuRmc9GB
         JXVYlQs1wXLOcLNKEAqu5wgfrM0j8ksaiPourI8044ulHlgADn9woHRoB+js+XEAHF6d
         2YGnbH/HljtV/I5shh93qY0XOMQqps3p7JO5pyqnua+Ap3WfgFKYmJNnVdxNs3DmSHk6
         FwvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/yONv1kdRnlqNR+nmrCzS11CksYIfXIWyKTEJeVicmT3fjZdkpC4+/GVD9HsN/BnrpNsochjehKKx9e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyctWzRCPeUPon5XMLHVwxC62Tsr0p7XrVI/O6Baz2/k3WiX2xt
	31jDhq+hAeUwbys/eDOKMNoV5JG2h0SJ7PJdjW+4QScNMhjVQ26evLdqsrD8NjbCqXW5EpV/DIa
	a5+APfqO2BQ==
X-Google-Smtp-Source: AGHT+IEqlyW4/tadreX6bN11wpCmzXQCZWMdmwaTsthqhgrxW9b3cNSTo/5NH/qdY8Gte5je22w3U1+J/ieEyw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a5b:2ca:0:b0:e30:bf92:7a64 with SMTP id
 3f1490d57ef6-e30bf927b96mr1319276.2.1730193884736; Tue, 29 Oct 2024 02:24:44
 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:24:19 +0800
In-Reply-To: <20241029092422.2884505-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029092422.2884505-4-davidgow@google.com>
Subject: [PATCH v2 3/3] rust: kunit: allow to know if we are in a test
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

In some cases, we need to call test-only code from outside the test
case, for example, to mock a function or a module.

In order to check whether we are in a test or not, we need to test if
`CONFIG_KUNIT` is set.
Unfortunately, we cannot rely only on this condition because:
- a test could be running in another thread,
- some distros compile KUnit in production kernels, so checking at runtime
  that `current->kunit_test !=3D NULL` is required.

Forturately, KUnit provides an optimised check in
`kunit_get_current_test()`, which checks CONFIG_KUNIT, a global static
key, and then the current thread's running KUnit test.

Add a safe wrapper function around this to know whether or not we are in
a KUnit test and examples showing how to mock a function and a module.

Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-3-c80db349e3b5@google.com=
/
- Rebased on top of rust-next.
- Use the `kunit_get_current_test()` C function, which wasn't previously
  available, instead of rolling our own.
- (Thanks also to Boqun for suggesting a nicer way of implementing this,
  which I tried, but the `kunit_get_current_test()` version obsoleted.)

---
 rust/kernel/kunit.rs | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index abcf0229ffee..bfc80394546a 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -272,11 +272,83 @@ macro_rules! kunit_unsafe_test_suite {
     };
 }
=20
+/// In some cases, you need to call test-only code from outside the test c=
ase, for example, to
+/// create a function mock. This function can be invoked to know whether w=
e are currently running a
+/// KUnit test or not.
+///
+/// # Examples
+///
+/// This example shows how a function can be mocked to return a well-known=
 value while testing:
+///
+/// ```
+/// # use kernel::kunit::in_kunit_test;
+/// #
+/// fn fn_mock_example(n: i32) -> i32 {
+///     if in_kunit_test() {
+///         100
+///     } else {
+///         n + 1
+///     }
+/// }
+///
+/// let mock_res =3D fn_mock_example(5);
+/// assert_eq!(mock_res, 100);
+/// ```
+///
+/// Sometimes, you don't control the code that needs to be mocked. This ex=
ample shows how the
+/// `bindings` module can be mocked:
+///
+/// ```
+/// // Import our mock naming it as the real module.
+/// #[cfg(CONFIG_KUNIT)]
+/// use bindings_mock_example as bindings;
+///
+/// // This module mocks `bindings`.
+/// mod bindings_mock_example {
+///     use kernel::kunit::in_kunit_test;
+///     use kernel::bindings::u64_;
+///
+///     // Make the other binding functions available.
+///     pub(crate) use kernel::bindings::*;
+///
+///     // Mock `ktime_get_boot_fast_ns` to return a well-known value when=
 running a KUnit test.
+///     pub(crate) unsafe fn ktime_get_boot_fast_ns() -> u64_ {
+///         if in_kunit_test() {
+///             1234
+///         } else {
+///             unsafe { kernel::bindings::ktime_get_boot_fast_ns() }
+///         }
+///     }
+/// }
+///
+/// // This is the function we want to test. Since `bindings` has been moc=
ked, we can use its
+/// // functions seamlessly.
+/// fn get_boot_ns() -> u64 {
+///     unsafe { bindings::ktime_get_boot_fast_ns() }
+/// }
+///
+/// let time =3D get_boot_ns();
+/// assert_eq!(time, 1234);
+/// ```
+pub fn in_kunit_test() -> bool {
+    // SAFETY: kunit_get_current_test() is always safe to call from C (it =
has fallbacks for
+    // when KUnit is not enabled), and we're only comparing the result to =
NULL.
+    unsafe { !bindings::kunit_get_current_test().is_null() }
+}
+
 #[kunit_tests(rust_kernel_kunit)]
 mod tests {
+    use super::*;
+
     #[test]
     fn rust_test_kunit_kunit_tests() {
         let running =3D true;
         assert_eq!(running, true);
     }
+
+    #[test]
+    fn rust_test_kunit_in_kunit_test() {
+        let in_kunit =3D in_kunit_test();
+        assert_eq!(in_kunit, true);
+    }
 }
--=20
2.47.0.163.g1226f6d8fa-goog


