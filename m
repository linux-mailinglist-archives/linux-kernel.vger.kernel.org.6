Return-Path: <linux-kernel+bounces-303046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E06960698
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B6CB2200E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C819E838;
	Tue, 27 Aug 2024 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p1nJVXQ0"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70C19DF65
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752921; cv=none; b=UxBOuCSV1Q5egqPtGg1iLZ/VXwZ2bKsruxu3tVm1LuA5vc2TD52WD0LovWvOnT3CTYLeplFD1DPMIsrqHLzrvP9E31GlX09q9rr9IQekzv+wX/Tklq4yTmmJ3A+UbXrb9q7MfXzDXpdOzF22bbVxy3N7is6krZiV1CZtLLssB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752921; c=relaxed/simple;
	bh=+9EVfrWGXweMRhdpWJLhgyFdBP6idc+nFpzOoZsSppQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psvpG5/8FEmTO1K8TnJLmoVNANdOojEX+wu28jW+Eo6iYozdH4Sa6bJNh6yCI56K1/ckncbeR9Cl8bZXHPgiErk56sa1SggiZtDtEdzQXaWiRaexiPLbY2eXGeZVNfN9OMrmUrNsc/nrJWAjthrQpf/5rnCA793BWo/NUiVcrUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p1nJVXQ0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CE231C000C;
	Tue, 27 Aug 2024 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724752917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7I4yjRM+EAGk8OmRLAB0yWxupKT0rtc7RgTC0k07aOc=;
	b=p1nJVXQ0ZHRoDKZt427xeQRxPBojvSF+oz4++jfpIazlyRI9cU7Dmg6/ms6VX8JOnzcIM+
	rcHUp6qmDu3UVPkRpu1nAzEhieGoevJALIeAFzLXg2GGF2akQ1xRILapKp8tZ/xWjco8F9
	HU3bEDJJXf6EMhbgA83/MIo1xdY6TljCuBxJJvQYa3om3+u/mSKYLIOjVzrcPSjsxmo9UR
	BiDQ3kiepDywO361YtrYdmc08vfR3ibSq2n4rW2KnuaUOHbNSrzO4ah3YDVS6zRhnemJto
	qN5/2mnfv7SMDQ+rlhV/iTcn9GuVfHKAQp7fd83bvBVK3P3r/P+LL58kbeaiWw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 27 Aug 2024 11:57:39 +0200
Subject: [PATCH v2 4/6] drm/vkms: rename to_vkms_crtc_state to
 drm_crtc_state_to_vkms_crtc_state to avoid confusion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-google-vkms-managed-v2-4-f41104553aeb@bootlin.com>
References: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
In-Reply-To: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+9EVfrWGXweMRhdpWJLhgyFdBP6idc+nFpzOoZsSppQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmzaQPuNM20rjRpZD7nSUpPweO7ZcP+gjwczjjc
 3gojL+9YGaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZs2kDwAKCRAgrS7GWxAs
 4qKID/9nz7XMygblI4ARivSoC0zr8EI1wnWrgFrT/tdSCA8CSeQCU5IF4gubapo16WY/hYgIq6e
 aQWsp0zCN/uM6uA6WwKIQ9LW3aBmC3cBDIQ7tR4hUO0qxovxiHsbpLYbnVF5J1dqx7N1tgOfqEU
 Fzvsm2DUmWCCain8nxX6c+Tg+XWA6iJQr+Qq7KoTX8kvoCT/6KWOH05FUZ3YKfbEqKOVpP+0aT7
 Zcn4OhyQ0meYoILFPIPviYTVcGJtLmbwpLzmP895OcrohHZYKuCQMP36/bDC9VZax49TVYc9hps
 V81E7s+aW/GVdZn6PhPFDNqKV2sTzHdILFD5MFKXuNd8v1ZXiq5ppe8eo95vm6+84I+dsEBnbpS
 GnxPh6jSnHYDk59cKDKlWerdgDzNaiipAhMgA8Y/QkP5gdkm9Cv+KoGhtHj7gSsM8rwi58f1Dbk
 cl40RVFpg74Wnv9V6krqLNSl57a2IdrxgTpSjNRzG77YndkloXIubWcdMa1qsZLnoSqG7EbuKdP
 hnwdn5LjQwHCMcxWN5zJhnoYHDGMSEfw5zB2iVsVRs6nnNo/5WZtAkdRGalBgg1N+NLq4qTrWA5
 O4ZDTFjXeILYM6Z8fpHsdgzbEDpTBU1BvMzcXuQx5iZk349+hUqhKoQaQv8OqDeqIyZDPkj5fPn
 l0Vn0Kz0ROmVv/Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To avoid confusion in macro, rename to_vkms_crtc_state to a more explicit
name drm_crtc_state_to_vkms_crtc_state

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 6 +++---
 drivers/gpu/drm/vkms/vkms_drv.c  | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 013bf8336b54..2bf733a1b9f0 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -132,7 +132,7 @@ vkms_atomic_crtc_duplicate_state(struct drm_crtc *crtc)
 static void vkms_atomic_crtc_destroy_state(struct drm_crtc *crtc,
 					   struct drm_crtc_state *state)
 {
-	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(state);
+	struct vkms_crtc_state *vkms_state = drm_crtc_state_to_vkms_crtc_state(state);
 
 	__drm_atomic_helper_crtc_destroy_state(state);
 
@@ -173,7 +173,7 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 {
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
 									  crtc);
-	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc_state);
+	struct vkms_crtc_state *vkms_state = drm_crtc_state_to_vkms_crtc_state(crtc_state);
 	struct drm_plane *plane;
 	struct drm_plane_state *plane_state;
 	int i = 0, ret;
@@ -257,7 +257,7 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 		crtc->state->event = NULL;
 	}
 
-	vkms_crtc->composer_state = to_vkms_crtc_state(crtc->state);
+	vkms_crtc->composer_state = drm_crtc_state_to_vkms_crtc_state(crtc->state);
 
 	spin_unlock_irq(&vkms_crtc->lock);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index d1ed6bbe9559..f2818374f5c9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -82,7 +82,7 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 
 	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i) {
 		struct vkms_crtc_state *vkms_state =
-			to_vkms_crtc_state(old_crtc_state);
+					       drm_crtc_state_to_vkms_crtc_state(old_crtc_state);
 
 		flush_work(&vkms_state->composer_work);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index c55ab45ccb20..3501cd9401d5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -136,7 +136,7 @@ struct vkms_device {
 #define drm_device_to_vkms_device(target) \
 	container_of(target, struct vkms_device, drm)
 
-#define to_vkms_crtc_state(target)\
+#define drm_crtc_state_to_vkms_crtc_state(target)\
 	container_of(target, struct vkms_crtc_state, base)
 
 #define to_vkms_plane_state(target)\

-- 
2.44.2


