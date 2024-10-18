Return-Path: <linux-kernel+bounces-371000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECD9A34CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A711F2501C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455EB188CC6;
	Fri, 18 Oct 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTcCdcOu"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391818F2DF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230814; cv=none; b=WCBNyk4TtYEbOSI8jc0nbdRmUIjTMq2kLf9qN1LXXgSkdmD0A+8qcZ7oS9aHcZzIlb9kpoG6RVkFlhPUiBmSVSqsYNL6ZNlbyzQ1Spvby3svq2NRca4Nf44kxdHonKAdKa12dPbSalXHY+fHycs6rVrXEaAfRg+KPyFQNTdfa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230814; c=relaxed/simple;
	bh=g08U9f8oSYil75nNL/+VFRCU493TDGJtAcpV/acVdJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uPne2KnArPHNH8gV6webBcFxjV4yAJZ9EgxRBocTFSF7vkEBa2vOTJXWY1Vf1M2Umc1gb9I/4dtC3BcmQLORcpvBOZx2hfxAeoFTVALvIj/KoqdDfQE0SHmSA0Gx+5CfMukiHXNOukIShSCV2Dqt+5qAXKEgPNHun/up/6OhR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTcCdcOu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb3110b964so17397671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230810; x=1729835610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nrAgdMnVLtva8aTGMf2zLIuQSqbfNbtWomKfHtJeeTw=;
        b=FTcCdcOuRuXvHhHiNfM02VKUFKlfl3ECEK+ZUcEd06tNyP7nRu0HwJYLgX5yaZKUBw
         IA0GGiQogaIIWFEXlB82tnQckqAwhZPcjynpsUoWTbNg9YNsOoM2kVY3a9A5WDjNPxqg
         GzEnBEfzRz51DrCygF/LmO+40M1ECYpQj/vuS1+jpv9JnpsOvlgVu7dnITDPc7bk4Fwt
         SUEiocL9aucmP8lpIPpElkhtD3t/66Vp2KS35GDqhxcg0k4CyHbT2QYTBxK2YqDV/mOS
         euDY3/memopRxowuCKnBGhBbtvSBoKDTZJicBxHslGJzpGEUpKKtBY1w/Xe7q6XiQyRE
         eKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230810; x=1729835610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrAgdMnVLtva8aTGMf2zLIuQSqbfNbtWomKfHtJeeTw=;
        b=uO0c0Z2db9qLL1lJtPH9crn+bRgsDGS16ConcxIVHQW2eDt3zdEAdzn+Id0FrEMUH+
         +kRtRExk5YBnqJ5frj9TnjtviNTZUv2601lKNKnY0xyLaYr3UZK6j6nQRT4ZdsgfDkKD
         hSSRnTQHRzl3H+2OkjoM16uSe5lV9ZLUcrjkNTPdbq8N02fZGlG0XWWIMICugLVeaz4T
         zDUc6EAPvnOhbivbSc8urwsMhtLncwSXqbA4msyvAh2J7I+RVu2u5G1G9cAy3HbKbtSB
         hnV0BWf8nHLAtzOTjFuk5GEAIvv0T2yPK0K3e+VIzPjseVTAfWKMoM5L22zT9rWcLR4/
         X+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW1UkMm01OT/AEzU68CF45uJ9EYa8RImqlMqYjO7PtaPlqFdBBh3laNKlDW/H+9WE4nulbFqBmOph9PEsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmqX+6yfitMHG7rWYjLZ52tFFx6eWPfq+NB3XzpOxBJqG2bD3
	nbLTRDUOyG7ypf0NAZtfi9xN3y/K/Y2foVWLVfo80wfRYcTjR0RkoMRICbZsd/6ujZfHGYJUijB
	g7u+mOwJniQGXDlgAurg5cXITj40=
X-Google-Smtp-Source: AGHT+IFdSQ1AzkRXtBXwnwktf3UTWm4uN2FRaxNkM7qHsXM/nFHckTfnrcypHqn9Oh08Lpgq+j2m3GgKee33v6viZZw=
X-Received: by 2002:a05:6512:304f:b0:53a:1a:cb58 with SMTP id
 2adb3069b0e04-53a154f9031mr559733e87.44.1729230809826; Thu, 17 Oct 2024
 22:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 18 Oct 2024 15:53:18 +1000
Message-ID: <CAPM=9ty_pQme=1c-KkA0yAR-X1PiUMqf8JiUnsCdGSOuM3fdpA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.12-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly fixes, msm and xe are the two main ones, with a bunch of
scattered fixes including a largish revert in mgag200, then amdgpu,
vmwgfx and scattering of other minor ones.

All seems pretty regular,

Regards,
Dave.

drm-fixes-2024-10-18:
drm fixes for 6.12-rc4

msm:
- Display:
- move CRTC resource assignment to atomic_check otherwise to make
  consecutive calls to atomic_check() consistent
- fix rounding / sign-extension issues with pclk calculation in
  case of DSC
- cleanups to drop incorrect null checks in dpu snapshots
- fix to use kvzalloc in dpu snapshot to avoid allocation issues
  in heavily loaded system cases
- Fix to not program merge_3d block if dual LM is not being used
- Fix to not flush merge_3d block if its not enabled otherwise
  this leads to false timeouts
- GPU:
- a7xx: add a fence wait before SMMU table update

xe:
- New workaround to Xe2 (Aradhya)
- Fix unbalanced rpm put (Matthew Auld)
- Remove fragile lock optimization (Matthew Brost)
- Fix job release, delegating it to the drm scheduler (Matthew Brost)
- Fix timestamp bit width for Xe2 (Lucas)
- Fix external BO's dma-resv usag (Matthew Brost)
- Fix returning success for timeout in wait_token (Nirmoy)
- Initialize fence to avoid it being detected as signaled (Matthew Auld)
- Improve cache flush for BMG (Matthew Auld)
- Don't allow hflip for tile4 framebuffer on Xe2 (Juha-Pekka)

amdgpu:
- SR-IOV fix
- CS chunk handling fix
- MES fixes
- SMU13 fixes

amdkfd:
- VRAM usage reporting fix

radeon:
- Fix possible_clones handling

i915:
- Two DP bandwidth related MST fixes

ast:
- Clear EDID on unplugged connectors

host1x:
- Fix boot on Tegra186
- Set DMA parameters

mgag200:
- Revert VBLANK support

panel:
- himax-hx83192: Adjust power and gamma

qaic:
- Sgtable loop fixes

vmwgfx:
- Limit display layout allocatino size
- Handle allocation errors in connector checks
- Clean up KMS code for 2d-only setup
- Report surface-check errors correctly
- Remove NULL test around kvfree()
The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354=
:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-18

for you to fetch changes up to 83f000784844cb9d4669ef1a3366479db3197b33:

  Merge tag 'drm-xe-fixes-2024-10-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-10-18 13:53:41 +1000)

----------------------------------------------------------------
drm fixes for 6.12-rc4

msm:
- Display:
- move CRTC resource assignment to atomic_check otherwise to make
  consecutive calls to atomic_check() consistent
- fix rounding / sign-extension issues with pclk calculation in
  case of DSC
- cleanups to drop incorrect null checks in dpu snapshots
- fix to use kvzalloc in dpu snapshot to avoid allocation issues
  in heavily loaded system cases
- Fix to not program merge_3d block if dual LM is not being used
- Fix to not flush merge_3d block if its not enabled otherwise
  this leads to false timeouts
- GPU:
- a7xx: add a fence wait before SMMU table update

xe:
- New workaround to Xe2 (Aradhya)
- Fix unbalanced rpm put (Matthew Auld)
- Remove fragile lock optimization (Matthew Brost)
- Fix job release, delegating it to the drm scheduler (Matthew Brost)
- Fix timestamp bit width for Xe2 (Lucas)
- Fix external BO's dma-resv usag (Matthew Brost)
- Fix returning success for timeout in wait_token (Nirmoy)
- Initialize fence to avoid it being detected as signaled (Matthew Auld)
- Improve cache flush for BMG (Matthew Auld)
- Don't allow hflip for tile4 framebuffer on Xe2 (Juha-Pekka)

amdgpu:
- SR-IOV fix
- CS chunk handling fix
- MES fixes
- SMU13 fixes

amdkfd:
- VRAM usage reporting fix

radeon:
- Fix possible_clones handling

i915:
- Two DP bandwidth related MST fixes

ast:
- Clear EDID on unplugged connectors

host1x:
- Fix boot on Tegra186
- Set DMA parameters

mgag200:
- Revert VBLANK support

panel:
- himax-hx83192: Adjust power and gamma

qaic:
- Sgtable loop fixes

vmwgfx:
- Limit display layout allocation size
- Handle allocation errors in connector checks
- Clean up KMS code for 2d-only setup
- Report surface-check errors correctly
- Remove NULL test around kvfree()

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: enable enforce_isolation sysfs node on VFs
      drm/amdgpu/smu13: always apply the powersave optimization
      drm/amdgpu/swsmu: Only force workload setup on init
      drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs

Aradhya Bhatia (1):
      drm/xe/xe2lpg: Extend Wa_15016589081 for xe2lpg

Cong Yang (1):
      drm/panel: himax-hx83102: Adjust power and gamma to optimize brightne=
ss

Dave Airlie (5):
      Merge tag 'drm-msm-fixes-2024-10-16' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-6.12-2024-10-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-10-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-10-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-10-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Dmitry Baryshkov (4):
      drm/msm/dpu: make sure phys resources are properly initialized
      drm/msm/dpu: move CRTC resource assignment to
dpu_encoder_virt_atomic_check
      drm/msm/dpu: check for overflow in _dpu_crtc_setup_lm_bounds()
      drm/msm/hdmi: drop pll_cmp_to_fdata from hdmi_phy_8998

Douglas Anderson (2):
      drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
      drm/msm: Allocate memory for disp snapshot with kvzalloc()

Ian Forbes (2):
      drm/vmwgfx: Limit display layout ioctl array size to
VMWGFX_NUM_DISPLAY_UNITS
      drm/vmwgfx: Handle possible ENOMEM in vmw_stdu_connector_atomic_check

Imre Deak (2):
      drm/i915/dp_mst: Handle error during DSC BW overhead/slice calculatio=
n
      drm/i915/dp_mst: Don't require DSC hblank quirk for a non-DSC
compatible mode

Jessica Zhang (2):
      drm/msm/dpu: Don't always set merge_3d pending flush
      drm/msm/dpu: don't always program merge_3d block

Jon Hunter (1):
      gpu: host1x: Fix boot regression for Tegra

Jonathan Marek (2):
      drm/msm/dsi: improve/fix dsc pclk calculation
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calcula=
tion

Juha-Pekka Heikkila (1):
      drm/i915/display: Don't allow tile4 framebuffer to do hflip on
display20 or greater

Lucas De Marchi (1):
      drm/xe/query: Increase timestamp width

Matthew Auld (4):
      drm/xe: fix unbalanced rpm put() with fence_fini()
      drm/xe: fix unbalanced rpm put() with declare_wedged()
      drm/xe/xe_sync: initialise ufence.signalled
      drm/xe/bmg: improve cache flushing behaviour

Matthew Brost (3):
      drm/xe: Take job list lock in xe_sched_add_pending_job
      drm/xe: Don't free job in TDR
      drm/xe: Use bookkeep slots for external BO's in exec IOCTL

Michael Chen (1):
      drm/amdgpu/mes: fix issue of writing to the same log buffer from
2 MES pipes

Mohammed Anees (1):
      drm/amdgpu: prevent BO_HANDLES error from being overwritten

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

Nirmoy Das (1):
      drm/xe/ufence: ufence can be signaled right after wait_woken

Philip Yang (1):
      drm/amdkfd: Accounting pdd vram_usage for svm

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix the for loop used to walk SG table

Rob Clark (1):
      drm/msm/a6xx+: Insert a fence wait before SMMU table update

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring

Thierry Reding (1):
      gpu: host1x: Set up device DMA parameters

Thomas Zimmermann (3):
      Revert "drm/mgag200: Add vblank support"
      drm/ast: sil164: Clear EDID if no display is connected
      drm/ast: vga: Clear EDID if no display is connected

Thorsten Blum (1):
      drm/vmwgfx: Remove unnecessary NULL checks before kvfree()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/radeon: Fix encoder->possible_clones

Zack Rusin (1):
      drm/vmwgfx: Cleanup kms setup without 3d

 drivers/accel/qaic/qaic_control.c                  |  2 +-
 drivers/accel/qaic/qaic_data.c                     |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            | 11 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               | 26 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 12 ++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 22 +++----
 drivers/gpu/drm/ast/ast_sil164.c                   |  2 +
 drivers/gpu/drm/ast/ast_vga.c                      |  2 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 40 ++++++++---
 drivers/gpu/drm/i915/display/intel_fb.c            | 13 ++++
 drivers/gpu/drm/i915/display/intel_fb.h            |  1 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 11 ++++
 drivers/gpu/drm/mgag200/mgag200_drv.c              | 38 -----------
 drivers/gpu/drm/mgag200/mgag200_drv.h              | 14 +---
 drivers/gpu/drm/mgag200/mgag200_g200.c             |  5 --
 drivers/gpu/drm/mgag200/mgag200_g200eh.c           |  5 --
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |  5 --
 drivers/gpu/drm/mgag200/mgag200_g200er.c           | 10 +--
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           | 10 +--
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |  5 --
 drivers/gpu/drm/mgag200/mgag200_g200se.c           | 10 +--
 drivers/gpu/drm/mgag200/mgag200_g200wb.c           |  5 --
 drivers/gpu/drm/mgag200/mgag200_mode.c             | 77 +-----------------=
----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 16 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           | 20 ++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 68 +++++++++++-------=
-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  7 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  5 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  | 19 +++---
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  4 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c           |  9 ---
 drivers/gpu/drm/panel/panel-himax-hx83102.c        | 12 ++--
 drivers/gpu/drm/radeon/radeon_encoders.c           |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |  6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 34 ++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  3 -
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  4 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  9 ++-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  3 -
 drivers/gpu/drm/xe/xe_device.c                     |  4 +-
 drivers/gpu/drm/xe/xe_exec.c                       | 12 ++--
 drivers/gpu/drm/xe/xe_gpu_scheduler.h              |  2 +
 drivers/gpu/drm/xe/xe_gt.c                         |  1 -
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        | 29 ++++----
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h        |  1 -
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  7 +-
 drivers/gpu/drm/xe/xe_query.c                      |  6 +-
 drivers/gpu/drm/xe/xe_sync.c                       |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  8 +--
 drivers/gpu/drm/xe/xe_wa.c                         |  4 ++
 drivers/gpu/drm/xe/xe_wait_user_fence.c            |  3 -
 drivers/gpu/host1x/context.c                       |  1 +
 drivers/gpu/host1x/dev.c                           | 18 +++--
 include/linux/host1x.h                             |  1 +
 61 files changed, 291 insertions(+), 388 deletions(-)

