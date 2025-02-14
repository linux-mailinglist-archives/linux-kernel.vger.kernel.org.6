Return-Path: <linux-kernel+bounces-514304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B687A35556
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD801165F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3E1519AD;
	Fri, 14 Feb 2025 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUpYRjMp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBF8837
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504059; cv=none; b=mE3jsa/joSkTbc/Evw5hc4uaqBmc6DxM3NEDPDu7sTaZ8ZCSddGfTOLU3de6pmXMknPcHT2zzUAjziFplRmVgoUc01dJmsCzmsirHoExis5FxOUaktwyVEoyP38znhH971v4HbafvK2+fcZ4KxjL8TrDHAmuNxkMVQdtDF/pwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504059; c=relaxed/simple;
	bh=zdZ1K83C+vUZuZDlAjW1b/O7SvJ3I6NBaCd43TdWb5M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=prvGMFdBHy8ySn48FTcRxkQuJQ3q+xumKQcrqbUdxnp7iRpU8E15soX7s757Bl1v6/VZ8tcmKNW6ao28ZmenViQy2gPrqxxa6e14b6QOnNi59sRHtsyYfJ4Egm5nDSoHLppG8deq2QklZ1x2Z3oOsDQAUpQ77REdComnLcVhRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUpYRjMp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so205170666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739504056; x=1740108856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ef52lVD5tbaEZhkFJicIhClRxVWfvA0fP+kz/Eg8/ZY=;
        b=WUpYRjMpBzqL2xjTHBiMr7DNjUBwEA8f1rt1nqdFfgyYJY5VDbhhgAZTChtT6h/BwZ
         Aivq104VP7psZ0G6rWixVSw2U0xrWGS94e+dylMpRcyCrrJ4OADu+mFSR8f/05MG7QYR
         UvD2fE5TMwP2EJPdCnsEqEWrww2Owq5zANnr/oOIdM+9rVb4eldb/8Rz5yxmcVGe9kth
         RQ0R5nryqM1AqWq9H6ekQuO494qi+fYbh9tX1MlIi2HxMsr4iOPC6ObARwPURKHtmK12
         ejcU8iPmUMpQpIvxiEQgaE/l2UBkR2X7NXOO6XYpx2hL1Md4CwXzRieliJjgQ2wwzz9W
         cegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739504056; x=1740108856;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ef52lVD5tbaEZhkFJicIhClRxVWfvA0fP+kz/Eg8/ZY=;
        b=MrKQKy4IY2CNdHbAOfw3ilKXJZ+3lWrDv1wKqWyoKwXzNCWDKD9sygvzp348QPo5yp
         rl1/InupyYcXDjg44JhrvUL4deXtjGhWPiGkjn0yDXwOT9HGLKDIILkL0a8IrUV165sr
         rwCxbkKlNlhKE2vM/DMlSJImhs2Xhw50iJiEMuXjAFjEkg54PDfI78+N7/RyWsjYYTjl
         Q5SlxCSSxM1AXBKGJBM/8KlnHXNrtzk1FzOQbUNn29TdOnL3Pdmq8buwlUr9XmVhChf9
         Hi+5AQ7gtgGL6K+jFAGZOCfrztwVp69JoAqHA10AqcBMvafbPvVbAUTz0ixybOlxxo3V
         mA6w==
X-Forwarded-Encrypted: i=1; AJvYcCVdJG1QJMyMbuctbxOTK0wKKyK7I2qJP+R4EEavPzYaQ/nKuKpmIVq30oUcXSkn/y+ttiLxFuxbHxEtPrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPAJS3Sjd/T1klCvVQKla1NiYLzqK25BMgn1gogscPf8pgsWf
	Nt18LBcydjuBDfYLIlwTOgjBZGITelg0FRRLl6vR3My4TkaNW+ZDKT+BMO0RQr2Tdsky0DmrdVv
	qK5i/fgHogIr/rM60S5NRxnlqUrGfeVop
X-Gm-Gg: ASbGncvFBaUo/PPh6t9hOo551nY2E7ZlwNNdNkWmqH0H86OGXWPpOaSaasYBBEub8+y
	DATbtPMqcbQtJ8P6XH7oSie1IrnGz5bJIDPiLR1ZcNNo9EckaIf9k+k7As+UU0CVfbqJTZ5o=
X-Google-Smtp-Source: AGHT+IFlURw+eXoPbSOgy1n/F/niJ/VuJ7bAChakLddym2av0Es1RzARThj+8CTS1YydSLt34l2lerM4R2qZjwFFKdQ=
X-Received: by 2002:a17:907:1909:b0:ab7:8e0d:3d3c with SMTP id
 a640c23a62f3a-ab7f3473720mr1011985966b.42.1739504055920; Thu, 13 Feb 2025
 19:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 14 Feb 2025 13:34:04 +1000
X-Gm-Features: AWEUYZl_qKYZfWnQCqMRQwD-8nIedPayc98_RI7-SUbGemV0yuUiFb-cZEKyM2Y
Message-ID: <CAPM=9txeA4G80xej2orc-_y1=cEBaxY2Hw-48v0sw485UjuWyQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.14-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly drm fixes pull request, nothing too unusual, the hdmi tests
needs a bit of refactoring after lockdep shouted at them, otherwise
amdgpu and xe lead and a few misc otherwise.

Thanks,
Dave.

drm-fixes-2025-02-14:
drm fixes for 6.14-rc3

amdgpu:
- Fix shutdown regression on old APUs
- Fix compute queue hang on gfx9 APUs
- Fix possible invalid access in PSP failure path
- Avoid possible buffer overflow in pptable override

amdkfd:
- Properly free gang bo in failure path
- GFX12 trap handler fix

i915:
- selftest fix: avoid using uninitialized context

xe:
- Remove bo->clients out of bos_lock area
- Carve out wopcm portion from the stolen memory

tests:
- fix lockdep with hdmi infrastructure tests

host1x:
- fix uninitialised mutex usage

panthor:
- fix uninit variable

hibmc:
- fix missing Kconfig select
The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-14

for you to fetch changes up to 04485cc34868892a823b909c6d5468ba21b63569:

  Merge tag 'drm-xe-fixes-2025-02-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-02-14 12:15:59 +1000)

----------------------------------------------------------------
drm fixes for 6.14-rc3

amdgpu:
- Fix shutdown regression on old APUs
- Fix compute queue hang on gfx9 APUs
- Fix possible invalid access in PSP failure path
- Avoid possible buffer overflow in pptable override

amdkfd:
- Properly free gang bo in failure path
- GFX12 trap handler fix

i915:
- selftest fix: avoid using uninitialized context

xe:
- Remove bo->clients out of bos_lock area
- Carve out wopcm portion from the stolen memory

tests:
- fix lockdep with hdmi infrastructure tests

host1x:
- fix uninitialised mutex usage

panthor:
- fix uninit variable

hibmc:
- fix missing Kconfig select

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/pm: fix UVD handing in amdgpu_dpm_set_powergating_by_smu()
      drm/amdgpu/gfx9: manually control gfxoff for CS on RV
      drm/amdgpu: bump version for RV/PCO compute fix

Arnd Bergmann (1):
      drm/hisilicon/hibmc: select CONFIG_DRM_DISPLAY_DP_HELPER

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2025-02-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.14-2025-02-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2025-02-13' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-02-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Imre Deak (1):
      drm: Fix DSC BPP increment decoding

Jiang Liu (2):
      drm/amdgpu: bail out when failed to load fw in psp_init_cap_microcode()
      drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Krzysztof Karas (1):
      drm/i915/selftests: avoid using uninitialized context

Lancelot SIX (1):
      drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handler

Maxime Ripard (4):
      drm/tests: hdmi: Fix WW_MUTEX_SLOWPATH failures
      drm/tests: hdmi: Remove redundant assignments
      drm/tests: hdmi: Reorder DRM entities variables assignment
      drm/tests: hdmi: Fix recursive locking

Nirmoy Das (1):
      drm/xe: Carve out wopcm portion from the stolen memory

Rupinderjit Singh (1):
      gpu: host1x: Fix a use of uninitialized mutex

Su Hui (1):
      drm/panthor: avoid garbage value in panthor_ioctl_dev_query()

Tejas Upadhyay (1):
      drm/xe/client: bo->client does not need bos_lock

Zhu Lingshan (1):
      amdkfd: properly free gang_ctx_bo when failed to init user queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  36 +++-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |   3 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |   4 +
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   3 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig            |   2 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   4 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |   1 +
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 200 +++++++++++----------
 drivers/gpu/drm/xe/xe_drm_client.c                 |   2 +-
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c             |  70 ++++----
 drivers/gpu/host1x/dev.c                           |   2 +
 drivers/gpu/host1x/intr.c                          |   2 -
 include/drm/display/drm_dp.h                       |   1 +
 18 files changed, 200 insertions(+), 144 deletions(-)

