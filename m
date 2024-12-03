Return-Path: <linux-kernel+bounces-430071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9809E2C45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD3B282D62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080322036EB;
	Tue,  3 Dec 2024 19:46:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F91FF60C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255197; cv=none; b=hR9gMbYGAkweTKvsEkIgKLh+q98h5SHlhBXx9dpvKWu6ZF2E+yiO2KzenMeHJbnTZb5OlJpaHG+6Oot04azGPRHyA++IRl2LH3V3nEsYj097wuZxjwnU9OV+v12DZWCfmdhp8LSWuAVgODaUGzV0+fuzkm7P6uulayFS5lSIG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255197; c=relaxed/simple;
	bh=rkc6rbl9zc2WEtrRWE9QRdGj1KrdadCRvxADO58Yds0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlmslLzQrJHXDenQmM22pNz5Jph/6Y4HplU6P518RGXdSiGiWEMmwHlSf0Dx8Ez+E6FWS1nyypC0nHh2wYUKDBdIDZN3MqzrNYVjscxDG96iDY68iEYDHG3EHzSD84vMBeoSOR6j9KKJ1Q0duqkFZ87oCxAawldfhXKlWS5KZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rkV1Dg1z9stH;
	Tue,  3 Dec 2024 20:46:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aV_W0aAXLTr7; Tue,  3 Dec 2024 20:46:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rkV0Sl9z9stD;
	Tue,  3 Dec 2024 20:46:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E2E0B8B763;
	Tue,  3 Dec 2024 20:46:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SLEBpkwrXIB1; Tue,  3 Dec 2024 20:46:25 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 243048B767;
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
Subject: [PATCH v4 2/4] objtool/powerpc: Add support for decoding all types of uncond branches
Date: Tue,  3 Dec 2024 20:44:50 +0100
Message-ID: <0ca71a4b0ac679ea52bd9fdd1f607195d72b499f.1733245362.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733245362.git.christophe.leroy@csgroup.eu>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255162; l=1411; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=rkc6rbl9zc2WEtrRWE9QRdGj1KrdadCRvxADO58Yds0=; b=MUTxe8REiHlw+JI/+u8V3K4lDnK/5EtJEVeqBc6ax4BfVURzLhLCDA5tDY/ZXNLL09g8PwuEo 4I2ho4Wdd6PCfriQVC/4QrKAKoaSfaqZq4Pz3Z0LEHDb7gyYbbbNSI5
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Add support for 'bla' instruction.

This is done by 'flagging' the address as an absolute address so that
arch_jump_destination() can calculate it as expected. Because code is
_always_ 4 bytes aligned, use bit 30 as flag.

Also add support for 'b' and 'ba' instructions. Objtool call them jumps.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/arch/powerpc/decode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 53b55690f320..c1228fef3dec 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -55,12 +55,15 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 	switch (opcode) {
 	case 18: /* b[l][a] */
-		if ((ins & 3) == 1) /* bl */
+		if (ins & 1)	/* bl[a] */
 			typ = INSN_CALL;
+		else		/* b[a] */
+			typ = INSN_JUMP_UNCONDITIONAL;
 
 		imm = ins & 0x3fffffc;
 		if (imm & 0x2000000)
 			imm -= 0x4000000;
+		imm |= ins & 2;	/* AA flag */
 		break;
 	}
 
@@ -77,6 +80,9 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 unsigned long arch_jump_destination(struct instruction *insn)
 {
+	if (insn->immediate & 2)
+		return insn->immediate & ~2;
+
 	return insn->offset + insn->immediate;
 }
 
-- 
2.47.0


