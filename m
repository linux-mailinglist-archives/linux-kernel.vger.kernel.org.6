Return-Path: <linux-kernel+bounces-392714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3C9B9765
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D43A2815D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1C1CDFDE;
	Fri,  1 Nov 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZAhpaBEr"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79D1CEEA8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485462; cv=none; b=aIkFkesjtnP7qkMWyfawPulau6wgWjo9eUDrk9GT1Z263yR+thg+lYtxpvb8kWGAsrIKqehY5t2zTlFHscqXteH49WGs3XOf9zfInZzc95ZdXe3Eu3XUp9v15HxnijJ7QsLH/MDPdQ6zk/VRDMVT2vL5zdOu/42gIvFivd7YM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485462; c=relaxed/simple;
	bh=YlitEqGAndQOUuAwteaAvH9Ilqz6KDCB00Uy3S28dto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOgZtIDsGy+CpPJrs86DNaFbK21mNSgBN+Hl2KkRC5hJGdne7gtkfWSkExXbZLnblDJLi8tvJ+NzbPJ1wn47Oprzkakr/L7DkxyupTO9C5YcuINLtAHx9qy4nBqsttNllVGG2FG9v4+70OJ12nujTNXHtRCtctDh9lAyR1fRdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZAhpaBEr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1rNIllVm8irZBshB7g/xMpsH8r3PsuoB4xB5fC9wdnE=; b=ZAhpaBErtf5A69797CUNNEW3Jl
	s9cK4EDa2cFUJ2OSRdAgVKfxjI0goTDqVYaK60teEaFAJDojz6ILaJDSGowclTsfLkI9U7iRY9mfY
	tyLdZrcACaCsvRND9keK+fbHSVv8qeYU0tGrbZqfqnfx0eoM7jhcuWmeqP4WTaIo8ogrv62aOK2Io
	4GXO3R3bWfbB74mEVQLovfNhP/aixZbK8qw7ZoczElAi90Hr5K5nWcPkxkFQ+BC/WG30NNhRrFkz3
	lMhcRAt5hAZfNMhTiS+ajXOyQiUNLw5ozR29Gbmq2oNcLOtg6THs3Fup3KROg/HPsv7j3MZ+aGfCk
	iAIlIaCQ==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6wJj-000XDx-Bm; Fri, 01 Nov 2024 19:24:15 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 01 Nov 2024 15:23:48 -0300
Subject: [PATCH RESEND v9 2/2] drm/amdgpu: Enable async flip on overlay
 planes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-tonyk-async_flip-v9-2-681814efbfbe@igalia.com>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
In-Reply-To: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426db0182cb2811bc6d5d09f52f8a4b..4c6aed5ca777d76245f5f2865046f0f598be342a 100644
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
2.47.0


