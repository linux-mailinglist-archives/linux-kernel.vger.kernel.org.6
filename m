Return-Path: <linux-kernel+bounces-348259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5898E4B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711321F248D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698692178FF;
	Wed,  2 Oct 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kRTx0JGw"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7E217338
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903828; cv=none; b=N2r6RD2RB60bDDuzE0N5TNmK9jKWHcw5pdqbBNs9DvgZvat+KBeQNRgrA8RUQqtzhcvmximdSQCWzm9c2f35yyml8cvAeEs255V1h3NfvLa+t1h0TPeJBMbmBfaB4ZkgIJgh3bVZcBKXp4iOuhVI3JxSx+fj54KGZGXvIbSLQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903828; c=relaxed/simple;
	bh=vogNgUbx1sfLEfHQGXYn5GNtb+v1JBZEEWpvO2CNrjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrOjvEX73op7xksxnRPSJDwZNtoboUbWUKSsDRX3VFu7gLAcmBf68kYMrr2kMmcgW6LkqgdDK0zNPro5HL58YUixJfNg/LSlt8YgHOuPzQT+xdiDK4B1hMKWRx2g+Twh6ufU3FFheoPIp4VlRLqU8iSPnua7EyHyHnO2cHO/jlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kRTx0JGw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QAyIxhbC81BBqvT0TIePt/27v6ZbBEnRkdmyNQCZFzk=; b=kRTx0JGw082mw71S8K848B/fa3
	XEOk/a2WoaReP9rjzQX3/aBXTW6yiE7HaIPbX7Mddacmx9vA36itbhY9VR57UAxuYjyO0wp7zcCuw
	r4LmkvPpIxmIFZ6zqRoy/kJNkoLeZfExLguVPAFh1LGZpokdUTH6FQ+fT71wS6Dv7/rO/bfbovGZZ
	QUJKIIWjuCZIo0zUuLgXGoRpqjz0RtvSnC2NcsjHRdGdjASXPLmadeBxyh+YvHmpEQCm4qjgsd0xD
	CGUDO0El+gJ/44L+1PFuRRvZwKkvJNvtW+RYhTfPGWAd/eqFHJeZwrQblYUrdS7JndbnDWodOfiZE
	uD3v9XnA==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw6iK-0042sU-N3; Wed, 02 Oct 2024 23:16:52 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 02 Oct 2024 18:16:06 -0300
Subject: [PATCH v9 2/2] drm/amdgpu: Enable async flip on overlay planes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241002-tonyk-async_flip-v9-2-453b1b8977bd@igalia.com>
References: <20241002-tonyk-async_flip-v9-0-453b1b8977bd@igalia.com>
In-Reply-To: <20241002-tonyk-async_flip-v9-0-453b1b8977bd@igalia.com>
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
X-Mailer: b4 0.14.1

amdgpu can handle async flips on overlay planes, so allow it for atomic
async checks.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426..4c6aed5ca777 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1266,8 +1266,7 @@ static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 	struct drm_plane_state *new_plane_state;
 	struct dm_crtc_state *dm_new_crtc_state;
 
-	/* Only support async updates on cursor planes. */
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (plane->type != DRM_PLANE_TYPE_CURSOR && plane->type != DRM_PLANE_TYPE_OVERLAY)
 		return -EINVAL;
 
 	new_plane_state = drm_atomic_get_new_plane_state(state, plane);

-- 
2.46.0


