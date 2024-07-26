Return-Path: <linux-kernel+bounces-262820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B293CD23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A68C28316D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0526AFB;
	Fri, 26 Jul 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj7wzlzG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B723D0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721966445; cv=none; b=iBOMoM95IcLAArqVryDdWhEyuOMWDWroueGo8Tig+1ozbiGMmkkYjTuRUIg+gUe9f45vRpIz4SJ4/Sp3YIrQ8vRfoti54H+hPwT2T47X9ogIj0whFyLgCBkMGcKhPft+pxOtCXHSZMUDqwkKW3ms/IEsKqy7LQG7QrBuAc9ZkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721966445; c=relaxed/simple;
	bh=dqjqL0I88UAtLggqcK0VtfoxjTnXK/cP6mQnMkEWn7Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IyyP9geKb+mnHOElM1O9og4zCaYijqG/GF7opk/QmOIz0C8H1tKsRCaRzUNwhZDw+Lo5/aYZolrNtTDL+blortglXfyZrCkWy6YnuQY8AyfXSqu/aO44plLymjAzgFElakJkxg4OToHKVI3BxIOgYBA13UHWbv1vK2r3jNnAoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj7wzlzG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f025bc147so1101444e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721966441; x=1722571241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oYzy0INYB4eflqD1jaYb5yq+dDkitEPiCdj1V15IGSk=;
        b=aj7wzlzGxzSubkQWBx54cI9pMGPjsCxSsija5cOnhn4OkOdOXSgsPEoZy3DgyFkMp6
         iIMdZvNrhEMcnwqkX2zhGrqjIbwKDNQvxf2Kkwb5y/TEhVDEesBSDJ4LTI/dZs79v9Fc
         qBaITye7vtQR9Q4LkcKuv8BAtkPWGQTHRLMSPZxYk39fzYmHqa+Tz/GY69JeaDMW2DHq
         M8fjDl88pdFAIGJxzkG7MDTb/Pi3q/9TUvpyC7Cgn7xRNE+NH6tCr9/tMo1qf2VNFEoV
         tjV5ZxEx+vo5pClT4BguNZu/k3yOgvt5ZklKBESk4vMorVNrY5clissKs4HS7OT9SE25
         v4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721966441; x=1722571241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYzy0INYB4eflqD1jaYb5yq+dDkitEPiCdj1V15IGSk=;
        b=VfQF/ZgjYXpCUqYAacsGdlnn0QRLb5/lxCQ1/zFWAdSqpX8naevE3H2+ctRCze5vmy
         MbaNLmgMcA4QM6lveaXShbzRn5tqC/WeXBpU+kR81uH6tJV3LJnk0iv621gCOFt58Eq7
         RIODr0zfM2CQ50YMCtR8O2n1TBpoAY3myy+Ev78KHvCqJtR6Gir2TY/GhI8jFhcnt0y8
         SULUGu3xekJI6crfh8hwHy2gh8hiYKssjpEobgWw/bFeCOrygGJ/mHiTpcEtoyXohVtq
         aKGUS/JMmoEnkl7jYjdo9WWZTqqUEmDB3HygHJJbcIlIGIFC7Oq6VjaXMeU0UweyFAqt
         6L/w==
X-Forwarded-Encrypted: i=1; AJvYcCWYFWbFBf/x8E+s7b62tSzuy3CG0fbEV4E7vk+NQM4nSCvptPxLTA8wH+BLON9K2pcG35FGx18RDuFj85bVV3EG1p3ePdHQqwNXIvzd
X-Gm-Message-State: AOJu0YwNug0HfDGLiQAHQ7wrXglBMwvFXAo1p6J5F0zy7FSjKLSkrfdR
	15iZt8+/TiVtEo12ou924pmpMxjK175AUrckXUytQdaKlH+XmcDk4Q3h/jhutnaFq9iUXRkxlnl
	XZA8a6DYPpeX8Gd8ZgWxBLy15f19FvsFU
X-Google-Smtp-Source: AGHT+IEPMMZjgxVxh3fasw56zM4zJ+ABOSO/wLULVTjWshFuaZWNYJv+tHgGYKGBfKOf7yFGYZGmtC6z6NfdIdehExg=
X-Received: by 2002:a05:6512:3b9c:b0:52f:d090:6dae with SMTP id
 2adb3069b0e04-52fd3f8e7a4mr3507195e87.52.1721966440768; Thu, 25 Jul 2024
 21:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 26 Jul 2024 14:00:29 +1000
Message-ID: <CAPM=9txAJoSXCOZHfjf2yObhi7tdQMxjXGggmujbjv1uLdZTew@mail.gmail.com>
Subject: [git pull] drm fixes for 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Fixes for rc1, mostly amdgpu, i915 and xe, with some other misc ones,
doesn't seem to be anything too serious.

Dave.

drm-next-2024-07-26:
drm fixes for 6.11-rc1

amdgpu:
- Bump driver version for GFX12 DCC
- DC documention warning fixes
- VCN unified queue power fix
- SMU fix
- RAS fix
- Display corruption fix
- SDMA 5.2 workaround
- GFX12 fixes
- Uninitialized variable fix
- VCN/JPEG 4.0.3 fixes
- Misc display fixes
- RAS fixes
- VCN4/5 harvest fix
- GPU reset fix

i915:
- Reset intel_dp->link_trained before retraining the link
- Don't switch the LTTPR mode on an active link
- Do not consider preemption during execlists_dequeue for gen8
- Allow NULL memory region

xe:
- xe_exec ioctl minor fix on sync entry cleanup upon error
- SRIOV: limit VF LMEM provisioning
- Wedge mode fixes

v3d:
- fix indirect dispatch on newer v3d revs

panel:
- fix panel backlight bindings
The following changes since commit 478a52707b0abe98aac7f8c53ccddb759be66b06=
:

  Merge tag 'amd-drm-next-6.11-2024-07-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2024-07-18
09:20:00 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-07-26

for you to fetch changes up to d4ef5d2b7ee0cbb5f2d864716140366a618400d6:

  Merge tag 'amd-drm-fixes-6.11-2024-07-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2024-07-26
09:52:15 +1000)

----------------------------------------------------------------
drm fixes for 6.11-rc1

amdgpu:
- Bump driver version for GFX12 DCC
- DC documention warning fixes
- VCN unified queue power fix
- SMU fix
- RAS fix
- Display corruption fix
- SDMA 5.2 workaround
- GFX12 fixes
- Uninitialized variable fix
- VCN/JPEG 4.0.3 fixes
- Misc display fixes
- RAS fixes
- VCN4/5 harvest fix
- GPU reset fix

i915:
- Reset intel_dp->link_trained before retraining the link
- Don't switch the LTTPR mode on an active link
- Do not consider preemption during execlists_dequeue for gen8
- Allow NULL memory region

xe:
- xe_exec ioctl minor fix on sync entry cleanup upon error
- SRIOV: limit VF LMEM provisioning
- Wedge mode fixes

v3d:
- fix indirect dispatch on newer v3d revs

panel:
- fix panel backlight bindings

----------------------------------------------------------------
Alex Deucher (2):
      drm/amd/display: fix corruption with high refresh rates on DCN 3.0
      drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell

Alex Hung (1):
      drm/amd/display: Add doc entry for program_3dlut_size

Ashutosh Dixit (1):
      drm/xe/exec: Fix minor bug related to xe_sync_entry_cleanup

Aurabindo Pillai (2):
      drm/amd: Bump KMS_DRIVER_MINOR version
      drm/amd/display: fix doc entry for bb_from_dmub

Boyuan Zhang (2):
      drm/amdgpu/vcn: identify unified queue in sw init
      drm/amdgpu/vcn: not pause dpg for unified queue

Dave Airlie (7):
      Merge tag 'drm-intel-next-fixes-2024-07-18' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-fixes-2024-07-18' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2024-07-19' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-fixes-6.11-2024-07-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2024-07-25' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2024-07-25' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-fixes-6.11-2024-07-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

David Belanger (1):
      drm/amdgpu: Fix atomics on GFX12

Imre Deak (2):
      drm/i915/dp: Reset intel_dp->link_trained before retraining the link
      drm/i915/dp: Don't switch the LTTPR mode on an active link

Jane Jian (1):
      drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF

Jonathan Cavitt (1):
      drm/i915: Allow NULL memory region

Li Ma (1):
      drm/amd/swsmu: enable Pstates profile levels for SMU v14.0.4

Lijo Lazar (2):
      drm/amdgpu: Add empty HDP flush function to JPEG v4.0.3
      drm/amdgpu: Add empty HDP flush function to VCN v4.0.3

Ma Ke (1):
      drm/amd/amdgpu: Fix uninitialized variable warnings

Matthew Brost (2):
      drm/xe: Wedge the entire device
      drm/xe: Don't suspend device upon wedge

Ma=C3=ADra Canal (2):
      drm/v3d: Add V3D tech revision to the device information
      drm/v3d: Fix Indirect Dispatch configuration for V3D 7.1.6 and later

Michal Wajdeczko (1):
      drm/xe/pf: Limit fair VF LMEM provisioning

Nitin Gote (1):
      drm/i915/gt: Do not consider preemption during execlists_dequeue for =
gen8

Rodrigo Siqueira (7):
      drm/amd/display: Move DIO documentation to the right place
      Documentation/gpu: Remove ':export:' option from DCN documentation
      Documentation/gpu: Adjust DCN documentation paths
      drm/amd/display: Add simple struct doc to remove doc build warning
      Documentation/gpu: Remove undocumented files from dcn-blockshubbub.h
      Documentation/amdgpu: Fix duplicate declaration
      drm/amd/display: Remove ASSERT if significance is zero in math_ceil2

Roman Li (1):
      drm/amd/display: Add function banner for idle_workqueue

Stanley.Yang (1):
      drm/amdgpu: Fix eeprom max record count

Stephan Gerhold (1):
      dt-bindings: display: panel: samsung,atna33xc20: Document ATNA45AF01

Sung Joon Kim (1):
      drm/amd/display: Check for NULL pointer

Tim Huang (2):
      drm/amd/pm: early return if disabling DPMS for GFX IP v11.5.2
      drm/amdgpu: add missed harvest check for VCN IP v4/v5

YiPeng Chai (2):
      drm/amdgpu: add mutex to protect ras shared memory
      drm/amdgpu: fix ras UE error injection failure issue

ZhenGuo Yin (1):
      drm/amdgpu: reset vm state machine after gpu reset(vram lost)

 .../bindings/display/panel/samsung,atna33xc20.yaml |   8 +-
 Documentation/gpu/amdgpu/display/dcn-blocks.rst    |  35 +-----
 .../gpu/amdgpu/display/display-manager.rst         |   4 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h             |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 121 ++++++++++++++---=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  53 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   9 +-
 drivers/gpu/drm/amd/amdgpu/df_v4_15.c              |  45 ++++++++
 drivers/gpu/drm/amd/amdgpu/df_v4_15.h              |  30 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |  27 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  12 ++
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |   4 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |   6 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |  54 ++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |   6 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |   6 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  17 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |   3 +-
 .../src/dml2_standalone_libraries/lib_float_math.c |   2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |  22 +++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |  14 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |  15 +++
 .../drm/amd/display/dc/link/hwss/link_hwss_dio.c   |  29 +++++
 .../drm/amd/display/dc/link/hwss/link_hwss_dio.h   |   9 --
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c |  15 +--
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |  10 ++
 .../drm/amd/include/asic_reg/df/df_4_15_offset.h   |  28 +++++
 .../drm/amd/include/asic_reg/df/df_4_15_sh_mask.h  |  28 +++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  16 +--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  18 ++-
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  55 ++++++++--
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   6 +-
 drivers/gpu/drm/i915/intel_memory_region.c         |   6 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |   5 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |   8 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  16 ++-
 drivers/gpu/drm/xe/xe_device.c                     |  20 ++++
 drivers/gpu/drm/xe/xe_exec.c                       |  14 +--
 drivers/gpu/drm/xe/xe_gt.c                         |  15 +++
 drivers/gpu/drm/xe/xe_gt.h                         |   1 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |   1 +
 drivers/gpu/drm/xe/xe_guc.c                        |  16 +++
 drivers/gpu/drm/xe/xe_guc.h                        |   1 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  38 ++++---
 drivers/gpu/drm/xe/xe_guc_submit.h                 |   1 +
 drivers/gpu/drm/xe/xe_uc.c                         |  14 +++
 drivers/gpu/drm/xe/xe_uc.h                         |   1 +
 56 files changed, 690 insertions(+), 197 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_15.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/df_v4_15.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_offset.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/df/df_4_15_sh_mask=
.h

