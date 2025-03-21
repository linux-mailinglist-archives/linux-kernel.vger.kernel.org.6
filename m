Return-Path: <linux-kernel+bounces-570694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F07A6B3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E6188B161
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9181E5B66;
	Fri, 21 Mar 2025 04:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbjXH1k1"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C182B664
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742530762; cv=none; b=mezfCCm5IcQctKOkTghcgoqUAeu9IDCxH83Ggo9RyPquhKIq/QyuVjsS1OYZ1Y2mFhFNqKGsG/UCla+16RETx8Tw4iVlCerP+p0DTfG0klrruadneTL0vEzpF79k0ARLd74esG1IRKpjGy2MgFwhSK4CeYSiSMqu/I6dFElcJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742530762; c=relaxed/simple;
	bh=oGwh/r98qC1FrijucD7CZo9YVD3rPbjFpxBfK1X4Jk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fVB4opr4fIIsWOTTrp0XsHPKnXtjoPqXsCSlCD3ugUKK/ncSDU/MoPWuEwg0ogANZwjcbYm2c6KET73QW2fX2B2sDAI9hk9wEwu5fUZSL+0EgGdrIuC1qgc2dNWncGbDXFXPMErY5sUbU7aR4YqFmeO2IZSx1kpuN16xl+ITrTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbjXH1k1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so201546366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742530756; x=1743135556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SpibAVJk9elna1e6DyUjTSilMAviHsEHwd+4cHoC0Q8=;
        b=ZbjXH1k1PQTKFmPykJj/es/eG6bN0HGOgIjaSR6zHsGbcks5xUXzAtdjA/HT76nP4T
         7D40MxP4L4GphdZhxTmHDFqhHHpTKrhb5rrNXyxzy8ekpsi1ZV2LGZbcPzWXWI9gWAOB
         EX4TpafqdZVN5gRD99n9r+8FrBhPvOaIaivc9QufKbt8rVWUs6xQt18M6r7bisN8vHY0
         +F82R0qCl2E9896yCPBULkO71U5fybb4eaibzvwEds6n0qzpHQokgeOHZi7pFl3POIUr
         VSK1djYMmtGmXx1kaoahRovZUqTM+iYbmbiArSroSTtUqNfqzBDj4S13oqgC798NiRD8
         ObJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742530756; x=1743135556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpibAVJk9elna1e6DyUjTSilMAviHsEHwd+4cHoC0Q8=;
        b=Fp31/qnRWH73TraMvCvcOZADgW2cMLDjso4/DQPhym8XvNEWxPA06TIKFYKoMQDfXI
         pf9Wohxl1QOrmxKJCvQNTchoePF9TmcWP68V//0h/J5VUQtFVncTYso4T5fbAb0IPp1j
         zeXTfq6e/if3iNeM8Zy2KrYCNj1gXrX865NCEedAsVpV1rhP5lpxzT7cbPYnaxubNtUg
         zrEYeNmpB4a5o7q594RRqzkLgQpiAugmVMbVqD3seTTDtjyQa2NHwz2OxJKN9+WWbOmH
         vyOhutjGdDUOnu1V48ffqAiNRgYeG6h7faQJaLTbMQwC9jjrT9YCcNt3v6FrMooPz8ww
         ebBg==
X-Forwarded-Encrypted: i=1; AJvYcCXREecJ949BdpQNWLA43QnDiFhJjD/GbrumOGUOQ2gT5SxLNTiI1KdFIzhQ/TXf3PSG2yBSs83ZuPTi2L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrwporoMrzc840NtCuTwSKSWMaPRTP6hT6wu7M1zPyziqvmQz
	3IB/uKrSLwDjJWxoBelcAc/BxWOs3T850L2ZPLKWe2SE8FQbpuSZwsplaezRaN5REzLegBReWUL
	+ugoSwcfGUjnYy58ofv8Os8/vwa8=
X-Gm-Gg: ASbGncv3hgYvd+qM0uxvbbzJMHpWRwz9kc7RjKI93C+c/80LGfKyGsj2budg/+HvC28
	1ZVdSfuzyTIVDh0957J7/8ECDAhc4H22Kq5NhYX27+ymFJjhvVFTP0kScSuCjvGzr0Vs5fSENJ8
	SaB1rGXvpWchF0p/g1j7k2Hhn2
X-Google-Smtp-Source: AGHT+IHlVqDnb9TbCW+gY+cKONThgIjNpaG7RCf0g7ElD2xNuuyzNFbzysKVelmk+2H+F4O4+paWAsWY1SnHSVmTN3Y=
X-Received: by 2002:a17:906:c103:b0:ac3:ec70:18aa with SMTP id
 a640c23a62f3a-ac3f22a26c2mr133689966b.25.1742530756331; Thu, 20 Mar 2025
 21:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 21 Mar 2025 14:19:05 +1000
X-Gm-Features: AQ5f1JpybLH9-9_AT_Id0S-ya_nN9kZxZ10q_mUeHQrczvkntzCRCad4nelQQXw
Message-ID: <CAPM=9txGdh-rbWbxA_nQVV_1AMin8SgJpo1T4HNcCc_4aRtJ0Q@mail.gmail.com>
Subject: [git pull] drm fixes for 6.14-rc8/final
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

It appears that the fd.o infrastructure is back enough to facilitate
sending this week's fixes, hopefully you can grab it without issue.
Just the usual spread of a bunch for amdgpu, and small changes to
others.

Regards,
Dave.

drm-fixes-2025-03-21:
drm fixes for 6.14-rc8

scheduler:
- fix fence reference leak

xe:
- Fix for an error if exporting a dma-buf multiple time

amdgpu:
- Fix video caps limits on several asics
- SMU 14.x fixes
- GC 12 fixes
- eDP fixes
- DMUB fix

amdkfd:
- GC 12 trap handler fix
- GC 7/8 queue validation fix

radeon:
- VCE IB parsing fix

v3d:
- fix job error handling bugs

qaic:
- fix two integer overflows

host1x:
- fix NULL domain handling
The following changes since commit 4701f33a10702d5fc577c32434eb62adde0a1ae1=
:

  Linux 6.14-rc7 (2025-03-16 12:55:17 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-03-21

for you to fetch changes up to 41e09ef6c26f0bd89f93691ef967fd621a38d759:

  Merge tag 'amd-drm-fixes-6.14-2025-03-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2025-03-21
11:59:49 +1000)

----------------------------------------------------------------
drm fixes for 6.14-rc8

scheduler:
- fix fence reference leak

xe:
- Fix for an error if exporting a dma-buf multiple time

amdgpu:
- Fix video caps limits on several asics
- SMU 14.x fixes
- GC 12 fixes
- eDP fixes
- DMUB fix

amdkfd:
- GC 12 trap handler fix
- GC 7/8 queue validation fix

radeon:
- VCE IB parsing fix

v3d:
- fix job error handling bugs

qaic:
- fix two integer overflows

host1x:
- fix NULL domain handling

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2

Dan Carpenter (1):
      accel/qaic: Fix integer overflow in qaic_validate_req()

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2025-03-20' of
ssh://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-03-20' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.14-2025-03-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Belanger (1):
      drm/amdgpu: Restore uncached behaviour on GFX12

David Rosca (3):
      drm/amdgpu: Fix MPEG2, MPEG4 and VC1 video caps max size
      drm/amdgpu: Fix JPEG video caps max size for navi1x and raven
      drm/amdgpu: Remove JPEG from vega and carrizo video caps

Harish Kasiviswanathan (1):
      drm/amd/pm: add unique_id for gfx12

Jason Gunthorpe (1):
      gpu: host1x: Do not assume that a NULL domain means no DMA IOMMU

Jay Cornwall (1):
      drm/amdkfd: Fix instruction hazard in gfx12 trap handler

Jeffrey Hugo (1):
      accel/qaic: Fix possible data corruption in BOs > 2G

Lo-an Chen (1):
      drm/amd/display: Fix incorrect fw_state address in dmub_srv

Mario Limonciello (1):
      drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

Ma=C3=ADra Canal (2):
      drm/v3d: Don't run jobs that have errors flagged in its fence
      drm/v3d: Set job pointer to NULL when the job's fence has an error

Nikita Zhandarovich (1):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()

Philip Yang (1):
      drm/amdkfd: Fix user queue validation on Gfx7/8

Tomasz Paku=C5=82a (1):
      drm/amdgpu/pm: Handle SCLK offset correctly in overdrive for smu 14.0=
.2

Tomasz Rusinowicz (1):
      drm/xe: Fix exporting xe buffers multiple times

Wentao Liang (1):
      drm/amdgpu/gfx12: correct cleanup of 'me' field with gfx_v12_0_me_fin=
i()

Yilin Chen (1):
      drm/amd/display: Fix message for support_edp0_on_dp1

qianyi liu (1):
      drm/sched: Fix fence reference count leak

 drivers/accel/qaic/qaic_data.c                     |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |  22 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  20 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  21 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  43 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 703 +++++++++++------=
----
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |  82 +--
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |  11 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   2 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  96 +--
 drivers/gpu/drm/radeon/radeon_vce.c                |   2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |  11 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  23 +-
 drivers/gpu/drm/xe/xe_bo.h                         |   2 -
 drivers/gpu/drm/xe/xe_dma_buf.c                    |   2 +-
 drivers/gpu/host1x/dev.c                           |   6 +
 21 files changed, 583 insertions(+), 498 deletions(-)

