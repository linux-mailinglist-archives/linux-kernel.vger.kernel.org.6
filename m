Return-Path: <linux-kernel+bounces-211624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCD7905496
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF7B262DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC002181B95;
	Wed, 12 Jun 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWUs/fU4"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FF181B90
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200605; cv=none; b=BwjITiyxNkxZh4YwE0v+UmWFd13ZKTT/UX0Q/b1ezrix8QFGFPpcGioBUj0RINXVNyyS9Sh/GRc3b0bZThYC8+3U2d3++s5T/YAhMynXI2HtDX8UHANgrEomiyCwe66FnDaJdXQtxRBdXmhya/TV02L/vk1YjcqaYrwgi0jifGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200605; c=relaxed/simple;
	bh=B9snKeq9ZRYgjq/H6UcbA2Jvzo4lG/FH93/9EA3J98Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f6p8njc7l1bqpre38Iig2MyQaYOnE6OGcLeu3Wlavh+uBjAt4NTGVXxe6q8gY7YhqTScQRseCSHiZRi60zpuCDrGXBSqJPjqFl7JNR55ooDI7VdTp5poLXJupffSiPHRgGgTAhgl4UBbgLjY/jHtdKc8mC4uKjbBGdpAEh22/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWUs/fU4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-422a0f21366so2127995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718200602; x=1718805402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EmGrnZgO3t8ZPnbrwHQ5qRX6BTJ4KO1P/NylSxAXYBg=;
        b=UWUs/fU4xO2SvlS+Cn4VV+JnImqbKOKgUbbnBY6iWAdWp0yUrp8FSIZNv8tsceXPSG
         CroLEKR6cIcXqo16/yjJmmJFpvSWhiPekhqcJr3DxXCaikXDOhYpXlj6nli2lgAw2ZgS
         L/dWP4sdDMQs7H3RHbXEPh6cbe60qbI5t0lNcKjsoXDIlwyhXvrW/tsPNA45wh07MxTR
         LHAiAWUNMX431xqSJiIuzftiDTE3jItsNgGW9Fp5ZBUOtCuAZKHze/KsayGDjLaHMzZU
         TXUBgAVKou7FSVKoLs/CkVu/jcifpfQnoObPq6lXBM6VHH1aGhx4R/p48PuaNX+LVquG
         q3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200602; x=1718805402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmGrnZgO3t8ZPnbrwHQ5qRX6BTJ4KO1P/NylSxAXYBg=;
        b=EW32hbw27/uU2hpSONtBS2A/8vFfum0gfYKlM8wX3sUH6m46wIviF4Qs+J7QzrxfUy
         m1uBl1YhXbxz+dcBgFFLtYDQuLmGcivSkqEkZt9xLKQWLOe12qSLd4P+jOZ7dLBxUNxw
         xQHhQ2lgryOGXcvRagw428lV0/vWrpxmzJNERtKGdlPLBkoQPMmwTRqdz8mrLp3nncY8
         Hlo6UYzhoT0CF7e8PoVQs2NM1vG830Bgry3EZyum8I5EmYrXvj1hBqAUqtgNakA1/wnS
         VhFyK0aEhNX5GbI8EmJT+uXVFq1Z4Orw1PNS28poJ3UekqNtI3AXLgMWqCdbVHc7oxrT
         SRPA==
X-Gm-Message-State: AOJu0YyqhDvS5q/DVrLRjnEMIJWaYCm+iSyiHOhA4qGlHdEAjGj/WErq
	s3AiK00BC/+IaSxz6qpjmdYZzrTjABHmV4qNt7vqnBfDMyVISOzpAB++qyrYdOQrur1V8g==
X-Google-Smtp-Source: AGHT+IFsOJdefJuFx3+Pp8lvsrui/AUtgWCOEXQHIXTVg2yNTTD6iKVMIgE75EiXY5YO2gtti/sv7rZm
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b87:b0:421:29c8:4ecb with SMTP id
 5b1f17b1804b1-422865ac153mr277195e9.4.1718200602509; Wed, 12 Jun 2024
 06:56:42 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4484; i=ardb@kernel.org;
 h=from:subject; bh=9nbCSSgNmzby1JSlEnWpnSGEjOMACQhq5RITLtxrX/A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS1zpfgLpcp2b3bD2JvSNT9/TLN9PW3eYoGMywWa1x3On
 JO4tWdCRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI+BqGv6JcvToXPPc5M52Z
 aWb5obptXsDCEvHAI7lTt+f271a5s5uR4eDp+GmSeQXpt/48lu+sVtrIXCPAupKvQKGradmXiEc P+AE=
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612135638.298882-2-ardb+git@google.com>
Subject: [PATCH v3] x86/efi: Free EFI memory map only when installing a new one.
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The logic in __efi_memmap_init() is shared between two different
execution flows:
- mapping the EFI memory map early or late into the kernel VA space, so
  that its entries can be accessed;
- cloning the EFI memory map in order to insert new entries that are
  created as a result of creating a memory reservation
  (efi_arch_mem_reserve())

In the former case, the underlying memory containing the kernel's view
of the EFI memory map (which may be heavily modified by the kernel
itself on x86) is not modified at all, and the only thing that changes
is the virtual mapping of this memory, which is different between early
and late boot.

In the latter case, an entirely new allocation is created that carries a
new, updated version of the kernel's view of the EFI memory map. When
installing this new version, the old version will no longer be
referenced, and if the memory was allocated by the kernel, it will leak
unless it gets freed.

The logic that implements this freeing currently lives on the code path
that is shared between these two use cases, but it should only apply to
the latter. So move it to the correct spot.

While at it, move __efi_memmap_free() into its only caller, and drop the
dummy definition for non-x86 architectures, as that is no longer needed.

Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v3:
- don't move __efi_memmap_free() into what turned out not to be its only
  caller
- drop another CPP #define related to the dummy definition

v2:
- free old memory map only after installing the new one succeeded
- move __efi_memmap_free() into its only caller
- drop obsolete dummy declaration from generic code

 arch/x86/include/asm/efi.h     |  1 -
 arch/x86/platform/efi/memmap.c | 12 +++++++++++-
 drivers/firmware/efi/memmap.c  |  9 ---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 1dc600fa3ba5..481096177500 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -401,7 +401,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
 extern void __efi_memmap_free(u64 phys, unsigned long size,
 			      unsigned long flags);
-#define __efi_memmap_free __efi_memmap_free
 
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 4ef20b49eb5e..6ed1935504b9 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -92,12 +92,22 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  */
 int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
+	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
+	unsigned long flags = efi.memmap.flags;
+	u64 phys = efi.memmap.phys_map;
+	int ret;
+
 	efi_memmap_unmap();
 
 	if (efi_enabled(EFI_PARAVIRT))
 		return 0;
 
-	return __efi_memmap_init(data);
+	ret = __efi_memmap_init(data);
+	if (ret)
+		return ret;
+
+	__efi_memmap_free(phys, size, flags);
+	return 0;
 }
 
 /**
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 3365944f7965..34109fd86c55 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -15,10 +15,6 @@
 #include <asm/early_ioremap.h>
 #include <asm/efi.h>
 
-#ifndef __efi_memmap_free
-#define __efi_memmap_free(phys, size, flags) do { } while (0)
-#endif
-
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
@@ -51,11 +47,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
-		__efi_memmap_free(efi.memmap.phys_map,
-				  efi.memmap.desc_size * efi.memmap.nr_map,
-				  efi.memmap.flags);
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
-- 
2.45.2.505.gda0bf45e8d-goog


