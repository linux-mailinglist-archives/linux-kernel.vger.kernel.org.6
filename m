Return-Path: <linux-kernel+bounces-310976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91996837D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F039CB211D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0151D0DDE;
	Mon,  2 Sep 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="PxhobTo3"
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570818661C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270168; cv=none; b=EfoU7wae0Y8CoU/ftkJ33DcqPd0QymB26bhYg1HDlngVE8x/AShktnSjzUrnXbO6w4xC9+Pjpo3+t/0CXYb52XP9bykU+0Fk23t6S2/UoLP2Rw+SeQzkiYKKl3PaODbrzjTfKhPrZOCi6i2HvnJCQ1V6ufzxIZXYeNfcQQZW/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270168; c=relaxed/simple;
	bh=OlHUmE2mWnpkfcvXYamxHN5q0GeOY6PdRc6d9KkwM28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLc/Dex3OqRKm+esZsBrPXvwPtJqy039UYwQMWn3YmkgFjVHlkwCFHGCy1O9cblLvplg3081Huhz2ghNmuLOsDT/LwibyYpvq4O/T1zZGuhu/A89Cq+1cEWDWL/2EyAg0dU3t4hxhywSvG70un/aWH4348Hu7z4JD2jv4rAfA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=PxhobTo3; arc=none smtp.client-ip=129.70.45.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1725270163;
	bh=OlHUmE2mWnpkfcvXYamxHN5q0GeOY6PdRc6d9KkwM28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxhobTo34c9OgoeDCdYgmwTNIlFUqpQKQOEl5R38TVuQv6lAQOLtWcgesSMA5mqK3
	 /Pcll18vAVcyeKzuD2cegIT/of0J1un6UNsMsnozrwQ/XRC6PFovPmhRi44ktLpQJC
	 0/ci/Idbi5rtewd/c3+g44D5Ee6g7Y+ahRF/+okViVJo2YrdX2DLeKcOYkWUkglAIo
	 zTERcuBa0RgZzInmUWcj37oE7pcUQDBK3YCAYyGbDragDLGzP+CmhoqM4NafskuFR2
	 Ax0GGBc0wjpSmsgSx5W3XOu9EAzH3BQhXeHzEwDK7/cc2owFWRCeO4xT4XFBZSO/Cw
	 F2oTmHvU4RvzA==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 7603B2098B;
	Mon,  2 Sep 2024 11:42:43 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: Avoid race between dcn35_set_drr() and dc_state_destruct()
Date: Mon,  2 Sep 2024 11:40:27 +0200
Message-ID: <fd879fd0595e9e7e47c3442da10a5aede21bf895.1725269643.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

dc_state_destruct() nulls the resource context of the DC state. The pipe
context passed to dcn35_set_drr() is a member of this resource context.

If dc_state_destruct() is called parallel to the IRQ processing (which
calls dcn35_set_drr() at some point), we can end up using already nulled
function callback fields of struct stream_resource.

The logic in dcn35_set_drr() already tries to avoid this, by checking tg
against NULL. But if the nulling happens exactly after the NULL check and
before the next access, then we get a race.

Avoid this by copying tg first to a local variable, and then use this
variable for all the operations. This should work, as long as nobody
frees the resource pool where the timing generators live.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3142
Fixes: 06ad7e164256 ("drm/amd/display: Destroy DC context while keeping DML and DML2")
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index dcced89c07b3..4e77728dac10 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1370,7 +1370,13 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 	params.vertical_total_mid_frame_num = adjust.v_total_mid_frame_num;
 
 	for (i = 0; i < num_pipes; i++) {
-		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
+		/* dc_state_destruct() might null the stream resources, so fetch tg
+		 * here first to avoid a race condition. The lifetime of the pointee
+		 * itself (the timing_generator object) is not a problem here.
+		 */
+		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
+
+		if ((tg != NULL) && tg->funcs) {
 			struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
 			struct dc *dc = pipe_ctx[i]->stream->ctx->dc;
 
@@ -1383,14 +1389,12 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 					num_frames = 2 * (frame_rate % 60);
 				}
 			}
-			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
-				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
-					pipe_ctx[i]->stream_res.tg, &params);
+			if (tg->funcs->set_drr)
+				tg->funcs->set_drr(tg, &params);
 			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
-				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
-					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
-						pipe_ctx[i]->stream_res.tg,
-						event_triggers, num_frames);
+				if (tg->funcs->set_static_screen_control)
+					tg->funcs->set_static_screen_control(
+						tg, event_triggers, num_frames);
 		}
 	}
 }
-- 
2.44.2


