Return-Path: <linux-kernel+bounces-240604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19802926F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B721F21351
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFD1A08C4;
	Thu,  4 Jul 2024 06:30:27 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1F1DA32D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074626; cv=none; b=Rp9BcCh3BlWqCv8LWvSfMdMpdjiwkYg55vFAxEbOTrNGYNMEhxBTXBpfJp9pSdEKxqeV7K8vPGmjnMfJbKIrG5fJlwMAN7NxQk83fOu1jEjEYkiu+ASfxbUt9YBG3seYP8xqQz559IneA5PK+7ZU1PFih/WC9f5uTzn2dsqXgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074626; c=relaxed/simple;
	bh=Qtio/5SWrxR4yNgLMS59Jf0uRJ+1ynjUQGU6piFtlq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HELHvdkLUcKWLcRVtd1YrXKZ2EofDyeuP0y90l3BwGKhSGu1LxW19sonAH3qFwFftPeg7lnLMKiEYLPCmsMTSyyclHku5ew5GTKgzKVxRHa5C7vd1/8qQvJiGpIz7HURW9p2smH3g99r1l4YnxZEt98oxU15mYmzU84W2k0GPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WF6Fv1xlNz9sS8;
	Thu,  4 Jul 2024 08:30:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzQAq9F0VSsR; Thu,  4 Jul 2024 08:30:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WF6Fs5QfBz9sRy;
	Thu,  4 Jul 2024 08:30:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A8A5D8B774;
	Thu,  4 Jul 2024 08:30:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jUYe5UpM6zxp; Thu,  4 Jul 2024 08:30:09 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.202.46])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 049628B764;
	Thu,  4 Jul 2024 08:30:08 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/3] mm: Add p{g/4}d_leaf() in asm-generic/pgtable-nop{4/u}d.h
Date: Thu,  4 Jul 2024 08:30:05 +0200
Message-ID: <c8cb83b709740f7ac835997b88c5ddda610f66ab.1720074307.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <b601e1a88e3a5d4d93b130fa20184b555e2a2bea.1720074307.git.christophe.leroy@csgroup.eu>
References: <b601e1a88e3a5d4d93b130fa20184b555e2a2bea.1720074307.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720074605; l=2466; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Qtio/5SWrxR4yNgLMS59Jf0uRJ+1ynjUQGU6piFtlq0=; b=azkcAf3wdFGcbqU1O5vMt5uKoTHRw3KHARwsWzN1kcj9JA/2Zqkg3tgnO+WN7dI+hkpsqGuyU Ek7ifyQRmn6BRdM6oZNuS29ECHniE5zPf7j4PVxqF0C1xeD9cC9pPk1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h

Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
erroneously defined by architectures that do not implement the
related page level.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/pgtable-nop4d.h | 1 +
 include/asm-generic/pgtable-nopud.h | 1 +
 include/linux/pgtable.h             | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd4..75c96bbc5a96 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -21,6 +21,7 @@ typedef struct { pgd_t pgd; } p4d_t;
 static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
+static inline int pgd_leaf(pgd_t pgd)		{ return 0; }
 static inline void pgd_clear(pgd_t *pgd)	{ }
 #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
 
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff..14aeb8ef2d8a 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -28,6 +28,7 @@ typedef struct { p4d_t p4d; } pud_t;
 static inline int p4d_none(p4d_t p4d)		{ return 0; }
 static inline int p4d_bad(p4d_t p4d)		{ return 0; }
 static inline int p4d_present(p4d_t p4d)	{ return 1; }
+static inline int p4d_leaf(p4d_t p4d)		{ return 0; }
 static inline void p4d_clear(p4d_t *p4d)	{ }
 #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..b27e66f542d6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1882,13 +1882,13 @@ typedef unsigned int pgtbl_mod_mask;
  * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
  *   pXd_devmap(), or hugetlb mappings).
  */
-#ifndef pgd_leaf
+#if !defined(__PAGETABLE_P4D_FOLDED) && !defined(pgd_leaf)
 #define pgd_leaf(x)	false
 #endif
-#ifndef p4d_leaf
+#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(p4d_leaf)
 #define p4d_leaf(x)	false
 #endif
-#ifndef pud_leaf
+#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(pud_leaf)
 #define pud_leaf(x)	false
 #endif
 #ifndef pmd_leaf
-- 
2.44.0


