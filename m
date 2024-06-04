Return-Path: <linux-kernel+bounces-200324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB948FAE6B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05931C23FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0069145B28;
	Tue,  4 Jun 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hlnEUBcy"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB414533C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492168; cv=none; b=mpYUG9yUNJYX1sQmQ7iOokmtu85haNuD6RggVjoxaYc0elAidxl8dgpwH4xCcr39r3w+tkSHLQB23CuwazsTfZmCsPFft4nfIKbjSWYw5Q/7GVYjtQ+L0c8VWTKOuRCsmRXPjVsL/g6ihQFaUuvb3lJLMs0Kihg9N3K2mLZMQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492168; c=relaxed/simple;
	bh=qzo424Vk5rNxGD6BzmCZaZ2WBrZluiV/F8P4RMNJ0qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDRFM+dULP99/h6KkvCULuZ+5O/KV4EwfUx5gnNlpGKqFxDcZ3wtVFO0C3mgG2RiJ/AiGOojQ6U768OzF/7xMcvRAj/tlWl9YUp3UznOviby//JLtv+6o67YsqK/HQu4GKukfZ/4RTyOGGmcmtgArAfNGB/1UrPlQOPZHV4zggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hlnEUBcy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68f1017170so77482766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492164; x=1718096964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3U0KL7w5U75JMn9WGwTfgeaFpYbfkGLETLiHeR3bJI=;
        b=hlnEUBcy+KP/tnIcd+B1HRDEX3CdAr5lMWPxpb/1I5fzfYCTKvaTKKgKV5xAFh0tnt
         A+vmIWNDVTSr17kHKxpgWsR52txSD1kCFQ/NAsc+Z3zhmkcvc3AmSKliGCSwClp6SVf8
         fFeMGvlLBrgL3AHTTmayijVYQaR153Sbqeer84nQLoo/kXMVqJB6mDGcY1uU5rD8OpPy
         53j7Y0WkZDgIoqS4ka3AC8sANe5HJU19ViHId82j1tuNtrZ/Ff57SrwJRGipbXl23GQ0
         L9vLHZwXmENS6qAYd+nO87qpCRc1xzookqTWVKKrOFemZCj1jqurdtjFd6BqsdHST+Te
         Q8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492164; x=1718096964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3U0KL7w5U75JMn9WGwTfgeaFpYbfkGLETLiHeR3bJI=;
        b=kaZUjAOAJBJs1boJMjX0pyFaku/nHFp1TnGluipz9YwP3VrhmyESRpKuQH874qqjGm
         Miq88w3t0gVBBHVOyDe1/A9wcUDOwf1u1BDS43S5zoptEMTfu/2ksB7pphTQo6ah89bR
         f7wpJ6+TSCqoUEaZ2Z8YDJNVgzXwm6e+ZP47SaPdTjqH1rWMOCLLEBPuVlV5jrIQ/Ws7
         cY+aXPx1JJj0sEluFfrUveXag/32ZylE4CsinSYsjkV0B6V6q+Zct0rIBBm10clLYqIm
         McwvaBptVqq/WeCsK6npfkgL5UjpY4B/yXQaAUZJV63iJCyBYF7NYH76dTfZaEsBz5XQ
         sFiA==
X-Forwarded-Encrypted: i=1; AJvYcCXmdQYflw5u3XK+LupLPL71/4wl1TrMnlKrjnw7QwlXc4LzCqjTS/qTkzBvZWXygO/ldQz6Fb/eEsJVIM3cXEGxoBtfpWT+yAyQxXtc
X-Gm-Message-State: AOJu0Ywj5YcUnjB2kONqpqqTsbn2r+6m1QeUXmtw6MxlhBGRYYgrQMw0
	GwfQfSMvqaIhpVb5Uu+DVMRPjnkUgw1DatlXCb5xOvRn68CemrG4QPDcqQDw+CA=
X-Google-Smtp-Source: AGHT+IEufjYupL5V5fjGHiqCyxBU1VmyGKHrnjXAzODktOVBv2dBJp+P8PCQHm8Bv1pzw0q+GjsDJg==
X-Received: by 2002:a17:906:c4ca:b0:a68:3bf0:79eb with SMTP id a640c23a62f3a-a683c10d453mr547303066b.47.1717492164227;
        Tue, 04 Jun 2024 02:09:24 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:22 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 14/15] linux/mm.h: move high_memory to mm/high_memory.h
Date: Tue,  4 Jun 2024 11:08:44 +0200
Message-Id: <20240604090845.2182265-15-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable is used by lots of arch/*/include/asm/ headers, but
these do not (and should not) include the huge linux/mm.h header.
Let's move this "extern" variable to a separate header and include
this one in arch/.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm/include/asm/memory.h                | 4 ++++
 arch/arm/include/asm/pgtable.h               | 2 ++
 arch/csky/include/asm/page.h                 | 1 +
 arch/hexagon/include/asm/mem-layout.h        | 4 ++++
 arch/m68k/include/asm/page_mm.h              | 1 +
 arch/m68k/include/asm/pgtable_mm.h           | 1 +
 arch/parisc/include/asm/floppy.h             | 1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h | 4 ++++
 arch/powerpc/include/asm/nohash/32/pgtable.h | 1 +
 arch/powerpc/include/asm/page.h              | 1 +
 arch/x86/include/asm/floppy.h                | 1 +
 arch/x86/include/asm/pgtable_32_areas.h      | 4 ++++
 drivers/mtd/nand/onenand/onenand_samsung.c   | 1 +
 include/linux/mm.h                           | 2 +-
 include/linux/mm/high_memory.h               | 7 +++++++
 15 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/mm/high_memory.h

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ef2aa79ece5a..a67afb213e2e 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -387,6 +387,10 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
  */
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
 					&& pfn_valid(virt_to_pfn(kaddr)))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index be91e376df79..eb80f6a65619 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -11,6 +11,8 @@
 #include <asm/proc-fns.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 0ca6c408c07f..17ccc91c3cd6 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -32,6 +32,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/mm/high_memory.h>
 #include <linux/pfn.h>
 
 #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
diff --git a/arch/hexagon/include/asm/mem-layout.h b/arch/hexagon/include/asm/mem-layout.h
index e2f99413fe56..a09116c50043 100644
--- a/arch/hexagon/include/asm/mem-layout.h
+++ b/arch/hexagon/include/asm/mem-layout.h
@@ -10,6 +10,10 @@
 
 #include <linux/const.h>
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 /*
  * Have to do this for ginormous numbers, else they get printed as
  * negative numbers, which the linker no likey when you try to
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index e0ae4d5fc985..f958655d1931 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
+#include <linux/mm/high_memory.h>
 #include <asm/module.h>
 
 /*
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index dbdf1c2b2f66..ec593656bdc5 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -13,6 +13,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
+#include <linux/mm/high_memory.h>
 #include <linux/sched.h>
 #include <linux/threads.h>
 
diff --git a/arch/parisc/include/asm/floppy.h b/arch/parisc/include/asm/floppy.h
index b318a7df52f6..98ed37c5dc59 100644
--- a/arch/parisc/include/asm/floppy.h
+++ b/arch/parisc/include/asm/floppy.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_PARISC_FLOPPY_H
 #define __ASM_PARISC_FLOPPY_H
 
+#include <linux/mm/high_memory.h>
 #include <linux/vmalloc.h>
 
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 52971ee30717..03e0a32e1c2c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -4,6 +4,10 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 /*
  * The "classic" 32-bit implementation of the PowerPC MMU uses a hash
  * table containing PTEs, together with a set of 16 segment registers,
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9164a9e41b02..8a9f5b546e4a 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -5,6 +5,7 @@
 #include <asm-generic/pgtable-nopmd.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e411e5a70ea3..9ae87fc2c648 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -7,6 +7,7 @@
  */
 
 #ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
diff --git a/arch/x86/include/asm/floppy.h b/arch/x86/include/asm/floppy.h
index 6ec3fc969ad5..7756e984f146 100644
--- a/arch/x86/include/asm/floppy.h
+++ b/arch/x86/include/asm/floppy.h
@@ -10,6 +10,7 @@
 #ifndef _ASM_X86_FLOPPY_H
 #define _ASM_X86_FLOPPY_H
 
+#include <linux/mm/high_memory.h>
 #include <linux/vmalloc.h>
 
 /*
diff --git a/arch/x86/include/asm/pgtable_32_areas.h b/arch/x86/include/asm/pgtable_32_areas.h
index b6355416a15a..b339137b4f4e 100644
--- a/arch/x86/include/asm/pgtable_32_areas.h
+++ b/arch/x86/include/asm/pgtable_32_areas.h
@@ -3,6 +3,10 @@
 
 #include <asm/cpu_entry_area.h>
 
+#ifndef __ASSEMBLY__
+#include <linux/mm/high_memory.h>
+#endif
+
 /*
  * Just any arbitrary offset to the start of the vmalloc VM area: the
  * current 8MB value just means that there will be a 8MB "hole" after the
diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index fd6890a03d55..7c3cc270386d 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm/high_memory.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c9089adbb4e..83613e9297b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -6,6 +6,7 @@
 #include <linux/mm/folio_size.h>
 #include <linux/mm/folio_usage.h>
 #include <linux/mm/folio_zone.h>
+#include <linux/mm/high_memory.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/pfmemalloc.h>
@@ -83,7 +84,6 @@ static inline void totalram_pages_add(long count)
 	atomic_long_add(count, &_totalram_pages);
 }
 
-extern void * high_memory;
 extern int page_cluster;
 extern const int page_cluster_max;
 
diff --git a/include/linux/mm/high_memory.h b/include/linux/mm/high_memory.h
new file mode 100644
index 000000000000..e504aafd0d48
--- /dev/null
+++ b/include/linux/mm/high_memory.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_HIGH_MEMORY_H
+#define _LINUX_MM_HIGH_MEMORY_H
+
+extern void * high_memory;
+
+#endif /* _LINUX_MM_HIGH_MEMORY_H */
-- 
2.39.2


