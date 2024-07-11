Return-Path: <linux-kernel+bounces-249159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C892E7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF351C23786
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DECB15ADB4;
	Thu, 11 Jul 2024 12:00:10 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F887143732
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699210; cv=none; b=mA5/Hd8DN6wDSlOlyX43xXNR+F22Gq1AHSqgcbxBu0VTDW5xbOsPYWWMcmFvw6kzvn6cfPgYIvTmSHPKKxpM3ft0/vXGebyWaBrofnAqmrnQtQqbgDICGhIzRnzXlGeFz1TKBYT6YiVqKOxBQr6Vl7aZIWLrZIKGdkxeX8cFYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699210; c=relaxed/simple;
	bh=VUlW/WnmW3lWWbXuUUb9fXEDL6iAgxyqWAXlpog9Zjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMk5m0pXFQu/GgkpndShoUj5i1JrwTimwibymwndnTCO5BH2iAR9jredVsRPUS6CuGNXxIXYgR7XqhQB2HQfKGBnlrsAPe4YS52W0HoOcfqVSsPoKExyVxXTHBQz8+PMt27q++6SLUa5Uk9EDAIpzPXGiHF95CMMEuAamnLZ7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WKYFL0wCwz9sSb;
	Thu, 11 Jul 2024 14:00:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sjtJxhZbc-EP; Thu, 11 Jul 2024 14:00:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WKYFL06F7z9sSY;
	Thu, 11 Jul 2024 14:00:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E98E78B778;
	Thu, 11 Jul 2024 14:00:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DnbBgMBVviD7; Thu, 11 Jul 2024 14:00:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.107])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F8948B764;
	Thu, 11 Jul 2024 14:00:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] Fixup for "mm: Remove pud_user() from asm-generic/pgtable-nopmd.h"
Date: Thu, 11 Jul 2024 14:00:03 +0200
Message-ID: <8870f6f84e611bbd3feeed7589c9db69fd6675dc.1720699192.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720699204; l=1378; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VUlW/WnmW3lWWbXuUUb9fXEDL6iAgxyqWAXlpog9Zjo=; b=HgQEB+jy1GuN8G7qy2mbADJiQNfg80tpEQ4+y36hghfbE/ndSQH/W9O8PkhkdrLES0S72Fllp n/jdy4hgWbPDckhJO/41aTQ2VUPKhFvkoV5iQXwVnxi3yFq0sO2eZnZ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

A stub pud_user() is also required for ARM64 after commit ed928a3402d8 ("arm64/mm: fix page table check compile error for CONFIG_PGTABLE_LEVELS=2")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202407111706.tTA6kPdD-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C7caf923d5d4a4ca5600708dca18a1c35%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638562861750514044%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=0BzPf75jJH9ok%2Bg69kthE24pZHTSoKfGBzpZEA2U91M%3D&reserved=0
---
 arch/arm64/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..c818b3328704 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -812,6 +812,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #define pud_valid(pud)		false
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
+#define pud_user		false /* Always 0 with folding */
 #define pud_user_exec(pud)	pud_user(pud) /* Always 0 with folding */
 
 /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
-- 
2.44.0


