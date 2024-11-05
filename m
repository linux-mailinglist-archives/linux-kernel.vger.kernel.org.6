Return-Path: <linux-kernel+bounces-396734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0A9BD162
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375A4284599
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8661DACA8;
	Tue,  5 Nov 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KupeMHV+"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0C1D89E2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822311; cv=none; b=JCK5Y1iiKbgFw3hi29VAZrDIqybdM9W7xPla1sYpY/kRxcJOyZ97u5OS9DgErOrsOwpvOZdvRzt/s9wSKAENXnV58Uomhl3qXapZsKX4mIcp1CbOzqO8iAb9Kpy/gHMF64nQLhWAceipgWKsPGo0JrOnJj3k0cRJRl60aV6XPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822311; c=relaxed/simple;
	bh=B8Gh4qRqNjfVPy5RrfT5smuqJzTShAUNOS01qUV3gCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZnAfAEyBSm1jihjeqcsCwKlP+k9a6Rz5118k6Hg6WARAh11geOrFyjL6hx8kGiIpxCIO4Nb2rqt7pmMDu++sG9uU1CvVEKigLWS9BWBSvvLQO/EjEf/NorjNdnzfvpORlFJyZPordeup1qYFuKcR1zXwTCA5IMXzOWy6bCIgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KupeMHV+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbcc2bd800so48319366d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822308; x=1731427108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiqzMq5ogq19Mry3xz2UGi6HbqnwquvC9QM8GIeB9g8=;
        b=KupeMHV+EtrJwErtoiqd5ZQS+T4Bl5HhdVUyaZ/NjY5kEqlE0Syt8WDiZszElzUc/2
         Id9v/gtKj46RH3HBUnzTdATW7psKVdX0gAZ5snJBNiGGSO55bYGaME1vT58DvXLa24zI
         OpFY0VVKJ4PHETtEGbfJ2B/7UsPysIUJDOm6eaekq4nBltnAFuUxfRJpbRkw+6sCeQTW
         tHXh8K2zVIe2fTXaHl0YS5H5xvKQZSTmPhgZF2X8gpj1ZMYQyUlX9Aya3Ai1NCfjHkao
         mDSL0PTlrev+xd9M9QCvXDb7I+8usnlrJbnRi9xjkJaGa8gj4iP/j6oLYld79xUwXNvj
         PlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822308; x=1731427108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiqzMq5ogq19Mry3xz2UGi6HbqnwquvC9QM8GIeB9g8=;
        b=nETIcbHTeN4tk9/kYyF5Dv/whB2kIErNvoXZBRLzkr3D7+4JdX2IlexnMn//m7R9Ea
         oBe8lOhYHLj5YQHIZiyAtqo4NwXRYBxfo6DYtiTK/g7aU9LdcOD2ALv8FQ9PVE0HD9AO
         6zuCQiiqW4ZqWrPpQ7ASF4mcKA0jMP20HMKQLO4B7i8m/e9ehgueZ/N//PadK7bHKSXG
         7brOBYAN56k7Cs6DXjqd47MxcEdJ6c/d4mpTzluj8Zc+KjJO6dwGerz8/ZGktw6HE+Yx
         NVD/GathpmPK47KAWzgfFaubfV4H7gpk1VcrwyecCOHLzbYQatl5qJBp1clHKDiva8ho
         rQbQ==
X-Gm-Message-State: AOJu0YzvY5kzN3ojoS500NFf9JqY5krLKx2EUTJBcnj9+D6oKDkSTmOt
	duXK4+z//dvcLuW/M+c5ogoq3g7rRmnnnb2uTRYZ8MBCWuiXXZBdXpNb
X-Google-Smtp-Source: AGHT+IFfdaOQHcuxYV9nMbUNrGTH6r6QvGpqPsMBZrQkSqY6KHUGnvdobomssGtbVK5q31tus/UKSg==
X-Received: by 2002:a0c:f90f:0:b0:6d3:6827:a7f6 with SMTP id 6a1803df08f44-6d36827ae92mr141878786d6.12.1730822308143;
        Tue, 05 Nov 2024 07:58:28 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:27 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 12/16] x86/percpu/64: Remove INIT_PER_CPU macros
Date: Tue,  5 Nov 2024 10:57:57 -0500
Message-ID: <20241105155801.1779119-13-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the load and link addresses of percpu variables are the same,
these macros are no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/desc.h   |  1 -
 arch/x86/include/asm/percpu.h | 22 ----------------------
 arch/x86/kernel/head64.c      |  2 +-
 arch/x86/kernel/irq_64.c      |  1 -
 arch/x86/kernel/vmlinux.lds.S |  7 -------
 arch/x86/tools/relocs.c       |  1 -
 6 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 62dc9f59ea76..ec95fe44fa3a 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,7 +46,6 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
-DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..1ded1207528d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,12 +20,6 @@
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
-#ifdef CONFIG_X86_64_SMP
-# define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
-#else
-# define INIT_PER_CPU_VAR(var)  var
-#endif
-
 #else /* !__ASSEMBLY__: */
 
 #include <linux/build_bug.h>
@@ -97,22 +91,6 @@
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-/*
- * Initialized pointers to per-CPU variables needed for the boot
- * processor need to use these macros to get the proper address
- * offset from __per_cpu_load on SMP.
- *
- * There also must be an entry in vmlinux_64.lds.S
- */
-#define DECLARE_INIT_PER_CPU(var) \
-       extern typeof(var) init_per_cpu_var(var)
-
-#ifdef CONFIG_X86_64_SMP
-# define init_per_cpu_var(var)  init_per_cpu__##var
-#else
-# define init_per_cpu_var(var)  var
-#endif
-
 /*
  * For arch-specific code, we can use direct single-insn ops (they
  * don't give an lvalue though).
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4b9d4557fc94..d4398261ad81 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -559,7 +559,7 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
-	struct desc_struct *gdt = (void *)(__force unsigned long)init_per_cpu_var(gdt_page.gdt);
+	struct desc_struct *gdt = (void *)(__force unsigned long)gdt_page.gdt;
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index ade0043ce56e..56bdeecd8ee0 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -27,7 +27,6 @@
 #include <asm/apic.h>
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_VMAP_STACK
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 859ff7c0dc02..fd1ecb1dbc1d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -450,13 +450,6 @@ SECTIONS
 PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
 
 #ifdef CONFIG_X86_64
-/*
- * Per-cpu symbols which need to be offset from __per_cpu_load
- * for the boot processor.
- */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
-INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 8d9e82748615..c3124aac7ab3 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -89,7 +89,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
 	"_end)$"
-- 
2.47.0


