Return-Path: <linux-kernel+bounces-418500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7859D624A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F910160502
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415D11DF73A;
	Fri, 22 Nov 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HFWZhrex"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7C1411DE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292892; cv=none; b=sPiPNi/dC6Lt4gkBbtuPC9fkWXkGXb6XnOoo0y2qIrJ9925bAhrVYDIH725wtzsN5ydcPTCY/BtblMdSmqRc8h+G0VW7tMfOjDqihBoaRJRQnYUhL6jPJcf305hrO+YIwohWCSO1ij+CgWTAXh7sRlDcxeJzEroasT0IUab/Fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292892; c=relaxed/simple;
	bh=NWshA2nhUmLf4+lUiI5nRj1x3O0ZVs1aUdEuVoWdoKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esmly65casd8dgby6SuGCcqnm8FLJC38iRmVcQsD20DKqQvQWPJRTt4Cefs2upGDCC4F6Bub+X1bI+2I1bacet4L7TrcLUsfVEyx4N0RETFSAYLTkrvq4e5NEc7LIXRuSy7LBZ18XAKZF3OOv1Ig3fE0Qvl8Fo3vL60ZvoNXZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HFWZhrex; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77909FF807;
	Fri, 22 Nov 2024 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjtQQ1bolICg0Cj3uC1vz9qBhffyIX0EePF6iMjpDpQ=;
	b=HFWZhrexD7ynn3nnjoqFLdtyQX8yrpNqYCksWwxYVwuG2jMsSYNFRFBcba/SMkntBk/MOx
	0fXWFiI1IAH1/LTcmm9obF7SUlSEu0gHLrGoblJyzE17NCIXifleZFz3NXqBzcDvuBcUc8
	IVZMfnQLdTWcNlT5O8CdA6gP0mpyx9IbWM0X4iElGtTHHutpCDhkegD+Sc/q72WHB2XNY6
	t+MS9SL2gi2H8utAC4ki/xmBFwy2mTkq+HrXU2r2QUk2qYkfAwBMKK/C1ZUlzlK67+HO7g
	AN7DrtEaVXFO3M7If+WchaJ2pIDEJe3VVExf83XHh8t0q3y0tFSe1Plyy7gJQQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 17:27:57 +0100
Subject: [PATCH v5 2/5] drm/vkms: Switch to managed for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-vkms-managed-v5-2-1ab60403e960@bootlin.com>
References: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
In-Reply-To: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=NWshA2nhUmLf4+lUiI5nRj1x3O0ZVs1aUdEuVoWdoKs=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLEOEBFS5O5qWfownFloyto/umJBvUpjk6mQb
 sMVowA0xnqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CxDgAKCRAgrS7GWxAs
 4oH8D/4k+pBR7pez2m0ozJyJXtzKZcED/qYgtMWsY6uIAFVIe7qdUBmQGalYwrxBwz5zAEgaO/u
 YQ04wBUqlf532sNqjmxIH6J+wHFD1q0TAChaJBT+RKFN8+N38BGnckitD3mq8h8MRv5EN6++/l2
 lcmAL6UpveeVn5QYdIVGRXKMmZ1AzeVRdXKI5nwSJhuWSQ50aGhEWG1HY9CioAnv9KU0JoD6TTO
 E6EvVq00K9KV8BWZJXG5eHRGG2u+kVtdJPz4wbJFOXsaQgmHOGA+N4IC1xF70Cpo5t5gQYaDnHX
 9OVDjnYqeQh78n5Tu3mjKQuN2glgr5Y+HHU8lO2tpSwZhoxYdGG1dPFcwE9Kp99zL17n5pLzBOK
 My+j9T+tGzp8FNtaCClDAjw78hLmEVS24bv0Ew8CydWg8Peblje8AqLCKmB3CwQCioGD6sQs4tN
 m8Wp6DoqWXRzFI7hYzhQ/M0R1Os8aajtlV8QEkDP1vSWXAhzJo8fLOr8bW7j58ku1mPkF1FTPQt
 eMxAQRRZm3nLOEzNFIKXRz7LWeUkDyK3IAbCbMZ1ECVerOuqppsU42zdhmw+sI/rhw+zfj80vnt
 e0ABx+laKp00UoQQylYv00PYAnaj44DljP8HB9/CnOm6PmSJ0LS18By5z0Gm1wT90kSV0hFb/nY
 mjZEa36PRlNLDcw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create encoders. It
is not an issue yet, but in order to support multiple devices easily,
convert this code to use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_output.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 570823ecb28f589e6323036590ec05a2f633bc9b..ab9affa75b66ce9f00fe025052439405206144ec 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -13,10 +13,6 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static const struct drm_encoder_funcs vkms_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
 	int count;
@@ -84,8 +80,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
 
-	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	ret = drmm_encoder_init(dev, encoder, NULL,
+				DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
 		return ret;
@@ -95,7 +91,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
 		DRM_ERROR("Failed to attach connector to encoder\n");
-		goto err_attach;
+		return ret;
 	}
 
 	if (vkmsdev->config->writeback) {
@@ -108,7 +104,5 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 
 	return 0;
 
-err_attach:
-	drm_encoder_cleanup(encoder);
 	return ret;
 }

-- 
2.47.0


