Return-Path: <linux-kernel+bounces-242686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F10928B70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D431C24220
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405616D30E;
	Fri,  5 Jul 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OyXB+XHu"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A516CD00
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192484; cv=none; b=JwydI/AI0WHZvh/pYa59E1EPplTr2eM72eQOWVDRzfBbrohy1pLxkMPREUAv8WXCMjrG7fu11c+UDyPj6jjOGv/7rwJvdEj1QZwSuGa7pmuTfx6naZNFwBs7k+PH6PbZuBEGJgerRaFFx/bJLPWcgE3vvHDsbXBrZJD6ZksgRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192484; c=relaxed/simple;
	bh=Rjlq4dX4IpqRTW8Ul3XgLuaaKOqQ40fAHqLrl/T0Tjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G72tW/RJRziVhiVYYZQPr3gfz7W2ABwVmnhdpIQWKDdKwMS6ZHK+nEjOn6qDEfJzBVEFXmqCg3ggYYzT285sSpWHOyrrXk7UsGUHDFEr1gHropM1kl2wK+z69WkrKUJOQ9ld4e1ksA9PaU13qZHQilgO68CDJBHLcZjaHxCnZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=OyXB+XHu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee92fe5fdcso1555731fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720192481; x=1720797281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY3Bk5gxpl8CBAzjGC4Q5ufFUhr18OlzUViMV+Tpk6Q=;
        b=OyXB+XHusV0Jh7GHFoeG0FdwmzVcw7AIM1ue7/PlLZNJkL+aGqt14nSPH7Oj/Taa4d
         LKGVNd5a5yYQjeo7lUJIucsOf8ID62B5rPQ0+knWczhrYBaVjnMnZJhmzTm/jZGQv9hO
         dvKlMLTWYLGASLaciiCSnn1CR/0Rx44ZZAKdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192481; x=1720797281;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3Bk5gxpl8CBAzjGC4Q5ufFUhr18OlzUViMV+Tpk6Q=;
        b=WgBfvkxNqUQL7SvT1B/J6ai+Pcpim8+lkRy6DYjjBCU/C3uHJsQysbAzaLxkdKDnYu
         FwBo9e44V20hv7YqH7Me5vzoWi2Rw63iO78oAqx5bzg04rzCqdi398FjtDueuR3cPMP5
         zJQD/s7C8nOGH2XFT6QlGeCLZyH0aFpBSQQg6OzGZBj4bqDOW7BBUpMnZ+9atfHnbwz1
         WJ60Ft+22VI0Ys5Xn6Dbyia97IhR7dBT8btzgvFnxwpi0LJsQ+Km9UoNTz9gi0tr1HCQ
         a2ru9j4FpwYd/PyLZS8N0+F89QXHyl292ZxqbMRklGA5YzpNG5YKrDZRbaO/TyPgJSgm
         oeOA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7G0tmnduaL4aAYElQZLGSp/jfhf/kNT/lky6DvCALQTMrhhJnS2F4ThgJe/456gu5OnPO+RO9QFLrhF+Q9DBmoeDJMlJfUmpFmYg
X-Gm-Message-State: AOJu0YzRmDyQR6IFj091W75u3tYbiUX3vYoXBMu7rPm/NVYmknNjBSYv
	Ps3GaaYddwb8Z+o6h5/cTu9QKkQB3OizDwe5AgXRqt6WVg78NPnvHBkXSXp8IGB6pDeAwYv+AOy
	yG+Q=
X-Google-Smtp-Source: AGHT+IGs8Ho/KWgUMyRlrMRcWi0P3DmQIACNh3RTD/PyyzOhyfwljzyw2Z8tMfSfoepNS97p/7uHqg==
X-Received: by 2002:a2e:9089:0:b0:2ee:87d8:c937 with SMTP id 38308e7fff4ca-2ee8ec4e32cmr33330071fa.0.1720192480745;
        Fri, 05 Jul 2024 08:14:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm67180705e9.10.2024.07.05.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:14:40 -0700 (PDT)
Date: Fri, 5 Jul 2024 17:14:38 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes for v6.10
Message-ID: <ZogN3gNPBVb29Vgl@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@gmail.com>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 6.9.7-amd64 

Hi Linus,

Dave is on vacations, should be back next week. Just small fixes all over
here, all quiet as it should.

Cheers, Sima

drm-fixes-2024-07-05:
drm-fixes for v6.10-rc7

drivers:
- amd: mostly amdgpu display fixes + radeon vm NULL deref fix
- xe: migration error handling + typoed register name in gt setup
- i915: usb-c fix to shut up warnings on MTL+
- panthor: fix sync-only jobs + ioctl validation fix to not EINVAL
  wrongly
- panel quirks
- nouveau: NULL deref in get_modes

drm core:
- fbdev big endian fix for the dma memory backed variant

drivers/firmware:
- fix sysfb refcounting

Cheers, Daniel

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-07-05

for you to fetch changes up to 3c6f5afd91cfacba9f43fd388f2d88c85195ae32:

  Merge tag 'amd-drm-fixes-6.10-2024-07-03' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-07-05 12:54:14 +0200)

----------------------------------------------------------------
drm-fixes for v6.10-rc7

drivers:
- amd: mostly amdgpu display fixes + radeon vm NULL deref fix
- xe: migration error handling + typoed register name in gt setup
- i915: usb-c fix to shut up warnings on MTL+
- panthor: fix sync-only jobs + ioctl validation fix to not EINVAL
  wrongly
- panel quirks
- nouveau: NULL deref in get_modes

drm core:
- fbdev big endian fix for the dma memory backed variant

drivers/firmware:
- fix sysfb refcounting

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/atomfirmware: silence UBSAN warning

Alvin Lee (1):
      drm/amd/display: Account for cursor prefetch BW in DML1 mode support

Boris Brezillon (2):
      drm/panthor: Don't check the array stride on empty uobj arrays
      drm/panthor: Fix sync-only jobs

Daniel Vetter (4):
      Merge tag 'drm-intel-fixes-2024-07-02' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-07-04' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-07-04' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.10-2024-07-03' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Fangzhi Zuo (1):
      drm/amd/display: Update efficiency bandwidth for dcn351

Imre Deak (1):
      drm/i915/display: For MTL+ platforms skip mg dp programming

John Schoenick (1):
      drm: panel-orientation-quirks: Add quirk for Valve Galileo

Ma Ke (1):
      drm/nouveau: fix null pointer dereference in nouveau_connector_get_modes

Matt Roper (1):
      drm/xe/mcr: Avoid clobbering DSS steering

Matthew Auld (1):
      drm/xe: fix error handling in xe_migrate_update_pgtables

Matthew Schwartz (1):
      drm: panel-orientation-quirks: Add labels for both Valve Steam Deck revisions

Pierre-Eric Pelloux-Prayer (1):
      drm/radeon: check bo_va->bo is non-NULL before using it

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dml2/FCLKChangeSupport

Thomas Hellström (1):
      drm/ttm: Always take the bo delayed cleanup path for imported bos

Thomas Huth (1):
      drm/fbdev-generic: Fix framebuffer on big endian devices

Thomas Zimmermann (1):
      firmware: sysfb: Fix reference count of sysfb parent device

Tom Chung (3):
      drm/amd/display: Reset freesync config before update new state
      drm/amd/display: Add refresh rate range check
      drm/amd/display: Fix refresh rate range for some panel

 drivers/firmware/sysfb.c                           | 12 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 53 +++++++++++++++++++++-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |  3 ++
 .../amd/display/dc/dml2/dml2_translation_helper.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c   |  2 +-
 drivers/gpu/drm/amd/include/atomfirmware.h         |  2 +-
 drivers/gpu/drm/drm_fbdev_generic.c                |  3 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  9 +++-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  3 ++
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  3 ++
 drivers/gpu/drm/panthor/panthor_drv.c              |  6 +--
 drivers/gpu/drm/panthor/panthor_sched.c            | 44 +++++++++++++-----
 drivers/gpu/drm/radeon/radeon_gem.c                |  2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |  1 +
 drivers/gpu/drm/xe/xe_gt_mcr.c                     |  6 +--
 drivers/gpu/drm/xe/xe_migrate.c                    |  8 ++--
 include/uapi/drm/panthor_drm.h                     |  5 ++
 17 files changed, 132 insertions(+), 31 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

