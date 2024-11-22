Return-Path: <linux-kernel+bounces-418510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D19D6263
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A648B226B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3591DF753;
	Fri, 22 Nov 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dxEApUST"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108B6F30C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293318; cv=none; b=rev0WEomHJFg2iN9ECM1luX0DCWBreFHB6FAPSVZH1davAfdCjDu4ctIHlUeK4VSsCtnT40w5HE88DdonP4A6OYTbiF9OVnnhzRN/H5YhxUsJ6ohTyo2EnVm8oh+ZAnhr0F4zUw/V5kYGOQNSRKxaDcFDllVbxPmyVNoN3JJB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293318; c=relaxed/simple;
	bh=9J4smgwkzCns2aVvmtM/IAB1GUDY/AKK9P5D+WB4J98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxPObBdIcVfsCbSXo9vSw8MHG5UwsLIunP5w92p8cyX/8d934S2ybyxE75xDvObMu9TSirwho0o9XickuJpuxrOWOYDXC9aEY5Xep/G0KIS8JtGFzlorL98PfD77OfIO1aS4LkxOPN+a781Dui41I1mbWY+Y0iy85fNqoHmHz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dxEApUST; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E307BE0008;
	Fri, 22 Nov 2024 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732293314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBxEQgaBIGduFnCagyGhbgYlms+rtIc0bzXxTFUBT8g=;
	b=dxEApUSTjB+WOgrSF89z0S1QVG21kBT1OPnz2CIAzDBx1TpsLAIZgWF5uP5L/TOadsVdAJ
	tmG80Yyst7L+9zcfSfCCCeGA111S0qFbGikh+y0ljIO1jSmav+G2DalWDZBmEEbFiA+c6r
	uutAuHkD86xP9Dl51DXJOp6Ivnl629wLSeN3wiL38ijespKWitC6uxe6Q8Rs2ZCYVbffdB
	MomSiS/3NoNrYMeM7slEjQsZ0t0a6MV54PlItTQhVvYEpV0FPXmUM3YcLiQqPOUmGrH1Jk
	kDS/c0GkFvSDgzVVP1GpXsnATebvmjhz1bCqPlnQ1ieMrL5U3apyvdo+BKGbxg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:35:10 +0100
Subject: [PATCH v2 2/4] drm/vkms: Switch to dynamic allocation for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-vkms-allocated-v2-2-ff7bddbf0bfb@bootlin.com>
References: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
In-Reply-To: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=9J4smgwkzCns2aVvmtM/IAB1GUDY/AKK9P5D+WB4J98=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLK/4gzREg6PN2hfytrSWLe5ckYkY3N5WNxuL
 /msJP5zWnuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CyvwAKCRAgrS7GWxAs
 4nHKD/4kxgJY26+312IrtktoPZTqilViLS0nxT2ymk9SgLB4MepEW8Tx8pnG8nuOpPk3zxftpG4
 1vcDdeyI2hMUD2X46ZIkL8fkHvS/oPEeCBA0i6Vt66ktCZbuFFQkL+ATZN1X2NbBVrtxjuCMlj8
 95nUkNP+AKutg/8nWLuigYisze+L4n8mR43dLIibGg4JEfzoWSIwmP1mk1Mg4YGvgeClY0jqdDG
 SlaK49H38B2Y0qEZgrWu2yMY5LN7URH/Sclbwj4ba5UURzyGKHEiSWe8ZWRd+IGJcsbaLJ69w61
 aUeYZfw2P9Ge/FO9uCCEvvWHDcD90pTjFnNzpWKfpqlKIrg41hRoIMM/aWWvj9OK/TM3XuW1L+q
 NFZP0OISu5LCJjxFjdYWHsQKDF1af+qu4yWCdn20uzNsOrUiAu4Z2QxJrRmc5Mz8bD89+5zgFlq
 haMV5W3XZNCVlv2zFw6B7MSdfuTT6eKAzdExtGSwxFuRXXmvxN/nX0O8PblHhNP1f4kuf41Fing
 aJHYCf2D28+3Sg0dNj12kmKVd+Eqnav3nUgmB+DJb5DLqiebxcc0dIpxv/6kh2ZKYFImYNHipx3
 R2CyIyf2I8XQ7hThOmc+fLhIlEWwfo7Hmw6FBHmZt3FFkTCm2cbf+4xzZhDD6CBjmbjN0PQ7ClA
 qYGUq+IIflfiieg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

A specific allocation for the encoder is not strictly necessary  at this
point, but in order to implement dynamic configuration of VKMS (configFS),
it will be easier to have one allocation per encoder.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h    | 1 -
 drivers/gpu/drm/vkms/vkms_output.c | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 820e7899cb049b45d8bdbe5a0dc7be08eee6db69..19fd99b8e506c4454d7878b67f692a0441c22665 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -176,7 +176,6 @@ struct vkms_crtc_state {
  */
 struct vkms_output {
 	struct drm_crtc crtc;
-	struct drm_encoder encoder;
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index ec3545730ef79af0db51d8ec605b9cdfff52c2a3..102b6ad466cb4f7c6704f30cea669e5d7f81540a 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -33,7 +33,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
 	struct drm_connector *connector;
-	struct drm_encoder *encoder = &output->encoder;
+	struct drm_encoder *encoder;
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_plane *primary, *overlay, *cursor = NULL;
 	int ret;
@@ -86,6 +86,11 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
+	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
+	if (!encoder) {
+		DRM_ERROR("Failed to allocate encoder\n");
+		return -ENOMEM;
+	}
 	ret = drmm_encoder_init(dev, encoder, NULL,
 				DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {

-- 
2.47.0


