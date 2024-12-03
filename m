Return-Path: <linux-kernel+bounces-429445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8819E9E1C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E34D166679
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C41E5000;
	Tue,  3 Dec 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCTswzuI"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889411E3DCA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229285; cv=none; b=YNqVrZQLACsGJpI/uRnJMJUlHdVpMbrOV1xO/5ZtuphUQSZsRzmV5bxSxzZFvbSZLXMK10RBVHD2qtsKY4P1WOPPgFYpJzddg15OrALNgIZvaGNbk0H1UvWNeEaZEMdE8d3JkqwVq0TsKV+H4hQwtyIHqKGHiBuBa3iHunejJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229285; c=relaxed/simple;
	bh=P5XsowLTop/fxlXeMKyEZ7YKyyNJW2T/VgiXS6bBYgI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oCvq4Xtudk30vt3Nwsct4MUsLU5gGkcBq3fjkNufrLOW6QbU44fkyqgj3Rw64wAIpH7X3qbcetPYFW3IQvYrdnn05N6yBs4ur6aO8rKHlFKgQ5y68QF22e5zWwyoaRji6Pv27KjKsOa2nMLy0CQs8jz10VKSgmADwSXfMeNfsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCTswzuI; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385e9c698e7so1715038f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733229282; x=1733834082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWiUS3KSfSWn7V1ibv9seUEX+RkuYFYOGqIyFpu2N1Q=;
        b=fCTswzuIEWQRrX5kC3xkIn9ex8kYo5JzGj7+NzdjNvE0IcQpmi2W3oGlJKR2F3pdpN
         5sKcdIj2gpPUv55A8RDNmJK2A35sqe8aHAbDEVmHaGPiIgkJ9sJyLk5LCdF8zVPwDa8M
         cxp72y2IKSDwky1Khjz6Plr8MtX+Dgd26HOjSsw412wsWiPjqmB70FaBTTvFQFEpSUCl
         8L8mRmQ39wyKIDOqAR5cOKEX2C/i7uwP4BaT6bu9cZQYMaJcq/sWxJse+vAARy8zZZR8
         HFNvR5pNGOWA/Zbk9lgkrZQVztFXl2Esg+/xZapg+sKJPO8GZnv6eXd3l11v5apxnikV
         gzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229282; x=1733834082;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWiUS3KSfSWn7V1ibv9seUEX+RkuYFYOGqIyFpu2N1Q=;
        b=N7TnJWvF3pDa8hfCItvQdJsSnZN3xWnpLyTQ/OcRcE9ED0M/tNNdOZg11gLvfVw4Ch
         YvisBW+oejUMfjfZmfYzNmFoU/pRhxefFORmrD4ZxNu9s0KSkvAuCmGKwNaDdVGytjmE
         mSYKJVYu84axbt/FCmdddy8R86/1341QiACoGXGgvwhjN+C8UYvVwDuu43YUtTwVMkTS
         bsBb4I89j4igi6/2cvK0lXBSqQnaA97OliZ69hGuy4amp8X+7uung2k3+isFKR5al5BK
         5TMXnQVOm4QRUaKenRaFis6WulWzG8SLecpM3dNENFFFwmZ2gmwHPZFRAiQYQ8CGZ5eZ
         asHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Y0wp27b6sSt8KWox8qppO7Y5cod0tvNecXwZcLW5hskpiEIZi5VcciPvRA51sz+9h2S6bH/9wPfYyAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kG6L9rKsRgiIyTN9yjkD90PilT4w9m7+T3JTIQixo8TGp3h4
	r/n4TYfL/e4shzuWEPE8H5NN/RH7qJGad4WuAcUQdwnQgpfViRROzzTe2KVHWRSzOnxSYpDSxS6
	5gf8JfLlX5P+jrQ==
X-Google-Smtp-Source: AGHT+IGpKZPLv4obgyNcShy8cWSbJ9x+38o8QAsbmZpH/fmxNgN6IgAtxx5EI/ELa0oKAW2CJM1ODQWjhGRhRKA=
X-Received: from wmbf1.prod.google.com ([2002:a05:600c:5941:b0:434:a5c2:2758])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64a3:0:b0:385:f69a:7e52 with SMTP id ffacd0b85a97d-385f69a807emr5437437f8f.15.1733229281943;
 Tue, 03 Dec 2024 04:34:41 -0800 (PST)
Date: Tue, 03 Dec 2024 12:34:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN36TmcC/x2MywqAIBAAfyX2nOALin4lOoSuuYc0XKhA/Pek4
 8DMVGAshAzLUKHgTUw5dVDjAC7u6UBBvjNoqa3S0oiT2PkuOhQc8xM8pZCFUnaapQ5WGoTeXgU Dvf933Vr7AC1SvNZnAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3098; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=P5XsowLTop/fxlXeMKyEZ7YKyyNJW2T/VgiXS6bBYgI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnTvrflqy7xay9NEhDtFcaO/NnmfqE9wixadTak
 U0fyHj6HkyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0763wAKCRAEWL7uWMY5
 Ro4bEACwKG1hLQoIAcQDmYdxQSue0xRJidilbl+rs8jlwiOvQwINow6aUzV/Phj3FOv0lhfGTkt
 zUlzxzpOG5PRRs88aJ3f6ANZaPiHp9RzYrkpaa5KM+S9ZXCo/QT3+zcsBPiprrUeEFvm0LeOmKh
 F9PaU/xv5cJeHIQLMhaOtfDpLE8RkBFvksUxaw5A8ikvPR1Q9xhrQ7fCM9ktibXNll0gUcu+hxI
 LTglgKzoPD/KjX1/oCzE1Pne/IvsoCorKq2E3APS0Apyhdr2I6QVi+16OQxGmvOjEZhguc0C4RP
 Lh6GoKhyWMHjMsshjfJCwAThw/gieK3LPugqEBt6v+zDk1sZ9GN9FRe7aYAswSAwU7UuUALkTXD
 o+1DT6d9kOQwipfRcfClWsC43YagsQPwT1oxrJHa9ryrppEB+iJ8RAg76cQwtmV2Zm2Qsl70Z8R
 5cjUR8uCeTj1MYAuoE8pV3ejblYUTx4Qrat3AgtLIxmyW1CBljg5bEU0tghES46W712G4dGp30b
 rv7iYo9mBO7NyEN0xBrWV1ApBpwxjFW+8GNbaqWDokRLJwapcVkiSk0wE0Z/18vTOb8bVHoXT44
 8EtvMw/20ZNuOaW1iP4RD9iqhbcTLN4cQbsivwhJ0/9YYIpcLgi9Zd9PXwyXf/z+MNbsdMreqGZ /2FjN6353gWxiJQ==
X-Mailer: b4 0.13.0
Message-ID: <20241203-miscdevice-showfdinfo-v1-1-7e990732d430@google.com>
Subject: [PATCH] rust: miscdevice: add fops->show_fdinfo() hook
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

File descriptors should generally provide a fops->show_fdinfo() hook for
debugging purposes. Thus, add such a hook to the miscdevice
abstractions.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This could not land with the base miscdevice abstractions due to the
dependency on SeqFile.

As for the dependency on File, please see:
https://lore.kernel.org/r/20241203-miscdevice-file-param-v1-1-1d6622978480@google.com
---
 rust/kernel/miscdevice.rs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 7e2a79b3ae26..190d7f477346 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,7 +11,9 @@
 use crate::{
     bindings,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    fs::File,
     prelude::*,
+    seq_file::SeqFile,
     str::CStr,
     types::{ForeignOwnable, Opaque},
 };
@@ -138,6 +140,15 @@ fn compat_ioctl(
     ) -> Result<isize> {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
+
+    /// Show info for this fd.
+    fn show_fdinfo(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _m: &SeqFile,
+        _file: &File,
+    ) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
 }
 
 const fn create_vtable<T: MiscDevice>() -> &'static bindings::file_operations {
@@ -165,6 +176,7 @@ impl<T: MiscDevice> VtableHelper<T> {
             } else {
                 None
             },
+            show_fdinfo: maybe_fn(T::HAS_SHOW_FDINFO, fops_show_fdinfo::<T>),
             // SAFETY: All zeros is a valid value for `bindings::file_operations`.
             ..unsafe { MaybeUninit::zeroed().assume_init() }
         };
@@ -254,3 +266,26 @@ impl<T: MiscDevice> VtableHelper<T> {
         Err(err) => err.to_errno() as c_long,
     }
 }
+
+/// # Safety
+///
+/// - `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
+/// - `seq_file` must be a valid `struct seq_file` that we can write to.
+unsafe extern "C" fn fops_show_fdinfo<T: MiscDevice>(
+    seq_file: *mut bindings::seq_file,
+    file: *mut bindings::file,
+) {
+    // SAFETY: The release call of a file owns the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+    // SAFETY: The caller ensures that the pointer is valid and exclusive for the duration in which
+    // this method is called.
+    let m = unsafe { SeqFile::from_raw(seq_file) };
+
+    T::show_fdinfo(device, m, file);
+}

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241203-miscdevice-showfdinfo-1147802f403e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


