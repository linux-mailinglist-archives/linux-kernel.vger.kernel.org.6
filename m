Return-Path: <linux-kernel+bounces-307933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684E96551B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185D3281895
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF08535DC;
	Fri, 30 Aug 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a76pPK7B"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD548814
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983736; cv=none; b=d1IjE7C1Fz+tdyqR6hzbmMxAxkVZEQgCCCY3rQBScUsBvNQ92PHAnjazdqyHjlOySOWkgTFm6vYnZKWcvkGzQcu2oW+uoeoC1xOp62iNqXEuKyoWhJKqZPbk4I5TfSgk9G2rhl/Iq2/K6MWovg7ZctDDOZhErFV+Xkr7C4MYdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983736; c=relaxed/simple;
	bh=vLOo20fm1bNZFa/3W03AfeqJwF2chkfS4J3VTIzsh6o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ahjMecsk+SawKuuDbCqIiRUbpJfw8qDn0HRNTT4NIGuDr2q/YuT/rcmT7Jpc7bimHNFQO2RkBipHEc8bDoHeSNDL1IWb//hhR6wgC5w8wKz73TdKvddzFdNUePYSt7PbXS2PvmaHmQK7Opw8CkfRAI71V/7M5cccrXNWYP5Oxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a76pPK7B; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86910caf9cso424579366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983733; x=1725588533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qg6WNfL/F6Y1y6D4ESySiWKDVVUAg0SLjU+a+wT4JMA=;
        b=a76pPK7B0C7UWyvGCUQhP03O7TnO+It+avm5mIUxgREpJkjWerqqGWQNlE8lSi6mOk
         y3Kzv4eruIUrHfP7ZVitgjjYVVxPTWb4zM2js2TcJxqewZa+I4m7GqxyxxNfFFZffNps
         J+yl29TQOxZ/5oL70huThmQTRSuwmuKrjq2Jhy99vrl0sGQLcTtpeVsbC71IPNzBr3sb
         Sxkry/zFKtGQgDzsoFqMcOWeY/3eAfKzLqmMgXJv4vm9gqHZqqs97o5tbLz3JeJBPi3W
         p9V655UVAg48qdPI1owEIa6sRrHj9qz3keMPFnJBVhPhBLLa/HKlOZCvkKjpN4kNB/cD
         2fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983733; x=1725588533;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qg6WNfL/F6Y1y6D4ESySiWKDVVUAg0SLjU+a+wT4JMA=;
        b=pSnSEFj9jmFX4IPlHazAnmJuIpU/3JB4olgIKRU36ZPGBjEegrbqW4BSv/bI6NolIN
         1MtubT1NUFjMnYdjggqvLqh9/6S1G7zYJUpJZOUU4aPuzYs5iCf5UKU+GQeEVTl3Q4Cv
         XfZMK4Is1T1nLiDQiOBzXua5AuSlBSU/QENompVwK+nexH0GepMACkgjqywrHXz02ZbZ
         nweKffAM1clDxNYzNaBBI746l/lMMNq2otkPBgOlRMQ7iTV7xUdIybC8sk8U1hVZkkcU
         YeFmB4WozRtfH/cJ+gdLoPIa4seJuTIV2q/CbgjKOm/qXVjBAoui7ZZFrU8/9W777kBl
         17Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXkV3ztUG54gwje/Gzl2ob3T+qqH8uUr1T2jAc0JEZ8drFZ+wOx1sUQJ1oW3N3fpSMm8fN9DsuCq4mmklg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhdl6226wOZjrYY7xty1DXOb+7tqzzdlDaBfnlJM0fa6ywtsVX
	b3pdHszmdaIcuaPlJLvco20fgjf4ug0V9AI1J++zzO6ST4wSNY05vpZ9oXbRGBd0GXGKJ7zkULl
	0LaYRfwUriQaW0XGUA4+odg0mf2ndaI3o
X-Google-Smtp-Source: AGHT+IHgBRLmBAT4IJRklNDrgpfErJbap5rAuJNsLi3oUTrZX4dHmrrQJ1gAnoqaDuwxckRhNyZezmoRL/ajgVTzvm0=
X-Received: by 2002:a17:907:980c:b0:a83:849e:ea80 with SMTP id
 a640c23a62f3a-a898284a66emr452964966b.32.1724983732769; Thu, 29 Aug 2024
 19:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 30 Aug 2024 12:08:41 +1000
Message-ID: <CAPM=9tzX71UKndfu8JECMOzc9kf4s4pp9cWTMWwE476cQXt_Yw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hey Linus,

Another week, another set of GPU fixes. amdgpu and vmwgfx leading the
charge, then i915 and xe changes along with v3d and some other bits.
The TTM revert is due to some stuttering graphical apps probably due
to longer stalls while prefaulting.

Seems pretty much where I'd expect things,

Dave.

drm-fixes-2024-08-30:
drm fixes for 6.11-rc6

ttm:
- revert prefault change, caused stutters

aperture:
- handle non-VGA devices bettter

amdgpu:
- SWSMU gaming stability fix
- SMU 13.0.7 fix
- SWSMU documentation alignment fix
- SMU 14.0.x fixes
- GC 12.x fix
- Display fix
- IP discovery fix
- SMU 13.0.6 fix

i915:
- Fix #11195: The external display connect via USB type-C dock stays
blank after re-connect the dock
- Make DSI backlight work for 2G version of Lenovo Yoga Tab 3 X90F
- Move ARL GuC firmware to correct version

xe:
- Invalidate media_gt TLBs
- Fix HWMON i1 power setup write command

vmwgfx:
- prevent unmapping active read buffers
- fix prime with external buffers
- disable coherent dumb buffers without 3d

v3d:
- disable preemption while updating GPU stats
The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-30

for you to fetch changes up to 27f5b729cb56e46d8beca47c227c0edf1e958fbb:

  Merge tag 'drm-misc-fixes-2024-08-29' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2024-08-30 11:28:11 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc6

ttm:
- revert prefault change, caused stutters

aperture:
- handle non-VGA devices bettter

amdgpu:
- SWSMU gaming stability fix
- SMU 13.0.7 fix
- SWSMU documentation alignment fix
- SMU 14.0.x fixes
- GC 12.x fix
- Display fix
- IP discovery fix
- SMU 13.0.6 fix

i915:
- Fix #11195: The external display connect via USB type-C dock stays
blank after re-connect the dock
- Make DSI backlight work for 2G version of Lenovo Yoga Tab 3 X90F
- Move ARL GuC firmware to correct version

xe:
- Invalidate media_gt TLBs
- Fix HWMON i1 power setup write command

vmwgfx:
- prevent unmapping active read buffers
- fix prime with external buffers
- disable coherent dumb buffers without 3d

v3d:
- disable preemption while updating GPU stats

----------------------------------------------------------------
Alex Deucher (6):
      Revert "drm/ttm: increase ttm pre-fault value to PMD size"
      video/aperture: optionally match the device in sysfb_disable()
      drm/amdgpu: align pp_power_profile_mode with kernel docs
      drm/amdgpu/smu13.0.7: print index for profiles
      drm/amdgpu/swsmu: always force a state reprogram on init
      drm/amdgpu/gfx12: set UNORD_DISPATCH in compute MQDs

Candice Li (1):
      drm/amd/pm: Drop unsupported features on smu v14_0_2

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.11-2024-08-28' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-08-29' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-08-29' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-08-29' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Hans de Goede (1):
      drm/i915/dsi: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Imre Deak (1):
      drm/i915/dp_mst: Fix MST state after a sink reset

John Harrison (1):
      drm/i915: ARL requires a newer GSC firmware

Karthik Poosa (1):
      drm/xe/hwmon: Fix WRITE_I1 param from u32 to u16

Kenneth Feng (1):
      drm/amd/pm: update message interface for smu v14.0.2/3

Lijo Lazar (1):
      drm/amd/pm: Add support for new P2S table revision

Likun Gao (1):
      drm/amdgpu: support for gc_info table v1.3

Ma Ke (1):
      drm/amd/display: avoid using null object of framebuffer

Matthew Brost (1):
      drm/xe: Invalidate media_gt TLBs

Tvrtko Ursulin (1):
      drm/v3d: Disable preemption while updating GPU stats

Zack Rusin (3):
      drm/vmwgfx: Prevent unmapping active read buffers
      drm/vmwgfx: Fix prime with external buffers
      drm/vmwgfx: Disable coherent dumb buffers without 3d

 drivers/firmware/sysfb.c                           |  19 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   6 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   9 +-
 drivers/gpu/drm/amd/include/discovery.h            |  42 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  21 ++--
 .../amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h   |  18 +++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   7 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  48 ---------
 drivers/gpu/drm/i915/display/intel_dp.c            |  12 +++
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  40 ++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.h        |   1 +
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   1 -
 drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c          |  31 ++++++
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |  10 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   2 +
 drivers/gpu/drm/i915/intel_device_info.c           |   7 ++
 drivers/gpu/drm/i915/intel_device_info.h           |   3 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |   6 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               | 114 ++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |  13 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  12 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   6 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      |   2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  37 ++++---
 drivers/of/platform.c                              |   2 +-
 drivers/video/aperture.c                           |  11 +-
 include/drm/intel/i915_pciids.h                    |  11 +-
 include/drm/ttm/ttm_bo.h                           |   4 -
 include/linux/sysfb.h                              |   4 +-
 35 files changed, 398 insertions(+), 126 deletions(-)

