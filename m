Return-Path: <linux-kernel+bounces-176210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287298C2BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B111F210B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391B13B7A1;
	Fri, 10 May 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEi5A5OH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519F13B5B0
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375911; cv=none; b=a8Y3jsZldVF8y8DQCVpduZ7izr8HVveE5g2AXOm44/DBmv7aoUjl87h/TrHPBM+1u2fIP+t5d4MaYBpKBm/HSRKG95urdBNG4qc2W0GXyDmlDLzsQgsBBCMOeEBtDLWgjOdPfxcwO0df3W4zZikTBWbh1RtgVo9niTC7pr9kvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375911; c=relaxed/simple;
	bh=YlawKcNma3OW7iUJ7dX7RhMRDpnHiurpM0xck2qN+AA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dBgqqdrJlPJvKrnrJ9S3jrjUkhM+jfqV2F1zVCwF1OyE0/KDjZ8zlmX3TKWBO/zb75CvHFYPnjMZgm4FDygtHafcXrLnSI7sOmVa0DrUwLOYLHKVN4Zpkk5dX1oLmD/aY0uLvL4ixtuALBuOFLWDKLiX6fwjumoRSa+fA4Eqf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEi5A5OH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f40b5e059so2764597e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715375904; x=1715980704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bW+gUUp7l8Go1CEjGjrXDMeS/n8FalO7s3mty8efupU=;
        b=IEi5A5OHpoMKyGqT1ENiMyHycHYzC2zwhz49SygyAIVQqe8iT/TrE1mlxhjtirn3FG
         GrlrEeBNs8NOVPPvTBnOp4ZWBG1xP1wkCXTQZFEggVEu8KMYHhkH7cqHxCJjDcVW2+xH
         dyaJ8eTsoEgFOjAJhqTGkUYB3pxzCDpmrqasRo/5h8PGGB+o1nUcygJP8TdAmiNnsFqg
         7UPBFObTmznrdR22E+oNvZgkcmphdqjIXTOVKKntw6zJ9cIW2DlvftjABabE2tX44Ase
         uOtMYj3OKBGWidzcJFN/sJN2aFxYvf1+G96NnPAWDpFsfFPNfaKGnNF5ZK5Vb/xIfxKf
         1ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715375904; x=1715980704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW+gUUp7l8Go1CEjGjrXDMeS/n8FalO7s3mty8efupU=;
        b=iJrrZ8x6WXDVXjMw/SZYPCpb0JqFzGt+ZiSjor1Yp7axEz+R+rffvWQGX5YgxsJAx7
         JRRAweZOoJEtIHOuSsxuTxO+F6vJ5rLciXsirSezlI+7hS6AWLIttUBNVLBGSs5XwF0s
         Yn8apnwAqDWbZdgk3WtZjBuLhajdS4of4O77aFp6qcR/H2hXvdvLmFhtUdRZvS02biU5
         BJ3erBATzfhxD6qgHjkrswjb5hOJQxHJ09ftPq4VqNXD+vqEGO/omRG4DrrNZA5+E8RE
         cHudtbuhE1dDB0lfCgQpRNdQZ+Yw61HUgdH+FbqqoYb/8jMqPRyVruEJbImneUVImu9M
         jiOg==
X-Forwarded-Encrypted: i=1; AJvYcCUm0MWyLB3vCp2JQfDbubRPa34/YstuAxKkaNYHr2GMtbxMQ46KM5dWr3isqFUm4Uz5uAtMP/ptovRqBaI+GQ43vhHId10ZptEIa/qd
X-Gm-Message-State: AOJu0Yw1JR9oZPhUYdEBD0hNSwb/SwOrr20LtrvgVczpQeZ4IPZXA2FF
	iD5sOMX3Ld6X0aBwE5f63TV3S/XyGj+4vDJudEXZXXS75E8OnDMvBPW/HQjpgW6q/wwmcmClkW/
	ct/jRRSLrsbr0yB4H25rBQqhbs0sZMOYw
X-Google-Smtp-Source: AGHT+IGPkILCn/IMVULz6wDQe+q9nP4ck7QElKaVUtKeX7kznQ9B34b4fGHKhJyPm9699w9mGDIT8u2ZCO+H1TNmzU4=
X-Received: by 2002:a05:6512:1287:b0:51d:2a27:9574 with SMTP id
 2adb3069b0e04-5220fb698bemr3152547e87.6.1715375903458; Fri, 10 May 2024
 14:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 11 May 2024 07:18:11 +1000
Message-ID: <CAPM=9tzZ8edq4gpxJpube9EOAVDFXr-n7Hwh9qwZ=_aBP34esA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.9 final
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This should be the last set of fixes for 6.9, i915, xe and amdgpu are
the bulk here, one of the previous nouveau fixes turned up an issue,
so reverting it, otherwise one core and a couple of meson fixes.

drm-fixes-2024-05-11:
drm fixes for 6.9 final

core:
- fix connector debugging output

i915:
- Automate CCS Mode setting during engine resets
- Fix audio time stamp programming for DP
- Fix parsing backlight BDB data

xe:
- Fix use zero-length element array
- Move more from system wq to ordered private wq
- Do not ignore return for drmm_mutex_init

amdgpu:
- DCN 3.5 fix
- MST DSC fixes
- S0i3 fix
- S4 fix
- HDP MMIO mapping fix
- Fix a regression in visible vram handling

amdkfd:
- Spatial partition fix

meson:
- dw-hdmi: power-up fixes
- dw-hdmi: add badngap setting for g12

nouveau:
- revert SG_DEBUG fix that has a side effect
The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361=
:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-05-11

for you to fetch changes up to a222a6470d7eea91193946e8162066fa88da64c2:

  Revert "drm/nouveau/firmware: Fix SG_DEBUG error with
nvkm_firmware_ctor()" (2024-05-11 07:04:10 +1000)

----------------------------------------------------------------
drm fixes for 6.9 final

core:
- fix connector debugging output

i915:
- Automate CCS Mode setting during engine resets
- Fix audio time stamp programming for DP
- Fix parsing backlight BDB data

xe:
- Fix use zero-length element array
- Move more from system wq to ordered private wq
- Do not ignore return for drmm_mutex_init

amdgpu:
- DCN 3.5 fix
- MST DSC fixes
- S0i3 fix
- S4 fix
- HDP MMIO mapping fix
- Fix a regression in visible vram handling

amdkfd:
- Spatial partition fix

meson:
- dw-hdmi: power-up fixes
- dw-hdmi: add badngap setting for g12

nouveau:
- revert SG_DEBUG fix that has a side effect

----------------------------------------------------------------
Agustin Gutierrez (2):
      drm/amd/display: Fix DSC-re-computing
      drm/amd/display: MST DSC check for older devices

Alex Deucher (1):
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

Andi Shyti (1):
      drm/i915/gt: Automate CCS Mode setting during engine resets

Chaitanya Kumar Borah (1):
      drm/i915/audio: Fix audio time stamp programming for DP

Daniele Ceraolo Spurio (1):
      drm/xe/guc: Check error code when initializing the CT mutex

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2024-05-08' of
https://anongit.freedesktop.org/git/drm/drm-intel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-05-09' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.9-2024-05-10' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-05-10' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Revert "drm/nouveau/firmware: Fix SG_DEBUG error with
nvkm_firmware_ctor()"

Douglas Anderson (1):
      drm/connector: Add \n to message about demoting connector force-probe=
s

Jerome Brunet (2):
      drm/meson: dw-hdmi: power up phy on device init
      drm/meson: dw-hdmi: add bandgap setting for g12

Karthikeyan Ramasubramanian (1):
      drm/i915/bios: Fix parsing backlight BDB data

Lijo Lazar (1):
      Revert "drm/amdkfd: Add partition id field to location_id"

Lucas De Marchi (1):
      drm/xe/ads: Use flexible-array

Mario Limonciello (1):
      dm/amd/pm: Fix problems with reboot/shutdown for some SMU
13.0.4/13.0.11 users

Matthew Brost (1):
      drm/xe: Use ordered WQ for G2H handler

Michel D=C3=A4nzer (1):
      drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible

Nicholas Kazlauskas (1):
      drm/amd/display: Fix idle optimization checks for multi-display
and dual eDP

Nicholas Susanto (1):
      drm/amd/display: Enable urgent latency adjustments for DCN35

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  16 ++-
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |   4 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  33 ++++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |   2 +-
 drivers/gpu/drm/drm_connector.c                    |   2 +-
 drivers/gpu/drm/i915/display/intel_audio.c         | 113 ++---------------=
----
 drivers/gpu/drm/i915/display/intel_bios.c          |  19 +---
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |   5 -
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c        |   6 +-
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h        |   2 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   4 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  70 ++++++-------
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       |  19 ++--
 drivers/gpu/drm/xe/xe_guc_ads.c                    |   2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  10 +-
 drivers/gpu/drm/xe/xe_guc_ct.h                     |   2 +-
 drivers/gpu/drm/xe/xe_guc_ct_types.h               |   2 +
 20 files changed, 122 insertions(+), 203 deletions(-)

