Return-Path: <linux-kernel+bounces-286655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75ED951D68
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDFC28E7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4D1BE870;
	Wed, 14 Aug 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mvByp2Kl"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94321BC9F0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646206; cv=none; b=ooJSCFJqrmfGgcdah9IQCpltQh9guEFpbJ99o5a7N/quR/HurZLDKLyxinKXtt0n1jZPABLBxwUL8YbYd6YAHxSvMJgGcuXg2BI/qcH93Jp+2/73FvyPf3WRx3iRwzmonN8a5OkK+KTF2wNYryCaggw8HdE4CegoO+xUxwUMOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646206; c=relaxed/simple;
	bh=tjoJrPo5BIMBI2L17f4sY05IB9HzBOdBn35thdcKzcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvfLs+NS/9BKv4kab88DP+1waN0fmfYh0A1b96O6a1xgZQ6axFEajD3hoWMHQG08l3PUPsZS82CP+4nL1hQA3UhyPwMcYdJvkqs/V//m4Zso7+imNnND9Bg3YCUpDzDn7byxRwAUkHvFH0WJhOwKhxaLf1wk4mpaUvA7/HdjVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mvByp2Kl; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67E001C0005;
	Wed, 14 Aug 2024 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNBsa5gXilZCMjJcUNu6qYchNDHM9vRKFj8hM50g5XU=;
	b=mvByp2Kl74mGE6PCxWmChgXv4lBKtvySDTcybijrJMUAxOd+vy1QvAIb8AhuCWJLWFpieU
	U3+Xd25mFABra3b1K3SHpELivWo1+TBqxo5M/+dgSNaUuypY8hQ4KXw/W8HI1jgT/7LTqZ
	YnaSR+f8HKUCXXYJIwHsQbyQo2AF92v2QhKTnx8lU+V38+GjTPimkMt2Xbecwwtr0qLfPA
	FcBt+B1jci95dlCZXoWgRW4k9fMRJxGFiUF8WtO5gyDJO3W2rJwUQDoARtb4aAvpCVq6lN
	m4KGvseCqgs8weym9R9KqQwgftsukbk/qANaeA9HnZTCGKkFXDGTevPW44qrNQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 16:36:36 +0200
Subject: [PATCH RFC 14/15] drm/vkms: Add name configuration for CRTCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-remove-crtc-index-from-parameter-v1-14-6e179abf9fd4@bootlin.com>
References: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
In-Reply-To: <20240814-google-remove-crtc-index-from-parameter-v1-0-6e179abf9fd4@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tjoJrPo5BIMBI2L17f4sY05IB9HzBOdBn35thdcKzcY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvMDrCscwQsdTCWw/uxtxJAmPQDMbjohNTLsUx
 iPCzx0eA5iJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrzA6wAKCRAgrS7GWxAs
 4szQD/4rCaqKNfLW9uhjCTCTuwJ20GY0AiBdTH4uC7GxNKeazdSaRvBhCR+gxgvo3q/KeYZU98d
 LAjUvLGaT2VuQ+bsBri4pPiuhei3xyQZOw+XhOU0zQ4tQpQ6Ri43vSi4uz+hLhGKsY55GfRlAtD
 4tqAl88TKyCY2d11Ycj+nXi7xfyI1s8bGEZQYY45UwxotFdRBspHGFdUcJvjuMn1ZpIXrWdfekd
 bKLPeSaxwaz8T3mkeJkFmawMJwcZZVmTJNKmzXD/NXRoFhwZLbwGCvO41lstUn8jxB2l64rwAxh
 8WK51LtUXg+X3GOHivCl0trkdfSPhctupA8ArV2WHo1wrQkWbmmGq3mHElsneFFppgtZwtiHs17
 mAuKZ+mwLsYVJI0CM3df7n77dGXb6NqJy9lI5WxkjsxmE1S69EpoVYcg4dYAsNBYSQY8h9sVjB+
 V94MSdZyqJBQ1icnQLbBR0I9NSDmX0rK+GBDXj4zPr0z1bq+SOuvygZLqwo5aVN012LugjtICHV
 weDXWBrnNMu80tqAbFdWOkbAdwSUl60XsxG+jVtFj61KKMLkMgnJbWwBcVSaEibQ+wxgv5WBZBU
 AW9ekDYZjZxGYcprYM/QzhQsPC39b+zeLg9H99Zmvx/rTk2+znc9Z7I20UTnBSpsvVkTOdbnKfp
 SmWPO+02ojaYD6g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As a CRTC will be a directory in ConfigFS, add the name configuration for
CRTC name so we will be able to reflect the configfs directory name in the
drm name.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++++
 drivers/gpu/drm/vkms/vkms_config.h | 2 ++
 drivers/gpu/drm/vkms/vkms_crtc.c   | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 7ef525091967..a6bf7ae6d216 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -35,6 +35,10 @@ struct vkms_config *vkms_config_alloc_default(bool enable_writeback, bool enable
 	if (!crtc)
 		goto err_alloc;
 	crtc->writeback = enable_writeback;
+	crtc->name = kzalloc(sizeof("Main CRTC"), GFP_KERNEL);
+	if (!crtc->name)
+		goto err_alloc;
+	sprintf(crtc->name, "Main CRTC");
 
 	encoder = vkms_config_create_encoder(vkms_config);
 	if (!encoder)
@@ -213,6 +217,7 @@ void vkms_config_delete_crtc(struct vkms_config_crtc *vkms_config_crtc,
 		}
 	}
 
+	kfree(vkms_config_crtc->name);
 	kfree(vkms_config_crtc);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 4223edd94ec2..4a4c16dea785 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -29,6 +29,7 @@ struct vkms_config {
  * struct vkms_config_crtc
  *
  * @link: Link to the others CRTCs
+ * @name: Name of the CRTC
  * @possible_planes: List of planes that can be used with this CRTC
  * @possible_encoders: List of encoders that can be used with this CRTC
  * @crtc: Internal usage. This pointer should never be considered as valid. It can be used to
@@ -38,6 +39,7 @@ struct vkms_config {
 struct vkms_config_crtc {
 	struct list_head link;
 
+	char *name;
 	bool writeback;
 	struct xarray possible_planes;
 	struct xarray possible_encoders;
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 654238dbba7f..5b659d67b9ce 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -298,7 +298,7 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
 	int ret;
 
 	vkms_crtc = drmm_crtc_alloc_with_planes(dev, struct vkms_crtc, base, primary, cursor,
-						&vkms_crtc_funcs, NULL);
+						&vkms_crtc_funcs, config->name);
 	if (IS_ERR(vkms_crtc)) {
 		DRM_DEV_ERROR(vkmsdev->drm.dev, "Failed to init CRTC\n");
 		return vkms_crtc;

-- 
2.44.2


