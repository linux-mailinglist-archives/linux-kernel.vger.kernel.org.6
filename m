Return-Path: <linux-kernel+bounces-250148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C280F92F4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6921F24004
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C431429A;
	Fri, 12 Jul 2024 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIOPVqey"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94901426C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720759632; cv=none; b=VpZTc7c77QTr6PAPWsJf0cpgVhP6CSvfzBJfZpzOWlC64ERNTLWYE4im27N0jZThKh9c4r6bZsEkdkbnZxYOxhYyU2PGwNzR4lzt0M1hEAGqzQ0h3MdBUXuX18hGVJ/JQi0i/c5dpY5JJzpiLApx5lQasyt9RPfGKuJ/B+3SwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720759632; c=relaxed/simple;
	bh=LzCdrdSvUSJ7UqCgfifWi+mxRfEkjWT9zt8kolquCZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eZYzRCYed9X30ldX5j18TvrLmyGo/f1f5l1/5ethy7k40NGZLwwzM2KooobDrsKESLOgcMNYsxw1K435caLAaCAdsf5nn7HO08nQvH2FiD60eHdiv2NWoCOtQsszYKJwmg2ZQMvbBtgpUqBNbtoU+fhBf1NPPq+p6+IXKwh32XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIOPVqey; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso413969566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720759628; x=1721364428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pAkn2cTSTcU5jSssfeBuKmvRbIUP8ptqi04m3wwrjB4=;
        b=HIOPVqeylR0sRGUjcQUCwmK7UzZq18Rr8N2WUA6n9ZcAT5EEtFyFl3snuGGaqKzNB7
         dYiHzYP1Iq+y3tiKvywsV2jtEAnetmt9ljyPuhZyFBLm7asAavvxdkxu2E7icsUmXykW
         1NCJis/rjkAQBNNwBCemLLxb7X+lSVNIcjaCpDVErRnzDw4AcNPKctsa6c6AoTbRsAa/
         MtnHAMvGVQJ7OHBQT2xcTbZtYgZ4Tcv1uSJhO1kA0C2COmvhaYQeBLKDL1r836lMPB2W
         G8aogGNe6ewTjJMsX/bY8qn5DQDUxH/r6US+m3E8rxJfMqOITEOmcEPdvE3/TMQef/WX
         wleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720759628; x=1721364428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAkn2cTSTcU5jSssfeBuKmvRbIUP8ptqi04m3wwrjB4=;
        b=m4JppuevnGRyBqDuxU+od6G8AFdiEyBb+1wSLxXiVIavgjRg+WOdHis89onwsVIg+J
         ffCp5cqR69kgKIXE2mFXlTydUDXM5BXrhbqOa8sPvhxxfNFu7dGS9Mt0YEFE6c9uP1/e
         jpzh/KBD7j8Ts9c5cOLXN6/NIyCbf5uvKTgk2IywsMc+MrcAXPZNYRYJVP9Bcdu7fAvN
         mxc2nSW7JsPv8f/rA+sWiC4eHLH9hpHX7aaq4Aby61d4BTao+b2RbVVczb8MGSmWqosL
         S4iuQj7+YZrvRiPWRj3z/UGBbdHUwnxu1w9pgLWAbUCNAFICmnA6c+s/EszsNH4wvzux
         icUA==
X-Gm-Message-State: AOJu0Yxk8X415d1f4ACOBIti/OQTfUAONChK3lc9IAZyLBiIFOc75SKW
	J6R4cnKUI3/3F40PzK5hh+AoTSx2p8PO7LhKXklHPlaYcQ/bnFzpMFzWntNN9n2JV/CMX6PSXFy
	habmE0zYIPTyuqjYdP/tfRDKUmo8t/cF5wMA=
X-Google-Smtp-Source: AGHT+IFZYBNzXtdjjVzb8dVyNE6tOfvjEVwR/PDhKcvGdCvIxNVO1vIgJ78q/iMjD9YQS0N3JFJqlTWFxpwOckYUnlI=
X-Received: by 2002:a17:907:7d90:b0:a77:e152:a8e with SMTP id
 a640c23a62f3a-a799cd00609mr126400866b.26.1720759627920; Thu, 11 Jul 2024
 21:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 12 Jul 2024 14:46:56 +1000
Message-ID: <CAPM=9tzVaA1Y4A69HF-gHPy3YEgE7EGKxZa0rFWT4NUKvdF1wg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc8
To: LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Back to work, thanks to Sima for last week, not too many fixes as
expected getting close to release, amdgpu and xe have a couple each,
and then some other misc ones.

Dave.

drm-fixes-2024-07-12:
drm fixes for 6.10-rc8

amdgpu:
- PSR-SU fix
- Reseved VMID fix

xe:
- Use write-back caching mode for system memory on DGFX
- Do not leak object when finalizing hdcp gsc

bridge:
- adv7511 EDID irq fix

gma500:
- NULL mode fixes.

meson:
- fix resource leak
The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948=
:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-07-12

for you to fetch changes up to 8b68788bebd3f697ae62aa9af3dac35ed112ebd7:

  Merge tag 'amd-drm-fixes-6.10-2024-07-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-07-12
13:32:36 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc8

amdgpu:
- PSR-SU fix
- Reseved VMID fix

xe:
- Use write-back caching mode for system memory on DGFX
- Do not leak object when finalizing hdcp gsc

bridge:
- adv7511 EDID irq fix

gma500:
- NULL mode fixes.

meson:
- fix resource leak

----------------------------------------------------------------
Adam Ford (1):
      drm/bridge: adv7511: Fix Intermittent EDID failures

Christian K=C3=B6nig (1):
      drm/amdgpu: reject gang submit on reserved VMIDs

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2024-07-11' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-07-11' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.10-2024-07-11' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Leo Li (1):
      Revert "drm/amd/display: Reset freesync config before update new stat=
e"

Ma Ke (2):
      drm/gma500: fix null pointer dereference in psb_intel_lvds_get_modes
      drm/gma500: fix null pointer dereference in cdv_intel_lvds_get_modes

Nirmoy Das (1):
      drm/xe/display/xe_hdcp_gsc: Free arbiter on driver removal

Thomas Hellstr=C3=B6m (1):
      drm/xe: Use write-back caching mode for system memory on DGFX

Yao Zi (1):
      drm/meson: fix canvas release in bind function

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            | 15 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c           | 15 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h           |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -
 drivers/gpu/drm/bridge/adv7511/adv7511.h          |  2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c      | 13 +++++--
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c      | 22 ++++++-----
 drivers/gpu/drm/gma500/cdv_intel_lvds.c           |  3 ++
 drivers/gpu/drm/gma500/psb_intel_lvds.c           |  3 ++
 drivers/gpu/drm/meson/meson_drv.c                 | 37 +++++++++---------
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c          | 12 ++++--
 drivers/gpu/drm/xe/xe_bo.c                        | 47 ++++++++++++++-----=
----
 drivers/gpu/drm/xe/xe_bo_types.h                  |  3 +-
 include/uapi/drm/xe_drm.h                         |  8 +++-
 14 files changed, 122 insertions(+), 60 deletions(-)

