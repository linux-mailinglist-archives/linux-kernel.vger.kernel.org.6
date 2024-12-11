Return-Path: <linux-kernel+bounces-441163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E899ECA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150BE188D43A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90623691A;
	Wed, 11 Dec 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Snz4vEGv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324822368F8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913470; cv=none; b=MOqrjDznxRtm03V3Fkfjnl4yLuWezop8CNfprqtOOje8s4NE0647PTpBvncAQnbjSpp0vLyg22uF/owUUow60GnfT6e9eEIubLUdaLX3u2DUBTCJ9vxdWRgQ9Pp/0uOEU9hF/bUSvyr0+srLtkgRj3qluQJ1FhyZZwzz7Y1THjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913470; c=relaxed/simple;
	bh=kzjS+ohxpZzNcxKXIXjmOFsrjiQU+XTutyXr8P3Ah4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bEgLjJocDf8rXAn74dxrsS9X+pE/zwki0ju/mTPz+cwIhxUtdvwSR5fHqomgcuicuLILooNFYWbzX8G2iUS7xm4dDZLAvNpfcVaPgQdzgPAqVGGhkVM1uuxjNiiuhWslGSTbna8w+wHp3/AL33ogy16mbA2CZTUZAo0NOsw7ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Snz4vEGv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434f1d39147so22998515e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913467; x=1734518267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTGvDMTG6tS84iSkKnwUvzTY8tCVI3+QbIdPlF0cheo=;
        b=Snz4vEGv5rozvAbPIcHfUxgexy7ZSGcFaME9OU+2/J56NmlxBR2LkSDr1bU5Qpu4Sr
         0gSsKsXcORkTQqNiO+ZWnD3jGlKqrIRGFD8VwzoYsOKtMJhXeOwCeQ4AR04wSRQ/u4Gw
         sXZuLEUCnh49VQOA9+Tu5+tH9NumIVQWUuerlOiWqBwq/bnwBZOIMgSnoXJnFnPyYLdi
         DkxqySeTYPTPbO2/LgdeiQ9VFUGecylV2sWZZAA2LQIP3RLyV37LK//LTwMqX26l8UH0
         ZWqzs1GWwNlXV6iSDvnadb0ZZkMwqWlkFJEqAc4xfvldUydZilE1jIohDe28Xa5yaMnx
         Oiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913467; x=1734518267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTGvDMTG6tS84iSkKnwUvzTY8tCVI3+QbIdPlF0cheo=;
        b=nnVTYRYqIOq4NJFh269WwFby9ifuU/EPEnEcXJzjE8E+HcnqmTcGorLh1I24IqkZlI
         DcXWq3Fe1cXc3pIWo/xKgkAa6KeEJ6/WtwebpjKL8bboiMjJseBADsH9O1FsmX4OhHg2
         s3IPeq7DjEEICJW/D1WYorJc9U4M/cQVxNU3ZIx7qi+rlUmGDqNlXSacnPTLjkyUiRCO
         uy6kNL7R+B83jBsru0z9OY8OyhxzGSL+VROTqQPjInNc4VSasesCd/0qwZN2aZJUqdzm
         bxY07FWmw6J7gLNUSiqzV4LOfxJd28kbHOZfuUXcQoOoZNCLWRq9wK7iRsrX8i3mWJZo
         h/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVTikLQoshjy6Vk2aBSnftNvZQ5cGLz0VrwF53IxDGroT18XbEJfNim60xlcud0U3LfKOsNWh4fDmxbn04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/IbVFrDKutcH298NRV9Be6LSTjB3KCFUo8GjTcdonfWNsu7d
	3Blj9gsUWq7PgeH9s0MRREXzPIfG4Pl+0o/+Wc0mL6q0lZWv1cgr6JM/rjhE6SIu79FCCqxVv8o
	bo7UzC0HwG7r0BA==
X-Google-Smtp-Source: AGHT+IFbQovoxVXUDOnrp4PlHMXfzU8u47wUa/LBd5eLin9mhsNX8CNYJjENnzGGaQ/unC/QIRj6aAvvCl/6L5c=
X-Received: from wmbf11.prod.google.com ([2002:a05:600c:594b:b0:434:a98d:6a1c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83cf:b0:434:edcf:7464 with SMTP id 5b1f17b1804b1-4361c418431mr18973185e9.30.1733913467697;
 Wed, 11 Dec 2024 02:37:47 -0800 (PST)
Date: Wed, 11 Dec 2024 10:37:11 +0000
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=kzjS+ohxpZzNcxKXIXjmOFsrjiQU+XTutyXr8P3Ah4o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWWtphPlZQRQby61uOX0k3ecWUliVN/FZJFCoi
 bM4aIl7KVeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1lraQAKCRAEWL7uWMY5
 RpGaD/wMi3M4it7Hk8rAcHr7ywdgfyToJ+g739ILqsktYqKVFQs/m+KIByJs+9mKBODgiyL10K5
 PEZYsa0Ox8s8XKZPI69psKntnEhe3GjUUvu7px0f15cmt57bRZODDgo3vI59YfdTW5FZOESP9RD
 YhSPLC08wMnnoQBxpcm99TqMClCmmsWIlo4bXZfGvuzS2CJUipJ9sptfZzzrYVIKNO23klgaGPQ
 8yZF6MBm59u1msMIvMt35PK1aBm/0EVWPzHCjgQnSqZTbQfrF0VdVZ5yjRfJiEzqf7NT36yIkz5
 a89RzhZKbKMOqBVSMGJ7WHIpfsblZ/9wBgcrgDYLjQRb0FTgJQemp5aXCPWaXMNLS/rtMH/O0VQ
 eaYb9srV1MWgtGQOwbKFC8C0jIWhmSOiTdUabE96UYeBrzR4OkXqW1nPI/E6OaG6jx9o34JdWHQ
 nCIW7jvcdA2V19zfyaTQT+zOkrX6OJ3rfccVMAXlArE2lHiCUpKWFt7L7z1DlYoYj9PmjnUaTZn
 IIsFDF/0jEngVlAuF+Fw+EHPuOXm2I4uasrQubr3yOClmPU2OeM9hwv1p1GvOzU6QfgS0LZempt
 ng0nHj9CaNoclmMK2hvLhOPagmeyxUlGOVFA12epr2x5ASIL++FcelN0S6Uqpdlju+Q7hHbXi1C UQa8vdmTLIt2gug==
X-Mailer: b4 0.13.0
Message-ID: <20241211-vma-v11-7-466640428fc3@google.com>
Subject: [PATCH v11 7/8] rust: miscdevice: add mmap support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add the ability to write a file_operations->mmap hook in Rust when using
the miscdevice abstraction. The `vma` argument to the `mmap` hook uses
the `VmAreaNew` type from the previous commit; this type provides the
correct set of operations for a file_operations->mmap hook.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/miscdevice.rs | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 7e2a79b3ae26..e5366f9c6d7f 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,6 +11,8 @@
 use crate::{
     bindings,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    fs::File,
+    mm::virt::VmAreaNew,
     prelude::*,
     str::CStr,
     types::{ForeignOwnable, Opaque},
@@ -110,6 +112,15 @@ fn release(device: Self::Ptr) {
         drop(device);
     }
 
+    /// Handle for mmap.
+    fn mmap(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _vma: &VmAreaNew,
+    ) -> Result {
+        kernel::build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handler for ioctls.
     ///
     /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
@@ -156,6 +167,7 @@ impl<T: MiscDevice> VtableHelper<T> {
         const VTABLE: bindings::file_operations = bindings::file_operations {
             open: Some(fops_open::<T>),
             release: Some(fops_release::<T>),
+            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
             unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
             #[cfg(CONFIG_COMPAT)]
             compat_ioctl: if T::HAS_COMPAT_IOCTL {
@@ -216,6 +228,31 @@ impl<T: MiscDevice> VtableHelper<T> {
     0
 }
 
+/// # Safety
+///
+/// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
+/// `vma` must be a vma that is currently being mmap'ed with this file.
+unsafe extern "C" fn fops_mmap<T: MiscDevice>(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> c_int {
+    // SAFETY: The mmap call of a file can access the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Mmap calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
+    let area = unsafe { VmAreaNew::from_raw(vma) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::mmap(device, file, area) {
+        Ok(()) => 0,
+        Err(err) => err.to_errno() as c_int,
+    }
+}
+
 /// # Safety
 ///
 /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.

-- 
2.47.1.613.gc27f4b7a9f-goog


