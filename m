Return-Path: <linux-kernel+bounces-445989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFD9F1E38
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FA81885007
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980CE18A92C;
	Sat, 14 Dec 2024 11:10:19 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D4170A13
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734174619; cv=none; b=RyIk15qfbobIHOotje7tbM5tGMTjXeBM0nK1hnQkmHmQApYjvkIKRlUuWGPMM6oH98cphcJaEiM8d28Bev9sCX274TgdmiVKAIR+LfGvr9Ju5LSYgMt8r5x7aE745X80CIF6i3ptPdS0cwrowzvOo9xfBTxeuF4eg/qI6WWeqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734174619; c=relaxed/simple;
	bh=Id6VnkfkemUObNZrJoyLbuxhi3EqAsU20mkXAySK750=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTqVAV9sD2PygFRgaqpdVdSo6eNWS6WDCkG5ZmPXlsp58XO5gbFSGIYkoz8gUhXT6JDDLl0F8ongcs7f1s6YjolRZ/7x6tNIWbgTzbqqaD0cJvp7BmkulZtJXsfwhv6Vf3M6j/+KwQIt3XxwqYi8Vj4sGJfwBKvxc9fv6zg/esY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y9Nlk4CDZz9str;
	Sat, 14 Dec 2024 12:10:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPm7RNNVorGo; Sat, 14 Dec 2024 12:10:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y9Nlk3PCxz9stm;
	Sat, 14 Dec 2024 12:10:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 602158B764;
	Sat, 14 Dec 2024 12:10:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ORiar0U6Uyif; Sat, 14 Dec 2024 12:10:10 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F33D58B763;
	Sat, 14 Dec 2024 12:10:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: Mark the vDSO code read-only after init
Date: Sat, 14 Dec 2024 12:09:31 +0100
Message-ID: <e9892d288b646cbdfeef0b2b73edbaf6d3c6cabe.1734174500.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734174572; l=1376; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Id6VnkfkemUObNZrJoyLbuxhi3EqAsU20mkXAySK750=; b=BkUWT8O9VnSeJAtYPHRuUCKVQNbICBP9Qw5Ri8RHqimnXtai2Qj6qHyFuNzZ+iGMHDfNHnziB 3d2nMQnnn4WCUXQhT1vkDT0vPhW1vFPQhNF3QEARosbKaKsRDvOebKz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

VDSO text is fixed-up during init so it can't be const,
but it can be read-only after init.

Do the same as x86 in commit 018ef8dcf3de ("x86/vdso: Mark the vDSO
code read-only after init") and arm in commit 11bf9b865898 ("ARM/vdso:
Mark the vDSO code read-only after init"), move it into
ro_after_init section.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso32_wrapper.S | 2 +-
 arch/powerpc/kernel/vdso64_wrapper.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32_wrapper.S b/arch/powerpc/kernel/vdso32_wrapper.S
index 10f92f265d51..20bca3548b44 100644
--- a/arch/powerpc/kernel/vdso32_wrapper.S
+++ b/arch/powerpc/kernel/vdso32_wrapper.S
@@ -2,7 +2,7 @@
 #include <linux/linkage.h>
 #include <asm/page.h>
 
-	__PAGE_ALIGNED_DATA
+	.section ".data..ro_after_init", "aw"
 
 	.globl vdso32_start, vdso32_end
 	.balign PAGE_SIZE
diff --git a/arch/powerpc/kernel/vdso64_wrapper.S b/arch/powerpc/kernel/vdso64_wrapper.S
index 839d1a61411d..1912936fa227 100644
--- a/arch/powerpc/kernel/vdso64_wrapper.S
+++ b/arch/powerpc/kernel/vdso64_wrapper.S
@@ -2,7 +2,7 @@
 #include <linux/linkage.h>
 #include <asm/page.h>
 
-	__PAGE_ALIGNED_DATA
+	.section ".data..ro_after_init", "aw"
 
 	.globl vdso64_start, vdso64_end
 	.balign PAGE_SIZE
-- 
2.47.0


