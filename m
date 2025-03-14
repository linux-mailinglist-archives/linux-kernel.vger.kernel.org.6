Return-Path: <linux-kernel+bounces-560798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE208A6099B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B38D8808CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35F1C862D;
	Fri, 14 Mar 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keUZC/a6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528E1C7014
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936291; cv=none; b=QMC6m5Vzm7ch1lVJTXXBu/KtUpmXtQKOrHwnbjvCBmi5DOaE7IYAHli7MnEqyRjIfvk0TDxpdvCGnYv/8cL1QgVH3inN0Snpq7Ema9fQeOZv6j+h67zBj/8HelJ8Q/0CyxKtK5BT1GBqKuWNGwunZjKyg826Q7ebZvfl6GCELOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936291; c=relaxed/simple;
	bh=our2k2a5BscNyCmTNxIK+vKJJVKwet/jhJRgx2A6KVM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qXxL0Xgy/zoJT0sNRjIYFZqKu9Ls6B7M9EPMeatZiXn8+dM3nhAvVkfNWLWgwHY/kcswum8ikFsI7n1QXTGTEG/wieYXJ/uIbG4otQ+8IVc9b2qjLQcMNZkf+temakAN8dG2wmEja7BzVkAPYNYCOV8JVKWNShFOFpSRaUHx+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keUZC/a6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bfcd2a66so305114766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741936287; x=1742541087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcxWgeBT29Hzcr2wTHpxcmqt2hkmYJcn5TysUSsXiZk=;
        b=keUZC/a602iSEfoiAiFNa05cFxbvkPpTqOVAwc1A6dKeTh+Sv6H42iZZoTc2tmGhE3
         URmgHLPAMB/IzWvTvoaZ4GMZIKu9qNlrjVTxWAfLu8A9QkZiOztUu/rESEVtXCyukuWp
         3ptMB1BmMjoEbAAsh23wql9+wnww/bjx2VtWTle9z8Os2FyekTlvXBK8tuLyruewByrW
         oKca8q1XPx5iRad80j1uItbnuMxxErH9l6qpa3R50Xm09KaQDb6Ed0002CabyDhu3BTT
         CCHOx+WUADLAsV0SsbZAfgT7+/YLGhVbCj5AepzxDiONeHDFQ4O4H/+w0SV4AUrgkpg2
         QFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741936287; x=1742541087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcxWgeBT29Hzcr2wTHpxcmqt2hkmYJcn5TysUSsXiZk=;
        b=i3jZVuyLglMhrPmn39/P1tbA4muduyG+q27wHy/pUMXndx9zKdplh4wCNHYICWSOMz
         VOsVs/uHOm7vV0d9R3+HZRLMJexACyn1OCVUE5hjOJVTTfXEwIhpmJBtX08DLNiyz5TL
         QUDyIL/65seD3Cg49aT/UXd0EIzdtjBfUWsPheR4Z1e95O04WbFmzPUdUIz2w71Hw5yk
         xGltywp3tCrlocSrKHw15K/z05OXCzh2V4fI0Sew4V8LZeZvFjSzouco/92JC4A7jxe+
         Lw2RAZSN4gMuSDu9l8LJPz/anCioLIghSYk2nFr246Q8C9J2wGWt34oxZ5Z1IWPeqHdh
         LKgA==
X-Forwarded-Encrypted: i=1; AJvYcCV7qPmrJ3vPElUvMr9T17UE3a09EsQNaGG197i8UiCn2Brbu/8P5uRinulg0jVsIkVef5radiMR2ed8Xm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PMyOrwSRPRGq1EnTF2KUlGgeujfawoc25axTuIFKgsGCeKMf
	Xo8ChjZskpg18St3SVsGDmK+cQ86+NNwZxL6uje9EOM2sW9bzCmH5mbArmHoMRhBaIJUUSM62O5
	bMYQVf90IGJim0JcN54EQQFYPymc=
X-Gm-Gg: ASbGncs3EDy4WMbdVxGLwzMotk+vataY9n085Jxs7aYhxebM76Qw7zIIytaWnG3qNwn
	PXI8WxAdGwIP4V9HScRuSMC9JwMoghDH1kLIpYsjoqMmORUojUCtAmUxWdA4z+xUZSty/MGhkjF
	HgWy1QjS53L7trd4v0PgfmHtI3
X-Google-Smtp-Source: AGHT+IG3lY5hWLZzc16ljHigKpjOmO3jNH0WK5YKf2sclutnlRHi1cZqp5Fgy5zy7sMtopTMFUOUZNG2+8Y+cdYmPkA=
X-Received: by 2002:a17:907:7241:b0:ac1:e332:b1f5 with SMTP id
 a640c23a62f3a-ac330371508mr151302166b.37.1741936287039; Fri, 14 Mar 2025
 00:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 14 Mar 2025 17:11:16 +1000
X-Gm-Features: AQ5f1JpfP3TmFF1lLfHcd-9pOehlmSFSUNN5ec8WIpMFS18OAW1wdWLVoWLg888
Message-ID: <CAPM=9tynNkAv1s70kbsCVHj31sGTXL1AQ0Dv6n0kwr7kw1rhkA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.14-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Regular weekly fixes pull, the usual leaders in amdgpu/xe, a couple of
i915, and some scattered misc fixes.

Next week the gitlab.freedesktop.org infrastructure will be down for
migration, so I've no idea whether I will have any fixes for final, I
can send an MR via github if needed, but I'm not sure if the
downstreams will have anything to get to me, but if anything urgents
pops up we will make sure it gets there.

Dave.

drm-fixes-2025-03-14:
drm fixes for 6.14-rc7

panic:
- two clippy fixes

dp_mst
- locking fix

atomic:
- fix redundant DPMS calls

i915:
- Do cdclk post plane programming later
- Bump MMAP_GTT_VERSION: missing indication of partial mmaps support

xe:
- Release guc ids before cancelling work
- Fix new warnings around userptr
- Temporaritly disable D3Cold on BMG
- Retry and wait longer for GuC PC to start
- Remove redundant check in xe_vm_create_ioctl

amdgpu:
- GC 12.x DCC fix
- DC DCE 6.x fix
- Hibernation fix
- HPD fix
- Backlight fixes
- Color depth fix
- UAF fix in hdcp_work
- VCE 2.x fix
- GC 12.x PTE fix

amdkfd:
- Queue eviction fix

gma500:
- fix NULL pointer check
The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a=
:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-14

for you to fetch changes up to d1d77326f585ccf1fb388e1bcc18a630e044577f:

  Merge tag 'drm-xe-fixes-2025-03-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-03-14 13:42:17 +1000)

----------------------------------------------------------------
drm fixes for 6.14-rc7

panic:
- two clippy fixes

dp_mst
- locking fix

atomic:
- fix redundant DPMS calls

i915:
- Do cdclk post plane programming later
- Bump MMAP_GTT_VERSION: missing indication of partial mmaps support

xe:
- Release guc ids before cancelling work
- Fix new warnings around userptr
- Temporaritly disable D3Cold on BMG
- Retry and wait longer for GuC PC to start
- Remove redundant check in xe_vm_create_ioctl

amdgpu:
- GC 12.x DCC fix
- DC DCE 6.x fix
- Hibernation fix
- HPD fix
- Backlight fixes
- Color depth fix
- UAF fix in hdcp_work
- VCE 2.x fix
- GC 12.x PTE fix

amdkfd:
- Queue eviction fix

gma500:
- fix NULL pointer check

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/vce2: fix ip block reference

Alex Hung (1):
      drm/amd/display: Assign normalized_pix_clk when color depth =3D 14

Aliaksei Urbanski (1):
      drm/amd/display: fix missing .is_two_pixels_per_container

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.14-2025-03-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2025-03-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-03-13' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-03-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David Rosca (1):
      drm/amdgpu/display: Allow DCC for video formats on GFX12

Imre Deak (1):
      drm/dp_mst: Fix locking when skipping CSN before topology probing

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Increase I915_PARAM_MMAP_GTT_VERSION version to
indicate support for partial mmaps

Leo Li (1):
      drm/amd/display: Disable unneeded hpd interrupts during dm_init

Mario Limonciello (4):
      drm/amd: Keep display off while going into S4
      drm/amd/display: fix default brightness
      drm/amd/display: Restore correct backlight brightness after a GPU res=
et
      drm/amd/display: Fix slab-use-after-free on hdcp_work

Miguel Ojeda (2):
      drm/panic: use `div_ceil` to clean Clippy warning
      drm/panic: fix overindented list items in documentation

Natalie Vock (1):
      drm/amdgpu: NULL-check BO's backing store when determining GFX12 PTE =
flags

Rodrigo Vivi (2):
      drm/xe/pm: Temporarily disable D3Cold on BMG
      drm/xe/guc_pc: Retry and wait longer for GuC PC start

Tejas Upadhyay (1):
      drm/xe: Release guc ids before cancelling work

Thomas Hellstr=C3=B6m (1):
      drm/xe/userptr: Fix an incorrect assert

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/cdclk: Do cdclk post plane programming later
      drm/atomic: Filter out redundant DPMS calls

Xin Wang (1):
      drm/xe: remove redundant check in xe_vm_create_ioctl()

Yifan Zha (1):
      drm/amd/amdkfd: Evict all queues even HWS remove queue failed

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 11 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |  5 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  8 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 17 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 64 +++++++++++++++---=
----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  7 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  7 ++-
 .../amd/display/dc/dce60/dce60_timing_generator.c  |  1 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      | 40 ++++++++------
 drivers/gpu/drm/drm_atomic_uapi.c                  |  4 ++
 drivers/gpu/drm/drm_connector.c                    |  4 ++
 drivers/gpu/drm/drm_panic_qr.rs                    | 16 +++---
 drivers/gpu/drm/gma500/mid_bios.c                  |  5 ++
 drivers/gpu/drm/i915/display/intel_display.c       |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  5 +-
 drivers/gpu/drm/xe/xe_guc_pc.c                     | 53 +++++++++++++-----
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  2 +-
 drivers/gpu/drm/xe/xe_hmm.c                        |  6 +-
 drivers/gpu/drm/xe/xe_pm.c                         | 13 ++++-
 drivers/gpu/drm/xe/xe_vm.c                         |  3 -
 22 files changed, 200 insertions(+), 79 deletions(-)

