Return-Path: <linux-kernel+bounces-205240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E3A8FF9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782F01C22241
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2911718;
	Fri,  7 Jun 2024 02:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpEoAvwV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09AB64E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725964; cv=none; b=htAUlIcjMgDkz0PRpLDMSkPSwvxyxLIqK7Vl551rgn4GyVTAdQbWSxDo5BU2LpLwh26RXwCEzFIDLNgyac3MjOZqzaLEM/VTEoq1a4HTo5UZ3Fo9OcDlBLtqdKwfARbjOYy/kmseeOoeqCKFFlm91vNDfAHGRTMDw9dyT1tvgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725964; c=relaxed/simple;
	bh=xMeczsdAlv4UoRd1dy3o2EX9IC+SZrtDX6ksBtcaQK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=coYOY2m+MnO9lU16FpWgNtg13aTuuyhHEmX1ZRXlyQlbuzBvVdxJDbTyL5h+12ee6KvehFkPSwaqXJD8z2GmMt+jY/xR19eUpXu8Blx8sFGAqUZFY/eGiVN+rDpK1yQJNNssItxso8GIUvaBzY/s+NhhUfCWdps795o12NrMFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpEoAvwV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b992fd796so1672134e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 19:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717725961; x=1718330761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QmdigPbiZh7u73WyQrLPcTJkkfoD9rCWbKcRqUVrOeI=;
        b=cpEoAvwVwCA/Nb7rybs4U+fb5vcW/IqcQVrB9ksi9rpuH4bFefH91GRvZ1lP+qu95V
         +/YojcWmSd1kAL2hB4V2oGXbrGt6fDhs255GzQmannjagBql96jH+k2rHzg7jeCl8iy7
         CPDn/V0QO+MhLX+BP9c/lJuxn39As0EkuH2EU7pzmJxBn1dMfB28WfqYQA3FEH//+YeX
         swex8ee7xh8zteOkcEdep63RG6kcUROjkMvSRjVy3N4EiOXsqmQqaDgLo2Pa7jV5hfmP
         YnVRH496//ULEspBxHdc4rkYIoMC20a09Vo9/m4NOB+MgVSKZSo7M9p3ACAE3rQ4NMXQ
         oPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725961; x=1718330761;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmdigPbiZh7u73WyQrLPcTJkkfoD9rCWbKcRqUVrOeI=;
        b=JLrfX5c7cpGh7btELXzWu8D1+YpGui/SYqVTX846n/a68Wv/UhJdfkR+NrFwgj4n3L
         znsrXtrAzYQLchQ3YCSq1vZUhJd0pVtNqbo1X+jFhkGqpBYkCWTxiojbKnlIJfZLBFQZ
         dkHt8VNXqtR0YmcJOv8O1q7wMoiLImv2S56L8GTmutqX7nCvHq9j3/TgxXIj7ZFyXPze
         wknTdboTI7WkMMVBylWOb223/bkTHgI+KM7W+OmHpByrNrWsTOstR1kkfAvb6qRheAWg
         g5f8NCpqo5NM9SRB4sxU/40dRlYybdqt5aDbjTLpux3JfudSjzMM1V3XF9odI/EUJovK
         vsxA==
X-Forwarded-Encrypted: i=1; AJvYcCWoCmDQZqNIqu4HbA82p7N/7GqxVFAseiDYmR7lQQgb9fPsLHCdb6puNO4JEbVEVLdFuGBDzz9jKF0EoTssb1GrMcuDKASRvGWekCt7
X-Gm-Message-State: AOJu0Ywyhcw95BlXvTSJrB85rPQsad9b0RMK+4ZuN/3FQDEijcr/g11h
	TFfsz3BUJkjvw3X2gIeAkxaIgTanhmcUXQf29slHvVfH545BmrQknmEYIhmixBAnmoR/+leay3r
	7YIlZ6sP67J1N7sYffeGELEdTBbU=
X-Google-Smtp-Source: AGHT+IFQlGkIbJhF9IM0XawMYHjSy8OtNnb4ijLh5dvdjX1Odn7hgcWDHLCBTdhu8/9XzpTX36XSKzRXzES+6SGR3qY=
X-Received: by 2002:a05:6512:3e14:b0:52b:bb10:6c19 with SMTP id
 2adb3069b0e04-52bbb106d7cmr554972e87.23.1717725960650; Thu, 06 Jun 2024
 19:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 7 Jun 2024 12:05:49 +1000
Message-ID: <CAPM=9tyvjs75_Op_yXD=vD_ZLQwZRzio0=_oM=vGkeOkaGW=TA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.10-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly fixes, vmwgfx leads the way this week, with minor changes in xe
and amdgpu and a couple of other small fixes.

Seems quiet enough.

Dave.

drm-fixes-2024-06-07:
drm fixes for 6.10-rc3

xe:
- Update the LMTT when freeing VF GT config

amdgpu:
- Fix shutdown issues on some SMU 13.x platforms
- Silence some UBSAN flexible array warnings

panel:
- sitronix-st7789v: handle of_drm_get_panel_orientation
  failing error.

vmwgfx:
- filter modes greater than available graphics memory
- fix 3D vs STDU enable
- remove STDU logic from mode valid
- logging fix
- memcmp pointers fix
- remove unused struct
- screen target lifetime fix

komeda:
- unused struct removal
The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-06-07

for you to fetch changes up to eb55943aab89be99a26e34fc2175ebb3583a2778:

  Merge tag 'drm-misc-next-fixes-2024-06-07' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2024-06-07 08:40:58 +1000)

----------------------------------------------------------------
drm fixes for 6.10-rc3

xe:
- Update the LMTT when freeing VF GT config

amdgpu:
- Fix shutdown issues on some SMU 13.x platforms
- Silence some UBSAN flexible array warnings

panel:
- sitronix-st7789v: handle of_drm_get_panel_orientation
  failing error.

vmwgfx:
- filter modes greater than available graphics memory
- fix 3D vs STDU enable
- remove STDU logic from mode valid
- logging fix
- memcmp pointers fix
- remove unused struct
- screen target lifetime fix

komeda:
- unused struct removal

----------------------------------------------------------------
Chen Ni (1):
      drm/panel: sitronix-st7789v: Add check for of_drm_get_panel_orientation

Dave Airlie (4):
      Merge tag 'drm-xe-fixes-2024-06-04' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.10-2024-06-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2024-06-07' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-misc-next-fixes-2024-06-07' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Dr. David Alan Gilbert (2):
      drm/komeda: remove unused struct 'gamma_curve_segment'
      drm/vmwgfx: remove unused struct 'vmw_stdu_dma'

Ian Forbes (6):
      drm/vmwgfx: Filter modes which exceed graphics memory
      drm/vmwgfx: 3D disabled should not effect STDU memory limits
      drm/vmwgfx: Remove STDU logic from generic mode_valid function
      drm/vmwgfx: Standardize use of kibibytes when logging
      drm/vmwgfx: Don't destroy Screen Target when CRTC is enabled but inactive
      drm/vmwgfx: Don't memcmp equivalent pointers

Mario Limonciello (1):
      drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms

Michal Wajdeczko (1):
      drm/xe/pf: Update the LMTT when freeing VF GT config

Tasos Sahanidis (1):
      drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds

 drivers/gpu/drm/amd/include/pptable.h              | 91 ++++++++++++----------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   | 20 ++---
 .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c |  5 --
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                | 19 ++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  3 -
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 28 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               | 60 ++++++++++++--
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |  1 +
 10 files changed, 135 insertions(+), 100 deletions(-)

