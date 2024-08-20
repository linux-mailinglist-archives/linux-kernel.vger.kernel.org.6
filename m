Return-Path: <linux-kernel+bounces-294529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEDA958ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4CB284D55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C07818EFD3;
	Tue, 20 Aug 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEBZ9ayU"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570D15FA75
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183373; cv=none; b=YGVAM/xcjOBXxfjR82fqqssOq6e4EjNxNUr5QQudEXBP52RxrCWanverxEWeL5rv8gaJZaXZuzKlsOmTFOypELXGYQ4ApMNHzHN8Eqz0ceowyGEBEh9iWTa/ygvrOI5egEsxhVrCxOTCtvyd5USyUq1G1u1mh1NC/fXGZqHTuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183373; c=relaxed/simple;
	bh=8XWZ6O1XvhCqlug5YfbNiQOFcwfew8ASeXNhq6EHhmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r/kHNXLonQdfQDBSqJwtDIB6rKs2Y6yaxg19s41lx7OB/5V8+UabAukuBq4iZXUIdcdtX5tnCdZ5Ibe7HzjdtkmlFUHQIe+0b0+DpqU55KXq7qHCZizu1ikaAgjvip3EBrIj6z+EBf4yO16bO2SN1+266DtetDkMbcZlucv4AD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEBZ9ayU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e165d8c8c28so847427276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724183371; x=1724788171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IttCgeBRXfLGGSRTMWMVTYyC3qQ0hIHeZRv9TWbyvy4=;
        b=fEBZ9ayUoX5VSqHR7O/sNKkhlBZTpwWBCIFFsUztQE0fUNrxu156vo64dBbREfFSka
         nEGwwQl8mH6LM4dV3FhmwR8XiBGzQU3JjJlfRgLZrGSXq4g3nJigTVQ/0hC8yu+pXf+9
         RDW1UzPHgZL8gLNg5jX4UhCAZP+0Y+0C1yLB5aLB9IE/Ci7v44oKa/bgWMBXKAdpdokZ
         z+5iEDmp18eY+Q2CIy2kH+tzpwJoR55V7QXr1lH/k5QvJKBNMm49qjlTspYIIHmS3kiy
         LMqoGp3nhsUb7/7dKjOhvxRYb9Mti0WJ7rji7ol4Lyyzz2IbB1NloQuYkDRYwEdW28Lf
         JrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183371; x=1724788171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IttCgeBRXfLGGSRTMWMVTYyC3qQ0hIHeZRv9TWbyvy4=;
        b=juRGTDpV889JEsvESGWe6QkFPeJAZEHfKz/wD4tyufxygC+U2e9d2nAP7ZyxI/v15T
         ioUJlFzCP0AYTLnttsFGQItskr/m7G7KtVNd8vHw0yAYoaEuyt6+qpxBJdcTX/ltjbyM
         K3eWhTFV1zw9jPWI8NDGw6Jbg9/j5/XTH+HAA1i8YYHMWU2d+l2jHD5wPSOdWpfRoeTT
         wHAoLi52cBVl+hyorZqkKBcJt96Nxmbn4S4U8hyN+IOe8P/wvikvclMRy+BMhFv8ncCp
         kXop3UtD7JQmYh3rEvOokck3B4NUE3cv4arGYEbDY9FHmCWQx23DxdUVRHwhNBusrbvW
         qBcg==
X-Forwarded-Encrypted: i=1; AJvYcCXORFE3ag3uAe9BahiD1jjZBGXtj5/VQb0oMWae9P0hPSI2QrBkltjDdgEixu7SV3E0urI3wlNoKNZxaOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGkrohM5deWFSUIq6bOUE99HCubSWvAHlsgFkAKunOOTpB97N
	DQbEfwJFIbk+RLlR65LZoveS/GWePxPXONTIStINE1kCCn0QIK/Y0c+TCD4BOCpyKefEj7sNurz
	hV8/1/Q==
X-Google-Smtp-Source: AGHT+IEN9uC1pBVlr5yFGFnZTcI/TObT0KfWuCPlVXznLGPUmFhI8NvOaWswDP0C+6WD618T70RZJO/olJf+
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:dc06:0:b0:e11:ade7:ba56 with SMTP id
 3f1490d57ef6-e16655a14famr5299276.7.1724183371261; Tue, 20 Aug 2024 12:49:31
 -0700 (PDT)
Date: Tue, 20 Aug 2024 19:48:59 +0000
In-Reply-To: <20240820194910.187826-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820194910.187826-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820194910.187826-5-mmaurer@google.com>
Subject: [PATCH v4 4/4] kasan: rust: Add KASAN smoke test via UAF
From: Matthew Maurer <mmaurer@google.com>
To: andreyknvl@gmail.com, ojeda@kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: dvyukov@google.com, aliceryhl@google.com, samitolvanen@google.com, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, glider@google.com, 
	Matthew Maurer <mmaurer@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds a smoke test to ensure that KASAN in Rust is actually detecting a
Rust-native UAF. There is significant room to expand this test suite,
but this will at least ensure that flags are having the intended effect.

The rename from kasan_test.c to kasan_test_c.c is in order to allow the
single kasan_test.ko test suite to contain both a .o file produced
by the C compiler and one produced by rustc.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 mm/kasan/Makefile                         |  7 ++++++-
 mm/kasan/kasan.h                          |  6 ++++++
 mm/kasan/{kasan_test.c => kasan_test_c.c} | 12 ++++++++++++
 mm/kasan/kasan_test_rust.rs               | 19 +++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
 rename mm/kasan/{kasan_test.c => kasan_test_c.c} (99%)
 create mode 100644 mm/kasan/kasan_test_rust.rs

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 7634dd2a6128..13059d9ee13c 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -44,13 +44,18 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
 CFLAGS_KASAN_TEST += -fno-builtin
 endif
 
-CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
+CFLAGS_kasan_test_c.o := $(CFLAGS_KASAN_TEST)
+RUSTFLAGS_kasan_test_rust.o := $(RUSTFLAGS_KASAN)
 CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
 
 obj-y := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
 obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
 obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
+kasan_test-objs := kasan_test_c.o
+ifdef CONFIG_RUST
+	kasan_test-objs += kasan_test_rust.o
+endif
 
 obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_test.o
 obj-$(CONFIG_KASAN_MODULE_TEST) += kasan_test_module.o
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fb2b9ac0659a..f438a6cdc964 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -555,6 +555,12 @@ static inline bool kasan_arch_is_ready(void)	{ return true; }
 void kasan_kunit_test_suite_start(void);
 void kasan_kunit_test_suite_end(void);
 
+#ifdef CONFIG_RUST
+char kasan_test_rust_uaf(void);
+#else
+static inline char kasan_test_rust_uaf(void) { return '\0'; }
+#endif
+
 #else /* CONFIG_KASAN_KUNIT_TEST */
 
 static inline void kasan_kunit_test_suite_start(void) { }
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test_c.c
similarity index 99%
rename from mm/kasan/kasan_test.c
rename to mm/kasan/kasan_test_c.c
index 7b32be2a3cf0..dd3d2a1e3145 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1899,6 +1899,17 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+/*
+ * Check that Rust performing a use-after-free using `unsafe` is detected.
+ * This is a smoke test to make sure that Rust is being sanitized properly.
+ */
+static void rust_uaf(struct kunit *test)
+{
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_RUST);
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
+}
+
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -1971,6 +1982,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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


