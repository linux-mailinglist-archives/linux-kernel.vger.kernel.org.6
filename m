Return-Path: <linux-kernel+bounces-272120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E228C945748
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5267BB225D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60C20B28;
	Fri,  2 Aug 2024 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJdPvNc+"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13141C2BD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575300; cv=none; b=RFnCRHAZUkjujk498V78rD2KoyF2NCExGP/FYd51JZVsFfijSgwKfIESrEYv3OJlrp9VfbJO9UG4BG7AhKQ6U6jdgzUwLbBHmNOd8Mqbxo8znGuuiKMNSwWy1tdCBHIpowUXdWurAzvl+3EYD2HgaUQk+HNHWKIC+8f2IBb1gKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575300; c=relaxed/simple;
	bh=eog2FjC1EYDmc3Pqnq98TwQQco8omNS757as43ghfxY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XXS3TWIFj4rpPYuojLRtbw2OI+b0brOdiHqz04B/Xl9ndJb9yFUGmDwgS+PPuoTd2SL63/BWCM/9RIne47+s69qFEWwTgh7fujiLvlSsCV/3zGzJ34wLKwZ2e4GyR2F8AyFKKAldKMPK1QUE+iA6snzbEvYX7luoHIg0PZQi07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJdPvNc+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94aa5080so99110666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722575297; x=1723180097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQSBIHh2x6d9F0Z2/XcgwrwlzUqOX9u6dBtDOp6ZOKw=;
        b=WJdPvNc+tTK/HXAewV6NkxyPlv/hn/ryTN78njcoHIkuz6RPeazYbpfVu8lOeGkSfk
         iHBWiwZpBnjYO/v+wxr6URTLEec4RG2QAiSJOKSRq04OOAJZozv1aF9qsHnP6mbH8jD4
         Emwes/2Sxti6+DAUChlBaekutpCyRGRadpgozCfwrsubCbWoZg5CHs1vqCkv0SXJGVL5
         5a+w2uEHXgwVgSoF+mUWlIwsLvUaiNx6y1oMknNn/vTl+vqEBF2q/GFa7E9y52wYMnqI
         qQ9cPr4nMuBZ6LP2eiMxe8VQXWV4WhiPqAxZ7Dlv/QmZeV/5USN/iCuS/Kq1bi7KiBD+
         9GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722575297; x=1723180097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQSBIHh2x6d9F0Z2/XcgwrwlzUqOX9u6dBtDOp6ZOKw=;
        b=Z20tOAr+2tIp8KgjPW6rp6kNlITISgWL8H6B8EIPxOZo+mZULZ4HyJQ6ET4v5luJDO
         43x7MglxCBONo/ueT9tszQY7BP8NjzmTC1Y3tOsuF1/Qx5f8vZHei7WhLudySOKSMvh3
         Yk89j3l2CX4HTavpez73wtxjdn5B/rcxNbcpcx2xy7AQ+tjXCo3I8ntcIqALMe5bhHZI
         YS4/dSkYKDTdu4Ob7msLnMKfPwnxtp/FAxiSxuvg0KFDTv0QVpTtwKF/ew9l/wh/8UZe
         5gjl6xz3WvKnsyTxcQbtBBSuh48AtgtolLwu8Zd2H8DDiHO54G3XYLCGmGxukJeP757n
         Dg0A==
X-Forwarded-Encrypted: i=1; AJvYcCUX8l6phvN017OJG7dr2pePHLVqwsFART3aPrJrmaFwBLdo0FIqN4NcfTNRquFmlblEhFvJ05VQcaiCwbtUQwL4AKU97pZgDQNW7hly
X-Gm-Message-State: AOJu0YwYKPbTYT/k1oJ9q5trDpyaST3xVeMO95D38nlx2r9yKxY4LcDc
	fb1Z50X5kRigvTiUxuaA1IAA5yXA27uFZ/YFdUpjYNfVil0vGLsYasJyeLKN8uULjZ9bnRG5XRL
	32sFdrq+bqR7O6HsRLZ7kY0RxTiE=
X-Google-Smtp-Source: AGHT+IEcTILTMdnWLjjOTY1mWVR8vxXku5vDqawPsrHX4ltfDplMoweepY+N6j+5QQh09FQZJN0qIT5bKCOah18V9y4=
X-Received: by 2002:a17:907:d16:b0:a7a:bae8:f297 with SMTP id
 a640c23a62f3a-a7dc5016569mr142804666b.15.1722575296994; Thu, 01 Aug 2024
 22:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 2 Aug 2024 15:08:04 +1000
Message-ID: <CAPM=9tw0tAEd9LQuK-ANW501UATMrCDJvyAube9N_umUBBWFDQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Regular weekly fixes. This is a bit larger than usual but doesn't seem
too crazy.

Most of it is vmwgfx changes that fix a bunch of issues with wayland
userspaces with dma-buf/external buffers and modesetting fixes.

Otherwise it's kinda spread out, v3d fixes some new ioctls, nouveau
has regression revert and fixes, amdgpu, i915 and ast have some small
fixes, and some core fixes spread about.

Let me know if any problems,
Thanks,
Dave.

drm-fixes-2024-08-02:
drm fixes for 6.11-rc2

client:
- fix error code

atomic:
- allow damage clips with async flips
- allow explicit sync with async flips

kselftests:
- fix dmabuf-heaps test

panic:
- fix schedule_work in panic paths

panel:
- fix OrangePi Neo orientation

gpuvm:
- fix missing dependency

amdgpu:
- SMU 14.x update
- Fix contiguous VRAM handling for IB parsing
- GFX 12 fix
- Regression fix for old APUs

i915:
- Static analysis fix for int overflow
- Fix for HDCP2_STREAM_STATUS macro and removal of PWR_CLK_STATE for gen12

nouveau:
- revert busy wait change that caused a resume regression
- fix buffer placement fault on dynamic pm s/r
- fix refcount underflow

ast:
- fix black screen on resume
- wake during connector status detect

v3d:
- fix issues with perf/timestamp ioctls

vmwgfx:
- fix deadlock in dma-buf fence polling
- fix screen surface refcounting
- fix dumb buffer handling
- fix support for external buffers
- fix overlay with screen targets
- trigger modeset on screen moves
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b=
:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-02

for you to fetch changes up to 27ce65f65258cf2f2855162cbeef59659a81fac4:

  Revert "nouveau: rip out busy fence waits" (2024-08-02 14:38:28 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc2

client:
- fix error code

atomic:
- allow damage clips with async flips
- allow explicit sync with async flips

kselftests:
- fix dmabuf-heaps test

panic:
- fix schedule_work in panic paths

panel:
- fix OrangePi Neo orientation

gpuvm:
- fix missing dependency

amdgpu:
- SMU 14.x update
- Fix contiguous VRAM handling for IB parsing
- GFX 12 fix
- Regression fix for old APUs

i915:
- Static analysis fix for int overflow
- Fix for HDCP2_STREAM_STATUS macro and removal of PWR_CLK_STATE for gen12

nouveau:
- revert busy wait change that caused a resume regression
- fix buffer placement fault on dynamic pm s/r
- fix refcount underflow

ast:
- fix black screen on resume
- wake during connector status detect

v3d:
- fix issues with perf/timestamp ioctls

vmwgfx:
- fix deadlock in dma-buf fence polling
- fix screen surface refcounting
- fix dumb buffer handling
- fix support for external buffers
- fix overlay with screen targets
- trigger modeset on screen moves

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: Fix APU handling in amdgpu_pm_load_smu_firmware()

Andr=C3=A9 Almeida (2):
      drm/atomic: Allow userspace to use explicit sync with atomic async fl=
ips
      drm/atomic: Allow userspace to use damage clips with async flips

Christian K=C3=B6nig (1):
      drm/amdgpu: fix contiguous handling for IB parsing v2

Dan Carpenter (1):
      drm/client: Fix error code in drm_client_buffer_vmap_local()

Danilo Krummrich (2):
      drm/gpuvm: fix missing dependency to DRM_EXEC
      drm/nouveau: prime: fix refcount underflow

Dave Airlie (5):
      nouveau: set placement to original placement on uvmm validate.
      Merge tag 'amd-drm-fixes-6.11-2024-07-27' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-08-01' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-08-01' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Revert "nouveau: rip out busy fence waits"

Dmitry Osipenko (1):
      drm/virtio: Fix type of dma-fence context variable

Ian Forbes (2):
      drm/vmwgfx: Fix overlay when using Screen Targets
      drm/vmwgfx: Trigger a modeset when the screen moves

Jammy Huang (1):
      drm/ast: Fix black screen after resume

Kenneth Feng (1):
      drm/amdgpu/pm: support gpu_metrics sysfs interface for smu v14.0.2/3

Maxime Ripard (2):
      Merge drm/drm-fixes into drm-misc-fixes
      Merge drm-misc/drm-misc-next-fixes into drm-misc-fixes

Michael Chen (1):
      drm/amdgpu: increase mes log buffer size for gfx12

Nikita Zhandarovich (1):
      drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Qiuxu Zhuo (1):
      drm/fb-helper: Don't schedule_work() to flush frame buffer during pan=
ic()

Suraj Kandpal (1):
      drm/i915/hdcp: Fix HDCP2_STREAM_STATUS macro

Thomas Zimmermann (1):
      drm/ast: astdp: Wake up during connector status detection

Tvrtko Ursulin (5):
      drm/v3d: Prevent out of bounds access in performance query extensions
      drm/v3d: Fix potential memory leak in the timestamp extension
      drm/v3d: Fix potential memory leak in the performance extension
      drm/v3d: Validate passed in drm syncobj handles in the timestamp exte=
nsion
      drm/v3d: Validate passed in drm syncobj handles in the
performance extension

Umesh Nerlige Ramappa (1):
      i915/perf: Remove code to update PWR_CLK_STATE for gen12

Zack Rusin (4):
      drm/vmwgfx: Fix a deadlock in dma buf fence polling
      drm/vmwgfx: Make sure the screen surface is ref counted
      drm/vmwgfx: Fix handling of dumb buffers
      drm/vmwgfx: Add basic support for external buffers

Zenghui Yu (1):
      kselftests: dmabuf-heaps: Ensure the driver name is null-terminated

 drivers/gpu/drm/Kconfig                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   8 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |   3 +
 drivers/gpu/drm/amd/include/mes_v12_api_def.h      |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  86 +++-
 drivers/gpu/drm/ast/ast_dp.c                       |   7 +
 drivers/gpu/drm/ast/ast_drv.c                      |   5 +
 drivers/gpu/drm/ast/ast_drv.h                      |   1 +
 drivers/gpu/drm/ast/ast_mode.c                     |  29 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |   5 +-
 drivers/gpu/drm/drm_client.c                       |   2 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  11 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   6 +-
 drivers/gpu/drm/i915/display/intel_hdcp_regs.h     |   2 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  33 --
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |  30 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   2 +-
 drivers/gpu/drm/nouveau/nouveau_prime.c            |   3 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   1 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |   4 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |  44 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   | 121 +++--
 drivers/gpu/drm/virtio/virtgpu_submit.c            |   2 +-
 drivers/gpu/drm/vmwgfx/vmw_surface_cache.h         |  10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 | 127 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  40 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |  62 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 502 +++++++++--------=
----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              |  32 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |  27 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  33 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               | 174 ++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            | 280 +++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |  40 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |   4 +-
 50 files changed, 1202 insertions(+), 650 deletions(-)

