Return-Path: <linux-kernel+bounces-411180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B031E9CF430
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEFA28808A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503061D54C7;
	Fri, 15 Nov 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE0br+av"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCB185B58
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696223; cv=none; b=nYUIf9pgEKdR6y7DjktdIHRXcHTxOwqSvQKnmKioe53cz0qREkL4kmh0WtQ7uNH72PDHOnS835Nf3qp80oVx2xIosjtGGrGDv/2CZPw03uW+IxAmGYQ7ciGM9PAM9BQnwRdXXdQLDpoINuFYb7rrxDb96Mcz0mdOi4JSK3JifFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696223; c=relaxed/simple;
	bh=sPNR/WsccMVXypZSmpUX5y1ntX/hab/v/hdExZ0IFPY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ne4XE+LcEyga6LABPJf812PIqbpmuAXHFGVQVAC7/Xo+2fqbOaw0ABXnFGRzkV2ZCW8pQdJKxh846Qyszvl2DcXQ0onuoG9ajxNa0tVdE2Jf0948G4Ggw4bT4ltzhkk8AiGW9jTGYuwlXhPdk78S3lEjBskrNsgPRuPcHXPgHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE0br+av; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso2883846a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731696220; x=1732301020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns6WfZhSQfmJ7I6CQwzLZn1dFVVnjRWH4a8zFMhdBVw=;
        b=IE0br+avvsunkdJRS2Txa6ZSAzh8THaDmQ3t+QHf9w5nO9G9br1q/vcFVCcH1/MLMm
         wKk/NGdJiuB3L5QHXZ+LJHkop+U+Pc1Qc2SSa8dYXIQ6saW0OMZ3dB+aO+lYS/RMSVme
         TLbOXrALeMQdX1Pz93lFNFNXVTJfsKhZ2EIUAEvSsQmX3EAdC/srW1ceHQgPjg4XeCi4
         Z+17uLO4c2fQ3boruGfT4tG0+pxE4m0FqTW1gCVCPP2RWkof6dnlO0N0A3wpdGCDcvBp
         LyPdvn7fV0IFUJ4xLXpM4mHF8lzObcyAP0JgxPn2dx1m3OLJf7pMnYuclrWXJlID01KD
         LeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731696220; x=1732301020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ns6WfZhSQfmJ7I6CQwzLZn1dFVVnjRWH4a8zFMhdBVw=;
        b=s2oU/GWiXrFx5jWTYPedw5tYhCj4TaB2NqGY6wDSOlGLHfjMrR+4JBhQIzwPSFQQ8w
         C/0+LG/5jmH64EQVokBfl05/KEp+4lqnPF/j2huyXJuEpZQbJXe8eZk9Mn78GEXehaks
         kkpRgEMuLc2Xr1Gcwq/lMnfndeLYVz7P6xNE0C2MIzGJqqU/HqzvmSa+0fgT1Bv378OC
         VPP50M8L9M9/WSs+h+Ow3P3furdMDtl0FP9qNObvfdn3B7mBmofh4COwyHxuUierDVNs
         nvA0fY4LtlisPcCBx2QLnLNe0TGUT2mWHYnvvY884LY9C7JLxDK9kYlPxB3NTeV/f7ZB
         Bwmg==
X-Forwarded-Encrypted: i=1; AJvYcCU626rcCAkU7wyBV1UzpMYk9TTrmo+99+rbLytcsluz8idMTvhYpHvcQIj52j1fAZP18m+R3SD9sFt3W4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEYjvwK4caF/8S04QqPyEPX91wRUdJRHeBLxh0fJ6tGKFPUd8
	3yZkntKYMDa0N4MMOzka5Lv4CBDdy4BqnHHWom8QUaQIOLaPeQzfatPHa04wwaG7LozmGRDSt0l
	MzgX7dKKK7JJljEaksxs12w8FDmk=
X-Google-Smtp-Source: AGHT+IHPCvRbPxfg5LsoJW7Tjh2CF8E5SZKCsqBDT5bA34WqRLRDci7Mj6XwarJG2pmuwL+6cKxaqGi6zL6TuhPec/8=
X-Received: by 2002:a17:907:7e9e:b0:a99:65c6:7f34 with SMTP id
 a640c23a62f3a-aa4833e8285mr325110966b.7.1731696219911; Fri, 15 Nov 2024
 10:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 16 Nov 2024 04:43:28 +1000
Message-ID: <CAPM=9tyjNNXJ-UZryHaGhapXqhPHB=SWH5v0tR_BF3iZOL873g@mail.gmail.com>
Subject: [git pull] drm fixes for 6.12-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Final week of fixes, lots of small amdgpu fixes, some i915 and xe
fixes, the nouveau changes fix a recent regression and some laptop
panel black screens, then a couple of other misc ones. It's probably a
little busier than I'd like, but each fix seems fine.

Dave.

drm-fixes-2024-11-16:
drm fixes for 6.12-rc8

amdgpu:
- PSR fix
- Panel replay fixes
- DML fix
- vblank power fix
- Fix video caps
- SMU 14.0 fix
- GPUVM fix
- MES 12 fix
- APU carve out fix
- DC vbios fix
- NBIO fix

i915:
- Don't load GSC on ARL-H and ARL-U if too old FW
- Avoid potential OOPS in enabling/disabling TV output

xe:
- Fix unlock on exec ioctl error path
- Fix hibernation on LNL due to ggtt getting lost
- Fix missing runtime PM in OA release

bridge:
- tc358768: Fix DSI command tx

nouveau:
- Fix GSP AUX error handling
- dp: Handle retires for AUX CH transfers with GSP
- fw: Sync DMA after setup

panthor:
- Fix partial BO mappings to GPU

rockchip:
- vop: Avoid null-ptr deref in plane-state check

vmwgfx:
- Avoid null-ptr deref in surface creation
The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623=
:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-16

for you to fetch changes up to 21c1c6c7d732c2f6f4c5ffc77e103aa3ae8bff1d:

  Merge tag 'drm-xe-fixes-2024-11-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-11-16 04:31:54 +1000)

----------------------------------------------------------------
drm fixes for 6.12-rc8

amdgpu:
- PSR fix
- Panel replay fixes
- DML fix
- vblank power fix
- Fix video caps
- SMU 14.0 fix
- GPUVM fix
- MES 12 fix
- APU carve out fix
- DC vbios fix
- NBIO fix

i915:
- Don't load GSC on ARL-H and ARL-U if too old FW
- Avoid potential OOPS in enabling/disabling TV output

xe:
- Fix unlock on exec ioctl error path
- Fix hibernation on LNL due to ggtt getting lost
- Fix missing runtime PM in OA release

bridge:
- tc358768: Fix DSI command tx

nouveau:
- Fix GSP AUX error handling
- dp: Handle retires for AUX CH transfers with GSP
- fw: Sync DMA after setup

panthor:
- Fix partial BO mappings to GPU

rockchip:
- vop: Avoid null-ptr deref in plane-state check

vmwgfx:
- Avoid null-ptr deref in surface creation

----------------------------------------------------------------
Akash Goel (1):
      drm/panthor: Fix handling of partial GPU mapping of BOs

Alex Deucher (1):
      Revert "drm/amd/display: parse umc_info or vram_info based on ASIC"

Andy Yan (1):
      drm/rockchip: vop: Fix a dereferenced before check warning

Ashutosh Dixit (1):
      drm/xe/oa: Fix "Missing outer runtime PM protection" warning

Chen Ridong (1):
      drm/vmwgfx: avoid null_ptr_deref in vmw_framebuffer_surface_create_ha=
ndle

Christian K=C3=B6nig (2):
      drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()
      drm/amdgpu: enable GTT fallback handling for dGPUs only

Daniele Ceraolo Spurio (1):
      drm/i915/gsc: ARL-H and ARL-U need a newer GSC FW.

Dave Airlie (7):
      nouveau: fw: sync dma after setup is called.
      nouveau: handle EBUSY and EAGAIN for GSP aux errors.
      nouveau/dp: handle retries for AUX CH transfers with GSP.
      Merge tag 'drm-intel-fixes-2024-11-14' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-11-14' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.12-2024-11-14' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2024-11-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David Rosca (1):
      drm/amdgpu: Fix video caps for H264 and HEVC encode maximum size

Dillon Varone (1):
      drm/amd/display: Require minimum VBlank size for stutter optimization

Francesco Dolcini (1):
      drm/bridge: tc358768: Fix DSI command tx

Hamish Claxton (1):
      drm/amd/display: Fix failure to read vram info due to static BP_RESUL=
T

Jack Xiao (1):
      drm/amdgpu/mes12: correct kiq unmap latency

Matthew Auld (2):
      drm/xe: improve hibernation on igpu
      drm/xe: handle flat ccs during hibernation on igpu

Matthew Brost (2):
      drm/xe: Ensure all locks released in exec IOCTL
      drm/xe: Restore system memory GGTT mappings

Rodrigo Siqueira (1):
      drm/amd/display: Adjust VSDB parser for replay feature

Ryan Seto (1):
      drm/amd/display: Handle dml allocation failure to avoid crash

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Tim Huang (1):
      drm/amd/pm: print pp_dpm_mclk in ascending order on SMU v14.0.0

Tom Chung (2):
      drm/amd/display: Change some variable name of psr
      drm/amd/display: Fix Panel Replay not update screen correctly

Vijendar Mukunda (1):
      drm/amd: Fix initialization mistake for NBIO 7.7.0

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Grab intel_display from the encoder to avoid potential oops=
ies

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  13 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c             |   6 ++
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  12 +--
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  12 +--
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |   2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 117 +++++++++++------=
----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_irq_params.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |   3 +
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  11 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |   5 +-
 drivers/gpu/drm/bridge/tc358768.c                  |  21 +++-
 drivers/gpu/drm/i915/display/intel_tv.c            |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c          |  50 +++++----
 drivers/gpu/drm/i915/i915_drv.h                    |   8 +-
 drivers/gpu/drm/i915/intel_device_info.c           |  24 ++++-
 drivers/gpu/drm/i915/intel_device_info.h           |   4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c    |  61 ++++++-----
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c           |  11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |   6 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   2 +
 drivers/gpu/drm/xe/xe_bo.c                         |  43 ++++----
 drivers/gpu/drm/xe/xe_bo_evict.c                   |  20 ++--
 drivers/gpu/drm/xe/xe_exec.c                       |   4 +-
 drivers/gpu/drm/xe/xe_oa.c                         |   2 +
 include/drm/intel/i915_pciids.h                    |  19 +++-
 34 files changed, 305 insertions(+), 197 deletions(-)

