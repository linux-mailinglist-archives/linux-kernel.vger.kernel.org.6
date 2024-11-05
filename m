Return-Path: <linux-kernel+bounces-396549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143129BCECA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE1B1F22DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665B81D89E2;
	Tue,  5 Nov 2024 14:12:48 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3C1D47B4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815968; cv=none; b=WHB1VbIEDDpSu6GkYS4sHY2UnnipyLcg1BEtLidGlqZlX6jSm6iv/L2wV3yDyWkfR1LnQdW8+nnStE+jBgFEbX2DX2ZfpYJu1PSSuDo39Q+atsjfc6WbBwJr+gM2d5vFDADCUrghl7lC0hrF6U4wyNiJEKOCuveNGqF39UPRUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815968; c=relaxed/simple;
	bh=SXQEx8fLTQsUgzN0AAypKZL3KqcCpTPfY8ymUkX3iL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lD97gQ9I61is8PWUblnlieLg8Df3YedOQcxp++d9B6809KukcFtnbs+AduCME24eFJRTexdqxzk0P0bFoU/n71rgkLvJkjyUkKIJcAZXwbhlhqHW/baHWUxHEEbMIEXzDaBCwCuDEbOnebcjJblOO2LAe54Xefv7Rw9OqFUxrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XjVcN6z18z1jwR8;
	Tue,  5 Nov 2024 22:11:00 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id B966F18001B;
	Tue,  5 Nov 2024 22:12:40 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:12:39 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <alexander.deucher@amd.com>,
	<christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Dillon.Varone@amd.com>, <Alvin.Lee2@amd.com>,
	<nicholas.kazlauskas@amd.com>, <alex.hung@amd.com>,
	<aurabindo.pillai@amd.com>, <relja.vojvodic@amd.com>,
	<chiahsuan.chung@amd.com>, <wenjing.liu@amd.com>, <george.shen@amd.com>,
	<mwen@igalia.com>, <yi-lchen@amd.com>, <martin.leung@amd.com>,
	<srinivasan.shanmugam@amd.com>, <stylon.wang@amd.com>, <jun.lei@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH 2/2] drm/amd/display: Fix null check for pipe_ctx->plane_state in hwss_setup_dpp
Date: Tue, 5 Nov 2024 14:01:37 +0000
Message-ID: <20241105140137.2465572-3-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105140137.2465572-1-quzicheng@huawei.com>
References: <20241105140137.2465572-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200012.china.huawei.com (7.221.188.145)

This commit addresses a null pointer dereference issue in
hwss_setup_dpp(). The issue could occur when pipe_ctx->plane_state is
null. The fix adds a check to ensure `pipe_ctx->plane_state` is not null
before accessing. This prevents a null pointer dereference.

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7ee2be8f82c4..bb766c2a7417 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -881,6 +881,9 @@ void hwss_setup_dpp(union block_sequence_params *params)
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 
+	if (!plane_state)
+		return;
+
 	if (dpp && dpp->funcs->dpp_setup) {
 		// program the input csc
 		dpp->funcs->dpp_setup(dpp,
-- 
2.34.1


