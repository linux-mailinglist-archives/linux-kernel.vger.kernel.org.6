Return-Path: <linux-kernel+bounces-385094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DA9B3252
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08D1B21100
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90281DD535;
	Mon, 28 Oct 2024 13:58:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95021DB52A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123929; cv=none; b=Dk3vs55WMA0SwaZSlBFqpjhJWgEMB+GCTrUCPWyWNah6qUyxkO42FUwo01VD5EfZ1dTegLlQBVJ/0TdzxrjxJsY/2w5G5KZz6bMzesuelY1ucRMm7HpeVy41ILyN1AoTJvkczrrXRE5LhWOZw4QQ4onZQDGHj6IzcMIAwZhYMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123929; c=relaxed/simple;
	bh=CzPJKqRFgxQIOChIsN+VVVQn9UyNCPT8yy2n4R5bs14=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsWyGmruP7LJkQIHxGn8uCuWXsF0/yoF4hpjzL8El5g2L3LrRNCrtc7f60+g9HVNVXnPeaFBvoO0brlDhuDXhIO+ZnfQe+Sh6GW05Gn89WxShzS0FAnF6Pyep5i2Qtm5X6aYo3V4YS5mX8v8R9wtU6rCBLTVB66L9VysIgvQbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XcZfv6FFzzfbY3;
	Mon, 28 Oct 2024 21:56:07 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 97CF8140135;
	Mon, 28 Oct 2024 21:58:40 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 21:58:39 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>
CC: <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Hawking.Zhang@amd.com>, <yifan1.zhang@amd.com>,
	<Likun.Gao@amd.com>, <Tim.Huang@amd.com>, <pratap.nirujogi@amd.com>,
	<victorchengchi.lu@amd.com>, <Jun.Ma2@amd.com>, <le.ma@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH] drm/amdgpu: Fix possible NULL pointer dereference
Date: Tue, 29 Oct 2024 05:59:33 +0800
Message-ID: <20241028215933.2599271-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Fix the potential NULL pointer dereference on mem_ranges in
amdgpu_discovery_get_nps_info(). Additionally, assign the output
parameters nps_type and range_cnt after the kvzalloc() call to prevent
modifying the output parameters in case of an error return.

Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4bd61c169ca8..1b1aedebb3c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
 	case 1:
-		*nps_type = nps_info->v1.nps_type;
-		*range_cnt = nps_info->v1.count;
 		mem_ranges = kvzalloc(
 			*range_cnt * sizeof(struct amdgpu_gmc_memrange),
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


