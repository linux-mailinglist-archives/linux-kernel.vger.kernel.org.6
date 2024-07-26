Return-Path: <linux-kernel+bounces-263329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7843593D461
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280E61F25840
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CD17C22B;
	Fri, 26 Jul 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FJpwCDjm"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53817C211
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001259; cv=none; b=nutZJd4p4FlWMLLqMyeV1pX1vrxx7JvT2TygbX+uAR6Mmb/2KfXsZY0F/YZX8nrA7lYACpQkgxmylhfdEAo11HI+basLI1Qf1LeKD+AWkDWSEannwqtl2BsY7M4cX6SsxurSu8/bmuXvrT0f5oJ48i2/9c/mLmyZ8O8ztHUqFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001259; c=relaxed/simple;
	bh=Wu8RMhQzPlOleoJZKdKLHfVe34k7QEtY0utXoWZH0iI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R1m1ei+e361jnKbFWYNpjCfnX2X527+CGxhIjIo6ucCHyHPsmKFAtqFiOFfM5Gx672Ry++Pv3TjZIenAOh6Z/H5zlt+l+XhMwv5n8zwZF+pppmPB7QTXi4pyL4LHhLKNFIL5osVPWwTlF/SKfR1wWrPktBHtW7/hAyilxKUzO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FJpwCDjm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722001252;
	bh=Wu8RMhQzPlOleoJZKdKLHfVe34k7QEtY0utXoWZH0iI=;
	h=From:Subject:Date:To:Cc:From;
	b=FJpwCDjmCBc5L2ACBCDMmHOy/nu9Hz1+c1Ue5EuoIWxUDGHC/IAVfTSKf/aZdSyc2
	 +AhiFXPnENw6gJby9w0YXOoAv1+0B0bVL/d3rWxk0uleTBzjkctJip4z/4Ouy1DNTt
	 d9yY+lyqiBW8RWl+vfsdgu1C7x51MfGz6x3XY1Zg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] drm/{amdgpu,radeon}: convert bios_hardcoded_edid to
 drm_edid
Date: Fri, 26 Jul 2024 15:40:14 +0200
Message-Id: <20240726-amdgpu-edid-bios-v2-0-8a0326654253@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD6no2YC/32NQQ6CMBBFr0K6dgwzYDWuuIdhUehAZyGQDqCGc
 HcrB3D5XvLf34xyFFZzzzYTeRWVcUhAp8y0wQ09g/jEhnIqc4sW3NP30wLsxUMjo4Ir0Dm0TV4
 QmjSbInfyPpKPOnEQncf4OR5W/Nk/sRUBgW7XsiOkprCX6sWiqm1Ywnng2dT7vn8BCXBZz7UAA
 AA=
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722001252; l=1843;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Wu8RMhQzPlOleoJZKdKLHfVe34k7QEtY0utXoWZH0iI=;
 b=NV0rHjFiycXVUHxW+gzFkBfJvhmxtFqKbwHYjrC4/phN2yODvj6QnhsBlIMMaL6vw4jQ2fR+P
 SJX559XylH/CAe51vuGxL4q0qa9O6b3vzlvt//yN5tSWps7cncwxPw4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of manually passing around 'struct edid *' and its size,
use 'struct drm_edid', which encapsulates a validated combination of
both.

While this series introduces new users for drm_edid_raw(),
these can be removed when the drivers get converted to 'struct drm_edid'
completely for which this series provides the foundation.

Only compile-tested.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase onto current amdgpu/drm-next and
  recent changes to hardcoded bios handling
- Add patch for drm/radeon
- Link to v1: https://lore.kernel.org/r/20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net

---
Thomas Weißschuh (2):
      drm/amdgpu: convert bios_hardcoded_edid to drm_edid
      drm/radeon: convert bios_hardcoded_edid to drm_edid

 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 17 ++++++-----------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c       | 17 ++++++-----------
 drivers/gpu/drm/radeon/radeon_combios.c        | 26 +++++---------------------
 drivers/gpu/drm/radeon/radeon_connectors.c     |  4 ++--
 drivers/gpu/drm/radeon/radeon_display.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_mode.h           |  4 ++--
 13 files changed, 30 insertions(+), 60 deletions(-)
---
base-commit: 644e49d582fd53d4d218d27e404043f56f2c286f
change-id: 20240616-amdgpu-edid-bios-a31aa16b0321

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


