Return-Path: <linux-kernel+bounces-360642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0C999DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EEE2859FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8AC209690;
	Fri, 11 Oct 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SffX+KNC"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CE1C2452
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631081; cv=none; b=fvIqc2aHgr1AfU2Ut2IzDQnsoH/cO0xJR4AxGa/b9PArW+eHwI4oNRBQZiPsHWa5alaSDgsxxYK1UKMTXl9oWAjfu3Hd3AJZYjJFWbknHuQPvjS1lZl69ZDKmwRvil4g6XaTmSgdfVhwjoXNzDJPemp4yNWUi7H6iotsU0ZH+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631081; c=relaxed/simple;
	bh=/v7v8UiVx+glbT4jc4xTEI40RQOsSZegwNsYgf5lac4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aGZEeH+Fk7q2gykx7gGTKZgIoaVjG4wXsDVR2M1/4LPbdLdVesvz09zkNZnhzwX/Y3WaP8q0Deb12pTkUXjd1DzDsY6lMQS8hsnG+rOiYw0uC7T4dOqmBTqE45RaHaU1cZDJcVOPQryqxCiHDiBNyDTMbpHU0vZeHzFkeAUHnrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SffX+KNC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5399041167cso2728259e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728631077; x=1729235877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6cy7cZf4Fx/waVp+aNE/ZvtmmKzyMs0V2HvQk1U00Uk=;
        b=SffX+KNC11WF9VwQvhj+jvSK/soQK8xJjCXSCQrG0LYCFKhh7lDgQSDHQdejBP7cR3
         OPx1VjEkYmWGs5r9ibfEv0ERJSmVW7QW1aHkRwtihKxpmClPQ81W2RLsUi9QkT1vqSa7
         pKfCD/6JUlwiHsSJx60vaReMOAcCyX7kbEXLvhV9ta8CZpnMFryAUeMdF95eE8EDm/AD
         8vPv1wCVa02TrQMHtemajbe1kOqlOVuXBD6eTlS6DKahdVmSHit0iJES5ShDx4tvAWhM
         f3I23aEhusZIH6kliWNJKCUfx2KT4aHb4civR2xWJPX9Rd0dIrWJOH3BNE8uiyhGPNKx
         q9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631077; x=1729235877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cy7cZf4Fx/waVp+aNE/ZvtmmKzyMs0V2HvQk1U00Uk=;
        b=eMT+p4Z3QKbbtKCTCZRnIUJDbMQD3rYyTfPkq0Jlbdv1uGeG7a+j68ohQNxPddK4/Z
         3uBWUlkTyT/kLq58LBWsc9KBGUHuE1xRLoJVZryYHZiMnmNT5w2IjX2ab79hySdj8Tb8
         vhd8MbeWvO54q9TaXObA7U1TH1LNHNBfUZYreMdvQmzyDPt7wr38ByTrUKa5V6xBGo5q
         ULxpGmaZ6RXenixVfq0XW3zhLBPbd3WBJ288v+Kk1QugJMPiOkQjY+RvBfwTXp0s8I+n
         F9ppTQbGhpGwWlQ5RCLb/bcHyRQe+270WDnyUwJxhIuu24Pnqqlkc95O3N4rz/kLcZAj
         Zu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkRswsiB29c2DRdU8Q8BCcA2KVlBbjSzoxRztQwYNBLJuTO58LjCIL0BBVdr5RmwMXHATcZn9NOLKIlFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mFj49HLSS3ie84+XycApYtMsl6hdCt0E5uRyMza8wKRl+5ap
	C5TbxPf3KaGZRxeBl+SD0eTlUSJ5uRupZbRrEhLTZ8YN2yAZvEG4X6OZ3E2wBiW097SYXRQ6uNH
	bvCPRDCbWUy7A51KOJC8469iCa0I=
X-Google-Smtp-Source: AGHT+IHlr3eLKcishdsjb5bOO9v15G9M4B7PfgNEFCXJmJfQ0Ll5KdyYXV6YFOtgcfEZSZuZFEOS3U4ch7qJ8ZI5EwU=
X-Received: by 2002:a05:6512:10c4:b0:536:7377:7d23 with SMTP id
 2adb3069b0e04-539da564e36mr1145033e87.40.1728631076785; Fri, 11 Oct 2024
 00:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 11 Oct 2024 17:17:44 +1000
Message-ID: <CAPM=9tyf6kxBxT7H9aPK8y8RDDu7Bx-mLEVPT1zWkapNaXKpcg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.12-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Weekly fixes haul for drm, lots of small fixes all over, amdgpu, xe
lead the way, some minor nouveau and radeon fixes, and then a bunch of
misc all over.

Nothing too scary or out of the unusual.

Regards,
Dave.

drm-fixes-2024-10-11:
drm fixes for 6.12-rc3

sched:
- Avoid leaking lockdep map

fbdev-dma:
- Only clean up deferred I/O if instanciated

amdgpu:
- Fix invalid UBSAN warnings
- Fix artifacts in MPO transitions
- Hibernation fix

amdkfd:
- Fix an eviction fence leak

radeon:
- Add late register for connectors
- Always set GEM function pointers

i915:
- HDCP refcount fix

nouveau:
- dmem: Fix privileged error in copy engine channel; Fix possible
  data leak in migrate_to_ram()
- gsp: Fix coding style

v3d:
- Stop active perfmon before destroying it

vc4:
- Stop active perfmon before destroying it

xe:
- Drop GuC submit_wq pool
- Fix error checking with xa_store()
- Fix missing freq restore on GSC load error
- Fix wedged_mode file permission
- Fix use-after-free in ct communication
The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b=
:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-11

for you to fetch changes up to ac44ff7cec33d5c2d4b72d52603552ec64c1a8bf:

  Merge tag 'drm-xe-fixes-2024-10-10' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-10-11 13:54:10 +1000)

----------------------------------------------------------------
drm fixes for 6.12-rc3

sched:
- Avoid leaking lockdep map

fbdev-dma:
- Only clean up deferred I/O if instanciated

amdgpu:
- Fix invalid UBSAN warnings
- Fix artifacts in MPO transitions
- Hibernation fix

amdkfd:
- Fix an eviction fence leak

radeon:
- Add late register for connectors
- Always set GEM function pointers

i915:
- HDCP refcount fix

nouveau:
- dmem: Fix privileged error in copy engine channel; Fix possible
  data leak in migrate_to_ram()
- gsp: Fix coding style

v3d:
- Stop active perfmon before destroying it

vc4:
- Stop active perfmon before destroying it

xe:
- Drop GuC submit_wq pool
- Fix error checking with xa_store()
- Fix missing freq restore on GSC load error
- Fix wedged_mode file permission
- Fix use-after-free in ct communication

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: partially revert powerplay `__counted_by` changes

Christian K=C3=B6nig (1):
      drm/radeon: always set GEM function pointer

Colin Ian King (1):
      drm/nouveau/gsp: remove extraneous ; after mutex

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.12-2024-10-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-10-10' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-10-10' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-10-10' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Hamza Mahfooz (1):
      drm/amd/display: fix hibernate entry for DCN35+

Jani Nikula (1):
      drm/i915/hdcp: fix connector refcounting

Janne Grunau (1):
      drm/fbdev-dma: Only cleanup deferred I/O if necessary

Josip Pavic (1):
      drm/amd/display: Clear update flags after update has been applied

Lang Yu (1):
      drm/amdkfd: Fix an eviction fence leak

Matt Roper (1):
      drm/xe: Make wedged_mode debugfs writable

Matthew Auld (3):
      drm/xe/ct: prevent UAF in send_recv()
      drm/xe/ct: fix xa_store() error checking
      drm/xe/guc_submit: fix xa_store() error checking

Matthew Brost (2):
      drm/sched: Use drm sched lockdep map for submit_wq
      drm/xe: Drop GuC submit_wq pool

Ma=C3=ADra Canal (2):
      drm/v3d: Stop the active perfmon before being destroyed
      drm/vc4: Stop the active perfmon before being destroyed

Vinay Belgaumkar (1):
      drm/xe: Restore GT freq on GSC load error

Wu Hoi Pok (1):
      drm/radeon: add late_register for connector

Yonatan Maman (2):
      nouveau/dmem: Fix privileged error in copy engine channel
      nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c          |  7 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 45 +++++++++---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h      | 26 +++----
 drivers/gpu/drm/drm_fbdev_dma.c                   |  3 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c         | 10 ++-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c             |  2 +-
 drivers/gpu/drm/radeon/atombios_dp.c              |  9 +--
 drivers/gpu/drm/radeon/radeon_connectors.c        | 17 +++++
 drivers/gpu/drm/radeon/radeon_gem.c               |  3 -
 drivers/gpu/drm/radeon/radeon_object.c            |  1 +
 drivers/gpu/drm/scheduler/sched_main.c            | 11 +++
 drivers/gpu/drm/v3d/v3d_perfmon.c                 |  9 ++-
 drivers/gpu/drm/vc4/vc4_perfmon.c                 |  7 +-
 drivers/gpu/drm/xe/xe_debugfs.c                   |  2 +-
 drivers/gpu/drm/xe/xe_gt.c                        |  4 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                    | 44 +++++++-----
 drivers/gpu/drm/xe/xe_guc_submit.c                | 85 ++-----------------=
----
 drivers/gpu/drm/xe/xe_guc_types.h                 |  7 --
 22 files changed, 149 insertions(+), 158 deletions(-)

