Return-Path: <linux-kernel+bounces-545786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52409A4F15E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68785188E79B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114727BF63;
	Tue,  4 Mar 2025 23:20:11 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CB279337
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130411; cv=none; b=M5qHElyH7UCEurHOIrjX69m6dhCJGgVtm8Xv1pmsbzUvpP16Fak+TGh+sOzSaNOJM4GkSZzfQR/DN42Casj9LTtSpuBMSnVHmq6IXKuYMs3KetWUNVpDxo/mfVAaq2VNw+3TgWXihLq1I/j4iVH3Su5sCRey6JLMxinVCGDKq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130411; c=relaxed/simple;
	bh=mhbNOqeaG3cayoZ0G+PBgg4dwi61tzwTHcEUa12auuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTT5RtNXhJIdWnVxwkFGM7IAU6ak1Ze/P4Bzf1azUrxpSifV+lgPMAlimmX153+QP8FRrDeLpzb3D4UdiOL7GbmOEdVEVH/Ph+9556j2u4boY4ozlJKhYzQa7QWW87YD6vM99fzVxsDEnCmHKaYKoDHgkx05XDU0o0LGAudyzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z6rkH4Tpfz9stK;
	Wed,  5 Mar 2025 00:00:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vg8UFazMBaqu; Wed,  5 Mar 2025 00:00:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z6rkH3gmRz9stJ;
	Wed,  5 Mar 2025 00:00:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 68B398B776;
	Wed,  5 Mar 2025 00:00:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WgqhTFqhzL8T; Wed,  5 Mar 2025 00:00:23 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A6868B763;
	Wed,  5 Mar 2025 00:00:22 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] powerpc: Fix 'intra_function_call not a direct call' warning
Date: Wed,  5 Mar 2025 00:00:19 +0100
Message-ID: <88876fb4e412203452e57d1037a1341cf15ccc7b.1741128981.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741129219; l=2054; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=mhbNOqeaG3cayoZ0G+PBgg4dwi61tzwTHcEUa12auuE=; b=7N9scikoa+Nrpe1ZRdjcL9gPR/Fv9oP706Utkehsb5jpMtETPsmWna7UeuR2WrRZqNzuzxEPV Yl2xUJ9+RvLDFWnUJcyDqZ4beL9CAl/sTxFcq+8ZuShM/FEjsmx0abA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The following build warning have been reported:

  arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
  arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call

This happens due to commit bb7f054f4de2 ("objtool/powerpc: Add support
for decoding all types of uncond branches") because that commit decodes
'bl .+4' as a normal instruction because that instruction is used by
clang instead of 'bcl 20,31,+.4' for relocatable code.

The solution is simply to remove the ANNOTATE_INTRA_FUNCTION_CALL
annotation now that the instruction is not seen as a function call
anymore.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com
Fixes: bb7f054f4de2 ("objtool/powerpc: Add support for decoding all types of uncond branches")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/switch.S            | 1 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/switch.S b/arch/powerpc/kernel/switch.S
index 608c0ce7cec6..59e3ee99db0e 100644
--- a/arch/powerpc/kernel/switch.S
+++ b/arch/powerpc/kernel/switch.S
@@ -39,7 +39,6 @@ flush_branch_caches:
 
 	// Flush the link stack
 	.rept 64
-	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	.+4
 	.endr
 	b	1f
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ea7ad200b330..83f7504349d2 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1524,14 +1524,12 @@ kvm_flush_link_stack:
 
 	/* Flush the link stack. On Power8 it's up to 32 entries in size. */
 	.rept 32
-	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	.+4
 	.endr
 
 	/* And on Power9 it's up to 64. */
 BEGIN_FTR_SECTION
 	.rept 32
-	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	.+4
 	.endr
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
-- 
2.47.0


