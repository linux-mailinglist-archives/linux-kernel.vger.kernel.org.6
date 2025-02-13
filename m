Return-Path: <linux-kernel+bounces-512751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6EA33D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1930A1883B70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C65214A80;
	Thu, 13 Feb 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lj0YoAi"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6A214200
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444687; cv=none; b=Yxyutim5GETNDltcEhfE4YeefrK34ndzu9oQPG7EE2xQ/wCksUG/dzjMDLMWlmER+wAGa5H6Fm5t/kq0FXACzvdtjlpFBZWdrxiNChNt30/EbUMD+4FdXaaRzUcSdG02eOeA+1TaDjZI5Z34ewQ6bbTB3/+MHkGh5jElSXNqVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444687; c=relaxed/simple;
	bh=7ZqqtUDXsP1Gbf5JFgD6mksdBLRaKifIQkb0l8YZdwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZlH5UypxM00S4/HH9le8awngn4vBYU27SYa/6jkPUy8PVmCNVwBLpCFlOgk/w24NZaQ7EI4JE/4xZlhfFZDoQfr1RXDJZAIn6Ykizq+eF1Fvaw7tZoJqEw+k3da81hHi5B7i+OR8WuNUXnL2eY28Tvk3YUx0I2Nw+rDnP53egm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lj0YoAi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so4018335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444684; x=1740049484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8n2CzMf4Ztdvpb33CNEbhu5gkerbPNLl9WXyFXHMr8=;
        b=3lj0YoAiEJ+rvFY7cJz6x79dNMDH0iIuMS6LRUmzPkO40jq/EA6czkj+GW7/NRKNjT
         YXGhFx13EKin/m1h/djMk+e1d60/o8XuHCE+9262jd94wqGugkN3KLG4LAqF3US8ILev
         vzzr8lZHuGkgJh3w5s6OYPkrKFkRtJxlzHu2iAYXMe5FHVXGfgXqOSs3HR+AlATYtR0M
         0Gdl6+N7opkGovHWZ7KGYZjhawapQ4VZEAWHLLaoN6oP+0ouOjIocNEycLXC37CEg1jz
         XRZS+c5vKzNk2xqIxf8qwY3IS+zkNmeyVxvkOCxToWoKQroCnPqQL6ZiRZvKXnQhWcZv
         dtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444684; x=1740049484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8n2CzMf4Ztdvpb33CNEbhu5gkerbPNLl9WXyFXHMr8=;
        b=YCHE876oqkl6CModF+kBqD3XcDSBAHw4Ef8o8NSKpt9hK+TT2UUgx3yryqSOA70dzC
         3lARpzaSegtSn7frar3kNMGQMaSzdON48fm/WcOimlpJGoAkgHNGsLGsuSAc8pWUd3/P
         gDs2/zh76acGXb5jxg8w6aZxEA7lf0cJi1TeNBrD/HYGpQq7ercn3v6wIvYi0Fvj9ztx
         8BUpEuUKRvXJ90SIgl+HShzJ1FbpP8WygD0F25SEH90m1iVWlWBQ9jeA1y5+vY1ObrFt
         f3gjcrUC/2wJBs9FyXnFJR/wRgKIuiCV+jTu3cMGqL+OJqls34dUAIcRB6dfj0i20X9x
         fYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBTi62Gi1qLA9mOyt5kPil9d2bMB0Js2UmjFDyELaXTawKLTGJkoxY3F79n9TGhT7JHfZRn3QzNE69VRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybhoSAKexo1dSMddRXvdjSUlsQfOQJaLzxkFVmxYIOMMs5rwlx
	oN9mVGtCYcsvvW9xpl0c4NHYezwafVPJFwm/5Gbfa7/7cSu6DZ5T0Rc4EvHq+Dr3gtedKt7lH7y
	z1mAW+wxvk9WPjg==
X-Google-Smtp-Source: AGHT+IG/p1umuQ0eJvKQbofKR2QTqEeXJEbd0YG5yn6XEcTENIpdxL45h7o3jCh3ZD60eJkyCoDKaBabKC0ULTw=
X-Received: from wmbbh11.prod.google.com ([2002:a05:600c:3d0b:b0:439:45fc:d36d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5246:b0:439:643a:c8c4 with SMTP id 5b1f17b1804b1-439643ad059mr10276655e9.22.1739444683950;
 Thu, 13 Feb 2025 03:04:43 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:02 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7ZqqtUDXsP1Gbf5JFgD6mksdBLRaKifIQkb0l8YZdwQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdG/lIDQqsozko862Oxdr+bH9Os+BAM98CkzW
 TQa1IBfCNyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RvwAKCRAEWL7uWMY5
 RkmVEACn0Bt1SGwPL8suuc+/47buudaTvg3C0yzMa/mLK3qz1QtjJ/vbqRpsG+2npghIgyqGybL
 /aoGakDA+MpjDEuSZ48Sj8+IfzZKx2S5QjUFbKImceVUBQ74kG0KaRiwRZ5QDm1AwbnVy+YOTzj
 s2UHHoDn/+zj5ohSQj084UIiOIW8diiANWVf1SFI3MHTSK92oXMVUUIINrDxr2MHo1QYUaP6upr
 aXnJ36ntw7Rr04VgFHD54PDsGPqLHO5Re9WOxKQ9dYfibQt6IfQPKOc1qapGkRz33ZzFGnZRmYo
 igPauwx2md2jJ7jtq4eGsnNcbd4aq5GjD8Yc/mIO63CmITjOlPHq3UdvFDeDRHtC+r+yqFJXN2r
 gq1yAD+iXjILo4u1V25wO8369fHEMYGWa736PP63qiVSnHYTfY5bPhuuR6hGdEvBAXBjRkvOrvI
 uK1Papa5R28mD6UPHrUa/KSpUmu8jQQCnqs8hkSXpgpR+sZuLCvQDOq2PZ/KYcf16GPokj1XBrb
 kdu4UYkD3b+aorFabaCod8DPGo31Koml+GsGR53OQCg6WiKYIZJFbw1IFzh+M3p8HDPei63VpvW
 cMFE2AmzaRijV5Lv1oxBWfyrJOfMOjBLg7JHzgDODBxphjEiCAXDvR97INrlToJlCDR4oRIt5Ao HuTGjipQymChgVA==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-3-b29c47ab21f5@google.com>
Subject: [PATCH v14 3/8] mm: rust: add vm_insert_page
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
flag, so we introduce a new type to keep track of such vmas.

The approach used in this patch assumes that we will not need to encode
many flag combinations in the type. I don't think we need to encode more
than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
becomes necessary, using generic parameters in a single type would scale
better as the number of flags increases.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/mm/virt.rs | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index a66be649f0b8..3e2eabcc2145 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -14,7 +14,15 @@
 //! ensures that you can't, for example, accidentally call a function that requires holding the
 //! write lock when you only hold the read lock.
 
-use crate::{bindings, mm::MmWithUser, types::Opaque};
+use crate::{
+    bindings,
+    error::{to_result, Result},
+    mm::MmWithUser,
+    page::Page,
+    types::Opaque,
+};
+
+use core::ops::Deref;
 
 /// A wrapper for the kernel's `struct vm_area_struct` with read access.
 ///
@@ -119,6 +127,75 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
             bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
         };
     }
+
+    /// If the [`VM_MIXEDMAP`] flag is set, returns a [`VmaMixedMap`] to this VMA, otherwise
+    /// returns `None`.
+    ///
+    /// This can be used to access methods that require [`VM_MIXEDMAP`] to be set.
+    ///
+    /// [`VM_MIXEDMAP`]: flags::MIXEDMAP
+    #[inline]
+    pub fn as_mixedmap_vma(&self) -> Option<&VmaMixedMap> {
+        if self.flags() & flags::MIXEDMAP != 0 {
+            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
+            // satisfied by the type invariants of `VmaRef`.
+            Some(unsafe { VmaMixedMap::from_raw(self.as_ptr()) })
+        } else {
+            None
+        }
+    }
+}
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access and [`VM_MIXEDMAP`] set.
+///
+/// It represents an area of virtual memory.
+///
+/// This struct is identical to [`VmaRef`] except that it must only be used when the
+/// [`VM_MIXEDMAP`] flag is set on the vma.
+///
+/// # Invariants
+///
+/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
+/// set.
+///
+/// [`VM_MIXEDMAP`]: flags::MIXEDMAP
+#[repr(transparent)]
+pub struct VmaMixedMap {
+    vma: VmaRef,
+}
+
+// Make all `VmaRef` methods available on `VmaMixedMap`.
+impl Deref for VmaMixedMap {
+    type Target = VmaRef;
+
+    #[inline]
+    fn deref(&self) -> &VmaRef {
+        &self.vma
+    }
+}
+
+impl VmaMixedMap {
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
+        // SAFETY: By the type invariant of `Self` caller has read access and has verified that
+        // `VM_MIXEDMAP` is set. By invariant on `Page` the page has order 0.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })
+    }
 }
 
 /// The integer type used for vma flags.

-- 
2.48.1.502.g6dc24dfdaf-goog


