Return-Path: <linux-kernel+bounces-406533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE99C6084
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B29282C01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A14218301;
	Tue, 12 Nov 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZSd7Tal6"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69A217452
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436467; cv=none; b=V8mKb81CkC6vcWWyrU8ANE5F3Q+Z8+pRgyk+W8gcWUuFb5OYuFIeeVb7acTOBzNoDWjDsj4oxw72YpTZN/pDSoSSI5fn7L5eqeS69QeXAKlgaCKhv1+orrRyQR62aR+/lBVnjY4O+l0ihyVG3aKemg8haKopQqESbTQhtmh1R04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436467; c=relaxed/simple;
	bh=N0c1AAbtePVSIawYLO3q1m7P6uw9XKLYSSRostz+3OQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tgj0zuonDE0Gzrh1FRsFJe1bPux9WdtlraUxLhqRnFaV6mpY9je0b17GWSm11DL91ZPc1+ju5W689mKoSOyoLbb8low8dn/WvPQUW8NhiyBAXoVAxaHRjcqUoTpHFzHwbtfQ0KDeXUrUUInsQmvKo/WzCgORuaCqduYEOhssuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZSd7Tal6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436454;
	bh=N0c1AAbtePVSIawYLO3q1m7P6uw9XKLYSSRostz+3OQ=;
	h=From:Subject:Date:To:Cc:From;
	b=ZSd7Tal6uncyzkCLszuWlsuHp0Htz1BcIfaA7ab67Z2Fvb/rQVsHHSDaDetTeZWEn
	 b1XkfbT1hhjqo+1k5rXt2rUijbRZGZnSsruu9YuSOLFdgHsSdSCQ/s+k5C5fZ6TxxG
	 Xc6RDnMkt4wtuZ3e7AyexjzW/6pduXD6WMw+GaPQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/7] drm/amd: Switch over to struct drm_edid
Date: Tue, 12 Nov 2024 19:34:09 +0100
Message-Id: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKGfM2cC/2WNQQ6CMBBFr0JmbQ2tWKkr72GIqZ0pnYVAWkAN4
 e5WXLp8L/nvL5AoMiU4FwtEmjlx32VQuwJcsF1LgjEzqFJVpZZHYR/YDpPA+LgRMoqDQqMN+nt
 tDOTVEMnzaytem8yB09jH93Ywy6/9tWpZ/7VmKUphyWrtpD85X12exCklF6aw72iEZl3XD7xmj
 JGzAAAA
X-Change-ID: 20240615-amdgpu-drm_edid-32d969dfb899
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 jinzh <jinzh@github.amd.com>, Aric Cyr <Aric.Cyr@amd.com>, 
 Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=2732;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N0c1AAbtePVSIawYLO3q1m7P6uw9XKLYSSRostz+3OQ=;
 b=DSan8VeZ7z6jB8KBMTo1YdJljrXaXmpIwmBYKc4f+pXlBmb7Gc3xQgOb8/t/+Sr+ybouB/T2u
 w8012xFrELoDJzXSW3yrth4Kwa64Dvu6H1KIVEjBjxpgrwRw8+vKYJ6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The AMD DRM drivers use 'struct edid', raw pointers and even custom
structs to represent EDID data.
Uniformly switch to the safe and recommended "struct drm_edid".

Some uses of "struct edid" are left because some ad-hoc parsing is still
being done inside the drivers.

Patches 1 and 2 delete some dead code.
The remaining patches perform the actual conversion in steps.

If some patches are already acceptable as they are, I'd be happy for
those to be picked up from the series.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Remove a wrong kfree(struct drm_edid);
- Drop patch "drm/edid: constify argument of drm_edid_is_valid()"
- Add missing call to drm_edid_connector_update()
- Drop drm_edid_equal()
- Add patch to remove edid_extract_panel_id()
- Link to v1: https://lore.kernel.org/r/20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net

---
Thomas Weißschuh (7):
      drm/amd/display: Remove spurious declaration of dm_helpers_get_sbios_edid()
      drm/amd/display: Remove EDID members of ddc_service
      drm/amd/display: Use struct edid in dc_link_add_remote_sink()
      drm/amdgpu: Switch amdgpu_connector to struct drm_edid
      drm/amd/display: Switch dc_sink to struct drm_edid
      drm/amd/display: Drop opencoded edid panel id extraction
      drm/amd/display: Switch dc_link_add_remote_sink() to struct drm_edid

 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 55 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 20 ++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 36 +++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  6 +--
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  8 ++--
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |  7 ---
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  5 --
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  4 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h          |  3 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   | 49 ++++++++++---------
 .../gpu/drm/amd/display/dc/link/link_detection.h   |  3 +-
 17 files changed, 92 insertions(+), 128 deletions(-)
---
base-commit: 377dda2cff59825079aee3906aa4904779747b0b
change-id: 20240615-amdgpu-drm_edid-32d969dfb899

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


