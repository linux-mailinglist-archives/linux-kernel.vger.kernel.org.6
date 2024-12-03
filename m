Return-Path: <linux-kernel+bounces-429444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4349E1C34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0C82835A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41531E5015;
	Tue,  3 Dec 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sqy23aTj"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780933398B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229146; cv=none; b=FWqbG74+FYAGyZmN0FWNhs3BThRB23CV76WAxljHFlgkcs51FSX9NTwzm0240G6G2J2REieMHFWCQ1pUwdAGHAGg4H5LDEriHU9+wWJJ/9skaEyUHzP0PnBObqkzOHMQAhqSfLoseu754qO/w1LSdKirlPnkFLDVTo3oAB5I4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229146; c=relaxed/simple;
	bh=K4K5bH5iL7IGrE+CMedjJXS8p8VdpmNCvWAiSWl+5kg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sIRhIhNDPAYqo9OtvTZ5juRcCRHTfH1V0AfFbZnGtZEvontpV3q5d08cT6DjROIgXhSUAjkLYM8gnQ7VZGL21Vy0IVULHs/uWEWr+yPptFXEduaY4vymjfw03726pz++KNBwWNP+1S6SGcu87dracZW52gj39T5UUacpX9CsoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sqy23aTj; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385e3cbf308so1270860f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733229143; x=1733833943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bsyQGeajoL+2ji0112HTI64BfJRl6hyRMLf4C5WHRH8=;
        b=Sqy23aTjspWlWQZGFE5VvGYZXlZ2o4MR1mUNxaw7C6kf8PejnqbpD+597YVDLvfrdl
         rJ+QCtcBCmFQfXqZqy0szda2Y2/2JGSw5BdsK6+hIkgd+sRFoGM7UwDk0j7/0luqTuoM
         Vrl3Craw5RRIa0jplMBQMwz6NUBCr+8gRNVXr10OXe2RpNKHrFsYARjQjj66MufVVrWg
         DhaPshX3OhARC24gjvh3zjQfWDmM5lEE5p50kWb18fcrxkFr0+JgeakbZy77V3+5oioz
         DoLrJsDx8DgAMOQp3ceJDorCTxqtNkDE+lWYbHyZfrmtzdRcNJIfotx4LX1J8hq/XAvw
         r23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229143; x=1733833943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsyQGeajoL+2ji0112HTI64BfJRl6hyRMLf4C5WHRH8=;
        b=Emyr7LTjclI98NKzXYI5ptdHMYWPQEpaO6DXaqRxAmKYJ1ZnVwVkz456nf3nFuCbFi
         gPWCchpFd1nvEZbICHoooaPWlEy3fD+WlU79SjhVaZIIhs09Q5BDuyLpSafIocDo1pkw
         imzVkEfpFCHg5l+thndNWgP+rIvrM+WV6Oyc93YZ7ltQ5XMH3CY1cnlAhQWNT61oOl0B
         8n0/wcikHAl26rIS+WLtKV7X+RYho486tinr6HnUbDS8lsUFPHgr5LaVN+mjbcDE4Mws
         g6r9yXPHqgef4XmQwlUdngD7Jwntr/6Ky3XgEHL9IQwpzJokRBFR51HtIZuLOVTUxHuN
         59OA==
X-Forwarded-Encrypted: i=1; AJvYcCWpMpzCt82iIPEdFNriuPB1Qh3RhfKkqBGVXPjQfL/L4GyDY2jyh199HvCUxaShpehhtHKMrq8/2lwfDN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytc1ntRHBwd8lKa5HEcnXUr3n1N3nbdaMw4DL/NkYnkPdAAKxE
	SfPlh91hw7otanRKA8h6qiOk/LDr2wsa5b4xpGvIOq1KRhtt7Ce36Y4Kgw8ARI/0VAUz+F5F7pN
	+hIIHLgZfmYg33g==
X-Google-Smtp-Source: AGHT+IFTx1JfUUUE1OX1ur6IdprsxOiC/0OyIrFS6p9HKVQtwnVF7srFtfHtspD/XIYJskcNLw5tvBkvyQLXMbw=
X-Received: from wman26.prod.google.com ([2002:a05:600c:6c5a:b0:434:9fab:eb5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f83:0:b0:385:df4e:3691 with SMTP id ffacd0b85a97d-385fd418da7mr1861614f8f.42.1733229143049;
 Tue, 03 Dec 2024 04:32:23 -0800 (PST)
Date: Tue, 03 Dec 2024 12:32:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAET6TmcC/x2MWwqAIBAAryL73UJaVnSV6EN0rYUeohCBePekz
 4GZyZAoMiWYRYZIDye+rwqyEWB3c22E7CqDalUvVdvhycm6KlpCzwdhMNGcqJ0f/ainQToDtQ2 RPL//d1lL+QD0/RYmZwAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4119; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=K4K5bH5iL7IGrE+CMedjJXS8p8VdpmNCvWAiSWl+5kg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnTvpGWm5GIHyfFAtMwGxN9Y19I3MHyDO78DTgh
 XoA81FGqDOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ076RgAKCRAEWL7uWMY5
 RgPUD/9LHlCHPV6gVuUGvP8AI6mE9nWl2vJH3YjjUB6dhNkdRO1dw9NVrEzoogJ9Fs5wA3mciTE
 c0GohCb/qhtEfP3O3//+IZVQi5I350QDQtsgOH/TYnZRyvESHP74oaa+E5EvjkxX/4DIZG7ax9s
 tme7xdBVghDnWAmkreX70tA9lsF153Ie5N15dN8Xilpqp6g5uaKQrsER513+rfWLh/dUVE2YVbY
 LRbwtd7C41CQnhYW8Ugpirfp3Ps2Hx78nJK/3deoPEsRhn8bwp89rnb30lOBOS8+INAJfiplAAd
 JVIfbnyQ8xnJaUc2OQryvK0J9HKvHjbIc9DLun6MOD9gMKh+bVCiH6sa+QBCy7MhWAZlqd8YzQD
 WbKEDg+4x1jh4z3HDAv2FgAx6Ba2qNLP8U2yF7jzi1q5y1GVNcO4WlvjSifHaOiZLjw5yxzgsM+
 qZIkei41aRAi4kSLfGGS3tHOJY8UBz5xG/saWZh7BfoP63WX9M6teUiY89TFEaAUSUt2Xxy+fs/
 +YaLaEwts6TfwX7aeYs17Ij2i0DuyjSYQalFQ9fF1QGb78zjp2kuyOwWaGXbw5v4kEsaTQKB38Y
 v0hpBzOhUg7p9LBrj/MckajNUIEGC71GQEV6ngDHIgZs+5RZcxd5NRkmpuXIqjOziGJfAsL+Ss4 Hfq6rrUT2eSQeWQ==
X-Mailer: b4 0.13.0
Message-ID: <20241203-miscdevice-file-param-v1-1-1d6622978480@google.com>
Subject: [PATCH] rust: miscdevice: access file in fops
From: Alice Ryhl <aliceryhl@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This allows fops to access information about the underlying struct file
for the miscdevice. For example, the Binder driver needs to inspect the
O_NONBLOCK flag inside the fops->ioctl() hook.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This could not land with the base miscdevice abstractions due to the
dependency on File.
---
 rust/kernel/miscdevice.rs | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 7e2a79b3ae26..0cb79676c139 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,6 +11,7 @@
 use crate::{
     bindings,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    fs::File,
     prelude::*,
     str::CStr,
     types::{ForeignOwnable, Opaque},
@@ -103,10 +104,10 @@ pub trait MiscDevice {
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
-    fn open() -> Result<Self::Ptr>;
+    fn open(_file: &File) -> Result<Self::Ptr>;
 
     /// Called when the misc device is released.
-    fn release(device: Self::Ptr) {
+    fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
@@ -117,6 +118,7 @@ fn release(device: Self::Ptr) {
     /// [`kernel::ioctl`]: mod@crate::ioctl
     fn ioctl(
         _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
         _cmd: u32,
         _arg: usize,
     ) -> Result<isize> {
@@ -133,6 +135,7 @@ fn ioctl(
     #[cfg(CONFIG_COMPAT)]
     fn compat_ioctl(
         _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
         _cmd: u32,
         _arg: usize,
     ) -> Result<isize> {
@@ -187,7 +190,10 @@ impl<T: MiscDevice> VtableHelper<T> {
         return ret;
     }
 
-    let ptr = match T::open() {
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
         Ok(ptr) => ptr,
         Err(err) => return err.to_errno(),
     };
@@ -211,7 +217,10 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: The release call of a file owns the private data.
     let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
 
-    T::release(ptr);
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    T::release(ptr, unsafe { File::from_raw_file(file) });
 
     0
 }
@@ -229,7 +238,12 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
-    match T::ioctl(device, cmd, arg as usize) {
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::ioctl(device, file, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
         Err(err) => err.to_errno() as c_long,
     }
@@ -249,7 +263,12 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
-    match T::compat_ioctl(device, cmd, arg as usize) {
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::compat_ioctl(device, file, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
         Err(err) => err.to_errno() as c_long,
     }

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241203-miscdevice-file-param-5df7f75861da

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


