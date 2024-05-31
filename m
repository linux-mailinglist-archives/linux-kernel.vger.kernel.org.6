Return-Path: <linux-kernel+bounces-197465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7A8D6B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0F283A75
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2320DF4;
	Fri, 31 May 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSBEHtFc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A904D26A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188397; cv=none; b=Vpo2K+9v6a4r0DVn7WqzIE9K9qbHyH6SNDDH60SzOCT9i8+EVdVOwUwt4SuSH08Rvi3D5aX3Jn3TeYT0KOzqnZeWuu27ZFRw8EXhQEgbejPcxcT04DvLYixNfBpmq44KpK5FvmOwiKxemzp3y+uaJvYUepsmkwHeMBeE0B46ntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188397; c=relaxed/simple;
	bh=NRh7SwR7lW/WZo1PwQv0aYl0vZDrJ+DXFVC3/sQVISo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SW+LoyFRKYsAb3cVsobqTAw4+C7VtdfI837dCLRzK7Hd+pU1bO2FoRLy76cR6LNmseX/Xmt6UYWRvQOgjQbQTWChQGw3RctzCgpcTBfWRMyPsdzBQjDohNu4nVx4G93ceZ/fjKCvEVe411/aj6DXUUrTSGmi552tX84oVRGdke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSBEHtFc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42134bb9677so3186685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717188393; x=1717793193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4g+rEwHBcMN+2aT1BC6VpP5t+V5uAhfcBKcCc2CEh0A=;
        b=ZSBEHtFcdtSDQF1CyHVv4NMfag3yE1IGoa3ewc/ntdRel75/W1y9FWBLurKYlYtE0K
         0jj7yopXwxWmPjmgK6zMKRr9QTlXKWddIue5v1/Y/kPRq8A5lmaYftLXSHXbJl9L4oEX
         v6gN5uTBFf9XDQnVHupkthMwGoahHaq7i/fT48nnYEdCfjXu13fGJ1gPgvDThwgheN08
         lWw5oIPixYLU0U84pmc72EAtVGVd/AsHCScFAT+Ygzbr9/dL8rOuCNChpb9GC07RcoDd
         yNQkmLnszMSNJIEsF/sbykRZQWrn11QUNIHZ+7/XwcXkBQux9wiQlWTUy/6ga3uCgzIp
         I4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717188393; x=1717793193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4g+rEwHBcMN+2aT1BC6VpP5t+V5uAhfcBKcCc2CEh0A=;
        b=D1QD7zQ29vEESxEExKcPd/6ehCmZrV+uvJIpvSd4woxadgEnw45ETneEdQuWZSPwtc
         GZy7X6qqaiEI7DL+EU/sZYYLpUMXxfV0vQD/3dwGEJ0nlzXu3cT4UlYjJ1QWw3hC9i7q
         m8qXNvimihKlqxgxl9s+xtEyCY0930KeHAixN5EqVgFd776LW+BIedKVe1gSu2oJFL2g
         Cdzo/8GML4qN219j4vfnNQCX/rgJKTXaN/fWYdmxlZj5ya+Z8nIV7tC818aCNVXrMNDC
         40to2d8/VUvpw/kmN7I1V/pzLC+N8Tem8gSj9oQDRgrEOudATCYshgPwni+rS/drfeUV
         ErqA==
X-Forwarded-Encrypted: i=1; AJvYcCVfrshjKl37F5LCrFe6PHT2d7f5sPynfLuOBvTj9fdJSU7iQIgnXT0jR7EMggfrAdd/wtVuk8ug56m2K0KydiXRRahf32sVud5LUG1w
X-Gm-Message-State: AOJu0Yx1QncDOp4w46Dv8IqGcC7utkkX13oNbYL/Y4t5Cy0Aw5h8qLaE
	AIUaakcxAOGwqxTQfiHJpZTfsf9oRb0s4e5BOpykZs8aHE1ZCa+Tc/St51+RiovDINZ1lhscDs1
	7D+G87pZkl84iIONVy1vaMz2zg5+qhcuB
X-Google-Smtp-Source: AGHT+IElKWdRFih2Jml1WOQJsNpU5+9fNskohGXotupKN6rRuuT8aQbOvjceSNmZztSQTj1xQxytgxklvg7TJ5GD9fc=
X-Received: by 2002:a05:600c:3144:b0:41b:f6b6:46cf with SMTP id
 5b1f17b1804b1-4212e0500c1mr28691055e9.11.1717188393295; Fri, 31 May 2024
 13:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 1 Jun 2024 06:46:21 +1000
Message-ID: <CAPM=9tzbuJuE=aW-A9Uwst-VuqJwXHR0Ez6Ov-OMxTvDEVjsMA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This is the weekly fixes pull. Lots of small fixes across the board,
one BUG_ON fix in shmem seems most important, otherwise amdgpu, i915,
xe mostly with small fixes to all the other drivers.

Dave.

drm-fixes-2024-06-01:
drm fixes for 6.10-rc2

shmem:
- fix BUG_ON in COW handling
- Warn when trying to pin imported objects

buddy:
- fix page size handling

dma-buf:
- sw-sync: Don't interfere with IRQ handling
- Fix kthreads-handling error path

i915:
- Fix a race in audio component by registering it later
- Make DPT object unshrinkable to avoid shrinking when framebuffer has
  not shrunk
- Fix CCS id calculation to fix a perf regression
- Fix selftest caching mode
- Fix FIELD_PREP compiler warnings
- Fix indefinite wait for GT wakeref release
- Revert overeager multi-gt pm reference removal

xe:
- One pcode polling timeout change
- One fix for deadlocks for faulting VMs
- One error-path lock imbalance fix

amdgpu:
- RAS fix
- Fix colorspace property for MST connectors
- Fix for PCIe DPM
- Silence UBSAN warning
- GPUVM robustness fix
- Partition fix
- Drop deprecated I2C_CLASS_SPD

amdkfd:
- Revert unused changes for certain 11.0.3 devices
- Simplify APU VRAM handling

lima:
- Fix dma_resv-related deadlock in object pin

msm:
- Remove build-time dependency on Python 3.9

nouveau:
- nvif: Fix possible integer overflow

panel:
- lg-sw43408: Select DP helpers; Declare backlight ops as static
- sitronix-st7789v: Various fixes for jt240mhqs_hwt_ek_e3 panel

panfrost:
- Fix dma_resv-related deadlock in object pin
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0=
:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-01

for you to fetch changes up to a2ce3f7752bfbb47e659574fc2e1e6942bca3c29:

  Merge tag 'drm-misc-fixes-2024-05-30' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2024-05-31 11:51:20 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc2

shmem:
- fix BUG_ON in COW handling
- Warn when trying to pin imported objects

buddy:
- fix page size handling

dma-buf:
- sw-sync: Don't interfere with IRQ handling
- Fix kthreads-handling error path

i915:
- Fix a race in audio component by registering it later
- Make DPT object unshrinkable to avoid shrinking when framebuffer has
  not shrunk
- Fix CCS id calculation to fix a perf regression
- Fix selftest caching mode
- Fix FIELD_PREP compiler warnings
- Fix indefinite wait for GT wakeref release
- Revert overeager multi-gt pm reference removal

xe:
- One pcode polling timeout change
- One fix for deadlocks for faulting VMs
- One error-path lock imbalance fix

amdgpu:
- RAS fix
- Fix colorspace property for MST connectors
- Fix for PCIe DPM
- Silence UBSAN warning
- GPUVM robustness fix
- Partition fix
- Drop deprecated I2C_CLASS_SPD

amdkfd:
- Revert unused changes for certain 11.0.3 devices
- Simplify APU VRAM handling

lima:
- Fix dma_resv-related deadlock in object pin

msm:
- Remove build-time dependency on Python 3.9

nouveau:
- nvif: Fix possible integer overflow

panel:
- lg-sw43408: Select DP helpers; Declare backlight ops as static
- sitronix-st7789v: Various fixes for jt240mhqs_hwt_ek_e3 panel

panfrost:
- Fix dma_resv-related deadlock in object pin

----------------------------------------------------------------
Abhinav Kumar (1):
      drm/msm: remove python 3.9 dependency for compiling msm

Adri=C3=A1n Larumbe (3):
      drm/panfrost: Fix dma_resv deadlock at drm object pin time
      drm/lima: Fix dma_resv deadlock at drm object pin time
      drm/gem-shmem: Add import attachment warning to locked pin function

Alex Deucher (4):
      drm/amdgpu: Adjust logic in amdgpu_device_partner_bandwidth()
      drm/amdgpu: silence UBSAN warning
      Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices=
"
      drm/amdkfd: simplify APU VRAM handling

Andi Shyti (1):
      drm/i915/gt: Fix CCS id's calculation for CCS mode setting

Arnd Bergmann (1):
      drm/i915/guc: avoid FIELD_PREP warning

Chris Wilson (1):
      drm/i915/gt: Disarm breadcrumbs if engines are already idle

Daniel Vetter (1):
      Merge tag 'drm-misc-fixes-2024-05-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2024-05-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2024-05-30' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-05-30' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.10-2024-05-30' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-05-30' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Dmitry Baryshkov (2):
      drm/panel/lg-sw43408: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/panel/lg-sw43408: mark sw43408_backlight_ops as static

Fedor Pchelkin (1):
      dma-buf: handle testing kthreads creation failure

Gerald Loacker (3):
      drm/panel: sitronix-st7789v: fix timing for jt240mhqs_hwt_ek_e3 panel
      drm/panel: sitronix-st7789v: tweak timing for jt240mhqs_hwt_ek_e3 pan=
el
      drm/panel: sitronix-st7789v: fix display size for
jt240mhqs_hwt_ek_e3 panel

Guenter Roeck (1):
      drm/nouveau/nvif: Avoid build error due to potential integer overflow=
s

Hawking Zhang (1):
      drm/amdgpu: correct hbm field in boot status

Heiner Kallweit (1):
      drm/amd/pm: remove deprecated I2C_CLASS_SPD support from newly
added SMU_14_0_2

Himal Prasad Ghimiray (1):
      drm/xe: Change pcode timeout to 50msec while polling again

Imre Deak (1):
      drm/i915: Fix audio component initialization

Janusz Krzysztofik (1):
      Revert "drm/i915: Remove extra multi-gt pm-references"

Jesse Zhang (1):
      drm/amdgpu: fix dereference null return value for the function
amdgpu_vm_pt_parent

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Mario Limonciello (1):
      drm/amd/display: Enable colorspace property for MST connectors

Matthew Auld (2):
      drm/buddy: stop using PAGE_SIZE
      drm/tests/buddy: stop using PAGE_SIZE

Matthew Brost (1):
      drm/xe: Only use reserved BCS instances for usm migrate exec queue

Mohamed Ahmed (1):
      drm/nouveau: use tile_mode and pte_kind for VM_BIND bo allocations

Niranjana Vishwanathapura (1):
      drm/xe: Properly handle alloc_guc_id() failure

Nirmoy Das (1):
      drm/i915/selftests: Set always_coherent to false when reading from CP=
U

Rajneesh Bhardwaj (1):
      drm/amdgpu: Make CPX mode auto default in NPS4

Tetsuo Handa (1):
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Vidya Srinivas (1):
      drm/i915/dpt: Make DPT object unshrinkable

Wachowski, Karol (1):
      drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

 drivers/dma-buf/st-dma-fence.c                     |  6 ++++
 drivers/dma-buf/sync_debug.c                       |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 19 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  6 +++-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 11 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  3 ++
 drivers/gpu/drm/amd/include/atomfirmware.h         |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  1 -
 drivers/gpu/drm/drm_buddy.c                        |  2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |  5 +++
 drivers/gpu/drm/i915/display/intel_audio.c         | 32 +++++++++++------
 drivers/gpu/drm/i915/display/intel_audio.h         |  1 +
 .../gpu/drm/i915/display/intel_display_driver.c    |  2 ++
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     | 18 ++++++++++
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |  4 ++-
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |  2 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        | 15 ++++----
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  6 ++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c        |  2 +-
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |  8 +++++
 drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h      |  6 ++--
 drivers/gpu/drm/lima/lima_gem.c                    |  2 +-
 drivers/gpu/drm/msm/registers/gen_header.py        |  5 +--
 drivers/gpu/drm/nouveau/nvif/object.c              | 24 +++++++++----
 drivers/gpu/drm/panel/Kconfig                      |  2 ++
 drivers/gpu/drm/panel/panel-lg-sw43408.c           |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     | 16 ++++-----
 drivers/gpu/drm/panfrost/panfrost_gem.c            |  2 +-
 drivers/gpu/drm/tests/drm_buddy_test.c             | 42 +++++++++++-------=
----
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  1 +
 drivers/gpu/drm/xe/xe_migrate.c                    | 12 +++----
 drivers/gpu/drm/xe/xe_pcode.c                      |  2 +-
 include/drm/drm_buddy.h                            |  6 ++--
 39 files changed, 186 insertions(+), 114 deletions(-)

