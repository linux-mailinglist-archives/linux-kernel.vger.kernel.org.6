Return-Path: <linux-kernel+bounces-281526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969F94D7C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76BB1C229BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED715ECD2;
	Fri,  9 Aug 2024 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTSgxrie"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AF24B2F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233624; cv=none; b=MPkLAZKJ0hcdImMFUA0wfa02SExjHMcg7aAaHgIKLYBN+0AxyLuI3yhSNMBsVgFtc5aDe+rl9v+iNCCD6NbaDfhUZzl6MUlUOcS3ONfdqbhifyDI3LT8utWpU/GzLDgWR02wDHBM0fWxeB5SunbaNn2wzEwlYQDM7VZ6yvizvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233624; c=relaxed/simple;
	bh=Tpdy4cgdbsFT29gQug1bFyuPJ0g0lNrJa1Tx2WH9Wys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZkVaqtIeJ/OrFe6p/MmIKxjjcjWnTRdaaUprrUw8Q14NUAGuToYa8wOIWlIqT/CDzwE1jbG+IoSLDapEI1manxO6pcgJQV7t3pEflaEd1BKU9tBujl4FasP4C+J+LDtcyH5IYAWr0i+LQCs7U6lW5PeKjoALgx/R90jdqumkeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTSgxrie; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so2885681a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723233620; x=1723838420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/ZW3nV5tNcjPS6iptoriBrB0i5jeyrg1616ntHGkoU=;
        b=aTSgxrieXk2IcRB9UCnENYpaJ0BUK9pNmfRWCF3ARlIF5aZaZ5n8bZ9yASVykwqHhT
         6UNQI9qftkRWU/Cohoe39ix/6bVUs1vt6TLMHnz8HCrr112mV0cRmYXlL48vd7LbLtmv
         pGNYmvMmu/7OK/G4fdomzRw2PqFo64vZhU6FIQ376SJB6/plqMqNyhg06rHt35kvidpV
         M2Ve27r/hsuYZNRGtYYySyo5K4djpFsgiVyydRqlQA9/fCllOvvleW1xYjyVARjv1ItL
         IHAqf6vSl/LvGPmlGbNzheHUDYd721v+r4d1S4yaeP9Ckjzl0c8IZLXzC98ocFbI54vk
         buNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723233620; x=1723838420;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/ZW3nV5tNcjPS6iptoriBrB0i5jeyrg1616ntHGkoU=;
        b=ORwN9/W7Q+zwnWtmsJki7wpi9BIUyC9n5vn14BbS+WtjQfuAl5+sXfbklLVqX8bN1D
         EN7iIswpX08vGpX5uwED6ZkkB84fSdgk25OeJrH8e1pMij6ISUekaq3GyIjh+S97rdrL
         wAcjXVH25+ukbRUmENcDFyPbrAcTrep+k4iOPP5yVAiu7/OKLNRs4SPIK+BLudE8Ts8G
         TYmwOeLVneDeqMCMI/YleMgFASEtGlbEsyKzs1JqZfJPFlCvYpGiQ0iJC8eyZZGGLgTH
         ciNsWFXs8DKJ68Clh6zajd32I4X7YHj8XTxBbDjEh25jy2ESLLaN/335LfeQVmq10sOA
         7ARQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYgbiUJDGWT97/cL5GxDYRGzTGeEXkvjdpBSzEuDZTouQExAHbDM2NCxrGJxz1BIn064e2NBtpm767muA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ACXqMvRu9AgHuJ/lm3bLqp8X4N22vd0eBzn17MaYXPPJEgl9
	/rgRxJpJiKCa7Ioan9gTQ9yL407YSA8g55oV/o0LuEC984FKOjIBqoz7IHmOniuKuXrN+0pVxKs
	D3RpQxSO7EobyuXNjl3Sz0xrxNt0=
X-Google-Smtp-Source: AGHT+IER4wDD4pBbs3PQSGPA4ATqufxR+7PRC0XRU0hX1k+RT9NExlXC/+x7kc54KGWyv5Nh9Qjh9AVvd9sF6bJTD3U=
X-Received: by 2002:a17:907:7da3:b0:a7a:a0c9:124e with SMTP id
 a640c23a62f3a-a80aa53909emr188358066b.4.1723233620228; Fri, 09 Aug 2024
 13:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 10 Aug 2024 06:00:08 +1000
Message-ID: <CAPM=9txFVKQ-E5rPvgUJSo_ypt4uWW4dCyozsb_A5HD8Ldc5zQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly regular fixes, mostly amdgpu with i915/xe having a few each,
and then some misc bits across the board, seems about right for rc3
time.

Regards,
Dave.

drm-fixes-2024-08-10:
drm fixes for 6.11-rc3

client:
- fix null ptr deref

bridge:
- connector: fix double free

atomic:
- fix async flip update

panel:
- document panel

omap:
- add config dependency

tests:
- fix gem shmem test

drm buddy:
- Add start address to trim function

amdgpu:
- DMCUB fix
- Fix DET programming on some DCNs
- DCC fixes
- DCN 4.0.1 fixes
- SMU 14.0.x update
- MMHUB fix
- DCN 3.1.4 fix
- GC 12.0 fixes
- Fix soft recovery error propogation
- SDMA 7.0 fixes
- DSC fix

xe:
- Fix off-by-one when processing RTP rules
- Use dma_fence_chain_free in chain fence unused as a sync
- Fix PL1 disable flow in xe_hwmon_power_max_write
- Take ref to VM in delayed dump snapshot

i915:
- correct dual pps handling for MTL_PCH+ [display]
- Adjust vma offset for framebuffer mmap offset [gem]
- Fix Virtual Memory mapping boundaries calculation [gem]
- Allow evicting to use the requested placement
- Attempt to get pages without eviction first
The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-10

for you to fetch changes up to 06f5b920d1d0b686d794426264dc39aa8582db14:

  Merge tag 'drm-intel-fixes-2024-08-08' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
(2024-08-09 17:16:29 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc3

client:
- fix null ptr deref

bridge:
- connector: fix double free

atomic:
- fix async flip update

panel:
- document panel

omap:
- add config dependency

tests:
- fix gem shmem test

drm buddy:
- Add start address to trim function

amdgpu:
- DMCUB fix
- Fix DET programming on some DCNs
- DCC fixes
- DCN 4.0.1 fixes
- SMU 14.0.x update
- MMHUB fix
- DCN 3.1.4 fix
- GC 12.0 fixes
- Fix soft recovery error propogation
- SDMA 7.0 fixes
- DSC fix

xe:
- Fix off-by-one when processing RTP rules
- Use dma_fence_chain_free in chain fence unused as a sync
- Fix PL1 disable flow in xe_hwmon_power_max_write
- Take ref to VM in delayed dump snapshot

i915:
- correct dual pps handling for MTL_PCH+ [display]
- Adjust vma offset for framebuffer mmap offset [gem]
- Fix Virtual Memory mapping boundaries calculation [gem]
- Allow evicting to use the requested placement
- Attempt to get pages without eviction first

----------------------------------------------------------------
Andi Shyti (2):
      drm/i915/gem: Adjust vma offset for framebuffer mmap offset
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation

Arnd Bergmann (1):
      drm/omap: add CONFIG_MMU dependency

Arunpravin Paneer Selvam (3):
      drm/buddy: Add start address support to trim function
      drm/amdgpu: Add address alignment support to DCC buffers
      drm/amdgpu: Add DCC GFX12 flag to enable address alignment

Cristian Ciocaltea (1):
      drm/bridge-connector: Fix double free in error handling paths

Dave Airlie (5):
      drm/test: fix the gem shmem test to map the sg table.
      Merge tag 'drm-misc-fixes-2024-08-08' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.11-2024-08-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2024-08-08' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2024-08-08' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes

David Gow (2):
      drm/i915: Allow evicting to use the requested placement
      drm/i915: Attempt to get pages without eviction first

Dnyaneshwar Bhadane (1):
      drm/i915/display: correct dual pps handling for MTL_PCH+

Fangzhi Zuo (1):
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Frank Min (2):
      drm/amdgpu: change non-dcc buffer copy configuration
      drm/amdgpu: correct sdma7 max dw

Joshua Ashton (1):
      drm/amdgpu: Forward soft recovery errors to userspace

Karthik Poosa (1):
      drm/xe/hwmon: Fix PL1 disable flow in xe_hwmon_power_max_write

Kenneth Feng (1):
      drm/amd/pm: update powerplay structure on smu v14.0.2/3

Likun Gao (2):
      drm/amdgpu: force to use legacy inv in mmhub
      drm/amdgpu: add golden setting for gc v12

Lucas De Marchi (1):
      drm/xe/rtp: Fix off-by-one when processing rules

Ma Ke (1):
      drm/client: fix null pointer dereference in drm_client_modeset_probe

Matthew Brost (2):
      drm/xe: Use dma_fence_chain_free in chain fence unused as a sync
      drm/xe: Take ref to VM in delayed snapshot

Rob Clark (1):
      dt-bindings: display: panel: samsung,atna45dc02: Document ATNA45DC02

Rodrigo Siqueira (6):
      drm/amd/display: Replace dm_execute_dmub_cmd with
dc_wake_and_execute_dmub_cmd
      drm/amd/display: Add missing DET segments programming
      drm/amd/display: Add dcc propagation value
      drm/amd/display: Add missing mcache registers
      drm/amd/display: Add missing DCN314 to the DML Makefile
      drm/amd/display: Add missing program DET segment call to pipe init

Simon Ser (1):
      drm/atomic: allow no-op FB_ID updates for async flips

 .../bindings/display/panel/samsung,atna33xc20.yaml |  9 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       | 36 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             | 27 +++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             | 18 +++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  7 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  3 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |  3 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  2 +
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  2 +
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  2 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |  1 +
 .../display/dc/resource/dcn401/dcn401_resource.h   |  4 +-
 .../gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h | 52 +++++++++++++++++---
 drivers/gpu/drm/drm_atomic_uapi.c                  | 15 ++----
 drivers/gpu/drm/drm_bridge_connector.c             |  8 +---
 drivers/gpu/drm/drm_buddy.c                        | 25 +++++++++-
 drivers/gpu/drm/drm_client_modeset.c               |  5 ++
 drivers/gpu/drm/i915/display/intel_backlight.c     |  3 ++
 drivers/gpu/drm/i915/display/intel_pps.c           |  3 ++
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           | 55 +++++++++++++++++++---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            | 13 ++---
 drivers/gpu/drm/omapdrm/Kconfig                    |  1 +
 drivers/gpu/drm/tests/drm_gem_shmem_test.c         | 11 +++++
 drivers/gpu/drm/xe/xe_hwmon.c                      |  3 +-
 drivers/gpu/drm/xe/xe_lrc.c                        | 15 +++++-
 drivers/gpu/drm/xe/xe_rtp.c                        |  2 +-
 drivers/gpu/drm/xe/xe_sync.c                       |  2 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |  2 +-
 include/drm/drm_buddy.h                            |  2 +
 32 files changed, 287 insertions(+), 56 deletions(-)

