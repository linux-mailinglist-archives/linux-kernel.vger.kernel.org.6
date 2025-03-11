Return-Path: <linux-kernel+bounces-556299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F5A5C3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F091895119
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0825DCE5;
	Tue, 11 Mar 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4f6FNPus"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A525DAEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703172; cv=none; b=NVXM+ToWSmiNXKUnPRKt7drB7NJfkdCck3ote8BuC9j3HQcL3T6Uacl80XIxJgnUz1NQ3AkkHKmbVcH/1OY1eGxjh/TvywX6MUcttw2jUvpdUM9gSF/9LJFGsfBrRUfs/GBj1nRajvsKjApi44IDCcLLIJppouxJ1t198MEJ/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703172; c=relaxed/simple;
	bh=XKU9cRKvgp0kixzFl7aIj/zQ08YPYBtJF12+lpAONHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t3r08L2k7gu2BOMOH/kCsTivnJJxp2xe1zo9C621UVz/K2eNHI9ymnsQ1RbkGxIaPq1LQiWoXNUqSMSPTexlqlh4HKsAxWiWrBzhCDfynw3p8AQw8KZLeCe+5OJ1fcidtPyPGq1NSHCOtBjDNgGVjxOMQqYa1MCmbR6Hh15JTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4f6FNPus; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso38607715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703169; x=1742307969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQkOm0HuLjqgJ/hyLLb+0wyoHUwdib0o04dd3QzbZVE=;
        b=4f6FNPusmUKksfcApkEJM5V/VifHAifeFXamG8VD5ereZTP2WafqRHGzTXAljwA873
         TjoVpkxojd6iXoXcm1O4bxse3p37aeJ9PqpeOXjpQDU74ZiDamEn5lITUZAQFB0YKb+h
         IJoAAaWs0F/pItdji0bgnjwphkNmwND3eLgCQm//pKW5YW8B58I8YQyfUX35o2hXMBq0
         gBOT7mr0bNPDgojXwjqLY4zRe9/rsR2BCK6BDqxvA80sDnVok+AIpbPp4fTRpvXil5Vv
         1gkTd8PkYG4X6cnU4cw0mZPPZzmCR2cEwOPJ4o8Xpofi17Oe9kRAZ21NUABZklP3ej5M
         HsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703169; x=1742307969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQkOm0HuLjqgJ/hyLLb+0wyoHUwdib0o04dd3QzbZVE=;
        b=JHc5V7sga+wOZDEhA3AoOyjLWK2fH6NY6YLHDnjW9Z378SkTU/L2lFvoJ2koQLToQF
         TntvMnUml5NbfhMHPluc+cUBWHbNqo8QLYpGZGMJtCJjoygwxvTVxmh/KEps3Msb+9q/
         aGpntnBMw0E5cesl2gsJxyFf2jG6leIhDUh8bP3XeZ+hA0dqvaU2TObn5NKTpqmZm0z7
         8BDq8k4DjTSesAzGsi1ibv7ZnpYCdtdyb8nZodMa0yC9yXIhR3zXkz0hFDO/PMIOF9xP
         J6SNd+gjt44HhdPiW7sb3nS2+UvtQzhBJRo61zVCapJcBYaCPSzC7l8a4AqbeFaaHlXU
         XHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmzGRIcHJ9OUP6i5xOtRe4stOc+lATm8ek4Sn45cm4611Kt3Gb8WJjOtBaATkZFcwLrH2nvWOeg/vg3os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokiKYf0uK6BfGF2DVzGPLuJj8H+fLbCvvVzLxQqgWMIGrU2yS
	W2ZR35DPA3r7QKuqtMK3D4hRuJnCF+vH9esuV5kUD6j0ECf6tZKt5s7zN9u+CVtmHqZewTb90av
	mpRrUDYXTv8acKQ==
X-Google-Smtp-Source: AGHT+IEKcctCw7ZE8Dhz7OmLcHjMnkf+lSBoaUGhJ5HarQK2WExcbUIVOji5s7/eIioXjPE5fNGcYR4TJw8MjYw=
X-Received: from wmbeq13.prod.google.com ([2002:a05:600c:848d:b0:43c:eb09:3790])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d1:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-43c5a62a276mr121343725e9.19.1741703169365;
 Tue, 11 Mar 2025 07:26:09 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:25:16 +0000
In-Reply-To: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=njR+x/nscsCHeUCgj3YO2aDLhcwxUN+kX/SqnNjxafY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0Ef0QAFWkXYX3kchm9jUoi8bW0gXnTRM5w+9N
 ik63DSHu1qJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9BH9AAKCRAEWL7uWMY5
 RptKD/9PcaUl3LQFRl7WMAEGoq02tV5SSw12s5SdnBTHJOb9SR4peV7vPWrl0pNjX/ViKyTUuvG
 s0Wr8dNK+ufhYjhCIeE4YYPPLOjUVMvHBiLgr5kDY6N70SX5EUBsaLcYvm0wo0I8hi6UUzAZ+Nd
 g0tGzOrxETkPiRvEDVAOvQ8szLJ8szou4Xkcr+9WDn0bmtBlpgxzqw+HIhBZAvC3hY8TGsq32DI
 NLfY5XuQbuEErBJCyMj8TrgZQMSLbpEGmRF3lkwJfsX8ilxuWvqvSIjJG7vxfPLpd+1aGZYK+EM
 YyHy8/SAS/Q0Y26SfLdvcS8SB/veQxc83xwNhEs/uFPzS355E8Cv4U9OPK+jkSZm3Zwlhtj5cvP
 Q/BYVk/L6hD4KXT1cjalpO+pLeaTy3rWQ6sK0db4n0UI29UoM821M9ZZk67/FIp0hOulNbr2u2g
 ynJaG4MyIyXkjeiuXBhJfbMiCgTcQTSyjhS0mGmr9gWAybPHQK/lWhWRDiNzvkk8VMAnAR8eavf
 BwkryPISFR9W0uRT13z349A7ho7F1I6Lif4GdjQXUBlEyldBJOoRH7/rQ/SX48M503PRZShN6Hf
 vPHBKdU1Sea0+jf8v33Eyum5KoE+pfA3pK2+UE2F867ES3qQk7Sc9GGysYvZ+QE0Jef5NGwZ916 JykYp+2ruMMGwTA==
X-Mailer: b4 0.14.2
Message-ID: <20250311-iov-iter-v1-5-f6c9134ea824@google.com>
Subject: [PATCH 5/5] samples: rust_misc_device: Expand the sample to support
 read()ing from userspace
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Lee Jones <lee@kernel.org>

A userland application can now operate on the char device with read() in
order to consume a locally held buffer.  Memory for the buffer is to be
provisioned and the buffer populated in its subsequently provided
write() counterpart.

Signed-off-by: Lee Jones <lee@kernel.org>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 samples/rust/rust_misc_device.rs | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 40ad7266c2252e5c0b4e91e501ef9ada2eda3b16..6405713fc8ff69659799f30710074487ea3bb14e 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -101,7 +101,9 @@
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
-    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    iov::{IovIterDest, IovIterSource},
+    kvec,
+    miscdevice::{Kiocb, MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
     sync::Mutex,
@@ -143,6 +145,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
 struct Inner {
     value: i32,
+    buffer: KVec<u8>,
 }
 
 #[pin_data(PinnedDrop)]
@@ -164,7 +167,10 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         KBox::try_pin_init(
             try_pin_init! {
                 RustMiscDevice {
-                    inner <- new_mutex!( Inner{ value: 0_i32 } ),
+                    inner <- new_mutex!(Inner {
+                        value: 0_i32,
+                        buffer: kvec![],
+                    }),
                     dev: dev,
                 }
             },
@@ -172,6 +178,33 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         )
     }
 
+    fn read_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterDest<'_>) -> Result<usize> {
+        let me = kiocb.private_data();
+        dev_info!(me.dev, "Reading from Rust Misc Device Sample\n");
+
+        let inner = me.inner.lock();
+        // Read the buffer contents, taking the file position into account.
+        let read = iov.simple_read_from_buffer(kiocb.ki_pos_mut(), &inner.buffer)?;
+
+        Ok(read)
+    }
+
+    fn write_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterSource<'_>) -> Result<usize> {
+        let me = kiocb.private_data();
+        dev_info!(me.dev, "Writing to Rust Misc Device Sample\n");
+
+        let mut inner = me.inner.lock();
+
+        // Replace buffer contents.
+        inner.buffer.clear();
+        let len = iov.copy_from_iter_vec(&mut inner.buffer, GFP_KERNEL)?;
+
+        // Set position to zero so that future `read` calls will see the new contents.
+        *kiocb.ki_pos_mut() = 0;
+
+        Ok(len)
+    }
+
     fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


