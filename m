Return-Path: <linux-kernel+bounces-441159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2E9ECA77
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75F0188D5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17B232373;
	Wed, 11 Dec 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6NjFYKW"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0A2210E5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913463; cv=none; b=JL9JTqAqdqEsmq0K/xGyjxiwAzYeg+ZACDyh8DiJjktcp5viKO83qWmSzTMeyZ94a/lV4qztSxUdrnXm1BmRDoX3/uT7pf5QNCzndwiOKt+mxO3UArP8qDGKNMnRi0XKVlBJkc3hGhNEPQ6ZMEBkyIaaF6zrOfmsLWdmkG5m/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913463; c=relaxed/simple;
	bh=6t+xF+P5/IR/lCGOL4lVeujRJ3nIoK+5J94bGPLjczU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oCG2URTjmyeCqS+sn99QwyCrQAcdkxKbBRk36oUEu9xEHYjpmnG+ho6cOteDF7Wqo9i3gKdfkWqHtAImu/FxFeQ1IiOq1B2wgbMax7m2a3FV9L5evDwRq7DOBMcJw1Y7GucXal7tTmz4n3YMKFIqnf4vHGsigYLeG2eSEpvNCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6NjFYKW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434e8beeed9so37307495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913459; x=1734518259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdRoZ/FXvJ1iNt28gv3dQ+sMcWS78rYWNAmYz+QTguo=;
        b=S6NjFYKWwSym4fUf+k0z26/gmycD63KMqkywRbEZOFAgLmYK1wnVxQfUNXW8SS2Wdy
         /DWCD5CMyg0pAlK1gXr2pKA/f1sO44Rbw8FR4MqY+E2OoBxNKsCuCM0exK83quEHB7AB
         cszXZ+gKTyp56KkVVw2XZ+azKG9m2cmJqwXEE3WYI4+kQcbSo/H5GpoBqaO3jR63ZTlA
         AX8h4pX+AbygbIDCZmyreVvzkJF4wRJSWsVqAFqf1llm6zdIkM2nbdDHH7+cuyb0VCtq
         6af3/eoRCztg8cKhffH9kNEE5XMGO20aB3qd1HpZHsuHCCpFIqKqsASTTmF8dIH/Plnj
         eDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913459; x=1734518259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdRoZ/FXvJ1iNt28gv3dQ+sMcWS78rYWNAmYz+QTguo=;
        b=jlhSZWxoIxZIpBdNMZxyfoDMf891E8lkxUjMod+v/QeuCye7cA7hg++hL130FPUGyA
         8uU/zj7Zy1ImeAU2j3TFFl0NvOPkceM+zUr3qGhRlOEoF+8Z0JZr1bwngHcHL7GDSkHL
         L+njbbKvytrYM/3uL8njXWRkkQmRaprxTqz1JgLfQcdpVXGSpVMJ+VcenX6q/vaBNNJR
         RutW/J473rKuXzvEslRK2S7cqURgePt4O76bS3RQJB0nVDVlWuLKT0oGP27Hvv+XFHE3
         /ds/K7On9r5L5V/NSGidh0lmSPFx2Pn4yePHIQb5ToFZtEQ1lIqVSB/iZe8euQZwK9D3
         JI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg4LmOpbRe2RrgdxipyJ+JU/OkYbo3c+v0Ix+yjlt8ytd6/hRMD5c/g26JyTqWt7R/6FVTh4zQRZ63VVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7/OciLcooWXveliESDPlcWzfxJaaG6tZy6v1vabeKrCPyC+F
	NI1t4aimrCa6Q0JeAyEGlg54Tw5y/vMXBxOlxEvtHWkeP916iw4m1/9lwZuZfCBMuJspbgOpl9E
	zvcnnZDPwSksYTw==
X-Google-Smtp-Source: AGHT+IFiaOcL2ApjopemuAF+csic5VYHrPo4suLSy1p/57Ja4FGM8Qf+KoTAcXifpYCYix4DnL3IX5KOAs2s7jk=
X-Received: from wmoy22.prod.google.com ([2002:a05:600c:17d6:b0:436:1995:1888])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f11:b0:435:23c:e23e with SMTP id 5b1f17b1804b1-4361c3ab01fmr16964065e9.12.1733913459182;
 Wed, 11 Dec 2024 02:37:39 -0800 (PST)
Date: Wed, 11 Dec 2024 10:37:07 +0000
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3734; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6t+xF+P5/IR/lCGOL4lVeujRJ3nIoK+5J94bGPLjczU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWWtn4X75kf6LePY+XZjlPFNolUZoJJ13E+kKv
 AdV5RmQ4cmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1lrZwAKCRAEWL7uWMY5
 RsYAEAClhhBwJB76Jj2L7B1ET41hYpXogDIazTH+rKg3i7QZObgXoaE2MPemKRlrV4yMInqgRij
 eWQIwr4ncHv/JV7zPTLkVOZ3LcVB0UPpgYcTPZ9/18yIS3+Db7En1gZRHrU9YmfFe4Incwr2JQK
 DB4vDQ2gtEQzfpx2s6Z77STq/wcZLrfnk6guaSaocfPSmf79vOKr18vnHn05DDVEtV6kV65amQT
 fEDULMlPeyXghGqiA1Xhv7wIq/jdIoFWmXTMgn46Zr5XpBKTwJAyh8GgaS0NrVLXXarNrOgpqjo
 ygUHM9Opb8NqrgNOae6CNtoBy3bVIE1Ftn8SGnhULvbvGQ2+C2utiYsAkWlaDVLLCmE0v4bow13
 BUR5B8FS3dRzJ3d+n5fQkBdXnMw8Y2ovTwu+71t4Vz7hWt1OdmZ+IQCRoqx/DoPrJHRpR2hwmyW
 R/ZHCvJEbjPPbt+8KnCYToVtc0DTAJGW3I5t3TE+BMC/qBFk0kJ80vj9lwBRD8zh5j3KMToFUqm
 IBiRpwF1dIyfMCAaWSr6GoixEibdzj31iE3iTylBVC8DbZIl0BzB+K/rxomImUe7AIrEDRAd5R6
 1RsaczeisEh5okvkLlrWcVFYbfxpa1IJJuHTKwlA1sHNehU3jTTg+NuvSPAnkHJe4ZL5Zy+MAuk tt79oV/6PfAzmtw==
X-Mailer: b4 0.13.0
Message-ID: <20241211-vma-v11-3-466640428fc3@google.com>
Subject: [PATCH v11 3/8] mm: rust: add vm_insert_page
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
 rust/kernel/mm/virt.rs | 71 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 68c763169cf0..3a23854e14f4 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -4,7 +4,15 @@
 
 //! Virtual memory.
 
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
@@ -100,6 +108,67 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
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
2.47.1.613.gc27f4b7a9f-goog


