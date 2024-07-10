Return-Path: <linux-kernel+bounces-247183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09592CC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA62859C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F5212A14C;
	Wed, 10 Jul 2024 07:51:53 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC584A21
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597912; cv=none; b=SRTa7Ddr557crq503v1gIw1SKwMToHLXYUC04C4nPuPm2mrbfHZDf7vHZyI2IK9qaPHoGc3k+odkutLrUi3KXCrPf0+ht6ia/xQ1HhA/dvSuzMv+lDUCIroxGsAiuxTY80emH6MoAYjXNnnwBalYzIrxdE6nq+v+TP7xxgjt+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597912; c=relaxed/simple;
	bh=KrmMH7bKbT2qDBAZ6LB+t1vXN/9qd6MtCCjJv9qO9v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmqdY6NQCuGemGzuRZ25W3MZj4yZ6l4GUOqhhgKi5Rk9BzK0mUMAlzRp5pHlxSU5pWA8oWEnpFK2UTCJKISb4CzyKY4QhDCqSbKs/nD+i+BGmAT5LE8nJmLKNscxruGpGzmprDB5BsAAu5NSV2aQS1o4BtvpkVJscMRcO8cnzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WJqn86kSVz9sT0;
	Wed, 10 Jul 2024 09:51:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DO_FCbpqAp2z; Wed, 10 Jul 2024 09:51:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WJqmw5Xm4z9sTL;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AEAED8B778;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id F75U0umoaS2G; Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.26])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EC4A8B766;
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
Subject: [PATCH v2 3/3] mm: Add p{g/4}d_leaf() in asm-generic/pgtable-nop{4/u}d.h
Date: Wed, 10 Jul 2024 09:51:22 +0200
Message-ID: <f69941b076bf8fec89b6bec5573fdb79483c2a75.1720597744.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720597882; l=2461; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=KrmMH7bKbT2qDBAZ6LB+t1vXN/9qd6MtCCjJv9qO9v0=; b=pGaWWJEGDivcTq/5LpqkCHIxHohVMbXxhf5suF8mh+EeYylaNrKQXv2k5AEG2JkUQc5H3Jal6 i+vMA84HOjbCpusC+m6HDo5+DieuE1RR+YB2uewJR0SbO5l1KYE5xsN
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h

Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
erroneously defined by architectures that do not implement the
related page level.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Added pXd_leaf macro as well in asm-generic/pgtable-nopXd.h to cohabit with the fallback
---
 include/asm-generic/pgtable-nop4d.h | 2 ++
 include/asm-generic/pgtable-nopmd.h | 1 +
 include/asm-generic/pgtable-nopud.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd4..ed7ba008469f 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -21,6 +21,8 @@ typedef struct { pgd_t pgd; } p4d_t;
 static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
+static inline int pgd_leaf(pgd_t pgd)		{ return 0; }
+#define pgd_leaf pgd_leaf
 static inline void pgd_clear(pgd_t *pgd)	{ }
 #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
 
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index b01349a312fa..e178ace2e23e 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -31,6 +31,7 @@ static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
+#define pud_leaf pud_leaf
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
 
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff..655dfebea91c 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -28,6 +28,8 @@ typedef struct { p4d_t p4d; } pud_t;
 static inline int p4d_none(p4d_t p4d)		{ return 0; }
 static inline int p4d_bad(p4d_t p4d)		{ return 0; }
 static inline int p4d_present(p4d_t p4d)	{ return 1; }
+static inline int p4d_leaf(p4d_t p4d)		{ return 0; }
+#define p4d_leaf p4d_leaf
 static inline void p4d_clear(p4d_t *p4d)	{ }
 #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
 
-- 
2.44.0


