Return-Path: <linux-kernel+bounces-559028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A918A5EE87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35173BCD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB6263C8F;
	Thu, 13 Mar 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svniIdmr"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18992263887
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855980; cv=none; b=WYX52x3B3/7BSWUmNbL6epC9IUn35b8JtypRF01w7glh5yebxsl2JR2B9tjJD5Ef7znG3OenY9s9FDWy2yOgI1r/sYU1GHfMARMChijauSaW88lWBW9RiaWtRN9hjCKGPrlu9bCnAC0FJ0Kqs8MlLXYHEQRSKgiITim48yUjG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855980; c=relaxed/simple;
	bh=B60cmvatsBTV+TadNyiteqdRIJr0Vh6J8NTfO7bcc3c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OU1VnmIEb5VSR/hNReUV4V+UZE9xhrWrc+lZsX/lgJxGVwMuGejZZV/Z8E+uv0W1haQHTmznsQvJggMCqtjy34XkQwwG5YWPr2XAukMrOegECJxElxUKuicO5VuzPrGQhwJTLz5f5sHdV1pr80GNfK5rVk1NFyEurrHaPoXdB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svniIdmr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bd8fd03a2so3182235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741855976; x=1742460776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGmBak50vxMWviTu0tMlQwgGYOz3feUzTuxbm0LlmKU=;
        b=svniIdmrZsB1xNRtpIJlNT72vjNWhPSR97nvpg4yN3S8QVyFrp6L121yWUkRer7tGK
         lFAYWcdmaUCf4xq6b7TnKAJme39FEPEq04kh3ZHVpW/LuWSm5rueUh86kxLW3MSROP7k
         8xJ4kFh2RZwUvQcgL6KUVo+4tz201M6PfVRa5saOCNC/uwAYU3aawvxwfFpzgM5K3GNa
         7SaxCRabi4IVkyIuvHMXHLc1XBGqndSqtYpSeLxfxFO9e1YBITQov47RbPx6QkvpYLzU
         baoM17Uu5mrY0zxtIc62MIKquazCZkcYKBQqUa9QxG/C7S+xnLnQDFBkGm+gxfC4jV5N
         U6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855976; x=1742460776;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGmBak50vxMWviTu0tMlQwgGYOz3feUzTuxbm0LlmKU=;
        b=N2xgEhIQB9TSRYoBJnpMhZvx3SGjFc2iruihL6k9MUDs+/VRwlK99dUagKwjEVGPX+
         kZY6GUiRmktBP/k14hlucgir8KYbVPoFgkhC549/ucNBlqNu9++2DTXwmkFjiZI3uVYH
         b6fxhaMSU3V8TG2s56kKk71VLa1lQDaVKxb9wxFn8klGRrfI8UqW+sb3/FQ/2LIFyD3+
         /MQ0Nhi170AHxHOZiwPdWeluRydvRMaTfTBAMnJ8Q+Sp2sjmqCX7bh1MCxcUcjmEE5UB
         qI3MC+2jeoOX8oeaCK4WD97MoQ2rXD3bYAKWLK2V+DRwgHk8EEnl8orehYFiN/cmW0jW
         8eKA==
X-Forwarded-Encrypted: i=1; AJvYcCVmqbeWV95RptYxZVJ7G53R0VKBbWmWS8Nxza4jC3/HxcAD31daEIsHOj19wKY0nhrbpJGQqNI2OGATVqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB30+8/mpg9N6xIbnnhT4GztOUObT4bSzna0TW7bGAZz/6fl+3
	H+oWMb/QJozSS4mfD6by7JPQUzDgnMHC+MhBNJ0+ze5gBrpslCG1LFzHfC5x0ynsLroWi9SMwc2
	U+PZPgV2uWQmaBQ==
X-Google-Smtp-Source: AGHT+IFMlxgAbcZlB8BaJfKWUuaxRImNIAzPdA+jl808PsvZy09gOtzLzfDaycyQqQF3tBUSrM+uadh9GZE1ffg=
X-Received: from wmbgx9.prod.google.com ([2002:a05:600c:8589:b0:43d:10b:2c42])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3155:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-43d017258e1mr100973925e9.29.1741855976230;
 Thu, 13 Mar 2025 01:52:56 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:52:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANyc0mcC/x2M0QpAMBRAf0X32WobRn5FWtoubjHaRUr+3fJ46
 pzzAGMkZGizByJexLSFBCrPwM1DmFCQTwxa6koWSot48mFXYmd90h3aY/GiqCtfusagkQZSukc c6f63Xf++H30S//pmAAAA
X-Change-Id: 20250312-rust_misc_device_tld-375d4c86e606
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6510; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B60cmvatsBTV+TadNyiteqdRIJr0Vh6J8NTfO7bcc3c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0pzdpia0z/18cRRU/hozqzA1OFwdC0vtxoTVP
 ITCWBI05U6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9Kc3QAKCRAEWL7uWMY5
 RgK2D/48SEVoR7kp7wF5nyJozyctYc3vIiigedhKo7Ouu0T+m2tJz2lLL2kOQ199Vk0aN0kbMfX
 OQ3lwtt1XMbJo2YbWwcbMD5sro48UWPNtXFKn1CBUgMlYDeEYgpWqyHfZEPwmJfycq1vCbpFkHm
 j/VrOxJIUK9r7DcHkS8m6TV7lQ4xqrZx893kC1T5n+gnlI9gk9CR5VcwFCi713AiHH1kqHiUej/
 By5CW2BHGQegzYkK4XPP2tHsoCUUlGSxVUO4RSGaocLKjFhrK2wHdHM8v94wlTyRi3hgUic1Ygr
 8ZbiP3DJUij+4i84x2tfK01Z0uk6+9v5ab13NFKLAgtBeWvS3JTGJ++O1aefd3AMS3IXRgHVrk5
 igczULn5RNiKGZ+WrjiSdPew0eysw3iaB5rbamc/+sf+LsDCjRd+QgUTYeEdj4wvGfQPy0TQbhS
 dHhB9SbwX2MYyKkAigO2mMnB5dO0TCaOJPqseVYZSL8/GAwlr+O0SwPHkA3jB/7saKiPmYkcuWR
 sI0F4L5QxxckcL2eOPx1Aavf7wqUUrEsJ+uRdQhSN56Gi2Ds8ltSc4dKgU8QvFtqY1gjLtzaXIK
 roPzt8fYLgDCoN2GlglJJOyn25T7JU7D1DmbM7vhUzXEKlMulCLbxPCkQTraFFzh/7rUJL6hiJ1 URm5vPBj+TU3zzA==
X-Mailer: b4 0.14.2
Message-ID: <20250313-rust_misc_device_tld-v1-1-a519bced9a6d@google.com>
Subject: [PATCH] samples: rust_misc_device: fix markup in top-level docs
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The meaning of /// is to document the thing that comes after it, so
currently the example is documentation for the `use core::pin::Pin;`
statement. To write top-level docs (and have them rendered as such in
the html by rustdoc), use //! instead.

This does not change the contents of the docs at all. The only change is
changing /// to //!.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 samples/rust/rust_misc_device.rs | 181 ++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 90 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 40ad7266c2252e5c0b4e91e501ef9ada2eda3b16..17ae59979dd05d3e240966e598e5ce0cbf10ef18 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -3,97 +3,98 @@
 // Copyright (C) 2024 Google LLC.
 
 //! Rust misc device sample.
+//!
+//! Below is an example userspace C program that exercises this sample's functionality.
+//!
+//! ```c
+//! #include <stdio.h>
+//! #include <stdlib.h>
+//! #include <errno.h>
+//! #include <fcntl.h>
+//! #include <unistd.h>
+//! #include <sys/ioctl.h>
+//!
+//! #define RUST_MISC_DEV_FAIL _IO('|', 0)
+//! #define RUST_MISC_DEV_HELLO _IO('|', 0x80)
+//! #define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
+//! #define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
+//!
+//! int main() {
+//!   int value, new_value;
+//!   int fd, ret;
+//!
+//!   // Open the device file
+//!   printf("Opening /dev/rust-misc-device for reading and writing\n");
+//!   fd = open("/dev/rust-misc-device", O_RDWR);
+//!   if (fd < 0) {
+//!     perror("open");
+//!     return errno;
+//!   }
+//!
+//!   // Make call into driver to say "hello"
+//!   printf("Calling Hello\n");
+//!   ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
+//!   if (ret < 0) {
+//!     perror("ioctl: Failed to call into Hello");
+//!     close(fd);
+//!     return errno;
+//!   }
+//!
+//!   // Get initial value
+//!   printf("Fetching initial value\n");
+//!   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
+//!   if (ret < 0) {
+//!     perror("ioctl: Failed to fetch the initial value");
+//!     close(fd);
+//!     return errno;
+//!   }
+//!
+//!   value++;
+//!
+//!   // Set value to something different
+//!   printf("Submitting new value (%d)\n", value);
+//!   ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
+//!   if (ret < 0) {
+//!     perror("ioctl: Failed to submit new value");
+//!     close(fd);
+//!     return errno;
+//!   }
+//!
+//!   // Ensure new value was applied
+//!   printf("Fetching new value\n");
+//!   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
+//!   if (ret < 0) {
+//!     perror("ioctl: Failed to fetch the new value");
+//!     close(fd);
+//!     return errno;
+//!   }
+//!
+//!   if (value != new_value) {
+//!     printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
+//!     close(fd);
+//!     return -1;
+//!   }
+//!
+//!   // Call the unsuccessful ioctl
+//!   printf("Attempting to call in to an non-existent IOCTL\n");
+//!   ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
+//!   if (ret < 0) {
+//!     perror("ioctl: Succeeded to fail - this was expected");
+//!   } else {
+//!     printf("ioctl: Failed to fail\n");
+//!     close(fd);
+//!     return -1;
+//!   }
+//!
+//!   // Close the device file
+//!   printf("Closing /dev/rust-misc-device\n");
+//!   close(fd);
+//!
+//!   printf("Success\n");
+//!   return 0;
+//! }
+//! ```
 
-/// Below is an example userspace C program that exercises this sample's functionality.
-///
-/// ```c
-/// #include <stdio.h>
-/// #include <stdlib.h>
-/// #include <errno.h>
-/// #include <fcntl.h>
-/// #include <unistd.h>
-/// #include <sys/ioctl.h>
-///
-/// #define RUST_MISC_DEV_FAIL _IO('|', 0)
-/// #define RUST_MISC_DEV_HELLO _IO('|', 0x80)
-/// #define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
-/// #define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
-///
-/// int main() {
-///   int value, new_value;
-///   int fd, ret;
-///
-///   // Open the device file
-///   printf("Opening /dev/rust-misc-device for reading and writing\n");
-///   fd = open("/dev/rust-misc-device", O_RDWR);
-///   if (fd < 0) {
-///     perror("open");
-///     return errno;
-///   }
-///
-///   // Make call into driver to say "hello"
-///   printf("Calling Hello\n");
-///   ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
-///   if (ret < 0) {
-///     perror("ioctl: Failed to call into Hello");
-///     close(fd);
-///     return errno;
-///   }
-///
-///   // Get initial value
-///   printf("Fetching initial value\n");
-///   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
-///   if (ret < 0) {
-///     perror("ioctl: Failed to fetch the initial value");
-///     close(fd);
-///     return errno;
-///   }
-///
-///   value++;
-///
-///   // Set value to something different
-///   printf("Submitting new value (%d)\n", value);
-///   ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
-///   if (ret < 0) {
-///     perror("ioctl: Failed to submit new value");
-///     close(fd);
-///     return errno;
-///   }
-///
-///   // Ensure new value was applied
-///   printf("Fetching new value\n");
-///   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
-///   if (ret < 0) {
-///     perror("ioctl: Failed to fetch the new value");
-///     close(fd);
-///     return errno;
-///   }
-///
-///   if (value != new_value) {
-///     printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
-///     close(fd);
-///     return -1;
-///   }
-///
-///   // Call the unsuccessful ioctl
-///   printf("Attempting to call in to an non-existent IOCTL\n");
-///   ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
-///   if (ret < 0) {
-///     perror("ioctl: Succeeded to fail - this was expected");
-///   } else {
-///     printf("ioctl: Failed to fail\n");
-///     close(fd);
-///     return -1;
-///   }
-///
-///   // Close the device file
-///   printf("Closing /dev/rust-misc-device\n");
-///   close(fd);
-///
-///   printf("Success\n");
-///   return 0;
-/// }
-/// ```
 use core::pin::Pin;
 
 use kernel::{

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250312-rust_misc_device_tld-375d4c86e606

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


