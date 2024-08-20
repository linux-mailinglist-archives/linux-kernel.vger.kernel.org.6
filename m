Return-Path: <linux-kernel+bounces-293985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56295873C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3C41C21AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000C18FC89;
	Tue, 20 Aug 2024 12:42:44 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16D18DF9B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157764; cv=none; b=NzmsYP82rfLGClZrzdaBwuiks4S8COj/jw172sLY8eq9gHGoon+SjJrcEA0ewRXXwKe+BG17UnAbBMfjlqq63fGnI77o0zvSiE2Qkfe0RF48uOz52ElqfAo5r8xnE02lYDmw8hPb/jKIvDWYowLcJCJ5BcL+cj3i+Tox/dqx5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157764; c=relaxed/simple;
	bh=vit4wtQaPUAYtYDj9r5m8Vd0k9ZpNkpkxjsTA4lKqbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liARyPr6PT0GNCWixHvEfC2tiw0xTsdXnJjzHMjtQIv9+BSpERw7KDVNWnBoXKCXNkyg+4FR1n1srBWB8r9fKoZk9e+SwN0t9egBxXSpbU2PBjRTZZOdV0YRqiZOB/MITQVwJNF1ymovghsY4E/8hcThxMMNhWmw+VoY9P7Pwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wp8J05B18z9sSX;
	Tue, 20 Aug 2024 14:42:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MxXdqBdrQDP7; Tue, 20 Aug 2024 14:42:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wp8J04TQDz9sSR;
	Tue, 20 Aug 2024 14:42:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B0938B778;
	Tue, 20 Aug 2024 14:42:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oPTjdzjTUaec; Tue, 20 Aug 2024 14:42:40 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 279838B763;
	Tue, 20 Aug 2024 14:42:40 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/64e: Define mmu_pte_psize static
Date: Tue, 20 Aug 2024 14:42:38 +0200
Message-ID: <beb30d280eaa5d857c38a0834b147dffd6b28aa9.1724157750.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724157759; l=1089; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=vit4wtQaPUAYtYDj9r5m8Vd0k9ZpNkpkxjsTA4lKqbk=; b=WtKiITM7yUMaeHEqbzDXFhbtKx4TLCzBLuVdApzRx5bRJjEWnPfvpGWmxWINMu99fPwMvcGNx 2+3HzHdfwOMDJSucXj/S/dK2gtpdTth0oW1JL8nphWMINfaHwRA81n1
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

mmu_pte_psize is only used in the tlb_64e.c, define it static.

Fixes: 25d21ad6e799 ("powerpc: Add TLB management code for 64-bit Book3E")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408011256.1O99IB0s-lkp@intel.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/tlb_64e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
index 113edf76d3ce..d26656b07b72 100644
--- a/arch/powerpc/mm/nohash/tlb_64e.c
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -33,7 +33,7 @@
  * though this will probably be made common with other nohash
  * implementations at some point
  */
-int mmu_pte_psize;		/* Page size used for PTE pages */
+static int mmu_pte_psize;	/* Page size used for PTE pages */
 int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
 int book3e_htw_mode;		/* HW tablewalk?  Value is PPC_HTW_* */
 unsigned long linear_map_top;	/* Top of linear mapping */
-- 
2.44.0


