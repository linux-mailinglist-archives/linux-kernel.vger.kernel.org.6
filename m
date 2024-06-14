Return-Path: <linux-kernel+bounces-215514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE090940A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E71C21210
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A091850B3;
	Fri, 14 Jun 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/kt2/mZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFC1487ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402760; cv=none; b=tjW8riWRYv26sQ1DgDpls4MlTtxEFn6byvrq0cRXoA9VV/6yDe0AZ2m/BGbod40IFe9kfk0wjwXZc8R66TUMrOP99Kqu+Cg/v3a7nvOVsuB3mrMJT9L0tyXfbZX6DPueGTjlTE85Yny5PyLfVUId3ApLYpenxkVFv7prPki9bEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402760; c=relaxed/simple;
	bh=l+hkOlIOckNGSbjbSDsoJE132cFGlCp3v1uR5gDDpUA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SeXPcgeImfDgD1aPDwhometdNAgj/DFfm5xvH4msh/bQRuEq+FjD4U4r71A7ikJA6D7nz4i9bxcwKvPFbcXy23vcs33MZ5edbGqVANryYYQScnOA3tJnqUI7ko7o0bVAV4IH7ybztK4nTB6LJjDEZAoH0w4wk6cGQZ07H4zIdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/kt2/mZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso404712066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718402756; x=1719007556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9NKpnQ84zxi9g2DKsrp6paIKuEaCxz0JVSsufLK/lNo=;
        b=K/kt2/mZ2gCvHXr0eWntuXdB3UivroutgIjYZb6NSwNpMt5twn8hMsJ5L3GtSAieZL
         VDikTlLeF74Gy/zcl+9Zb7es5At4KEgpHNPFCWEEO+ORgvE759IoXCStfsw2mXeQONU7
         vMzUWKaMtLsrOfZ5S7e9UCXTD7om25oRni63Zo689DLKH44UvI936Pz/+XW5SWSiHHYt
         8YqcTqVmsPeTO8CwTwCYAm28eURRIGn65hufF46HvYytwEs+1yk7ouN2CFoeYM19dT+T
         TH2dZpUWDSlcApqgrZxFhyaPA+Zu5WCRxoslsJbsJ9dmWTZS9UsfSjSH0HgoZ8j8L39S
         XAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718402756; x=1719007556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NKpnQ84zxi9g2DKsrp6paIKuEaCxz0JVSsufLK/lNo=;
        b=C6uHPu2CCyfk2yhwfH21DeIBg/Ol/Gk8z0SRWwRj5B1LECJ+pwNczCXV9AAjzYOQrU
         TFTBEipnbrNec8uJcn2UVzJNsc0BFdJdkxzVYSMR5vQpW4vlQMjqI4SIwJRJCEzQAwx0
         nulq243MsEhfu16PdLPv0in3psvowWabzcHm0uDp+BLBxyQeXugDSpK4a1FJxds5tVdS
         +Rxm0X9isJS8+hrikKrp8fcac6x0IPaog4XQaK4pfwo3jIG4UGAHuSeQZTqMEmYcn/4h
         bvib4KHcSHoTwwPI2tvj7eZtccQZ3aBvB0XiLq2kLIDGTYJDGpQF4QrBwNgieIejodPX
         ZBqg==
X-Forwarded-Encrypted: i=1; AJvYcCWqdsOeCBusiO+cpnl3FVxprLg3q/m9zpg1IBBJEh3NQrsxHvc6wmDVwAevyJykil3Qb+XKlSmW2Cw5lmg8lMIwNOUo8DfFr+HaBwfq
X-Gm-Message-State: AOJu0YxKfXJR0pQEXklgjI5sUTzYzdgLrIGAXAjIG41pJOzzAy+NwM+F
	IAM04fCvqME2AEJx/XQQRJdigX6JJldmbexnm69B5U2JLXF7JAnqtQxSvtCxF3DOHoKBFgDSJoT
	1FQ59h+21mXpGAypOj8u/+y9dgLA=
X-Google-Smtp-Source: AGHT+IE+b6gM0omkmI2wHLa+MByqftBT92VyZN7nayii8T/REdVaTUWrLOvSqVsXzjNF0/QTWDMl4C/8m+idjGvgN50=
X-Received: by 2002:a17:906:c29a:b0:a6f:5698:ab61 with SMTP id
 a640c23a62f3a-a6f60cef734mr249722066b.11.1718402756064; Fri, 14 Jun 2024
 15:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 15 Jun 2024 08:05:44 +1000
Message-ID: <CAPM=9tw_3xzMPo46mPYfkPpnxy8jgeBy1Q5Ep1pH8Ws2BdA87g@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Weekly fixes pull, seems a little quieter than usual, but still a
bunch of stuff across the board. Mostly xe, some exynos and nouveau
fixes. There is the fixup for the WERROR that you pointed out
previously, hopefully it does what you expect now.

Dave.

drm-fixes-2024-06-15:
drm fixes for 6.10-rc4

core:
- Werror Kconfig fix

panel:
- add orientation quirk for Aya Neo KUN
- fix runtime warning on panel/bridge release

nouveau:
- remove unused struct
- fix wq crash on cards with no display

amdgpu:
- fix bo release clear page warning

xe:
- update MAINTAINERS
- Use correct forcewake assertions.
- Assert that VRAM provisioning is only done on DGFX.
- Flush render caches before user-fence signalling on all engines.
- Move the disable_c6 call since it was sometimes never called.

exynos:
- fix regression with fallback mode
- fix EDID related memory leak
- remove redundant code

komeda:
- fix debugfs conditional compilations
- check pointer error value

renesas:
- atomic shutdown fix

mediatek:
- atomic shutdown fix
The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670=
:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-15

for you to fetch changes up to 9f0a86492ac4de4d1db718986a91833fdc914a54:

  Merge tag 'drm-misc-fixes-2024-06-14' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2024-06-15 06:52:56 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc4

core:
- Werror Kconfig fix

panel:
- add orientation quirk for Aya Neo KUN
- fix runtime warning on panel/bridge release

nouveau:
- remove unused struct
- fix wq crash on cards with no display

amdgpu:
- fix bo release clear page warning

xe:
- update MAINTAINERS
- Use correct forcewake assertions.
- Assert that VRAM provisioning is only done on DGFX.
- Flush render caches before user-fence signalling on all engines.
- Move the disable_c6 call since it was sometimes never called.

exynos:
- fix regression with fallback mode
- fix EDID related memory leak
- remove redundant code

komeda:
- fix debugfs conditional compilations
- check pointer error value

renesas:
- atomic shutdown fix

mediatek:
- atomic shutdown fix

----------------------------------------------------------------
Adam Miotk (1):
      drm/bridge/panel: Fix runtime warning on panel bridge release

Amjad Ouled-Ameur (1):
      drm/komeda: check for error-valued pointer

Andrzej Hajda (1):
      drm/xe: flush engine buffers before signalling user fence on all engi=
nes

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Fix the BO release clear memory warning

Dave Airlie (3):
      Merge tag 'exynos-drm-fixes-for-v6.10-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-fixes
      Merge tag 'drm-xe-fixes-2024-06-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-06-14' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Douglas Anderson (2):
      drm: renesas: shmobile: Call drm_atomic_helper_shutdown() at shutdown=
 time
      drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time

Dr. David Alan Gilbert (1):
      drm/nouveau: remove unused struct 'init_exec'

Jani Nikula (2):
      drm: have config DRM_WERROR depend on !WERROR
      drm/exynos/vidi: fix memory leak in .get_modes()

Krzysztof Kozlowski (1):
      drm/exynos: dp: drop driver owner initialization

Marek Szyprowski (1):
      drm/exynos: hdmi: report safe 640x480 mode as a fallback when no
EDID found

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Michal Wajdeczko (1):
      drm/xe/pf: Assert LMEM provisioning is done only on DGFX

Oded Gabbay (1):
      MAINTAINERS: update Xe driver maintainers

Riana Tauro (2):
      drm/xe/xe_gt_idle: use GT forcewake domain assertion
      drm/xe: move disable_c6 call

Thomas Hellstr=C3=B6m (1):
      MAINTAINERS: Update Xe driver maintainers

Tobias Jakobi (1):
      drm: panel-orientation-quirks: Add quirk for Aya Neo KUN

Vasily Khoruzhick (1):
      drm/nouveau: don't attempt to schedule hpd_work on headless cards

pengfuyuan (1):
      arm/komeda: Remove all CONFIG_DEBUG_FS conditional compilations

 MAINTAINERS                                            |  2 +-
 drivers/gpu/drm/Kconfig                                |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c                |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c             |  2 --
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c        |  8 --------
 .../gpu/drm/arm/display/komeda/komeda_pipeline_state.c |  2 +-
 drivers/gpu/drm/bridge/panel.c                         |  7 +++++--
 drivers/gpu/drm/drm_panel_orientation_quirks.c         |  6 ++++++
 drivers/gpu/drm/exynos/exynos_dp.c                     |  1 -
 drivers/gpu/drm/exynos/exynos_drm_vidi.c               |  7 ++++++-
 drivers/gpu/drm/exynos/exynos_hdmi.c                   |  7 +++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                 |  8 ++++++++
 drivers/gpu/drm/nouveau/dispnv04/disp.c                |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c                |  2 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c                 |  5 -----
 drivers/gpu/drm/nouveau/nouveau_display.c              |  6 +++++-
 drivers/gpu/drm/nouveau/nouveau_drv.h                  |  1 +
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c       |  8 ++++++++
 drivers/gpu/drm/xe/xe_gt_idle.c                        |  9 ++++++++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c             | 15 +++++++++++++-=
-
 drivers/gpu/drm/xe/xe_guc_pc.c                         |  6 ------
 drivers/gpu/drm/xe/xe_ring_ops.c                       | 18 ++++++++++++++=
++--
 22 files changed, 87 insertions(+), 37 deletions(-)

