Return-Path: <linux-kernel+bounces-351734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A6999157A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F3A1F23717
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97913D243;
	Sat,  5 Oct 2024 09:20:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D017741
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728120006; cv=none; b=sED9G7cYlf2nW8Rpnk3EIsYmX9AwTgeoiO3IV55ZR1BaBLrngMWCZUh5xv+GNmizx8BpBdbeeGw4P6Zbi8glAsBPemPkmHlD7kFFPbh1mK+DyEiPMHPdXB7HnF+EeZI9ibIcGxYjUKc4GJEPw3Zs8bJQW/ingMBmwEBUgg2JeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728120006; c=relaxed/simple;
	bh=XNloKlJd6cPapFbwHXbwp1032E6JMP4+SCql5KR1xK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdmdqW67web4hRQbAmBB0Sk5FZpmHYG+ZaGOEzBROV+AZDXdCw/PIaKUp8YEOGb/m2vOODAEz7BIh7wqd09N24STUKdyEJALQFyBa4E6Y7S4DNbWak3fdyuH1BBMGgjNCdKw8MOESbTVnQT0humXGNmS3b29yQ0unHuDzC473Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XLK2N4PKSz9sPd;
	Sat,  5 Oct 2024 10:53:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6xuLXh36INx; Sat,  5 Oct 2024 10:53:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XLK2N3P69z9rvV;
	Sat,  5 Oct 2024 10:53:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6023A8B77D;
	Sat,  5 Oct 2024 10:53:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9WLz8uhMso-s; Sat,  5 Oct 2024 10:53:32 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.211])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EEBB08B77B;
	Sat,  5 Oct 2024 10:53:31 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Fix kernel DTLB miss on dcbz
Date: Sat,  5 Oct 2024 10:53:29 +0200
Message-ID: <2b851399bd87e81c6ccb87ea3a7a6b32c7aa04d7.1728118396.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728118409; l=3761; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=XNloKlJd6cPapFbwHXbwp1032E6JMP4+SCql5KR1xK8=; b=MV0GpGNaLPexePei572twkP5R34vCisIPn8jbBEp5+gwQu4j26//ZnjFihd6JDUBdGBGte4II ramSssSGYWCCvtHbKjkYPrcdAg1Wtnh107ni4b8I2AhaLGwow4cpjb2
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Following OOPS is encountered while loading test_bpf module
on powerpc 8xx:

[  218.835567] BUG: Unable to handle kernel data access on write at 0xcb000000
[  218.842473] Faulting instruction address: 0xc0017a80
[  218.847451] Oops: Kernel access of bad area, sig: 11 [#1]
[  218.852854] BE PAGE_SIZE=16K PREEMPT CMPC885
[  218.857207] SAF3000 DIE NOTIFICATION
[  218.860713] Modules linked in: test_bpf(+) test_module
[  218.865867] CPU: 0 UID: 0 PID: 527 Comm: insmod Not tainted 6.11.0-s3k-dev-09856-g3de3d71ae2e6-dirty #1280
[  218.875546] Hardware name: MIAE 8xx 0x500000 CMPC885
[  218.880521] NIP:  c0017a80 LR: beab859c CTR: 000101d4
[  218.885584] REGS: cac2bc90 TRAP: 0300   Not tainted  (6.11.0-s3k-dev-09856-g3de3d71ae2e6-dirty)
[  218.894308] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 55005555  XER: a0007100
[  218.901290] DAR: cb000000 DSISR: c2000000
[  218.901290] GPR00: 000185d1 cac2bd50 c21b9580 caf7c030 c3883fcc 00000008 cafffffc 00000000
[  218.901290] GPR08: 00040000 18300000 20000000 00000004 99005555 100d815e ca669d08 00000369
[  218.901290] GPR16: ca730000 00000000 ca2c004c 00000000 00000000 0000035d 00000311 00000369
[  218.901290] GPR24: ca732240 00000001 00030ba3 c3800000 00000000 00185d48 caf7c000 ca2c004c
[  218.941087] NIP [c0017a80] memcpy+0x88/0xec
[  218.945277] LR [beab859c] test_bpf_init+0x22c/0x3c90 [test_bpf]
[  218.951476] Call Trace:
[  218.953916] [cac2bd50] [beab8570] test_bpf_init+0x200/0x3c90 [test_bpf] (unreliable)
[  218.962034] [cac2bde0] [c0004c04] do_one_initcall+0x4c/0x1fc
[  218.967706] [cac2be40] [c00a2ec4] do_init_module+0x68/0x360
[  218.973292] [cac2be60] [c00a5194] init_module_from_file+0x8c/0xc0
[  218.979401] [cac2bed0] [c00a5568] sys_finit_module+0x250/0x3f0
[  218.985248] [cac2bf20] [c000e390] system_call_exception+0x8c/0x15c
[  218.991444] [cac2bf30] [c00120a8] ret_from_syscall+0x0/0x28

This happens in the main loop of memcpy()

  ==>	c0017a80:	7c 0b 37 ec 	dcbz    r11,r6
	c0017a84:	80 e4 00 04 	lwz     r7,4(r4)
	c0017a88:	81 04 00 08 	lwz     r8,8(r4)
	c0017a8c:	81 24 00 0c 	lwz     r9,12(r4)
	c0017a90:	85 44 00 10 	lwzu    r10,16(r4)
	c0017a94:	90 e6 00 04 	stw     r7,4(r6)
	c0017a98:	91 06 00 08 	stw     r8,8(r6)
	c0017a9c:	91 26 00 0c 	stw     r9,12(r6)
	c0017aa0:	95 46 00 10 	stwu    r10,16(r6)
	c0017aa4:	42 00 ff dc 	bdnz    c0017a80 <memcpy+0x88>

Commit ac9f97ff8b32 ("powerpc/8xx: Inconditionally use task PGDIR in
DTLB misses") relies on re-reading DAR register to know if an error is
due to a missing copy of a PMD entry in task's PGDIR, allthough DAR
was already read in the exception prolog and copied into thread
struct. This is because is it done very early in the exception and
there are not enough registers available to keep a pointer to thread
struct.

However, dcbz instruction is buggy and doesn't update DAR register on
fault. That is detected and generates a call to FixupDAR workaround
which updates DAR copy in thread struct but doesn't fix DAR register.

Let's fix DAR in addition to the update of DAR copy in thread struct.

Fixes: ac9f97ff8b32 ("powerpc/8xx: Inconditionally use task PGDIR in DTLB misses")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 8120273c7249..78942fd6b4b9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -495,6 +495,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	bctr				/* jump into table */
 152:
 	mfdar	r11
+	mtdar	r10
 	mtctr	r11			/* restore ctr reg from DAR */
 	mfspr	r11, SPRN_SPRG_THREAD
 	stw	r10, DAR(r11)
-- 
2.44.0


