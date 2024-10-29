Return-Path: <linux-kernel+bounces-386915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A39B49A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E492B224DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B1205E3F;
	Tue, 29 Oct 2024 12:27:19 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B239205ADB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204838; cv=none; b=OatZNpDcf0x8MAQMNf+5Jleu8x+kL0Q9aCflCImlSyyuczUcHzM96dP5pEXsePBu8PntU7I/gYE8k9M3rYh42r2iJ3QcUbea1rQAVBgcciYkinuGOVUL6yVO3tsY4g98/MefRNMNdr0k+EOHcE/YejLkyNi3QokNRnrX44JPUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204838; c=relaxed/simple;
	bh=7mhiZmY2GL+llId5mUHpE9T/ZEU+bn/887f9XiB2SFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eomS1zC8SW/SSaJ6HVlP9ct7SK1qLjO13SaPTGJMETnnjj19RdXHGRx5DHrLzNrLVMFglnuRcC4QQZNJBEejFeLfmUJGVArN+3X+dTx4LJii3BcbazMST4Mg/f2ST+5S5X/gWgLE0Loy+qU6iMwZBh1yNDQrwzX6J4tj6drpAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xd8bw6bhnz1SCwB;
	Tue, 29 Oct 2024 20:25:32 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BEC714013B;
	Tue, 29 Oct 2024 20:27:04 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 20:27:03 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>,
	<christophe.jaillet@wanadoo.fr>
CC: <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Hawking.Zhang@amd.com>, <yifan1.zhang@amd.com>,
	<Likun.Gao@amd.com>, <Tim.Huang@amd.com>, <pratap.nirujogi@amd.com>,
	<victorchengchi.lu@amd.com>, <Jun.Ma2@amd.com>, <le.ma@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH v3] drm/amdgpu: Fix the memory allocation issue in amdgpu_discovery_get_nps_info()
Date: Wed, 30 Oct 2024 04:27:58 +0800
Message-ID: <20241029202758.2764535-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Fix two issues with memory allocation in amdgpu_discovery_get_nps_info()
for mem_ranges:

 - Add a check for allocation failure to avoid dereferencing a null
   pointer.

 - As suggested by Christophe, use kvcalloc() for memory allocation,
   which checks for multiplication overflow.

Additionally, assign the output parameters nps_type and range_cnt after
the kvcalloc() call to prevent modifying the output parameters in case
of an error return.

Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v3: 
 - As suggested by Christophe, replace kvzalloc() with kvcalloc()
 - Link to v2: https://lore.kernel.org/lkml/20241029101839.2605713-1-lihuafei1@huawei.com/

Changes in v2:
 - kvzalloc() call uses 'nps_info->v1.count' instead of '*range_cnt'
 - Link to v1: https://lore.kernel.org/lkml/20241028215933.2599271-1-lihuafei1@huawei.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4bd61c169ca8..620090f092ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
 	case 1:
+		mem_ranges = kvcalloc(nps_info->v1.count,
+				      sizeof(struct amdgpu_gmc_memrange),
+				      GFP_KERNEL);
+		if (!mem_ranges)
+			return -ENOMEM;
 		*nps_type = nps_info->v1.nps_type;
 		*range_cnt = nps_info->v1.count;
-		mem_ranges = kvzalloc(
-			*range_cnt * sizeof(struct amdgpu_gmc_memrange),
-			GFP_KERNEL);
 		for (i = 0; i < *range_cnt; i++) {
 			mem_ranges[i].base_address =
 				nps_info->v1.instance_info[i].base_address;
-- 
2.25.1


