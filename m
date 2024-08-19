Return-Path: <linux-kernel+bounces-292936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC489576AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F2B221C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231CD15A4B0;
	Mon, 19 Aug 2024 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OokaoxRv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40904186E21
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103361; cv=none; b=kKyWFzRAg0UiVQQ6Rb/Ed+KyxRTA455kpLBvXLrD4IzPFE3q5m+XL4XWEo4Kfp4xfvVi943bXAsGJGN33lmOx07MmQzK5KeJwyALImPZB+jw+qV6BUBrR7uZ3Cb23pipcI8FYoq34cRFLen/vku59eNJG00XsTrgV69rsbY1km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103361; c=relaxed/simple;
	bh=QXVwuyABVLpLt6Mh/xtj6wT5oL3WMNpIk4hb6szKexE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DNDqngiz4Mr2j1Z+7UKJlAMwEsd8R6S6xDU9LZieMWY9WnadTbsC61q+LXNPVtHIOWySX75CwBuQzYNbo0vbp3B3PxGOzhK3RVK4zWXxKKzFiRl61FoHq8h5fLGBKtMI+gLtyDZsHf2DbMHbYO56emoIAqVwzGTdnZyjBiOo5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OokaoxRv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b052c5939cso43872397b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724103358; x=1724708158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLZP/QF5cmnVPLPNbpw6BEPvqDqvHQJMieoIEn+0YgI=;
        b=OokaoxRvVng5EXprC6LCOHHlPKkcxYuiL0CcccFRaZGcbu40HxfCs9pC25gYmDWzU6
         OUjKR5gGABsdT6eT6rev/AnkKFMhhx2+kz39SQOeEsl3qUJ4la9PgSZkPZ3UqrqOIPgG
         JBrzsW8s9JuqVgwkixcyji4nJ4Eq9cOCGAcW20RCzjOhx7U0WHH9kqEd02fYX4xSe3IF
         NS/95Z4MBrTWIvqOSBXMUEnKUEu1LlDAUH//osYXgr4UtouN3j8qfjz+3/I+CvTHDhw2
         gbuGWEWQpkezazniVlAnxvrfo+09sLt9V6PYCfaonDektTEjUCI1jfO5tFQUmMgN5RVx
         EbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103358; x=1724708158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLZP/QF5cmnVPLPNbpw6BEPvqDqvHQJMieoIEn+0YgI=;
        b=oL4/LWP9vaAMGVdjxXpNeRJFvvZObdudB+bq1NeJQjBMju3BG9/6ZVeUy0hqKfP40z
         LV37VnVsFUDlRtWBMzopQWWDnyiqeDU/oKBsPjqydGsKdo1CfUkSxbWOsSH01tHM51U7
         mec6IlOS/QRzb49SY+F1UFdToC6iXguJMnAdaz3dUXyJriLzyui+WYXf+ouZta0Gp1Zk
         DQ0lqVm/Z6zAfXsfSKXxMGMo50Jkad4r9zxbqqzTlt+WxBthFVrr7pp1mhd7vFkbkl1g
         zcUdQYroQiLJuKNm7+LnvJAVt4C76E2zRQCRALVgE1ZBPAEPO8nQXNoh0bNsxUFFuZ4W
         hQPA==
X-Forwarded-Encrypted: i=1; AJvYcCWDZlWlYVaPCFarRbA6NBgsPftlE1/HtH/3nJgSk9SGQr/3+i1sExYXV5k1RHHG/xUE35Rk5UUSFYBM3eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+v0lwnfwv3qqjQB+lWkAzdlO7K9Q80sXNGI8PMjwfNzqOefi
	A448j338q/1cjbSkY5GAmoHvS0DYdjNyqV5S4U3yAkqWAMvYtGH+O7Wb6yK1FOGVY07Sh4l09XR
	SzmDS7Q==
X-Google-Smtp-Source: AGHT+IFZS2xXJL0usEpl7aC1i9T/njX/Lp67FzLHxgLhINWz6El3o0+qNCa3oemMpCX7xuFSKtHBgm4HGnGG
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:4d82:b0:644:c4d6:add0 with SMTP
 id 00721157ae682-6bdcdcb9effmr348377b3.1.1724103358288; Mon, 19 Aug 2024
 14:35:58 -0700 (PDT)
Date: Mon, 19 Aug 2024 21:35:22 +0000
In-Reply-To: <20240819213534.4080408-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819213534.4080408-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819213534.4080408-5-mmaurer@google.com>
Subject: [PATCH v3 4/4] kasan: rust: Add KASAN smoke test via UAF
From: Matthew Maurer <mmaurer@google.com>
To: dvyukov@google.com, ojeda@kernel.org, andreyknvl@gmail.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: aliceryhl@google.com, samitolvanen@google.com, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, glider@google.com, Matthew Maurer <mmaurer@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds a smoke test to ensure that KASAN in Rust is actually detecting a
Rust-native UAF. There is significant room to expand this test suite,
but this will at least ensure that flags are having the intended effect.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 mm/kasan/Makefile                         |  9 ++++++++-
 mm/kasan/kasan.h                          |  1 +
 mm/kasan/{kasan_test.c => kasan_test_c.c} | 11 +++++++++++
 mm/kasan/kasan_test_rust.rs               | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)
 rename mm/kasan/{kasan_test.c => kasan_test_c.c} (99%)
 create mode 100644 mm/kasan/kasan_test_rust.rs

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 7634dd2a6128..d718b0f72009 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -44,7 +44,8 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
 CFLAGS_KASAN_TEST += -fno-builtin
 endif
 
-CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
+CFLAGS_kasan_test_c.o := $(CFLAGS_KASAN_TEST)
+RUSTFLAGS_kasan_test_rust.o := $(RUSTFLAGS_KASAN)
 CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
 
 obj-y := common.o report.o
@@ -54,3 +55,9 @@ obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o
 
 obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_test.o
 obj-$(CONFIG_KASAN_MODULE_TEST) += kasan_test_module.o
+
+kasan_test-objs := kasan_test_c.o
+
+ifdef CONFIG_RUST
+kasan_test-objs += kasan_test_rust.o
+endif
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fb2b9ac0659a..e5205746cc85 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -566,6 +566,7 @@ static inline void kasan_kunit_test_suite_end(void) { }
 
 bool kasan_save_enable_multi_shot(void);
 void kasan_restore_multi_shot(bool enabled);
+char kasan_test_rust_uaf(void);
 
 #endif
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test_c.c
similarity index 99%
rename from mm/kasan/kasan_test.c
rename to mm/kasan/kasan_test_c.c
index 7b32be2a3cf0..3a81e85a083f 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1899,6 +1899,16 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+/*
+ * Check that Rust performing a use-after-free using `unsafe` is detected.
+ * This is a smoke test to make sure that Rust is being sanitized properly.
+ */
+static void rust_uaf(struct kunit *test)
+{
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
+}
+
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -1971,6 +1981,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(rust_uaf),
 	{}
 };
 
diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
new file mode 100644
index 000000000000..7239303b232c
--- /dev/null
+++ b/mm/kasan/kasan_test_rust.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Helper crate for KASAN testing
+//! Provides behavior to check the sanitization of Rust code.
+use kernel::prelude::*;
+use core::ptr::addr_of_mut;
+
+/// Trivial UAF - allocate a big vector, grab a pointer partway through,
+/// drop the vector, and touch it.
+#[no_mangle]
+pub extern "C" fn kasan_test_rust_uaf() -> u8 {
+    let mut v: Vec<u8> = Vec::new();
+    for _ in 0..4096 {
+        v.push(0x42, GFP_KERNEL).unwrap();
+    }
+    let ptr: *mut u8 = addr_of_mut!(v[2048]);
+    drop(v);
+    unsafe { *ptr }
+}
-- 
2.46.0.184.g6999bdac58-goog


