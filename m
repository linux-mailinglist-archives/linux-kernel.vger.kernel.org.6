Return-Path: <linux-kernel+bounces-538521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DCA4999F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74193BDF4C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA826F44B;
	Fri, 28 Feb 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7numUTg"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4326B972
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746420; cv=none; b=UAwiPEFWVjDqkg+SsUXoTQHpbUsUGOAM6SnGTY2ynC0ZTQYhvkd8mLNAqqkA/pgo0AGZV2spoU/lJoc+2t3MZfsjJEzPTqIE3g4tBuYW9CGJZaObtP56nT60wpZ5mk8VJMqGpR6ufIcpZNUgppX7qs2XOSDkNq2awvOor+enyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746420; c=relaxed/simple;
	bh=lzB/op9EvTIfS1pnVWB0B3izr6Rw961OsgJ28NlS2cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJ2SK3aY5GxEm9KhfUpgXtcxQE2edv/Gk0V4MWbtROqB45Vk3aEfkj3LcnAYAZyaS7UOL2j4LcDCHs/igvHL5nrk2rruqJYwoRgkU6FkwWY/UqIEMKq9uFOY9QC2vkqz7TqZwyAFPnH2tpEHL5r0qaJ8SSVzUHRzGxpNkgxrG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7numUTg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390f365274dso147515f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740746416; x=1741351216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKdCOruHgStYFRjw1OWEfRvPiQaLPkJaqZbPvH06xZY=;
        b=W7numUTg4VHj23F4uHUaN7xc5Y7v4PBACfAG56Fl8qjhYZQOGqi14kjONu7IF6WxcW
         EVswn5T4+89a8qzpiCQv6I5FjBVu5HKjvO9K5sMFe+0EmNnbpJ2XQxLH/e9dY7nEG/Ae
         4QPcA8isiTThzhG0FANOI6TF6RkTkyWZYh3riVF0PA2ubKBkbnWY3GY/jMYttyX0UTjQ
         i1TUbCckxsRQh4qjxBMDE/ZEvVHiFlFOsoiYCCjsUDy/zYsKqsiFaELwHkRutdVvNNNa
         N66+qI8sBNJ9hgm1UJ6bn6lWhI7LyxlX3ykNTpueYpmX8qfBRLeNt+yHI+aOzzQvxQAG
         ncEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746416; x=1741351216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKdCOruHgStYFRjw1OWEfRvPiQaLPkJaqZbPvH06xZY=;
        b=gtpm6hfVCwlBUD7m4h92ORphcQdQ1cUF69p+u+m5jdj4XudYfFxnmVg0CJbGjl4v/8
         C1XVySPMFUeQl/LibRh75gPZLT4srb8vrMheTzdGoxpFF90PIZlNH27KQfCAoS1GU26P
         9x7K01x/9m70kd2gDTshaHav77fTQqUAbEHGg1d/jHAVuFTrPk24q2turHvx1hFiGj8x
         uSjzCQRPPYiJhV8IVqJcu/f9Xgg2qjII9a2WOHneZAt1TDWfbfoLHk2UkTcTFsXAWNqa
         bt6FTQGFK4xDnOfa9dlQpBckOHO8HLi0/WDyrWjcjD9v8w5u4X1IY0cQ5HdipznL3Ch0
         +8/A==
X-Forwarded-Encrypted: i=1; AJvYcCW50CJuwZe+d1Nj0LjI/NOFqUPcYK2jMPh/qHy+3nMzupUQLNYdNSMne1UZlrzUxx2YskLugJN8yvzcJV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsrf4A238A8YeJ9t1PDaM8TttTt26g+hozej7A80GG8qq2aXup
	3md1ZLAygXIfD4OGWPzxbocI0XsTUnjKD4/XJAOFZGQO3SbeQWbjZ3VGh7/V1Bi6GPC7YmtDa6u
	sw1RGb8k2W3D6jw==
X-Google-Smtp-Source: AGHT+IGAooNngUR6F5E/Jf8s4LC0YsqlsbQHIiPJaRDR2Z8JjTKZ1EiRXmYu1cG1inA9uIBqBtJ1Q5wUohwQEBs=
X-Received: from wmqa13.prod.google.com ([2002:a05:600c:348d:b0:439:64f9:d801])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:400a:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-390e18c8b0amr5646269f8f.18.1740746416493;
 Fri, 28 Feb 2025 04:40:16 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:34 +0000
In-Reply-To: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4391; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=lzB/op9EvTIfS1pnVWB0B3izr6Rw961OsgJ28NlS2cw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnwa6i0KzBrUws4mz1R1VW1D9TxSn72HLiqHpJR
 ZCRZT3AF3mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8GuogAKCRAEWL7uWMY5
 Rn+wD/0RyHzL949Lt17UGWI6WZmlRtRFdhXsWk8dwmUL3pTAjhMNHcSkL+/UnC0ieyheuZIskCq
 Zj9whzeOEdqIAvKuTybm4nrO3wlr9Ub2HqLOXnjVhG0pLJEgzOgI2+b849oWrWVTwA3oUXTvIaI
 LdWL4ZpXcv8ExvLxawdGYmKPshMkVytyRdqa8U77ea3ermzIeryGAJAIfOH7Lepic7ytK5s091O
 LgMpB/ONmXPnUtZ5hTfBt7670ADKL9u6TY8st/doIQDRtzQhlOl+rp6JRUrbQ83YhNnqhYV0rKq
 cPE3iYpkevaMaz178BE9yJBSyyGDmZGi3zGNUkcNvQuteKV5LvDdt5LkHeP6vq8chtkIRLI4v2u
 jbPpfgQ9TevWf6P7qjX+zLT2OPcujpJeQYL8i87KzswA2CLporYAycPNjeXGnAO0swAzTnkIupR
 pUIZx0cHok7eIB+aQMKbmTJ+ll4sQj5svV60Fh7+t0bsn27VvbBYh6gkGj4pSwrYUMPos4/4wmx
 5qg8JPiN08hqo8Mwmvc56mROWbHnfhQ8+M8cgZLe0qg0p8HKJSahax6nqP+stenJuVsT0LxqDDy
 nH2pF0Q1rTPc2kSGHG/HXCeY2yrEhabXztuHQLggzlkGHSNZxp3L+8dk8d1eNSs/A7XhAjVsc1j FplYmT7vKagKAaw==
X-Mailer: b4 0.14.1
Message-ID: <20250228-export-macro-v2-5-569cc7e8926c@google.com>
Subject: [PATCH v2 5/5] panic_qr: use new #[export] macro
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This validates at compile time that the signatures match what is in the
header file. It highlights one annoyance with the compile-time check,
which is that it can only be used with functions marked unsafe.

If the function is not unsafe, then this error is emitted:

error[E0308]: `if` and `else` have incompatible types
   --> <linux>/drivers/gpu/drm/drm_panic_qr.rs:987:19
    |
986 | #[export]
    | --------- expected because of this
987 | pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
    |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected unsafe fn, found safe fn
    |
    = note: expected fn item `unsafe extern "C" fn(_, _) -> _ {kernel::bindings::drm_panic_qr_max_data_size}`
               found fn item `extern "C" fn(_, _) -> _ {drm_panic_qr_max_data_size}`

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_panic.c     |  5 -----
 drivers/gpu/drm/drm_panic_qr.rs | 15 +++++++++++----
 include/drm/drm_panic.h         |  7 +++++++
 rust/bindings/bindings_helper.h |  4 ++++
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index f128d345b16d..dee5301dd729 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -486,11 +486,6 @@ static void drm_panic_qr_exit(void)
 	stream.workspace = NULL;
 }
 
-extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
-
-extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_len, size_t data_size,
-				u8 *tmp, size_t tmp_size);
-
 static int drm_panic_get_qr_code_url(u8 **qr_image)
 {
 	struct kmsg_dump_iter iter;
diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index bcf248f69252..d055655aa0cd 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -27,7 +27,10 @@
 //! * <https://github.com/bjguillot/qr>
 
 use core::cmp;
-use kernel::str::CStr;
+use kernel::{
+    prelude::*,
+    str::CStr,
+};
 
 #[derive(Debug, Clone, Copy, PartialEq, Eq, Ord, PartialOrd)]
 struct Version(usize);
@@ -929,7 +932,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
 /// * `tmp` must be valid for reading and writing for `tmp_size` bytes.
 ///
 /// They must remain valid for the duration of the function call.
-#[no_mangle]
+#[export]
 pub unsafe extern "C" fn drm_panic_qr_generate(
     url: *const kernel::ffi::c_char,
     data: *mut u8,
@@ -980,8 +983,12 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
 /// * If `url_len` > 0, remove the 2 segments header/length and also count the
 ///   conversion to numeric segments.
 /// * If `url_len` = 0, only removes 3 bytes for 1 binary segment.
-#[no_mangle]
-pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
+///
+/// # Safety
+///
+/// Always safe to call.
+#[export]
+pub unsafe extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
     #[expect(clippy::manual_range_contains)]
     if version < 1 || version > 40 {
         return 0;
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index f4e1fa9ae607..2a1536e0229a 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -163,4 +163,11 @@ static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags)
 
 #endif
 
+#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
+
+extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_len, size_t data_size,
+				u8 *tmp, size_t tmp_size);
+#endif
+
 #endif /* __DRM_PANIC_H__ */
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14..5345aa93fb8a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,10 @@
 #include <linux/workqueue.h>
 #include <trace/events/rust_sample.h>
 
+#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+#include <drm/drm_panic.h>
+#endif
+
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;

-- 
2.48.1.711.g2feabab25a-goog


