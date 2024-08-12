Return-Path: <linux-kernel+bounces-283717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4094F81C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849C01F22B69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B80197A9F;
	Mon, 12 Aug 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FdWZwDdg"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880541922CF;
	Mon, 12 Aug 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493949; cv=none; b=W952ZTkw0ONUTZ1E9qFmQQbRpK1Wu9EEcuc6T8O/IlHqp1/1zkK2qYae+FwxRWzg/p7nupuOSwTs3xlrI6+EHYQhWg8Tjzikj1KcLVtpU3BtAHWuymhHwL8cMRCvVouDjlgHuPL8u554dCdHIZjXbVb2jClsoVX+rdsr7I/Aiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493949; c=relaxed/simple;
	bh=OzOV3KctGeSDiPIQhS912kuUk6g/QvgVA8C2lsF764I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PUAU7cscytUi34mYlWhF2p4QX4HnU6nKLP5tqSORO7MGfOolrecAs1B53VEUr0VE8AM7LbV0tJ8lwP4jvdMGzMh6Ig0GexoESvOoAp0KsGaxMnNp7d7VRBpQ4A5hoedeNB9zMrg+UI5iGbfDfVhLAmU2cZRqnMcGBlGp1eszgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FdWZwDdg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723493938;
	bh=OzOV3KctGeSDiPIQhS912kuUk6g/QvgVA8C2lsF764I=;
	h=From:Subject:Date:To:Cc:From;
	b=FdWZwDdgvX2TtqUKia2mVoB2WpjXtAVkfH7fVseSxaihp02dh8lc6bgzO/tSzALce
	 tqQq++y0Apzc6qOfTHM8SpOL0dVtbZqmpmVgSf/378luwwArzPC8ErIDhazEGCFFa9
	 rJ4DjVh5g91ZC3j3EZsdX9NaF+xoP8tWIp7grOZw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 0/3] drm: Minimum backlight overrides and implementation
 for amdgpu
Date: Mon, 12 Aug 2024 22:18:29 +0200
Message-Id: <20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABVuumYC/43Ny27CMBCF4VdBXncqe+zcWPEeVRe+TOIRJYCdp
 EUo745h00qtUJf/WXznKjIlpiy2m6tItHDm41jCvGyEj3YcCDiUFijRyFpJsIcwnGY48AjO+v0
 HD3GC88xpD62R2IeWGl1bUYBTop6/Hvjbe+nIeTqmy+NrUff1X+yiQBW76tquspVDu/skzjn7O
 MfXkSZxtxf84aF+6iFI8OT7pjddsJ3709PfXqPVU08Xz9TBSOdQ2Rp/eeu63gCCLLBOaQEAAA=
 =
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723493938; l=2087;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OzOV3KctGeSDiPIQhS912kuUk6g/QvgVA8C2lsF764I=;
 b=aTt0wBYAI8GAN6I1WJ95Le7kAoxr9a86SGkK2Libk4hy1AiwbDKxvcsNN0hsMRNHS5SqrYrP2
 fIzKPqwVXOqClrIFTOS7mp2IadEEkNx8z/n/SO50HAkkSZRiMKamDsy
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Introduce a quirk to override "min_input_signal" to "0" which leads to a
much lower minimum brightness, which is still readable even in daylight.

Tested on a Framework AMD 13 BIOS 3.05 and Framework AMD 16.

One solution would be a fixed firmware version, which was announced but
has no timeline.

---
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
Thomas Weißschuh (3):
      drm: Add panel backlight quirks
      drm: panel-backlight-quirks: Add Framework 13 matte panel
      drm/amd/display: Add support for minimum backlight quirk

 Documentation/gpu/drm-kms-helpers.rst             |  3 +
 drivers/gpu/drm/Kconfig                           |  4 ++
 drivers/gpu/drm/Makefile                          |  1 +
 drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++
 drivers/gpu/drm/drm_panel_backlight_quirks.c      | 77 +++++++++++++++++++++++
 include/drm/drm_utils.h                           |  3 +
 7 files changed, 99 insertions(+)
---
base-commit: d74da846046aeec9333e802f5918bd3261fb5509
change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


