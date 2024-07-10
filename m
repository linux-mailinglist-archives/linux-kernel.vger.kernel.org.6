Return-Path: <linux-kernel+bounces-247182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4DF92CC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B760B1F23A24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323286267;
	Wed, 10 Jul 2024 07:51:48 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990184D25
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597908; cv=none; b=N76LfFGUk+vWE9r41ub8PBlQMdmSMYV/o8UxK4GvhEwf6XV5mevb2WmcdEFNwl/GJ5k7iJLRETYO9YkRkip90mZGTyAJFAreYS4Xad7gAws5GNj6KtJOghGb3QBBE/iZAcmZyuspjXj1AUBcUF0xO4PtDOYfWSZSML4UjtE4700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597908; c=relaxed/simple;
	bh=P+XptGl9DFkWiOOf5gEDy59BT6RaK29b7Gl+mTkrxXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5bNM42TFlI2pAvy9Ph7r/NQtorT0XpRsEj4h8l8+WLkZI70ruYTlpAAXHTyq3nD3W9q+qvof3lB6cAPJPh5JVJer65dklbxr1CbZm197DbuIrxM8p3CQm9HleYBRjxdyixCMUJoSwAUxHIyeLOcTOmdgmzp8/SporjCnOx2qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WJqn72Jh2z9sSy;
	Wed, 10 Jul 2024 09:51:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Msdeejhv638O; Wed, 10 Jul 2024 09:51:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WJqmw5HDpz9sTK;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 715EE8B779;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5aOEaBIr4O0c; Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.26])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 31AA68B778;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 2/3] mm: Remove pud_user() from asm-generic/pgtable-nopmd.h
Date: Wed, 10 Jul 2024 09:51:21 +0200
Message-ID: <c31a39463929daba6c91917598ec05cf47103af5.1720597744.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720597882; l=1658; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=P+XptGl9DFkWiOOf5gEDy59BT6RaK29b7Gl+mTkrxXs=; b=4OAIfRcbzGZiTThCn+52k1t3OLfWXpjONvRAqOB3CJHAKApZphNbftRQQVoK9x0oBHpC3u7Sh lQY8C28x+HSAHuZKfuXlBaRhY70+1c0WDh8lUCy4Op4atGDbaMZoNRm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
issues") added pud_user() in include/asm-generic/pgtable-nopmd.h

But pud_user() only exists on ARM64 and RISCV and is not expected
by any part of MM.

Add the missing definition in arch/riscv/include/asm/pgtable-32.h
and remove it from asm-generic/pgtable-nopmd.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/riscv/include/asm/pgtable-32.h | 5 +++++
 include/asm-generic/pgtable-nopmd.h | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 00f3369570a8..37878ef37466 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -36,4 +36,9 @@
 static const __maybe_unused int pgtable_l4_enabled;
 static const __maybe_unused int pgtable_l5_enabled;
 
+static inline int pud_user(pud_t pud)
+{
+	return 0;
+}
+
 #endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..b01349a312fa 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -30,7 +30,6 @@ typedef struct { pud_t pud; } pmd_t;
 static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
-static inline int pud_user(pud_t pud)		{ return 0; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
-- 
2.44.0


