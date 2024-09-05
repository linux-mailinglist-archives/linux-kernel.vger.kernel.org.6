Return-Path: <linux-kernel+bounces-316709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2896D2F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBE4B22758
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFEB198857;
	Thu,  5 Sep 2024 09:17:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E34C92
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527877; cv=none; b=LrnuyBnxcP450B36ZIh7HTh6ak+OdBiJH8Swx4zaFW0aDqNuR0d7UsN2E8Z6ULR4m58DDI6v0YcVyDtGy+kQ2f3+GJWRTYv+hrX4DcSOVAJt4BdGGAl0EXXqqfEUQ5Vyk0hS68sGsK2B/wQ7ecGuAkBA5h8C7LdAL6Zge2OA2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527877; c=relaxed/simple;
	bh=JUqVB63pu+ou9u5XWMxo9nuXSdc6Fcwny1TsRTjf1C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPZhEqxa97xVe6RIm+AqduKdf1e572XFkfGUsZHacx5qqfafbGP4x/h86M6QTq2wUrH0KweBQg/NjTErzmCX9i9yIX80rL2K+MdmdvCffKhKpWr7JClH1SudlF/SudSsgHni+5K/ShGRXL8S3lwKP/L3zdVD9KDHeTV7rGaYl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9065C1570;
	Thu,  5 Sep 2024 02:18:21 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.29.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF323F8A4;
	Thu,  5 Sep 2024 02:17:53 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 2/2] irqchip/gic-v3-its: Rely on genpool alignment
Date: Thu,  5 Sep 2024 10:17:38 +0100
Message-Id: <20240905091738.28544-3-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905091738.28544-1-steven.price@arm.com>
References: <20240905091738.28544-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

its_create_device() over-allocated by ITS_ITT_ALIGN - 1 bytes to ensure
that an aligned area was available within the allocation. The new
genpool allocator has its min_alloc_order set to
get_order(ITS_ITT_ALIGN) so all allocations from it should be
appropriately aligned.

Remove the over-allocation from its_create_device() and alignment from
its_build_mapd_cmd().

Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 557214c774c3..49aacf96ade2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -700,7 +700,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_node *its,
 	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
 
 	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
-	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
 
 	its_encode_cmd(cmd, GITS_CMD_MAPD);
 	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
@@ -3495,7 +3494,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 */
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
-	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
+	sz = max(sz, ITS_ITT_ALIGN);
 
 	itt = itt_alloc_pool(its->numa_node, sz);
 
-- 
2.34.1


