Return-Path: <linux-kernel+bounces-386602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9199B45A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E1EB21618
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B01E1042;
	Tue, 29 Oct 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4FbJqFL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D2204092
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193883; cv=none; b=T/gWvL5+U3UUNr0Zfm796NpxWdT7hEPf5X/9bfG6N2ZfRusKBVx8cCqFhq9vcFpcFA8snUF7YxnF3NS9G3QqieGVJ97a/BojT0B7040wOOx0g9ZBFkMAy3fYJ9Tfq6VPJSHB6pVdD4D3i8Dn3mgxW079HlQwETtsgjqlA3IWXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193883; c=relaxed/simple;
	bh=4kN9i92hlnE0wmXPl+ENU7TbH9RwQ/rN4/YrZobYVrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNmDj09waumlDfD6yWRf33uqbfys3osb9q5PoHDLT46UzQ7EotfssVL/4F8wbE3f24n/PQTWgXwotX76m3+ZtKHdEVDZfpl7QZf2pFMu9pIpW3oyRs9xKB78G8yWigbG97EU7tlE50lCavir37w4m5LgQPtPC/AJVgQ8xp9Z2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4FbJqFL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30c7a38bd7so195540276.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730193880; x=1730798680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e/K1PoHQ1ZWLXaF3jCF9hLNTpdzMLuZ5eUsJNHKGQU=;
        b=J4FbJqFLSIoY71yomsudA3Fw+03kFxVCoBmxXRQMXIXB66t5c/hW5tteYFxuWT/Wyl
         +EY6mx8jtyTzpPzZ2g/LkuizP+Nkjw/n4bUqyNEl8OeOUCPGj8ehIDsOOiKjELgdItiv
         lUGffSTcjW2YflhXCh/PBtngVlGZh126a7UUjj8BiDEOJcwdbRNod7YnAosfGuLjEsvE
         RN7lR0reB+sDk4830TYMBo8vB4NuMHvC7S34Vnm2oFdjVoRndOroblGW7FPeZRWWI+3o
         tbOedO0kQgFwy3wPwuPRX60kHDk8QYKp19IcTAnfH6+ZRusFClO4WZcUu8TrazZ31vD4
         8c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193880; x=1730798680;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/e/K1PoHQ1ZWLXaF3jCF9hLNTpdzMLuZ5eUsJNHKGQU=;
        b=KT+o5HyKgSRJ+U/FO7Y6z5FwGrvQDo5WT5tGYsU8RqkvW3zb9DDMc3ptp68Hxz1wyl
         Ood/ODrIpT67I+u9d6hXG8ZQ5bvSMAjewWybS592c4Hk1IsU9X80GHHFyDUoMPjXHGuj
         DlOCHqNPxuD7W3YJblC2mcfIqHTgcruc3TSV83HfPh1zyFhv9iyP8IxTMH8jDUR2J2FB
         o+InSghfFzvBINQtXKg0y4eZwj08Q/s502NoSM9T4LM/ZwVvmWo0TgUy+tZui8YGOIqu
         Ijm5plr2Xsz2GMC1yM8T6vNAb+fgSDuUOKQfk+aj2iuDoTWrcfM2EQFmSazRdCB9PGYv
         cDXw==
X-Forwarded-Encrypted: i=1; AJvYcCUr9Ir3vTKrn488LE8apR8m4w7NiToNlfD+FFrCQg7lzrUEcND30E3RPXJxtwECXcdWXRn8g9eQ0IIrZOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmpy7WyaORoT9YdgcarvCluYgSqgdbTrXD/AZcsKj2ewrPzIU
	7JEwWRovploKpLSMUR0iUC1L0ZSQouQVdEu52ayyrUIRRWzABopYwetU4UkKkixQrjtClYOe+rj
	A4dGLtWtdwQ==
X-Google-Smtp-Source: AGHT+IHb7K7be6vvr7Lz0o1myzy7kRdN5S2epEVxI2qbDBPCGbnJZwBdPfhyQpr+WatB5sq5LzQNvAGK5j80sQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a5b:750:0:b0:e26:3788:9ea2 with SMTP id
 3f1490d57ef6-e30c16724f7mr21596276.0.1730193880123; Tue, 29 Oct 2024 02:24:40
 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:24:18 +0800
In-Reply-To: <20241029092422.2884505-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029092422.2884505-3-davidgow@google.com>
Subject: [PATCH v2 2/3] rust: macros: add macro to easily run KUnit tests
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

Add a new procedural macro (`#[kunit_tests(kunit_test_suit_name)]`) to
run KUnit tests using a user-space like syntax.

The macro, that should be used on modules, transforms every `#[test]`
in a `kunit_case!` and adds a `kunit_unsafe_test_suite!` registering
all of them.

The only difference with user-space tests is that instead of using
`#[cfg(test)]`, `#[kunit_tests(kunit_test_suit_name)]` is used.

Note that `#[cfg(CONFIG_KUNIT)]` is added so the test module is not
compiled when `CONFIG_KUNIT` is set to `n`.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
[Updated to use new const fn.]
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google.com=
/
- Rebased on top of rust-next
- Make use of the new const functions, rather than the kunit_case!()
  macro.

---
 MAINTAINERS          |  1 +
 rust/kernel/kunit.rs | 11 +++++++++++
 rust/macros/lib.rs   | 29 +++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b77f4495dcf4..b65035ede675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12433,6 +12433,7 @@ F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
 F:	rust/kernel/kunit.rs
+F:	rust/macros/kunit.rs
 F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
=20
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index fc2d259db458..abcf0229ffee 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -40,6 +40,8 @@ pub fn info(args: fmt::Arguments<'_>) {
     }
 }
=20
+use macros::kunit_tests;
+
 /// Asserts that a boolean expression is `true` at runtime.
 ///
 /// Public but hidden since it should only be used from generated tests.
@@ -269,3 +271,12 @@ macro_rules! kunit_unsafe_test_suite {
         };
     };
 }
+
+#[kunit_tests(rust_kernel_kunit)]
+mod tests {
+    #[test]
+    fn rust_test_kunit_kunit_tests() {
+        let running =3D true;
+        assert_eq!(running, true);
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 939ae00b723a..098925b99982 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -10,6 +10,7 @@
 mod quote;
 mod concat_idents;
 mod helpers;
+mod kunit;
 mod module;
 mod paste;
 mod pin_data;
@@ -430,3 +431,31 @@ pub fn paste(input: TokenStream) -> TokenStream {
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
     zeroable::derive(input)
 }
+
+/// Registers a KUnit test suite and its test cases using a user-space lik=
e syntax.
+///
+/// This macro should be used on modules. If `CONFIG_KUNIT` (in `.config`)=
 is `n`, the target module
+/// is ignored.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use macros::kunit_tests;
+///
+/// #[kunit_tests(kunit_test_suit_name)]
+/// mod tests {
+///     #[test]
+///     fn foo() {
+///         assert_eq!(1, 1);
+///     }
+///
+///     #[test]
+///     fn bar() {
+///         assert_eq!(2, 2);
+///     }
+/// }
+/// ```
+#[proc_macro_attribute]
+pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
+    kunit::kunit_tests(attr, ts)
+}
--=20
2.47.0.163.g1226f6d8fa-goog


