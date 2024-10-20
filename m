Return-Path: <linux-kernel+bounces-373458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A78D9A56E3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23DD1F213A2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CA61FFE;
	Sun, 20 Oct 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Od33U5rZ"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E901953A2
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729457891; cv=none; b=sb2ixX0DYrEqiku/Sp8eytgPr2D5vHBfE0pC7PCQT2W2JdBAB2hnZ0BfWEQS/WHr+KkLjbGF0X1YYy9HBe2tNR6jCdw1n97lhC7w98VjhxDvX03o0FBBIdEWoz+3Dd2PSOpBgZBDFjJ+73AgCOOKJGX4D/0oK4YCpL1ZGXAM4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729457891; c=relaxed/simple;
	bh=EfxVEeGNDmujOulPWqcn08TjTzZJIo/THqWXncENQ90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqTI3BTVv5l440Lidm2vh/Fhc31FgDmy1xLZWbIPnwgncjA0UbxtxG5JkSJTLlOy7lAEIj9ocHxWQ1iTq8buOyZCOWQwOLY3P6vAfdPS9A2BjsFUzaqHyc23itpKU0+G1WaBuna9AUF8Gkaur6CF+Ar4jhZ+fJyq7ZyMzWqz/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Od33U5rZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729457887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jjJQZzYA3O4L685OlUDWu67kmoWLZnGrBNA2Vrqz3DY=;
	b=Od33U5rZb/Kt50GksqZizafa3dtZ8oXJjAoQk//oSfEu/Qg9cHhM/82cT0cggHHvOdBCr0
	Q1NMzGS6WHMot4SXCLbRzpwlg2BWLh6tzn8rCRy8OG7XKfiYiapLCQLs/pmNTcFFY9MrzX
	/iFDt2YCImqvWV+fpfdTU/6PeJ25S/M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: kernel: Use str_read_write() helper function
Date: Sun, 20 Oct 2024 22:57:55 +0200
Message-ID: <20241020205758.332095-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_read_write() helper function
and remove some unnecessary negations.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/m68k/kernel/traps.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 53d0cf343d90..d2f25e8895e5 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -383,7 +383,7 @@ static inline void bus_error030 (struct frame *fp)
 			fp->ptregs.format == 0xa ? fp->ptregs.pc + 4 : fp->un.fmtb.baddr);
 	if (ssw & DF)
 		pr_debug("Data %s fault at %#010lx in %s (pc=%#lx)\n",
-			ssw & RW ? "read" : "write",
+			str_read_write(ssw & RW),
 			fp->un.fmtb.daddr,
 			space_names[ssw & DFC], fp->ptregs.pc);
 
@@ -419,7 +419,7 @@ static inline void bus_error030 (struct frame *fp)
 				}
 
 				pr_err("Data %s fault at %#010lx in %s (pc=%#lx)\n",
-					ssw & RW ? "read" : "write",
+					str_read_write(ssw & RW),
 					fp->un.fmtb.daddr,
 					space_names[ssw & DFC], fp->ptregs.pc);
 			}
@@ -455,7 +455,7 @@ static inline void bus_error030 (struct frame *fp)
 			pr_debug("*** unexpected busfault type=%#04x\n",
 				 buserr_type);
 			pr_debug("invalid %s access at %#lx from pc %#lx\n",
-				 !(ssw & RW) ? "write" : "read", addr,
+				 str_read_write(ssw & RW), addr,
 				 fp->ptregs.pc);
 			die_if_kernel ("Oops", &fp->ptregs, buserr_type);
 			force_sig (SIGBUS);
@@ -514,7 +514,7 @@ static inline void bus_error030 (struct frame *fp)
 			fp->ptregs.format == 0xa ? fp->ptregs.pc + 4 : fp->un.fmtb.baddr);
 	if (ssw & DF)
 		pr_debug("Data %s fault at %#010lx in %s (pc=%#lx)\n",
-			ssw & RW ? "read" : "write",
+			str_read_write(ssw & RW),
 			fp->un.fmtb.daddr,
 			space_names[ssw & DFC], fp->ptregs.pc);
 
@@ -548,7 +548,7 @@ static inline void bus_error030 (struct frame *fp)
 			/* We might have an exception table for this PC */
 			if (ssw & 4 && !search_exception_tables(fp->ptregs.pc)) {
 				pr_err("Data %s fault at %#010lx in %s (pc=%#lx)\n",
-				       ssw & RW ? "read" : "write",
+				       str_read_write(ssw & RW),
 				       fp->un.fmtb.daddr,
 				       space_names[ssw & DFC], fp->ptregs.pc);
 				goto buserr;
@@ -564,7 +564,7 @@ static inline void bus_error030 (struct frame *fp)
 				       mmusr);
 		} else if (mmusr & (MMU_B|MMU_L|MMU_S)) {
 			pr_err("invalid %s access at %#lx from pc %#lx\n",
-			       !(ssw & RW) ? "write" : "read", addr,
+			       str_read_write(ssw & RW), addr,
 			       fp->ptregs.pc);
 			die_if_kernel("Oops",&fp->ptregs,mmusr);
 			force_sig(SIGSEGV);
@@ -575,7 +575,7 @@ static inline void bus_error030 (struct frame *fp)
 #endif
 
 			pr_err("weird %s access at %#lx from pc %#lx (ssw is %#x)\n",
-			       !(ssw & RW) ? "write" : "read", addr,
+			       str_read_write(ssw & RW), addr,
 			       fp->ptregs.pc, ssw);
 			asm volatile ("ptestr #1,%1@,#0\n\t"
 				      "pmove %%psr,%0"
@@ -991,7 +991,7 @@ static void bad_super_trap(struct frame *fp)
 				fp->ptregs.pc + 4 : fp->un.fmtb.baddr);
 		if (ssw & DF)
 			pr_err("Data %s fault at %#010lx in %s (pc=%#lx)\n",
-				ssw & RW ? "read" : "write",
+				str_read_write(ssw & RW),
 				fp->un.fmtb.daddr, space_names[ssw & DFC],
 				fp->ptregs.pc);
 	}
-- 
2.47.0


