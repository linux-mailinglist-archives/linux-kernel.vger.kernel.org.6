Return-Path: <linux-kernel+bounces-396557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E4A9BCED7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0070D1C22646
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D741D89E2;
	Tue,  5 Nov 2024 14:14:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9911D47B4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816044; cv=none; b=TjhcbOyFPLBEa7oeYHozTDAetQg5JCxPmB8HJeR1Fka3XZT+RG8/yHnYWsdR7tnneJVR2birPVZl+k4/ORZv1tupDYJ/UC6vLZGt8V5z0BnHL4Cuc4Odxh4jZ10RRlrJW/roTcZwI9nrpl0JOcPI3u901hr72Hkx4x+cfK9jbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816044; c=relaxed/simple;
	bh=HE8vRuBCo5xd2lYT7uDjw2wR7SGFV++W8f1tPdlfhqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkXSb19GY/Wu1cW/aFqa0y+4p8jQrj6oWs6Ga3zqeUwwgFQ8EoeHW1N+ihZ1riicBAAupaGN2pb7GNUif0C9066CgysfvN8T4h5ExKy72bJRTKxFrv2FXTHP/RiToblD1QBrEltnIfttcQwrg8DkgMg80M7bdFV8N7TG9XirlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XjVdv6nMqz2Fbrp;
	Tue,  5 Nov 2024 22:12:19 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id E1AC014011F;
	Tue,  5 Nov 2024 22:13:59 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:13:58 +0800
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
Subject: [PATCH 2/2] drm/amd/display: Fix incorrect power gating configuration for DOMAIN11
Date: Tue, 5 Nov 2024 14:02:56 +0000
Message-ID: <20241105140256.2465614-3-quzicheng@huawei.com>
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

The current implementation incorrectly updates DOMAIN11_PG_CONFIG with
DOMAIN9_POWER_FORCEON, which is not the intended behavior. This patch
corrects the power gating configuration by updating DOMAIN11_PG_CONFIG
with DOMAIN11_POWER_FORCEON, preventing potential issues related to
power management.

Fixes: 46825fcfbe16 ("drm/amd/display: avoid power gate domains that doesn't exist")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 67a77274d813..bc21eb0b2760 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -327,7 +327,7 @@ void dcn20_enable_power_gating_plane(
 	if (REG(DOMAIN9_PG_CONFIG))
 		REG_UPDATE(DOMAIN9_PG_CONFIG, DOMAIN9_POWER_FORCEON, force_on);
 	if (REG(DOMAIN11_PG_CONFIG))
-		REG_UPDATE(DOMAIN11_PG_CONFIG, DOMAIN9_POWER_FORCEON, force_on);
+		REG_UPDATE(DOMAIN11_PG_CONFIG, DOMAIN11_POWER_FORCEON, force_on);
 
 	/* DCS0/1/2/3/4/5 */
 	REG_UPDATE(DOMAIN16_PG_CONFIG, DOMAIN16_POWER_FORCEON, force_on);
-- 
2.34.1


