Return-Path: <linux-kernel+bounces-173973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4E8C088A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55042830C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF6522089;
	Thu,  9 May 2024 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="scEcmSPu"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FB11187
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215359; cv=none; b=E943gxBqK/KA+veGFB84nfLoy3gYmet+hfH6I8Pr0i252uqR40G5yTNlt9MNFxlqOxm2L6EtQkc4IxLGOmx2/BdOs1MXhAPAHoGhG6N2q2WGcFxmhQjkvC4OhL2zIg1HlAJhfZDdTp6munHzEEkqJaBHh2ok6fmmpcIySNTpwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215359; c=relaxed/simple;
	bh=TPb2KrzVa/M4U4qQEv+XPFeb6ImczDK45yEo2LsRBEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmB00b7RPuouAKftmUkCRNd9pBy1tFrnC8dgkg+xnngg7MEjO7goBo+WTvWHRaRis4jw92PSrLQXqaWr1KW+MAKyXieS2Iy9mQogmTifiLODynWCSrsGjFcc+baxLXRyp9QEIp7DQJu7zFZg360/7QVVGDoWhGRye/KqKyaPNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=scEcmSPu; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715215353; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wVO/HJhR3CVVe/+QfkVvjqCqjwnhqXmuIyFXGYZw6CA=;
	b=scEcmSPuiroWtG0Wgy12ggMU0jSORvXlS5LydQ50GZaNOoSTCADJ4EAK381LTTjWPqyxT3S5VKS6znRXE6H56j1We44FdVXxO4NGXa8oeOMa2XXBbFcEBNwY+0wrtPgCFCI3DWKoJTnkbpeHUMo8sfBTw6rv9zs8NRyHYqIpTAM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=llfl@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W64weoP_1715215351;
Received: from localhost(mailfrom:llfl@linux.alibaba.com fp:SMTPD_---0W64weoP_1715215351)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 08:42:32 +0800
From: "Kun(llfl)" <llfl@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/amd: Fix sysfs leak in iommu init
Date: Thu,  9 May 2024 08:42:20 +0800
Message-ID: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>
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

Fixes: 39ab9555c241 ("iommu: Add sysfs bindings for struct iommu_device")
Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
---
 drivers/iommu/amd/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ac6754a85f35..82a54898194a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1678,8 +1678,17 @@ static void __init free_pci_segments(void)
 	}
 }
 
+static void __init free_sysfs(struct amd_iommu *iommu)
+{
+	if (iommu->iommu.dev) {
+		iommu_device_unregister(&iommu->iommu);
+		iommu_device_sysfs_remove(&iommu->iommu);
+	}
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


