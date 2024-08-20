Return-Path: <linux-kernel+bounces-294404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E85958D47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DA61C22211
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967551C7B99;
	Tue, 20 Aug 2024 17:24:58 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5B1BD4F7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174698; cv=none; b=QL6Lha6KyBFcSgonN93Xd6WoQT1NTZOPKxfPmW5CN2nXeo51G9N8uHDOSm+TWQ55pFEEldRbZZVKExqY6r2frx4Jnf1Q5VTX0fYHxstjl0dkDdYA3rSmEY+Vr7dW3gZ8vPTvH9+sxr6mjEDbsTuorLDo/jo3JJeYMHNV2IsMT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174698; c=relaxed/simple;
	bh=QghUhOLt+fDy9xXI8MShWpF744dR2KvB7NG7dru6wKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpeiQbwlOA0iK0t7RROt/8KL8+3jKd6CCyZdLSSdvF9G0eQME12M2b3jInKT70dlVq0GJ0OfFzFxHvOWwIz6TZWiZo15TcLngfJNSRpSeKf+FbienBWOdBkzgjZRU7cZ4l5mWcXQDP+sUsxa7vAbahwYGxzDGwy8dYu+YaR6a1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYD28fbz9sSK;
	Tue, 20 Aug 2024 19:24:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrWW9xR0OynL; Tue, 20 Aug 2024 19:24:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY81ckQz9sSH;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 236178B763;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6wQq5cqY-1b6; Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B9B718B778;
	Tue, 20 Aug 2024 19:24:27 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/14] powerpc/8xx: Preallocate execmem page tables
Date: Tue, 20 Aug 2024 19:23:51 +0200
Message-ID: <a7180cc1ba59dec4502af39b4e9f3ff91c57280d.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=1364; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=QghUhOLt+fDy9xXI8MShWpF744dR2KvB7NG7dru6wKs=; b=p35/7MeKFXvgWyw2nEkxBbdlQ/EimXZx64Q3oIz5HccSchZVwnSLo9VqIT+2ie4PJqnwy0CBM wGbwiXC+Im9DQU8vhoxf5GVY4XAn8kKqGJLJAZj38ttVcn5z0ZgbKfR
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Preallocate execmem page tables before creating new PGDs so that
all PGD entries related to execmem can be copied in pgd_alloc().

On 8xx there are 32 Mbytes for execmem by default so this will use
32 kbytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index da21cb018984..5495572b42e6 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -410,6 +410,18 @@ EXPORT_SYMBOL_GPL(walk_system_ram_range);
 #ifdef CONFIG_EXECMEM
 static struct execmem_info execmem_info __ro_after_init;
 
+#ifdef CONFIG_PPC_8xx
+static void prealloc_execmem_pgtable(void)
+{
+	unsigned long va;
+
+	for (va = ALIGN_DOWN(MODULES_VADDR, PGDIR_SIZE); va < MODULES_END; va += PGDIR_SIZE)
+		pte_alloc_kernel(pmd_off_k(va), va);
+}
+#else
+static void prealloc_execmem_pgtable(void) { }
+#endif
+
 struct execmem_info __init *execmem_arch_setup(void)
 {
 	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
@@ -441,6 +453,8 @@ struct execmem_info __init *execmem_arch_setup(void)
 	end = VMALLOC_END;
 #endif
 
+	prealloc_execmem_pgtable();
+
 	execmem_info = (struct execmem_info){
 		.ranges = {
 			[EXECMEM_DEFAULT] = {
-- 
2.44.0


