Return-Path: <linux-kernel+bounces-293856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD69585CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD561F27E31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39518E05C;
	Tue, 20 Aug 2024 11:28:21 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836418CC00
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153300; cv=none; b=dmsCpPX5/z9JS+QU1wAYY1v+cikiL1bAIt8BX2EZ3nBQ8lRtEvro8i1iIJ+cvyEjZIAWN3h8UYZ5ZWYGSMHBzfqTecF73TPgbCwpxbv/8NIqLsKNqLKlIKdwu4jocxC2b50hR/qxVinfqk54FwquC5IIrz3XDK9l7yxOrQQ0iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153300; c=relaxed/simple;
	bh=7B8+M/Fb75kjCItR5+3I02za1jo5KRize8Lpna3H3iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXtm+cgEhCDCr6WBX7eSjuuxPHeU8RjeFS6FSJPfoxjXGq6IiPx/2W28Vqzh8IG2eCFgfSNPKdCWZzUld04SVhBWg/DaDGKbTQOGBN4m+MetbX+waYHziH9D+feZ/59Lrr2y1Nkudixj83EFsW7k2tHG4Ps0p3uk34jYPeAzaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wp6f24sJjz9sSK;
	Tue, 20 Aug 2024 13:28:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FMbKl540KsHO; Tue, 20 Aug 2024 13:28:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wp6f243Xwz9sSH;
	Tue, 20 Aug 2024 13:28:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C6168B778;
	Tue, 20 Aug 2024 13:28:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nbey0QpDfNSf; Tue, 20 Aug 2024 13:28:10 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 275298B763;
	Tue, 20 Aug 2024 13:28:10 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: Don't discard rela sections
Date: Tue, 20 Aug 2024 13:28:07 +0200
Message-ID: <45c3e6fc76cad05ad2cac0f5b5dfb4fae86dc9d6.1724153239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724153287; l=2140; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=7B8+M/Fb75kjCItR5+3I02za1jo5KRize8Lpna3H3iY=; b=1rZ7EVC/17O6gwXBouEqcHmQ7k3Lf6P8XwMTqcqXvN+N1nrKYKx7Q5v2URHH2+jgNG5XjW2CU lItGiILDyqtCwpsWl1eF8SHUM7KUkxOQ4VGA+wUNhUJpYe/J13G2v1E
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

After building the VDSO, there is a verification that it contains
no dynamic relocation, see commit aff69273af61 ("vdso: Improve
cmd_vdso_check to check all dynamic relocations").

This verification uses readelf -r and doesn't work if rela sections
are discarded.

Fixes: 8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Was part of series "Wire up getrandom() vDSO implementation on powerpc" but
it is not directly related and should be fixed independantly as it may happen
already, for instance if the compiler wants rest_gpr30 instead of rest_gpr31.
---
 arch/powerpc/kernel/vdso/vdso32.lds.S | 4 +++-
 arch/powerpc/kernel/vdso/vdso64.lds.S | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 426e1ccc6971..8f57107000a2 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -74,6 +74,8 @@ SECTIONS
 	.got		: { *(.got) }			:text
 	.plt		: { *(.plt) }
 
+	.rela.dyn	: { *(.rela .rela*) }
+
 	_end = .;
 	__end = .;
 	PROVIDE(end = .);
@@ -87,7 +89,7 @@ SECTIONS
 		*(.branch_lt)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
-		*(.got1 .glink .iplt .rela*)
+		*(.got1 .glink .iplt)
 	}
 }
 
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index bda6c8cdd459..400819258c06 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -69,7 +69,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 	.gcc_except_table : { *(.gcc_except_table) }
-	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
+	.rela.dyn ALIGN(8) : { *(.rela .rela*) }
 
 	.got ALIGN(8)	: { *(.got .toc) }
 
@@ -86,7 +86,7 @@ SECTIONS
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
 		*(.opd)
-		*(.glink .iplt .plt .rela*)
+		*(.glink .iplt .plt)
 	}
 }
 
-- 
2.44.0


