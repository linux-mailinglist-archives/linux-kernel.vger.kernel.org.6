Return-Path: <linux-kernel+bounces-226016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C091391B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D114A1F22105
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79517D3E8;
	Sun, 23 Jun 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EPVuytmQ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB059B71
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133164; cv=none; b=ooAaCXwD07r7kSeVm45FwtTi5fb/sUCVwePu226NEPSexuZEhNqUg5xg2l7qHPsPTd8hkIl2F4SYwPcBwTxX93ykKhDJBlxmEcJgki5UPtFWyyIiu6BrItBfXnPrTo/1Rjii+Eh6gf+X+II/0hLtBkfiSxlG5Y1Zy66fkQ/vJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133164; c=relaxed/simple;
	bh=zB2lHe/cxmaq3sEJTX39vzQps5Xljraxg3sewiB+Xv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AxeaFU+kyMnU3hmnglIh7gYeTwAioadJboblSaOKfkrAXG5jaLILCDz6S+KbcMoZtwF/gaKI8LQT3nmwYYRFvDSWxokQ2L2hNXlx2S3oFIqRQPREsLTuKdJTy1iOQhhqDXH2VsvuLBQAEd6UCZoe3UtPJxaYqWO5KQNUG37adUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EPVuytmQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719132689;
	bh=zB2lHe/cxmaq3sEJTX39vzQps5Xljraxg3sewiB+Xv4=;
	h=From:Subject:Date:To:Cc:From;
	b=EPVuytmQawb4QbbtMpIwLUtd1BUdP0idrchVzD9gAehNsFqyCWCq8p6jeuAIf5LtI
	 Oszh/kVYFO031J5jQHlU7hRtfepvzrlfcyYKeAjIHSmyH5XmMEaP13KcN6EFyA7g3/
	 BeKkxckBNBpat78/zwLluNhRRrzCP9bRB2OsX34g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
Date: Sun, 23 Jun 2024 10:51:26 +0200
Message-Id: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA7id2YC/43NQQ6CMBCF4auQrh3TVkBg5T0MiwIDnSAFO4Aaw
 t2tnMDl/xbf2wSjJ2RRRJvwuBLT6ELoUyRqa1yHQE1ooaWOZaokmKHppgUGclCZun9QZ2d4LuR
 7yGKp2ybD6yU1IgCTx5beB34vQ1viefSf42tVv/UvdlWggp3kWZ6YpNLm9kJi5tou9uxwFuW+7
 184PZHbyQAAAA==
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719132688; l=2496;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zB2lHe/cxmaq3sEJTX39vzQps5Xljraxg3sewiB+Xv4=;
 b=0x05OrASCwGcIIhqmTXoV+ChUICWHrXM8Z9UIIYNcCruuieBg6vTjCBfs6mo2eNPXUpI5W4k5
 Oemc98k/a8gCFqs5lAvZneIj1AHRCPlDTahSWgqSjSbzKCuwz0HJqaY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The value of "min_input_signal" returned from ATIF on a Framework AMD 13
is "12". This leads to a fairly bright minimum display backlight.

Add a generic quirk infrastructure for backlight configuration to
override the settings provided by the firmware.
Also add amdgpu as a user of that infrastructure and a quirk for the
Framework 13 matte panel.
Most likely this will also work for the glossy panel, but I can't test
that.

One solution would be a fixed firmware version, but given that the
problem exists since the release of the hardware, it has been known for
a month that the hardware can go lower and there was no acknowledgment
from Framework in any way, I'd like to explore this alternative
way forward.

Notes:

* Should the quirk infrastructure be part of drm_edid.c?
* The current allocation of struct drm_edid in amdgpu is bad.
  But it is done the same way in other parts of amdgpu.
  I do have patches migrating amdgpu to proper usage of struct drm_edid [0]

Mario:

I intentionally left out the consideration of the firmware version.
The quirk will stay correct even if the firmware starts reporting
correct values.
If there are strong opinions it would be easy to add, though.

Based on amdgpu/drm-next.

[0] https://lore.kernel.org/lkml/20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net/

---
Changes in v2:
- Introduce proper drm backlight quirk infrastructure
- Quirk by EDID and DMI instead of only DMI
- Limit quirk to only single Framework 13 matte panel
- Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net

---
Thomas Weißschuh (3):
      drm: Add panel backlight quirks
      drm: panel-backlight-quirks: Add Framework 13 matte panel
      drm/amd/display: Add support backlight quirks

 Documentation/gpu/drm-kms-helpers.rst             |  3 +
 drivers/gpu/drm/Kconfig                           |  4 ++
 drivers/gpu/drm/Makefile                          |  1 +
 drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++
 drivers/gpu/drm/drm_panel_backlight_quirks.c      | 76 +++++++++++++++++++++++
 include/drm/drm_utils.h                           | 11 ++++
 7 files changed, 124 insertions(+)
---
base-commit: 1ecef5589320fd56af599b624d59c355d162ac7b
change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


