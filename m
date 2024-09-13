Return-Path: <linux-kernel+bounces-327660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785119778F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3942A287FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07254187563;
	Fri, 13 Sep 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB3/JJma"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75C323D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210005; cv=none; b=POsA28X0Gf1BioXLk5RrLH2Ed+ju5muLvBl0QAdeMp9HXUwmHD2UerxBBaVnZ5+Xgqve0rl/INq+sYuG0ci+o9f9RJ6YwbZYI5eKhBKeqid3ABlrsUWy+t0ZoKI+NGSJzafVBtFQd2agTXh4gNBQI5urYGYlRznCNPUsOWn0rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210005; c=relaxed/simple;
	bh=Vjh9ODiP5CKx66B5gIAuui1eAbZJebK33g5lRUHAhZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UmEN8z0wV3Lu+bUzH08/+xRtQE9dg/je4/ZFuLnPco4orJWNG1cS7Q5EeOr8BQOP4skR4SSoaJMyKRwAswIFpbajlBvWiNT0jY+PyG7jndfwJoC9jVVbDSudZjyYkbIBXSl8MIVMSNP21DIRj+6KLz7eU4Zpn27uILvAROp4DvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB3/JJma; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d43657255so68355866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726210002; x=1726814802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=smMa8B5bRHDRz1/lPizULbe3C4Z8KUeTa44Yd/ZIa8I=;
        b=iB3/JJmaX+myFI7eoOvDgNDZB/6oKfj8QFnFqC1PbTJNx2UIBr5E3yZUmJk7BY6wc2
         ASMjA63+56/a5rs2BDiyvTEf6Omt61syAk0ZIpl22eoasGLKj3k/kKZ/RQUH+Ar4wYFk
         De0isdhhATRL3Hu5xdkLolr46LpjBkTcmqvxA8oDx8mNSU5YRtOUYRRsA3Y7tkf1392r
         BvUNUA4TtIHtECYmq74xSR1crZbw2zF66d4xNvXBdFgizeu/zATNGQMX9uwJKLD6yeqW
         SqL8sBqpO2InCPz0JS0/2V0O35pttWkJkxRi/jmdk7D5UKIZXYnMeFokYpkHLtjdQ9LH
         gwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210002; x=1726814802;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smMa8B5bRHDRz1/lPizULbe3C4Z8KUeTa44Yd/ZIa8I=;
        b=NwTGF2oG3EfXPF7gSOuB8/HFsf83eIcGC4lqH1jZ+PZ/am6YrW/iRbGrLJmaFDCZF/
         IzbT1gZYWxcRKFuhYvB/ulIDOuQeNv2ZobF5gsN0QEzCQac9IoZv1FNkj/rCKoDiTTPV
         WkSqEoF1JzbmIpsi/WoZUDRlJbHKi3SKW9rE6gazpF0qR5YQh2e4qRH13AEwwPHyicG8
         DsD4JI4k1/tOGCFGAZUCb4fBE1pqQ9z6aM6yoKmTykftcVzeWw/qF770UcrbzD3RA3a8
         1Q57NDA3FDBqC5iCwipAbeZK7jwWjGwzzgihJb8D8vSpzsrVgirZmVmoWIp87lUxf8U1
         rsNg==
X-Forwarded-Encrypted: i=1; AJvYcCWGk+eyybrPm80mIkw5g6YDdysrnGumhxirnaPuFKTXVWq/a3gZ2xASIkclUMFow5KCTxbKRwFv/G5bvSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eZD4I3jcH+hvsmKmpf/IBOgOx+Wyvot3aRCEY2jICMcvD7re
	quN0wXwoNxskgDm0ZKT4T8zXGtVmtIA+YOD9x+RvmV5QEGWWtMiKnP4U+Nrq1rLvH5bsyqcS78I
	N6daVH4GayyZ6JDlRWAIVFKdZB6M=
X-Google-Smtp-Source: AGHT+IGFIE0/ZOcDEPolMk8IJA9VxyAyQezzhh2vLOuPFzpZ1w7BptM9JEBsFT44Ziy9ZBA1a7hV6xiokysK/EVCuaA=
X-Received: by 2002:a17:907:86a3:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a9047ca87aemr109485866b.20.1726210001470; Thu, 12 Sep 2024
 23:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 13 Sep 2024 16:46:14 +1000
Message-ID: <CAPM=9tyi5A8t9bfCC3gtbG18Ai9cPS0bLrFVL_eJ1N1UyT4uBg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Regular fixes pull, the amdgpu JPEG engine fixes are probably the
biggest, they look to block some register accessing, otherwise there
are just minor fixes and regression fixes all over. nouveau had a
regression report going back a few kernels that finally got fixed, Not
entirely happy with so many changes so late, but they all seem quite
benign apart from the jpeg one.

I should be fine for the merge window next week, see you in Vienna.

Dave.

drm-fixes-2024-09-13:
drm fixes for 6.11-rc8

dma-buf/heaps:
- fix off by one in CMA heap fault handler

syncobj:
- fix syncobj leak in drm_syncobj_eventfd_ioctl

amdgpu:
- Avoid races between set_drr() functions and dc_state_destruct()
- Fix regression related to zpos
- Fix regression related to overlay cursor
- SMU 14.x updates
- JPEG fixes
- Silence an UBSAN warning

amdkfd:
- Fetch cacheline size from IP discovery

i915:
- Prevent a possible int overflow in wq offsets

xe:
- Remove a double include
- Fix null checks and UAF
- Fix access_ok check in user_fence_create
- Fix compat IS_DISPLAY_STEP() range
- OA fix
- Fixes in show_meminfo

nouveau:
- fix GP10x regression on boot

stm:
- add COMMON_CLK dep

rockchip:
- iommu api change

tegra:
- iommu api change
The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-09-13

for you to fetch changes up to 135be1dc46c64c454f2828dbb7f239d035f47180:

  Merge tag 'drm-xe-fixes-2024-09-12' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-09-13 15:18:18 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc8

dma-buf/heaps:
- fix off by one in CMA heap fault handler

syncobj:
- fix syncobj leak in drm_syncobj_eventfd_ioctl

amdgpu:
- Avoid races between set_drr() functions and dc_state_destruct()
- Fix regerssion related to zpos
- Fix regression related to overlay cursor
- SMU 14.x updates
- JPEG fixes
- Silence an UBSAN warning

amdkfd:
- Fetch cacheline size from IP discovery

i915:
- Prevent a possible int overflow in wq offsets

xe:
- Remove a double include
- Fix null checks and UAF
- Fix access_ok check in user_fence_create
- Fix compat IS_DISPLAY_STEP() range
- OA fix
- Fixes in show_meminfo

nouveau:
- fix GP10x regression on boot

stm:
- add COMMON_CLK dep

rockchip:
- iommu api change

tegra:
- iommu api change

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/atomfirmware: Silence UBSAN warning

Arnd Bergmann (1):
      drm/stm: add COMMON_CLK dependency

Ashutosh Dixit (1):
      drm/xe/oa: Enable Xe2+ PES disaggregation

Ben Skeggs (1):
      drm/nouveau/fb: restore init() for ramgp102

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.11-2024-09-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-09-12' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-09-12' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-09-12' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David (Ming Qiang) Wu (2):
      drm/amd/amdgpu: apply command submission parser for JPEG v2+
      drm/amd/amdgpu: apply command submission parser for JPEG v1

David Belanger (1):
      drm/amdkfd: Add cache line size info

Jani Nikula (1):
      drm/xe/display: fix compat IS_DISPLAY_STEP() range end

Kenneth Feng (2):
      drm/amd/pm: update the features set on smu v14.0.2/3
      drm/amd/pm: fix the pp_dpm_pcie issue on smu v14.0.2/3

Leo Li (2):
      drm/amd/display: Do not reset planes based on crtc zpos_changed
      drm/amd/display: Add all planes on CRTC to state for overlay cursor

Lu Baolu (2):
      drm/rockchip: Use iommu_paging_domain_alloc()
      drm/tegra: Use iommu_paging_domain_alloc()

Lucas De Marchi (1):
      drm/xe/gt: Remove double include

Matthew Auld (2):
      drm/xe/client: fix deadlock in show_meminfo()
      drm/xe/client: add missing bo locking in show_meminfo()

Matthew Brost (2):
      drm/xe: Remove fence check from send_tlb_invalidation
      drm/xe: Fix possible UAF in guc_exec_queue_process_msg

Nikita Zhandarovich (1):
      drm/i915/guc: prevent a possible int overflow in wq offsets

Nirmoy Das (1):
      drm/xe: Fix access_ok check in user_fence_create

T.J. Mercier (2):
      dma-buf: heaps: Fix off-by-one in CMA heap fault handler
      drm/syncobj: Fix syncobj leak in drm_syncobj_eventfd_ioctl

Tobias Jakobi (2):
      drm/amd/display: Avoid race between dcn10_set_drr() and
dc_state_destruct()
      drm/amd/display: Avoid race between dcn35_set_drr() and
dc_state_destruct()

 drivers/dma-buf/heaps/cma_heap.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             | 76 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h             | 11 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             | 63 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h             |  6 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h             |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           | 57 +---------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h           |  7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  8 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 13 +++-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    | 20 +++---
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 20 +++---
 drivers/gpu/drm/amd/include/atomfirmware.h         |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       | 11 +++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 12 ++++
 drivers/gpu/drm/drm_syncobj.c                      | 17 +++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h       |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c  |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 10 ++-
 drivers/gpu/drm/stm/Kconfig                        |  1 +
 drivers/gpu/drm/tegra/drm.c                        |  5 +-
 drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h  |  2 +-
 drivers/gpu/drm/xe/regs/xe_oa_regs.h               |  1 +
 drivers/gpu/drm/xe/xe_drm_client.c                 | 45 +++++++++++--
 drivers/gpu/drm/xe/xe_gt.c                         |  1 -
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        |  4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  4 +-
 drivers/gpu/drm/xe/xe_oa.c                         |  4 ++
 drivers/gpu/drm/xe/xe_sync.c                       |  2 +-
 36 files changed, 315 insertions(+), 109 deletions(-)

