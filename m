Return-Path: <linux-kernel+bounces-296745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3A95AE73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D78281E98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42FA13B5B7;
	Thu, 22 Aug 2024 07:11:51 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC04206A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310711; cv=none; b=YCzbRgQPkTLHUsMeLZ/ebmVtX7HcXGWDsX6zEbiFwCsYNwCwud5cCspq918BdAbK++nKMnlmECBbhLqg+Q3CCowzsyIeFmwiQ0R/KVQPh7xmFhOycCpNqYuJM3g1czEcuMpF1Rn4Cu5LCgR6Mk/BdbkKSNSKRHEH7B02M4IqJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310711; c=relaxed/simple;
	bh=k+OARink3Sd5ABEWoXoLiOg6VmZ93CyU7zwPnPNIfFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/qi8clQzpqON7yk8idAthIaea6I3E6EjtGqhq+smP90ibmyYX01JEekLEYHqVK2tuAZ8c5AK1jsahZf6L7hfB9UaFdqrFT/PZqh1GnGNTs7Oeo42B8/gzLVJd863sxYAVQDdZysM/Oe2DJmXVv2k8/2NmgFU2CIN5agZgi+u4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqDlp3VlXz69M4;
	Thu, 22 Aug 2024 15:07:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 80C6A140553;
	Thu, 22 Aug 2024 15:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 15:11:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Date: Thu, 22 Aug 2024 15:19:16 +0800
Message-ID: <20240822071916.3547318-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/nvme/target/debugfs.c:16:15: warning:
	symbol 'nvmet_debugfs' was not declared. Should it be static?

This symbol is not used outside debugfs.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/nvme/target/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index cb2befc8619e..220c7391fc19 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -13,7 +13,7 @@
 #include "nvmet.h"
 #include "debugfs.h"
 
-struct dentry *nvmet_debugfs;
+static struct dentry *nvmet_debugfs;
 
 #define NVMET_DEBUGFS_ATTR(field) \
 	static int field##_open(struct inode *inode, struct file *file) \
-- 
2.34.1


