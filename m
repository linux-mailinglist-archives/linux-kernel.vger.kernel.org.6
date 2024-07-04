Return-Path: <linux-kernel+bounces-241063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A79276A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50068283273
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8D1AE849;
	Thu,  4 Jul 2024 13:00:33 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9D41A81
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098033; cv=none; b=gXH54fBI8nyQCmk9cCs1/BkVU18KLmGBGxgEMnyisb03CxEhx7Ve7GK2Pnvlb4aFrvQ4lTnSZCrgM0PGjAHyxWZUfzv3BH/X7rYqJb5WLr9uWP/W0lFDk9RqFOF0GmRoetrbfn9mODX18GXbLKKlRYACn10Z60XACBa79g8K9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098033; c=relaxed/simple;
	bh=YYVhrcsfZ0vEB6KqnZlngZZFqp5pxACsU+ykzL+008A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IKJuiCCcVnREPTQMPoGQ2Nqo7qRJwZFx+snFeCweUQQAKsKZEN/4dup4EyKY+evwAVnb6ykaqWTUIc0yB2Sfusoj4QAWUti3qoRqNUwfVluXiNDKvKRnIWmIGQoMpy49XIOnicx858HX79bEU/kFsq9gUX8NillqcLQEAP28rU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACXncngnIZm316NAQ--.1350S2;
	Thu, 04 Jul 2024 21:00:24 +0800 (CST)
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
	dillon.varone@amd.com,
	roman.li@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH RESEND] drm/amd/display: Check pipe_ctx before it is used
Date: Thu,  4 Jul 2024 21:00:15 +0800
Message-Id: <20240704130015.295645-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXncngnIZm316NAQ--.1350S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtry7XrWUur15AryfWFy8Xwb_yoWkArc_KF
	429r95tF47CF1DAa4jyr4ru3ySya1kurWkWF9FvayS9r17Wry8Z34IvrZ8Wr18ZFnrJa4D
	A34DKFyru3sxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUrBMNUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

resource_get_otg_master_for_stream() could return NULL, we
should check the return value of 'otg_master' before it is
used in resource_log_pipe_for_stream().

Fixes: 5db346c256bb ("drm/amd/display: update pipe topology log to support subvp")
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


