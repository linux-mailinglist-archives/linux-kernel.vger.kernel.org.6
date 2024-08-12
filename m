Return-Path: <linux-kernel+bounces-283912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB994FA49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E791F23B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E0199380;
	Mon, 12 Aug 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1IsasBN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A2199EB2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505370; cv=none; b=vBjYcqUaCGqJBaxoHq3qvUQXnXSg5T9ZOPFF+NI99QVPvedZZ0bLMKHA3NN/dc8MJcQhQgPwDk2jb5J031rlcza7mR8/oiKYZKTsutGrMJ/+yasXL7mlkEsoFSLKIb7GX/LtSvdjyKly/BK1RgQ7gvv30hURJtpcpQfuOtVLejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505370; c=relaxed/simple;
	bh=kL3DAzlkmToM0AEz1ViuUbMjwHeKGPw4C7nPFToMXko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PwndhQXJAyw3DOSSliZl6/HN9r2ryPjiVwmMLBaKVp4PQSWYt28bX6KOlKHhAtH7irMPUajMoIQKvDFKSzP90fUDN8YUsIe3gzUnFot8RSf0n3VJ+2bb6zEkTnQ9MF4ybtvp3HNjgKDujtq5emwf3IN+Z0BLSHEvW27BBtrVjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1IsasBN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-672bea19dd3so109852337b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723505367; x=1724110167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upOwpMTeo+ntHO/NqVQFtbSuOi1aXqqXOiMSFMXzMsU=;
        b=f1IsasBNxo4XZqapEeD60eNUNEXwjJskZs/3jKYwkoDWmKQJqisxhUJUX/xk0JzT3J
         qnWdWhK6Fn18V7E3DmEGsYhfSl/ebQT8z9v3fq71p+o9DJz2HhIkmD2d7ivlBlMTjpXB
         Hq3rc/8BE8PGkVcNL4fqZB/samAm5fWIqP3L0XzTDwp4dvNtRvEEj6+lajqSDv/aJNWj
         SC048n4JXQwZD0NrfxGj8nt0mRcUIYZYxX669AwIyRhuGkO/+Wt8MgjbPHejfBpNykfs
         g78HctiZbtF47N3sBqG76QP5ELI2TJuCXk7Dmd37F7XPLhNp1fDgv6+XL3SrxOZbePrI
         gTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505367; x=1724110167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upOwpMTeo+ntHO/NqVQFtbSuOi1aXqqXOiMSFMXzMsU=;
        b=CCetS5WEsxZHVQ+HcOUc9onf2hNNftJC0wAhaP9UMnpNHvjitnf5l8CJqBuMnJgK6C
         r+GUi9PH/A408uOGxI9w6aUbcmasG4OOxvYlR7MbInnkJBBKwuIZ6uEdxrOowTevE5Wi
         0ftaZDP2iDTd5jEmyPWW6aX9weJMTS9hHmm5ymfVcTJmpmtPlVF+gAHu2yzLTRvtBDBw
         WySueztFWRntexmYXJuaOYc/+xNaDg3AvvPckbQCUMyVfOHRGHsbAa7c9WnqMcQdoR68
         J++VzklJoLdWoDm61yrusDewOHr6ersyQS1PZIy0p5tI9LBC6294LPIKbK7oXJNAFVvD
         ZRJA==
X-Forwarded-Encrypted: i=1; AJvYcCUxz98NpYL8/fJM4VLno+5donp/JjEBdE+PgUNEdz+NNUGs7HNFJ9ikkteet24RY/PF8TFVfJ9fm1J/akWUgn+E/vnIpXscNBk0EYzm
X-Gm-Message-State: AOJu0YzzPEwT5gxtJ6taRQIuLQkJlQFkO+xpabU/YXlvp9DMKInP88W3
	EN+UWD7LDdxjKsuG5hRm5ADMRU9TUpdl8Ee9wb4dGIGBlfeNXAULGpSLXPurQe8JKmJ42TuTrY2
	/n/ZKUA==
X-Google-Smtp-Source: AGHT+IEbI2xHXS1NFNlXCt2+JC+OCS4CUJP3dnvdvqLavIiiV4QA03cxFw2gUqrwIFrDOo44dUgxsS61/+Y1
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:5f09:0:b0:e0e:4a15:cc1e with SMTP id
 3f1490d57ef6-e113c80de33mr25468276.0.1723505367499; Mon, 12 Aug 2024 16:29:27
 -0700 (PDT)
Date: Mon, 12 Aug 2024 23:29:03 +0000
In-Reply-To: <20240812232910.2026387-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812232910.2026387-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812232910.2026387-4-mmaurer@google.com>
Subject: [PATCH v2 3/3] kasan: rust: Add KASAN smoke test via UAF
From: Matthew Maurer <mmaurer@google.com>
To: dvyukov@google.com, ojeda@kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: aliceryhl@google.com, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adds a smoke test to ensure that KASAN in Rust is actually detecting a
Rust-native UAF. There is significant room to expand this test suite,
but this will at least ensure that flags are having the intended effect.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 mm/kasan/Makefile                         |  9 ++++++++-
 mm/kasan/{kasan_test.c => kasan_test_c.c} | 13 +++++++++++++
 mm/kasan/kasan_test_rust.rs               | 17 +++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)
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
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test_c.c
similarity index 99%
rename from mm/kasan/kasan_test.c
rename to mm/kasan/kasan_test_c.c
index 7b32be2a3cf0..28821c90840e 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test_c.c
@@ -30,6 +30,7 @@
 #include <asm/page.h>
 
 #include "kasan.h"
+#include "kasan_test_rust.h"
 
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
 
@@ -1899,6 +1900,17 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+/*
+ * Check that Rust performing a uaf using `unsafe` is detected.
+ * This is an undirected smoke test to make sure that Rust is being sanitized
+ * appropriately.
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
@@ -1971,6 +1983,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(rust_uaf),
 	{}
 };
 
diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
new file mode 100644
index 000000000000..6f4b43ea488c
--- /dev/null
+++ b/mm/kasan/kasan_test_rust.rs
@@ -0,0 +1,17 @@
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
2.46.0.76.ge559c4bf1a-goog


