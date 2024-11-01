Return-Path: <linux-kernel+bounces-392781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51069B980B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE37B21278
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FE1CEE80;
	Fri,  1 Nov 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHB5SwDN"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D214B955
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487907; cv=none; b=QvPFN5JUzqbS56QsLj90UA6eqS2UL0f9OyMFZWKUnIbNvlSpyyGzQMl3qofHUbBmYAxra1aVEsE2DJSnqoNqBIv+pM5xsZduWfqkIvirU1n4USlwb8BRdzcFtEufLhKHr/tdyuiWYtdm7+x42tSvnTg9qYWxGGkJTuPcaz6q3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487907; c=relaxed/simple;
	bh=CJP2QIGMftOi/qql5FNEZPDPwqRsagEaH2yTt/bd5Po=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fNjMnzRBfN/Ykc/0e4Eyoih5J3931yGZac5bYRtP0LLci7BkBug65eMzt9+z4hS0u9bf3L0oZ/4yQ0YMLkH/L+x+0z/ep+J2HYybHeqgl3kO5nkGzHnYWB8iAFr4BAIJ/eb3S/A5X4Y4KGA9Z+7cZMkLBnzE8y0apV43v+YaZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHB5SwDN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cec8c4e2f6so203230a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730487900; x=1731092700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Po6d0vKxLdO7pwjS43uJ8mMLBhaRpS3FlzyZbdeogh0=;
        b=gHB5SwDNpfvimV+TdnfF8ggtWGsCInMIMhikUi5UlkBh7ct89ani4MGjjlMWgjj8uy
         A/qFwc5TIxgasKqyP0/4V/1RVD7PgYqWsYeag7BmjBo7SH3j0Mw693iDNX1yu8aMcuFs
         eoOBfy0NBpSfdi68KJiOT4wMNX7OLrBrJGbKPRl8NrQLvahrUQLLi8jx7MpRmFDw7rPZ
         BW1s1nBE5WmMGyvg8doeuY9yKhbAudlQQosxW0XEIN6lYjKa8gwcBIy4Ot6OdEfo2uT0
         s07eSaZ/LQdjOxg9Nf4PbLmo28XBjUhwyJAvNUrOVDbtfFG80C6Ewn8OHxWfjnIY/HL9
         wkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487900; x=1731092700;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Po6d0vKxLdO7pwjS43uJ8mMLBhaRpS3FlzyZbdeogh0=;
        b=QYWLcBiprW879QxggxLLRwpgdeIuq5oeiTE5qI8CLTf3lcRbzcN855fASX6IY7BfC6
         8e7lpy3NwockNhk1IF4PoAwgsrz5JTt83KogSyIlE3G27BWnUIrhLvMAmZtfol4tEZ9Z
         ytp7E/26g+nit7WrypqLUXSkLspcF+kZON8cLvmd0xPAf5CrlyN3rK+pLxKa2IODaqxo
         2B+TKZt4HJYtSlRK0eDEqchuZFE+0Pb6zm9y2uWe3S/OPIwmnLpveSi+VrOz8zO54958
         uyeeJw+v2/o+B/z56O5xGdVyLMQ6i+aV2787msoXw7pfupI4u+lLcBmlF4obdSQnpXvK
         JE2A==
X-Forwarded-Encrypted: i=1; AJvYcCXWTSVjGaKREsYxQAPh14iGuYqndGB+Ssvpugv0ywYdAvuFeK00qzQ3GN+8+zCD0Zg2kLYbxUopTSJqHnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9GR+JgBylXdiKqdqf3PbKKrnHwDi5wxS5ITbHxYFmTMsDBzR
	bqL+buPH3kh2iwDspig8AejQfVtX2FlCWsWvIYQm4h3FjnNUSjXT6nQVzI0tW9rTKhpfg7aHsF1
	bBZo3F1dUmEEgUmF+OpdL6NJacUA=
X-Google-Smtp-Source: AGHT+IH6PM1liYSO7moMOes+IZEnj/BLvyNO2FkOyxZ2n3b7UwW3d7ynYQOX7iVUFj4chQM+C+t8umkIqIo9sBEzB9E=
X-Received: by 2002:a05:6402:13cc:b0:5cb:6672:fbbe with SMTP id
 4fb4d7f45d1cf-5ceb9381fa8mr3529903a12.30.1730487900038; Fri, 01 Nov 2024
 12:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 2 Nov 2024 05:04:48 +1000
Message-ID: <CAPM=9tywoHB87EmV5CYripW2A2gVBg2dMTM-+gv_xbxOK3EQ=Q@mail.gmail.com>
Subject: [git pull] drm fixes for 6.12-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Regular fixes pull, nothing too out of the ordinary, the mediatek
fixes came in a batch that I might have preferred a bit earlier but
all seem fine, otherwise regular xe/amdgpu and a few misc ones.

Dave.

drm-fixes-2024-11-02:
drm fixes for 6.12-rc6

xe:
- Fix missing HPD interrupt enabling, bringing one PM refactor with it
- Workaround LNL GGTT invalidation not being visible to GuC
- Avoid getting jobs stuck without a protecting timeout

ivpu:
- Fix firewall IRQ handling

panthor:
- Fix firmware initialization wrt page sizes
- Fix handling and reporting of dead job groups

sched:
- Guarantee forward progress via WC_MEM_RECLAIM

tests:
- Fix memory leak in drm_display_mode_from_cea_vic()

amdgpu:
- DCN 3.5 fix
- Vangogh SMU KASAN fix
- SMU 13 profile reporting fix

mediatek:
- Fix degradation problem of alpha blending
- Fix color format MACROs in OVL
- Fix get efuse issue for MT8188 DPTX
- Fix potential NULL dereference in mtk_crtc_destroy()
- Correct dpi power-domains property
- Add split subschema property constraints
The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-11-02

for you to fetch changes up to f99c7cca2f712d11a67148cfbe463fdefeb82dc5:

  Merge tag 'drm-xe-fixes-2024-10-31' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-11-02 04:44:27 +1000)

----------------------------------------------------------------
drm fixes for 6.12-rc6

xe:
- Fix missing HPD interrupt enabling, bringing one PM refactor with it
- Workaround LNL GGTT invalidation not being visible to GuC
- Avoid getting jobs stuck without a protecting timeout

ivpu:
- Fix firewall IRQ handling

panthor:
- Fix firmware initialization wrt page sizes
- Fix handling and reporting of dead job groups

sched:
- Guarantee forward progress via WC_MEM_RECLAIM

tests:
- Fix memory leak in drm_display_mode_from_cea_vic()

amdgpu:
- DCN 3.5 fix
- Vangogh SMU KASAN fix
- SMU 13 profile reporting fix

mediatek:
- Fix degradation problem of alpha blending
- Fix color format MACROs in OVL
- Fix get efuse issue for MT8188 DPTX
- Fix potential NULL dereference in mtk_crtc_destroy()
- Correct dpi power-domains property
- Add split subschema property constraints

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/smu13: fix profile reporting

Andrzej Kacprowski (1):
      accel/ivpu: Fix NOC firewall interrupt handling

Boris Brezillon (3):
      drm/panthor: Fix firmware initialization on systems with a page size > 4k
      drm/panthor: Fail job creation when the group is dead
      drm/panthor: Report group as timedout when we fail to properly suspend

Dan Carpenter (2):
      drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
      drm/tegra: Fix NULL vs IS_ERR() check in probe()

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2024-10-31' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.12-2024-10-31' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'mediatek-drm-fixes-20241028' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-xe-fixes-2024-10-31' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Hsin-Te Yuan (1):
      drm/mediatek: Fix color format MACROs in OVL

Imre Deak (2):
      drm/xe/display: Separate the d3cold and non-d3cold runtime PM handling
      drm/xe/display: Add missing HPD interrupt enabling during
non-d3cold RPM resume

Jason-JH.Lin (5):
      drm/mediatek: ovl: Fix XRGB format breakage for blend_modes
unsupported SoCs
      drm/mediatek: ovl: Refine ignore_pixel_alpha comment and placement
      drm/mediatek: ovl: Remove the color format comment for ovl_fmt_convert()
      drm/mediatek: ovl: Add blend_modes to driver data
      drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs

Jinjie Ruan (3):
      drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()
      drm/connector: hdmi: Fix memory leak in drm_display_mode_from_cea_vic()
      drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()

Liankun Yang (1):
      drm/mediatek: Fix get efuse issue for MT8188 DPTX

Maarten Lankhorst (1):
      drm/xe: Remove runtime argument from display s/r functions

Macpaul Lin (1):
      dt-bindings: display: mediatek: dpi: correct power-domains property

Matthew Brost (3):
      drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM
      drm/xe: Add mmio read before GGTT invalidate
      drm/xe: Don't short circuit TDR on jobs not started

Moudy Ho (1):
      dt-bindings: display: mediatek: split: add subschema property constraints

Ovidiu Bunea (1):
      Revert "drm/amd/display: update DML2 policy
EnhancedPrefetchScheduleAccelerationFinal DCN35"

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Tvrtko Ursulin (1):
      drm/amd/pm: Vangogh: Fix kernel memory out of bounds write

 .../bindings/display/mediatek/mediatek,dpi.yaml    | 24 +++---
 .../bindings/display/mediatek/mediatek,split.yaml  | 19 +++++
 drivers/accel/ivpu/ivpu_debugfs.c                  |  9 +++
 drivers/accel/ivpu/ivpu_hw.c                       |  1 +
 drivers/accel/ivpu/ivpu_hw.h                       |  1 +
 drivers/accel/ivpu/ivpu_hw_ip.c                    |  5 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c  |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  6 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                |  4 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c            |  2 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h            | 10 +++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h            |  2 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            | 74 ++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c    |  7 ++
 drivers/gpu/drm/mediatek/mtk_dp.c                  | 85 +++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_ethdr.c               |  7 ++
 drivers/gpu/drm/mediatek/mtk_ethdr.h               |  1 +
 drivers/gpu/drm/mediatek/mtk_plane.c               | 15 ++--
 drivers/gpu/drm/mediatek/mtk_plane.h               |  4 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |  4 +-
 drivers/gpu/drm/panthor/panthor_gem.c              | 11 ++-
 drivers/gpu/drm/panthor/panthor_mmu.c              | 16 +++-
 drivers/gpu/drm/panthor/panthor_mmu.h              |  1 +
 drivers/gpu/drm/panthor/panthor_sched.c            | 20 ++++-
 drivers/gpu/drm/scheduler/sched_main.c             |  5 +-
 drivers/gpu/drm/tegra/drm.c                        |  4 +-
 drivers/gpu/drm/tests/drm_connector_test.c         | 24 +++---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  8 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c          | 42 +++++++++++
 drivers/gpu/drm/xe/display/xe_display.c            | 71 +++++++++++-------
 drivers/gpu/drm/xe/display/xe_display.h            |  8 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       | 10 +++
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 18 +++--
 drivers/gpu/drm/xe/xe_pm.c                         |  6 +-
 include/drm/drm_kunit_helpers.h                    |  4 +
 36 files changed, 412 insertions(+), 121 deletions(-)

