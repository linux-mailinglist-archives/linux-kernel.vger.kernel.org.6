Return-Path: <linux-kernel+bounces-303042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77904960690
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F6F1F21DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029919CCEA;
	Tue, 27 Aug 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iw+Ttc95"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF12FB2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752917; cv=none; b=EiEZ4NdYvvtsRNdYmwF6GPTI1UqjS/7h3GnBMHhk38ohfDKoF+KMO+G/G0xk1zhaRBcXuOjGqhY9kT/U29R0yn1mdioo4L0rblr/GKxj71Wq2oHZxzREFZiZMQ1jgvzlQaAEpWvWeaMrq9I5SYgftG3AWjY672ZKTTPy3RiEPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752917; c=relaxed/simple;
	bh=kkQPZG06IpFYUa1eknEy2U+GBqL9zKMZwhs+ar0jO0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iHHOfYl6gS/svbdZFWDHq5km4rKGN82VxW8Zg8dF4uK1q5Z+OnvESuHoDrrgo9r/whAreZC8kSRsJ78iF8+DuIZy+o/fFIk9tweCDSuYlMWexG1wYsgd5RkeDipLdgsziy7GpO9NfltLNipJyqgBM+8TBAKNY0M3+DIT3yvoxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iw+Ttc95; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F131D1C0009;
	Tue, 27 Aug 2024 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724752913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2BE0t2+jrdIWHLllfSRcGCCmI5KaLivDVMuWirHlqw=;
	b=iw+Ttc95e/nnYF1Lrp2KMwhTqzwct1NCpWnGN/egsQHfpQ5qfuUL0atFPOGK8mBsg6ngac
	En3tsqL5pc8KYOj9UYvCqHWSC1Ywro45VKE5QqpSq2KXeELJnNCm2VYyo5KDgJ0jTYReoL
	98AjkT2BCu5TvDnPExiQMegDG/c8cLYegi1ixBjlNtm4+V/ggeOmqySziu93LKymPMW1XD
	ebY2OpozH++vLmjmFeRYM/rRGDMkXyR+BdZlp0eWt0ecGfUDpprq+rUVCRx3Wq3LBpLpVh
	KCtAvVuz2vt+MfFx2mtmUb3hjk6JZeFQp8SPybpmI6kwgJ+M2mfgUkFpNl5nxw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v2 0/6] drm/vkms: Switch all vkms object to DRM managed
 objects
Date: Tue, 27 Aug 2024 11:57:35 +0200
Message-Id: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA+jzWYC/22Oyw6CMBBFf4XM2lFaUR4r/8OwKDDiRNtqWwmG8
 O9WiDt3cyc5954JPDkmD1UygaOBPVsTg9wk0F6V6Qm5ixlkKrP0IAX21vZ3wuGmPWplVE8dZor
 assyOQuU5RPLh6MLj0nqu1+zo+YrlYX1Cozxha7XmUCWd06jZt7vfgYbGAF/yyj5Y9170BrGgi
 0khsr8mg8AUc9UUTVFKIdL9qbE23Nls4xjU8zx/AGS8n3TyAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=kkQPZG06IpFYUa1eknEy2U+GBqL9zKMZwhs+ar0jO0o=;
 b=kA0DAAgBIK0uxlsQLOIByyZiAGbNpAWhOGenNaFhOIUMlPA7yyRKLWkMbVKJUk7qUvyEYEiZy
 4kCMwQAAQgAHRYhBE+PuD++eDwxDFBZBCCtLsZbECziBQJmzaQFAAoJECCtLsZbECzilnoQAMGB
 nJx8Ba1ppeQtMtaE3ZgkPR1RG7phsMbOy9lxgZH0VY2amTYjm/1X9w2RfCd2jFaB2WU3DU5NSfu
 yAG0puCNCrnm5DHOMaMzQLI6TDNN8/d/8wrvS9/D9G87gjB0as0qAUX0drNI2ySyTQqUXs45Vmn
 k2XOfF6I1M5N4dWJlHEDQiY3I2yigNGgvVWyWHH0AKF9NqXJz5Wuz/+zWUTBJe/xsoQ8M4UeB4h
 iaDffTKM4rsm37Q3Cc5zVLO2KWqN/6j7kTm0PjqGxuJ30fwuy10kKcwZs7AVwyDrH4BsNM8AapI
 Rv/DelA4uclT/O9Jih8a5X7n6JmdxXLP0VkGkfAVGU3BOrYve9dAXR6nAurYMqyeQpFBnfYV9cl
 Cwzzm0/BhxtwE2UEC4dsYNMSaX9Gm2+CuubRduiR5P8K1cTCfuMSiyg+4pN8R5WNHIFshdxYZ8+
 uVX0O9aeygHDGOVIcolNjH1IPrepx9Ll5drrJ6NVgqFkNVsTdjHMnhbj1u+aFYrT6xqntgicUPJ
 8zMx3EDsOeFuHTGDBeL3/zPNNWksby5Vj6qyS3kRZ5M4rUsa2lHGQCVW4IIka7Xmhp0m2c98K9p
 Sf2DNuJ0ElVmJWwsN4AcA3s6ws62j6HzrYzWD2ryQ0kj5z2Q93UXzhc/aV7QP09yTCq9EOXiYuR
 +FeHO
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To simplify the memory managment this series replace all allocation by 
drm-managed one. This way the VKMS code don't have to manage it directly 
and the DRM core will handle the object destruction.

No functional changes are intended in this series.

PATCH 1/6: Migrate connector managment to drm
PATCH 2/6: Migrate encoder managment to drm
PATCH 3/6: Rename vkms_output to vkms_crtc
PATCH 4/6: Rename to_vkms_crtc_state
PATCH 5/6: Migrate connector management to drm
PATCH 6/6: Add missing check in CRTC initialization

This series have conflicts with [1], which adds documentation for the 
vkms_output/vkms_crtc structure. when one of those series is merged, I 
will rebase the other.

[1]: https://lore.kernel.org/all/20240826-google-clarifications-v2-1-2574655b0b91@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v2:
- Applied comments from José
- Extract the rename vkms_output -> vkms_crtc to avoid useless changes in 
  the last commit
- Extract the rename to_vkms_crtc_state to
  drm_crtc_state_to_vkms_crtc_state to avoid useless changes in last 
  commit
- Extract the drm_mode_crtc_set_gamma_size result check in its own commit
- Rebased on drm-misc/drm-misc-next
- Link to v1: https://lore.kernel.org/r/20240814-google-vkms-managed-v1-0-7ab8b8921103@bootlin.com

---
Louis Chauvet (6):
      drm/vkms: Switch to managed for connector
      drm/vkms: Switch to managed for encoder
      drm/vkms: Rename vkms_output to vkms_crtc
      drm/vkms: rename to_vkms_crtc_state to drm_crtc_state_to_vkms_crtc_state  to avoid confusion
      drm/vkms: Switch to managed for CRTC
      drm/vkms: Add missing check for CRTC initialization

 drivers/gpu/drm/vkms/vkms_composer.c  |  30 +++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c      |  97 ++++++++++++++++++--------------
 drivers/gpu/drm/vkms/vkms_drv.c       |  11 +---
 drivers/gpu/drm/vkms/vkms_drv.h       |  21 +++----
 drivers/gpu/drm/vkms/vkms_output.c    | 101 ++++++++++++++++------------------
 drivers/gpu/drm/vkms/vkms_writeback.c |  22 ++++----
 6 files changed, 138 insertions(+), 144 deletions(-)
---
base-commit: 071d583e01c88272f6ff216d4f867f8f35e94d7d
change-id: 20240521-google-vkms-managed-4aec99461a77

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


