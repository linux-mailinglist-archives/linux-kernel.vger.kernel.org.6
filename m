Return-Path: <linux-kernel+bounces-376297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4FA9AA2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27BC1C22313
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7119DF9E;
	Tue, 22 Oct 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxS1N5eg"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E519D091
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602882; cv=none; b=PRm0scX65vdov+5qH5Plinc32u6Z6RUBzSvOKuKLN54Z27pP6N3t5JFjRq3yfYI0a5uI342q8ODk1zTLjtz19uBrs26G3+1DWUg0Mr3uHcBxRk7OYyB7pM7b9l4GiTJcEohKNNDeqv5e+5CjuL1hseBoLPE70OvSDx40kZJIjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602882; c=relaxed/simple;
	bh=bzYa45NCqnTORazHFkLQGM6CgtEUVNWRvkcY6jTZj4o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WhzQR+BhbStqQOEX0DRgpken2IyyZqmkYkkmpLNYQ7nMzZsyOwFnaDaW12WgsUqllN3RQlz/U/V8cBaOUF9Oa7TaE/wDVXtNFfJtLuZAwoI4KBwScsHJTInWEx0I5qjs4KwWH8hpUQtM4AFSQAW9FKp+UFoqmr+xBXfKITlJIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxS1N5eg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4315544642eso44960745e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729602879; x=1730207679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRAykP1fNNvIzFYLduUZiWTcjJefEob5v3W2FI1wTa4=;
        b=VxS1N5eg16RDv2J7hGy1mLeapVRLh/Bdf9+kDjf/FWhKdO2OtaCICqtQRlCi2bXhs3
         w9a6AZ1Qgw3E2gEtLkgcK5jXC5VbF8SdZUfx01WPgs7u7Opu17AbFtf+2PenefhWmXqx
         q02VxNGm+7mlZoIt0/kIxKrsxSwaAlRGCjv66j9fStfyxkne3x9sqpcOI4uUaQdpj7BJ
         oJVKq9Bu010JXDJIeFltxvpBbUlF2HS0cgwNrF0neQjpzNyn8rPS9q+31jDg1UkOHWrH
         xcf/oA0MfiXX2hr1ufdE+J+sQW7tdS+LCkQXy1e7zLgM7DX1DMRZl3U2Lt0oqeizpluj
         GvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602879; x=1730207679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRAykP1fNNvIzFYLduUZiWTcjJefEob5v3W2FI1wTa4=;
        b=K90px03dWAG4qkOx+Jp7ZF4ERXlvFBGObUaGylfDrVMwiMLtmzZJqPQXhsmt2w+pEG
         W8Ua8FWQRWkYtC9XktxrOuV5oSeL1PA43fU8b0SocLuDiipEMbPMMEIPaWtWw30ve7wz
         9nWNa6VCK2uKQIBuMIVGvRXCXsg29RyzOZ3ytH/LKB1ZzTP7LOjzHYk99O5YkimbVevH
         S1d9rnzNZg7FrIe41/gWaIm29jE82E7y4aMyWdJinPVZjdArAyny+NeUlhizxQOfDdrl
         HIirtc8OnDIkKMIku0gscLSJOtPsQrtwAo1gelUYh7frcuEnviVhl2ctsXFMYf2kfcAG
         7UCg==
X-Forwarded-Encrypted: i=1; AJvYcCV/GKQ2MmSAO0RUlW6VcLy2sS3XO83zlAvbDyaY4jn9yoXP753TZKG1kgjsWLjAV3vLtUVmKh91Mtwtw1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsiGWwmVoJZ3CB4qlkc1zFZcnVKwYqbNH8h/WyRacsZ9Oakpi
	LX+7EQ9vyHx5doDciGNZmOrMsa1gS8cO9+CBB7KUx74nHxt4pkuvfTR7fAdIDWSBT5cDHFYzes4
	W8KgBL62FOfIWsQ==
X-Google-Smtp-Source: AGHT+IFcqWhJUXiZ+rZ/V741zsPMrG2CvyVlgjMZLkwXlzhjncAltLOLeJDXI64RvetcvYdkLvACS6viaCgQRDE=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:255:b0:431:3ba7:7854 with SMTP
 id 5b1f17b1804b1-431615b82edmr519905e9.0.1729602879107; Tue, 22 Oct 2024
 06:14:39 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:14:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACSlF2cC/x2MywoCMQwAf6XkbKCP7Qr+ingIbbqbg1UafEDZf
 zd4nGGYCcpDWOHiJgx+i8qjG4STg7JT3xilGkP0cQk+RryLlmphYXx1pcb4odGxyRfbOWWfMq0 5BLDBc7Dp//x6O44fT/hL3WwAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4553; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=bzYa45NCqnTORazHFkLQGM6CgtEUVNWRvkcY6jTZj4o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnF6UqAKf9A2qfrFBy87/C7ylF9u/jbGKpGNj/K
 lr0mAkYWHeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZxelKgAKCRAEWL7uWMY5
 Rnu/EACUHXj1gYSEHGrd5wJArXWLMfyyKdkuvDvPNGREdQKqWJjVuhy1fgUN6aqm7xenYMDDCUl
 l+k1xTusz/+FEdjgLcb9HYkuvuCBE6sl8BLNlpe+PwLHIAa54hnEEWzSm2Bx8370alpPhyQrYxE
 sS4tT+g/lTUj1FpaTRI1RgCs9bp4q2UEj7MOQnwSZHHREAfBEZHJHsFHCR7s0XRPF2q8RoiWmSf
 2Y8pK8bERSWvXvTz9mUvW4VNpmyeD7+gc+veLgJY6bf5iqvdTO1ML4WEGR9dTz9mh9Y92VLh5JW
 /4HrQjFkpMvs4/zJ3lhJma9vHtvpTrkOwbbQS0X0xGatGNBbZmQJcJogPFyFMsN04YzkEg8G3NI
 7tANuPgmXxNgQE00leptSEm5r/sbE1R4gZoxIa+D1DTxi873C098PBZx9f1nPXO/OZZWpWhpTvM
 OK8PYWn6QNsdoytnGRU9M0bGNIg0irNOIINRB1MscHDlKADfQD6DdXzDlms0/FdRjvu2LTTdezs
 vUF43O2QMr5wG4GnkR41WrGB3H/DN9fh6VyCZsn0cgTzlmArisQy4oiOX1Q2xUzB/FVZfQT/EsK
 44ku4oyUyQzl3UNfSnkkD3dqUo8JOkU7n7iJe7sHdtqhP4K8IxTek+0nLWcdzeYW6NEJmPoI7YG sDIKOw5fpoOOnmA==
X-Mailer: b4 0.13.0
Message-ID: <20241022-miscdevice-unsafe-warn-fix-v1-1-a78fde1740d6@google.com>
Subject: [PATCH] rust: miscdevice: add missing safety comments
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Arnd Bergmann <arnd@arndb.de>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This fixes the following four warnings:

	warning: unsafe block missing a safety comment
	   --> /home/aliceryhl/rust-for-linux/rust/kernel/miscdevice.rs:168:15
	    |
	168 |             ..unsafe { MaybeUninit::zeroed().assume_init() }
	    |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    |
	    = help: consider adding a safety comment on the preceding line
	    = help: for further information visit
	      https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
	    = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`

	warning: unsafe function's docs are missing a `# Safety` section
	   --> /home/aliceryhl/rust-for-linux/rust/kernel/miscdevice.rs:175:1
	    |
	175 | / unsafe extern "C" fn fops_open<T: MiscDevice>(
	176 | |     inode: *mut bindings::inode,
	177 | |     file: *mut bindings::file,
	178 | | ) -> c_int {
	    | |__________^
	    |
	    = help: for further information visit
	      https://rust-lang.github.io/rust-clippy/master/index.html#missing_safety_doc
	    = note: `-W clippy::missing-safety-doc` implied by `-W clippy::all`
	    = help: to override `-W clippy::all` add `#[allow(clippy::missing_safety_doc)]`

	warning: unsafe function's docs are missing a `# Safety` section
	   --> /home/aliceryhl/rust-for-linux/rust/kernel/miscdevice.rs:196:1
	    |
	196 | / unsafe extern "C" fn fops_release<T: MiscDevice>(
	197 | |     _inode: *mut bindings::inode,
	198 | |     file: *mut bindings::file,
	199 | | ) -> c_int {
	    | |__________^
	    |
	    = help: for further information visit
	      https://rust-lang.github.io/rust-clippy/master/index.html#missing_safety_doc

	warning: unsafe function's docs are missing a `# Safety` section
	   --> /home/aliceryhl/rust-for-linux/rust/kernel/miscdevice.rs:210:1
	    |
	210 | / unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
	211 | |     file: *mut bindings::file,
	212 | |     cmd: c_uint,
	213 | |     arg: c_ulong,
	214 | | ) -> c_long {
	    | |___________^
	    |
	    = help: for further information visit
	      https://rust-lang.github.io/rust-clippy/master/index.html#missing_safety_doc

Note that these warnings are currently not enabled in the build, but
rust-next contains a commit that will enable them, so we should fix
them.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 50885fb511bf..7e2a79b3ae26 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -165,6 +165,7 @@ impl<T: MiscDevice> VtableHelper<T> {
             } else {
                 None
             },
+            // SAFETY: All zeros is a valid value for `bindings::file_operations`.
             ..unsafe { MaybeUninit::zeroed().assume_init() }
         };
     }
@@ -172,6 +173,10 @@ impl<T: MiscDevice> VtableHelper<T> {
     &VtableHelper::<T>::VTABLE
 }
 
+/// # Safety
+///
+/// `file` and `inode` must be the file and inode for a file that is undergoing initialization.
+/// The file must be associated with a `MiscDeviceRegistration<T>`.
 unsafe extern "C" fn fops_open<T: MiscDevice>(
     inode: *mut bindings::inode,
     file: *mut bindings::file,
@@ -193,6 +198,10 @@ impl<T: MiscDevice> VtableHelper<T> {
     0
 }
 
+/// # Safety
+///
+/// `file` and `inode` must be the file and inode for a file that is being released. The file must
+/// be associated with a `MiscDeviceRegistration<T>`.
 unsafe extern "C" fn fops_release<T: MiscDevice>(
     _inode: *mut bindings::inode,
     file: *mut bindings::file,
@@ -207,6 +216,9 @@ impl<T: MiscDevice> VtableHelper<T> {
     0
 }
 
+/// # Safety
+///
+/// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
 unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
     file: *mut bindings::file,
     cmd: c_uint,
@@ -223,6 +235,9 @@ impl<T: MiscDevice> VtableHelper<T> {
     }
 }
 
+/// # Safety
+///
+/// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
 #[cfg(CONFIG_COMPAT)]
 unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
     file: *mut bindings::file,

---
base-commit: 4f94fbb8848c4d2bc5260045ed66907b1bf520fd
change-id: 20241022-miscdevice-unsafe-warn-fix-f735035a6511

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


