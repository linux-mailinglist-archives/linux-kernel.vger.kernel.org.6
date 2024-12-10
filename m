Return-Path: <linux-kernel+bounces-439241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDE19EACAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E6816B39F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5729226531;
	Tue, 10 Dec 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHmVQEka"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D156223E75
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823565; cv=none; b=GisP+xpE02yrVXykvzCF5S8BZ/Z2rkTQv02jOaZqt80ZEc2UsQ2M3UweHlAYPBLLz4Be0hrmO+3r+LWslPRdbTzOTBrim4CSItLndoRshOg0rThUDFtfBmLEY9TN04uDSxESHIw8OWfEvB7PZOJzPWjvOB8mHmr9FNf93PF0Z4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823565; c=relaxed/simple;
	bh=TIZgaELzS4o7ZQ2rRybQ/bDaOlh/wZlUNZbESQXsjQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HLPotcNG8dWZqFhdn7zCkY8/fntT7GWG82VzOt1exij0h8NLp8gqO3WOAvsfgWFacg/aBYFiBzqXepihp/Gu4LtHw1SaA1W+TaUBlVyQXa5KLkEL241ytsSFwelJG8BJVpDoJ8XqxmencNhLaE3zNfAsXuMRwMB5ak5qXRE4Tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHmVQEka; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434fff37885so6986955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733823561; x=1734428361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFa4Sx8o03OpDIf4yd72th5gbNsT5Y/F06Nhp3ZErPo=;
        b=SHmVQEkaC0ZgiaavyLj24Df6FPZJr/SU2t7VwnSWioVcEpPXsT7e6XsZi1lwVK8iTy
         ldl3ym+YcJPdq0cCPsL/NHUPoc/d+OE71TlMsm/UiAKOlAZvshDqhAZPat3wEFk5+dut
         /W2euzF3FRKEgG6lC1VOGx9jGSKB33sCgV3p1T5x5xc9Qb7osJX0qK6k1t2PK/h9ukia
         MppCeUdZV6jC7OZDYZBY6mAjQjxU7D50CyEkUoTNbdaNHIvcC2B1szVwjWfR+9LgRK2Y
         1atjo1JUu1cctHLf5SO6qcJ9iMq2gz5Gd2QJ7PMyDJ8EfWx853xRQ3G7kKwOcqEL0K+p
         s+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823561; x=1734428361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFa4Sx8o03OpDIf4yd72th5gbNsT5Y/F06Nhp3ZErPo=;
        b=HT41+W6ml5Oj23wQvmHnu8zZOogBhTVMU90MKBBvhSzkdluTS9zD6qDr51XijEs7T9
         OaN+nTBOvdwUbE6pmKYZvBBNJGT17/EQXco97gv/ZaVOpyEuyy/jOfgAxT+caMf2sjMe
         jaw+uE2zUn5mmwkFwst9jXL31ggnkQnHXIs25b4fS26KWCo4DjLTEsO4Pyi4m8vjU3uu
         72ZVKFdomuQXg72d+0jpXGgimSPtnyi8Q7SHq5qj0bW9Opm4Hu/CUtChdMcI+Zb3F3RQ
         /xEXottVHRr1newC/t6lxWxae8//GpNP6SpuQcdbfyABqNZoukbFocrh94TtVD5a9wav
         hTcw==
X-Forwarded-Encrypted: i=1; AJvYcCXH+BuQvEhoS5kA9QViR5cDY47G4bwKK99K3fxd3JnRaXe1EBRo1wAEXKzfTO3fx/G95JXrsBh9ex6Sz+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSeLDBUp2W2z7VlDx0zNQftEeP5YCY+rKRzbtziBQCTyO+hVG
	xI2mNDfU5MJaz2jaZGe5xaRP740BHeXX8yDkXAcMzp8d91T0GNluDQr7VUgraiGtsbMwhXlJh3J
	5cPbO3fx5NhOutw==
X-Google-Smtp-Source: AGHT+IFTAIsoLjCnseunZkxQrOKLy3SO/tU28cLm2zGgylonn6ozjaJ7xFiN74e3V5QM1iTmYhSYvxVlSI32agI=
X-Received: from wmsk4.prod.google.com ([2002:a05:600c:1c84:b0:436:1673:20f2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4024:b0:385:ebea:969d with SMTP id ffacd0b85a97d-386453dd647mr2609026f8f.22.1733823561743;
 Tue, 10 Dec 2024 01:39:21 -0800 (PST)
Date: Tue, 10 Dec 2024 09:39:01 +0000
In-Reply-To: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=TIZgaELzS4o7ZQ2rRybQ/bDaOlh/wZlUNZbESQXsjQQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWAxCQ1h2WpVVpnD0aW6J6VK3++n+QS/SZnSaX
 rEfMES1WVCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1gMQgAKCRAEWL7uWMY5
 RhI7D/46ycYdrqP5Pz7sFmDy42lQFhujE1YwfYpsec2TpPTd4tIK9CIul6vG/mJXJzNjdVainmD
 KLRHFAv2yIfkmzmGbITsotYwcruhMV9fhjEIIa88SCpPUGoFHH6hHzFzKHFrWzGJxIc1/JRGSbW
 I7Hj/jHBkG3WSce8/GBA5+8ES78iSWj81cBBMXoBKE00jCU3eShL6lIr93nBK0I5qwPzdN2BH7+
 HYBoXmXrHUgHJV51fbRZaP6GGMRLjPclhL6FoIVi3PN2au2a9OFaXu9zHC22IbOWukkcGrH+jfL
 +hp6fr6jOK2nS0GBRupsJab4Grqkv952VUk+lPtwZi6Gu/yjGCkLvDZNgyoD9OssBqVCe6yzJ/y
 jf3Gc2mAQOdAJ4uYdn5xsUn0aDxqzM+97iXCSdWPh4xk+A/oxP0IYIs7LXKpvl8ymFBjuSZBjUI
 ejXvA5cFrnkajiZpGW59mvvXbqroV9tggdDeayGIUF5dnuVVYPmUXddGeLKS2EXDoizBdqMdkRB
 IjimKnSnCXHHsH8JMgLZXjFjxrchhxnpR9Q0O6xCPGhfKzYzfuRSplXpo+96h4gH2O3OIernJ/Z
 AdXGX9q7up8xZ6Y8KLlsAX5m/BJmu5d0avcH/r4nBPj9mLhSz+qiU7J5lPKMVH3/ftK3XTdv7x1 aLVfLqf6VWwb3BQ==
X-Mailer: b4 0.13.0
Message-ID: <20241210-miscdevice-file-param-v3-2-b2a79b666dc5@google.com>
Subject: [PATCH v3 2/3] rust: miscdevice: access the `struct miscdevice` from fops->open()
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Providing access to the underlying `struct miscdevice` is useful for
various reasons. For example, this allows you access the miscdevice's
internal `struct device` for use with the `dev_*` printing macros.

Note that since the underlying `struct miscdevice` could get freed at
any point after the fops->open() call (if misc_deregister is called),
only the open call is given access to it. To use `dev_*` printing macros
from other fops hooks, take a refcount on `miscdevice->this_device` to
keep it alive. See the linked thread for further discussion on the
lifetime of `struct miscdevice`.

Link: https://lore.kernel.org/r/2024120951-botanist-exhale-4845@gregkh
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 0cb79676c139..75a9d26c8001 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -97,14 +97,14 @@ fn drop(self: Pin<&mut Self>) {
 
 /// Trait implemented by the private data of an open misc device.
 #[vtable]
-pub trait MiscDevice {
+pub trait MiscDevice: Sized {
     /// What kind of pointer should `Self` be wrapped in.
     type Ptr: ForeignOwnable + Send + Sync;
 
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
-    fn open(_file: &File) -> Result<Self::Ptr>;
+    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
 
     /// Called when the misc device is released.
     fn release(device: Self::Ptr, _file: &File) {
@@ -182,24 +182,38 @@ impl<T: MiscDevice> VtableHelper<T> {
 /// The file must be associated with a `MiscDeviceRegistration<T>`.
 unsafe extern "C" fn fops_open<T: MiscDevice>(
     inode: *mut bindings::inode,
-    file: *mut bindings::file,
+    raw_file: *mut bindings::file,
 ) -> c_int {
     // SAFETY: The pointers are valid and for a file being opened.
-    let ret = unsafe { bindings::generic_file_open(inode, file) };
+    let ret = unsafe { bindings::generic_file_open(inode, raw_file) };
     if ret != 0 {
         return ret;
     }
 
+    // SAFETY: The open call of a file can access the private data.
+    let misc_ptr = unsafe { (*raw_file).private_data };
+
+    // SAFETY: This is a miscdevice, so `misc_open()` set the private data to a pointer to the
+    // associated `struct miscdevice` before calling into this method. Furthermore, `misc_open()`
+    // ensures that the miscdevice can't be unregistered and freed during this call to `fops_open`.
+    let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
+
     // SAFETY:
-    // * The file is valid for the duration of this call.
+    // * This underlying file is valid for (much longer than) the duration of `T::open`.
     // * There is no active fdget_pos region on the file on this thread.
-    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
+    let file = unsafe { File::from_raw_file(raw_file) };
+
+    let ptr = match T::open(file, misc) {
         Ok(ptr) => ptr,
         Err(err) => return err.to_errno(),
     };
 
-    // SAFETY: The open call of a file owns the private data.
-    unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
+    // This overwrites the private data with the value specified by the user, changing the type of
+    // this file's private data. All future accesses to the private data is performed by other
+    // fops_* methods in this file, which all correctly cast the private data to the new type.
+    //
+    // SAFETY: The open call of a file can access the private data.
+    unsafe { (*raw_file).private_data = ptr.into_foreign().cast_mut() };
 
     0
 }

-- 
2.47.1.613.gc27f4b7a9f-goog


