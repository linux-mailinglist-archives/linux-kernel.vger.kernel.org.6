Return-Path: <linux-kernel+bounces-299476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE495D54B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DBB1C2160A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAF191F6B;
	Fri, 23 Aug 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S21US1zw"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3C3FB3B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437671; cv=none; b=F+mr7UezlSCwuXfAoy5C7s//PSRFymuHoM/JzBGdRa/oLcjERp6PtU4AHxcf80KSp7UHN0UbMg/4JiHv+6gazNOCd7PZjYbWMude2cbaHvRmYw0iyP87b6l3ovSZNj0zsqPCrrVjD/DRzF8vJE4jjksjipPVqy8tZmTBC74PCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437671; c=relaxed/simple;
	bh=2+N+bQ8V68EGi05bIG2BJ0O62HNsvUmq/VtdRKmEWEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uM0hYuf7K+oS//sRFxdVhVs1myXoyk+CZXCGl/e4x+y1ouQw4+8s71r2uAhPGeeaQ8dWZrF20DGXfPLzVtyZw+hvI+GN8Arht5kMU98YfxT99uJ9psm4kpQmtLLQPCQI3ZwEQO+c8hSOCA41UJRP80oJbKvjvpKBm9jdulD1a1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S21US1zw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334879ba28so2788655e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437667; x=1725042467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arxEqM4iPY0nUgAVDsfW5DaV8kH/NilIDpYqT7ZQlQ8=;
        b=S21US1zwGFbEAr4WmCApctAWji9o+BFAG7TiT+BzFobo4jqAnfsKGh0gtWXkny/36P
         OEaDSUesiuEd6YC8HHQgI9HCIWC3nuj8/2gqEqDGXBPIVnpc6sajsfiQxFNUMOBj0IJz
         qihQydb9lgdXbfefzPL0oKS+UL9gRXCIFaV6gGPW2wJSqI/V7XPUJiDE9CJ9i2ztCRt4
         573jL6DRrTS4ezWnzHXHARlyIqxpF6YvYePXkobHi72g8UAenNKpgc6KbR0YQtm08HPv
         pPGwKGnJmkQv7CKShHHNWgvyspSxIqZbYU93SyR4p/KfE8U6aPSyABWYxUCJXm6pUj21
         5BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437667; x=1725042467;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arxEqM4iPY0nUgAVDsfW5DaV8kH/NilIDpYqT7ZQlQ8=;
        b=AmD4FBRM3y/iNlsZyxnn7/cZEgw/60HhUYDfzFdc688WjuOtRSG4FkOLCqNqihXAvH
         SDq4nAEpfTHQq/hMGF0TniBIdhRNlX7nLzfNcNHFjYlAQisj4U7+67v+vswVmHeTlDTQ
         l89/+EosQY8p+h8dGVgL+P27/52EckYbTCv+WM/tqtgCplaHAulcQNKLXLdLy+mtmaVW
         BnHI6Z70EyD0TVIveIxnijHJys4GC2mjxU7yBOplgSeujrTlh90JAdtwTswk++tVHEsI
         y1ptCHgN5F9TNmZBSqu6ZQelna/1iXZksWUllBHd9WTPFVYBCJfLfNtundMYJDN8BSiV
         PDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTnt1NSVEmXsar9e5zdwiC849PKdgB+DxGF3hfAcxmisg9NbLS/efBWHT0WNzWonjMFdtHeEUtKU1AIT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfmGACTBW/pZawbLEVx48KH1BcJ5S+L+6Sb0M31U2h+1m5YJJ
	iT4XmurC8puKDQtCXj/EqzKrem812UIyRs/Sp3Xayqoir/zXdy9hVyYVC3mWzKIGRy9p336mw3y
	SdDiCVzEfGUxo7hOwG/Hxtfxp5ws=
X-Google-Smtp-Source: AGHT+IEJb+8tF7tY/g8yHvdoply7Da2ztQdeHYo2OEl1kEfnlapB254+UWR94w8xoPNOngUvXYvA6RQAXznRl4L7ysI=
X-Received: by 2002:a05:6512:33ce:b0:52c:d6d7:9dd0 with SMTP id
 2adb3069b0e04-5343877997cmr2208217e87.20.1724437666671; Fri, 23 Aug 2024
 11:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 24 Aug 2024 04:27:35 +1000
Message-ID: <CAPM=9tw7_X_1Bhji+DNJXK+940VH2MwgLPsvjX72doJkKt2SHQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly fixes. xe and msm are the major groups, with
amdgpu/i915/nouveau having smaller bits. xe has a bunch of hw
workaround fixes that were found to be missing, so that is why there
are a bunch of scattered fixes, and one larger one. But overall size
doesn't look too out of the ordinary.

Thanks,
Dave.

drm-fixes-2024-08-24:
drm fixes for 6.11-rc5

msm:
- virtual plane fixes
-    drop yuv on hw where not supported
-    csc vs yuv format fix
-    rotation fix
- fix fb cleanup on close
- reset phy before link training
- fix visual corruption at 4K
- fix NULL ptr crash on hotplug
- simplify debug macros
- sc7180 fix
- adreno firmware name error path fix

amdgpu:
- GFX10 firmware loading fix
- SDMA 5.2 fix
- Debugfs parameter validation fix
- eGPU hotplug fix

i915:
- fix HDCP timeouts

nouveau:
- fix SG_DEBUG crash

xe:
- Fix OA format masks which were breaking build with gcc-5
- Fix opregion leak (Lucas)
- Fix OA sysfs entry (Ashutosh)
- Fix VM dma-resv lock (Brost)
- Fix tile fini sequence (Brost)
- Prevent UAF around preempt fence (Auld)
- Fix DGFX display suspend/resume (Maarten)
- Many Xe/Xe2 critical workarounds (Auld, Ngai-Mint, Bommu, Tejas, Daniele)
- Fix devm/drmm issues (Daniele)
- Fix missing workqueue destroy in xe_gt_pagefault (Stuart)
- Drop HW fence pointer to HW fence ctx (Brost)
- Free job before xe_exec_queue_put (Brost)
The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-08-24

for you to fetch changes up to 76f461867800fa9421d26a70a1640eed55dff0cd:

  Merge tag 'drm-xe-fixes-2024-08-22' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-08-23 09:12:16 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc5

msm:
- virtual plane fixes
-    drop yuv on hw where not supported
-    csc vs yuv format fix
-    rotation fix
- fix fb cleanup on close
- reset phy before link training
- fix visual corruption at 4K
- fix NULL ptr crash on hotplug
- simplify debug macros
- sc7180 fix
- adreno firmware name error path fix

amdgpu:
- GFX10 firmware loading fix
- SDMA 5.2 fix
- Debugfs parameter validation fix
- eGPU hotplug fix

i915:
- fix HDCP timeouts

nouveau:
- fix SG_DEBUG crash

xe:
- Fix OA format masks which were breaking build with gcc-5
- Fix opregion leak (Lucas)
- Fix OA sysfs entry (Ashutosh)
- Fix VM dma-resv lock (Brost)
- Fix tile fini sequence (Brost)
- Prevent UAF around preempt fence (Auld)
- Fix DGFX display suspend/resume (Maarten)
- Many Xe/Xe2 critical workarounds (Auld, Ngai-Mint, Bommu, Tejas, Daniele)
- Fix devm/drmm issues (Daniele)
- Fix missing workqueue destroy in xe_gt_pagefault (Stuart)
- Drop HW fence pointer to HW fence ctx (Brost)
- Free job before xe_exec_queue_put (Brost)

----------------------------------------------------------------
Abhinav Kumar (4):
      drm/msm/dp: fix the max supported bpp logic
      drm/msm/dpu: move dpu_encoder's connector assignment to atomic_enable()
      drm/msm/dp: reset the link phy params before link training
      drm/msm: fix the highest_bank_bit for sc7180

Alex Deucher (2):
      drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1
      drm/amdgpu: fix eGPU hotplug regression

Ashutosh Dixit (1):
      drm/xe/observation: Drop empty sysctl table entry

Bommu Krishnaiah (1):
      drm/xe/xe2lpg: Extend workaround 14021402888

Candice Li (1):
      drm/amdgpu: Validate TA binary size

Daniele Ceraolo Spurio (3):
      drm/xe: fix WA 14018094691
      drm/xe: use devm instead of drmm for managed bo
      drm/xe/uc: Use devm to register cleanup that includes exec_queues

Dave Airlie (6):
      nouveau/firmware: use dma non-coherent allocator
      Merge tag 'drm-msm-fixes-2024-08-19' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'amd-drm-fixes-6.11-2024-08-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-08-22' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-08-22' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-08-22' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Dmitry Baryshkov (5):
      drm/msm/dpu: don't play tricks with debug macros
      drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails
      drm/msm/dpu: limit QCM2290 to RGB formats only
      drm/msm/dpu: relax YUV requirements
      drm/msm/dpu: take plane rotation into account for wide planes

Geert Uytterhoeven (1):
      drm/xe/oa/uapi: Make bit masks unsigned

Lucas De Marchi (1):
      drm/xe: Fix opregion leak

Maarten Lankhorst (1):
      drm/xe/display: Make display suspend/resume work on discrete

Matthew Auld (2):
      drm/xe: prevent UAF around preempt fence
      drm/xe/bmg: implement Wa_16023588340

Matthew Brost (4):
      drm/xe: Move VM dma-resv lock from xe_exec_queue_create to
__xe_exec_queue_init
      drm/xe: Fix tile fini sequence
      drm/xe: Drop HW fence pointer to HW fence ctx
      drm/xe: Free job before xe_exec_queue_put

Ngai-Mint Kwan (1):
      drm/xe/xe2lpm: Extend Wa_16021639441

Rob Clark (1):
      drm/msm/adreno: Fix error return if missing firmware-name

Stuart Summers (1):
      drm/xe: Fix missing workqueue destroy in xe_gt_pagefault

Suraj Kandpal (1):
      drm/i915/hdcp: Use correct cp_irq_count

Tejas Upadhyay (3):
      drm/xe/xe2: Make subsequent L2 flush sequential
      drm/xe/xe2: Add Wa_15015404425
      drm/xe/xe2hpg: Add Wa_14021821874

Yang Wang (1):
      drm/amdgpu: fixing rlc firmware loading failure issue

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c     |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         |  5 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c         | 18 +++++----
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c   |  4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c        |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c    |  4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h        | 14 +------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      | 20 ++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.c               |  2 +
 drivers/gpu/drm/msm/dp/dp_panel.c              | 19 ++++-----
 drivers/gpu/drm/msm/msm_mdss.c                 |  2 +-
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c   |  9 +++--
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c       |  6 +++
 drivers/gpu/drm/xe/Makefile                    |  2 +
 drivers/gpu/drm/xe/display/xe_display.c        | 28 ++++++++++++-
 drivers/gpu/drm/xe/display/xe_dsb_buffer.c     |  8 ++++
 drivers/gpu/drm/xe/display/xe_fb_pin.c         |  3 ++
 drivers/gpu/drm/xe/regs/xe_gt_regs.h           |  9 +++++
 drivers/gpu/drm/xe/xe_bo.c                     |  6 +--
 drivers/gpu/drm/xe/xe_device.c                 | 32 +++++++++++++++
 drivers/gpu/drm/xe/xe_device.h                 |  1 +
 drivers/gpu/drm/xe/xe_exec_queue.c             | 24 ++++++-----
 drivers/gpu/drm/xe/xe_exec_queue_types.h       |  2 -
 drivers/gpu/drm/xe/xe_gsc.c                    |  8 ++--
 drivers/gpu/drm/xe/xe_gt.c                     | 55 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_pagefault.c           | 18 ++++++++-
 drivers/gpu/drm/xe/xe_gt_types.h               |  6 +++
 drivers/gpu/drm/xe/xe_guc_submit.c             |  4 +-
 drivers/gpu/drm/xe/xe_hw_fence.c               |  9 +++--
 drivers/gpu/drm/xe/xe_hw_fence_types.h         |  7 +++-
 drivers/gpu/drm/xe/xe_mmio.c                   | 28 ++++++++++++-
 drivers/gpu/drm/xe/xe_observation.c            |  1 -
 drivers/gpu/drm/xe/xe_pat.c                    | 11 +++++-
 drivers/gpu/drm/xe/xe_pm.c                     | 11 +++---
 drivers/gpu/drm/xe/xe_preempt_fence.c          |  3 +-
 drivers/gpu/drm/xe/xe_preempt_fence_types.h    |  2 +
 drivers/gpu/drm/xe/xe_sched_job.c              |  3 +-
 drivers/gpu/drm/xe/xe_trace.h                  |  2 +-
 drivers/gpu/drm/xe/xe_wa.c                     | 18 +++++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules             |  1 +
 include/uapi/drm/xe_drm.h                      |  8 ++--
 43 files changed, 334 insertions(+), 90 deletions(-)

