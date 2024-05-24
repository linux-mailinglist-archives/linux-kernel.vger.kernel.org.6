Return-Path: <linux-kernel+bounces-189084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED78CEACF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30041C21014
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEA74420;
	Fri, 24 May 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsUFuNAZ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7D46542
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582220; cv=none; b=pkOMsZ9HK+2Vkx99ICovCEyvVUS1wK/VPBfMT/eKKo7EZQfftccKbihhHCd3DmG2p6Fofv9JYnxCXOwn7A06kWUcumgxRjcQyLZNOHDrJ+NxsjJwE6QOVNRpVU9obgHj3Kyeqc/dxtnshTy4zktnmdo6MEqOra08BprxqCDcXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582220; c=relaxed/simple;
	bh=+8flVrqRpeNHkFkBTr1JBBuIZPp/jo4j6L+YL66rDwo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LamB5qoVvCxMAXediNs2KeFRvjZjhaG0n04qthKJ8q9IOgyLk8UxkNDH/EflNJaI+Q0l5AsfRPKYW1Q7v8pIXWuPF6Wf5dDkYV6IZgE45kIK7uq7E+TJa/8x4dlfoJXs+XZeLVGRVKKtY+B7i9ZAjXJuFr/tvf/YNhm8VMo2oEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsUFuNAZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295dadce7fso1731694e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716582217; x=1717187017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wJu/pVRboFbiKJMa5J2Vf5uGNhPMTOM1fhENv4rUh4M=;
        b=SsUFuNAZTsclkmSeGZpumGlXf1N/7S+RbPdZ4pwwE64duAdFHeWO/U+/VIrkZKlVhB
         zR+mKML68nMbHg94zkBXKJysSWXl3xNTS/P7JFfDXCvA0g/rKOGDYrgFVkleQVdsl5j5
         iL54zy9iGtw5crfV7zaQVvdI7qHPtx52m3yI8L0zzhNi1gnG0Qj83ZOluS1yMCnzJ1/W
         GjLZEY2gqcPPh8z0EZu26dPRDqK5F4l8jrhyqcIj6XJXy47SuTVYxGIKjA4guI2A2D6R
         znPSZQPh6HRVPi2zOGUvFFnrHkWl5ZhXlCMsvXuK7nDNN761A64QsiGRg+oISs0cfWK7
         ZVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582217; x=1717187017;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJu/pVRboFbiKJMa5J2Vf5uGNhPMTOM1fhENv4rUh4M=;
        b=otxI7WJgMkG2KXMreMp4TneGKQqZG52Ah07busCZVIOmn4axcVTywjyQmZaN5BL4am
         1CUPHYwKsEgMQmp9+bewFsChU08z3NOoK20Ux8tiktOfZTnuMjTgRwZfIr/iHpvW9Nty
         56t3cHFhZXMyNYmsh1YPxFxcis+bzr+nnuWgCGjPKGze1Wd1mnkCiWr9N0nSh6cWakMv
         HphTjxZbC9t3ct/UtGaLPuDDx44sJTgyiNx3qeMmt7pjQFFOZ2GmrStiTP5wTsflUV5C
         xZL9arpPGRgY4ocflIEGrIR87K4b0A+qioM+bj5ArfKO6z9KCAelTnvM5XDMmEBr1SEK
         pXVg==
X-Forwarded-Encrypted: i=1; AJvYcCUtpKXgP4FDjeroleg7V6c0OFTGNJqQtN9Fu/UMSwFR9h3NxzPxld+LUQ7bU/BxeetMQhi9lKC6erVKXVBmb0/me2RNU8L18AOMxIP5
X-Gm-Message-State: AOJu0YwVHAMfZ542ia6YtdGbhCoOHeuOM6DUDPLQeVFEccIV07tkYcOx
	vbaNXNE2QLVav2IfEfzumKZUn2Nq34kECR1rYxsmcPiIPW5x2qDZ6GyUEZH5xY9FyDeS2g4Ztm4
	qO0DrY5MUxOc6MsDSCOq/lwEO5rqfsV7P
X-Google-Smtp-Source: AGHT+IGwmsPs4HGTBqKhtiV4QlaLPzfF1wSev4VipuhbjSozto/Lo1KdNV3EosRe1k+njY8t88ynRvq85kmOC499ALE=
X-Received: by 2002:a05:6512:15a2:b0:523:8858:db81 with SMTP id
 2adb3069b0e04-529649c5e7fmr2540839e87.22.1716582217251; Fri, 24 May 2024
 13:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 25 May 2024 06:23:25 +1000
Message-ID: <CAPM=9txzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Some fixes for the end of the merge window, mostly amdgpu and panthor,
with one nouveau uAPI change that fixes a bad decision we made a few
months back.

Regards,
Dave.

drm-next-2024-05-25:
drm fixes for 6.10-rc1

nouveau:
- fix bo metadata uAPI for vm bind

panthor:
- Fixes for panthor's heap logical block.
- Reset on unrecoverable fault
- Fix VM references.
- Reset fix.

xlnx:
- xlnx compile and doc fixes.

amdgpu:
- Handle vbios table integrated info v2.3

amdkfd:
- Handle duplicate BOs in reserve_bo_and_cond_vms
- Handle memory limitations on small APUs

dp/mst:
- MST null deref fix.

bridge:
- Don't let next bridge create connector in adv7511 to make probe work.
The following changes since commit 431c590c3ab0469dfedad3a832fe73556396ee52:

  drm/tests: Add a unit test for range bias allocation (2024-05-16
12:50:14 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-25

for you to fetch changes up to 32a0bb7ef217aa37e6b67ca7950f5e504312ed72:

  Merge tag 'drm-misc-next-fixes-2024-05-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2024-05-23 16:01:39 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc1

nouveau:
- fix bo metadata uAPI for vm bind

panthor:
- Fixes for panthor's heap logical block.
- Reset on unrecoverable fault
- Fix VM references.
- Reset fix.

xlnx:
- xlnx compile and doc fixes.

amdgpu:
- Handle vbios table integrated info v2.3

amdkfd:
- Handle duplicate BOs in reserve_bo_and_cond_vms
- Handle memory limitations on small APUs

dp/mst:
- MST null deref fix.

bridge:
- Don't let next bridge create connector in adv7511 to make probe work.

----------------------------------------------------------------
Anatoliy Klymenko (2):
      drm: xlnx: zynqmp_dpsub: Fix few function comments
      drm: xlnx: zynqmp_dpsub: Fix compilation error

Antonino Maniscalco (1):
      drm/panthor: Fix tiler OOM handling to allow incremental rendering

Arunpravin Paneer Selvam (1):
      drm/buddy: Fix the warn on's during force merge

Boris Brezillon (8):
      drm/panthor: Make sure the tiler initial/max chunks are consistent
      drm/panthor: Relax the constraints on the tiler chunk size
      drm/panthor: Fix an off-by-one in the heap context retrieval logic
      drm/panthor: Document drm_panthor_tiler_heap_destroy::handle
validity constraints
      drm/panthor: Force an immediate reset on unrecoverable faults
      drm/panthor: Keep a ref to the VM at the panthor_kernel_bo level
      drm/panthor: Reset the FW VM to NULL on unplug
      drm/panthor: Call panthor_sched_post_reset() even if the reset failed

Dave Airlie (3):
      Merge tag 'drm-misc-next-fixes-2024-05-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-fixes-6.10-2024-05-22' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2024-05-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next

Lang Yu (2):
      drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms
      drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs

Li Ma (1):
      drm/amdgpu/atomfirmware: add intergrated info v2.3 table

Liu Ying (1):
      drm/bridge: adv7511: Attach next bridge without creating connector

Mohamed Ahmed (1):
      drm/nouveau: use tile_mode and pte_kind for VM_BIND bo allocations

Wayne Lin (1):
      drm/mst: Fix NULL pointer dereference at drm_dp_add_payload_part2

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 23 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 15 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  6 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  2 +-
 drivers/gpu/drm/amd/include/atomfirmware.h         | 43 +++++++++++++++++++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  3 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |  4 +-
 drivers/gpu/drm/drm_buddy.c                        |  6 +--
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |  3 ++
 drivers/gpu/drm/nouveau/nouveau_bo.c               | 44 +++++++++-----------
 drivers/gpu/drm/panthor/panthor_device.c           |  8 +---
 drivers/gpu/drm/panthor/panthor_device.h           |  1 +
 drivers/gpu/drm/panthor/panthor_fw.c               |  5 ++-
 drivers/gpu/drm/panthor/panthor_gem.c              |  8 ++--
 drivers/gpu/drm/panthor/panthor_gem.h              |  8 +++-
 drivers/gpu/drm/panthor/panthor_heap.c             | 36 +++++++++-------
 drivers/gpu/drm/panthor/panthor_sched.c            | 48 ++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_sched.h            |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |  6 +--
 include/drm/display/drm_dp_mst_helper.h            |  1 -
 include/uapi/drm/nouveau_drm.h                     |  7 ++++
 include/uapi/drm/panthor_drm.h                     | 20 +++++++--
 27 files changed, 215 insertions(+), 98 deletions(-)

