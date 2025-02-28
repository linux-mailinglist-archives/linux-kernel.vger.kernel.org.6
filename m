Return-Path: <linux-kernel+bounces-537672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585CA48EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFA01891B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443618C02E;
	Fri, 28 Feb 2025 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDJuGO24"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8E17A2F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712231; cv=none; b=H35g0fKlOtT7CbPJgubk49SeI7hWFBuDl/6rvo0pccOYzsR9vKBziye9LqmFfW6Dm/oH8a3RFgYCmcVhWX46vG1f1vXfs6Cyp8ZVB4z2Gp+WxYyGU68Tr6jqLeKUnEXbhTRk/hVX3Sq+D3YVfpghSzj63DH0dTGU1ylscTZhx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712231; c=relaxed/simple;
	bh=sIOpBYfJ+kfPOfd140+zope7zVgTf4C2UnuzvIJBpkY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rlVs9QIcpuFQZvouukxlFnQoh2YLlgHu4hVxqOwb9K+zoeKz6ST/hTTua/0icBYRimju5AZvW9MXKguk2xBrhyo7nUKaVWhgaOSursAKaPUaWnNuNbOqPvcGwkA/58xXxKGTC6CTW1/fRl3nxhjXzTP6MelXIJagf5LCpTICDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDJuGO24; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb81285d33so316780266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740712228; x=1741317028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dR5kvLhrP5a254wV2DQO0tyOX2xPxb7vk5FR9eMet5I=;
        b=TDJuGO24QCP/gXafJ9k2AzH8tJNg3HIqqZtnD8aS4GHa/mt5+qop+zegCJ97M75XmS
         HAy24+QcfcAEHukMUwFkLkryH3yPK1aCOO5DMZLysGTuu45n8cGcmJadL0fMYOpWwZxV
         PSh9v1iP3oGbYCndpIP0bBHWd13Npc+r2CjPAQ4kO72tkBmDUazQ70H8zgGVUMy2AQpJ
         FIgTci/4ihu4hjmLyBHje11QDHb8Rz/J3nglBOGp4j7U+OoxAKy0oBqUgbMIsGWGoZWC
         OIdzrM4HPj9ivltXU4sImReykNq6oEz0XzOq+Uz1M7cRS7ZXAysWDjS0HB2YdtUd7pEW
         6Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740712228; x=1741317028;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR5kvLhrP5a254wV2DQO0tyOX2xPxb7vk5FR9eMet5I=;
        b=ZYgOe1rGMkyShFT5l3Z6NJgurs4ZZQBw9Cfde8CWF2LvpKiIhzXc6aZ8T8MMUFVTEn
         Tp/Di2qT/SnP/68Q7uVE32IhaJzX2s4pFFsm0WTsaq4h6x0iLYDYzEaa0NjCOh+Kae7V
         S6s9pfZaDA4vGcVvn/NDPb6OOeS8kyeI1aqSgQTF6AwWXwM3bFh2KZIQ5xWkP3h5rdcZ
         K7eNgA6u0fuGjoYvZxZ6gWEC06B0ROesB/bis3EGPvBg24XMY8OVOROHJWfIF/K6/gfT
         LQNuVYKhEhcAOaqaQl2EuQ5iWG3ShTtLB5HlB1MGeGNhTihgH5hhUEGZF1e2UoY0p7tp
         ZXpw==
X-Forwarded-Encrypted: i=1; AJvYcCVzaxGCiplge7rwnm3l9JKIgy02STOIKk//NlEl4LoP55V8UPiWiA8Plc8dmmPcOAXXSj9TQ27sNtdUleA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPy6H8oklfIYZ36tPEWzitOlANAbmP1kHOOUK2qeVwN6uXt6e
	e0XouQuPB6pklaUHwquhGGBuQN15VJc2iYQgSQ/nDMbMxTbqBP5fHMtqIIodQD73vzBtjyN5KDB
	rJdQowc0wqTyUsCa2hlARX4sGhOY=
X-Gm-Gg: ASbGncuw/z8uDHYe+JyYpFtSVxXPN7GO0YIwp0s0dDM7zxXQwX77aCrcU79QYk1YUG5
	acJe9bBwkfLmoF4RKv3BQPcpDSOTWfedC07ohcMVAzaStZ7l0OHMAE8kgDt/Ech6dMLuYO9fa28
	uW7v5xDw==
X-Google-Smtp-Source: AGHT+IF5FDia1S0yddEgQ8TKsm3JENQUPPmxA3vJfmHNYPcSRkT7h5GfkDJLwseuptXBBJry8MULMowpRZQBixHxSCg=
X-Received: by 2002:a17:907:d8a:b0:ab7:b072:8481 with SMTP id
 a640c23a62f3a-abf265ce47bmr158044966b.45.1740712227677; Thu, 27 Feb 2025
 19:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 28 Feb 2025 13:10:16 +1000
X-Gm-Features: AQ5f1JoL4X2aIUXy2QZ8GfJ_quTK_ODi4bnubCGIy0X0uFyQe7-QzYQKpJNZymU
Message-ID: <CAPM=9tzCwv8Uhq9BzwMJ_rQoxEBAEFDQzcFJms=cmD9Njrd3hw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.14-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This week's fixes pull, amdgpu mostly, with some xe and a few misc
others, the fb defio fix is bit of a change, but it avoids some nasty
NULL pointer crashes due to defio assuming page backing in places it
didn't have pages.

Regards,
Dave.

drm-fixes-2025-02-28:
drm fixes for 6.14-rc5

amdgpu:
- Legacy dpm suspend/resume fix
- Runtime PM fix for DELL G5 SE
- MAINTAINERS updates
- Enforce Isolation fixes
- mailmap update
- EDID reading i2c fix
- PSR fix
- eDP fix
- HPD interrupt handling fix
- Clear memory fix

amdkfd:
- MQD handling fix

vkms:
- fix rounding error

imagination:
- header fix

nouveau:
- connector status fix

fb/defio:
- NULL ptr fix for defio drivers

i915:
- Fix encoder HW state readout for DP UHBR MST

xe:
- OA uapi fix (Umesh)
- Userptr related fixes
- Remove a duplicated register entry
- Scheduler related fix to prevent exec races when freeing it
The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-28

for you to fetch changes up to 6a5884f200693eeffac4b008faf1e8bdf1c92af5:

  Merge tag 'drm-xe-fixes-2025-02-27' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-02-28 10:47:09 +1000)

----------------------------------------------------------------
drm fixes for 6.14-rc5

amdgpu:
- Legacy dpm suspend/resume fix
- Runtime PM fix for DELL G5 SE
- MAINTAINERS updates
- Enforce Isolation fixes
- mailmap update
- EDID reading i2c fix
- PSR fix
- eDP fix
- HPD interrupt handling fix
- Clear memory fix

amdkfd:
- MQD handling fix

vkms:
- fix rounding error

imagination:
- header fix

nouveau:
- connector status fix

fb/defio:
- NULL ptr fix for defio drivers

i915:
- Fix encoder HW state readout for DP UHBR MST

xe:
- OA uapi fix (Umesh)
- Userptr related fixes
- Remove a duplicated register entry
- Scheduler related fix to prevent exec races when freeing it

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: disable BAR resize on Dell G5 SE
      MAINTAINERS: update amdgpu maintainers list
      drm/amdgpu/gfx: only call mes for enforce isolation if supported
      drm/amdgpu/mes: keep enforce isolation up to date

Aurabindo Pillai (1):
      MAINTAINERS: Update AMDGPU DML maintainers info

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.14-2025-02-26' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2025-02-27' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-02-27' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-02-27' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David Yat Sin (1):
      drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd

Harry Wentland (1):
      drm/vkms: Round fixp2int conversion in lerp_u16

Imre Deak (1):
      drm/i915/dp_mst: Fix encoder HW state readout for UHBR MST

Maarten Lankhorst (1):
      MAINTAINERS: Add entry for DMEM cgroup controller

Masahiro Yamada (1):
      drm/imagination: remove unnecessary header include path

Matthew Auld (2):
      drm/xe/userptr: restore invalidation list on error
      drm/xe/userptr: fix EFAULT handling

Melissa Wen (1):
      drm/amd/display: restore edid reading from a given i2c adapter

Mingcong Bai (1):
      drm/xe/regs: remove a duplicate definition for RING_CTL_SIZE(size)

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: init return value in amdgpu_ttm_clear_buffer

Rodrigo Siqueira (2):
      MAINTAINERS: Change my role from Maintainer to Reviewer
      mailmap: Add entry for Rodrigo Siqueira

Roman Li (1):
      drm/amd/display: Fix HPD after gpu reset

Tejas Upadhyay (1):
      drm/xe: cancel pending job timer before freeing scheduler

Thomas Zimmermann (2):
      drm/nouveau: Do not override forced connector status
      drm/fbdev-dma: Add shadow buffering for deferred I/O

Tom Chung (1):
      drm/amd/display: Disable PSR-SU on eDP panels

Umesh Nerlige Ramappa (1):
      drm/xe/oa: Allow oa_exponent value of 0

Yilin Chen (1):
      drm/amd/display: add a quirk to enable eDP0 on DP1

chr[] (1):
      amdgpu/pm/legacy: fix suspend/resume issues

 .mailmap                                           |   3 +
 MAINTAINERS                                        |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  86 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  14 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   3 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |  25 ++-
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c     |   8 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  26 ++-
 drivers/gpu/drm/drm_fbdev_dma.c                    | 217 +++++++++++++++------
 drivers/gpu/drm/i915/display/intel_ddi.c           |   9 +-
 drivers/gpu/drm/imagination/Makefile               |   2 -
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   1 -
 drivers/gpu/drm/vkms/vkms_composer.c               |   2 +-
 drivers/gpu/drm/xe/regs/xe_engine_regs.h           |   1 -
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   2 +
 drivers/gpu/drm/xe/xe_oa.c                         |   5 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  40 +++-
 28 files changed, 407 insertions(+), 124 deletions(-)

