Return-Path: <linux-kernel+bounces-359637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A2998E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D24286162
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D8A19CD17;
	Thu, 10 Oct 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RkeGxkAW"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B619ABCE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581953; cv=none; b=N5/ou+cEpg+g6KB136pufIQpcITabUF2aomEQ6CxuC98rFsOIK+ClX9LV4xyq9jBOaa5ouQPwqCTsG7/P+pGwPHZilR+M3NlTz3FBP0ThqWgMDQefFA5iv9xzt4VuPgCMi9mgx+W8e5ZwX5Dnv1uHwVSQsxH3nrcKvV0y1Te0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581953; c=relaxed/simple;
	bh=eCAtSnq3gulUFMwB2cnvUWBPF/mvKoiVD9qzhmGDGE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iCkYNPlRCG17HQRY45nqzr2RqEJsR00hYwXNSeXp27bWwM1V/ENEM2TwRocY2SdAznc3JmsP9czMcXO+IBmMM82IhVSG8caKs4LHZJgS8/IjlEfX/3T9zQlRssWboHeLcRPM4qJsWb+VvShcYctF2R+TZYlRWL6hvdwIBpJw+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RkeGxkAW; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E16BC60006;
	Thu, 10 Oct 2024 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728581949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ruN4O9/Ba3jAbdbuON4edAws+A0ti/PF5RubXDcwX+o=;
	b=RkeGxkAWhZg17IAYWcVES+d27AoOvgBnPUQ5cV2SmnDF+X0Cupdb/YAQXRNxbpa99YjEFC
	3LLXMF73XlR32pGKRNQhVfblb/B/LLSJpBpqvQ1gBSfBIYBeadrGP+aUbmllOqicfNnRuf
	kgXGTnmbd2wYSJ+8uRJRThDpah+hfKgwNE50MYN35AkmS67H1cg9OQST+4jm9plBBdAypE
	PjNOSIi4nE9StgT3vK7dzIxglADzMb7YUl6wYnW0RuvaGDUPUFLuRIh9NZzkBP8B5Lah6t
	7CVIwnWFy4r2Q9CZafUTCiVLJ9DmpAnbjO34QUNuxQSI8d+qWWQWgqAJBaWJ3A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v4 0/5] drm/vkms: Switch all vkms object to DRM managed
 objects
Date: Thu, 10 Oct 2024 19:39:02 +0200
Message-Id: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADYRCGcC/23P3U7EIBAF4FdpuHYUKP2NMb6H8YKWaZe4gEIlN
 Zu+u5TGuMa9YyDzcc6FBPQaA+mLC/EYddDOpkHcFWQ8STsjaJVmwikXtOIMZufmM0J8MwGMtHJ
 GBULi2HWiZrJpSNp89zjpNasvr8fs8eMz4ctxSQYZEEZnjF76QnkDRofx4ecAFtdlhwyGIHOGv
 njcIzDK6PG3R+NierEKV4gcGNRDq+pxUpVk1fPg3HLW9j798UT2DCcdFue/ctHIcojcqWXiZqf
 IgEIjh3ZoO84YLa/JLEZ+pfDmtsKTMom0L6qqlDj8V8pfpWP8tlLuWRqa+knFa67+Ktu2fQNRc
 PLayAEAAA==
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=eCAtSnq3gulUFMwB2cnvUWBPF/mvKoiVD9qzhmGDGE4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnCBE5nqvO1enzNoBDUmJl18zoP3bi28kgHR3bC
 63r2GfUcfeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZwgROQAKCRAgrS7GWxAs
 4lD+D/0eULtEQye4haSPbrk6GSIgnwnAQDJ+6uNC/MKn5ST6UzYLnzCDUYioqSwSk8H0ENGGiai
 XF9awjWtLyV8du/CKF3dlSj5B7fxZ4NZDuJAu+Rl4VmpRvZi0QQ79vxeLYAgescgUb9CK3Emu9K
 OgFofxVrID45zlIethtoE+jox4L9m1AWTQQR8W42+sQUX194BbKWaRgm8xlU/NQZC/2O6XedUIx
 PdNVSMgNDbjBa0w0xAhMVz0cAuv8tJk3GJ6hcqZ27omQOUO/i85nKMIirsnNdr9OIGcA+qHcVND
 0yu84p9FKOlNN9ifdt48nuK7Lq6lJJ6laJVntVNRcZ9fOgkOW4GLKRWF+Qan/pOJuHB2fopvYMM
 TrbMK8JwGDGedaxzHwqP2CFNF3P0X0EKcdlAauufSCuP6vPoHGt9Fl9O8tG5LwFkiUSMJ6Plm6O
 d3se8vH5lzQGO0do5KKUAqxUnYl22sB0qVmsvozlynaJET165HVMdeNmPyKRyiKAh8BH/BXya4V
 SimWZgQyPeYFjCkVMnjXNbOXSql6M1wsqtmSBx+Dh3F+0Seo7FNdVrsrix8ktIZHvl76N2kNdtj
 xTGJyhUsNz/xSZ4s9e7lrkIR+YkS6fEPGh0dL9u7GReQghUvjxydreWOS5IzrWPYSBUUn41nkIi
 lyc2XWWk7yFZb7g==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To simplify the memory managment this series replace all manual drm 
object managment by drm-managed one. This way the VKMS code don't have to 
manage it directly and the DRM core will handle the object destruction.

No functional changes are intended in this series. This series depends on 
[2] (for some code cleanup, which conflict with this series).

PATCH 1/5: Migrate connector managment to drmm
PATCH 2/5: Migrate encoder managment to drmm
PATCH 3/5: Migrate connector management to drm
PATCH 4/5: Introduce drmm_writeback helpers
PATCH 5/5: Migrate writeback connector management to drm

[2]:https://lore.kernel.org/all/20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com/

For the drmm_writeback helpers, you can find some discussions here [3].

[3]:https://lore.kernel.org/all/20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v4:
- No changes for the managed part
- Add the patch to introduce drmm_writeback helpers
- Link to v3: https://lore.kernel.org/r/20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com

Changes in v3:
- As suggested by Maxime, split the managed and the dynamic allocation 
  parts in different series
- To reduce the diff in this series, extract the "remove crtc index" part, 
  see https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
- Link to v2: https://lore.kernel.org/r/20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com

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
Louis Chauvet (5):
      drm/vkms: Switch to managed for connector
      drm/vkms: Switch to managed for encoder
      drm/vkms: Switch to managed for crtc
      drm: writeback: Introduce drm managed helpers
      drm/vkms: Switch to managed for writeback connector

 drivers/gpu/drm/drm_connector.c       |   4 +
 drivers/gpu/drm/drm_writeback.c       | 224 +++++++++++++++++++++++++++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c      |  14 +++
 drivers/gpu/drm/vkms/vkms_drv.c       |   9 --
 drivers/gpu/drm/vkms/vkms_output.c    |  31 ++---
 drivers/gpu/drm/vkms/vkms_writeback.c |  13 +-
 include/drm/drm_writeback.h           |  10 ++
 7 files changed, 238 insertions(+), 67 deletions(-)
---
base-commit: 33c255312660653cf54f8019896b5dca28e3c580
change-id: 20240521-google-vkms-managed-4aec99461a77
prerequisite-message-id: <20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com>
prerequisite-patch-id: 920c23497fc5bd2fdf1dded06ce198c227ea0ef9

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


