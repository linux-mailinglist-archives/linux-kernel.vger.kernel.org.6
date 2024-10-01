Return-Path: <linux-kernel+bounces-345481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C141598B6CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5280F1F22565
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8719B5AC;
	Tue,  1 Oct 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qcB3QEF"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F719AD8B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770980; cv=none; b=kklXusNoMUZk55YuxPIQo64f8wXN8Gsl3rr3vsAEF2EN6fqzpXaZnI+hptRvcwSHZoYILVf0ZOXeBnZrPwbnddjQ2M6CnKvXJR33V+N4wkJCQZWdjOYfb4QSeEaLCXzplMcjxAXkYOQib4bJzMoOMz3/NfMrC6SyEv/WtAZvXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770980; c=relaxed/simple;
	bh=w5vpF2KjSDzHeIA5XI18Zu/5o3t9dW7N6iJWlXkLYZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTTvmQzKbieH/2SkstzS1ZODarZKDzT6ACrDy/tgv81lSXNj4p54GkSwf0+xbtW1rcK5IHUTJJFYHVTOdYwVv3L21S51UaS0WjtaNnIrE4yrE3qAn+Yv8KoIYKXkV1I00S9vQZtoGGgqBNBQnV8LK7WCEGKFRq73mUaZNXJXQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qcB3QEF; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37ccc96d3e6so2104410f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727770976; x=1728375776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8JAKUUFBvhOCHorbss54F6W7KzK+U9EFUJD/YO7YbM=;
        b=4qcB3QEFsxp7LUgWcdyXEaTZfqxCPgMoISEi/UGI/qMbbCH7vYaNS2BHmXyEy0RpC3
         z1hnA14LykfoNgKIqJHdnjKE4RzUdBw682HM9YE01KVPjOecSQ6CrtSYw5WbDqh++npP
         SmlMu9iWLfO7PMsP3iHQNy5PEhDn1O3bq/H7uGkVoMiKo0A5TxWNWcW2p5mm4oUugvqX
         wFM+k2VenaG2tudZbFZD/oXZFzdaADLL0hgw36RgOEtod1J/MuL5OdsP4nY8DPmNC81C
         MkWUyJnMBT90K/uKQ7Q/I0vLvYzG776NGglpUa1CErr7AAkoOfQtK2iG0bThrbKtg4ir
         jKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770976; x=1728375776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8JAKUUFBvhOCHorbss54F6W7KzK+U9EFUJD/YO7YbM=;
        b=OAru9Zb1Aywhl4QYkcQyKMi+H2efk6MzUxYP9r+VmojskP6inwnUqLwWGO9t5FEKqx
         MDb4QS59g2zn+Hy1gZwUwcv4sq7rTfd+O0iO0ehwwVfdoRTnOtGyLgBZTHtH6wh0aknA
         2O95nY47cA4Hab4IB0p2Zp5VAlCGt3ormW9GWrisJeMTRk16+8jnldhlLhOKnY2v23Yg
         pSIw1U4GOegNoAb5U4j5sQVUNO9oqLvh0GHR6Ow+YtwsDep/RmvLTTD9OuCDTFYvIQFg
         BqFddHV7ss7ncAQnlh5YmBZzcw1D5bnS4YRHLZtqzCWiAcnzitVEE+6FC0tmfkzW95YH
         tkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcE/RePT1PBbd+xq8/yXVQYUeMFw8JZKj0UQ4seAr4FaOkde4lobJdGlGoba/L8VWXy94VrkHljbA8gMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0pbg49l9tveVBPC5pqoi/5ys+8h9lqpAIYB2wENvi4MkFSQl
	RPMvYCnr3JyQODJLTD4ioRJta1s/sFB8TjVw6t94UjUBRw3R2jb0HWBVtYz4b20eRmb6Arnxf1y
	rKmSv4ya8nsiizg==
X-Google-Smtp-Source: AGHT+IExXCuGSNKUgb5EKB5y8fwqLie6k5olxuTaa9T8BXXPAp3Q/DwnPl64kxTDFM8XU5WbOnsZDGZTiDxpjmE=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6000:bca:b0:374:bfe8:d22 with SMTP
 id ffacd0b85a97d-37cd5b3eaefmr8058f8f.11.1727770976221; Tue, 01 Oct 2024
 01:22:56 -0700 (PDT)
Date: Tue, 01 Oct 2024 08:22:21 +0000
In-Reply-To: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=w5vpF2KjSDzHeIA5XI18Zu/5o3t9dW7N6iJWlXkLYZM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+7Faj3Wj9brE1kX52zaHrM4iK6V7I6NilUBNn
 AQyNOJces+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvuxWgAKCRAEWL7uWMY5
 RhP5D/47AvaqeB+62q3O1KMypiw0Uqdma3vnjtOhLzoHreid8ZWfEq1YVzJD5DUeW1K1u+/X7KA
 Bg44SAyZjJfcs0mvaljv0XH9yVjxPwHVSzijzWQutVSGNLyMFO5Tua6eO7QK8GOR6Y6DHSpi6+y
 QReDvZl9Ooy4yh+5qhcr5Jze59Q3JAkDCCArER5/ff47aE/3Bntj9hcZ/V3YmaONrvDR3jeLYwa
 pYUL5nWP+AmunDeTdOHa8sLACzqP6dWk0lsTOB0k9Ql/qyg4gRXPvTcGPCctbgPPRwHnSJZXMkF
 TOoYBe0q6cZmdmovVp3GgfRGNbYE18+AT+o2onhzo8uCWdPp8PJUUBfz7gAhmWGembgCv1KT252
 ZUbtKUMbElR94YEIQQNF+PIKHhzco4N+LF3prHtK+GFOFcTFGxn0s3Vv3MEt2rJO4x3YuiuUss8
 q/jA67lEosi05xolm36lzl4l+St/CaywfXpGTC6L/+fAVltqtKMgD3TucAj+evM42LAg2JFQajS
 TdI4ZdTI7vuOiE7JbAcGWV462UEnzkLLps+yyl3fiWdvcGqD8BYMJ8Y2Pr1e9EnW3zHw3CnJ2n+
 Rmz4MMJHvDNhlMkzlynVcv87XqaBANpgRIGbhMxlLChDoUxb9l4bA3za/IZvJ9UMV98qCUS+SdC lew50KVTtGV9bQA==
X-Mailer: b4 0.13.0
Message-ID: <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
Subject: [PATCH v2 1/2] rust: types: add Opaque::try_ffi_init
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This will be used by the miscdevice abstractions, as the C function
`misc_register` is fallible.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9e7ca066355c..070d03152937 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -299,6 +299,22 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
         }
     }
 
+    /// Creates a fallible pin-initializer from the given initializer closure.
+    ///
+    /// The returned initializer calls the given closure with the pointer to the inner `T` of this
+    /// `Opaque`. Since this memory is uninitialized, the closure is not allowed to read from it.
+    ///
+    /// This function is safe, because the `T` inside of an `Opaque` is allowed to be
+    /// uninitialized. Additionally, access to the inner `T` requires `unsafe`, so the caller needs
+    /// to verify at that point that the inner value is valid.
+    pub fn try_ffi_init<E>(
+        init_func: impl FnOnce(*mut T) -> Result<(), E>,
+    ) -> impl PinInit<Self, E> {
+        // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init_func` to not fully
+        // initialize the `T`.
+        unsafe { init::pin_init_from_closure::<_, E>(move |slot| init_func(Self::raw_get(slot))) }
+    }
+
     /// Returns a raw pointer to the opaque data.
     pub const fn get(&self) -> *mut T {
         UnsafeCell::get(&self.value).cast::<T>()

-- 
2.46.1.824.gd892dcdcdd-goog


