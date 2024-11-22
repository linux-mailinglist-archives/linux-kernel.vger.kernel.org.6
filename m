Return-Path: <linux-kernel+bounces-418425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F649D6175
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E343EB23B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844C1DE89A;
	Fri, 22 Nov 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32NE2WEQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE81DF738
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290072; cv=none; b=dTi4GlrpgOwU/JKPsORus7Tapiv9Q8zNk12Yft6Glol12TApjYLogs6xl1pg28kzAq7SgMj8LPrufgU6hhNn7F5UqTCKjCeIWJlE2M47q8QdCvk4DdKV6Wk7SwT26Z1i4mPxEbZ2qWS2xhgdSeyRIuJ+Yb3MONiwQaoH7MbrW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290072; c=relaxed/simple;
	bh=0kJbDQ2R2LaDZDdpCyVYpygYX3kC3nlpmnRFMMkub60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nTpV6wsLKRzRg95s/fn3X9+r2F0Il5gll6pj1ypx/c+Vq2N2nbMqkpOf7tnVOMyVYuro8HzSxxYpIpEHQLgm03EhbytnJ4zUcrL0vVCyGf0KpZ/HwOddsEtFroTVM6FahHcI9xym9p35AV4Ydb21u5X9AoduBe7v6/zPiNpIL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32NE2WEQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso19724135e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290069; x=1732894869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYxLUop5CFzWW+VlEDd2o5nmfczomOBA2awiJyr0ME8=;
        b=32NE2WEQsDYftq4CMwJz4noYsOjr48OLjIcOntOBfIiYdqYXFhh4e92uvIubSprztX
         hIA4FsNe61g8NmT0SpXSrFVqBmbOlfIls4YmXu0zlAMEL0Jiry5dmuwVq8cPtBlZi+X7
         p2ZRWDIAEkKWTw2H6UTd3F0lA/jXoDpmnuWCpo36PEoaq29RfICX9Em4qDmmgnZQNUAf
         c4mCYCR/ok5fuw3vjNzTjPvkljeQKzgqQM1EnM8th8AxjwPnKLzAqSzL4zNkRpz+sNy6
         XA7bly+vEkp4svxKoR1a8tVmmEIyR9Na+kiW8IWlV5y4vU0wCWVYchDhQ+mmxxkpXiXY
         25ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290069; x=1732894869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYxLUop5CFzWW+VlEDd2o5nmfczomOBA2awiJyr0ME8=;
        b=G3L/WiQK1ZoGsio7JJ3rpesvaoAsyx8Q3xyf/4lY9olQ3IATGrqeHCbJZ3+4oYhk9S
         0JpBk4ImwAYczOZTMXseglxewpZlTxrFIVG7w0oZTSCteWZ7BAX0DDNa9TLaI6WDFSiM
         Bg1mRjFUHtcxpbSlLeopjgfvMGHznuolZa5Zh9xwBT9vCRGo6K1qmQQ/l34o/h/PNYuD
         f1oZ/xP/1Wzx53W2lCQgRjKtY8o+O1pq/WKvVuomeVp947fZHm7LHb7JBYvwYuVfWS4D
         vELBttRSMpFRe3AFO6TnuRXQ/rWsN/CCjVzcYd9lOMQ6MMCI18ijJc66ritjmC4kVncX
         JkKw==
X-Forwarded-Encrypted: i=1; AJvYcCUkkqYVemqde350Y7C/l4rTChadNSq7p9eDdkTUkBtTipaDqucjtF+FCQJ+VvTe/uZhVXYykCQLhfTRYX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzB3EAZ++vZ9G2zOOIUzjpf8whAc1zYb83VndM9RbNorN6BHUf
	kkSylBGNZfUgG6yxyvgOjkSFY1XcxLZ+jgdx33rM2Lq/XgNZvyo6n+BdH6dTMgHwka5kJJtv0BM
	vVpsI1yLdsEcIdQ==
X-Google-Smtp-Source: AGHT+IEIKcYcdx6MVWct3b+zC6qUnAKNrcyvu2pxBZsUhCYdS8JAEE1PK1hh3wfuatjl0mJTsbCFOi6Ydty6B7I=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:35c4:b0:42e:d463:3ea7 with SMTP
 id 5b1f17b1804b1-433ce4b2e61mr290325e9.3.1732290069096; Fri, 22 Nov 2024
 07:41:09 -0800 (PST)
Date: Fri, 22 Nov 2024 15:40:28 +0000
In-Reply-To: <20241122-vma-v9-0-7127bfcdd54e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3694; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=0kJbDQ2R2LaDZDdpCyVYpygYX3kC3nlpmnRFMMkub60=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnQKYIvyS3vYvaLl2hnXmTUoNnpgWbUaM0XAaBO
 5Hd920hx1WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0CmCAAKCRAEWL7uWMY5
 RpyREACin3dfUAa6PzIT6e2p6DXDZa92oR0hkUItIreeOaz+aDB7QYUz1TQHXS+0/ggVZfuQ5qM
 PW6oK14yS9QIiu6J0zqJlQ+h9CcPk6ycDjrkQKKQQNlnLaoA1KUSopOA0/dXkvOqDZx7eh0rczd
 yRoj+CT4F/YkIYDETENVy6KMVZIMklx4enehQes6M1v/AftWAvbN7ZluoxYjzTtcsgsw2dpLQyx
 7qtm2TIoTqNlAKvdXoxetMePlgiR9OmK4DFj9zSoknu222UrRAZLZrEQ8Us3nMTCd6rFI9dsVrh
 SCqn+C7ZJgAOZP0UDU7gBbCXtL0TdYszA+ja48fRu7t9eb8GZZZmuDMM6i2jHKgKcw5HKVmPW2U
 H4YawniEx4YivnbG2E58oYT2t6bhlDrlBu4OZ2PFnSo0O0TvsiX8919xV8I3dfRkiGz7bpC4icL
 Eeyu4sxt/8cUq/Bdr52weSKg05oKqakBtcrCfbQ0SFx0QyO/X+ZPpuoUjw5l6SIRSglewAePJui
 rlIdtOTOVSpaMVVvRJiCG1X7KKQLnOa9o/znQ2gVJjMOYupgju8s87HWBq/AKVyzZPO+9LI9JxH
 b7afReIFODoqSqosl36aTz7325JcyO+7kKY7zNDD5KnoFhgQa/Hj/u1nSsxHHiPTc/MT1lNXiLA Zar/2JKK9H6pk4Q==
X-Mailer: b4 0.13.0
Message-ID: <20241122-vma-v9-3-7127bfcdd54e@google.com>
Subject: [PATCH v9 3/8] mm: rust: add vm_insert_page
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
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="utf-8"

The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
flag, so we introduce a new type to keep track of such vmas.

The approach used in this patch assumes that we will not need to encode
many flag combinations in the type. I don't think we need to encode more
than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
becomes necessary, using generic parameters in a single type would scale
better as the number of flags increases.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 6df145fea128..3e494e40b530 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -4,7 +4,14 @@
 
 //! Virtual memory.
 
-use crate::{bindings, types::Opaque};
+use crate::{
+    bindings,
+    error::{to_result, Result},
+    page::Page,
+    types::Opaque,
+};
+
+use core::ops::Deref;
 
 /// A wrapper for the kernel's `struct vm_area_struct` with read access.
 ///
@@ -85,6 +92,67 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
             )
         };
     }
+
+    /// Check whether the `VM_MIXEDMAP` flag is set.
+    ///
+    /// This can be used to access methods that require `VM_MIXEDMAP` to be set.
+    #[inline]
+    pub fn as_mixedmap_vma(&self) -> Option<&VmAreaMixedMap> {
+        if self.flags() & flags::MIXEDMAP != 0 {
+            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
+            // satisfied by the type invariants of `VmAreaRef`.
+            Some(unsafe { VmAreaMixedMap::from_raw(self.as_ptr()) })
+        } else {
+            None
+        }
+    }
+}
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access and `VM_MIXEDMAP` set.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
+/// set.
+#[repr(transparent)]
+pub struct VmAreaMixedMap {
+    vma: VmAreaRef,
+}
+
+// Make all `VmAreaRef` methods available on `VmAreaMixedMap`.
+impl Deref for VmAreaMixedMap {
+    type Target = VmAreaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmAreaRef {
+        &self.vma
+    }
+}
+
+impl VmAreaMixedMap {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
+    /// (or stronger) is held for at least the duration of 'a. The `VM_MIXEDMAP` flag must be set.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
+    ///
+    /// This operation does not take ownership of the page.
+    #[inline]
+    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
+        // SAFETY: The caller has read access and has verified that `VM_MIXEDMAP` is set. The page
+        // is order 0. The address is checked on the C side so it can take any value.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
+    }
 }
 
 /// The integer type used for vma flags.

-- 
2.47.0.371.ga323438b13-goog


