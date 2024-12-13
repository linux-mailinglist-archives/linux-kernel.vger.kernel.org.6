Return-Path: <linux-kernel+bounces-445590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7869F1800
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0E1885418
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7301922FC;
	Fri, 13 Dec 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USXLKP5b"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA181DA5F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125039; cv=none; b=JBNlmvGoHnkTOoX36CkrE7tpwnspq+czpm6nTnjvCls59VcPYBOTUJqdOM/+JmCjpCAC5zXCuS6rdIFsKm6aOhWuuDWjpO9yvYCOGbazqvIxzRqpnPcCPk5Shz2BS/uOBa+MP2xyawmrpbU5STvlMNwP96gTHLok49VjTeBF4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125039; c=relaxed/simple;
	bh=88HMWtLRn5GlgVLxCNG0kn0VbpG0bCsCZqPlKWhubTM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=diDZ/YkIACSV29mtLKxNUZmTe3ZVVDQE1r5kUULlW0elH3DxuRMj1EEQn9wMnZ7NyOi0Yt2Gq3vmYsNOajF1gdUH1oTJJUYhqMAwQbqj4jAyaEsOXl2YELI7uYdl5GqV9xSl2ZTsbIg2X217iIHwaNa8pblT2uNc4dRwHbRd+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USXLKP5b; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa662795ca3so632068966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734125036; x=1734729836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ko6SqQy8zgaq8WuJxgzJuB+CGxF6XuhiRKK6wt4rr1M=;
        b=USXLKP5bNZddsLAEsJQtKe8IgGU/q0nWMjJ2YOYIU6kVz+PzqCsCafmJ3wR1M+ZD4z
         dYjczdSCu1EshJexS2/JyDUpFJChQHdj3KZOvCfFPvVIMJr4gy4Lb8foXp8J1l/B477d
         +Qr6ciW0hCJHuz337Xcf8bLalR3SFH3JKnMvxBcZFL6wqFCr6NreKeB/HnmQw9BaS4FZ
         bCW1ONmVSPJ25hC8QS5UHRX0ZGttOzlRt3HGEbHVjQJp7YIxkzOAnRnU4Y0el7Z0QZ0J
         fSpP02gs/V6PO/ZFYj8FWsp0ZwMhYjQwhFfr/vb08SpZANXZRSmlNGgh3vgi09keojjg
         CvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125036; x=1734729836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ko6SqQy8zgaq8WuJxgzJuB+CGxF6XuhiRKK6wt4rr1M=;
        b=TCDbGKU1KrZP0OrymHhlPzzOhGMasDOSt7//LM67Z7eetu4R2c13rQQSnkFkMBcJQF
         SsQI3De4NAfDltp6C2Lvl4m8ahRNIHYsAM0pX3hLlXDR6EoysMNeiTni7ixcBqBPIp1h
         +ikS5F+acqb0eOpWzeWVNtN+9uT+wfVXIl8E7n6F1m9RaX5s44CZOoNuV4ojPRSncStx
         By0k64szSY4QFqpTU/jVC5NkaC4TbROnxZg+n7QQv2cU3yGSYClFjq9qlHclCx9sDNzm
         qOVBZaZ+wGF4yewH7kRK6+vVD5RmKewhcUQ0iIj5N2FJpumCua2KSx3EToEaf37tYDwS
         Xg6g==
X-Gm-Message-State: AOJu0YyFWugcc9iZQ+5T7GyXLJpmxY0NLbR0yzPGYAmrxWJXTl2sgNj0
	ejsn1XSK7P+TES9gR5MYIy6WMMtI+ykYr1VMmpv3qh+2QIkqHdM1ASBnkJQ4eLhIExsq/pRUU5P
	veApEkleuyxc+x20hK0UFfrWoGs4=
X-Gm-Gg: ASbGncswJnH8xU4ciQ7FOdfSrLpTKWsob7nHE+8sEdcrFlBjRq+T/rbY8jwir/7mnNp
	uyZEyj+AeLfqw/KbaDhe3VV5E7HWe9HROBcka
X-Google-Smtp-Source: AGHT+IEPGkmoimuWCVe3G3imQ1LRZj/yAkACmoMdE4SG4c9rfT1r1umXXrh0Fonid474ByBp4kNOXWLF7rpPDcrV1Ns=
X-Received: by 2002:a17:907:7709:b0:aa6:79c0:d8ce with SMTP id
 a640c23a62f3a-aab7b0e8a85mr342981666b.1.1734125035505; Fri, 13 Dec 2024
 13:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 14 Dec 2024 07:23:44 +1000
Message-ID: <CAPM=9tyHzxubr_sRuNSoPdJB4uL=E1cFzUzNxY1dPrOW=y-NdQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.13-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This is the weekly fixes pull for drm. Just has i915, xe and amdgpu
changes in it, the misc tree didn't get a PR to me this week (cc'ed),
so next week might have a larger set of changes, otherwise nothing too
major in here.

Regards,
Dave.


drm-fixes-2024-12-14:
drm fixes for 6.13-rc3

i915:
- Don't use indexed register writes needlessly [dsb]
- Stop using non-posted DSB writes for legacy LUT [color]
- Fix NULL pointer dereference in capture_engine
- Fix memory leak by correcting cache object name in error handler

xe:
- Fix a KUNIT test error message (Mirsad Todorovac)
- Fix an invalidation fence PM ref leak (Daniele)
- Fix a register pool UAF (Lucas)

amdgpu:
- ISP hw init fix
- SR-IOV fixes
- Fix contiguous VRAM mapping for UVD on older GPUs
- Fix some regressions due to drm scheduler changes
- Workload profile fixes
- Cleaner shader fix

amdkfd:
- Fix DMA map direction for migration
- Fix a potential null pointer dereference
- Cacheline size fixes
- Runtime PM fix
The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4=
:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-14

for you to fetch changes up to d172ea67dbeec5c90f72752c91d202d5718e3754:

  Merge tag 'amd-drm-fixes-6.13-2024-12-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-12-13
09:43:20 +1000)

----------------------------------------------------------------
drm fixes for 6.13-rc3

i915:
- Don't use indexed register writes needlessly [dsb]
- Stop using non-posted DSB writes for legacy LUT [color]
- Fix NULL pointer dereference in capture_engine
- Fix memory leak by correcting cache object name in error handler

xe:
- Fix a KUNIT test error message (Mirsad Todorovac)
- Fix an invalidation fence PM ref leak (Daniele)
- Fix a register pool UAF (Lucas)

amdgpu:
- ISP hw init fix
- SR-IOV fixes
- Fix contiguous VRAM mapping for UVD on older GPUs
- Fix some regressions due to drm scheduler changes
- Workload profile fixes
- Cleaner shader fix

amdkfd:
- Fix DMA map direction for migration
- Fix a potential null pointer dereference
- Cacheline size fixes
- Runtime PM fix

----------------------------------------------------------------
Andrew Martin (1):
      drm/amdkfd: Dereference null return value

Christian K=C3=B6nig (2):
      drm/amdgpu: fix UVD contiguous CS mapping problem
      drm/amdgpu: fix when the cleaner shader is emitted

Daniele Ceraolo Spurio (1):
      drm/xe: Call invalidation_fence_fini for PT inval fences in error sta=
te

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2024-12-11' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-12-12' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.13-2024-12-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David (Ming Qiang) Wu (1):
      amdgpu/uvd: get ring reference from rq scheduler

Eugene Kobyak (1):
      drm/i915: Fix NULL pointer dereference in capture_engine

Harish Kasiviswanathan (2):
      drm/amdkfd: hard-code cacheline size for gfx11
      drm/amdkfd: hard-code MALL cacheline size for gfx11, gfx12

Jesse.zhang@amd.com (1):
      drm/amdkfd: pause autosuspend when creating pdd

Jiasheng Jiang (1):
      drm/i915: Fix memory leak by correcting cache object name in error ha=
ndler

Kenneth Feng (1):
      drm/amd/pm: Set SMU v13.0.7 default workload type

Lijo Lazar (1):
      drm/amd/pm: Initialize power profile mode

Lucas De Marchi (1):
      drm/xe/reg_sr: Remove register pool

Mirsad Todorovac (1):
      drm/xe: fix the ERR_PTR() returned on failure to allocate tiny pt

Pratap Nirujogi (2):
      Revert "drm/amdgpu: Fix ISP hw init issue"
      drm/amdgpu: Fix ISP HW init issue

Prike Liang (1):
      drm/amdkfd: Correct the migration DMA map direction

Victor Zhao (1):
      drm/amdgpu: use sjt mec fw on gfx943 for sriov

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/dsb: Don't use indexed register writes needlessly
      drm/i915/color: Stop using non-posted DSB writes for legacy LUT

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 13 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            | 10 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              | 24 ++++++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 15 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 23 +-----
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 12 ++--
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 24 +++++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  1 +
 drivers/gpu/drm/i915/display/intel_color.c         | 81 ++++++++++++++----=
----
 drivers/gpu/drm/i915/display/intel_dsb.c           | 19 ++++-
 drivers/gpu/drm/i915/display/intel_dsb.h           |  2 +
 drivers/gpu/drm/i915/i915_gpu_error.c              | 18 ++++-
 drivers/gpu/drm/i915/i915_scheduler.c              |  2 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c              |  4 +-
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        |  8 +++
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h        |  1 +
 drivers/gpu/drm/xe/xe_pt.c                         |  3 +-
 drivers/gpu/drm/xe/xe_reg_sr.c                     | 31 ++-------
 drivers/gpu/drm/xe/xe_reg_sr_types.h               |  6 --
 25 files changed, 200 insertions(+), 125 deletions(-)

