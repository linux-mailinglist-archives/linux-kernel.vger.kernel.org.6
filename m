Return-Path: <linux-kernel+bounces-430073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B109E2C49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586DB1660D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83609204F8D;
	Tue,  3 Dec 2024 19:46:47 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3677204F7E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255207; cv=none; b=A1dLcH6a3vRp7ob3HQDlLSDatplEJv9noWCLm/Kz7AFOIwktn+vrkXwSF2S8mR4Oq37nlgvf7KPmKywGL709RL5ZMv+Y3C4Z76Uxb0B8Hos4FHeyey5BHeV0yxQAMnL2TfS+fRZp0kRrrZywPgJ550Ok8oUzwYYzPxV5ORAlrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255207; c=relaxed/simple;
	bh=zg0V8okVh2HcUM+I7hCx9fsftgdLb74b1p7T4df88FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdJhI9DtWj8rqlnaMrfUgTN8kmiHjdzuuMhgNZVV5MHUStHyQslmz7imFZjEoVLzFmm1wsGf+9p+mUpkOyiA6vQ4c5bMs5IvfvkInkfPND4tjIHOEwYJpSZd/7a802SMK8ehopWrl4JvbfPGPAPbLq+VMvjMmSlMq2W/+nTgtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rkY0ytrz9stJ;
	Tue,  3 Dec 2024 20:46:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1DaesogsHDn; Tue,  3 Dec 2024 20:46:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rkW4TSmz9stD;
	Tue,  3 Dec 2024 20:46:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 85FDF8B763;
	Tue,  3 Dec 2024 20:46:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xC4QlQoN6kLD; Tue,  3 Dec 2024 20:46:27 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B2B7B8B767;
	Tue,  3 Dec 2024 20:46:26 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/4] powerpc/static_call: Implement inline static calls
Date: Tue,  3 Dec 2024 20:44:52 +0100
Message-ID: <3dbd0b2ba577c942729235d0211d04a406653d81.1733245362.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733245362.git.christophe.leroy@csgroup.eu>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255162; l=2956; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=zg0V8okVh2HcUM+I7hCx9fsftgdLb74b1p7T4df88FM=; b=jSBMxVv18VlXpPuDupbIyS5plVVdoSdXqAPZOJsldhnjbLavWN3Ndh72UGg82KviTra0e+M3P hCKRZRhv9Q4AQVQ/dJOxisbTfOoMv6GCOPbkcYtTdTMX/qsmDcSOEJ0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Implement inline static calls:
- Put a 'bl' to the destination function ('b' if tail call)
- Put a 'nop' when the destination function is NULL ('blr' if tail call)
- Put a 'li r3,0' when the destination is the RET0 function and not
a tail call.

If the destination is too far (over the 32Mb limit), go via the
trampoline.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/static_call.h |  2 ++
 arch/powerpc/kernel/static_call.c      | 24 +++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a0ce777f9706..285bc1ae17dd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -282,6 +282,7 @@ config PPC
 	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,$(m32-flag) -mstack-protector-guard=tls -mstack-protector-guard-reg=r2 -mstack-protector-guard-offset=0)
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,$(m64-flag) -mstack-protector-guard=tls -mstack-protector-guard-reg=r13 -mstack-protector-guard-offset=0)
 	select HAVE_STATIC_CALL			if PPC32
+	select HAVE_STATIC_CALL_INLINE		if PPC32
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
diff --git a/arch/powerpc/include/asm/static_call.h b/arch/powerpc/include/asm/static_call.h
index de1018cc522b..e3d5d3823dac 100644
--- a/arch/powerpc/include/asm/static_call.h
+++ b/arch/powerpc/include/asm/static_call.h
@@ -26,4 +26,6 @@
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)	__PPC_SCT(name, "blr")
 #define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)	__PPC_SCT(name, "b .+20")
 
+#define CALL_INSN_SIZE		4
+
 #endif /* _ASM_POWERPC_STATIC_CALL_H */
diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 1b106fbcc567..ec3101f95e53 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -15,7 +15,29 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 
 	mutex_lock(&text_mutex);
 
-	if (tramp) {
+	if (site && tail) {
+		if (!func)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_BLR()));
+		else if (is_ret0)
+			err = patch_branch(site, _ret0, 0);
+		else if (is_short)
+			err = patch_branch(site, _func, 0);
+		else if (tramp)
+			err = patch_branch(site, _tramp, 0);
+		else
+			err = 0;
+	} else if (site) {
+		if (!func)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_NOP()));
+		else if (is_ret0)
+			err = patch_instruction(site, ppc_inst(PPC_RAW_LI(_R3, 0)));
+		else if (is_short)
+			err = patch_branch(site, _func, BRANCH_SET_LINK);
+		else if (tramp)
+			err = patch_branch(site, _tramp, BRANCH_SET_LINK);
+		else
+			err = 0;
+	} else if (tramp) {
 		if (func && !is_short) {
 			err = patch_ulong(tramp + PPC_SCT_DATA, _func);
 			if (err)
-- 
2.47.0


