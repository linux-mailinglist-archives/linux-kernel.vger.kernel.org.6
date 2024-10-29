Return-Path: <linux-kernel+bounces-386197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30B9B404D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA57A1F23328
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3EE4AEE0;
	Tue, 29 Oct 2024 02:17:59 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37A4204F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168279; cv=none; b=PKK/CZopOCsFVwvuJCmeyPn9rvTVamZT86hlg2brxfWHF3CinJbNGBMORjIttesa/R8fYpSD07+568z0m+vbtTqzEFlogXFukXz7AJuul9qwZNyduI7CeXQ27aWXZ3CyIq1PI6NGHaV+Zgs0DQIH/uxshcn3U/QORICa4kfwvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168279; c=relaxed/simple;
	bh=Koug5sk641LpFuN3VwGNzIhzIGAy+THCOvJ4FFp1cNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ix1qCOOdT9wN8ylPsj2MsDSLJDSbt5BEo6a9++UIeINcwxZB3osFug+g1V8fQDU8NKWSqiiquSx+LW1AQRGdIUBLhdp48fbifPrRAVh8ODhTauqOCQ+9SXzstM/eDC3g0o/YS1Ty7Age8rkSjUa8wJwkLB1yJp0+eWt/WPSALaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xcv4w0FmBz1jw4v;
	Tue, 29 Oct 2024 10:16:16 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F62140391;
	Tue, 29 Oct 2024 10:17:46 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 10:17:45 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>
CC: <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Hawking.Zhang@amd.com>, <yifan1.zhang@amd.com>,
	<Likun.Gao@amd.com>, <Tim.Huang@amd.com>, <pratap.nirujogi@amd.com>,
	<victorchengchi.lu@amd.com>, <Jun.Ma2@amd.com>, <le.ma@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH v2] drm/amdgpu: Fix possible NULL pointer dereference
Date: Tue, 29 Oct 2024 18:18:39 +0800
Message-ID: <20241029101839.2605713-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Fix the potential NULL pointer dereference on mem_ranges in
amdgpu_discovery_get_nps_info(). Additionally, assign the output
parameters nps_type and range_cnt after the kvzalloc() call to prevent
modifying the output parameters in case of an error return.

Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v2:
 - kvzalloc() call uses 'nps_info->v1.count' instead of '*range_cnt'
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4bd61c169ca8..9a0b1b208a9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
 	case 1:
-		*nps_type = nps_info->v1.nps_type;
-		*range_cnt = nps_info->v1.count;
 		mem_ranges = kvzalloc(
-			*range_cnt * sizeof(struct amdgpu_gmc_memrange),
+			nps_info->v1.count * sizeof(struct amdgpu_gmc_memrange),
 			GFP_KERNEL);
+		if (!mem_ranges)
+			return -ENOMEM;
+		*nps_type = nps_info->v1.nps_type;
+		*range_cnt = nps_info->v1.count;
 		for (i = 0; i < *range_cnt; i++) {
 			mem_ranges[i].base_address =
 				nps_info->v1.instance_info[i].base_address;
-- 
2.25.1


