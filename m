Return-Path: <linux-kernel+bounces-440719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2B9EC349
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C91674BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DBE217F55;
	Wed, 11 Dec 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lQkmEMCr"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49681211274
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887542; cv=none; b=JjvCS/oZodRKWto/iGY7o9WEdZz7xQuC+OB0+2tatua9q1H/8jcx0Py26w/A1r7/RbNdZ1lkVnEY4tr5iNIrYJGwolLyitxAhQ0fNJkk8YEcsyQUeLLJGaV8DlV/v/RFsCSgWUcqfVUDcCDsmImee6mUpjV78/TaCtBgjzfSQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887542; c=relaxed/simple;
	bh=jMOt6Vl9NUupz8shReDFa1tPYKzu04IEESBBhCYq1Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1rPU10SjyAxi4VGIz7RObgsGNi+vlACBgkmvBcqbgC0LOzrNBWOtWA4CeKGjT4h7TyPXCpnxQDEHGxDC3Vuu66XMv1JG09WpcQ/CK+zU/XVfzkkq+Btp59suInn/0WCghvJgbgRo2xTFEzqdHPqSMxbT3GgxZb4YjXrxM5EHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lQkmEMCr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PrQgF4dnk3S2LprziJrI8Fd1ba1twX8nobVmzaXgmsA=; b=lQkmEMCrmc4ttoZgoAygYY8iks
	LKBWvNsjWW7Qwm6rhDMc8m9g9GATacLTr/5p9cQFoyvqqoe8JXJ2wapRw2aVeAkyF0WEqRKSSb8Ds
	K05xR8+IkqjJuDQs1+d/Vz1ORQxbOwXcYcrkG1qvvZI9/Twf4PmVrvD4hvRuxffVI4IXfdOQc8AYY
	yCcLYSn7CBSk8MnuMhjhNp4BVHg+BmDKWpa5MmLbEAOal8EwaNRFvUFuAs9zeWbEIzUMnkH27B1yp
	SDDJ6VCHtga8/cHmajuvBFJaOPBfmVaJ3AJoxLByuHa5+N1OqDcaQRPrOC4W3hadmPON7wpDvHuxn
	26s7XL/A==;
Received: from [179.118.189.35] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tLDM1-001lyu-3k; Wed, 11 Dec 2024 04:25:37 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 11 Dec 2024 00:25:09 -0300
Subject: [PATCH v10 2/2] drm/amdgpu: Enable async flip on overlay planes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-tonyk-async_flip-v10-2-6b1ff04847c2@igalia.com>
References: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
In-Reply-To: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, dmitry.baryshkov@linaro.org, 
 Simon Ser <contact@emersion.fr>, joshua@froggi.es, 
 Xaver Hugl <xaver.hugl@gmail.com>, Daniel Stone <daniel@fooishbar.org>, 
 ville.syrjala@linux.intel.com
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

amdgpu can handle async flips on overlay planes, so allow it for atomic
async checks.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v8:
- Use new parameter 'flip'
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426db0182cb2811bc6d5d09f52f8a4b..2792d393157beec12d6e96843c43158c03f16027 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1260,22 +1260,25 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 }
 
 static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
-					      struct drm_atomic_state *state)
+					      struct drm_atomic_state *state, bool flip)
 {
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_plane_state *new_plane_state;
 	struct dm_crtc_state *dm_new_crtc_state;
 
-	/* Only support async updates on cursor planes. */
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (flip) {
+		if (plane->type != DRM_PLANE_TYPE_OVERLAY)
+			return -EINVAL;
+	} else if (plane->type != DRM_PLANE_TYPE_CURSOR)
 		return -EINVAL;
 
 	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
 	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 	/* Reject overlay cursors for now*/
-	if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
+	if (!flip && dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
 		return -EINVAL;
+	}
 
 	return 0;
 }

-- 
2.47.1


