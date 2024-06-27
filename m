Return-Path: <linux-kernel+bounces-233159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7068F91B30C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8211F239E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8D1A38C0;
	Thu, 27 Jun 2024 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTfnornY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DC13E04F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532703; cv=none; b=RWTPvagPTWCCpi7wY8pXaFue2TL4s9y6O3ksYVHCMU9XcCljrNHbpPbqTKyMIyggke5MZtfuXc9AKq5Msf2hSNLntJODi+OM/+zVU3PQBounr9daWiOprJuOnx3Psk0+1mnCdFyoy9Z+Tt1j5lFi7k7w3MemdUARPxdGWkwc8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532703; c=relaxed/simple;
	bh=UFc/fiNTjZgg1CcIjQWWOQRdnQM2dgAOGLd9mvVP+zo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QoNmp9bsywC2HPn6JuekB3zU9sxRV0c3ISqRVFLzy87498rQ0BsXaVfwzXOcTZwo+td6Yb9bERmG6hlPsKw1WL0wU/laBgJhOrau3vwaApoauvSVGxwfn/DmC28uUKc79H378XjsrU6+7WbrcnF1RgcIYBhra/Ki2ANFxKWHHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTfnornY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72517e6225so4639866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719532700; x=1720137500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Os/l/7RjSLQRoODmoguN2V2Kljaci69+SAiWEDn+JaI=;
        b=iTfnornYmbv+pUOqK9AdpksanI32CFSMLKEDGjzidMICrQGhhB131DLxwJHoBnS3L8
         oz9067WYhYnPKasi5gIfE2+uhLXCyl2Ja2Fk0BMecCKyUYjUZhLaCDoYpRDtnwursUMj
         GDl1WzQijnttsG6HvLdGD1nFJ06ApjwGxTv/3w4jNK45DCEMRkjeQHQrw1ATmplSwo1p
         bMd7Fdr/lPl5UQhvGbGW5VQ0uQfxeuQ5PFk+5UEbh5oJtECxogOHdPMVpSvGcJo9TzLy
         Ovo2+vJBPIWg2FoBW9MXSxwfdTPlXGrsAhdzjc3vWURnIFEu2uU7IZafTClpLZQ4ELdf
         s2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719532700; x=1720137500;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Os/l/7RjSLQRoODmoguN2V2Kljaci69+SAiWEDn+JaI=;
        b=NdVhiPaTpI05LD8rDkvcHEzCKWMy3lLhud/D77BJIsKGzThtAE5CmLRQydxxpY0vC7
         Bdjg9Pa8r1gn2cftcKXBZTyuwcKI/xHYOSMbQWL13elYUpnVGgexCHT/oNDtHvLbvHDP
         sxH1s6sC3m4g/E6TdL1Km3mMaJ7djKdaaTuBNU4rJ2/2IziQ73EAdRzREoUCfwu5QQHp
         +dMrSmFX0+8kDChiuEBhqwGmk9x6YLHdjaE5d66rJP6+lPOqFjB3n3i/EwL8GJdfhMNI
         qt1O4Vr7dgNUY8007fYN7A1DYvneBx58WrE9cyI8U2J4x5INYv6KuTYEDQvf0IKpPyfw
         Tmbw==
X-Forwarded-Encrypted: i=1; AJvYcCXIwbiv9Wn5Rlo7dp5ur0iTDCReHjsx6jeqCQALEQuRuzZuX+Si7CyMfVk+yJ3HYx3HIfM/9dSpQA39gTVv4rT9jXbbhnjGuIfT9dFf
X-Gm-Message-State: AOJu0YzsQ/C40i6DkvYgAGW/WJvfl1VPrEEtuRWnVKgodVpJ94RBg4Rg
	76JmxxMP6JjF89qD5Fmuh4VfWnGEKj+aKH/kz9VkzkTIL4w6V9K2mYfg2x3O4Rs58o8GkojioIz
	5wbjJrTBBQ2R+e0/SVnvFg/zmNX2DxK7OfL8=
X-Google-Smtp-Source: AGHT+IEJiGF8X5t1BC3wuLtEUWMcoVjEujVJtq4GEgIjlEkz6OuGpOs7B8hJTKQqIRTUNd3rmpGMjQ2Oly6ezaqmMNw=
X-Received: by 2002:a17:906:308d:b0:a6f:e05b:b1f1 with SMTP id
 a640c23a62f3a-a715f94a879mr874501566b.30.1719532699302; Thu, 27 Jun 2024
 16:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 28 Jun 2024 09:58:07 +1000
Message-ID: <CAPM=9txzYPEzGHDvNBJb_WXfbktOSy0Y8odZGTRGpqJ00kPgRA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Regular fixes, mostly amdgpu with some minor fixes in other places,
along with a fix for a very narrow UAF race in the pid handover code.

I'm going to be travelling next week so expect a fixes pull from Sima,
I don't think I'll be completely offline but won't be too responsive.
(though Japan at this time of year might cause me to be indoors more
than expected!).

drm-fixes-2024-06-28:
drm fixes for 6.10-rc6

core:
- fix refcounting race on pid handover

fbdev:
- Fix fb_info when vmalloc is used, regression from
  CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM.

amdgpu:
- SMU 14.x fix
- vram info parsing fix
- mode1 reset fix
- LTTPR fix
- Virtual display fix
- Avoid spurious error in PSP init

i915:
- Fix potential UAF due to race on fence register revocation

nouveau
- nouveau tv mode fixes.

panel:
- Add KOE TX26D202VM0BWA timings.
The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-28

for you to fetch changes up to 4f2a129b33a2054e62273edd5a051c34c08d96e9:

  drm/drm_file: Fix pid refcounting race (2024-06-28 08:56:26 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc6

core:
- fix refcounting race on pid handover

fbdev:
- Fix fb_info when vmalloc is used, regression from
  CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM.

amdgpu:
- SMU 14.x fix
- vram info parsing fix
- mode1 reset fix
- LTTPR fix
- Virtual display fix
- Avoid spurious error in PSP init

i915:
- Fix potential UAF due to race on fence register revocation

nouveau
- nouveau tv mode fixes.

panel:
- Add KOE TX26D202VM0BWA timings.

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/atomfirmware: fix parsing of vram_info

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2024-06-26' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.10-2024-06-26' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-06-27' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes

Jann Horn (1):
      drm/drm_file: Fix pid refcounting race

Janusz Krzysztofik (1):
      drm/i915/gt: Fix potential UAF by revoke of fence registers

Julia Zhang (1):
      drm/amdgpu: avoid using null object of framebuffer

Li Ma (1):
      drm/amd/swsmu: add MALL init support workaround for smu_v14_0_1

Lijo Lazar (2):
      drm/amdgpu: Fix pci state save during mode-1 reset
      drm/amdgpu: Don't show false warning for reg list

Liu Ying (1):
      drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA

Ma Ke (2):
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes

Michael Strauss (1):
      drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if
LTTPR is present

Thomas Zimmermann (1):
      drm/fbdev-dma: Only set smem_start is enable per module option

 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 25 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           | 18 +++++-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |  5 +-
 .../display/dc/link/protocols/link_dp_capability.c | 10 ++-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |  5 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 13 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  5 ++
 .../amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h   |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   | 73 ++++++++++++++++++++++
 drivers/gpu/drm/drm_fb_helper.c                    |  6 +-
 drivers/gpu/drm/drm_fbdev_dma.c                    |  5 +-
 drivers/gpu/drm/drm_file.c                         |  8 +--
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |  1 +
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |  6 ++
 drivers/gpu/drm/panel/panel-simple.c               |  1 +
 18 files changed, 174 insertions(+), 24 deletions(-)

