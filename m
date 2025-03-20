Return-Path: <linux-kernel+bounces-570399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025DA6AFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AB4189DF12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC037214A74;
	Thu, 20 Mar 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3KhkDhb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F901E5205
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506393; cv=none; b=DHds5nfVA/rRwy7mXDm9jfn8O1DffrnMggt8LOr68aF9M+lr09Em8MkSLW/S1isqhlMF1/TBHgKsaIJvBrdokcUWokld+V9V1q2s7UKOKsNQAFUF5Syukhq2MBy8L7GmO7ex0p/4X4DCOB3J7MuQajQHbgCL9AMYvEpkSxPRzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506393; c=relaxed/simple;
	bh=z9aD4qcaeaKlke4b63aztPAhDC6jz7SUuP3IeA+8IC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FG9Tdf/pOxjNSXTnwup4fzz2Owpmvvi+Lpmew1voOtXiq9Ikh4adzorO1w9uxJGFTnB6sxjbVCMRYTNdVUEg/Tr49htuh+wN0kXcorqeFa4cI3D56hv9uJ+K7preNdbhQpDWq+UzRpXtGo1XnxBRbuxnEVbGiIes9QJn33HbBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3KhkDhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAE9C4CEE3;
	Thu, 20 Mar 2025 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506392;
	bh=z9aD4qcaeaKlke4b63aztPAhDC6jz7SUuP3IeA+8IC8=;
	h=From:To:Cc:Subject:Date:From;
	b=L3KhkDhb/X4l+ZoTHaHy+efZ6NFuQtDLvdTdyYTx5WQ3y/OKEI55/eljU/p/O7fm2
	 nlVmF1iBZTl3+/9jgRhpHKUWP4FcalFQxUeczzIVeWjaQklQ28qJBVhtLkX0gchBLn
	 UC/8vWwSxATRBNnDnvsaxsYuuWume/N6RrbRwFZuoEoR80eN1+kS6MWteDat6MH4kJ
	 VonPGrh9pTe3NhDMFZ72YlGFT6X27ltjuu4xhnYzgDntP3NMv2bhGj0rTXEHBoBRcr
	 8NcnpMi8OFAZGbDNspm0qN7KSB2998KWNAXXxPlZq6qPK53E6RkS4Lt83ht4GaosTc
	 sKoMxFYO4Nf2A==
From: Ard Biesheuvel <ardb@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	samitolvanen@google.com,
	brgerst@gmail.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] x86/asm: Make asm export of __ref_stack_chk_guard unconditional
Date: Thu, 20 Mar 2025 22:32:39 +0100
Message-ID: <20250320213238.4451-2-ardb@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=ardb@kernel.org; h=from:subject; bh=z9aD4qcaeaKlke4b63aztPAhDC6jz7SUuP3IeA+8IC8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf1OZ5mjpoCcwfKy+oq1TIx7V54XOvqkWe3SzWbRBQd/Z C/5mTOro5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzksgIjw8YcR95NO6an1Bzm i6tZsD9Bm3HW/Z27eWPO1bYc0TaJnsXI8H/ehMRtQrLH/Q7Ot0tc6Pt32eTdc/dphfT1mlsuyg1 XYgIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Clang does not tolerate the use of non-TLS symbols for the per-CPU stack
protector very well, and to work around this limitation, the symbol
passed via the -mstack-protector-guard-symbol= option is never defined
in C code, but only in the linker script, and it is exported from an
assembly file. This is necessary because Clang will fail to generate the
correct %GS based references in a compilation unit that includes a
non-TLS definition of the guard symbol being used to store the stack
cookie.

This problem is only triggered by symbol definitions, not by
declarations, but nonetheless, the declaration in <asm/asm-prototypes.h>
is conditional on __GENKSYMS__ being #define'd, so that only genksyms
will observe it, but for ordinary compilation, it will be invisible.

This is causing problems with the genksyms alternative gendwarfksyms,
which does not #define __GENKSYMS__, does not observe the symbol
declaration, and therefore lacks the information it needs to version it.
Adding the #define creates problems in other places, so that is not a
straight-forward solution. So take the easy way out, and drop the
conditional on __GENKSYMS__, as this is not really needed to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/asm-prototypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8d9e62725202..11c6fecc3ad7 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -20,6 +20,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
-#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+#ifdef CONFIG_STACKPROTECTOR
 extern unsigned long __ref_stack_chk_guard;
 #endif
-- 
2.47.2


