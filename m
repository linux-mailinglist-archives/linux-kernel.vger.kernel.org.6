Return-Path: <linux-kernel+bounces-318127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424196E8BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629B61C23600
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E8537F5;
	Fri,  6 Sep 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZXKa/32"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845C4E1B3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597759; cv=none; b=ETxQ9RlFTqDcaB4o3otqS+15KPZHS/fG106cKTQxp0lrBbVcMsgctgcnUbGORf3xc55mC3Alw+UH7MSmDlYVblatAIGef+bb7Dcp583y7G6l7hgRXoTAQlM4bU+fScrN7D3LyA4pEyGCY2btDfBKISf8jE+BJJ7XDa2CMc8RE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597759; c=relaxed/simple;
	bh=BCbBBSz9pg1bWSfFiHrWMLrG2AxbpyzbeZ4FHvCGUKY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uCuCIXRYsOjYNFB64I8GxgzCHX17zqeIiurbaIocnBirZBNnlV+vlXvAlncXAWX6kbuVT/4uXy1cOU+cdZd1Ba9ByLlunmgcwOaSnzX0sv21/HH3zXywo2mWkZ0lVrLb3yLjBVODGx5Kb3c/SFbmIY6r/rWFjaltxoNZnuCcNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZXKa/32; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so197332866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725597756; x=1726202556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HNTgh0Gw7k2vbgdhNpFyVMrFhVun9hfimao1T3fhE4=;
        b=CZXKa/32qOudPL+y/R2MuuozWfJpxs5inGLzJ5M9jC0XE3ynf00f0JXmWg9bnJMroN
         Kq53E7JO4bAJ6puRV30P9BAuXL/+yp2N6+j1rRV7T4U9bZGYj1994x5Zu+fhvFu+bWoR
         m+VoMnNNRJ8psXnR97Bmb1cowjHAXMO6KIb8ez+Td78Rm7FfBjfRVqZVNB2lcr+8zAma
         DZ4JRO8AysEoh7ySzL5Wbd0cUdJpnUZkFpxDd0gCLoOXBwDfudSgMXvwAqX0YZ31r8D9
         AfFnJPFAebGgczzFvJb5rbspQh76jjKXJFso3dbcsLuzD9nmzS00egHuhcSBMr1OOJx2
         KLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597756; x=1726202556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HNTgh0Gw7k2vbgdhNpFyVMrFhVun9hfimao1T3fhE4=;
        b=eUvrZZOHp51IjhBCEYxeu+BIBHnZ/Q4jri+0wjutCCsHQizQ3LzDmXarlBF+MIZopY
         x84qOaEYU1e6NLSKWH9b6pMEeZf7DSrM2disQFo6016Ao2KMBR++HF3yX1uw5rOyesdU
         HE34yOtMcCEx3x2xhxX7oojfsxE9BYy52eb5yMP6UcTtkXDT5IVVDhMHdqR6ukjm9lav
         g8X5QIhgU2JfF91Qk65TgtK8hN7wFSDFev5LIyZR9Hq4YdsZgxpxu79S9Bof8wD/xkI+
         5AxqZs+6YP5v/ySgWf1vLuEw/oi4nSd3hrc81R83UeoWgWf1YrcQ2t/vmi97ygGwZt0p
         JKSg==
X-Forwarded-Encrypted: i=1; AJvYcCXI0OrE3bOQfB/xiJgIKqsbFA7z/QLRTEQQ3Fkkg6F1NYXXRvA5i9nUI8oA5BS6XUATII2yeNiUJY3kSmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLzv79uvDTagdo/XVBjxrMap1LDO/Hx5wdjuns7H7985+eHDr
	dSlYQlQlLIrLNwnxjhN5qMWsoL6G72QDZmCJHq2tpKLCUkzGKkFmW85NbyYk4Bl38oj4bWhZ7yT
	1WMCEQjTtEo7dnNJ+qzyyJThcA+pdwK3o
X-Google-Smtp-Source: AGHT+IFkdH+PKjAfxOEWEApI1PAeMzo3NRnrgpgvh8In4iDMY2t0zHfT2XRFQJXd4EDMBNQCzq9u5iiqxe+gnrfDilA=
X-Received: by 2002:a17:906:d7dd:b0:a86:9fac:6939 with SMTP id
 a640c23a62f3a-a8a8644482bmr137611966b.30.1725597755552; Thu, 05 Sep 2024
 21:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 6 Sep 2024 14:42:24 +1000
Message-ID: <CAPM=9twtq1CjWbeNnVKRaquctv6GHYSixXofFbprS4Dk5iBkGg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This has a fair few patches in it, but I reviewed them all and they
seem like real things, amdgpu, i915 and xe each have a bunch of fixes
for various things, then there is a some bridge suspend/resume
ordering fixes for a recent rework, and then some single driver
changes in a few others.

Nothing looks too serious, hopefully next week is quiet.

Dave.

drm-fixes-2024-09-06:
drm fixes for 6.11-rc7

amdgpu:
- IPS workaround
- Fix compatibility with older MES firmware
- Fix CPU spikes when clearing VRAM
- Backlight fix
- PMO fix
- Revert SWSMU change to fix regression

xe:
- GSC loading fix
- PCODE mutex fix
- Suspend/Resume fixes
- RPM fixes

i915:
- Do not attempt to load the GSC multiple times
- Fix readout degamma_lut mismatch on ilk/snb
- Mark debug_fence_init_onstack() with __maybe_unused
- fence: Mark debug_fence_free() with __maybe_unused
- display: Add mechanism to use sink model when applying quirk
- display: Increase Fast Wake Sync length as a quirk

komeda:
- zpos normalization fix

nouveau:
- incorrect register fix

imagination:
- memory leak fix

bridge:
- hdmi/bridge rework fixes

panthor:
- cache coherency fix
- hi priority access fix

panel:
- change of compatible string

fbdev:
- deferred-io init with no struct page fix
The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6=
:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-09-06

for you to fetch changes up to 141bb6bc73cf45e8b742d6fafa6734b6d5f82b77:

  Merge tag 'amd-drm-fixes-6.11-2024-09-05' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-09-06
11:31:02 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc7

amdgpu:
- IPS workaround
- Fix compatibility with older MES firmware
- Fix CPU spikes when clearing VRAM
- Backlight fix
- PMO fix
- Revert SWSMU change to fix regression

xe:
- GSC loading fix
- PCODE mutex fix
- Suspend/Resume fixes
- RPM fixes

i915:
- Do not attempt to load the GSC multiple times
- Fix readout degamma_lut mismatch on ilk/snb
- Mark debug_fence_init_onstack() with __maybe_unused
- fence: Mark debug_fence_free() with __maybe_unused
- display: Add mechanism to use sink model when applying quirk
- display: Increase Fast Wake Sync length as a quirk

komeda:
- zpos normalization fix

nouveau:
- incorrect register fix

imagination:
- memory leak fix

bridge:
- hdmi/bridge rework fixes

panthor:
- cache coherency fix
- hi priority access fix

panel:
- change of compatible string

fbdev:
- deferred-io init with no struct page fix

----------------------------------------------------------------
Adri=C3=A1n Larumbe (1):
      drm/panthor: flush FW AS caches in slow reset path

Alex Deucher (2):
      drm/amdgpu: always allocate cleared VRAM for GEM allocations
      Revert "drm/amdgpu: align pp_power_profile_mode with kernel docs"

Andy Shevchenko (2):
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Daniele Ceraolo Spurio (2):
      drm/i915: Do not attempt to load the GSC multiple times
      drm/xe/gsc: Do not attempt to load the GSC multiple times

Dave Airlie (5):
      nouveau: fix the fwsec sb verification register.
      Merge tag 'drm-intel-fixes-2024-09-05' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-09-05' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-09-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.11-2024-09-05' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Dillon Varone (1):
      drm/amd/display: Block timing sync for different signals in PMO

Dmitry Baryshkov (3):
      drm/display: stop depending on DRM_DISPLAY_HELPER
      drm/bridge-connector: move to DRM_DISPLAY_HELPER module
      drm/bridge-connector: reset the HDMI connector state

Imre Deak (1):
      drm/xe: Suspend/resume user access only during system s/r

Jack Xiao (1):
      drm/amdgpu/mes: add mes mapping legacy queue switch

Jouni H=C3=B6gander (2):
      drm/i915/display: Add mechanism to use sink model when applying quirk
      drm/i915/display: Increase Fast Wake Sync length as a quirk

Leo Li (2):
      drm/amd/display: Determine IPS mode by ASIC and PMFW versions
      drm/amd/display: Lock DC and exit IPS when changing backlight

Maarten Lankhorst (1):
      drm/xe/display: Match i915 driver suspend/resume sequences better

Mary Guillemard (1):
      drm/panthor: Restrict high priorities on group_create

Matt Coster (1):
      drm/imagination: Free pvr_vm_gpuva after unlink

Matt Roper (1):
      drm/xe/pcode: Treat pcode as per-tile rather than per-GT

Rodrigo Vivi (2):
      drm/xe: Add missing runtime reference to wedged upon gt_reset
      drm/xe/display: Avoid encoder_suspend at runtime suspend

Ryan Walklin (2):
      dt-bindings: display: panel: Rename WL-355608-A8 panel to rg35xx-*-pa=
nel
      drm: panel: nv3052c: Correct WL-355608-A8 panel compatible

Thomas Zimmermann (1):
      drm/fbdev-dma: Only install deferred I/O if necessary

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix readout degamma_lut mismatch on ilk/snb

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

 ...608-a8.yaml =3D> anbernic,rg35xx-plus-panel.yaml} |  15 ++-
 MAINTAINERS                                        |   2 +-
 drivers/gpu/drm/Makefile                           |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  49 +++++++---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  39 +++++++-
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   6 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  10 +-
 drivers/gpu/drm/bridge/Kconfig                     |   1 +
 drivers/gpu/drm/display/Kconfig                    |  24 +++--
 drivers/gpu/drm/display/Makefile                   |   2 +
 .../gpu/drm/{ =3D> display}/drm_bridge_connector.c   |  13 ++-
 drivers/gpu/drm/drm_fbdev_dma.c                    |  83 ++++++++++++----
 drivers/gpu/drm/i915/display/intel_alpm.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   4 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   4 +
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |  16 +++-
 drivers/gpu/drm/i915/display/intel_dp_aux.h        |   2 +-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |  31 +++++-
 drivers/gpu/drm/i915/display/intel_quirks.c        |  68 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h        |   6 ++
 drivers/gpu/drm/i915/gt/uc/intel_gsc_uc.c          |   2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |   5 +
 drivers/gpu/drm/i915/i915_sw_fence.c               |   8 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |   4 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |   2 +
 drivers/gpu/drm/imx/lcdc/Kconfig                   |   2 +
 drivers/gpu/drm/ingenic/Kconfig                    |   2 +
 drivers/gpu/drm/kmb/Kconfig                        |   2 +
 drivers/gpu/drm/mediatek/Kconfig                   |   2 +
 drivers/gpu/drm/meson/Kconfig                      |   2 +
 drivers/gpu/drm/msm/Kconfig                        |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c    |   2 +-
 drivers/gpu/drm/omapdrm/Kconfig                    |   2 +
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c    |   2 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |  23 +++++
 drivers/gpu/drm/panthor/panthor_fw.c               |   8 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |  21 ++++-
 drivers/gpu/drm/panthor/panthor_mmu.h              |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c            |   2 +-
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |   2 +
 drivers/gpu/drm/renesas/rz-du/Kconfig              |   2 +
 drivers/gpu/drm/renesas/shmobile/Kconfig           |   2 +
 drivers/gpu/drm/rockchip/Kconfig                   |   4 +
 drivers/gpu/drm/tegra/Kconfig                      |   1 +
 drivers/gpu/drm/tidss/Kconfig                      |   2 +
 .../gpu/drm/xe/compat-i915-headers/intel_pcode.h   |   8 +-
 .../gpu/drm/xe/compat-i915-headers/intel_uncore.h  |   7 ++
 drivers/gpu/drm/xe/display/xe_display.c            |  23 +++--
 drivers/gpu/drm/xe/xe_device_types.h               |   6 ++
 drivers/gpu/drm/xe/xe_gsc.c                        |  12 +++
 drivers/gpu/drm/xe/xe_gt.c                         |   7 +-
 drivers/gpu/drm/xe/xe_gt_types.h                   |   6 --
 drivers/gpu/drm/xe/xe_guc_pc.c                     |   2 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      |   4 +-
 drivers/gpu/drm/xe/xe_pcode.c                      | 104 ++++++++++-------=
----
 drivers/gpu/drm/xe/xe_pcode.h                      |  16 ++--
 drivers/gpu/drm/xe/xe_tile.c                       |   3 +
 drivers/gpu/drm/xe/xe_uc_fw.h                      |   9 +-
 drivers/gpu/drm/xe/xe_vram_freq.c                  |   6 +-
 drivers/gpu/drm/xlnx/Kconfig                       |   1 +
 include/uapi/drm/panthor_drm.h                     |   6 +-
 66 files changed, 546 insertions(+), 178 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{wl-355608-a8.yaml
=3D> anbernic,rg35xx-plus-panel.yaml} (67%)
 rename drivers/gpu/drm/{ =3D> display}/drm_bridge_connector.c (97%)

