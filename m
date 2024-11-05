Return-Path: <linux-kernel+bounces-396551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2C9BCECC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441AC28380B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C91D935E;
	Tue,  5 Nov 2024 14:12:50 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078331D5AB2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815970; cv=none; b=WdQGclVw8LwQ8n5ZmoVVKkbspV0l32lbQLkTXNNGlcGw9FNzYhHkh41DCdmMGr1NF3RCt7TlndTP6zICezv4MnZWXopEhZmwIBcKYoKwPN1hmUq2Fp9vq2oP5JSNEqAuoCvftGaXgs7QjemLejscoEoI6ZK4Besdq7aDXAeYlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815970; c=relaxed/simple;
	bh=3ARecU0HmFg8QXgNQwLuBzW3IAx4FalzghCZYRWGTtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEnk2Cdo1cLd3bORH+c6FVS34L7zbCtIAmQrDjQLTboFu+TmnjIzZ3/zI7EDE0Re/zxp91fUTSWHf62V6Keq99QNwXnMuUn9Cr6vC0dgsTvnmqQ6HUG16MmBuUOl10Xz+D9ILo70szCpLXv5PX4C3CX0/AqEH54w77PIKKGeLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XjVfT4mnlz1ypGn;
	Tue,  5 Nov 2024 22:12:49 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id B27391402E2;
	Tue,  5 Nov 2024 22:12:39 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 5 Nov
 2024 22:12:38 +0800
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
Subject: [PATCH 1/2] drm/amd/display: Fix null check for pipe_ctx->plane_state in dcn20_program_pipe
Date: Tue, 5 Nov 2024 14:01:36 +0000
Message-ID: <20241105140137.2465572-2-quzicheng@huawei.com>
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
dcn20_program_pipe(). Previously, commit 8e4ed3cf1642 ("drm/amd/display:
Add null check for pipe_ctx->plane_state in dcn20_program_pipe")
partially fixed the null pointer dereference issue. However, in
dcn20_update_dchubp_dpp(), the variable pipe_ctx is passed in, and
plane_state is accessed again through pipe_ctx. Multiple if statements
directly call attributes of plane_state, leading to potential null
pointer dereference issues. This patch adds necessary null checks to
ensure stability.

Fixes: 8e4ed3cf1642 ("drm/amd/display: Add null check for pipe_ctx->plane_state in dcn20_program_pipe")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a80c08582932..36d12db8d022 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1923,9 +1923,9 @@ static void dcn20_program_pipe(
 				dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->hubp_regs.det_size);
 	}
 
-	if (pipe_ctx->update_flags.raw ||
-	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.raw) ||
-	    pipe_ctx->stream->update_flags.raw)
+	if (pipe_ctx->plane_state && (pipe_ctx->update_flags.raw ||
+	    pipe_ctx->plane_state->update_flags.raw ||
+	    pipe_ctx->stream->update_flags.raw))
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
 
 	if (pipe_ctx->plane_state && (pipe_ctx->update_flags.bits.enable ||
-- 
2.34.1


