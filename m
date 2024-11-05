Return-Path: <linux-kernel+bounces-396556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4A9BCED6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45D31F23EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811851D89E3;
	Tue,  5 Nov 2024 14:14:03 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371881D86C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816043; cv=none; b=jLJAbtFw6+xRLnRNBzcCi+JaLw3YU+Mgv7LzINzD6xbI+7hSG7TWqCQhcCzPGPfdptyUs9KN/omBGEUIgc/bRU6YtE6ZLO/V0Pgwvh4RrH5Ey4QlN4HcNyOGcYkd/0aCUR+kWVHrAFRxlJobPDkRVt2Chwb6iiPj09zUdnRMYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816043; c=relaxed/simple;
	bh=JKSvejyDsua8sYUbP21pF+/kg85Bhkck/hWr67ET6ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMLwrW9MIe+KqxZrR1NN1w6PWZCh2JNpQDaHdtTApQaDOcgNxn8e6E+brtgk2zPQtBJBqzTKVI6+H9cht67gKwRks/zsGrjM0eCL1I6O6OyytY19CE9WFH5yUcQQtHJvhA6GOZfxeXq0IxycQLjE38fWFk/5nEqTgFgaheCMvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XjVh06cH5z1ynZK;
	Tue,  5 Nov 2024 22:14:08 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id F1A9B18001B;
	Tue,  5 Nov 2024 22:13:58 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:13:57 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Alvin.Lee2@amd.com>, <chiahsuan.chung@amd.com>,
	<alex.hung@amd.com>, <wenjing.liu@amd.com>, <Dillon.Varone@amd.com>,
	<george.shen@amd.com>, <mwen@igalia.com>, <yi-lchen@amd.com>,
	<martin.leung@amd.com>, <yongqiang.sun@amd.com>, <tony.cheng@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 1/2] drm/amd/display: Fix incorrect power gating configuration for DOMAIN10
Date: Tue, 5 Nov 2024 14:02:55 +0000
Message-ID: <20241105140256.2465614-2-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105140256.2465614-1-quzicheng@huawei.com>
References: <20241105140256.2465614-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200012.china.huawei.com (7.221.188.145)

The current implementation incorrectly updates DOMAIN10_PG_CONFIG with
DOMAIN8_POWER_FORCEON, which is not the intended behavior. This patch
corrects the power gating configuration by updating DOMAIN10_PG_CONFIG
with DOMAIN10_POWER_FORCEON, preventing potential issues related to
power management.

Fixes: 46825fcfbe16 ("drm/amd/display: avoid power gate domains that doesn't exist")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a80c08582932..67a77274d813 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -317,7 +317,7 @@ void dcn20_enable_power_gating_plane(
 	if (REG(DOMAIN8_PG_CONFIG))
 		REG_UPDATE(DOMAIN8_PG_CONFIG, DOMAIN8_POWER_FORCEON, force_on);
 	if (REG(DOMAIN10_PG_CONFIG))
-		REG_UPDATE(DOMAIN10_PG_CONFIG, DOMAIN8_POWER_FORCEON, force_on);
+		REG_UPDATE(DOMAIN10_PG_CONFIG, DOMAIN10_POWER_FORCEON, force_on);
 
 	/* DPP0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN1_PG_CONFIG, DOMAIN1_POWER_FORCEON, force_on);
-- 
2.34.1


