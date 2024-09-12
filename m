Return-Path: <linux-kernel+bounces-326586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2349B976A77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BACD1F24C02
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C21AD24B;
	Thu, 12 Sep 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MKTgkDMf"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3B1A724B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147529; cv=none; b=FDhz/BWFgpbPYB5Dcz1Xy4EeNHi6p9lUqA830wvP022HbngU3DXxfreZMX2jJWHKnBwkG7zxci4Ux1x8IsCVcnphGIOWfcX0p+7VZkE+9m69ytn6tma/yyt1q2d7WDqCi9tbzJtHhyD1f6wIuMi5kKytB2+TOvzt5eB25aUz8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147529; c=relaxed/simple;
	bh=iHq3eNdKgsYGlwtr+CdIy04TnSmMaePg0ryEiV/pQTU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BLCP2Rdcc0B4npBEK1vzvNyh6sqijyUcQnDG9NgB+/h79YjNDH5BNu5jpWH2lJIuPZJuude03DJD56RorVPOkC9HLYhF+cKntuQWEH8frJOmFVG9lXI+6oz3T1e3kDcAob8b2N2t+jdJCyl8hQKBAsoVxX3I5v0NMXKi9IFgwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MKTgkDMf; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFC564000A;
	Thu, 12 Sep 2024 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726147518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNRqgvianzN3IRB8vf0Folh27Fs9kKbgdl8Cp6aHy3I=;
	b=MKTgkDMf371LagYal+PhEzcuSVQ9ziYC+/cdOmROZS/xahW1ygKatTpQKbYKE6Nd4lwCnj
	qwnX4yAOFgHrHd+iMTHTursEzgRVfjPlHL752/4EVCoZWL3m6HjfAEl93ojcXoJ2a99W7b
	PrcewU6Wbda9kemCajzoDt9NS6JW8cCP5wgGMDoYNVknN1ymwIDSVWgq1wu0uFi5SUeRvo
	wFSZHgT4PysLX5YrBp5B3A+I3nnHMiceTA9EYkX2SWhflEI0V4L7N2VIilLa6sCZhE+t9S
	ZF0WDnzjw+6/c6WGnEu8rLdcwC0dyovHw7mZcifPKTv5W5lEOWiS4zTP4M0+Aw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v3 0/4] drm/vkms: Switch all vkms object to DRM managed
 objects
Date: Thu, 12 Sep 2024 15:25:13 +0200
Message-Id: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALnr4mYC/3XQ3U7DIBQH8FdpuPYo0HaljTG+h/GCj9OObBSFi
 jVL313GYrIl844/5Pw455xIxGAxkqE6kYDJRuvnHOqHiui9nCcEa3ImnPKGtpzB5P10REgHF8H
 JWU5ooJGo+77ZMdl1JFd+BBztWtS390sO+PmV8eVySZSMCNo7Z5ehMsGBs1E//R1gxnU5Qw5jl
 KWHoXouLfR0B98hO0rqA+QCB4kBA8rQYM0FE1y/Ku+Xo50f8wcv/zNlhIDOp/wyG1wvUq1HNEZ
 orfh4K51H2du4+PBT9pVYmaWAgjV3V5NJCp1UQomeM0bra7KIiV8pvLuv8KyMTa5v2raWqG6Vb
 dt+ARfOf+3JAQAA
X-Change-ID: 20240521-google-vkms-managed-4aec99461a77
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=iHq3eNdKgsYGlwtr+CdIy04TnSmMaePg0ryEiV/pQTU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4uu81QC7GWjOTYVRV+uJU9FBktsstAxxhTYfh
 LSp/Xp8aB2JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuLrvAAKCRAgrS7GWxAs
 4qyNEADM9Am1y3Maz9fE8dIneWLQDF3kyPM616KpP4j9qMC1JOfFCT6UlA3H9qgdWqyA8sIKocf
 KBScH5Aqo1Xarxzflt0OuTgn9e58PdazJio5OtIFeo7pnSOD/wbzVWhO+QPQk7MkBiLo5j/PkDw
 5mN4WQjXvlgqQNHucCNI27sN0Dv9Ag7OdAJxndI0tvOflJvvHs5ruGbVTtzASsQLdpKAKshFXNh
 BeKTTrU+dhB02uc38zUNGygeuAppCNEWYq2a9A/N2DmScie95W2ci0eIPmuH1BUUsvxsho+h+fW
 0XpFOZ2wJulWyI/koQsC2IlayD+L9ckiibtoouMsydjgo2mFlNr8vo2aHRkl9OwzFvdE48PJSLW
 F6d6Cq8Ov+vW1R5r7JgZMANTa9OdaskUh2zwOpwCS1wuxt8VS0fja3L/D00MdduvMzSQmJ8In0z
 bzP4q/A4Jf4YSFdeBObX29Hupv7lBY5VIcky0qZgSIwCclZl+W9h7q8KZRkP5G0eCDuaizeKSLQ
 Y2X+HNIxCk10IGb/KgVjUQLgTVnIzE6KMqJBTmcPtDZ1w/40U0fHR//Li9NtAqitHKyqvJnC+NT
 w2CwPRIOJjexvWpVMZZ07a5cxMNlAyKrWxBGlPBVrgkpPmrwwpGlDKRgda74hSFfpjASknBPfgC
 SygzvdGiImQT6vw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To simplify the memory managment this series replace all manual drm 
object managment by drm-managed one. This way the VKMS code don't have to 
manage it directly and the DRM core will handle the object destruction.

No functional changes are intended in this series. This series depends on 
[1] (for writeback connector) and [2] (for cleaning code).

PATCH 1/4: Migrate connector managment to drmm
PATCH 2/4: Migrate encoder managment to drmm
PATCH 3/4: Migrate connector management to drm
PATCH 4/4: Migrate writeback connector management to drm

[1]: https://lore.kernel.org/all/20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com/
[2]: https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
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
Louis Chauvet (4):
      drm/vkms: Switch to managed for connector
      drm/vkms: Switch to managed for encoder
      drm/vkms: Switch to managed for crtc
      drm/vkms: Switch to managed for writeback connector

 drivers/gpu/drm/vkms/vkms_crtc.c      | 14 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c       |  9 ---------
 drivers/gpu/drm/vkms/vkms_output.c    | 25 +++++++------------------
 drivers/gpu/drm/vkms/vkms_writeback.c | 13 ++++++-------
 4 files changed, 27 insertions(+), 34 deletions(-)
---
base-commit: d2194256049910d286cd6c308c2689df521d8842
change-id: 20240521-google-vkms-managed-4aec99461a77
prerequisite-message-id: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
prerequisite-patch-id: 93bfa5c36385932ea291789faa7356639d9e4bfc
prerequisite-message-id: <20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com>
prerequisite-patch-id: 130816a16434cafa13b7a2b629398a20782be3a6

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


