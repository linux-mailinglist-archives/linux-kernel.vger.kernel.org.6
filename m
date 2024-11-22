Return-Path: <linux-kernel+bounces-418601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDACC9D6366
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338C516152F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A61E0B70;
	Fri, 22 Nov 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PFJEXr5k"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC71DFE37
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297152; cv=none; b=O1EYf+UHD2HlLnb1iTgFz9v2HbJY2X2ppA3kL6e3LXR7ZpgtQORUB8FmwGR1NUm0wlFgeMohLg65oYSpp4W1YS1AibUVZmrFEs4Z+o4cpSj6ymW7khmHC0NmfcWkH0e/8UoILIAAchdCzpwX+WHGm7hxH2iNkrg9G1AsWO1sOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297152; c=relaxed/simple;
	bh=1Ri0TOTViTXTQHPBy7TMsfMxJ4cY55t/DcvCkNIQR34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feSSHLeBAh540zB5Jp3u7MRMO7NYOiFwzNcfgZC9sJwFiluPUUZ9ovgvhc/BJxqlNWordX8G4JRlgfLhuQSU17RW0mSn/fgl5zW7XkCJMZHp29pPBRUtjXaPjbz/h4yteyLMotN9fZrLINBg95fEJl8BkDQn0Q9GMpscRllLCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PFJEXr5k; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1517CC0006;
	Fri, 22 Nov 2024 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Umi/Nc0PaCWgnTJXdvq5nC0lHTLO/Dv+MccW98xmYjM=;
	b=PFJEXr5kYMEyByoavROrDhb0QDrLNCjVyLbE7LUU7lnPfwm0P+87zn6m8y6Km7rikB3g0+
	BdbVx9roantQbqNNznAIOhmbW/SW7kMvTDnqdgCZlfPBLrUr1CGwIKjCYRdPXI+u/hd0s5
	gCeKxG0/b2vKU1LtE0dV/2WAi6tP5s3IUKUaRRhSZ9DEFnup4h7PJ8V1szDf7ztlf3Owkx
	yglaM7PKamqxBMQkPPmfOqVso9Uu4Tcb5g0+djN2Ki+i9UhpRXhI/6fZbvuxFD136e5uGp
	6meWwerB39UwS0N7275f5liOx1dI6q5BP9jtAdYJwEk2WELOlzu54v7WJeXLGA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:38 +0100
Subject: [PATCH RFC v2 12/16] drm/vkms: Introduce configfs for device name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-config-fs-v2-12-4b7e6f183320@bootlin.com>
References: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
In-Reply-To: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org, 
 arthurgrillo@riseup.net, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=1Ri0TOTViTXTQHPBy7TMsfMxJ4cY55t/DcvCkNIQR34=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGslsy21ABH21B13Q+YvwSq1A/MGbJKgsbL2
 zLJCX8MK66JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBrAAKCRAgrS7GWxAs
 4tFmD/9L9XzU8tBSrGH5ErZur/taVRSe5Xv6FAgtgK3bckxOAuYLrjP+gVleufcFAYJDHBavEMn
 pnevD0nL7Gu5Zx4qOdwoNTdmR9+RcQIyJ9Dk5Dhw012UsLylzGFj2Nlc2tNti91gQ0xOapijn7D
 Pf4fmVYGwHyli+GSDcRzCia2ELSZcIv5h/rxrWP+onsV8bt971/tUYsYQYNt0cIAFlzXplkBrQH
 jVEa1Ot9NrfFSNQM8+RHbIFAGfxkZBGLlUawvRJbTKaRe67dnBjaub074puL4b0eVPDQXHVCrfZ
 QkU6q+6xOcI/16HiL3cY7vms/FnXuZZMyU00EFLWEbxDeGxjSdHiNzxRtr3rkMusqk1bApnKo8y
 MRUuwObaBXCGDJrqqIdqDAZvRAJ9SvcWEnIi8/j3uQgZyeKj3UFaFiNDY2EeLtdP7hp8HfL4xoa
 RetgJ/GEXfi/XVoQGqIyi5GIBGrJ0LHgnPXSNsC+U7RfHmUhnD/8R1t8y9SzE5TB3fVCP1TsS46
 gDa6CFoQK9u1TwkP2IYBClditq2iYRL2MgDP8EyVxy7QTmyobZspogsXChWzDTAi2YbNTkKOsoz
 FnOHj/qLmsdRJ+3v1M8zbGjO81D9j4kjmUoczUuzuVPcaskkEM9TjQDx9Iv1FqoQJhZZBhgkIwr
 TcVf9UySYfuV4zg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index a1ddf25ab6f882ae1857bc82fb4b4a425b6d287d..dede56a8a2c1e866734f9c979c76977370907680 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1137,10 +1137,26 @@ static ssize_t device_enable_store(struct config_item *item,
 	return (ssize_t)count;
 }
 
+static ssize_t device_device_name_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_device *configfs_device = config_item_to_vkms_configfs_device(item);
+
+	scoped_guard(mutex, &configfs_device->lock)
+	{
+		if (configfs_device->enabled)
+			return sprintf(page, "%s\n",
+				       dev_name(configfs_device->vkms_config->dev->drm.dev));
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
 CONFIGFS_ATTR(device_, enable);
+CONFIGFS_ATTR_RO(device_, device_name);
 
 static struct configfs_attribute *device_attrs[] = {
 	&device_attr_enable,
+	&device_attr_device_name,
 	NULL,
 };
 

-- 
2.47.0


