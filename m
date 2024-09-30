Return-Path: <linux-kernel+bounces-344360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A798A8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DF81F264F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441519B3E3;
	Mon, 30 Sep 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lURCSA1H"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988519B3D3;
	Mon, 30 Sep 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710377; cv=none; b=NT3EkjetlJd7uM6OueK/vAVloHpns62WMdbpYzAX2wqGTyYhrM7iAQfSuhyGvgAg4zgK7xa1Bp26bUNveV5LQf9bGklhPQpwwYebM3lBSoI6rjHggAGvpMl3B5a2J1UP36BZQUYruabFgOZuU5HydbcSO/GvEmbQGtY7vLLW8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710377; c=relaxed/simple;
	bh=PFGhswxeEmLZHlnqofeGdDJ2SDZWzjkoeeHK9t5I21Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsX3mAaIN7VmG8h5pN7+VIwbNJM6CbxmmCfGmLoAFK4rYSZexuh00HUq6rq5Ar/zcD6kROs58a6W5/k1Q/sj+m5qQD0o4U+zEo3HuWv1S8EGnsgIBX050zDExW86sfs9V2nrwj46YaO32aIjls4lJ+6lSEb1Qq3td+/c602JbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lURCSA1H; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F51A40005;
	Mon, 30 Sep 2024 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727710374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BsU4INOE1CHTascqSt5xwkugSRCgOxTbOYvghbcOx8=;
	b=lURCSA1HRcGwdcAmfvs9INlcPYq4R+x16i0Ao6iyv1A8mCp51UDhLUNFOFYeh+j2vDVWKT
	6KISbWCpekVlZg9B1uFSq8xICR44Md/EmNVEUO5k83kvTTN8Vg+DHy2AUKRSOjtM76OElT
	YJsjUOaOsK3a6YyMS/9nCpM6VhtXZULckwCEGKdysiV4Ov31wOrvKIYr5S34Czjlcoac7Q
	+QPVfVt1Z0g0VMVLMxLIBnYHyHBAHfu8fEJsC26yTTTXqoAMLc88KGL9lX3kODm4z86Rfd
	pscjWCwhDOYOve2BExY+2skHgn5ZpqVYShcfOfQhQ2g60/VdFMf+OAafmZ0xRQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 30 Sep 2024 17:31:49 +0200
Subject: [PATCH v11 09/15] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-yuv-v11-9-4b1a26bcfc96@bootlin.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
In-Reply-To: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=PFGhswxeEmLZHlnqofeGdDJ2SDZWzjkoeeHK9t5I21Y=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm+sRvrp5toRNt9ZbuVGMYE/HWgSlWWN2L53xZK
 UFT/cuxTN2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZvrEbwAKCRAgrS7GWxAs
 4pjbD/99I/P4K3aEzp0gCAXgr4/Qt9FGXrK0D0GqMwJgCCi4bA8avu2lDrG86/GBNTPP207zRVx
 2j+OPNryais+TjpGqDgWBGCk2Ysi9pXNAT4NOfWw8mrqUrMdFGse2pYlvC2XAcWkc7uYQxIjcMX
 exWTbjlmxwDm8FlytYWBnX6qaUXdUzqjc3yQ7dptSA1+h9KpyxhumfEmebxoZEJwIanzujyEroC
 ezSYkgC9uB+01+jo62OXllGLhW1O5nwEDsKVPluAGsMbsiQYRYVDs+7pi+B5Y9Y57xrs1hQ7G5+
 ALciwo7vladTKgPt5WmMXDRoCHM8qTo5u5mIidBgyKwwRIBcaGgL7FtLxM63PEMJyTGqnkObYRS
 nae0A8FecUFq1H3ex3l42ymq7VtPoqCSx8MsY1K+8NJvQRHfAEY7nBA9SVBrCIpO8iNn7MRQ6uD
 ILQ93AO9NcisRuVOF2oVW28k5rknWPcgR4VeNhWMT8MrvSJHgIwvf8PmG9/MV9lQF40vrRgmWPt
 dW+DUqeo0nAMqVqaRekXLmJxTriuQCe75HkxI5YjYhF5BW0nRKrCcebAIyZoJGT/1ba8TU6kOvn
 Ghf7dkbxJnfdEU/GZTEu4YRcy5gG/PXAbPRGq/5LW4ggzjsiRE30R1X2QUSf9sBAntCWoYSOerd
 VU9Xtrokju31fbQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As all the rotation are now supported by VKMS, this simplification does
not make sense anymore, so remove it.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8875bed76410..5a028ee96c91 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->fb = fb;
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
-	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-									  DRM_MODE_ROTATE_90 |
-									  DRM_MODE_ROTATE_270 |
-									  DRM_MODE_REFLECT_X |
-									  DRM_MODE_REFLECT_Y);
-
+	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
 }

-- 
2.46.2


