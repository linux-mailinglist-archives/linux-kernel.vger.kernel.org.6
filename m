Return-Path: <linux-kernel+bounces-526635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E792BA40161
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6163A9C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BC253326;
	Fri, 21 Feb 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZazHA5jc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991D1EE028
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171108; cv=none; b=gFYedKVbF7pHEOS0UuD45u+6/fpWgveIVkSaFRKomnp2zRk9gqUmxxIK9eol6TNIskViO1w6XzKBDdUOxbrMcYDU1U3L8K6uT5IN4pA7GIFEBULdL/IhV4rpH70yx6mw5hVKxHLw988KDWAUL+thTSvzmQTUIAC/m4+h3Ky5zC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171108; c=relaxed/simple;
	bh=lD9AXcjn0RZGhvHYTzO56i8eaPDx1JEByHYcHlBDOxY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nWNyj6ZwZYM6BDFCtHCwaOb4iq8KVSCB+1l6A/U+u6ZJSWodzX1/x7gyFF1o6wnlmg98Yt4MhwTTiMDX6dxjS/9OyaXX6gDpGub+T35HrDd0ZeYe0aj70UqsSlB8Y2vI1CU2LhRmOHpE+yJQLY55s4KqsQLmRJoVgw+kkVqM/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZazHA5jc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaedd529ba1so308965966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171104; x=1740775904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x96f1GfMBe0SzhF3gidD9+1z7xQuC/mzsHXfqU7tA9M=;
        b=ZazHA5jcoKLl+BNUM08QK6s3dewEgaRHkEADo3T67bCcnBgphT9Sxbc/Wy7shc0i4Y
         Sd3snmUYKeRzb2DA8r+WGbz+4TG/SG8MjzyGh0CzWwkaxflv/PG0A2WMrZBz2enQYz/X
         qGeaWThEoN3z8InKOq8YHLjmCPf/p//qMZaZdVobKzcKuvEQ0yRFZnxk8y7JpJpZLfNQ
         L0Tv/q5y2QVIRADqed3JVZbqRiwQjDo11Rrl84zyzmF0ShbURqpVfK1bsn5h7CF2rEzW
         cQyWDN0gxQVvOvli4Qnd3RqQgTqepChEETu0QHkNBnsb666ya5i5RRmgvnqHkVCLkxTH
         IRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171104; x=1740775904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x96f1GfMBe0SzhF3gidD9+1z7xQuC/mzsHXfqU7tA9M=;
        b=S5oNKO6hYPIet+u50LdOjsHCuZYmwyjW8KLwoRpCoU3t1kyL7hDlxpx2/G+I1rwihW
         RQxf8M7FCi/mOpNL6OSjR4S4V3EDUhREXUJKZQNZz0cxriYzLHn695iywXvIRfNRlM9E
         UEZCX9Cqgd6W+1MVyBTHicogfDbDj6ZpyCI78SnVRjEAUlAUUfItKITyaugPX5S/dd3H
         /ce7j3gxtyfg/YJwiLxdfJGswjG5YCGbOyOqa9U/EXvgUWRJ8Ka+cALkxmnRYvzV5o0/
         iihXeAKdnLurDEuw6jeUs79YPF79GHZv0C1iDKMB6CMiJMjq/m/UH/WWPP8SB4ug0DTt
         tpKA==
X-Forwarded-Encrypted: i=1; AJvYcCVhUGUGnqq31TzeVnhDWKYlnf17YWkXpId0VRjcOBeBdR0Oq3R3/W8Hm/VlsDBvYsnJ3T0417V9QfjbpJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4eRPoFl2upsZNx2iKos2DsiHhutmeU8CJZ/fxZhRuBMxwnVs8
	J67lOwyViAsjmQBOMeOCYToCfJvW2EY+KYCKyFc61fG9X0n3PiaSTmsFdTcJV446I2qVBJ/aEeG
	o6PSdPKShUAqwYHthRhABAt8nBDdBMyh5
X-Gm-Gg: ASbGncsAgWbtwvF9ue0ZnFjOz1iJl453jgFiUWrl7kzDD7SNBsBMVf6I9CfnOs1SuU+
	5aLl4X/F8dHpgmg85CH5SZifu2w6mQu679Fim4hyK5hfFU9eirPEIfWF7R3uvWppYVv4TyeKCNB
	7BzSwFig==
X-Google-Smtp-Source: AGHT+IEBIM3w/S/4VXusmbdzIx6RtxGNJF3Zb9ZxCF2ectBaJO4SRI3P29mXck8mE014TqAR9asMcjXvZEJGv/MBQe0=
X-Received: by 2002:a05:6402:2350:b0:5de:a6a8:5ec6 with SMTP id
 4fb4d7f45d1cf-5e0b70f0872mr9828315a12.10.1740171104188; Fri, 21 Feb 2025
 12:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 22 Feb 2025 06:51:33 +1000
X-Gm-Features: AWEUYZlHT0KIW6LET21wCc2AX_ISkd6d3ZxA2cwyAdI4KGn4QmjXCgDhU4YQ-2Q
Message-ID: <CAPM=9tyHJiMrF8nxXe=mhn0i5N1v-7RHh2TZfoz8BoUBBnuxzw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.14-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly drm fixes pull request, lots of small things all over, msm has
a bunch of things but all very small, xe, i915, a fix for the cgroup
dmem controller.

Thanks,
Dave.

drm-fixes-2025-02-22:
drm fixes for v6.14-rc4

core:
- remove MAINTAINERS entry

cgroup/dmem:
- use correct function for pool descendants

panel:
- fix signal polarity issue jd9365da-h3

nouveau:
- folio handling fix
- config fix

amdxdna:
- fix missing header

xe:
- Fix error handling in xe_irq_install
- Fix devcoredump format

i915:
- Use spin_lock_irqsave() in interruptible context on guc submission
- Fixes on DDI and TRANS programming
- Make sure all planes in use by the joiner have their crtc included
- Fix 128b/132b modeset issues

msm:
- More catalog fixes:
- to skip watchdog programming through top block if its not present
- fix the setting of WB mask to ensure the WB input control is programmed
  correctly through ping-pong
- drop lm_pair for sm6150 as that chipset does not have any 3dmerge block
- Fix the mode validation logic for DP/eDP to account for widebus (2ppc)
  to allow high clock resolutions
- Fix to disable dither during encoder disable as otherwise this was
  causing kms_writeback failure due to resource sharing between
  WB and DSI paths as DSI uses dither but WB does not
- Fixes for virtual planes, namely to drop extraneous return and fix
  uninitialized variables
- Fix to avoid spill-over of DSC encoder block bits when programming
  the bits-per-component
- Fixes in the DSI PHY to protect against concurrent access of
  PHY_CMN_CLK_CFG regs between clock and display drivers
- Core/GPU:
- Fix non-blocking fence wait incorrectly rounding up to 1 jiffy timeout
- Only print GMU fw version once, instead of each time the GPU resumes
The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319=
:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-22

for you to fetch changes up to 9a1cd7d6df5d708ef244f93715855c8e54d79448:

  Merge tag 'drm-msm-fixes-2025-02-20' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2025-02-21
10:50:29 +1000)

----------------------------------------------------------------
drm fixes for v6.14-rc4

core:
- remove MAINTAINERS entry

cgroup/dmem:
- use correct function for pool descendants

panel:
- fix signal polarity issue jd9365da-h3

nouveau:
- folio handling fix
- config fix

amdxdna:
- fix missing header

xe:
- Fix error handling in xe_irq_install
- Fix devcoredump format

i915:
- Use spin_lock_irqsave() in interruptible context on guc submission
- Fixes on DDI and TRANS programming
- Make sure all planes in use by the joiner have their crtc included
- Fix 128b/132b modeset issues

msm:
- More catalog fixes:
- to skip watchdog programming through top block if its not present
- fix the setting of WB mask to ensure the WB input control is programmed
  correctly through ping-pong
- drop lm_pair for sm6150 as that chipset does not have any 3dmerge block
- Fix the mode validation logic for DP/eDP to account for widebus (2ppc)
  to allow high clock resolutions
- Fix to disable dither during encoder disable as otherwise this was
  causing kms_writeback failure due to resource sharing between
  WB and DSI paths as DSI uses dither but WB does not
- Fixes for virtual planes, namely to drop extraneous return and fix
  uninitialized variables
- Fix to avoid spill-over of DSC encoder block bits when programming
  the bits-per-component
- Fixes in the DSI PHY to protect against concurrent access of
  PHY_CMN_CLK_CFG regs between clock and display drivers
- Core/GPU:
- Fix non-blocking fence wait incorrectly rounding up to 1 jiffy timeout
- Only print GMU fw version once, instead of each time the GPU resumes

----------------------------------------------------------------
Aaron Kling (1):
      drm/nouveau/pmu: Fix gp10b firmware guard

Abhinav Kumar (1):
      drm/msm/dp: account for widebus and yuv420 during mode validation

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2025-02-20' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-02-20' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-02-20' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-msm-fixes-2025-02-20' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

David Hildenbrand (1):
      nouveau/svm: fix missing folio unlock + put after
make_device_exclusive_range()

Dmitry Baryshkov (3):
      drm/msm/dpu: skip watchdog timer programming through TOP on >=3D SM84=
50
      drm/msm/dpu: enable DPU_WB_INPUT_CTRL for DPU 5.x
      drm/msm/dpu: correct LM pairing for SM6150

Ethan Carter Edwards (1):
      drm/msm/dpu: Fix uninitialized variable

Friedrich Vock (1):
      cgroup/dmem: Don't open-code css_for_each_descendant_pre

Hugo Villeneuve (1):
      drm: panel: jd9365da-h3: fix reset signal polarity

Imre Deak (4):
      drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
      drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
      drm/i915/dp: Fix error handling during 128b/132b link training
      drm/i915/dp: Fix disabling the transcoder function in 128b/132b mode

Jessica Zhang (2):
      drm/msm/dpu: Disable dither in phys encoder cleanup
      drm/msm/dpu: Drop extraneous return in dpu_crtc_reassign_planes()

Jos=C3=A9 Roberto de Souza (1):
      drm/xe: Make GUC binaries dump consistent with other binaries in
devcoredump

Karol Herbst (1):
      MAINTAINERS: Remove myself

Konrad Dybcio (1):
      drm/msm/a6xx: Only print the GMU firmware version once

Krzysztof Karas (1):
      drm/i915/gt: Use spin_lock_irqsave() in interruptible context

Krzysztof Kozlowski (3):
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG0 updated from driver side
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG1 against clock driver
      drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1 when choosing
bitclk source

Lucas De Marchi (2):
      drm/xe: Fix error handling in xe_irq_install()
      drm/xe/guc: Fix size_t print format

Marijn Suijten (1):
      drm/msm/dpu: Don't leak bits_per_component into random DSC_ENC fields

Rob Clark (1):
      drm/msm: Avoid rounding up to one jiffy

Su Hui (1):
      accel/amdxdna: Add missing include linux/slab.h

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Make sure all planes in use by the joiner have their
crtc included

 MAINTAINERS                                        |  2 -
 drivers/accel/amdxdna/amdxdna_mailbox.c            |  1 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |  4 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  8 ++--
 drivers/gpu/drm/i915/display/intel_display.c       | 18 ++++++++
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 15 +++++-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  4 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  8 ++--
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  2 +-
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  2 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h |  2 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  3 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  7 ++-
 drivers/gpu/drm/msm/dp/dp_display.c                | 11 +++--
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  5 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          | 53 +++++++++++++++---=
----
 drivers/gpu/drm/msm/msm_drv.h                      | 11 ++---
 .../gpu/drm/msm/registers/display/dsi_phy_7nm.xml  | 11 ++++-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |  9 +++-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c    |  2 +-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   |  8 ++--
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  6 ++-
 drivers/gpu/drm/xe/xe_guc_log.c                    |  3 +-
 drivers/gpu/drm/xe/xe_irq.c                        | 14 +-----
 kernel/cgroup/dmem.c                               | 50 +++++-------------=
--
 30 files changed, 146 insertions(+), 124 deletions(-)

