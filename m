Return-Path: <linux-kernel+bounces-230790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395849181ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7B4285B82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36918411D;
	Wed, 26 Jun 2024 13:07:19 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC4181D1B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407239; cv=none; b=D8KubkZjhIo6wbqg0qfDi9KrRHIH+izFSqXL5TsNi4t69q65yil9Y40M9XYt5cXREgpuzHbZg3XvcISuQAxYJ4XV/Ax6wW9Bv28ZhGmkmBU9d/nb+1Hcovhlw5unbx0JTJ/+eWJG+y1UGWE2tXFxw7EUchBAVcAHEgXCLNUWMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407239; c=relaxed/simple;
	bh=AnX1gDtL0IQAx9+Sy3bf0fMoaFEkM6urkZKsa6ZShHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fvcBMCxHTm1IFNxIUJ/sqkBYQYz3zfbcZQreUTS+8bNwTf9ZWZh1AXy2P0OPmNof+D70JWiDEj/cNbtu5di2WUjCWoAlpbKM4Dk+hO2e3z4NebildyrWUN2qAgyyeG73Jh2PbBhZVXv0AuOUXrDrJ8Ci24dZbx9bDTIByRnEPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowABXN0xsEnxmiXAGAA--.1461S2;
	Wed, 26 Jun 2024 21:07:02 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jun.lei@amd.com,
	wayne.lin@amd.com,
	dillon.varone@amd.com,
	nicholas.kazlauskas@amd.com,
	Qingqing.Zhuo@amd.com,
	stylon.wang@amd.com,
	make24@iscas.ac.cn
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Add null check before access structs
Date: Wed, 26 Jun 2024 21:06:50 +0800
Message-Id: <20240626130650.2866706-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXN0xsEnxmiXAGAA--.1461S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1UtFW5Kry3XF4xCryrtFb_yoWDXrc_K3
	WUZrWftryUC3Z09F1YyrnxuFyF93yrZF4vqwn7KF9ayryxZFyxZ3yxXrW8Wr18ZrZrtFyD
	Aa9F93Z5JwnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUShFxUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In enable_phantom_plane, we should better check null pointer before
accessing various structs.

Fixes: 09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
index 282d70e2b18a..3d29169dd6bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
@@ -750,6 +750,8 @@ static void enable_phantom_plane(struct dml2_context *ctx,
 					ctx->config.svp_pstate.callbacks.dc,
 					state,
 					curr_pipe->plane_state);
+			if (!phantom_plane)
+				return;
 		}
 
 		memcpy(&phantom_plane->address, &curr_pipe->plane_state->address, sizeof(phantom_plane->address));
-- 
2.25.1


