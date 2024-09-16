Return-Path: <linux-kernel+bounces-330674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32E97A295
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E44AB25AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87790154C19;
	Mon, 16 Sep 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="cT3PlXSr"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FB14D2B3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491304; cv=none; b=qQEmZ9A8lZLkFjKRi5zJ9CH1nmXLq6+hcmv8Y/+04chcYG4ULJdIOh8SWYAk76maHypAZ/aDlrnfK+OwNUxbmQTTEXfRn3CHiqp1X4I1IcTkX7/xXpfMJegLT17jL8m2OTpUrJZGthmGiUIVoN11TEKgoD33ukh+YBYr01JTgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491304; c=relaxed/simple;
	bh=LnO0JNIansUrMbzfXU5umY+44k8cAt6InLj0VkTrFiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la4Ryy3Rvq6zfn7qPJMbtnyk/+RwIUHRVbHy8beRmBwEe7qUGBYExE/3ASBpl7sp1uKQvh4J9UffLp9AdTYnm3BFDcCIye73rNN5/Jo9OWvailU1fXgAshX1zxebsKWBjApknWFyopvovs4Gk+DhF60H4KpI4c36wJC8JB4km70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=cT3PlXSr; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1726491291;
	bh=LnO0JNIansUrMbzfXU5umY+44k8cAt6InLj0VkTrFiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cT3PlXSryBRL9EQ8zlz5fe6oTOmA8d3RB6jVRdoASZLISrfqGDRfrgJBzHmm3HdBZ
	 Wg6bTo6MyVDChtBjdqwruSZAhNjV24lZGsvxx/0EJmzJNTZcx0UAc+E7pGJUPYXWWv
	 x3cYEYkfOSC4+n5XpyAxIibbOnT3SZkqAImg0NVObtptKi2u5AbyKSKKJDLKrk0uZI
	 0gw+1HNPIXW8KUPGjdAALT8MVgQqlcFlRodrKiR+k0d2cm5XixfIeloBnsz9OCiPcy
	 k+shI8fKMfak1wmiSNEGPv0T0SPlkIAYUJMDUnnM8BYGjAlUwl/IEfpZ5WLygsd9IZ
	 sZrmsQJiHVFUw==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 9271720F3D;
	Mon, 16 Sep 2024 14:54:51 +0200 (CEST)
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
Subject: [PATCH 1/1] drm/amd/display: handle nulled pipe context in DCE110's set_drr()
Date: Mon, 16 Sep 2024 14:54:05 +0200
Message-ID: <24dcaa14eba59e211355d4798df02ccb64d460ba.1726490926.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <cover.1726490926.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1726490926.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

As set_drr() is called from IRQ context, it can happen that the
pipe context has been nulled by dc_state_destruct().

Apply the same protection here that is already present for
dcn35_set_drr() and dcn10_set_drr(). I.e. fetch the tg pointer
first (to avoid a race with dc_state_destruct()), and then
check the local copy before using it.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3142
Fixes: 06ad7e164256 ("drm/amd/display: Destroy DC context while keeping DML and DML2")
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 0d3ea291eeee..666dfc6d192e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1970,13 +1970,20 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 	 * as well.
 	 */
 	for (i = 0; i < num_pipes; i++) {
-		pipe_ctx[i]->stream_res.tg->funcs->set_drr(
-			pipe_ctx[i]->stream_res.tg, &params);
-
-		if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
-			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
-					pipe_ctx[i]->stream_res.tg,
-					event_triggers, num_frames);
+		/* dc_state_destruct() might null the stream resources, so fetch tg
+		 * here first to avoid a race condition. The lifetime of the pointee
+		 * itself (the timing_generator object) is not a problem here.
+		 */
+		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
+
+		if ((tg != NULL) && tg->funcs) {
+			if (tg->funcs->set_drr)
+				tg->funcs->set_drr(tg, &params);
+			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
+				if (tg->funcs->set_static_screen_control)
+					tg->funcs->set_static_screen_control(
+						tg, event_triggers, num_frames);
+		}
 	}
 }
 
-- 
2.44.2


