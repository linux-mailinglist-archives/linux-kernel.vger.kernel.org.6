Return-Path: <linux-kernel+bounces-415964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF539D3E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01288284E25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75101DE883;
	Wed, 20 Nov 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXHgzK+1"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052011DE882
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114593; cv=none; b=TtX7WlL8LgmV5Ei2xmlWIClrnFojTYgeiCrFTpV8wpncZGDxyOdcxXGExAijHpQsGgbetHW5OejQNJ4myENsJg/nuseLBpR7k9xCq+5eVuFzDy7jfmWct4hCJ3frhsbEIq36GUIlUA8PPjJUR7WHWYHZ4VrAWSWJCL+rYkX/shE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114593; c=relaxed/simple;
	bh=GxeBG0VLgiYY7aoOP2RaPrBmc8r79aoXtEJ4vi7OY7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BosgE8zUFNpsdqmg0nvxt+uTnpUJY2kj23vES8Q2x4oR4tGRIExbv6qJUiG2PDpEYRSG3TdTKZmCe8nIjug8c57kESnNHEN4/+2MNN5wIpWIyQwaXlH6XYBUccvc8cNkYSvvifT9ApnOmuunptPDVyPwC8MKkMOpiPrHJ/VXK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXHgzK+1; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-382440c1f83so511539f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732114590; x=1732719390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwChOJ9zAIfe8IedX9D+YlgaCTQORbfAqxOhT4faXfc=;
        b=jXHgzK+1Ojn0bGoExBGeXSSh/lw5SP1NuDHWyD2dEB2BkkTT1UBEbybBuMgD8TFOMl
         pfky7K1nTYuj3nJjsDS4wwLBZ1Ty7xsY2+Q8jgmYbzyEw9K0D5gNapOScW04Ss+6y3ks
         Do8W90Sc7jtXFuR/dJn8Lx2eehQ9pe+lZhRgELpdXlBWTkci8bz5sTl66QRHbuH6BpCU
         dO1whBJdULMmULw5xqMDzwBr5doe9sAX+qFTBTN9t0f6TBsOTrF6vr3otIzzCt2+KbK9
         zLEIdmQb2h5aejyRLsdXSvjR8mQeoItw1LKKdBWDpp25EFDtWbPcdQJhOQdugJgS49WA
         Ikgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114590; x=1732719390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwChOJ9zAIfe8IedX9D+YlgaCTQORbfAqxOhT4faXfc=;
        b=qNyEVzt3UFLnaHmAcH+t93ZqolQVURoiQFSDJqiykmvptYtooqUXldgvFHs1c7oPjk
         kI3XK/45A8evihxTGZ4byyoaF2mMD6BGJqxFYfbSZJcBee6QuNPNsp1cwubHbsShjIPt
         20nroZRRWeAcqMK0T11wxZuARBh4cDM0QWWUtfwK4RQ1cjlfyXKuMRdIGLzsKrqaGGM0
         OoArz5u/+g9HtURL31xy1QLJvcS4e3g8k4yBlZl3hFT0com5X4O0vj+RqQtEM62a2bZd
         YOdWyADgIitwuI/9sT8IObyZZHkXpd3nfsJly57aGy1jdH0WaJhu8SnTlzw3u9rRL1E+
         dTYA==
X-Forwarded-Encrypted: i=1; AJvYcCUkdA/hdjegy+XG/GGfdlHLW8nHqr4L43CoEAZE9/vbF1egwQ0OaO/WfcKfvAneTP4T/tophV3MzKGa+N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQbrSaWcDtr8EBJYWOGOQyX1qupFCKKrsO0S49VquHwqPhrZX
	SheZTox4F8v9LXV5GJ7+gsXXHScnjAoNAcmP3WO66qz3uGQ43fmcUU+QipxjUnuZLeEtBzcE7OH
	vqURJhrAtkIToBg==
X-Google-Smtp-Source: AGHT+IHXbdV8HAQ4+Suef2mPnmtDgGLMdzhu1f1M8BZUgtuk+G0K3LivSZuvpPIt1xjcvlwyptBDB6mRFKUQlaU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a5d:444b:0:b0:382:3b1a:1870 with SMTP id
 ffacd0b85a97d-382544b5d4bmr1125f8f.2.1732114590361; Wed, 20 Nov 2024 06:56:30
 -0800 (PST)
Date: Wed, 20 Nov 2024 14:50:00 +0000
In-Reply-To: <20241120-vma-v8-0-eb31425da66b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7325; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GxeBG0VLgiYY7aoOP2RaPrBmc8r79aoXtEJ4vi7OY7A=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnPfiLpdbSAArUzD356S1Rdhs5xf34Ng/4olKS2
 zZLQlqEVN6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZz34iwAKCRAEWL7uWMY5
 RihJEACjPpazX+vyEm1GGkDxAIjC2Z0e2x4wQhJDGkGfba15BJ7OdktI8JOyxO4017dJv7XCJE2
 OK+70me6wb/vPIGBpARjasmBRsFqaWj33HTt1PEH+AHdNRkVxswHxI5VMyAqQptj05zDgBFlLA+
 pELHaN5ryoaVBTyMbpNCl5l3L3mMgagvMJupYAsGhl/NuPbLAzrAcTJpklnovug1YMbz2qXblbO
 kZQq818LxO5ybuOlDxESimOZvwO/0X8dqnBHHB6RSgzsbH2WBwpTUjasTqFEFJAAdcjYwYGRPyy
 yDGqkIDT4zK+A1mvjaTbYEexaoFbkmVufawcJ+sJlPsyfJOJmaW1zqteMwMUHZTpgHqWaDoU2El
 6/Cnz20ExMDZSdITnhC4No7JB2fyu6VSmp2Aor9F7uLIdVIU2DeBjq8dkTovFnTS+TGtrMlSMj/
 Ci9+qIFkfEOc1w8OBPZFbg1CVnuL3zWzP5c3Z7E845AFM557AtWKQqKNFglOOn1CXmskiZEPWsM
 y2lk0A+cmA/1wgD04mcczeJqeAL733Oyea4JeEwhAlod49osPNU5t2OxdO/MUB+wWy7BDcEKpyj
 /CZlEDcP/JoXoioDlwssN3+EJNhN88t5exP5y3//5S1kP4i1ip5KuZWp9yhkc9cLDxjERVAQHCB eDHl3Ean9iBRSrQ==
X-Mailer: b4 0.13.0
Message-ID: <20241120-vma-v8-6-eb31425da66b@google.com>
Subject: [PATCH v8 6/7] mm: rust: add VmAreaNew
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="utf-8"

When setting up a new vma in an mmap call, you have a bunch of extra
permissions that you normally don't have. This introduces a new
VmAreaNew type that is used for this case.

To avoid setting invalid flag values, the methods for clearing
VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
the return value results in a compilation error because the `Result`
type is marked #[must_use].

For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
we add a VM_PFNMAP method, we will need some way to prevent you from
setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 169 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index de7f2338810a..22aff8e77854 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     bindings,
-    error::{to_result, Result},
+    error::{code::EINVAL, to_result, Result},
     page::Page,
     types::Opaque,
 };
@@ -148,6 +148,173 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
     }
 }
 
+/// A builder for setting up a vma in an `mmap` call.
+///
+/// # Invariants
+///
+/// For the duration of 'a, the referenced vma must be undergoing initialization.
+pub struct VmAreaNew {
+    vma: VmAreaRef,
+}
+
+// Make all `VmAreaRef` methods available on `VmAreaNew`.
+impl Deref for VmAreaNew {
+    type Target = VmAreaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmAreaRef {
+        &self.vma
+    }
+}
+
+impl VmAreaNew {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is undergoing initial vma setup for the duration of 'a.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
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
+        // shared. Additionally, `VmAreaNew` is `!Sync`, so it cannot be used to write in parallel.
+        // The caller promises that this does not set the flags to an invalid value.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags };
+    }
+
+    /// Set the `VM_MIXEDMAP` flag on this vma.
+    ///
+    /// This enables the vma to contain both `struct page` and pure PFN pages. Returns a reference
+    /// that can be used to call `vm_insert_page` on the vma.
+    #[inline]
+    pub fn set_mixedmap(&self) -> &VmAreaMixedMap {
+        // SAFETY: We don't yet provide a way to set VM_PFNMAP, so this cannot put the flags in an
+        // invalid state.
+        unsafe { self.update_flags(flags::MIXEDMAP, 0) };
+
+        // SAFETY: We just set `VM_MIXEDMAP` on the vma.
+        unsafe { VmAreaMixedMap::from_raw(self.vma.as_ptr()) }
+    }
+
+    /// Set the `VM_IO` flag on this vma.
+    ///
+    /// This marks the vma as being a memory-mapped I/O region.
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
+    pub fn get_read(&self) -> bool {
+        (self.flags() & flags::READ) != 0
+    }
+
+    /// Try to clear the `VM_MAYREAD` flag, failing if `VM_READ` is set.
+    ///
+    /// This flag indicates whether userspace is allowed to make this vma readable with
+    /// `mprotect()`.
+    #[inline]
+    pub fn try_clear_mayread(&self) -> Result {
+        if self.get_read() {
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
+    pub fn get_write(&self) -> bool {
+        (self.flags() & flags::WRITE) != 0
+    }
+
+    /// Try to clear the `VM_MAYWRITE` flag, failing if `VM_WRITE` is set.
+    ///
+    /// This flag indicates whether userspace is allowed to make this vma writable with
+    /// `mprotect()`.
+    #[inline]
+    pub fn try_clear_maywrite(&self) -> Result {
+        if self.get_write() {
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
+    pub fn get_exec(&self) -> bool {
+        (self.flags() & flags::EXEC) != 0
+    }
+
+    /// Try to clear the `VM_MAYEXEC` flag, failing if `VM_EXEC` is set.
+    ///
+    /// This flag indicates whether userspace is allowed to make this vma executable with
+    /// `mprotect()`.
+    #[inline]
+    pub fn try_clear_mayexec(&self) -> Result {
+        if self.get_exec() {
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
2.47.0.371.ga323438b13-goog


