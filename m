Return-Path: <linux-kernel+bounces-398958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018509BF877
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007CC1C20DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647420C31C;
	Wed,  6 Nov 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8mqV7ur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248020C02A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928414; cv=none; b=G62BL8IERTlaZPTlpRDUI8emllEOIlpxllhtZtVs8J3PQ38MOo77U5K9AInWejm1KEM8TlaOIMWO9SXM9DusWE4cCK5Tp9wuHdNVa+2x8qoY8cnxC7R7cGlFDTPLtceyhe1K676GIkJdJHqkHJgJ5Mv5lkWCYg6F40JU49juO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928414; c=relaxed/simple;
	bh=hiA2YZ1vGHtJnoyVlnCwmx+UZjZfmGxI/JLLYuDClGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3+DfcoLKLCq3TvmYEHbB4OVt3dJUTQ4FdrdIUGh75aKDp+Wx+TxKkV3OoJEhcVGeuBros+cls/To6laha+Steza13eA6E3p4dL/boBxlmBVPYyNm6lyr4HTaPR/az0r5P6CqPxx1gCgLXuBwy3uK2NvOablc42ijpmNyQJE03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8mqV7ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89974C4CEC6;
	Wed,  6 Nov 2024 21:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730928413;
	bh=hiA2YZ1vGHtJnoyVlnCwmx+UZjZfmGxI/JLLYuDClGY=;
	h=From:To:Cc:Subject:Date:From;
	b=f8mqV7urJNd6E2NJ6F1Q//xrKBhNdMS5JBULN/RiaUEgmF7IT70A+l2rOIq6eAuU4
	 0bzESHpWqfeYw/M0ZRm7JYVXrErrhky4NrtrOSh4HhYM1FNG5yn1yegjbYXYAvAPlO
	 kmuv1k1tRhB1TaoxGeA7E+JUUrDxW6w+QB61xZ0GEGPk69t0hVFKj19fr5bz6P/4+q
	 kwZAkyKZXy/H82jsjUlW3QMR0VnhpHtJZx1t/rHh6rMtU7iA32YgClxaYqPlD+nW1m
	 6TScWI1kurcrmtvDcvD5cZC83lmMUKGFUUJdZjgpwWMMDvZe6ANHrKEJThIpJtf3JY
	 DLNU2Xctw5pzg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: cell: Use for_each_of_range() iterator
Date: Wed,  6 Nov 2024 15:26:46 -0600
Message-ID: <20241106212647.341857-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the cell_iommu_get_fixed_address() dma-ranges parsing to use the
for_each_of_range() iterator.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/powerpc/platforms/cell/iommu.c | 49 ++++++++++-------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 4cd9c0de22c2..62c9679b8ca3 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -779,58 +779,41 @@ static int __init cell_iommu_init_disabled(void)
 
 static u64 cell_iommu_get_fixed_address(struct device *dev)
 {
-	u64 cpu_addr, size, best_size, dev_addr = OF_BAD_ADDR;
+	u64 best_size, dev_addr = OF_BAD_ADDR;
 	struct device_node *np;
-	const u32 *ranges = NULL;
-	int i, len, best, naddr, nsize, pna, range_size;
+	struct of_range_parser parser;
+	struct of_range range;
 
 	/* We can be called for platform devices that have no of_node */
 	np = of_node_get(dev->of_node);
 	if (!np)
 		goto out;
 
-	while (1) {
-		naddr = of_n_addr_cells(np);
-		nsize = of_n_size_cells(np);
-		np = of_get_next_parent(np);
-		if (!np)
-			break;
-
-		ranges = of_get_property(np, "dma-ranges", &len);
+	while ((np = of_get_next_parent(np))) {
+		if (of_pci_dma_range_parser_init(&parser, np))
+			continue;
 
-		/* Ignore empty ranges, they imply no translation required */
-		if (ranges && len > 0)
+		if (of_range_count(&parser))
 			break;
 	}
 
-	if (!ranges) {
+	if (!np) {
 		dev_dbg(dev, "iommu: no dma-ranges found\n");
 		goto out;
 	}
 
-	len /= sizeof(u32);
-
-	pna = of_n_addr_cells(np);
-	range_size = naddr + nsize + pna;
-
-	/* dma-ranges format:
-	 * child addr	: naddr cells
-	 * parent addr	: pna cells
-	 * size		: nsize cells
-	 */
-	for (i = 0, best = -1, best_size = 0; i < len; i += range_size) {
-		cpu_addr = of_translate_dma_address(np, ranges + i + naddr);
-		size = of_read_number(ranges + i + naddr + pna, nsize);
+	best_size = 0;
+	for_each_of_range(&parser, &range) {
+		if (!range.cpu_addr)
+			continue;
 
-		if (cpu_addr == 0 && size > best_size) {
-			best = i;
-			best_size = size;
+		if (range.size > best_size) {
+			best_size = range.size;
+			dev_addr = range.bus_addr;
 		}
 	}
 
-	if (best >= 0) {
-		dev_addr = of_read_number(ranges + best, naddr);
-	} else
+	if (!best_size)
 		dev_dbg(dev, "iommu: no suitable range found!\n");
 
 out:
-- 
2.45.2


