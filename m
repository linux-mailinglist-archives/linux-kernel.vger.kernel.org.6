Return-Path: <linux-kernel+bounces-550127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E878EA55B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E047A41E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD59DDAD;
	Fri,  7 Mar 2025 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bchumZve"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E3256D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306404; cv=none; b=b4vL8h9Cl9/M0dfn96y5F3yRABe6JesCElkWVwQFFZH+PLaKKD//ArWHE9jmu3U/BKQOG4f964BYohM86M49erxfnMoQoHA58cFoY46CJ2pEW4opIsj5s261c16W9PgHm4p93C4lx5p8zI0Nx05NsJmQrZMxpVe+KC0BUs9kYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306404; c=relaxed/simple;
	bh=WUy3BnoFl87bFjAqIVAVQ7fVwAEL7qPTWFsOcRZs2CE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z/JB1xNx+xd4C01UzMG+yvX/bFSwf4uWTSj2hQKyLj3LWfMBpu5emhUGEkUnyMqX8KTkRhS+LMABXQiVUNRs8nOZkGalXJCYqiq1jmQNA4BjQ36R4zR9Hfn6GWru2q4JLfBjrpF/uSbaZj0zVOo81P6QyDY1v5Q9jo90sjtdilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bchumZve; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so212504266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 16:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741306401; x=1741911201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+coMIrKPqiErWfQYpK9wmQFyJx26pAi45ANI3Pnrqs=;
        b=bchumZvezx90PKclDV2ptNe0tJhynW9a3sgKenRSKV8cVcHJ9W8ZAhJJLLyzVigjbn
         UOZF0uSiySkaysv/xPIAy1dHUfAlzbinan99A1pLNgGZqL1LPcBDCYEHT4vbQJtpTouC
         Qbku8L/m1E+/BqJcQHdr7RPJHMsrrP7tDW+FIbZrlWn76+G6wE87NkU8RzYRli2QlGmk
         OtrMYs2Ua0ACwR5KdGQTE2M+XZpzMxUeRcWnGWZyOasQtWFzxuqT3maLdekfIHWKDBog
         b6AQfAww9EMoHx2Kt+vRk/R2DZYjIGMUDFLrCeMuRd4ezz26+jX8DRz7vJlgnhq7gPLB
         7FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306401; x=1741911201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+coMIrKPqiErWfQYpK9wmQFyJx26pAi45ANI3Pnrqs=;
        b=UBTzHWn26saDS53bjZDl71QwBSMEk1iiYAOalaISguToPXD9TKic+76fjY5yh/6pe8
         KQB6fgGnzU1nCqzFzDa18kNpd05tJLRGGleguseo6Z61UsqXsL7uMEtB9BkBIxmBKtJY
         5CtphiOe7C7fZ5nXWikYKOUVnW9kOhhGjWpfAqAxBOMzJO8vmCB8iFNMRR0/juucfKJ+
         YhZn9JT8JDBry+G71idJ/JuNSgQZJBqKvil/HP1oe1FJh0HE6MzJz5BlWtjb/IPRxmCi
         yPuR2luhM7j3rlRjB3rSLHG+YjQOc7anNZeV0g9DnOdEeZT60HuBgkfpcWjurc0At0L2
         S4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXsGxY92qnP4l1QLRAhR2b+V1Z1SDPbPO8sTS+kN6ycBIvca+z1tdKptRQokX/MZrpEEmiAF+OtdX3kiuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfX/mVcZfTVRaFat9tJwhBSLkJ0yCrBM0Xyis4jb6/zSnv5dgt
	hVWFgkL9j5tZCsVE+StDLhjtYsmx2qq0fmaj7iH95PzhJXtrsJpQ7qaSMzC7M6/dmO26+VnLoys
	ODAmxhcjQbU3+k8LEBYTYW2kDejIPG6Gp
X-Gm-Gg: ASbGnct8Ae1o6aLoMKrPjAeUZVyrcKTflYp9CPtiuaF4Vetx4tuc3nv7UzZCiPaAI94
	97G0Gzd28wlJ4hwjZRAjTshMBu+VDzmHZqPoK9FrOBoMbiYaWx8S3/bP6Tceo2+Jz3x/p9tckb/
	QtsXMzFeZgLQ6JosOG8s1jOxN9
X-Google-Smtp-Source: AGHT+IEs1H7D9wR1RtDGXDvz8FVlYfWVFiJqdKal9HypXfyO5HuEqNCbowowkuut9E3ZHZsn1JHucObPLqq+FkMKUiQ=
X-Received: by 2002:a17:907:1c1f:b0:ac1:dc35:8337 with SMTP id
 a640c23a62f3a-ac252fb9b12mr126049366b.38.1741306400461; Thu, 06 Mar 2025
 16:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 7 Mar 2025 10:13:09 +1000
X-Gm-Features: AQ5f1JoQcijU1PWlrdTrt7IvLjGGmpF6i0qrOAiYW8LmLQ3TMWUvadsseaEZHJ8
Message-ID: <CAPM=9tzHwhm74Z=itrPBz=yz=0VZOrcbnKs6u5LLQuwJrng5zw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.14-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Looks like the cyclone is taking its time getting here, so I can at
least get the drm fixes tree out.

Fixes across the board, mostly xe and imagination with some amd and
misc others. The xe fixes are mostly hmm related, though there are
some others in there as well, nothing really stands out otherwise. The
nouveau Kconfig to select FW_CACHE is in this, which we discussed a
while back.

drm-fixes-2025-03-07:
drm fixes for 6.14-rc6

nouveau:
- rely on fw caching Kconfig fix

imagination:
- avoid deadlock on fence release
- fix fence initialisation
- fix timestamps firmware traces

scheduler:
- fix include guard

bochs:
- dpms fix

i915:
- bump max stream count to match pipes

xe:
- Remove double page flip on initial plane
- Properly setup userptr pfn_flags_mask
- Fix GT "for each engine" workarounds
- Fix userptr races and missed validations
- Userptr invalid page access fixes
- Cleanup some style nits

amdgpu:
- Fix NULL check in DC code
- SMU 14 fix

amdkfd:
- Fix NULL check in queue validation

radeon:
- RS400 HyperZ fix
The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6=
:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-07

for you to fetch changes up to c8bc66206a44f389649af374f5301b2c3a71fff4:

  Merge tag 'amd-drm-fixes-6.14-2025-03-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2025-03-07
09:54:43 +1000)

----------------------------------------------------------------
drm fixes for 6.14-rc6

nouveau:
- rely on fw caching Kconfig fix

imagination:
- avoid deadlock on fence release
- fix fence initialisation
- fix timestamps firmware traces

scheduler:
- fix include guard

bochs:
- dpms fix

i915:
- bump max stream count to match pipes

xe:
- Remove double page flip on initial plane
- Properly setup userptr pfn_flags_mask
- Fix GT "for each engine" workarounds
- Fix userptr races and missed validations
- Userptr invalid page access fixes
- Cleanup some style nits

amdgpu:
- Fix NULL check in DC code
- SMU 14 fix

amdkfd:
- Fix NULL check in queue validation

radeon:
- RS400 HyperZ fix

----------------------------------------------------------------
Alessio Belle (1):
      drm/imagination: Fix timestamps in firmware traces

Andrew Martin (1):
      drm/amdkfd: Fix NULL Pointer Dereference in KFD queue

Brendan King (3):
      drm/imagination: avoid deadlock on fence release
      drm/imagination: Hold drm_gem_gpuva lock for unmap
      drm/imagination: only init job done fences once

Dave Airlie (5):
      drm/nouveau: select FW caching
      Merge tag 'drm-misc-fixes-2025-03-06' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-03-06' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-03-06' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.14-2025-03-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Jani Nikula (1):
      drm/i915/mst: update max stream count to match number of pipes

Kenneth Feng (1):
      drm/amd/pm: always allow ih interrupt from fw

Ma Ke (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in
resource_build_scaling_params

Maarten Lankhorst (1):
      drm/xe: Remove double pageflip

Matthew Auld (1):
      drm/xe/userptr: properly setup pfn_flags_mask

Matthew Brost (1):
      drm/xe: Add staging tree for VM binds

Philipp Stanner (1):
      drm/sched: Fix preprocessor guard

Richard Thier (1):
      drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M

Takashi Iwai (1):
      drm/bochs: Fix DPMS regression

Thomas Hellstr=C3=B6m (6):
      drm/xe/vm: Validate userptr during gpu vma prefetching
      drm/xe/vm: Fix a misplaced #endif
      drm/xe: Fix fault mode invalidation with unbind
      drm/xe/hmm: Style- and include fixes
      drm/xe/hmm: Don't dereference struct page pointers without notifier l=
ock
      drm/xe/userptr: Unmap userptrs in the mmu notifier

Tvrtko Ursulin (1):
      drm/xe: Fix GT "for each engine" workarounds

 drivers/gpu/drm/amd/amdkfd/kfd_queue.c            |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  12 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c       |   3 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c         |   6 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c        |   4 +-
 drivers/gpu/drm/imagination/pvr_queue.c           |  18 +-
 drivers/gpu/drm/imagination/pvr_queue.h           |   4 +
 drivers/gpu/drm/imagination/pvr_vm.c              | 134 ++++++++++++---
 drivers/gpu/drm/imagination/pvr_vm.h              |   3 +
 drivers/gpu/drm/nouveau/Kconfig                   |   1 +
 drivers/gpu/drm/radeon/r300.c                     |   3 +-
 drivers/gpu/drm/radeon/radeon_asic.h              |   1 +
 drivers/gpu/drm/radeon/rs400.c                    |  18 +-
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h   |   4 +-
 drivers/gpu/drm/tiny/bochs.c                      |   5 +-
 drivers/gpu/drm/xe/display/xe_plane_initial.c     |  10 --
 drivers/gpu/drm/xe/xe_gt.c                        |   4 +-
 drivers/gpu/drm/xe/xe_hmm.c                       | 194 ++++++++++++++++--=
----
 drivers/gpu/drm/xe/xe_hmm.h                       |   7 +
 drivers/gpu/drm/xe/xe_pt.c                        |  96 +++++------
 drivers/gpu/drm/xe/xe_pt_walk.c                   |   3 +-
 drivers/gpu/drm/xe/xe_pt_walk.h                   |   4 +
 drivers/gpu/drm/xe/xe_vm.c                        | 100 +++++++----
 drivers/gpu/drm/xe/xe_vm.h                        |  10 +-
 drivers/gpu/drm/xe/xe_vm_types.h                  |   8 +-
 26 files changed, 459 insertions(+), 200 deletions(-)

