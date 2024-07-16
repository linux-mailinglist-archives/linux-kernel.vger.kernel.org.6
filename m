Return-Path: <linux-kernel+bounces-253793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB72193270C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BAD1C229AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559819AD4F;
	Tue, 16 Jul 2024 13:03:17 +0000 (UTC)
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188832AE6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.246.186.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134996; cv=none; b=TvBU0hK3XE/2//kf+v+LYxVjII3kyKTHU5QrGs62Wam24ReC7m2g0I02H5qwsMhNgVndVTwy2JIKHtl+sqf6gHjc4eFdSc2U7yVi1MskNKcpV/CFTi96YwjWwBQ0bNVCJhTrRaaZUWBWXgZHx12He+UZmMQwWzfxGYAry4UimP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134996; c=relaxed/simple;
	bh=wBQVZAtEyRAncUH0l2oZWKvolfP4GGy/6DguPZSaPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaMOW5H/Lp+72dW5kjQn42Z1aYAtZRmciKw2WeYhbTEqpC20AFksiZHdvi+7XV+QUIdJW1kcaf3H6HD5sKKIdmxDVC75rDCFfZxs+7ud4uq87y3Cpj/lDcgXfJYEgJOFkQiYiGnm+dD2m9gjJplZm3AoXqc4uKZiwDPbGjyPUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru; spf=pass smtp.mailfrom=red-soft.ru; arc=none smtp.client-ip=188.246.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red-soft.ru
Received: from localhost.biz (unknown [10.81.100.48])
	by gw.red-soft.ru (Postfix) with ESMTPA id 747043E1B85;
	Tue, 16 Jul 2024 15:55:29 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: Joerg Roedel <joro@8bytes.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
Date: Tue, 16 Jul 2024 15:55:14 +0300
Message-ID: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 186538 [Jul 16 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;red-soft.ru:7.1.1;localhost.biz:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/07/16 12:37:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/07/16 03:46:00 #26020663
X-KLMS-AntiVirus-Status: Clean, skipped

In sprd_iommu_cleanup() before calling function sprd_iommu_hw_en()
dom->sdev is equal to NULL, which leads to null dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9afea57384d4 ("iommu/sprd: Release dma buffer to avoid memory leak")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/iommu/sprd-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ba53571a8239..a2f4ffe6d949 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -232,8 +232,8 @@ static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
 
 	pgt_size = sprd_iommu_pgt_size(&dom->domain);
 	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
-	dom->sdev = NULL;
 	sprd_iommu_hw_en(dom->sdev, false);
+	dom->sdev = NULL;
 }
 
 static void sprd_iommu_domain_free(struct iommu_domain *domain)
-- 
2.44.0


