Return-Path: <linux-kernel+bounces-556297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46CBA5C3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B82189885C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85F25D919;
	Tue, 11 Mar 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yst4CGoR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249425D553
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703168; cv=none; b=mgu9myB6pcd8it7MJ/XRh9aWDCJybXvrQkj+HyvtDR30zXv6X9N4hMLpFcutcJ+a5aLoEAk/WCnC4vCG8+foqO+ZSeEofy/4tr3xzv7aHzYqn6BVYmbIhNr3J1V0zy7nkEpqEZFNNsUO9WPYoPVWsibVvp5nutwLZV9PSDV0NJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703168; c=relaxed/simple;
	bh=B/1td+VMQnZgliO2HAl2eR0VoV3jv+kTGfbUL+xc5zM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGQbBJcXXpz57kNtoe/D2WbWkbWk+9u5T2yp14p/2bRd5KrzRk2Fosb4CNxhLEzi1bALUWUybqQ9EwzUEbO3vF3SZdCzNuu/vSuD4JBi+90Af7EENEbF13yuszf2DjbaVGa/5yXlpxwydW1bkJvSzMzMfGDYMQdVLTd1g0+tLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yst4CGoR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438da39bb69so39341715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741703165; x=1742307965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwl/IIHNARpgtRdEA9ewvhA5D9UXMrvwaaXp7LgTuiM=;
        b=yst4CGoR8XHMYCP7ByTARcMQAcsaxo11jJ97dbq15vl2OMj5FPJ1jVPQO3WjrsxLvX
         bb0Dd/k0VRRJEq5+3YaB6G2cGMruYo1QZUIcDrO8RvUPuZD8BnhU2uzFU86mc+l6Zq/A
         Tv8Nw9S98YiB3N33OkGM0OxZY6MwnNEzJL5iCsAwey4vRkNPzyB1Qf9Wjm7BjVSk0flj
         DQx1fyCt6XM8K6QUxkxvBuX4KCBTyvW74gF3tO3hxTFG73QUPHCJL3OOwWQcwoPFkjG/
         cULwcuxxwJ5yV4wBK0yhGo/tNjIvQi7BsTlRgGhnqGEbgv6ZYvyFHOkLyulkt3DV+9HC
         AMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703165; x=1742307965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwl/IIHNARpgtRdEA9ewvhA5D9UXMrvwaaXp7LgTuiM=;
        b=MgHLabtHTINW0HqJhqBk+JKOg3XvaB5BrGO7tZapcjnLFKya+nwwWqP+BfUZYggqDZ
         hm5h4TFblhXbJbeW95XsbCMt6AwXy5iAhaQKJ+/mhNWixkF66a6HJbdUzjkfBafLOCqr
         NCgYgvExx8UagVx4CYbRv2eIOTOcVU+SFHeLJLr7RCf4QXhjcx9STKtywgb+W/qmq8iU
         u3xcRaXNM8ghhQM6N3l9RjXI4kpY/xJ9/r8zsnu2t5/U3NXdHAO3Bp2adBe7qRXkDw+H
         8SiZ9rH4S1+16f4WDSWZQ/UL4hO9TYb5XpFgzQmvLOk0cGTaJZfrBqSW9ixaKE+tVBeh
         wSuw==
X-Forwarded-Encrypted: i=1; AJvYcCXUIiAJcxtpE8QPXA9aNUpepjIw2Aw7MHKesiaDk948zlTD9vAnBNpjN35oGcbTOzR2L0Z1mWudTPwW/F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYhtHV8fVfyIYnNJkrXBLXh9GoieBtWuc2H7oJN84bsWL/itr
	CzDlfhT1BPPog2mtf3FvCjLUw3l6+8acxMjaGPusjgVJhxXYs9DZ5JFEjP6oKuMYreRc9Ohv76W
	iB8GPZaZd8PtpyQ==
X-Google-Smtp-Source: AGHT+IHCHhtxEBMSk0zFJLJD1sCTwgXRkSzAoBtKJTTegGaH3YiBtG4mxjikWvm6uQn8V/KfJtSQzL2THiZAPOc=
X-Received: from wmbg7.prod.google.com ([2002:a05:600c:a407:b0:43c:fad4:7595])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba1:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-43cfbbf7eb2mr82199255e9.30.1741703164884;
 Tue, 11 Mar 2025 07:26:04 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:25:14 +0000
In-Reply-To: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5629; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B/1td+VMQnZgliO2HAl2eR0VoV3jv+kTGfbUL+xc5zM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn0EfycPAW1Ciir54AsE9E4XhJSOknSTnJQt/Ay
 rDG09KbMpyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9BH8gAKCRAEWL7uWMY5
 RmUzD/9iB799ragOz+5kMIbj3Cw6MOII1qea5vqLoUyvv3RqSfsHmR4XYvMlZe18Bq3w1M+4SPr
 ZV4+ncb+6BLbjxkrqddt4OT6/0TZZYF7Q3c0HBv1xI5Ypw+N19+sp56l8hjGvZB905QYMK4k57z
 It7HAGPZ1zHW0RjgeGPrRYpV287ylzZMY25PzMOYz0ORh1WT8P9O3qGLWUcCYZpLmBJ5MrDmrv6
 M++r1t6RAO6nvhtsBiylfCIzvB/4zys9xvGEKHJTbQuR/BWCb7qWgXDvTbwnOjd8GoK3oEJ5ALL
 JJdb7sHLQwGWmx6rzZ8tR92piqlwXEhDaDX/42dVqjrQX5+KtPfsEQABt8e0k3BYOjrLg2Kr/PS
 XJsvaae+SNYUB1US/Y9hg/cQ97jv9Notv4QJfulvsg+Q3SEuV1As/XQnut11E9ScomX7kLsmT0W
 aAK6BEA50S5w+kWCSAqwuD30Re2xtXAKYWgs2t4uq3oDKCbbF2bf+bNHt/Wk5U/Jw+P+aJ3YdCO
 Ws6wprfkkj7LccwDFrOWLuHRcYRqEQL99ILL6CuVA1avU4B6bIUU3Y0PtXTWTRKzWB3ZFA2GIKi
 hA3D+nevB+ja/cOnQAThmxu1b2/sRQria7nbTVuvz1S3ae9zdZ2YKo8pMXa3uKSHuf8k/Uk3Usa s0awEpUeZoXVQBg==
X-Mailer: b4 0.14.2
Message-ID: <20250311-iov-iter-v1-3-f6c9134ea824@google.com>
Subject: [PATCH 3/5] rust: miscdevice: Provide additional abstractions for
 iov_iter and kiocb structures
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

These will be used for the read_iter() and write_iter() callbacks, which
are now the preferred back-ends for when a user operates on a char device
with read() and write() respectively.

Co-developed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index fa9ecc42602a477328a25b5d357db90b59dc72ae..8daafdc7f3e47aef3c90507082d35ad6819598eb 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -14,12 +14,13 @@
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
     fs::File,
+    iov::{IovIterDest, IovIterSource},
     prelude::*,
     seq_file::SeqFile,
     str::CStr,
     types::{ForeignOwnable, Opaque},
 };
-use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
+use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin, ptr::NonNull};
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]
@@ -119,6 +120,16 @@ fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
+    /// Read from this miscdevice.
+    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterDest<'_>) -> Result<usize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Write to this miscdevice.
+    fn write_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterSource<'_>) -> Result<usize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handler for ioctls.
     ///
     /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
@@ -160,6 +171,36 @@ fn show_fdinfo(
     }
 }
 
+/// Wrapper for the kernel's `struct kiocb`.
+///
+/// The type `T` represents the private data of the file.
+pub struct Kiocb<'a, T> {
+    inner: NonNull<bindings::kiocb>,
+    _phantom: PhantomData<&'a T>,
+}
+
+impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
+    /// Get the private data in this kiocb.
+    pub fn private_data(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
+        // SAFETY: The `kiocb` lets us access the private data.
+        let private = unsafe { (*(*self.inner.as_ptr()).ki_filp).private_data };
+        // SAFETY: The kiocb has shared access to the private data.
+        unsafe { <T as ForeignOwnable>::borrow(private) }
+    }
+
+    /// Gets the current value of `ki_pos`.
+    pub fn ki_pos(&self) -> i64 {
+        // SAFETY: The `kiocb` can access `ki_pos`.
+        unsafe { (*self.inner.as_ptr()).ki_pos }
+    }
+
+    /// Gets a mutable reference to the `ki_pos` field.
+    pub fn ki_pos_mut(&mut self) -> &mut i64 {
+        // SAFETY: The `kiocb` can access `ki_pos`.
+        unsafe { &mut (*self.inner.as_ptr()).ki_pos }
+    }
+}
+
 /// A vtable for the file operations of a Rust miscdevice.
 struct MiscdeviceVTable<T: MiscDevice>(PhantomData<T>);
 
@@ -223,6 +264,50 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         0
     }
 
+    /// # Safety
+    ///
+    /// `kiocb` must be correspond to a valid file that is associated with a
+    /// `MiscDeviceRegistration<T>`. `iter` must be a valid `struct iov_iter` for writing.
+    unsafe extern "C" fn read_iter(
+        kiocb: *mut bindings::kiocb,
+        iter: *mut bindings::iov_iter,
+    ) -> isize {
+        let kiocb = Kiocb {
+            // SAFETY: The read_iter call of a file is given a kiocb for that file.
+            inner: unsafe { NonNull::new_unchecked(kiocb) },
+            _phantom: PhantomData,
+        };
+        // SAFETY: This is a valid `struct iov_iter` for writing.
+        let iov = unsafe { IovIterDest::from_raw(iter) };
+
+        match T::read_iter(kiocb, iov) {
+            Ok(res) => res as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
+    /// # Safety
+    ///
+    /// `kiocb` must be correspond to a valid file that is associated with a
+    /// `MiscDeviceRegistration<T>`. `iter` must be a valid `struct iov_iter` for writing.
+    unsafe extern "C" fn write_iter(
+        kiocb: *mut bindings::kiocb,
+        iter: *mut bindings::iov_iter,
+    ) -> isize {
+        let kiocb = Kiocb {
+            // SAFETY: The read_iter call of a file is given a kiocb for that file.
+            inner: unsafe { NonNull::new_unchecked(kiocb) },
+            _phantom: PhantomData,
+        };
+        // SAFETY: This is a valid `struct iov_iter` for reading.
+        let iov = unsafe { IovIterSource::from_raw(iter) };
+
+        match T::write_iter(kiocb, iov) {
+            Ok(res) => res as isize,
+            Err(err) => err.to_errno() as isize,
+        }
+    }
+
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
@@ -291,6 +376,16 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
+        read_iter: if T::HAS_READ_ITER {
+            Some(Self::read_iter)
+        } else {
+            None
+        },
+        write_iter: if T::HAS_WRITE_ITER {
+            Some(Self::write_iter)
+        } else {
+            None
+        },
         unlocked_ioctl: if T::HAS_IOCTL {
             Some(Self::ioctl)
         } else {

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


