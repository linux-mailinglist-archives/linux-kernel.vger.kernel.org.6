Return-Path: <linux-kernel+bounces-418591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B59D6350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB302160F81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397B1DF961;
	Fri, 22 Nov 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TvYfvOqT"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73E14C588
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297146; cv=none; b=tzOok8ldPdWMlF/dcEQRT2p4sNOLDZAx4ELdjCxDHr7sJ1hD716joDHu3iNcDo9ctZK1Ps1/5gcPh1h0JidadfP+jY0ozQCakXVR6GrogjQJZXkw0jtHqGB0bve75G4J1Na/APumV7F6VDhY3Ly4zpGVeG/j5fAmiLcB6jc6ipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297146; c=relaxed/simple;
	bh=arFPfBvkyojFw2UpPJF4s2GkOllumMgZfpsQfgBfcuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUJ9IUv4kWPXYfapheWz4r43qyzcKxbGqJGXtHLT9M67VpNZB6bmrsu8/aDaENjNwZSxoXiNl6fHAS7K4c/+Imz3c5DH1InW9pwnTjiSfZ6uG7VbhHYPs/6EQHr4ugXBNNODj8NfLo/lOrgmXDmFEhijOflK3eiyh/GGu9HckS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TvYfvOqT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CBD2C0005;
	Fri, 22 Nov 2024 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732297137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBkM1WMn2Ucut+MxptAqo72bzc6IetcnqSt6Z29iw1I=;
	b=TvYfvOqT+LpCytteXXJNt06lkYZbEGRUjKc6UmCPnhs+aOtDAtaJgE/fYIMhBi3i7ULsDm
	OOXicL7vllKFSf0pD8bsOsFzaYxgUvwYWIqQpkkwgVIefd/0bYUfd4WW35StebJIzdAp1C
	qpiwoJcV2W6+zKuuGv87zHPLjZz/Vf6geyNPAq2rIRPnCPcOX6pQ4i1JKuCd+qSAYBWWuj
	oFJKivG0cca+5mUXtZPPWisZYNjV47UptCNNcaFFp+VlgA8lQ8tx3ZtWDg6xdx3zqPjt00
	899n7yTUXkLlZh0oFkDRJ7iiCh1TOlWBkxqfmHSEMBxoZ5OrLwM2E3Q5lE7O8g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 22 Nov 2024 18:38:27 +0100
Subject: [PATCH RFC v2 01/16] drm/vkms: Add vkms_delete/create_device
 helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-google-config-fs-v2-1-4b7e6f183320@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=arFPfBvkyojFw2UpPJF4s2GkOllumMgZfpsQfgBfcuE=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQMGpCQj8Jt9fbd6PpIlfJ2MZdP1Sg5XKYX29J
 OQFgYT93d2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0DBqQAKCRAgrS7GWxAs
 4obYEACwzMhDfuO1In8gQEcRttWndvFngdxSb4RmW7W/ZRR9C7+qpQpyBErmwQ2RRllmXBVsFmG
 cINoA29G4KxnR/V6J2Ve8GDjFxnid5EnbnVQbbExbUSQlxv7W88KpU7cEPfRkvmlLz4fvETSMeN
 eUI+Wo7yxdDm1W2qHbK6hVKZ5E9s82X0+qruP54DWzUOsv10FrzkFYqkJ0YUb8w2VQAp7DDr6Zb
 uXs6tsyT6jgDYCRvVlA+46FhbTocRI5MMJA84jj4F5vLhvrlO1GjpPWxRejQ6FBuWutuiNfUVLM
 ornYXmJhWxkR41w+TIlXYuWDlLzd0LLcbQp7c2UeCpq7AYzjN9tykHDZOzufR+jRFlTaw1e9NJa
 GkuIvNkoaiOLr75xnJr4GQRe2865VET7FDM3FCNigHCP02sJBocQR6/fD8/BbjdoJkPBkm1x7Gg
 foAf0k+pVtVk4LBVBhUcVvD5G7aEJ7VMwDwEYYskIrqHtpvS8I856vACGfDdqWjdvmqfl/CM2xE
 eHSvdrpwFGYhT6KwdqMbp18lVMWyRF4/XE8xTSTIa/KdlUW3Q7wkiU4COpznfD5YnyaVsgsAMK3
 os1zOraueJOhRnUdTa48fYExpEFdZ1jv1/liOnnHurbj76C7s6z3x7HxEM8o1v5iq1JjBgNGutN
 E1AkicuK+SaDTLg==
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
index eb6fd570b4549639f6818ff63fb334f2a461b23d..2db393f5782eb26a5aa469a4774b2e19c886ee7e 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -152,7 +152,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	return vkms_output_init(vkmsdev);
 }
 
-static int vkms_create(struct vkms_config *config)
+int vkms_create(struct vkms_config *config)
 {
 	int ret;
 	struct platform_device *pdev;
@@ -226,7 +226,7 @@ static int __init vkms_init(void)
 	return ret;
 }
 
-static void vkms_destroy(struct vkms_config *config)
+void vkms_destroy(struct vkms_config *config)
 {
 	struct platform_device *pdev;
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index a772bf4168e11730c6ee2e3c79abce3a6351203f..5521d59f775170d828dea734b4ed3d177debdd0d 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -231,6 +231,9 @@ struct vkms_device {
 	const struct vkms_config *config;
 };
 
+int vkms_create(struct vkms_config *config);
+void vkms_destroy(struct vkms_config *config);
+
 /*
  * The following helpers are used to convert a member of a struct into its parent.
  */

-- 
2.47.0


