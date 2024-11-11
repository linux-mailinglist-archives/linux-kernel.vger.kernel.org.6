Return-Path: <linux-kernel+bounces-404513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC169C451B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC43B31576
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04E1AB539;
	Mon, 11 Nov 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZEc/M4XZ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EA1A9B37;
	Mon, 11 Nov 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348631; cv=none; b=kBLffkUCKbnuYAnuGYBoPiVv0otQa6JdPS5k68DOFVgcDs7wxXdguTJm8fIpraDNdvRH4uBZx2nOroPfYMhFGXN+mTEBhNdc9WHFXV6DpQearStgatFwRgvpJLIodqgopa69ildAZ6QICQOXOdvJviybGmpI2yEZRKLzCObYSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348631; c=relaxed/simple;
	bh=0fcvhlGDwQjs39aD+J+QDRM4SeIBKZg07OzIxurnNCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qu2FcAL2OOyqWvzzHNE3aEhdth3/1igHjWavgemP6AlFPgoFYZ+L3+qw19kWLmXuXh9bVpxNGzvso5wOE2Hzupvl0gjlYZ60xpO01iyqtXf0BjsfjzjdsCQtTZ+2vKVBjU5azgs0nNjNpU30vg5ypc1oMkxW31QfZIhgAqiVJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZEc/M4XZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731348626;
	bh=0fcvhlGDwQjs39aD+J+QDRM4SeIBKZg07OzIxurnNCE=;
	h=From:Subject:Date:To:Cc:From;
	b=ZEc/M4XZ8yOwd7ahUu/EXreUc6S9fTj2aLz8Dk5y8wxieSXUITdAbqC/p6DSG0IXk
	 VHhzaSeaCNCGM9tdvQRpjwg1hliakvTpBREgxG+LM6gGfjWJ5J/WEocCjLW5f8MJwH
	 AZfglvDxsEtv/A163I0dP2qgdLTsU6vqfY2hn5z4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v7 0/4] drm: Minimum backlight overrides and implementation
 for amdgpu
Date: Mon, 11 Nov 2024 19:09:34 +0100
Message-Id: <20241111-amdgpu-min-backlight-quirk-v7-0-f662851fda69@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF5IMmcC/43NS07DMBSF4a1UHmPktx1G7AMxuLavE6s0LXESQ
 FX2jttJIxFFDP8z+M6VFBwyFvJyuJIB51zyua9hnw4kdNC3SHOsTQQTihnOKJxie5noKffUQzh
 +5LYb6eeUhyN1iokUHVppgFTgMmDK33f87b12l8t4Hn7uXzO/rf9iZ055tXXjGg3aC3j9wlxKC
 d3UPfc4kps9i5Un5K4nKKMBQ7JJNREav+nJh2cl3/Vk9ZSJinkvOBix6amH57jY9VT1tAEjU3K
 N9XbT02vP7Xq6et4EhhBZsDJuemblCbXrmepxjNYa4DZ5+cdbluUXlg1dJFkCAAA=
X-Change-ID: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731348626; l=2864;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0fcvhlGDwQjs39aD+J+QDRM4SeIBKZg07OzIxurnNCE=;
 b=8s8m4HLB0qmD8Rb7rvfcrOFluNqdx1cDU6eJsavU3i9D2J2ifoCqE6rLQfvPk2WJyi+k0Nrt4
 q3pw3JsYmwBDbgTzLtfGyKk/lq7n1bOPspAfIgnp0BdJRIv7CMFWNgg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Introduce a quirk to override "min_input_signal" to "0" which leads to a
much lower minimum brightness, which is still readable even in daylight.

One solution would be a fixed firmware version, which was announced but
has no timeline.

---
Changes in v7:
- Rebase on drm-next
- Drop now unnecessary hacky allocation of struct drm_edid
- Link to v6: https://lore.kernel.org/r/20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net

Changes in v6:
- Clean up cover letter and commit messages
- Add my S-o-b to patch from Dustin
- Mention testing in combination with "panel_power_savings"
- Link to v5: https://lore.kernel.org/r/20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net

Changes in v5:
- Forward-declare struct drm_edid
- Reorder patches, quirk entries are last
- Add patch from Dustin for additional quirk entries
- Link to v4: https://lore.kernel.org/r/20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net

Changes in v4:
- Switch back to v2 implementation
- Add MODULE_DESCRIPTION()
- Simplify quirk infrastructure to only handle min backlight quirks.
  It can be extended if necessary.
- Expand documentation.
- Link to v3: https://lore.kernel.org/r/20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net

Changes in v3:
- Switch to cmdline override parameter
- Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net

Changes in v2:
- Introduce proper drm backlight quirk infrastructure
- Quirk by EDID and DMI instead of only DMI
- Limit quirk to only single Framework 13 matte panel
- Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net

---
Dustin L. Howett (1):
      drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels

Thomas Weißschuh (3):
      drm: Add panel backlight quirks
      drm/amd/display: Add support for minimum backlight quirk
      drm: panel-backlight-quirks: Add Framework 13 matte panel

 Documentation/gpu/drm-kms-helpers.rst             |  3 +
 drivers/gpu/drm/Kconfig                           |  4 +
 drivers/gpu/drm/Makefile                          |  1 +
 drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++
 drivers/gpu/drm/drm_panel_backlight_quirks.c      | 94 +++++++++++++++++++++++
 include/drm/drm_utils.h                           |  4 +
 7 files changed, 113 insertions(+)
---
base-commit: 377dda2cff59825079aee3906aa4904779747b0b
change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


