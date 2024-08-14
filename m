Return-Path: <linux-kernel+bounces-286729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF95F951E62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59067B23260
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A051B3F30;
	Wed, 14 Aug 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EtDRzC5+"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331B20DE8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648566; cv=none; b=dhbuYP5KMDD5/dOiVC+SmoFkQpxuPO+XFcoRI+de3wGSglNG1/lpgzNttx/I/7q7UFyNsqyRG0UHfuicyktJQR58DJbUbfp2GnhCRFBn9AD10QmCKyqfQQP1+dqI0Uh4Y3DVd2klUFVXgKdzSOkns3ZsbkHga65kO4mNSD6pJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648566; c=relaxed/simple;
	bh=KBDfEXrg7EsnVFW5hE1grE5/QDKpIdyCTzXK1gODbho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aT2jfLRf8DXDMCPx0GVulI0M0ozVO3pdm69FVCC8Dz6Sw1kuEbg/5mCxFnXmZI3PqrYt2pNArMwmEUAhCchG94uaMolgKCsuKlDQ76lRTk4ubZq5xuaVnVpIIOpZj++ksCQPYUIR1Lm72PE/uYdmuWaiabSL25SKUMwGq1QiGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EtDRzC5+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 768286000A;
	Wed, 14 Aug 2024 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723648561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wko6E4xauEKtnSS+VtA8L9zWLyLrg2+6EVQu8Spj3Y=;
	b=EtDRzC5+Ss9Oq+2KQNkKy8at1k40UMvePEDL2U66dQBb3+Y/2umeU+6Ky5yGt44JHToADt
	W/xXuK8YiRbkcV8TG7EhBAFlxfSUN8oV7nVDlUCWOD4wyA84msi4Zx9/CLbSCYNW5839Kc
	ZV4lWJm60PtlS6NEibbEYXFcuaoUjVa7M4XirybCgCIdLHgFltCHEt3Is/1Xd2NxEzp4lp
	B47rUNrPMmtvCxyccAeJmAWbrgztW9eI+iPrBifmVsercwtOYskISrQC23V0QKV7bWbP+m
	FjuqYtXnzpXqY7g9ZkmKUUqmaCrcOUr4JAg/HMpReen8zytzXftUzS0VHBGGOQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 14 Aug 2024 17:15:48 +0200
Subject: [PATCH RFC 1/7] drm/vkms: Add vkms_delete/create_device helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-google-config-fs-v1-1-8363181907a6@bootlin.com>
References: <20240814-google-config-fs-v1-0-8363181907a6@bootlin.com>
In-Reply-To: <20240814-google-config-fs-v1-0-8363181907a6@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=KBDfEXrg7EsnVFW5hE1grE5/QDKpIdyCTzXK1gODbho=;
 b=kA0DAAgBIK0uxlsQLOIByyZiAGa8yi2jOTyL9U67CP+cMHFwbfrbUNg9XtS1i7neBOhqybYoC
 okCMwQAAQgAHRYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJmvMotAAoJECCtLsZbECzi1GkP/2jx
 3MbwfaNkXhRdgz1oHQ1pLPqJoCaEIJ8M4VnLuC07CWSvDeF2zPxhTYWVhAdXP25nf1esGS7pvSF
 KryjPMVcZNn1OPWNiROOaQSAw8Zz7jiFP/kOXYOX4HFf5RHwN9JYglq3CdS5PP3K0g6xiLd3bEI
 SEPCDzS05qaA5Jnra13fxzVclYKKfUVuP5Zcbg0jFYOv6a7XEakTaDtgKYntE49dHuBOrQaOHoy
 JBHw1Rf7/mLTT2VlDqD82zC59Htq9FYAxH+U9iU+EwrFoCC2FV1bLM8DvUjow8UI8no6ecNwrYU
 aIzUkpn1Xkib/vKME+gbf9tIFLU4ecfJorqbMKy7cLCjLLbiO0HA3l5lVfgWJZKwN1Xz8T75tlg
 LfZf1ay3ytAzVyxk6pcLMUBYRDmjiQYayyMFNfGgedt+uSOwku806dh/IowEgIKhKK6JJxwBLfW
 701uC0HIEbQaiNrmp1ONZKB9pTcy0R4FqGdNrOD3zUbSHzA8N/UQV1ZbUn7zX8h4zAZz7LzdaRP
 s6+ksDvZfvHoyptgfR2oRXNyfgF5GyAneD1LQrIUhoKDI/guVRGXDqwWGldhw20mfncAVUTRFwf
 +8tHiqcAdQ3JLkuwE9eoXAepS87ayXzdmSc1Qp5OqP5acrcIOei/0SE7yBzwn7Cf89Bi9XuDBq9
 iXc/u
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

In preparation for introduction of ConfigFS support, expose the
vkms_destroy/create helper to remove a vkms device.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_drv.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index cd3920270905..9ea379f4338f 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -264,7 +264,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	return vkms_output_init(vkmsdev);
 }
 
-static int vkms_create(struct vkms_config *config)
+int vkms_create(struct vkms_config *config)
 {
 	int ret;
 	struct platform_device *pdev;
@@ -331,7 +331,7 @@ static int __init vkms_init(void)
 	return ret;
 }
 
-static void vkms_destroy(struct vkms_config *config)
+void vkms_destroy(struct vkms_config *config)
 {
 	struct platform_device *pdev;
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 64574695f655..0e62c6b6bdbc 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -41,6 +41,9 @@ struct vkms_device {
 	const struct vkms_config *config;
 };
 
+int vkms_create(struct vkms_config *config);
+void vkms_destroy(struct vkms_config *config);
+
 /*
  * The following helpers are used to convert a member of a struct into its parent.
  */

-- 
2.44.2


