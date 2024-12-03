Return-Path: <linux-kernel+bounces-430069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1209E2DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733CFB2791F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18E31F7594;
	Tue,  3 Dec 2024 19:46:28 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7B4A29
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255188; cv=none; b=M+AU4frJkSZkrIbHXizCcXcih+MTwrgxki9AQ0h3yeSNJJ2PyofTrNVmJq49IVUNw3y8HRKD//VpjkGE3Q3JNlr2gdtQSPcRf6tVFA7wAyTGlkkATszslPzxgA3sL/iBZyATmVJrvUf9IVTkTNTHq+TxBrLe+h2WZB1O2E9ZsSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255188; c=relaxed/simple;
	bh=Jx62nYcMSTwvdKtKDQNerCZbsnNhCFz68IobPQVAdEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZGuaZi6KF6dkde6mlL4X5zz2HzSDOT8f8+bdKuzm+YckQeN/jS/ELUY0+DK7XfiNn65+E5egu0jGaWu/axp6kc0bVYwBs6VvX8iHLlohibHOF8nKLuIWwEYfq1ih7IvuwQO7d/eV0q+x4uxgdxptpo1IOAmXgKmzhUHmUtxvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rkS3ybwz9stF;
	Tue,  3 Dec 2024 20:46:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjPAPZv7yfh5; Tue,  3 Dec 2024 20:46:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rkS34dCz9stD;
	Tue,  3 Dec 2024 20:46:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FAB58B767;
	Tue,  3 Dec 2024 20:46:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id rIwxW3CFzOGj; Tue,  3 Dec 2024 20:46:24 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 83D368B763;
	Tue,  3 Dec 2024 20:46:23 +0100 (CET)
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
Subject: [PATCH v4 0/4] Implement inline static calls on PPC32 - v4
Date: Tue,  3 Dec 2024 20:44:48 +0100
Message-ID: <cover.1733245362.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733255162; l=1638; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Jx62nYcMSTwvdKtKDQNerCZbsnNhCFz68IobPQVAdEA=; b=Vaz4d+v6txV/Q+bQM6mS4v2BNnSdLmi67e1D6FDiWHRGOLGgf/e+1G1Osrdd2/be5z+h07qO1 XoMzrV3t+WDBOTVvXC6nevltX7m2NOqd/ue3f+ZFR8JSDWnvI0Pw+pu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series implements inline static calls on PPC32.

First patch adds to static_call core the ability to pass the
trampoline address at the same time as the site address to
arch_static_call_transform() so that it can fallback on branching to
the trampoline when the site is too far (Max distance for direct
branch is 32 Mbytes on powerpc).

Second patch adds support for decoding all types of uncond branches.

Third patch rearranges function arch_static_call_transform() to ease
implementation of inline static call in following patch.

Last patch implements inline static calls on PPC32: This is done by:
- Put a 'bl' to the destination function ('b' if tail call)
- Put a 'nop' when the destination function is NULL ('blr' if tail call)
- Put a 'li r3,0' when the destination is the RET0 function and not
a tail call.

If the destination is too far (over the 32Mb limit), go via the
trampoline thanks to patch 1.

Christophe Leroy (4):
  static_call_inline: Provide trampoline address when updating sites
  objtool/powerpc: Add support for decoding all types of uncond branches
  powerpc: Prepare arch_static_call_transform() for supporting inline
    static calls
  powerpc/static_call: Implement inline static calls

 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/static_call.h |  2 +
 arch/powerpc/kernel/static_call.c      | 58 +++++++++++++++++++-------
 arch/x86/kernel/static_call.c          |  2 +-
 kernel/static_call_inline.c            |  2 +-
 tools/objtool/arch/powerpc/decode.c    |  8 +++-
 6 files changed, 55 insertions(+), 18 deletions(-)

-- 
2.47.0


