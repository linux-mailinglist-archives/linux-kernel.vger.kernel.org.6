Return-Path: <linux-kernel+bounces-513177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F93A3436A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E521416BDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162D424167D;
	Thu, 13 Feb 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRQz/BMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207624166D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457852; cv=none; b=IuODevc/0YXOR0xOyKEOyzQ4fkx1g1AfCn9hzv0jUcLojYzrkclMTz2OyWFfgOV19kpEfMhErC4+UXDsHN9R8aowiI/gB/UULVJ8D42ocEve5zFFuiF+tbMTO90Y8qZT/dDfivUae+T6pgEKPrcpA5/fB9NgqlP2g+Kg72c9jME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457852; c=relaxed/simple;
	bh=yGpnS+bYKk0E6Y2+/FI6asLPESf8ZlRcD1McZsZgydY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXz6KZKvyOc1fuvx7kZiQOq7WCl9a0r2Whgxbm+IkcJoz81DgwaSPeSLKQI1qCNM0QCYx6lSVPdePA/Hx9JnHzNJITVzltHZvicozwioc0wtZ+eX3sZR5w3Gj5sRmNuXNWCn0E637KPqSwK0eTsYChHFit+FM44DX9Lc5ylDrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRQz/BMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C2FC4CEE7;
	Thu, 13 Feb 2025 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457852;
	bh=yGpnS+bYKk0E6Y2+/FI6asLPESf8ZlRcD1McZsZgydY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BRQz/BMKy+nn7SKUQdVOSM8MJBR5b2wrVf5IhHik2mtfoyduMfZCCspBD35Usd16f
	 4yeMAVJ1gcbl1Hq8cObOdWiRJPNod6hHPZQIqRxREKpQ+35FA4OeDp3t5xrqqZLltf
	 0+AqZWziQ4Cgsdi5L4kxEq/MetdKcrxt6oTbaFGKEqge7ioGC/6lt18d3i8nBWoEb9
	 Lt9t/cbtwEcQBh+yZNxxT6ErVhE/lc5h0FgXyeFlbGdMJ8m6UfOMxKL3gTF32KiHDb
	 4Fr83buywEMQ+6fITlfrYZCBQOYLA0oFXeKIaGph+frKyBmyPVHgiGTemEFMP2EuwY
	 n2z8zEhxRAg2g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:25 +0100
Subject: [PATCH v3 06/37] drm/atomic-helper: Fix commit_tail state variable
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-6-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yGpnS+bYKk0E6Y2+/FI6asLPESf8ZlRcD1McZsZgydY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWCVEHtsY/ZGTm5OyIPTvgUu7lXcZsh0pZOX9M1di+
 0TN1valHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiH+0Z66v39e2Xbe9wvJC9
 0Uju65qP505+ePeyOdMxOfmGJ1PGVP/Utf+1PN72XzFYlG2m8cj3K2PDoaNXJgqo8c6JlY1b8S6
 F/9re14F7uwOrQg7GL5jyYv9iuSuzlpjuvvXga5Hzwm59yY9mAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Even though the commit_tail () drm_atomic_state parameter is called
old_state, it's actually the state being committed which is confusing.

It's even more confusing since the atomic_commit_tail hook being called
by commit_tail() parameter is called state.

Let's rename the variable from old_state to state to make it less
confusing.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26bf2465cee7807d640881ddcb8edc2f972e79d1..e8c30e151dc0af13fbf3d282cc8c5c32ef00c8ee 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1828,13 +1828,13 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
 
-static void commit_tail(struct drm_atomic_state *old_state)
+static void commit_tail(struct drm_atomic_state *state)
 {
-	struct drm_device *dev = old_state->dev;
+	struct drm_device *dev = state->dev;
 	const struct drm_mode_config_helper_funcs *funcs;
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_crtc *crtc;
 	ktime_t start;
 	s64 commit_time_ms;
@@ -1852,37 +1852,37 @@ static void commit_tail(struct drm_atomic_state *old_state)
 	 * These times will be averaged out in the self refresh helpers to avoid
 	 * overreacting over one outlier frame
 	 */
 	start = ktime_get();
 
-	drm_atomic_helper_wait_for_fences(dev, old_state, false);
+	drm_atomic_helper_wait_for_fences(dev, state, false);
 
-	drm_atomic_helper_wait_for_dependencies(old_state);
+	drm_atomic_helper_wait_for_dependencies(state);
 
 	/*
 	 * We cannot safely access new_crtc_state after
 	 * drm_atomic_helper_commit_hw_done() so figure out which crtc's have
 	 * self-refresh active beforehand:
 	 */
-	for_each_new_crtc_in_state(old_state, crtc, new_crtc_state, i)
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
 		if (new_crtc_state->self_refresh_active)
 			new_self_refresh_mask |= BIT(i);
 
 	if (funcs && funcs->atomic_commit_tail)
-		funcs->atomic_commit_tail(old_state);
+		funcs->atomic_commit_tail(state);
 	else
-		drm_atomic_helper_commit_tail(old_state);
+		drm_atomic_helper_commit_tail(state);
 
 	commit_time_ms = ktime_ms_delta(ktime_get(), start);
 	if (commit_time_ms > 0)
-		drm_self_refresh_helper_update_avg_times(old_state,
+		drm_self_refresh_helper_update_avg_times(state,
 						 (unsigned long)commit_time_ms,
 						 new_self_refresh_mask);
 
-	drm_atomic_helper_commit_cleanup_done(old_state);
+	drm_atomic_helper_commit_cleanup_done(state);
 
-	drm_atomic_state_put(old_state);
+	drm_atomic_state_put(state);
 }
 
 static void commit_work(struct work_struct *work)
 {
 	struct drm_atomic_state *state = container_of(work,

-- 
2.48.0


