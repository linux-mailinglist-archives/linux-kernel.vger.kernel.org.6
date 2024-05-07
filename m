Return-Path: <linux-kernel+bounces-170588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3698BD96C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0271F226FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEAEC122;
	Tue,  7 May 2024 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vZvR0cy+"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F42522F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049179; cv=none; b=mQhjtxMKVkRTIsOV6OAYPFvgPNqcYhFO0+pPxNZgjNHR+mcfUOPKWkuZgESzQq3SWGEz93YjJbLms/BhZuUT6cgZqkMdCM+V+CWbyaqjaV32LZMe/hRleIFZr/CILBkh/hA/3qScvfwyKZi5EDZVXYKap7Pk4B50KYpvj28YNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049179; c=relaxed/simple;
	bh=JUguHETqDOP1NC6kHcDcEM/JVS6Ow91MUipMFCyoUnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu73rLxxtv4NElQfjE7GeLSohkqMcoe/Rt28uz0KSNgZO07+arxfu2pmv+NgQ/OE4z8STWy3awwmS5KqUGSd/kQL0YUzMRRFBWpFfU6a5aihw606lNKyAmAGUp5j00lYBYjXKlhtvvBRKXGG3XGkVl3TmDRRz2FuJD4OrIk0G2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vZvR0cy+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715049166; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qTEkl+KBoQB5V/RVkcEJU2StJ0o4KM0JoH9OvRriiec=;
	b=vZvR0cy+EgKv71mIiI3Wu+tHxlm+4Lui8GkfaEO46Hif5qU/Lt/lm/NR80A9FXJLeb3ZBCpFA8LYB0c+79oTih1nBtiMNGoNfS/CPPTzOppQXX8OYHWzuKI6l4LkZ3W5+QIAiuEDjpaF76dfMxS/GFZoKmo9m0Fe9B043rfOrGE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=llfl@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W6-XnSs_1715049164;
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0W6-XnSs_1715049164)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 10:32:46 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iommu/amd: Fix sysfs leak in iommu init
Date: Tue,  7 May 2024 10:32:15 +0800
Message-ID: <4d516a6500ea0760e13cc19e2b14e663aa333518.1715048443.git.llfl@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the iommu initialization, iommu_init_pci() adds sysfs nodes.
However, these nodes aren't remove in free_iommu_resources() subsequently.

Fixes: ad8694bac410 ("iommu/amd: Move AMD IOMMU driver into subdirectory")
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
---
 drivers/iommu/amd/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..624ea2549f64 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1678,8 +1678,15 @@ static void __init free_pci_segments(void)
 	}
 }
 
+static void __init free_sysfs(struct amd_iommu *iommu)
+{
+	if (iommu->iommu.dev)
+		iommu_device_sysfs_remove(&iommu->iommu);
+}
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	free_sysfs(iommu);
 	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
-- 
2.43.0


