Return-Path: <linux-kernel+bounces-569037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66CFA69DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182FE19C1D80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EED1E492D;
	Thu, 20 Mar 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2e9vJiC"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50A1E25FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435769; cv=none; b=EpeU0Y1JKOVKEnzLIOIM8mfDahIMuUAMwRoCMbgBGX7HsuntkH2Bf0G8eRb6t02KyBHi8QnN5J36cdeAoMJEQevvBQlWbfS3xBkz/MwoFjHIzX9eEh0wk+F8dTfYPIcEYINR3i2xP5L4IyJq6/Qnw+rNLsRnwsBj/MMh2eob3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435769; c=relaxed/simple;
	bh=i5QZpDZ7YI6hC/iH6qDCV39l6Yx4a7oBLqrLCDGryQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GL6bPo27tmCtnLywL+cwqk5V0PHcm9Lh4TDXxLSo5OHe2fLt7guc90gHR6EZY59erVmFPNwu0B8khQ9bhAt361+3GksJMsADH/HCpyLaE0XqIA2/lUmnG3aiOsa42RjJvsDRNLHN85G0l8ZY055fX3RbYyZLnAKvK5iKEinuIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2e9vJiC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so728539a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435766; x=1743040566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8JvgS9AJeolBSiA/4pI8Lzjs3pyle8TVUuTg3xWzw4=;
        b=T2e9vJiCghOK//PMkpZ88RJqcaYfyi0w8rCH28VpQ1Tu+nrhGmoWgS/7sTAaSdWg/u
         Kn/oAzbi0W0i5nsdqEwpC9U7btxgLWGr+lp+pQQvsu9vqGdUi2eC1fxusQSH8i/SakHb
         43/Y8/Rx/mfsTEud/d+c1KkoKGC9bnKiiRYjp89YYs8m/GL7LxpB33uXMB+uY7Zcg9uK
         EuLq4TujcMOsqrDVky+Ql5DWa2TM9gjfnedpEnGmihLR+7EgksRrsb3keyjEisf0KPZV
         OPl92fEwkbNM6h6ggqXalsQcVSTFP7Z03gFzJ0RKEWTs+ApuLLZK0RrFPq8kA9n64Ccm
         qIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435766; x=1743040566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8JvgS9AJeolBSiA/4pI8Lzjs3pyle8TVUuTg3xWzw4=;
        b=U6Au5p7Yr73FrFRkAz/f0SfjJpoo4YFMyYL/65MCiF4Ql5XOQS3x2zvP6rDBApr0Hw
         M0gmHcm/TLl98aMLlRcMqAbvltRRVMMJtDYDriez66e3yvuomRlM3mWmeD9G2b1fSIce
         Lly6JnhUFZaxgCJ8l4aGVf6kwWKrnQZF45RlSLakhRYy0DnPsOE3PnGmKtJWp+K+MncD
         uOZfDg5Tm8kVsosaQMOR+H0OueKjPU4ybnNQ77d30nF73UW06rjh/hB9eFYe4Cu1/ZQh
         dd6sbfqeSSauG3bocWok00NG+E9FN3pKar8ys9JPE/NJV/RRe/93fkub0/KKanVb5y5/
         TeLw==
X-Gm-Message-State: AOJu0YzbRnstXqKPdA4GD9xfNvE5sIOtCJm/M1CyzZuNPjKMO1buxsaZ
	Tufsz1Q2ZbT135hZ68Ws1QQmwC0T3Ym+OCEXaIgTord2bcy7ymj3FriT9M828CORpgdNUlraUHj
	Q/49fOBbCZAfrI3wPPbe1kkfmMEDLHCmyorNE+lJX/aMDeIyb1FGIavf8hCv1+JCL6zQw/Rs5gc
	kOWvMhSuPMUe11kPnGAukF9RE4O0e8X9x01ZfL62VSX8J7uPJnmyXxMqoeOC6jSQ==
X-Google-Smtp-Source: AGHT+IHJ+6KP5vNZbXdYS1/CKUc+TX5VPg88WvJbDadlOPM+I9Fd2xGdM5rk7YaUv/4ZvrxELn+iFnZzlrBohdZi
X-Received: from pjk8.prod.google.com ([2002:a17:90b:5588:b0:2fc:ccfe:368])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2651:b0:2ff:6ac2:c5a5 with SMTP id 98e67ed59e1d1-301be1f90d5mr6693304a91.26.1742435766515;
 Wed, 19 Mar 2025 18:56:06 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:39 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-5-changyuanl@google.com>
Subject: [PATCH v5 04/16] memblock: Add support for scratch memory
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Alexander Graf <graf@amazon.com>

With KHO (Kexec HandOver), we need a way to ensure that the new kernel
does not allocate memory on top of any memory regions that the previous
kernel was handing over. But to know where those are, we need to include
them in the memblock.reserved array which may not be big enough to hold
all ranges that need to be persisted across kexec. To resize the array,
we need to allocate memory. That brings us into a catch 22 situation.

The solution to that is limit memblock allocations to the scratch regions:
safe regions to operate in the case when there is memory that should remain
intact across kexec.

KHO provides several "scratch regions" as part of its metadata. These
scratch regions are contiguous memory blocks that known not to contain any
memory that should be persisted across kexec. These regions should be large
enough to accommodate all memblock allocations done by the kexeced kernel.

We introduce a new memblock_set_scratch_only() function that allows KHO to
indicate that any memblock allocation must happen from the scratch regions.

Later, we may want to perform another KHO kexec. For that, we reuse the
same scratch regions. To ensure that no eventually handed over data gets
allocated inside a scratch region, we flip the semantics of the scratch
region with memblock_clear_scratch_only(): After that call, no allocations
may happen from scratch memblock regions. We will lift that restriction
in the next patch.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h | 20 +++++++++++++
 mm/Kconfig               |  4 +++
 mm/memblock.c            | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 1037fd7aabf4..a83738b7218b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -45,6 +45,11 @@ extern unsigned long long max_possible_pfn;
  * @MEMBLOCK_RSRV_KERN: memory region that is reserved for kernel use,
  * either explictitly with memblock_reserve_kern() or via memblock
  * allocation APIs. All memblock allocations set this flag.
+ * @MEMBLOCK_KHO_SCRATCH: memory region that kexec can pass to the next
+ * kernel in handover mode. During early boot, we do not know about all
+ * memory reservations yet, so we get scratch memory from the previous
+ * kernel that we know is good to use. It is the only memory that
+ * allocations may happen from in this phase.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -54,6 +59,7 @@ enum memblock_flags {
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
+	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 };
 
 /**
@@ -148,6 +154,8 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
+int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -292,6 +300,11 @@ static inline bool memblock_is_driver_managed(struct memblock_region *m)
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
 }
 
+static inline bool memblock_is_kho_scratch(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_KHO_SCRATCH;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
@@ -620,5 +633,12 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
 static inline void memtest_report_meminfo(struct seq_file *m) { }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+void memblock_set_kho_scratch_only(void);
+void memblock_clear_kho_scratch_only(void);
+#else
+static inline void memblock_set_kho_scratch_only(void) { }
+static inline void memblock_clear_kho_scratch_only(void) { }
+#endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..550bbafe5c0b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -506,6 +506,10 @@ config HAVE_GUP_FAST
 	depends on MMU
 	bool
 
+# Enable memblock support for scratch memory which is needed for kexec handover
+config MEMBLOCK_KHO_SCRATCH
+	bool
+
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
diff --git a/mm/memblock.c b/mm/memblock.c
index e704e3270b32..c0f7da7dff47 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -106,6 +106,13 @@ unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+/* When set to true, only allocate from MEMBLOCK_KHO_SCRATCH ranges */
+static bool kho_scratch_only;
+#else
+#define kho_scratch_only false
+#endif
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_MEMORY_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -165,6 +172,10 @@ bool __init_memblock memblock_has_mirror(void)
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
+	/* skip non-scratch memory for kho early boot allocations */
+	if (kho_scratch_only)
+		return MEMBLOCK_KHO_SCRATCH;
+
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
 
@@ -924,6 +935,18 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+__init_memblock void memblock_set_kho_scratch_only(void)
+{
+	kho_scratch_only = true;
+}
+
+__init_memblock void memblock_clear_kho_scratch_only(void)
+{
+	kho_scratch_only = false;
+}
+#endif
+
 /**
  * memblock_setclr_flag - set or clear flag for a memory region
  * @type: memblock type to set/clear flag for
@@ -1049,6 +1072,36 @@ int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t
 				    MEMBLOCK_RSRV_NOINIT);
 }
 
+/**
+ * memblock_mark_kho_scratch - Mark a memory region as MEMBLOCK_KHO_SCRATCH.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH will be considered
+ * for allocations during early boot with kexec handover.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_KHO_SCRATCH);
+}
+
+/**
+ * memblock_clear_kho_scratch - Clear MEMBLOCK_KHO_SCRATCH flag for a
+ * specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0,
+				    MEMBLOCK_KHO_SCRATCH);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -1080,6 +1133,13 @@ static bool should_skip_region(struct memblock_type *type,
 	if (!(flags & MEMBLOCK_DRIVER_MANAGED) && memblock_is_driver_managed(m))
 		return true;
 
+	/*
+	 * In early alloc during kexec handover, we can only consider
+	 * MEMBLOCK_KHO_SCRATCH regions for the allocations
+	 */
+	if ((flags & MEMBLOCK_KHO_SCRATCH) && !memblock_is_kho_scratch(m))
+		return true;
+
 	return false;
 }
 
@@ -2421,6 +2481,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
+	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.48.1.711.g2feabab25a-goog


