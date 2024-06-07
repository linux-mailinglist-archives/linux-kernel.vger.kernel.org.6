Return-Path: <linux-kernel+bounces-206697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B6900CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC4C1F210CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B2155399;
	Fri,  7 Jun 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0npk3eVU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAOWJZp1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEF1527BC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791740; cv=none; b=N3ogryFuRRBwCr5jYAh6nAGHqB9fOEMbBBCpfL1dBBsCtJYP7PyTL1sB/4JHlSY5LES0vW6ePvrpV/AnL+p9qMFSdTk8DFNWSWwRaQklpkI63yEhQrC3dQzTmjOptr0SvwXr9FA1wg/CcXNIBQHLzD0o+IDQvpBv2otjujUtQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791740; c=relaxed/simple;
	bh=b3kfaE3B5DqZl7RCPFsX8KN1jUPY+NVq9KI1mO6MnV8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCK3f0py09WEzGocR3R68zfHckPQdYvHQJ5MfSzpFmfi7Y8fK/xS0sKHkIRd2vMJaWXPTmWsmHIkiCaheOxHs7ytE08ROll7STybeYi49g9RT5GNui/5tB7m9Zyd3iOjUPUhjy8rGJFCmZ5BSndPOl+l9iODRkkTnmZe7e6C0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0npk3eVU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAOWJZp1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlQGR+tGoioFd255pa4F2M3do0QPDjAAVJR0Ox/2Zbw=;
	b=0npk3eVUOmUI1nJgJEXVN/ccbreM702IcCn9WYf4K/Oxj9tGeMxddKkJDGTLsUd6jU2Hld
	86Xue89Ax+FDFdr9bi4qq0TZILDFEK4O0vrkSSqjw0jrpsUrochYd1ry6G8v8Lp3515Rpi
	9Cn3A2N9JjNeldDor7FOPGDDYDVkBHeClap9PF2sTvYFqwn/F7PxWsn+/8ABx8JEdvzbGE
	PX6YLMMZVGxgy+nAhy0qy6DK607Dm1xO0FXBnf5odNFkK+MwvNBSvHhaM36oP+IVSTu7R0
	rgtqlU1JZaXDFC4dQJbF6bx8ZEJ21UxJuL5aMpyOjGfOAkB7alyW5ynRxbMVXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlQGR+tGoioFd255pa4F2M3do0QPDjAAVJR0Ox/2Zbw=;
	b=pAOWJZp1PU/dlsrZNLVkbeFP89DsN/O4sOSeJ+S3UZsBgLwdnT58Oc5YLEFIvS5di+cZG4
	vW6wJ5f0wxgfC1Cg==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] riscv: remove limit on the size of read-only section for XIP kernel
Date: Fri,  7 Jun 2024 22:22:13 +0200
Message-Id: <3bf3a77be10ebb0d8086c028500baa16e7a8e648.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size. This causes
build failures if the kernel gets too big [1].

Remove this limit.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404211031.J6l2AfJk-lkp@intel.com [1]
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h    | 7 -------
 arch/riscv/include/asm/set_memory.h | 2 +-
 arch/riscv/kernel/vmlinux-xip.lds.S | 5 +++--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1bc103aa9b74..bf4afffe0c53 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -107,13 +107,6 @@
 
 #endif
 
-#ifdef CONFIG_XIP_KERNEL
-#define XIP_OFFSET		SZ_32M
-#define XIP_OFFSET_MASK		(SZ_32M - 1)
-#else
-#define XIP_OFFSET		0
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <asm/page.h>
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index ec11001c3fe0..ab92fc84e1fc 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -46,7 +46,7 @@ bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_XIP_KERNEL)
 #ifdef CONFIG_64BIT
 #define SECTION_ALIGN (1 << 21)
 #else
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index 8c3daa1b0531..a7611789bad5 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -14,6 +14,7 @@
 #include <asm/page.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
+#include <asm/set_memory.h>
 
 OUTPUT_ARCH(riscv)
 ENTRY(_start)
@@ -65,10 +66,10 @@ SECTIONS
  * From this point, stuff is considered writable and will be copied to RAM
  */
 	__data_loc = ALIGN(PAGE_SIZE);		/* location in file */
-	. = KERNEL_LINK_ADDR + XIP_OFFSET;	/* location in memory */
+	. = ALIGN(SECTION_ALIGN);		/* location in memory */
 
 #undef LOAD_OFFSET
-#define LOAD_OFFSET (KERNEL_LINK_ADDR + XIP_OFFSET - (__data_loc & XIP_OFFSET_MASK))
+#define LOAD_OFFSET (KERNEL_LINK_ADDR + _sdata - __data_loc)
 
 	_sdata = .;			/* Start of data section */
 	_data = .;
-- 
2.39.2


