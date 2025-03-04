Return-Path: <linux-kernel+bounces-544068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD60FA4DD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5794F3AF839
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA37202F76;
	Tue,  4 Mar 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zB65Mf9B"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E9201025
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089115; cv=none; b=pMGYOWd22BunmzQSl1Q6qg9BZ54h9+11QV3RzzCsjo/U8Kf9l+ZaGgmKFK0ozR9pAJZpxg9Fqad3jCeAJqUs9Q5A6Tb5fQ8bz0dfFj2eqtJIwVTD/F4a5o89YRHnjILjYH3kV9y4iFJF12h9Xs+UdpgEwdlnV4wrVcr3U+9mduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089115; c=relaxed/simple;
	bh=/C8f07Nhmn9r2N3ZtBFXfPSvF/v+MduRZhwmhE1w51U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ou+rmp86jOK0x+CR2vYuBDTi/bF6KKFKmPVAAGUlAYpwldrShMtReLW51aVO9BDeLeiOg7+GN4CzTFI6R4KtLhnMXTz3FAzHzHo2qXVSxhJL5F7ij/Ndic+FG7gIXk/tr0di0ikEe2UsF59aaj9piBB7oNCrmSdNsTQZWA/nO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zB65Mf9B; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390fc428a45so1135443f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089111; x=1741693911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AL6XZaDC/No54Uy7L4GaNa2roz8/9UPa0CZkQ/7rfbM=;
        b=zB65Mf9B2/3TT7NZxQwkeoXra8qBGYgYVRudng74RYRLRBeZUA8nKptUMFApeIKXVd
         DMxN9RoKdrr1atuDUY5gwe79yTu5yjEW9PlTDVz9CpcTu1ezEgnUWdMbKU8MPQFi4kFU
         +M1gnf6wAJUOQhA4i0hLuH9OB7BxY3VyOnYnVI+wkDx5t80GEhsjwcy6Lg0xuP5lhO59
         I+nSuYIU4Zd1+L4s2xYq63DNCYnkF7UXrUSMybrGOFWdX3+W9TSUAjvyHMwbJ1qUMxmk
         FCtlAwltZnBM/MQEiSUnpVYu5oeYEmYg/qhzAGSyRjJkQs4kttiW1Z2eDgPDEGcTNJQ5
         ir/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089111; x=1741693911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AL6XZaDC/No54Uy7L4GaNa2roz8/9UPa0CZkQ/7rfbM=;
        b=ffV0kc7K0lSeNx7JLXecf5A9NS6yy3M0G2aJ2yIHAVlqodUsEJ6qobBhCFOlofGoaG
         gFYZYSOizcprlh4b/RnBCpwgoia0Fd9CERTn1AHMUq6nbNIXzlydCWpVFr7i4zDKI0Ln
         gmp0QM9jiaoFICmJa3gClx94m4QtyX7tTY2PWW7oSw1s8Iu5O0DbzObS2Te0hUsWveFm
         +ECoJeDvi24bW8Iq/12iXrUSIj4wGyoMCdWm1/s4oBSOa0xMc4e0UIHjuvSDEgwEkpoc
         J+A+7oA3OoFQkh+Wmk0Ma1SnD0uAGjhriC8UmSO3Knim8ObWRZGVLgro4vf+BWsq4LGY
         C6ag==
X-Forwarded-Encrypted: i=1; AJvYcCUPTzlEluOYqVcbyauX85mgZpTr8IpvdGMu1xkqSWqCz0pDJf+jXMLWlvdRw6l11LKipHhbv2I7MPQlpBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+txKo0rE5LDt6k1Zrl2alSHsW4K/TZxeKjtgCgYrvhOTpfhq
	nHQtmDafW7eqcMvy4UaX3uG1WIzRfbieJmmxUSmCT6CzlUdVi2dm7YBcgQ5ci6BQHUIyMXFNMg8
	6DRvAlp6eD2wpDg==
X-Google-Smtp-Source: AGHT+IEcl+aWiI9gcjsEH7JfVdofzIkvfGOPy+t3a2kQmtDWZILphyW/waOva2gmvbECfgZcZ+BxCm/pMy2ZPq4=
X-Received: from wmbfk7.prod.google.com ([2002:a05:600c:cc7:b0:43b:bfff:e091])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59a5:0:b0:390:f734:13b1 with SMTP id ffacd0b85a97d-390f7341455mr12051625f8f.23.1741089111497;
 Tue, 04 Mar 2025 03:51:51 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:57 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8695; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/C8f07Nhmn9r2N3ZtBFXfPSvF/v+MduRZhwmhE1w51U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulG0ds5DJF8JlTgZr/dILvw8f2A626kR9EDx
 jvhqzq6IwKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpRgAKCRAEWL7uWMY5
 RqEkD/4ti42FTv3nlJNYWD1fLr3wv5fy/4JQGBB9E0ylL3i+qRi8pSKEelsntkTxl/jZnfVDS+V
 fp+QpYHpY8oziZz/bpZHzAtPc178/Qgwn8qzvwIRIpCI+ZtgOVkhbXol1WYAZwEOg+rz0dc48Gg
 A4vKCEMHPK3+p0w9rTgxZ8YcqTHuWE1++VrOuVakRC8BJ+y1dsxFbr2UgXWJkQOtq1TMVvAdDgb
 0FneosWVTFR4XGPDOulBVFE1CaGx/+gkoFJhoDEeteybDTGZmb9NiGjB8tEs0WeOAVwoZiYIO9x
 4TnNI6PJk06+C+l+Lb18OQzWVoGjSU0tqZjRN4Y6o0nCwWSLKHNYscmNVWcPNmf6qP/LxwcDx/M
 HAzty486cYD80OlAiChyWBp2vI1ZD/w7nvNjUJUzntptuCMykGXvXlQ2gz8N9IFqTFERpEUoAY3
 htNB5rTU5NSR25zrarBU4qCD4bLNFuN96AzliQHzm85yjzipco6j+wSZYvSzhXgQ1mt2zgXTS4/
 +LG7FbPggom409fyyKf18F+ZSfhI1pVKw3u/Bc4ojT5UzV4inpw02Z/gmvZY7XbEhkAxLL1x1PN
 99OS/Dg6/NMypHm/faDQ7NhMDJ37oxM6Fe/tgcF2dPPFH29+uTRLMVZ4uJQhLT3VHHttIFgI1fW XKXrE3DMS5Gl9Mg==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-6-5c641b31980a@google.com>
Subject: [PATCH v15 6/9] mm: rust: add VmaNew for f_ops->mmap()
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This type will be used when setting up a new vma in an f_ops->mmap()
hook. Using a separate type from VmaRef allows us to have a separate set
of operations that you are only able to use during the mmap() hook. For
example, the VM_MIXEDMAP flag must not be changed after the initial
setup that happens during the f_ops->mmap() hook.

To avoid setting invalid flag values, the methods for clearing
VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
the return value results in a compilation error because the `Result`
type is marked #[must_use].

For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
we add a VM_PFNMAP method, we will need some way to prevent you from
setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 186 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 3e2eabcc21450497a02ffa1ed1f31f3e7e7e1b6b..31803674aecc57408df7960def17cfdc2cebcd6c 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -16,7 +16,7 @@
 
 use crate::{
     bindings,
-    error::{to_result, Result},
+    error::{code::EINVAL, to_result, Result},
     mm::MmWithUser,
     page::Page,
     types::Opaque,
@@ -198,6 +198,190 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
     }
 }
 
+/// A configuration object for setting up a VMA in an `f_ops->mmap()` hook.
+///
+/// The `f_ops->mmap()` hook is called when a new VMA is being created, and the hook is able to
+/// configure the VMA in various ways to fit the driver that owns it. Using `VmaNew` indicates that
+/// you are allowed to perform operations on the VMA that can only be performed before the VMA is
+/// fully initialized.
+///
+/// # Invariants
+///
+/// For the duration of 'a, the referenced vma must be undergoing initialization in an
+/// `f_ops->mmap()` hook.
+pub struct VmaNew {
+    vma: VmaRef,
+}
+
+// Make all `VmaRef` methods available on `VmaNew`.
+impl Deref for VmaNew {
+    type Target = VmaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmaRef {
+        &self.vma
+    }
+}
+
+impl VmaNew {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is undergoing initial vma setup for the duration of 'a.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *mut bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Internal method for updating the vma flags.
+    ///
+    /// # Safety
+    ///
+    /// This must not be used to set the flags to an invalid value.
+    #[inline]
+    unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
+        let mut flags = self.flags();
+        flags |= set;
+        flags &= !unset;
+
+        // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
+        // shared. Additionally, `VmaNew` is `!Sync`, so it cannot be used to write in parallel.
+        // The caller promises that this does not set the flags to an invalid value.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.__vm_flags = flags };
+    }
+
+    /// Set the `VM_MIXEDMAP` flag on this vma.
+    ///
+    /// This enables the vma to contain both `struct page` and pure PFN pages. Returns a reference
+    /// that can be used to call `vm_insert_page` on the vma.
+    #[inline]
+    pub fn set_mixedmap(&self) -> &VmaMixedMap {
+        // SAFETY: We don't yet provide a way to set VM_PFNMAP, so this cannot put the flags in an
+        // invalid state.
+        unsafe { self.update_flags(flags::MIXEDMAP, 0) };
+
+        // SAFETY: We just set `VM_MIXEDMAP` on the vma.
+        unsafe { VmaMixedMap::from_raw(self.vma.as_ptr()) }
+    }
+
+    /// Set the `VM_IO` flag on this vma.
+    ///
+    /// This is used for memory mapped IO and similar. The flag tells other parts of the kernel to
+    /// avoid looking at the pages. For memory mapped IO this is useful as accesses to the pages
+    /// could have side effects.
+    #[inline]
+    pub fn set_io(&self) {
+        // SAFETY: Setting the VM_IO flag is always okay.
+        unsafe { self.update_flags(flags::IO, 0) };
+    }
+
+    /// Set the `VM_DONTEXPAND` flag on this vma.
+    ///
+    /// This prevents the vma from being expanded with `mremap()`.
+    #[inline]
+    pub fn set_dontexpand(&self) {
+        // SAFETY: Setting the VM_DONTEXPAND flag is always okay.
+        unsafe { self.update_flags(flags::DONTEXPAND, 0) };
+    }
+
+    /// Set the `VM_DONTCOPY` flag on this vma.
+    ///
+    /// This prevents the vma from being copied on fork. This option is only permanent if `VM_IO`
+    /// is set.
+    #[inline]
+    pub fn set_dontcopy(&self) {
+        // SAFETY: Setting the VM_DONTCOPY flag is always okay.
+        unsafe { self.update_flags(flags::DONTCOPY, 0) };
+    }
+
+    /// Set the `VM_DONTDUMP` flag on this vma.
+    ///
+    /// This prevents the vma from being included in core dumps. This option is only permanent if
+    /// `VM_IO` is set.
+    #[inline]
+    pub fn set_dontdump(&self) {
+        // SAFETY: Setting the VM_DONTDUMP flag is always okay.
+        unsafe { self.update_flags(flags::DONTDUMP, 0) };
+    }
+
+    /// Returns whether `VM_READ` is set.
+    ///
+    /// This flag indicates whether userspace is mapping this vma as readable.
+    #[inline]
+    pub fn readable(&self) -> bool {
+        (self.flags() & flags::READ) != 0
+    }
+
+    /// Try to clear the `VM_MAYREAD` flag, failing if `VM_READ` is set.
+    ///
+    /// This flag indicates whether userspace is allowed to make this vma readable with
+    /// `mprotect()`.
+    ///
+    /// Note that this operation is irreversible. Once `VM_MAYREAD` has been cleared, it can never
+    /// be set again.
+    #[inline]
+    pub fn try_clear_mayread(&self) -> Result {
+        if self.readable() {
+            return Err(EINVAL);
+        }
+        // SAFETY: Clearing `VM_MAYREAD` is okay when `VM_READ` is not set.
+        unsafe { self.update_flags(0, flags::MAYREAD) };
+        Ok(())
+    }
+
+    /// Returns whether `VM_WRITE` is set.
+    ///
+    /// This flag indicates whether userspace is mapping this vma as writable.
+    #[inline]
+    pub fn writable(&self) -> bool {
+        (self.flags() & flags::WRITE) != 0
+    }
+
+    /// Try to clear the `VM_MAYWRITE` flag, failing if `VM_WRITE` is set.
+    ///
+    /// This flag indicates whether userspace is allowed to make this vma writable with
+    /// `mprotect()`.
+    ///
+    /// Note that this operation is irreversible. Once `VM_MAYWRITE` has been cleared, it can never
+    /// be set again.
+    #[inline]
+    pub fn try_clear_maywrite(&self) -> Result {
+        if self.writable() {
+            return Err(EINVAL);
+        }
+        // SAFETY: Clearing `VM_MAYWRITE` is okay when `VM_WRITE` is not set.
+        unsafe { self.update_flags(0, flags::MAYWRITE) };
+        Ok(())
+    }
+
+    /// Returns whether `VM_EXEC` is set.
+    ///
+    /// This flag indicates whether userspace is mapping this vma as executable.
+    #[inline]
+    pub fn executable(&self) -> bool {
+        (self.flags() & flags::EXEC) != 0
+    }
+
+    /// Try to clear the `VM_MAYEXEC` flag, failing if `VM_EXEC` is set.
+    ///
+    /// This flag indicates whether userspace is allowed to make this vma executable with
+    /// `mprotect()`.
+    ///
+    /// Note that this operation is irreversible. Once `VM_MAYEXEC` has been cleared, it can never
+    /// be set again.
+    #[inline]
+    pub fn try_clear_mayexec(&self) -> Result {
+        if self.executable() {
+            return Err(EINVAL);
+        }
+        // SAFETY: Clearing `VM_MAYEXEC` is okay when `VM_EXEC` is not set.
+        unsafe { self.update_flags(0, flags::MAYEXEC) };
+        Ok(())
+    }
+}
+
 /// The integer type used for vma flags.
 #[doc(inline)]
 pub use bindings::vm_flags_t;

-- 
2.48.1.711.g2feabab25a-goog


