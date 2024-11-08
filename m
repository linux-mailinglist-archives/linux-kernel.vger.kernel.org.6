Return-Path: <linux-kernel+bounces-402262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935B9C2592
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD55F1F24083
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A39A19AD8C;
	Fri,  8 Nov 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnjxW7if"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D3233D79
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094301; cv=none; b=pvRKfrdl5XI4AoQV5Htg/4MOycrE4eKE5EhnrSkNcQ2s4zPTyxgdfnL8MSY38s4ZjWfpd7blEqzxX0yjflVPUYa7ioYK9maK2YoCmwhrz6Z6XKMhH5D/OGZWaOBADllgkln9pihOn1SLQteyEu7TuwH6srAAEwYakzRb+mfCHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094301; c=relaxed/simple;
	bh=oHQX3J31qW4iyB3ReU4moYIX6jynKPjcuVEyAtD4GlY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G0YuDI5W1Br37S1BhbrnRWwNanzyUVKAsdyfCenyByARddEcEbF0qfe4pHoezAgJmruQUd4uOPGp/K2OdWaPoHPiJ60NT84q2X505QHwFto6CtdO3VH5yF70ekUyGvwntRD+o8FeOGvJf+Q8e4SMABnG+ViOugTyUdMABd0jzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnjxW7if; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e8522445dso425290666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731094298; x=1731699098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cgGxNNnaEQsNWjle8SbOikD38cOYArxLq1ZUW8VjYx8=;
        b=BnjxW7ifKIsmkd2+208fJo3kwRNTc1DL5yOzyNUYZ9eKwDt/03VzyMBpBaAKlcDPgj
         IuwvPXXXxaPD/kOYtfJtRCcNQxlW7vdQY7cZVK8C06nXEhfd/aMi//y2i+wB10JXZoRo
         D3KOxjDAsrRQpwjoYNUVH6C+MvWDXJgKZTpWpPr01Whzmh9RtXXKQOSwuDyGno/UE/Zk
         LdJ2Br9bgjsORKz/abzbRoiZDWe9eDQEaFHo/Kb1/46HamS/P1cPxb3tkb+5nxmKSB/F
         ym/ClU5jtT0seFFzfjMGoFdiegTzsNsBZ7HjoRoxJQaJd1uq19Nq3roWs4rnR7FvxSUX
         IPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731094298; x=1731699098;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgGxNNnaEQsNWjle8SbOikD38cOYArxLq1ZUW8VjYx8=;
        b=MzF1mO8nN/RnpGfKF3n0oLtH1J3hkiaCzX6byFf1wI/H9MDYfHYVYgl4a2B/9eGgmy
         +Hmw4seDLXE0R0TQxHndK/cMGW3ZjZuKPPNMHwx1qZeJgJHqaWjPCMYDPutLqUy8Cne5
         qrH6sp7SPPLkWtqKtRXxd2IcdbgutcK1nALa9nICRhCAnEOxNwpEHv7ToKqtOLVSlwpI
         54SO4nty3DqQwnLCY2B49XvQLVc6ksH1Na1nb/nwFw66eGr1boeo4k57UZbKxGzCzKAS
         QNJWX6S+qeuXrfRQnGKCjRZRET1X1e62HTVW7hBp7RIbrbf9j8CGqfM3pmWzKui7Qm5X
         WEhg==
X-Forwarded-Encrypted: i=1; AJvYcCWu4x/UT4rYWnK+7bGrwZ9OKqvQOgsOFDWmsMAfDBd2jZGJVqqw2d0KI/lKcBPvakxz6qCKFhQIrZKCQvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeuu8yo4tuOYgFY9maTLlNGKzLgQ+xA3la0EiepEyzGFt6owpw
	kfyEKag1aOQ0uf73rqr8z5MQ7SC7BkOVwA7huq0Xom1OFaWrnQ3pJeYy05GKOu13T3UKpG8Oe7T
	ARg7TmN78KvTP+V8BQah6uY+rDo4=
X-Google-Smtp-Source: AGHT+IHMDNHQMD4o8K4OqTTXnDjnVKeeIoUJdHC3XUjL4+6NCwn0AU8TEqbzl8MvoDBT83Swo+K0fNZ4bKWoidRppxo=
X-Received: by 2002:a17:907:804:b0:a9a:4e7d:b0a1 with SMTP id
 a640c23a62f3a-a9ef001322fmr402101766b.49.1731094297785; Fri, 08 Nov 2024
 11:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 9 Nov 2024 05:31:26 +1000
Message-ID: <CAPM=9typGnBRiPLJwjeYnWSWAXtuvi_4gi55zBXzLGD7+Kus0w@mail.gmail.com>
Subject: [git pull] drm fixes for 6.12-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly fixes, usual leaders in amdgpu and xe, then a panel quirk, and
some fixes to imagination and panthor drivers. Seems around the usual
level for this time and don't know of any big problems.

Regards,
Dave.

drm-fixes-2024-11-09:
drm fixes for 6.12-rc7

amdgpu:
- Brightness fix
- DC vbios parsing fix
- ACPI fix
- SMU 14.x fix
- Power workload profile fix
- GC partitioning fix
- Debugfs fixes

imagination:
- Track PVR context per file
- Break ref-counting cycle

panel-orientation-quirks:
- Fix matching Lenovo Yoga Tab 3 X90F

panthor:
- Lock VM array
- Be strict about I/O mapping flags

xe:
- Fix ccs_mode setting for Xe2 and later
- Synchronize ccs_mode setting with client creation
- Apply scheduling WA for LNL in additional places as needed
- Fix leak and lock handling in error paths of xe_exec ioctl
- Fix GGTT allocation leak leading to eventual crash in SR-IOV
- Move run_ticks update out of job handling to avoid synchronization
  with reader
The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-09

for you to fetch changes up to 1a6bbc4d9e55d6c9df2dfe7d4f2705a544d8ca13:

  Merge tag 'drm-xe-fixes-2024-11-08' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-11-09 05:14:29 +1000)

----------------------------------------------------------------
drm fixes for 6.12-rc7

amdgpu:
- Brightness fix
- DC vbios parsing fix
- ACPI fix
- SMU 14.x fix
- Power workload profile fix
- GC partitioning fix
- Debugfs fixes

imagination:
- Track PVR context per file
- Break ref-counting cycle

panel-orientation-quirks:
- Fix matching Lenovo Yoga Tab 3 X90F

panthor:
- Lock VM array
- Be strict about I/O mapping flags

xe:
- Fix ccs_mode setting for Xe2 and later
- Synchronize ccs_mode setting with client creation
- Apply scheduling WA for LNL in additional places as needed
- Fix leak and lock handling in error paths of xe_exec ioctl
- Fix GGTT allocation leak leading to eventual crash in SR-IOV
- Move run_ticks update out of job handling to avoid synchronization
  with reader

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: Adjust debugfs register access permissions
      drm/amdgpu: Adjust debugfs eviction and IB access permissions
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

Antonio Quartulli (1):
      drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported

Aurabindo Pillai (1):
      drm/amd/display: parse umc_info or vram_info based on ASIC

Balasubramani Vivekanandan (2):
      drm/xe: Set mask bits for CCS_MODE register
      drm/xe: Use the filelist from drm for ccs_mode change

Brendan King (2):
      drm/imagination: Add a per-file PVR context list
      drm/imagination: Break an object reference loop

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-6.12-2024-11-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-11-08' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-11-08' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Hans de Goede (1):
      drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI
match less strict

Jann Horn (1):
      drm/panthor: Be stricter about IO mapping flags

Kenneth Feng (2):
      drm/amd/pm: always pick the pptable from IFWI
      drm/amd/pm: correct the workload setting

Lijo Lazar (1):
      drm/amdgpu: Fix DPX valid mode check on GC 9.4.3

Liviu Dudau (1):
      drm/panthor: Lock XArray when getting entries for the VM

Lucas De Marchi (1):
      drm/xe: Stop accumulating LRC timestamp on job_free

Matthew Brost (2):
      drm/xe: Fix possible exec queue leak in exec IOCTL
      drm/xe: Drop VM dma-resv lock on xe_sync_in_fence_get failure in
exec IOCTL

Michal Wajdeczko (1):
      drm/xe/pf: Fix potential GGTT allocation leak

Nirmoy Das (3):
      drm/xe: Move LNL scheduling WA to xe_device.h
      drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
      drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Tom Chung (1):
      drm/amd/display: Fix brightness level not retained over reboot

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 10 +--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 15 +++++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 49 ++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  5 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 20 ++++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 74 ++--------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  8 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |  2 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  1 -
 drivers/gpu/drm/imagination/pvr_context.c          | 33 ++++++++++
 drivers/gpu/drm/imagination/pvr_context.h          | 21 ++++++
 drivers/gpu/drm/imagination/pvr_device.h           | 10 +++
 drivers/gpu/drm/imagination/pvr_drv.c              |  3 +
 drivers/gpu/drm/imagination/pvr_vm.c               | 22 +++++--
 drivers/gpu/drm/imagination/pvr_vm.h               |  1 +
 drivers/gpu/drm/panthor/panthor_device.c           |  4 ++
 drivers/gpu/drm/panthor/panthor_mmu.c              |  2 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  2 +-
 drivers/gpu/drm/xe/xe_device.c                     | 10 ---
 drivers/gpu/drm/xe/xe_device.h                     | 14 ++++
 drivers/gpu/drm/xe/xe_device_types.h               |  9 ---
 drivers/gpu/drm/xe/xe_exec.c                       | 13 ++--
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  6 ++
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                | 15 +++--
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |  4 +-
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c        |  2 +
 drivers/gpu/drm/xe/xe_guc_ct.c                     | 11 +---
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  2 -
 drivers/gpu/drm/xe/xe_wait_user_fence.c            |  7 ++
 38 files changed, 257 insertions(+), 155 deletions(-)

