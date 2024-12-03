Return-Path: <linux-kernel+bounces-430072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FF9E2CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F673B329B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54073204F6C;
	Tue,  3 Dec 2024 19:46:42 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F31FF7C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255201; cv=none; b=fDuQM022dpyeVsxNMKwyd3S4ebKVFndZkaYNJXt7kJXIB5G6S7mzUaKG1lkpxwTXBh77HFgtva4vYEOaPS2NKhpdnJCI9z1q0/m3D9kfNtKleYak5BXn0MzPawn7dctU3Tu6pEFrGkosMqGJRGc5ADNfoJUjC+FfUEFzCFgjP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255201; c=relaxed/simple;
	bh=w7NfWT76IPUH9paNfP5yUZDDBPDoYj5iPurgT8mFaks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxEZ6Kf8I7WnUlxjVha9dYEegonsRo6jUO4WO9Loack67Dze9pUq/SwFBjSNzVz/9yk4X46TfyCd/yab1pQqbgWSUpUTbw8q1ELA8ro87/l9W5uy1n89gWSpEtrYrsCUoQhj4xEIrES9lFqHmN+PMoetF96sy4/WPCmtcdjR7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rkX2QyNz9stL;
	Tue,  3 Dec 2024 20:46:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwoS2xF3MyfF; Tue,  3 Dec 2024 20:46:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rkV5pZyz9stJ;
	Tue,  3 Dec 2024 20:46:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B26FB8B763;
	Tue,  3 Dec 2024 20:46:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Rf4C0-DpdxVp; Tue,  3 Dec 2024 20:46:26 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E48148B76C;
	Tue,  3 Dec 2024 20:46:25 +0100 (CET)
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
Subject: [PATCH v4 3/4] powerpc: Prepare arch_static_call_transform() for supporting inline static calls
Date: Tue,  3 Dec 2024 20:44:51 +0100
Message-ID: <7a8b9245e773307c315c2548a4c6cad570ac2648.1733245362.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733245362.git.christophe.leroy@csgroup.eu>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255162; l=2238; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=w7NfWT76IPUH9paNfP5yUZDDBPDoYj5iPurgT8mFaks=; b=UOFid3geEIRWDqJio8hU372DJOg+8AyEgiUGBUMnBXwKYm/SVRPlnDeDmt1++gQNbOeuTqlfr sf+HWoDWPi6ADxLk81h3DPc5/BrTjlhwlf1wNxG/vL53eylhLICuWGI
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Reorganise arch_static_call_transform() in order to ease the support
of inline static calls in following patch:
- remove 'target' to nhide whether it is a 'return 0' or not.
- Don't bail out if 'tramp' is NULL, just do nothing until next patch.

Note that 'target' was 'tramp + PPC_SCT_RET0', is_short was perforce
true. So in the 'if (func && !is_short)' leg, target was perforce
equal to 'func'.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/static_call.c | 36 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/static_call.c b/arch/powerpc/kernel/static_call.c
index 7cfd0710e757..1b106fbcc567 100644
--- a/arch/powerpc/kernel/static_call.c
+++ b/arch/powerpc/kernel/static_call.c
@@ -8,26 +8,32 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	int err;
 	bool is_ret0 = (func == __static_call_return0);
-	unsigned long target = (unsigned long)(is_ret0 ? tramp + PPC_SCT_RET0 : func);
-	bool is_short = is_offset_in_branch_range((long)target - (long)tramp);
-
-	if (!tramp)
-		return;
+	unsigned long _tramp = (unsigned long)tramp;
+	unsigned long _func = (unsigned long)func;
+	unsigned long _ret0 = _tramp + PPC_SCT_RET0;
+	bool is_short = is_offset_in_branch_range((long)func - (long)(site ? : tramp));
 
 	mutex_lock(&text_mutex);
 
-	if (func && !is_short) {
-		err = patch_ulong(tramp + PPC_SCT_DATA, target);
-		if (err)
-			goto out;
+	if (tramp) {
+		if (func && !is_short) {
+			err = patch_ulong(tramp + PPC_SCT_DATA, _func);
+			if (err)
+				goto out;
+		}
+
+		if (!func)
+			err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
+		else if (is_ret0)
+			err = patch_branch(tramp, _ret0, 0);
+		else if (is_short)
+			err = patch_branch(tramp, _func, 0);
+		else
+			err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
+	} else {
+		err = 0;
 	}
 
-	if (!func)
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
-	else if (is_short)
-		err = patch_branch(tramp, target, 0);
-	else
-		err = patch_instruction(tramp, ppc_inst(PPC_RAW_NOP()));
 out:
 	mutex_unlock(&text_mutex);
 
-- 
2.47.0


