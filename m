Return-Path: <linux-kernel+bounces-291009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6DA955C37
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6710B214D7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B72381D9;
	Sun, 18 Aug 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LPchZ3G/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29039FD6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977825; cv=none; b=MPyOFHSGrC2AN56SqPeCMEfpP2rWeocjhAQ18QfTtVpEln0i23mZ6A3ERKaFkKVsq2XqGIZnqL00AzOUJlO/cLS1jsgzbl3Ts2U9ZGOZroheW202rH1PpVaSiUhj767vH1/zUoiN28CqAOmUfkmX7FHmjwc0JbcsU6wgdJ8a5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977825; c=relaxed/simple;
	bh=kl3heLQyW5KkENM8k3MDFGyGD2/NtXxvdiQoPH62gGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwonBf9wY/pzlTTPrkCA1oEmsvD1xyY9qV6QMc4AcepDxi69iFivwk2m0qIeYnZjE+CrYmXXSXOdO4TDBezvWq3me1lzbaFbY+Z2LHzINyFkx/Hhg/EBK65gxLSgDI6TVAAausf3nuHfkaYyN9dhsW29p8gXxH7qc1sH96ERYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LPchZ3G/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=kl3heLQyW5KkENM8k3MDFGyGD2/NtXxvdiQoPH62gGw=;
	h=From:Subject:Date:To:Cc:From;
	b=LPchZ3G/S6/6yaqZOfFCPLl8NFWMl8S7flXdySaR1G5BGGV1rEPWfM+xUpxhQsS5p
	 lV5rtVUOIhqqftBWg2UOVCn6z/NwZlYo9Fdjjkx/Yet1lkAKAkZKfbwvi5FVV4f/5X
	 IjzIW3JJjKJuHehLYxDDDxeOwKoLT0SDtAiCguA4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/12] drm/amd: Switch over to struct drm_edid
Date: Sun, 18 Aug 2024 12:43:24 +0200
Message-Id: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEzQwWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0NT3cTclPSCUt2Uotz41JTMFF1joxRLM8uUtCQLS0sloK6CotS0zAq
 widGxtbUAVJufj2EAAAA=
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=3177;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kl3heLQyW5KkENM8k3MDFGyGD2/NtXxvdiQoPH62gGw=;
 b=qjrcDRrBX2fNmXdj8yZQ7/qhkGPCfljpa2CO2OGtjIjBgGPNVeF/2zYxvJBCp7O7WSXImcy+s
 ehXe7AgCeEXCluWo2tPGajQZ52Wq0TbmbkhCDYpCF2kaeIab1vEYZIg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The AMD DRM drivers use 'struct edid', raw pointers and even custom
structs to represent EDID data.
Uniformly switch to the safe and recommended "struct drm_edid".

Some uses of "struct edid" are left because some ad-hoc parsing is still
being done inside the drivers.

The patch "drm/amd/display: Switch amdgpu_dm_connector to struct drm_edid"
will conflict with my backlight quirk series [0].
The conflict will result in an obvious and easy to fix build failure.

Patches 1 and 2 delete some dead code.
Patches 3 to 6 constify some arguments and shuffle around some code.
The remaining patches perform the actual conversion in steps.

[0] https://lore.kernel.org/lkml/20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (12):
      drm/amd/display: remove spurious definition for dm_helpers_get_sbios_edid()
      drm/amd/display: Remove EDID members of ddc_service
      drm/edid: constify argument of drm_edid_is_valid()
      drm/amd/display: Simplify raw_edid handling in dm_helpers_parse_edid_caps()
      drm/amd/display: Constify raw_edid handling in dm_helpers_parse_edid_caps()
      drm/amd/display: Constify 'struct edid' in parsing functions
      drm/amd/display: Use struct edid in dc_link_add_remote_sink()
      drm/amdgpu: Switch amdgpu_connector to struct drm_edid
      drm/amd/display: Switch amdgpu_dm_connector to struct drm_edid
      drm/edid: add a helper to compare two EDIDs
      drm/amd/display: Switch dc_sink to struct drm_edid
      drm/amd/display: Switch dc_link_add_remote_sink() to struct drm_edid

 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 56 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 84 +++++++++++-----------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 34 +++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 28 ++++----
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  8 +--
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |  7 --
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  5 --
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  4 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h          |  3 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   | 42 ++++-------
 .../gpu/drm/amd/display/dc/link/link_detection.h   |  3 +-
 drivers/gpu/drm/drm_edid.c                         | 20 +++++-
 include/drm/drm_edid.h                             |  3 +-
 20 files changed, 155 insertions(+), 171 deletions(-)
---
base-commit: 207565ee2594ac47261cdfc8a5048f4dc322c878
change-id: 20240615-amdgpu-drm_edid-32d969dfb899

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


