Return-Path: <linux-kernel+bounces-541183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC0A4B9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193603A8948
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44851F1317;
	Mon,  3 Mar 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRVew8xk"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1961F12E7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991561; cv=none; b=PcYNEhYcAHmbJYTBd02XM1qotKBSh4p15Tw/mw+9dPkZwmfIWK4OlGsQ/ReR2kTbVVW2YIzArcyoqmZzamft+RuitxXVmdcI6gXGF4zI1XB518pGeZKUcYm6fBmTq42KIp3DM5hR4c7sOxaynil2G0Nf9llppmCwFT2S57tfh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991561; c=relaxed/simple;
	bh=h39madShj1asyLtbf2sfVdBNK2RyKkwe8T8CD9+EWUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a7gPtkBXwPsL2Jq2QjVlgCLKH2hZgQ/WjevRvvfL1SAOa0ohmbGNNdiMv8J43ae5wPd3kx9353ridPwIunob0wSSI9o1Cv3qbj6K2PvlO9bJekIfAi7NqhJt8K9p+hqX6QWNw88Ec/R0INUtxUYuW8JL7z9UVFpzrdDBaM5ZsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRVew8xk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so18162215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740991557; x=1741596357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DQHcaO0nvqPOcD0xXA6BfduaWtfQQJcuNoquBNRtQM=;
        b=pRVew8xkZ3dx76UDMEb5V5Ln0Zrn19RnI5UNBN3imF+cdAd3P5dKdKXSD097jduQ1Z
         hZfQsnVy5qXTmvDUQuSeT+7hm8iab/iHttka6yYU8AvtbdxDjRC7WG4+k/FM9VXhYmRd
         qg3JW79D2XsRY+IFG1p9KlEAhSA/5Es8qCluW2j1lg/JbPwtYLqaVb3iKxpXeLh6C3Nm
         kcO29QyghbQouvkyRiEx1nTOW9f+uwTRnmG/0lOUu7kJZXSYcaP6ffAR6+teNa5AwY9v
         FtL4/CB4/2ZsHeBqN8O5pKm1OSMZVUMFwUL0NXJBE3k5tE+JDzyqm76RKjhTYpR1JkKb
         6acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991557; x=1741596357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DQHcaO0nvqPOcD0xXA6BfduaWtfQQJcuNoquBNRtQM=;
        b=mx4YYY69mm77Dwe2RhBKoa6HEwVya5REa/RE/Ing4Py1uF+4epn9BOTN2sRIxHzH8A
         3n/mdsENPLPtN8Bm+J3/wHMvQe7rZz2GgV15WdfGvv1V/wnpgTvC64ZlKHfuENvgFlzV
         Inapi/h/RA1MQJ89i308YYyBRcIFJROuJblg0ZNZPAyoLt2dH7RHTFGmAp+45QmGQUlH
         NJTq9Lj8OUjDLtVMVm8NLVRKhQ7QsDWnk2TIqd7GQP3YFUmdrggNfnVGUxjfFH9VrcwI
         h4FyfasPMQ5hPrJx86u3A5JXtKQfTri50Um+KfWYXB7BnnTafJsf8V3StYfgULooRo8C
         Hzwg==
X-Forwarded-Encrypted: i=1; AJvYcCUrlYmYVMDNaZkCpOGO2yzC6nS7+nWC2JblI1Rl/ZqTtWHfyeiVJLCUmnzoP/IX1evgJ4hjVzruwzJ5IIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wQ3LqBkKnxZJ9yeobPH2v7MEwBNTnzSeI/58dWma9X9zlICl
	3Fxk8jglUh5X5FXkcBSNLY4/z8hMzOtJ280MlZ9hzYBihnZgDWR93G5jMTpHRBA8N44A0us9hoe
	Qkwn5gdCu56iHow==
X-Google-Smtp-Source: AGHT+IEbR3/WcyPiaNNIulZcuIWaKGsu5gY2WjUpjPLpgdJov23gFYjscM1b2KomiFKt1HIexbDsjk8ll3zgBPY=
X-Received: from wmbay26.prod.google.com ([2002:a05:600c:1e1a:b0:439:80fc:8bb2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c25:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-43ba6774a03mr109919695e9.30.1740991557659;
 Mon, 03 Mar 2025 00:45:57 -0800 (PST)
Date: Mon, 03 Mar 2025 08:45:16 +0000
In-Reply-To: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4809; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=h39madShj1asyLtbf2sfVdBNK2RyKkwe8T8CD9+EWUU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxWw3pj1BuO7nm85LYW8CAGocu7fhqRw9nvE8r
 O7rU8v0FnuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8VsNwAKCRAEWL7uWMY5
 Ru5uEACnfnvDNKGTdfDWkGpV2cmEz+XPIKAv+OAav/nOsh2wf+SfXkLPHDH7ruxHfwIZIgBxSN0
 XNYeBV/QOAcBcfj7kCEnALSOYbYa68MODYU3lWLzoYQGcTKnIvgBpZcQNcIw6XoiTggnSfS4pRN
 twnRo0DybJXquoJRODCF7pPH1zuKCeDtLN4pEBmlSQz4JJr4lm9jHA2UxFUYxzGNmRBYpPxK3sA
 gzDGC1QnvX1VjNHlwTJV9otv6N0zCdO3zdQ/FW0byi7n9wxNs91XO1qcbwOraS/zqXnSJujthF9
 g/DF9vk9C9vtZYhOUPPUdeYjapB4wG9+h8TlKGembKDI4h7zk/XPUxfp6siqoMycq+lGTAEepNz
 +sT9UyQN+jUXepDM2K2FM4AA1cu3hMqJkfDZgI4x49hrXRmBJ1VGEt308d5DPco6Um7EQtheFGc
 0fNhGeafPpTduaf2Ebi+xrdhZQ2ZBTzGDxRFgRMTOFSANfmum5+BX4ZuThqe9scF5REbMHD65y0
 nvytaWAsv4lSnYIg9wMuWBKn+4uCuI1QWlTyjvLtl4aOcceJFpdKBShLjTO+8UvL6H9CqvjDm0y
 VQ0iys7hDYKZ+bk5RgqB3PZWRsc8fbJlsZUk8pdSqFSdC4ibbPV67kpPGD7QcElJrgJYkllt3no E+HSkBYCbHVjBeQ==
X-Mailer: b4 0.14.1
Message-ID: <20250303-export-macro-v3-5-41fbad85a27f@google.com>
Subject: [PATCH v3 5/5] panic_qr: use new #[export] macro
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
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona.vetter@ffwll.ch>
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

The signature declarations are moved to a header file so it can be
included in the Rust bindings helper, and the extern keyword is removed
as it is unnecessary.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/drm_panic.c     |  5 -----
 drivers/gpu/drm/drm_panic_qr.rs | 15 +++++++++++----
 include/drm/drm_panic.h         |  7 +++++++
 rust/bindings/bindings_helper.h |  5 +++++
 4 files changed, 23 insertions(+), 9 deletions(-)

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
index bcf248f69252..906943b02beb 100644
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
+#[export] // required to be unsafe due to this annotation
+pub unsafe extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
     #[expect(clippy::manual_range_contains)]
     if version < 1 || version > 40 {
         return 0;
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index f4e1fa9ae607..ff78d00c3da5 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -163,4 +163,11 @@ static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags)
 
 #endif
 
+#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
+
+u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data_len, size_t data_size,
+			 u8 *tmp, size_t tmp_size);
+#endif
+
 #endif /* __DRM_PANIC_H__ */
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14..607e90a682ca 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,11 @@
 #include <linux/workqueue.h>
 #include <trace/events/rust_sample.h>
 
+#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
+// Used by #[export] in drivers/gpu/drm/drm_panic_qr.rs
+#include <drm/drm_panic.h>
+#endif
+
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;

-- 
2.48.1.711.g2feabab25a-goog


