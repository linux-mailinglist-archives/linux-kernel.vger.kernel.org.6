Return-Path: <linux-kernel+bounces-269155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193B942E69
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B72528A839
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A351AE85F;
	Wed, 31 Jul 2024 12:29:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CC1AB516
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428941; cv=none; b=Ie/LPQvJGz58VQ0sBeViG1VuTd6q5Ao9UGgXxxHlTkOLG1H6SUbRfzKZyXV/k2p3lRLCBCpfBpACaa4BaVlmTQTpdJxSpd2E3GDdl/Hcmprsj/lmoSAzvbq42vz1viFEbujHV68PfzThzfj650fK8Z/qS88uGPGUkcOFbpCY3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428941; c=relaxed/simple;
	bh=tQkEMLicAtzugyMacODmoLe4eruRUJj7jwiJTgB10z8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J62hjTTB8eIP4qxQUfT7O521jmk85sEnf4I/tNerNSd6E86r0TQsgkeHZotm6TUBmdGQBuekvOBWFnNC4WKyC7ef22sQWf1RxVY2/4vMLr9WACB+FPq2SqjZOweLyyxz2yQOSMMuT/zlk8wqTDD689/mhBgacmm36+rw+GcSJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYrvF6NC4zgYWY;
	Wed, 31 Jul 2024 20:27:05 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A483180101;
	Wed, 31 Jul 2024 20:28:56 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 31 Jul
 2024 20:28:55 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <hch@lst.de>, <ira.weiny@intel.com>,
	<dlemoal@kernel.org>, <hare@suse.de>, <axboe@kernel.dk>
CC: <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvdimm/pmem: Set dax flag for all 'PFN_MAP' cases
Date: Wed, 31 Jul 2024 20:25:30 +0800
Message-ID: <20240731122530.3334451-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

The dax is only supportted on pfn type pmem devices since commit
f467fee48da4 ("block: move the dax flag to queue_limits"), fix it
by adding dax flag setting for the missed case.

Fixes: f467fee48da4 ("block: move the dax flag to queue_limits")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/nvdimm/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1ae8b2351654..210fb77f51ba 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -498,7 +498,7 @@ static int pmem_attach_disk(struct device *dev,
 	}
 	if (fua)
 		lim.features |= BLK_FEAT_FUA;
-	if (is_nd_pfn(dev))
+	if (is_nd_pfn(dev) || pmem_should_map_pages(dev))
 		lim.features |= BLK_FEAT_DAX;
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
-- 
2.39.2


