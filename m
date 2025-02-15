Return-Path: <linux-kernel+bounces-516083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43827A36CC3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FCC3AD85A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC61A317D;
	Sat, 15 Feb 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoTdf/5p"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559891A3031
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610406; cv=none; b=LwKEPvNn0ZtJG+0xKuLC5UbPEnkKVtyx+gWFdqNkpXjastKgf334Bepi+qI6r0LcQSkWzvS0EHv1SuYe3vOMC8dwEB0BVrirOqka6NcgS5oGv9Ex+p8j0WLo6ssvcwn5qlsZA+kPvW449YNxuM9+WvkCaaTIBOmHIcpz/M/QWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610406; c=relaxed/simple;
	bh=Brif0Uu+CgbP+MFCn/3eNgcrnGLZavM1s9AzupsE6jE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t1slfBPVMLjgkF/2yPypfkks3SGRdDV9sSNBGI79ipoH8QJuAMxiXKjLh/IAv7AelfJC9//ToqHAUrJONb5WTY6/LqK7a/WfOjhdZUW806+g8QFU25c1flVJaSnV2Xk3LltcMLA5uB8B9+71SbKHFfXh6MhFZfwU8sNXCp2k2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uoTdf/5p; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d6018858so45960555ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610404; x=1740215204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNO63Q8fUF1rvzf4dCO7HftqO6PY/IYB86cB56hZgtY=;
        b=uoTdf/5pTEcoBE0ehDSoWcWeEIVRVHRO2MRuBWYcq2/frZp+db8ol+6jXL6YsTpA5u
         0eAfHfDEYa2ggvV1jV38g77DhAyG6EleEGespzvyxXmnmRi6YqRB81BNpLrAk68DE0j1
         FP+ztuVSz2/bNmYoIsT1abiz+QFBB15/vy+0S6YFa4hW9ar4I0+wv9AWF0Vaf5do3//6
         QPdcuJM/EgGYpX0od4ae3+3jh1NWAsv79/xZnYBR/kvtb8w6P+Rj39f/WNOEU6sFEwnQ
         3nA+TZqfuB2wItnnYqYBF5wUeJTI8BC/6GUhoqtsFsJA0UAAWB8TPJwhmcBQD+9zXmOq
         pbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610404; x=1740215204;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNO63Q8fUF1rvzf4dCO7HftqO6PY/IYB86cB56hZgtY=;
        b=Qmij5wOTf8VdMAV2yAGktONMpS9BJRE0qzpx92x5nrcN/J3JXCDHLh4C6t+Td+X0nm
         MpVP46bZZW3kNVP7lvNd3KvSSrExPK23f69sEynszi0uP9Le7JiYlODykN7edZd7CaZ2
         INL19pe43uWYefGP3c8k9LYaC6u4nqvlgXr1Y9jgynwQNmH60NFaaLFP0WsU51r5A+8K
         0kfAC7umrnsCtvr45ziY6xIKZEln0l0VY8h1ThmQJQ/ZG2KBRXIDzYZRcspzCiSR1VTH
         ZH0N3wfz0rJIVJ+zJwppdKD0k+a2uKoElBo7Rle9yjAgP0CpDbfNeFRteMFKltVzU93X
         LDdA==
X-Forwarded-Encrypted: i=1; AJvYcCXFRTEfUzoS8d6xlkQsrqr0Oo3OsCMXDZNq1h3d+KLBgkXTzuFLfX5R9WOf7HIZfWoJuIvLb4Hn/Kz22nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1brOA3mq/NnWAORIrMmIqESO0AqSPIBIa+rPGCDArOs9hhF3
	7qV/+f2/fU4QgsGF0Rs0rvlGt9LCJQmkdknx7QO6xawMQE8ZzazR7RwXDEuVXVHb/A1jbCISabI
	3tx3+MT1+kg==
X-Google-Smtp-Source: AGHT+IHtFENxipav4o9tqRA/ja1GzbDCGx7710bdD1BFLEpzmG+fgognz6SYkYpQwhD6qiYIX2BeQfkGlf/crg==
X-Received: from pfbbq17.prod.google.com ([2002:a05:6a00:e11:b0:732:222e:ac25])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:999e:b0:1dc:7907:6d67 with SMTP id adf61e73a8af0-1ee8cbf7a69mr4953468637.40.1739610404506;
 Sat, 15 Feb 2025 01:06:44 -0800 (PST)
Date: Sat, 15 Feb 2025 17:06:20 +0800
In-Reply-To: <20250215090622.2381038-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215090622.2381038-1-davidgow@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215090622.2381038-4-davidgow@google.com>
Subject: [PATCH v7 3/3] rust: kunit: allow to know if we are in a test
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
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-4-davidgow@go=
ogle.com/
- Doc comments now have a useful link. (Thanks, Tamir!)
- A small tidy-up to limit unsafe usage. (Thanks, Tamir!)

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-4-davidgow@google.com/
- Greatly improved documentation, which is both clearer and better
  matches the rustdoc norm. (Thanks, Miguel)
- The examples and safety comments are also both more idiomatic an
  cleaner. (Thanks, Miguel)
- More things sit appropriately behind CONFIG_KUNIT (Thanks, Miguel)

Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-4-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- Fix some missing safety comments, and remove some unneeded 'unsafe'
  blocks. (Thanks Boqun)

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-8-davidgow@g=
oogle.com/
- The example test has been updated to no longer use assert_eq!() with
  a constant bool argument (fixes a clippy warning).

No changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-4-davidgow@g=
oogle.com/

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-3-c80db349e3b5@google.com=
/
- Rebased on top of rust-next.
- Use the `kunit_get_current_test()` C function, which wasn't previously
  available, instead of rolling our own.
- (Thanks also to Boqun for suggesting a nicer way of implementing this,
  which I tried, but the `kunit_get_current_test()` version obsoleted.)
---
 rust/kernel/kunit.rs | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 2131443a5f1e..91aa49da0265 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -286,11 +286,77 @@ macro_rules! kunit_unsafe_test_suite {
     };
 }
=20
+/// Returns whether we are currently running a KUnit test.
+///
+/// In some cases, you need to call test-only code from outside the test c=
ase, for example, to
+/// create a function mock. This function allows to change behavior depend=
ing on whether we are
+/// currently running a KUnit test or not.
+///
+/// # Examples
+///
+/// This example shows how a function can be mocked to return a well-known=
 value while testing:
+///
+/// ```
+/// # use kernel::kunit::in_kunit_test;
+/// fn fn_mock_example(n: i32) -> i32 {
+///     if in_kunit_test() {
+///         return 100;
+///     }
+///
+///     n + 1
+/// }
+///
+/// let mock_res =3D fn_mock_example(5);
+/// assert_eq!(mock_res, 100);
+/// ```
+///
+/// Sometimes, you don't control the code that needs to be mocked. This ex=
ample shows how the
+/// [`bindings`] module can be mocked:
+///
+/// ```
+/// // Import our mock naming it as the real module.
+/// #[cfg(CONFIG_KUNIT)]
+/// use bindings_mock_example as bindings;
+/// #[cfg(not(CONFIG_KUNIT))]
+/// use kernel::bindings;
+///
+/// // This module mocks `bindings`.
+/// #[cfg(CONFIG_KUNIT)]
+/// mod bindings_mock_example {
+///     /// Mock `ktime_get_boot_fast_ns` to return a well-known value whe=
n running a KUnit test.
+///     pub(crate) fn ktime_get_boot_fast_ns() -> u64 {
+///         1234
+///     }
+/// }
+///
+/// // This is the function we want to test. Since `bindings` has been moc=
ked, we can use its
+/// // functions seamlessly.
+/// fn get_boot_ns() -> u64 {
+///     // SAFETY: `ktime_get_boot_fast_ns()` is always safe to call.
+///     unsafe { bindings::ktime_get_boot_fast_ns() }
+/// }
+///
+/// let time =3D get_boot_ns();
+/// assert_eq!(time, 1234);
+/// ```
+pub fn in_kunit_test() -> bool {
+    // SAFETY: `kunit_get_current_test()` is always safe to call (it has f=
allbacks for
+    // when KUnit is not enabled).
+    !unsafe { bindings::kunit_get_current_test() }.is_null()
+}
+
 #[kunit_tests(rust_kernel_kunit)]
 mod tests {
+    use super::*;
+
     #[test]
     fn rust_test_kunit_example_test() {
         #![expect(clippy::eq_op)]
         assert_eq!(1 + 1, 2);
     }
+
+    #[test]
+    fn rust_test_kunit_in_kunit_test() {
+        assert!(in_kunit_test());
+    }
 }
--=20
2.48.1.601.g30ceb7b040-goog


