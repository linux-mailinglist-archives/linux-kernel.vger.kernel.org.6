Return-Path: <linux-kernel+bounces-560162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD26EA5FEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D96716E478
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971E1EE7C0;
	Thu, 13 Mar 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VidZKwKu"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EF1E8353
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889505; cv=none; b=jw9OCdJj0/JQYqkrRhqa3zBv7iAnxzebswEXA5lo2fKONRApaf7mJn/IesRF2Db295pUjeYWWIrXmoYcfIkfvKngaq9H/NX3YUArvWvEz2yfo2bMkJWZjdNZQ725LH70Pj4edNqy2IUatrad9PaxPJXCW/pdWz4TLv3nYgthkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889505; c=relaxed/simple;
	bh=ySyHX086OhKMjV+LGusFiK1XjR1ttUWVQkQVY652QBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nGkUUgviWE8I7nWnjhUF57LwVUTonyNQ4BPOYfrJDtrMzWwRjPRYifQH+aWLV3C94YU3PUH6xNxhu85QMjhUhkqJDq/gNDfD9YA7qh7Rg8BOi8qriX5QnwoXbtJy2gcws4egF8JxUxHvKUNKTUF0MZVfyrBXfxVkBj7k4J3x6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VidZKwKu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cec217977so6872045e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889502; x=1742494302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fZcxWQbpwDGRa6fhxDYyz+3EEc+Y2ZKaTPRMrOqTnk=;
        b=VidZKwKu6QnKNGVQ43zvHn+n1OZYMJLQh54WWUyXTanyRrw46HJAmmZNJo45P1XgGA
         WLsvVyn4+M9L035fyLnea4tjidSL0jj/zthS0Y+gx/wJ5z8MWNSY8nmVMQfJ96AgfxTM
         lnnrqzc9K+h2NS2vqpYyRtLpTB2z3DdfBS71QwIqCtcTrGVb5O4lFlujmnEIf0hvuhKr
         i17/M9OyWUSLdXmaI9dVc98JQH1SGS9D8YPbSU7oLTidD7kUpF+hqSZjTrFw57qdmnlI
         N5E9geFu9MeQ5Z3xp69pD58UDFlqPBBk7r3uv9+6Cy9YfPh6vyVldp0+KnlVkUqoYxKi
         mBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889502; x=1742494302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fZcxWQbpwDGRa6fhxDYyz+3EEc+Y2ZKaTPRMrOqTnk=;
        b=BffRXzb8YrKW8X20X2KkroAVGQKivsldZmCZ6NNaIsomIFK+HCUa+oCP9eLFZ4xjRs
         atr7l6VnRKuaGlfzKBKOQ1Kl1IxxjZy9A2c5Fa+J2SSgzxjS6aUd0PRtBypteZrJtcbN
         0HjauqqTG6NZUVYVMX2gWjUMoX1ZB/+uU1b/StoOu0sBVdAUnGmq0nDo11rLviWtl6o2
         C2DTG2nfWqc+xSB8vgciw9FAibG2gPozUjSiB1wb9KcEW8f9Fq5BrfKloJPG/f08BD69
         L+m7nPh5xbJQ+8wdSABQ9gHn4cJ6G4u2osL+VlF8vEbdJcNRH9N3kE8tgQndWG4scIAx
         eHWQ==
X-Gm-Message-State: AOJu0YyiWtxcGaAaq2IoR6Q1OAhf6WL9SGCseqeGlYgzgy+l7A1zD+Nr
	uF1Bc3violb7lGCq4ZZDnl0h232ThDKOdpuP5gucZHvWs1Mh8Vn5FKT1HdNLWpBuq/O25aOXIvJ
	GB2aeoOaLMQ==
X-Google-Smtp-Source: AGHT+IHiDt1oL77dvdJgK/87oo1nyciMshPbOYF45qDzwy03t12Mx9YK7JD3EmFk7CS3zUEi1Qz1ZwU+UaX2dg==
X-Received: from wmbbd19.prod.google.com ([2002:a05:600c:1f13:b0:43c:eb09:3784])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4593:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43d1d87fd9bmr6539185e9.6.1741889502176;
 Thu, 13 Mar 2025 11:11:42 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:20 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-1-04972e046cea@google.com>
Subject: [PATCH RFC 01/11] x86/mm: Bare minimum ASI API for page_alloc integration
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

This commit serves to provide a minimal framework to present an ASI
integration into the page allocator, without getting distracted by
irrelevant details. There's no need to review this actively, just refer
back to it as-needed when reading the later patches.

In a real [PATCH] series this should be several separate commits.

Aside from missing the actual core address-space switching and security
logic, this is missing runtime-disablement of ASI. If you enable it in
Kconfig, ASI's mm logic gets run unconditionally. That isn't what we
want in the real implementation (certainly not in the initial version,
anyway).

- Add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION. Attempt to follow the
  proposal by Mike Rapoport here:
  https://lore.kernel.org/linux-mm/Z8K2B3WJoICVbDj3@kernel.org/

  In this RFC, there's only a small amount of x86-specific logic,
  perhaps it's possible to implement this logic without any arch/
  dependency. But, this is absolutely not true of the full ASI
  implementation. So that's already reflected in the Kconfig stuff
  here.

- Introduce struct asi, which is an "ASI domain", i.e. an address space.
  For now this is nothing but a wrapper for a PGD.

- Introduce the "global nonsensitive" ASI domain. This contains all the
  mappings that do not need to be protected from any attacker.
  Maintaining these mappings is the subject of this RFC.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/Kconfig               | 14 ++++++++++++++
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/asi.h | 28 ++++++++++++++++++++++++++++
 arch/x86/mm/Makefile       |  1 +
 arch/x86/mm/asi.c          |  8 ++++++++
 arch/x86/mm/init.c         |  3 ++-
 include/linux/asi.h        | 18 ++++++++++++++++++
 7 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b8a4ff36558228240080a5677f702d37f4f8d547..871ad0987c8740205ceec675a6b7304c644f28e1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -17,6 +17,20 @@ config CPU_MITIGATIONS
 	def_bool y
 endif
 
+config ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION
+	bool
+
+config MITIGATION_ADDRESS_SPACE_ISOLATION
+	bool "Allow code to run with a reduced kernel address space"
+	default n
+	depends on ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION && !PARAVIRT
+	help
+	  This feature provides the ability to run some kernel code
+	  with a reduced kernel address space. This can be used to
+	  mitigate some speculative execution attacks.
+
+	  !PARAVIRT dependency is a temporary hack while ASI has custom
+	  pagetable manipulation code.
 #
 # Selected by architectures that need custom DMA operations for e.g. legacy
 # IOMMUs not handled by dma-iommu.  Drivers must never select this symbol.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0e27ebd7e36a9e3d69ad3e77c8db5dcf11ae3016..19ceecf5978bbe62e0742072c192c8ee952082dc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -36,6 +36,7 @@ config X86_64
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
+	select ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
new file mode 100644
index 0000000000000000000000000000000000000000..b8f604df6a36508acbc10710f821d5f95e8cdceb
--- /dev/null
+++ b/arch/x86/include/asm/asi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ASI_H
+#define _ASM_X86_ASI_H
+
+#include <asm/pgtable_types.h>
+
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+
+extern struct asi __asi_global_nonsensitive;
+#define ASI_GLOBAL_NONSENSITIVE	(&__asi_global_nonsensitive)
+
+/*
+ * An ASI domain (struct asi) represents a restricted address space. The
+ * unrestricted address space (and user address space under PTI) are not
+ * represented as a domain.
+ */
+struct asi {
+	pgd_t *pgd;
+};
+
+static __always_inline pgd_t *asi_pgd(struct asi *asi)
+{
+	return asi ? asi->pgd : NULL;
+}
+
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
+#endif /* _ASM_X86_ASI_H */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 690fbf48e8538b62a176ce838820e363575b7897..89ade7363798cc20d5e5643526eba7378174baa0 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
+obj-$(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION)		+= asi.o
 
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
new file mode 100644
index 0000000000000000000000000000000000000000..e5a981a7b3192655cd981633514fbf945b92c9b6
--- /dev/null
+++ b/arch/x86/mm/asi.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/asi.h>
+
+static __aligned(PAGE_SIZE) pgd_t asi_global_nonsensitive_pgd[PTRS_PER_PGD];
+
+struct asi __asi_global_nonsensitive = {
+	.pgd = asi_global_nonsensitive_pgd,
+};
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 62aa4d66a032d59191e79d34fc0cdaa4f32f88db..44d3dc574881dd23bb48f9af3f6191be309405ef 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -250,7 +250,8 @@ static void __init probe_page_size_mask(void)
 	/* By the default is everything supported: */
 	__default_kernel_pte_mask = __supported_pte_mask;
 	/* Except when with PTI where the kernel is mostly non-Global: */
-	if (cpu_feature_enabled(X86_FEATURE_PTI))
+	if (cpu_feature_enabled(X86_FEATURE_PTI) ||
+	    IS_ENABLED(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION))
 		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
 
 	/* Enable 1 GB linear kernel mappings if available: */
diff --git a/include/linux/asi.h b/include/linux/asi.h
new file mode 100644
index 0000000000000000000000000000000000000000..2d3049d5fe423e139dcce8f3d68cdffcc0ec0bfe
--- /dev/null
+++ b/include/linux/asi.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _INCLUDE_ASI_H
+#define _INCLUDE_ASI_H
+
+#include <asm/pgtable_types.h>
+
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#include <asm/asi.h>
+#else
+
+#define ASI_GLOBAL_NONSENSITIVE NULL
+
+struct asi {};
+
+static inline pgd_t *asi_pgd(struct asi *asi) { return NULL; }
+
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+#endif /* _INCLUDE_ASI_H */

-- 
2.49.0.rc1.451.g8f38331e32-goog


