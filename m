Return-Path: <linux-kernel+bounces-530728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33FFA43790
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034A618983C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE6264F94;
	Tue, 25 Feb 2025 08:20:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7225EF95
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471608; cv=none; b=FBKShFqa4oVxjLUhxffKu4gOyujOpWZW7KCQ8s9tbaQpt2X+1b+o9XIRdYOhpLtZ5exv2j/KFyLQIWuzW6/7kcQmdVfQ1UZX2UsOQC80DIA40EmZem5g/PFbPBuUwEf5Rzzlk8oJLtfbqXrN7S1Ypcv9FT2uHCZLriTCgOT3Azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471608; c=relaxed/simple;
	bh=8JbHItkDNTqx7ppT/iSayCN1jPwzTMbHToRWPnGXZ+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh3yOI5r3JIx8ErxMrYQtXNsrzb2IXl1/rJxekBVUl0MnHTb0cPpMcSnL/tSkKs5wDK1Rp8f43TqCJ08Pf/SrYwa/0+9QDJeSvW4GtCfZBwGQyUsETbgUIxKxEtLkgf5EktQ6kXJTw69ofBkIjNOX653MZsbdaYu4QHENWUEWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z29CQ5nnmz9sSd;
	Tue, 25 Feb 2025 09:05:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOg3G3RLLwfI; Tue, 25 Feb 2025 09:05:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z29CM62YDz9sSY;
	Tue, 25 Feb 2025 09:05:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B84C28B780;
	Tue, 25 Feb 2025 09:05:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0Az_q5mFkqk4; Tue, 25 Feb 2025 09:05:51 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0385A8B77C;
	Tue, 25 Feb 2025 09:05:50 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Segher Boessenkool <segher@kewrnel.crashing.org>
Subject: [PATCH v5 2/4] objtool/powerpc: Add support for decoding all types of uncond branches
Date: Tue, 25 Feb 2025 09:05:49 +0100
Message-ID: <bf0b4d554547bc34fa3d1af5b4e62a84c0bc182b.1740470510.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <0ca71a4b0ac679ea52bd9fdd1f607195d72b499f.1733245362.git.christophe.leroy@csgroup.eu>
References: <cover.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740470749; l=1915; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=8JbHItkDNTqx7ppT/iSayCN1jPwzTMbHToRWPnGXZ+8=; b=kDGs0rx51ssFnmq55d2aoKmsBU2DAAmDzguoyq3tyjbjJbM4jrsG8ij4o0PNedE9Vme8j9BUr x0rsWe/Na1UAXrX4N8/CmGrpflO/ZQFmsAwWzcfysb78yw/g0I16gKg
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Add support for 'bla' instruction.

This is done by 'flagging' the address as an absolute address so that
arch_jump_destination() can calculate it as expected. Because code is
_always_ 4 bytes aligned, use bit 30 as flag.

Also add support for 'b' and 'ba' instructions. Objtool call them jumps.

And make sure the special 'bl .+4' used by clang in relocatable code is
not seen as an 'unannotated intra-function call'. clang should use the
special 'bcl 20,31,.+4' form like gcc but for the time being it does not
so lets work around that.

Link: https://github.com/llvm/llvm-project/issues/128644
Reviewed-by: Segher Boessenkool <segher@kewrnel.crashing.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: Add a special case for clang to ignore 'bl .+4' form.
---
 tools/objtool/arch/powerpc/decode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 53b55690f320..26d5050424a9 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -55,12 +55,17 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 	switch (opcode) {
 	case 18: /* b[l][a] */
-		if ((ins & 3) == 1) /* bl */
+		if (ins == 0x48000005)	/* bl .+4 */
+			typ = INSN_OTHER;
+		else if (ins & 1)	/* bl[a] */
 			typ = INSN_CALL;
+		else		/* b[a] */
+			typ = INSN_JUMP_UNCONDITIONAL;
 
 		imm = ins & 0x3fffffc;
 		if (imm & 0x2000000)
 			imm -= 0x4000000;
+		imm |= ins & 2;	/* AA flag */
 		break;
 	}
 
@@ -77,6 +82,9 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 unsigned long arch_jump_destination(struct instruction *insn)
 {
+	if (insn->immediate & 2)
+		return insn->immediate & ~2;
+
 	return insn->offset + insn->immediate;
 }
 
-- 
2.47.0


