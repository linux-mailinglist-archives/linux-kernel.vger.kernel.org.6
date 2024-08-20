Return-Path: <linux-kernel+bounces-294396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D09958D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693E5B21ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573C1BC080;
	Tue, 20 Aug 2024 17:24:31 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380B18C92C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174670; cv=none; b=rO/iYVF3Ge2d5S/8y0tEnuu/LKvdmHJk4ALmzDOERDVi8FNugsA5kVj2OmKLXrJpQWxPwKc6cWdmVmvi3cg0V52KHlJXqJAccAKCuyyA31g1CR8wj3uFoTbCNynZjlMKCIGCm/96H41Pp/L2jBwaiE1prtPKNvJUhvbEPwb2fkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174670; c=relaxed/simple;
	bh=gTta4f3jaT+jWY0auhaD//hXnmuziWuUHy3TgHHYXUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dibwwKc7STegRfDxu596M5Wj+2ZBELPHJNMJisCZ/Qlswsp2bRR3k/EsV/FIFlnAhv6noY3n1Y6NC2INajslFJrTM1IMtwdNqITmryw1qkLOkdMyu8Awr5CvPqM87XFdx9//StP5WwesIRiF4rSSxNMqD8rAwEwBYEKlrCUJrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGY54F2Sz9sSK;
	Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EhOvV_YNy5du; Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY537Y7z9sSH;
	Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 555D48B779;
	Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Fciq5aS0IFe3; Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E39AA8B763;
	Tue, 20 Aug 2024 19:24:24 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/14] Reduce alignment constraint on STRICT_KERNEL_RWX and speed-up TLB misses on 8xx and 603
Date: Tue, 20 Aug 2024 19:23:44 +0200
Message-ID: <cover.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174647; l=2698; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=gTta4f3jaT+jWY0auhaD//hXnmuziWuUHy3TgHHYXUg=; b=xC7dWx5C6HJGMCqgWXUtATxKUvFEOaQv/VtHA77ieLJUgUz1UbvI+S472+R14TnuWw/CpSgUk CVzgx3Kru4mBjSNVMlkQDPWVSh7zDDp/LhgkOUbPAF6POyiffaQveR0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series does mainly two things:
- Remove the 8M alignment constraint on STRICT_KERNEL_RWX on 8xx to
avoid wasting memory.
- Speed-up TLB misses by duplicating kernel PGD entries into each
task's PGDIRs to avoid the address comparison in TLB miss handler.

On 8xx, the address comparison takes a significant part of CPU cycles
as it requires saving/restoring CR, and because a taken branch
requires 2 cycles.
On 603 it is less significant because CR is saved automatically and
has to be restored anyway but it is still worth it.

For ITLB misses:
- Kernel PGD entries are setup for once during init, before creation
of new PGDIRs.
- Module PGD entries are setup also at init by preallocating page
tables for a very few number of pages

For DTLB misses:
- Some handling is added in 8xx DATA TLB error interrupt and in
603 DATA read and store TLB miss interrupts to copy missing PGD
entries into child.

The cost of that additional handling on error paths is worth the gain
on hot TLB miss pathes.

Because 8xx and 603 don't use leaf kernel pages at PGD level, there is
no need to care about PGD entries cleanup, page tables are never freed.

Christophe Leroy (14):
  powerpc/8xx: Fix initial memory mapping
  powerpc/8xx: Fix kernel vs user address comparison
  powerpc/8xx: Copy kernel PGD entries into all PGDIRs
  Revert "powerpc/8xx: Always pin kernel text TLB"
  powerpc/8xx: Allow setting DATA alignment even with STRICT_KERNEL_RWX
  powerpc/8xx: Reduce default size of module/execmem area
  powerpc/8xx: Preallocate execmem page tables
  powerpc/8xx: Inconditionally use task PGDIR in ITLB misses
  powerpc/8xx: Inconditionally use task PGDIR in DTLB misses
  powerpc/32s: Reduce default size of module/execmem area
  powerpc/603: Copy kernel PGD entries into all PGDIRs and preallocate
    execmem page tables
  powerpc/603: Switch r0 and r3 in TLB miss handlers
  powerpc/603: Inconditionally use task PGDIR in ITLB misses
  powerpc/603: Inconditionally use task PGDIR in DTLB misses

 arch/powerpc/Kconfig                         |  31 +++-
 arch/powerpc/include/asm/book3s/32/pgtable.h |   3 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |   3 +-
 arch/powerpc/include/asm/nohash/pgalloc.h    |   8 +-
 arch/powerpc/kernel/head_8xx.S               |  78 +++++-----
 arch/powerpc/kernel/head_book3s_32.S         | 144 +++++++++----------
 arch/powerpc/mm/book3s32/mmu.c               |   2 +
 arch/powerpc/mm/mem.c                        |  14 ++
 arch/powerpc/mm/nohash/8xx.c                 |   9 +-
 arch/powerpc/platforms/8xx/Kconfig           |   7 +
 10 files changed, 173 insertions(+), 126 deletions(-)

-- 
2.44.0


