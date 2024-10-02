Return-Path: <linux-kernel+bounces-347685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D498DA9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D482B25DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C71D2F77;
	Wed,  2 Oct 2024 14:17:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC871D0DF7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878650; cv=none; b=rI1Yqz39mfBRcgsi8kNZuVtX9WOIdmsgNISdnwNKWlR0LhNwLENt6eKi75GKOEHVDANFbHGKQ0vYl3bCZ64t09IcDVLC9a+7ORg9po9LRjLd89MXvoytsgHPoeYOub13iVXRztUQcDY4gyfYRZx+f05aYYA0di7yjlxwap5G2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878650; c=relaxed/simple;
	bh=FwyocT23P2ZBQV7I2j1YtltD7RvOJSqqLqEZaqt92fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2Vx40RoxrSRvnnvaPIFRe8N9E+ZQ1IXXuRsuXULLWij50sb32sHoP6Tk7KiYFaLvnfDli3WV1Y6PniU1wG6lY6TZKNIOxC0y2ciKYpy32K/G6sRLndWGN0G8x6FC8pYntIY+l15NV9snPDyHh+K3rvuYL8d1A7Cu/B+zQYE3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B60A497;
	Wed,  2 Oct 2024 07:17:58 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.64.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96CA23F58B;
	Wed,  2 Oct 2024 07:17:26 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 2/2] irqchip/gic-v3-its: Rely on genpool alignment
Date: Wed,  2 Oct 2024 15:16:30 +0100
Message-Id: <20241002141630.433502-3-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002141630.433502-1-steven.price@arm.com>
References: <20241002141630.433502-1-steven.price@arm.com>
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
index 7a62fd3a8673..1d2a952e342d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -712,7 +712,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_node *its,
 	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
 
 	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
-	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
 
 	its_encode_cmd(cmd, GITS_CMD_MAPD);
 	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
@@ -3501,7 +3500,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 */
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
-	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
+	sz = max(sz, ITS_ITT_ALIGN);
 
 	itt = itt_alloc_pool(its->numa_node, sz);
 
-- 
2.34.1


