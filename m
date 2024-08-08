Return-Path: <linux-kernel+bounces-279158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094F94B9B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A3B22035
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF2148FF9;
	Thu,  8 Aug 2024 09:33:04 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CCA84A51
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109584; cv=none; b=mxs0CL4Oa9CzEu7jRzvnWLoR7bxU5+dS/pqksyPYIvFVe7yeXlrlgcSK0okJRIG0v4KTIWbm2TPYYCcBoCMZDcjjHpQWGuS0+ea9a6szx5fNvvu8q3tZLVQmag0nCqgea6R3P62SHnmdwK+CbgwEU5Gl/KjuDdatd2aCrjA5szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109584; c=relaxed/simple;
	bh=cC+vGrMsk7qtfO7gPds0huUqn3FKXHJr45RkPS0DplI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mS8c/UoZRgRaTEb/Y72ABXCw74FNcf1/Lsg0JVoToBWFBLob1uCnJD7cwcXDTJhBHGpfn6PJnfalY68d+OzlCZr8+pTif4GJ7ax4nIx4y3GkCY+CaoRGuLOrPxgJN+c8m2WXq/TOv2bRumY/R/S8QLIZkasYUunONP25NAR+cwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wfhfh0zVNz9sPd;
	Thu,  8 Aug 2024 11:33:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3gIbBZXjQLT; Thu,  8 Aug 2024 11:33:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wfhfh0BYvz9rvV;
	Thu,  8 Aug 2024 11:33:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E77468B76C;
	Thu,  8 Aug 2024 11:32:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pOdydQ41dDJz; Thu,  8 Aug 2024 11:32:59 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.168])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 934C08B763;
	Thu,  8 Aug 2024 11:32:59 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] powerpc/mm: Fix size of allocated PGDIR
Date: Thu,  8 Aug 2024 11:32:47 +0200
Message-ID: <1cdaacb391cbd3e0240f0e0faf691202874e9422.1723109462.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723109568; l=1396; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=cC+vGrMsk7qtfO7gPds0huUqn3FKXHJr45RkPS0DplI=; b=r2P7zKGJF+IEFY9k2QKtbTHKpOZWiFOTES8xvq7+aDHEH2n9CBVuQlAuv4rxuHhecLDWrLg1I zG2GBs0U48ICqY3uwR2HTkQTe2L3iVLgP4/vo1lYmSAfH7ULavQyJ+M
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx
(32 bits)") increased the size of PGD entries but failed to increase
the PGD directory.

Use the size of pgd_t instead of the size of pointers to calculate
the allocated size.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx (32 bits)")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/init-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 9b4a675eb8f8..2978fcbe307e 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -73,7 +73,7 @@ void setup_kup(void)
 
 #define CTOR(shift) static void ctor_##shift(void *addr) \
 {							\
-	memset(addr, 0, sizeof(void *) << (shift));	\
+	memset(addr, 0, sizeof(pgd_t) << (shift));	\
 }
 
 CTOR(0); CTOR(1); CTOR(2); CTOR(3); CTOR(4); CTOR(5); CTOR(6); CTOR(7);
@@ -117,7 +117,7 @@ EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
 void pgtable_cache_add(unsigned int shift)
 {
 	char *name;
-	unsigned long table_size = sizeof(void *) << shift;
+	unsigned long table_size = sizeof(pgd_t) << shift;
 	unsigned long align = table_size;
 
 	/* When batching pgtable pointers for RCU freeing, we store
-- 
2.44.0


