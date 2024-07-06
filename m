Return-Path: <linux-kernel+bounces-242987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB57928FEB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF271F2271A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 01:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F95A95E;
	Sat,  6 Jul 2024 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YMPeVsSd"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698358825
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720228356; cv=none; b=taDa1nxWJbQbuWmp02U2wY643YhnWQy3Ex5Q2yNqNy8rP/fM4KwrZaVFTjfQZ9+O7d3FjI0Ju7NEnz3n0Jz/cjU+9o1TXbcBHCwg94ROJhyDgixmdkMPQm8VB5/v7QERr7lsGRKUG9D1oPHrm4QoLgionqad00e5a4O1JmsGc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720228356; c=relaxed/simple;
	bh=vTZlYpE03yBLXxj8jIXX2zEByRTBxWGxIFi8wO2fnBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsq6jWOSQ2poSPwCg4xHy0XiKFvwCKU6QB0Whbs96DuvuxKEDymiIUSdRLPPHC9LA+Po5LOoALTX1TOziDkZs3lRnZIyourXiyLUp9EdOEj7hEDBFeDKZmeWWH4vOd9rBxtr410DNN9uLs/7UKv6XjBn9A0HppM3xSl8AMhURGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YMPeVsSd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gFzB+aQujMt/IACIZP4KZSW18O15WloNnGMAa2AP0Wg=; b=YMPeVsSdiNuDZ9uzzjwlnlckNF
	mhbxNNP5MvOhAVlTwg20W674xj5zWQAwPlLmR80kRDYTEG5qOgxPcWbd8VlRXHa/exLsHWwvIrC2j
	bZfflrQFCVpGAg9//lyoTcejE2SFYTC1G0BXX5lEiNPEwNwho6+wlggTJC7oZPRZ3jMSD/OVr/P8k
	6AiIUMkMMy+wd/TdgYMjtpObyUCqYqQp/sUHDAliCAKDEnv6jGDKDNBYCtXiq40DTnu6Y6JODBQr3
	I8gygUeA9iO0CLBsvHdhxJF7Em24B/xfFNNYVqdDK4NgCn0CmcwquNDJEGnYsRedUm3+qmLzKaZVm
	78jsvNSA==;
Received: from [191.19.134.16] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sPtyX-00BhBm-6O; Sat, 06 Jul 2024 03:12:29 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 1/2] drm/atomic: Let drivers decide which planes to async flip
Date: Fri,  5 Jul 2024 22:12:13 -0300
Message-ID: <20240706011214.380390-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706011214.380390-1-andrealmeid@igalia.com>
References: <20240706011214.380390-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, DRM atomic uAPI allows only primary planes to be flipped
asynchronously. However, each driver might be able to perform async
flips in other different plane types. To enable drivers to set their own
restrictions on which type of plane they can or cannot flip, use the
existing atomic_async_check() from struct drm_plane_helper_funcs to
enhance this flexibility, thus allowing different plane types to be able
to do async flips as well.

In order to prevent regressions and such, we keep the current policy: we
skip the driver check for the primary plane, because it is always
allowed to do async flips on it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 7609c798d73d..d888ee8f7a11 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -27,8 +27,9 @@
  * Daniel Vetter <daniel.vetter@ffwll.ch>
  */
 
-#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -1063,6 +1064,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 		struct drm_plane *plane = obj_to_plane(obj);
 		struct drm_plane_state *plane_state;
 		struct drm_mode_config *config = &plane->dev->mode_config;
+		const struct drm_plane_helper_funcs *plane_funcs = plane->helper_private;
 
 		plane_state = drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {
@@ -1080,11 +1082,20 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
-			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
-				       obj->id);
-			ret = -EINVAL;
+		if (async_flip) {
+			/* we always allow primary planes */
+			if (plane->type != DRM_PLANE_TYPE_PRIMARY) {
+				ret = -EINVAL;
+
+				if (plane_funcs && plane_funcs->atomic_async_check)
+					ret = plane_funcs->atomic_async_check(plane, state);
+
+				if (ret) {
+					drm_dbg_atomic(prop->dev,
+						       "[PLANE:%d] does not support async flips\n",
+							obj->id);
+				}
+			}
 			break;
 		}
 
-- 
2.45.2


