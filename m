Return-Path: <linux-kernel+bounces-226587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F89140A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8E61F22F85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FC8BE5;
	Mon, 24 Jun 2024 02:48:57 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED656523A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197337; cv=none; b=QYCEZU0DTj9ucflezbBy8je/4sGCzujsC09W6PiKJSN9sWzYCKPUzc4hTDCFooTrb6BJi0ZFZeGmAJHgDhUt43MMwkPOxzVerQ2xpnkPNjSWtxglLgCA4ZIVZUr7UQN0o3CV7GkSqO0SszImmrBYDpKCYT9mftFu7PnHLwwCRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197337; c=relaxed/simple;
	bh=my4dGlQ9gzuVDACWeB5zCgg12MA76GVh0ob5BNCwWmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SzKVudVs7KHXihuEGgBChTmqLXFAYdSP/+ycKxAMyLcQTMBf+4cBr/ZVN1GYimtJKEZHsIvkItbeEuXeTrMmuXbIz0NSMN8Fu6SbBwWS5R+6H1nxMiOzXG3VfYVzPP2Hc2DIuXYO64TZWNoZeIpGp4GK0kF6CYOPYOfc5hxSoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAC31ySF3nhmBYYkEg--.51914S2;
	Mon, 24 Jun 2024 10:48:48 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	alex.hung@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] drm/amd/display: Check pipe_ctx before it is used
Date: Mon, 24 Jun 2024 10:48:35 +0800
Message-Id: <20240624024835.2278651-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC31ySF3nhmBYYkEg--.51914S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtry7XrWUur15AryfXryxZrb_yoWDZwb_KF
	429r95JF47AF1DAa4jyr4ru3ySya1kurWkWasFvayS9r17Xry8Z342qrs8Wr1UZFnrJa4D
	Aa4DKFyru3sxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUby8BUUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

resource_get_otg_master_for_stream() could return NULL, we
should check the return value of 'otg_master' before it is
used in resource_log_pipe_for_stream().

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 15819416a2f3..597ca9f369c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2279,6 +2279,8 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 					state->stream_status[stream_idx].mall_stream_config.paired_stream);
 			otg_master = resource_get_otg_master_for_stream(
 					&state->res_ctx, state->streams[phantom_stream_idx]);
+			if (!otg_master)
+				continue;
 			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 		}
 	}
-- 
2.25.1


