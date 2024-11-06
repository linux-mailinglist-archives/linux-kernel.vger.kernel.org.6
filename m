Return-Path: <linux-kernel+bounces-398957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE329BF875
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227FD1F22F03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016920C31C;
	Wed,  6 Nov 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7v38/3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40413A26F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928404; cv=none; b=K9W2BWaAEV1n7CCvUilgG/zf0tXlMJmKrPR1ZqH4oEYARrxCDxLlwrsFbOH64a57Ft4uXOMV6wwgWWqdxTQYcm4ULEsgMhLxgmurqhwjZ/xudpzbS5ynsEr1Sl3RX+52UEm/zB8FyjzQqkBYF2EMdJUO+LUNHX9x3qxKMgGZt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928404; c=relaxed/simple;
	bh=LHBtxJhLBykWSxx00mtqWlXXjjjtzn2Hz6+h64j7m6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADV2gqJsFtKrpi3mMsZjkeqRcRiSz7vrC7VwYUHr/VnBg6oiDPZNAMUirDPFvvUrCA+48+REUPs6tp9Dt7CsVFmCX/smKOsND40lwLcYPRZu/oenb2wrmqxo8fVfwIxISAWYLteopinwPpVCHUop1peq3MWjr+DUIuX/DJOkmJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7v38/3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FE7C4CEC6;
	Wed,  6 Nov 2024 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730928403;
	bh=LHBtxJhLBykWSxx00mtqWlXXjjjtzn2Hz6+h64j7m6A=;
	h=From:To:Cc:Subject:Date:From;
	b=T7v38/3yK0uSWHnVsgInKyiUPs+SoGDfDPS9DuPtSPQ3dGIA8wEZtXFqy8s6jRAL1
	 Ak7OmesWGEaHpDhd8mXGc0RjoTFXacEY5YbTl3raPkiit9zeH07hIdh2NMuoiRGOF6
	 aikkXNa/qOM5zRMj1a1TnU+/gdpO+OPCDE4Ft/buVRDMTXQ9Ga1xx8RqSmhxADC29n
	 DuvGFUz2L0vYfYTAezQnErDB3Tl8Pl9CLkEQDkAxkdcpyF+zwGoShooHBpoCgeKy94
	 AhuXpGKLgCkR2noXIOCI1jiIr2DaeMmTGXzAcLypbbV7aE0O87GO2Z8sWVF2MkfkSa
	 Qi6xIiNF6Oyng==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: 44x: Use for_each_of_range() iterator
Date: Wed,  6 Nov 2024 15:26:39 -0600
Message-ID: <20241106212640.341677-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the ppc44x PCI dma-ranges parsing to use the for_each_of_range()
iterator.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/powerpc/platforms/44x/pci.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/44x/pci.c b/arch/powerpc/platforms/44x/pci.c
index db6d33ca753f..364aeb86ab64 100644
--- a/arch/powerpc/platforms/44x/pci.c
+++ b/arch/powerpc/platforms/44x/pci.c
@@ -94,10 +94,8 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
 					  struct resource *res)
 {
 	u64 size;
-	const u32 *ranges;
-	int rlen;
-	int pna = of_n_addr_cells(hose->dn);
-	int np = pna + 5;
+	struct of_range_parser parser;
+	struct of_range range;
 
 	/* Default */
 	res->start = 0;
@@ -105,18 +103,15 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
 	res->end = size - 1;
 	res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 
-	/* Get dma-ranges property */
-	ranges = of_get_property(hose->dn, "dma-ranges", &rlen);
-	if (ranges == NULL)
+	if (of_pci_dma_range_parser_init(&parser, hose->dn))
 		goto out;
 
-	/* Walk it */
-	while ((rlen -= np * 4) >= 0) {
-		u32 pci_space = ranges[0];
-		u64 pci_addr = of_read_number(ranges + 1, 2);
-		u64 cpu_addr = of_translate_dma_address(hose->dn, ranges + 3);
-		size = of_read_number(ranges + pna + 3, 2);
-		ranges += np;
+	for_each_of_range(&parser, &range) {
+		u32 pci_space = range.flags;
+		u64 pci_addr = range.bus_addr;
+		u64 cpu_addr = range.cpu_addr;
+		size = range.size;
+
 		if (cpu_addr == OF_BAD_ADDR || size == 0)
 			continue;
 
-- 
2.45.2


