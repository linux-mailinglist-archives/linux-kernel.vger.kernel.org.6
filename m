Return-Path: <linux-kernel+bounces-347167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0098CEED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4331C21428
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB29195962;
	Wed,  2 Oct 2024 08:39:35 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CB46BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858375; cv=none; b=AKt4fNpDUnuIJ3/NVNjKSxUWSQNBQ3mcBwvagmRhqPSuW9SmKDyxlJnSdT7101SDBMK+x6dJJmDWbWgyA5TK10i7O7IxxulzwR/EQyZYBng/UVAIwifnuOYiHF9I4HeHVVjpa9wq+94iCr6FKvy5cZ+IQ00rdVttlgAaSmNwbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858375; c=relaxed/simple;
	bh=2d6q09o9Jg03K1Fftd9k2eSsOwepxX3z7CwragHjdg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWkm5nP/90IM+nLKdrE5WYeEhpLjCvWioelVmty475DYH1dL1eAsHXO5p4TEpQsaG8CaGk3mRgE0B6R0H0eDyIAcmgtzMXG7Arj5FpNd4Sq1+7aEz/SYac+LenEkiYjmgz06k3ACcOO6oa2NhWsgx4+O/e/Rz1rlUJZPrtoKzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XJSsZ6wvTz9sPd;
	Wed,  2 Oct 2024 10:39:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9ZPkM7raCZc; Wed,  2 Oct 2024 10:39:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XJSsZ5g4Qz9rvV;
	Wed,  2 Oct 2024 10:39:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B01978B766;
	Wed,  2 Oct 2024 10:39:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id MwNwPOZZvBb2; Wed,  2 Oct 2024 10:39:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.39])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 64C358B763;
	Wed,  2 Oct 2024 10:39:30 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Jason@zx2c4.com
Subject: [PATCH 1/2] powerpc/vdso: Add a page for non-time data
Date: Wed,  2 Oct 2024 10:39:28 +0200
Message-ID: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727858369; l=7984; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2d6q09o9Jg03K1Fftd9k2eSsOwepxX3z7CwragHjdg4=; b=YjwygazVYJyYA37fR6nEx74Yzfej7/nibnrMl8wyMSLUBObqa9XjMc4W6iRSs/6OUylxDHOvL 64Gtto9HmwlAxvyvF37DtV2C+KzeSYR/rFZprsPOk9A1PsFqRbe/UD7
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The page containing VDSO time data is swapped with the one containing
TIME namespace data when a process uses a non-root time namespace.
For other data like powerpc specific data and RNG data, it means
tracking whether time namespace is the root one or not to know which
page to use.

Simplify the logic behind by moving time data out of first data page
so that the first data page which contains everything else always
remains the first page. Time data is in the second or third page
depending on selected time namespace.

While we are playing with get_datapage macro, directly take into
account the data offset inside the macro instead of adding that offset
afterwards.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso_datapage.h | 24 +++++++-----------------
 arch/powerpc/kernel/vdso.c               | 16 ++++++++++------
 arch/powerpc/kernel/vdso/cacheflush.S    |  2 +-
 arch/powerpc/kernel/vdso/datapage.S      |  4 ++--
 arch/powerpc/kernel/vdso/getrandom.S     |  3 +--
 arch/powerpc/kernel/vdso/gettimeofday.S  |  5 ++---
 arch/powerpc/kernel/vdso/vdso32.lds.S    |  2 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S    |  2 +-
 8 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 248dee138f7b..33069afccb3c 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -82,8 +82,9 @@ struct vdso_arch_data {
 	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
 	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
 
-	struct vdso_data data[CS_BASES];
 	struct vdso_rng_data rng_data;
+
+	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
 };
 
 #else /* CONFIG_PPC64 */
@@ -95,8 +96,9 @@ struct vdso_arch_data {
 	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
 	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
-	struct vdso_data data[CS_BASES];
 	struct vdso_rng_data rng_data;
+
+	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
 };
 
 #endif /* CONFIG_PPC64 */
@@ -105,29 +107,17 @@ extern struct vdso_arch_data *vdso_data;
 
 #else /* __ASSEMBLY__ */
 
-.macro get_datapage ptr
+.macro get_datapage ptr offset=0
 	bcl	20, 31, .+4
 999:
 	mflr	\ptr
-	addis	\ptr, \ptr, (_vdso_datapage - 999b)@ha
-	addi	\ptr, \ptr, (_vdso_datapage - 999b)@l
+	addis	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@ha
+	addi	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@l
 .endm
 
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 
-.macro get_realdatapage ptr scratch
-	get_datapage \ptr
-#ifdef CONFIG_TIME_NS
-	lwz	\scratch, VDSO_CLOCKMODE_OFFSET(\ptr)
-	xoris	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@h
-	xori	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@l
-	cntlzw	\scratch, \scratch
-	rlwinm	\scratch, \scratch, PAGE_SHIFT - 5, 1 << PAGE_SHIFT
-	add	\ptr, \ptr, \scratch
-#endif
-.endm
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index ee4b9d676cff..6166c1862c06 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -48,12 +48,13 @@ long sys_ni_syscall(void);
  */
 static union {
 	struct vdso_arch_data	data;
-	u8			page[PAGE_SIZE];
+	u8			page[2 * PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
 struct vdso_arch_data *vdso_data = &vdso_data_store.data;
 
 enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
+	VVAR_BASE_PAGE_OFFSET,
+	VVAR_TIME_PAGE_OFFSET,
 	VVAR_TIMENS_PAGE_OFFSET,
 	VVAR_NR_PAGES,
 };
@@ -119,7 +120,7 @@ static struct vm_special_mapping vdso64_spec __ro_after_init = {
 #ifdef CONFIG_TIME_NS
 struct vdso_data *arch_get_vdso_data(void *vvar_page)
 {
-	return ((struct vdso_arch_data *)vvar_page)->data;
+	return vvar_page;
 }
 
 /*
@@ -153,11 +154,14 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	unsigned long pfn;
 
 	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
+	case VVAR_BASE_PAGE_OFFSET:
+		pfn = virt_to_pfn(vdso_data);
+		break;
+	case VVAR_TIME_PAGE_OFFSET:
 		if (timens_page)
 			pfn = page_to_pfn(timens_page);
 		else
-			pfn = virt_to_pfn(vdso_data);
+			pfn = virt_to_pfn(vdso_data->data);
 		break;
 #ifdef CONFIG_TIME_NS
 	case VVAR_TIMENS_PAGE_OFFSET:
@@ -170,7 +174,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 */
 		if (!timens_page)
 			return VM_FAULT_SIGBUS;
-		pfn = virt_to_pfn(vdso_data);
+		pfn = virt_to_pfn(vdso_data->data);
 		break;
 #endif /* CONFIG_TIME_NS */
 	default:
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
index 3b2479bd2f9a..0085ae464dac 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_realdatapage	r10, r11
+	get_datapage	r10
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/datapage.S
index 2b19b6201a33..db8e167f0166 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_realdatapage	r3, r11
+	get_datapage	r3
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_realdatapage	r3, r11
+	get_datapage	r3
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
index f3bbf931931c..3deddcf89f99 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -31,8 +31,7 @@
 	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
-	get_realdatapage	r8, r11
-	addi		r8, r8, VDSO_RNG_DATA_OFFSET
+	get_datapage	r8 VDSO_RNG_DATA_OFFSET
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
 #ifdef __powerpc64__
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 5540d7021fa2..5333848322ca 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -32,11 +32,10 @@
 	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
-	get_datapage	r5
 	.ifeq	\call_time
-	addi		r5, r5, VDSO_DATA_OFFSET
+		get_datapage	r5 VDSO_DATA_OFFSET
 	.else
-	addi		r4, r5, VDSO_DATA_OFFSET
+		get_datapage	r4 VDSO_DATA_OFFSET
 	.endif
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 7b41d5d256e8..1a1b0b6d681a 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -16,7 +16,7 @@ OUTPUT_ARCH(powerpc:common)
 
 SECTIONS
 {
-	PROVIDE(_vdso_datapage = . - 2 * PAGE_SIZE);
+	PROVIDE(_vdso_datapage = . - 3 * PAGE_SIZE);
 	. = SIZEOF_HEADERS;
 
 	.hash          	: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index 9481e4b892ed..e21b5506cad6 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -16,7 +16,7 @@ OUTPUT_ARCH(powerpc:common64)
 
 SECTIONS
 {
-	PROVIDE(_vdso_datapage = . - 2 * PAGE_SIZE);
+	PROVIDE(_vdso_datapage = . - 3 * PAGE_SIZE);
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
-- 
2.44.0


