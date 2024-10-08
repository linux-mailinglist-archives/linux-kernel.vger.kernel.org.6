Return-Path: <linux-kernel+bounces-354466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA387993DD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF9D1C22AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265913959D;
	Tue,  8 Oct 2024 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HBWekZk5"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F677DA7F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360591; cv=none; b=a3Fo6cflbfmi+ym8I2ZP8FPtsf7ASoDwgxQfh7TC6Tyj8ur8ql0w8XYFMJPwXDMFa81UFYX6p0ayyM1Uk7CsDIaX7lukyaXduMSAYTLxk0+7Z7PT8Jk4ed5kDgQ5xR+kytrX/cfzGFSnfRlOgRWC04TzuFS/HOtQ4Qs3QEPtgfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360591; c=relaxed/simple;
	bh=DHhuzZhjAm4ZEudb3tSCaMtj0QN9/k+X9pxMVtWsGEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5vGM6JuUcz+OtTQCcMlPSyzyjqMBiSD82EY041xPSGbBKzwg+tmla6gL5yEWrEQywQ4UtRPZBk1J/Gnzk6ZTHM9yB0lS4HUKB/IFGkQIYmIMBWDQOETZawOYsASn4yUJIN+gBMSP5mvboruoggtGnJ8EWwyQKdOCxwo/9IyBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HBWekZk5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71df49bbc2fso421078b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 21:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728360589; x=1728965389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90wkvuAWekoK3fpE0nIhFuDYwdiSixPtxvMNgDon0sc=;
        b=HBWekZk5q5eRQiKNRMCKkVXjhlYP+8oqs+Yx1f6aNS7Pn6HA7zWSM0bvT6tR/Hf/LS
         C0Pown5vi1zeSwzUKYyl5jgQoosoy84b5kBtbsXSrhiY25QtdzBlbCGObD8douee5/CG
         wxzEWNyf4kIMcdkHE0Wav0cu2L/hRnY+E06gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360589; x=1728965389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90wkvuAWekoK3fpE0nIhFuDYwdiSixPtxvMNgDon0sc=;
        b=P7DsBHZgyj7VR8cIJpF8X3Z/gK3TLaYsI70+yD/HJmBxHnSfN224WgfkGB5FpbWwU8
         /kKm5x4o2JTwE+tNHcOkaQj/yABIcEqhQfmMCzIS7IchxQoE8JcZUUIQm9lpjo1y8P3O
         PbWijRAP0b/kGWp/W8R1Nuw4uPHEs9HpdGIVuCss5Kk8HTcTm0VfZdQxWV/RFO9YbZs9
         ecxd5rBNYq4h7oNqJTkTIyKPR6hHmjjXp2QtbEinkGPkgcY78QlInhcMlwyZ9h5PeWrn
         lcOVxu1dQ738VeeMVuY8bjFbT1W90YJ3w0daGnQX7oVECoj/141q26E27pSOJr5xuYxO
         OUOw==
X-Forwarded-Encrypted: i=1; AJvYcCUdU0lRMDvnGgLnP72mhIcDbvvoHbXMuSK3v/Ty8vJ8Pw3iI+7uHMUeX745zRoiZa9BYQ3Vbw8t8XZcuxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVm/UU8NsvO14f6A5S0ESnvNfcFhcBrcPs5zVg+nbA+6LFUyC
	XMfRu+B7jffYGojD7rXeY7GFdG5kPNFkuNZkqRJSZV6GusMNR02YHf1ty3Jcxg==
X-Google-Smtp-Source: AGHT+IHhIw2pHBt0h/VID9GWM+euXYVzwxAlVqV/d2tqJ+8lzREcc45zS7z9y+WNZ1KvQ13t8NzDcw==
X-Received: by 2002:a05:6a00:218e:b0:71e:1499:7461 with SMTP id d2e1a72fcca58-71e14997515mr361277b3a.4.1728360588868;
        Mon, 07 Oct 2024 21:09:48 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0d7b80bsm5217370b3a.185.2024.10.07.21.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:09:48 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 1/1] mseal: update mseal.rst
Date: Tue,  8 Oct 2024 04:09:41 +0000
Message-ID: <20241008040942.1478931-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008040942.1478931-1-jeffxu@chromium.org>
References: <20241008040942.1478931-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update doc after in-loop change: mprotect/madvise can have
partially updated and munmap is atomic.

Fix indentation and clarify some sections to improve readability.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Fixes: df2a7df9a9aa ("mm/munmap: replace can_modify_mm with can_modify_vma")
Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
Fixes: 38075679b5f1 ("mm/mremap: replace can_modify_mm with can_modify_vma")
Fixes: 23c57d1fa2b9 ("mseal: replace can_modify_mm_madv with a vma variant")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/userspace-api/mseal.rst | 307 +++++++++++++-------------
 1 file changed, 148 insertions(+), 159 deletions(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 4132eec995a3..41102f74c5e2 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -23,177 +23,166 @@ applications can additionally seal security critical data at runtime.
 A similar feature already exists in the XNU kernel with the
 VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
 
-User API
-========
-mseal()
------------
-The mseal() syscall has the following signature:
-
-``int mseal(void addr, size_t len, unsigned long flags)``
-
-**addr/len**: virtual memory address range.
-
-The address range set by ``addr``/``len`` must meet:
-   - The start address must be in an allocated VMA.
-   - The start address must be page aligned.
-   - The end address (``addr`` + ``len``) must be in an allocated VMA.
-   - no gap (unallocated memory) between start and end address.
-
-The ``len`` will be paged aligned implicitly by the kernel.
-
-**flags**: reserved for future use.
-
-**return values**:
-
-- ``0``: Success.
-
-- ``-EINVAL``:
-    - Invalid input ``flags``.
-    - The start address (``addr``) is not page aligned.
-    - Address range (``addr`` + ``len``) overflow.
-
-- ``-ENOMEM``:
-    - The start address (``addr``) is not allocated.
-    - The end address (``addr`` + ``len``) is not allocated.
-    - A gap (unallocated memory) between start and end address.
-
-- ``-EPERM``:
-    - sealing is supported only on 64-bit CPUs, 32-bit is not supported.
-
-- For above error cases, users can expect the given memory range is
-  unmodified, i.e. no partial update.
-
-- There might be other internal errors/cases not listed here, e.g.
-  error during merging/splitting VMAs, or the process reaching the max
-  number of supported VMAs. In those cases, partial updates to the given
-  memory range could happen. However, those cases should be rare.
-
-**Blocked operations after sealing**:
-    Unmapping, moving to another location, and shrinking the size,
-    via munmap() and mremap(), can leave an empty space, therefore
-    can be replaced with a VMA with a new set of attributes.
-
-    Moving or expanding a different VMA into the current location,
-    via mremap().
-
-    Modifying a VMA via mmap(MAP_FIXED).
-
-    Size expansion, via mremap(), does not appear to pose any
-    specific risks to sealed VMAs. It is included anyway because
-    the use case is unclear. In any case, users can rely on
-    merging to expand a sealed VMA.
-
-    mprotect() and pkey_mprotect().
-
-    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
-    for anonymous memory, when users don't have write permission to the
-    memory. Those behaviors can alter region contents by discarding pages,
-    effectively a memset(0) for anonymous memory.
-
-    Kernel will return -EPERM for blocked operations.
-
-    For blocked operations, one can expect the given address is unmodified,
-    i.e. no partial update. Note, this is different from existing mm
-    system call behaviors, where partial updates are made till an error is
-    found and returned to userspace. To give an example:
-
-    Assume following code sequence:
-
-    - ptr = mmap(null, 8192, PROT_NONE);
-    - munmap(ptr + 4096, 4096);
-    - ret1 = mprotect(ptr, 8192, PROT_READ);
-    - mseal(ptr, 4096);
-    - ret2 = mprotect(ptr, 8192, PROT_NONE);
-
-    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
-
-    ret2 will be -EPERM, the page remains to be PROT_READ.
-
-**Note**:
-
-- mseal() only works on 64-bit CPUs, not 32-bit CPU.
-
-- users can call mseal() multiple times, mseal() on an already sealed memory
-  is a no-action (not error).
-
-- munseal() is not supported.
-
-Use cases:
-==========
+SYSCALL
+=======
+mseal syscall signature
+-----------------------
+   ``int mseal(void \* addr, size_t len, unsigned long flags)``
+
+   **addr**/**len**: virtual memory address range.
+      The address range set by **addr**/**len** must meet:
+         - The start address must be in an allocated VMA.
+         - The start address must be page aligned.
+         - The end address (**addr** + **len**) must be in an allocated VMA.
+         - no gap (unallocated memory) between start and end address.
+
+      The ``len`` will be paged aligned implicitly by the kernel.
+
+   **flags**: reserved for future use.
+
+   **Return values**:
+      - **0**: Success.
+      - **-EINVAL**:
+         * Invalid input ``flags``.
+         * The start address (``addr``) is not page aligned.
+         * Address range (``addr`` + ``len``) overflow.
+      - **-ENOMEM**:
+         * The start address (``addr``) is not allocated.
+         * The end address (``addr`` + ``len``) is not allocated.
+         * A gap (unallocated memory) between start and end address.
+      - **-EPERM**:
+         * sealing is supported only on 64-bit CPUs, 32-bit is not supported.
+
+   **Note about error return**:
+      - For above error cases, users can expect the given memory range is
+        unmodified, i.e. no partial update.
+      - There might be other internal errors/cases not listed here, e.g.
+        error during merging/splitting VMAs, or the process reaching the maximum
+        number of supported VMAs. In those cases, partial updates to the given
+        memory range could happen. However, those cases should be rare.
+
+   **Architecture support**:
+      mseal only works on 64-bit CPUs, not 32-bit CPUs.
+
+   **Idempotent**:
+      users can call mseal multiple times. mseal on an already sealed memory
+      is a no-action (not error).
+
+   **no munseal**
+      Once mapping is sealed, it can't be unsealed. The kernel should never
+      have munseal, this is consistent with other sealing feature, e.g.
+      F_SEAL_SEAL for file.
+
+Blocked mm syscall for sealed mapping
+-------------------------------------
+   It might be important to note: **once the mapping is sealed, it will
+   stay in the process's memory until the process terminates**.
+
+   Example::
+
+         *ptr = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+         rc = mseal(ptr, 4096, 0);
+         /* munmap will fail */
+         rc = munmap(ptr, 4096);
+         assert(rc < 0);
+
+   Blocked mm syscall:
+      - munmap
+      - mmap
+      - mremap
+      - mprotect and pkey_mprotect
+      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
+        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK
+
+   The first set of syscalls to block is munmap, mremap, mmap. They can
+   either leave an empty space in the address space, therefore allowing
+   replacement with a new mapping with new set of attributes, or can
+   overwrite the existing mapping with another mapping.
+
+   mprotect and pkey_mprotect are blocked because they changes the
+   protection bits (RWX) of the mapping.
+
+   Certain destructive madvise behaviors, specifically MADV_DONTNEED,
+   MADV_FREE, MADV_DONTNEED_LOCKED, and MADV_WIPEONFORK, can introduce
+   risks when applied to anonymous memory by threads lacking write
+   permissions. Consequently, these operations are prohibited under such
+   conditions. The aforementioned behaviors have the potential to modify
+   region contents by discarding pages, effectively performing a memset(0)
+   operation on the anonymous memory.
+
+   Kernel will return -EPERM for blocked syscalls.
+
+   When blocked syscall return -EPERM due to sealing, the memory regions may
+   or may not be changed, depends on the syscall being blocked:
+
+      - munmap: munmap is atomic. If one of VMAs in the given range is
+        sealed, none of VMAs are updated.
+      - mprotect, pkey_mprotect, madvise: partial update might happen, e.g.
+        when mprotect over multiple VMAs, mprotect might update the beginning
+        VMAs before reaching the sealed VMA and return -EPERM.
+      - mmap and mremap: undefined behavior.
+
+Use cases
+=========
 - glibc:
   The dynamic linker, during loading ELF executables, can apply sealing to
-  non-writable memory segments.
-
-- Chrome browser: protect some security sensitive data-structures.
+  mapping segments.
 
-Notes on which memory to seal:
-==============================
+- Chrome browser: protect some security sensitive data structures.
 
-It might be important to note that sealing changes the lifetime of a mapping,
-i.e. the sealed mapping won’t be unmapped till the process terminates or the
-exec system call is invoked. Applications can apply sealing to any virtual
-memory region from userspace, but it is crucial to thoroughly analyze the
-mapping's lifetime prior to apply the sealing.
+When not to use mseal
+=====================
+Applications can apply sealing to any virtual memory region from userspace,
+but it is *crucial to thoroughly analyze the mapping's lifetime* prior to
+apply the sealing. This is because the sealed mapping *won’t be unmapped*
+until the process terminates or the exec system call is invoked.
 
 For example:
+   - aio/shm
+     aio/shm can call mmap and  munmap on behalf of userspace, e.g.
+     ksys_shmdt() in shm.c. The lifetimes of those mapping are not tied to
+     the lifetime of the process. If those memories are sealed from userspace,
+     then munmap will fail, causing leaks in VMA address space during the
+     lifetime of the process.
+
+   - ptr allocated by malloc (heap)
+     Don't use mseal on the memory ptr return from malloc().
+     malloc() is implemented by allocator, e.g. by glibc. Heap manager might
+     allocate a ptr from brk or mapping created by mmap.
+     If an app calls mseal on a ptr returned from malloc(), this can affect
+     the heap manager's ability to manage the mappings; the outcome is
+     non-deterministic.
+
+     Example::
+
+        ptr = malloc(size);
+        /* don't call mseal on ptr return from malloc. */
+        mseal(ptr, size);
+        /* free will success, allocator can't shrink heap lower than ptr */
+        free(ptr);
+
+mseal doesn't block
+===================
+In a nutshell, mseal blocks certain mm syscall from modifying some of VMA's
+attributes, such as protection bits (RWX). Sealed mappings doesn't mean the
+memory is immutable.
 
-- aio/shm
-
-  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_shmdt() in
-  shm.c. The lifetime of those mapping are not tied to the lifetime of the
-  process. If those memories are sealed from userspace, then munmap() will fail,
-  causing leaks in VMA address space during the lifetime of the process.
-
-- Brk (heap)
-
-  Currently, userspace applications can seal parts of the heap by calling
-  malloc() and mseal().
-  let's assume following calls from user space:
-
-  - ptr = malloc(size);
-  - mprotect(ptr, size, RO);
-  - mseal(ptr, size);
-  - free(ptr);
-
-  Technically, before mseal() is added, the user can change the protection of
-  the heap by calling mprotect(RO). As long as the user changes the protection
-  back to RW before free(), the memory range can be reused.
-
-  Adding mseal() into the picture, however, the heap is then sealed partially,
-  the user can still free it, but the memory remains to be RO. If the address
-  is re-used by the heap manager for another malloc, the process might crash
-  soon after. Therefore, it is important not to apply sealing to any memory
-  that might get recycled.
-
-  Furthermore, even if the application never calls the free() for the ptr,
-  the heap manager may invoke the brk system call to shrink the size of the
-  heap. In the kernel, the brk-shrink will call munmap(). Consequently,
-  depending on the location of the ptr, the outcome of brk-shrink is
-  nondeterministic.
-
-
-Additional notes:
-=================
 As Jann Horn pointed out in [3], there are still a few ways to write
-to RO memory, which is, in a way, by design. Those cases are not covered
-by mseal(). If applications want to block such cases, sandbox tools (such as
-seccomp, LSM, etc) might be considered.
+to RO memory, which is, in a way, by design. And those could be blocked
+by different security measures.
 
 Those cases are:
 
-- Write to read-only memory through /proc/self/mem interface.
-- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
-- userfaultfd.
+   - Write to read-only memory through /proc/self/mem interface (FOLL_FORCE).
+   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
+   - userfaultfd.
 
 The idea that inspired this patch comes from Stephen Röttger’s work in V8
 CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
 
-Reference:
-==========
-[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
-
-[2] https://man.openbsd.org/mimmutable.2
-
-[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
-
-[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
+Reference
+=========
+- [1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
+- [2] https://man.openbsd.org/mimmutable.2
+- [3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
+- [4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
-- 
2.47.0.rc0.187.ge670bccf7e-goog


