Return-Path: <linux-kernel+bounces-381126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218269AFAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF83E281AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393B1B2197;
	Fri, 25 Oct 2024 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYV4l1EC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF767A0D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840241; cv=none; b=i1BuSqnZGcqDZvHzUSWR7akUI8HwgRWdGpeoJ+UCvkwabYDe04fxnCDhBZ9nVIW2dFUjePP3/3WOfK6pDQeFHwc27dHqFQd0KEwaYYH5CZ1ECVtkaxYRWTGFQdIpKq30cEWoFcS5tsyUVSS1+SplxEdanPWENOxYIcQim9Wr+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840241; c=relaxed/simple;
	bh=3KW7d+KJmbc0374AYq/XLD97rhLrTfllEdHaS/gjRNc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n/GKmo1LXmdyILU62aUAi7uTvqQ5J74fwb+kiyIh5ttbtamR4xDE4Yym59UaDUnnIlqWreXa3AcKwSxJo44xxfRYC56hDYfxvTIeHqVFIJBZf4pfbZDiVjiEO8CuEt0CkdsuzlLvqfCdZ1Nt4miD55UyE531/YcQF5CunlY8vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYV4l1EC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so5012838a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729840237; x=1730445037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QN1tsLfbB9d5DyYhuV0X7PZg8MBg1dvti2XZFfsqElk=;
        b=TYV4l1ECFqNYgeQe/mnSZQYfi3d+o9TMlQdVkyEQ/GiW/l9IyR2DMdWSoIlaIk9zmY
         uleVwnUmHveHEDmEIf+DNulupo2FdMciUitsUxPni8Jddn2pAlXJa78n7muZEWdq1gIA
         TxcZzOXYYryDD9js52hb11DamCVwFuXnbY9Z+XmyfElRwWeRfYx6XGtbZj8/6FxyDB2s
         PWkgOcwjfrVDq1p3RlaaZzM48e53zogmT9RVM1KfiD5agRnVhaOiGzSpt/+Mohd6KQXH
         RM2AAAIKeiV30Hc0Kksdj2p7Gd1EC6HKcUr9TPnweXl2OLq1FlJgW9vWrEQUaebj93hj
         lS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840237; x=1730445037;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QN1tsLfbB9d5DyYhuV0X7PZg8MBg1dvti2XZFfsqElk=;
        b=ewi5mExUUn/Au63JR+tf97NkQWAP+i0JhN+NEkAMXXTta0J7CwHRQh3SJq+xv7LGPM
         m5wOuBysA0h1ODe4XSqttqBhIMIEBsne4fD/6PBqJ6WIgJyF+9uFzrz2lPAy02LKMkhT
         XN/eYgVinVXIef4UqBjVMn3+WexLq9h6q41RnOgoRF6Q/Ov5W2fJmOYTmxeghtREtVEB
         f6monOGs5e4ywiXJk8k8X3EhEZ+O4SjBtdc3WBjOq2digcoVogruw/EkZmeQWJRGfdMR
         ODSRwPrxX8bhkSRlxJ0xEW1dKuhAKZarbzX7BG7D/LBjbdd93ki3AFacbI0l/XrsBitZ
         eBSw==
X-Forwarded-Encrypted: i=1; AJvYcCXBga4vL5sz0KoX6J7/sDpKT6zCGl0eEhwi3LqhR8HtxFLSe8dnF7wNqCKvth+1ON4Vhpfh1WOrnipjtY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynMnu+TYsgqvEqv5AlkdEXbS9ym0/tC5kd/30ALJm6Nnpk85ok
	P3I3S6nkduyFOJSBO8sU/z/bzayX2GmNOh61J4jiokcGFzJqyjNStqgRby9YYImshQQWHYriP+r
	7JqwM4nNdC3Qu3OgfNMRvxGjY9xE=
X-Google-Smtp-Source: AGHT+IE69Rqr3iBH6ZNcjuDegoQGEui60s/sn4mr/tPGvtxt6xXxL+X7hGKebCB5jrKTWLLH0Hq1AL+CvD7/bQpwE+0=
X-Received: by 2002:a17:907:eab:b0:a99:3db2:eb00 with SMTP id
 a640c23a62f3a-a9ad1add979mr449403266b.28.1729840236927; Fri, 25 Oct 2024
 00:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 25 Oct 2024 17:10:25 +1000
Message-ID: <CAPM=9txMNPAbbfxvD+0ouRGY5nojRvu6n+cPc=hjNwQzzj6gtA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.12-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly drm fixes, mostly amdgpu and xe, with minor bridge and an i915
Kconfig fix. Nothing too scary and it seems to be pretty quiet.

Dave.

drm-fixes-2024-10-25:
drm fixes for 6.12-rc5

amdgpu:
- ACPI method handling fixes
- SMU 14.x fixes
- Display idle optimization fix
- DP link layer compliance fix
- SDMA 7.x fix
- PSR-SU fix
- SWSMU fix

i915:
- Fix DRM_I915_GVT_KVMGT dependencies in Kconfig

xe:
- Increase invalidation timeout to avoid errors in some hosts
- Flush worker on timeout
- Better handling for force wake failure
- Improve argument check on user fence creation
- Don't restart parallel queues multiple times on GT reset

bridge:
- aux: Fix assignment of OF node
- tc358767: Add missing of_node_put() in error path
The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-25

for you to fetch changes up to 4d95a12beba146b0ca2de59c7ce905bc0aadfd0c:

  Merge tag 'drm-xe-fixes-2024-10-24-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2024-10-25 16:55:39 +1000)

----------------------------------------------------------------
drm fixes for 6.12-rc5

amdgpu:
- ACPI method handling fixes
- SMU 14.x fixes
- Display idle optimization fix
- DP link layer compliance fix
- SDMA 7.x fix
- PSR-SU fix
- SWSMU fix

i915:
- Fix DRM_I915_GVT_KVMGT dependencies in Kconfig

xe:
- Increase invalidation timeout to avoid errors in some hosts
- Flush worker on timeout
- Better handling for force wake failure
- Improve argument check on user fence creation
- Don't restart parallel queues multiple times on GT reset

bridge:
- aux: Fix assignment of OF node
- tc358767: Add missing of_node_put() in error path

----------------------------------------------------------------
Abel Vesa (1):
      drm/bridge: Fix assignment of the of_node of the parent to aux bridge

Alex Deucher (1):
      drm/amdgpu: handle default profile on on devices without fullscreen 3D

Arnd Bergmann (1):
      i915: fix DRM_I915_GVT_KVMGT dependencies

Aurabindo Pillai (2):
      drm/amd/display: temp w/a for dGPU to enter idle optimizations
      drm/amd/display: temp w/a for DP Link Layer compliance

Badal Nilawar (1):
      drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.12-2024-10-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2024-10-24' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-10-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2024-10-24-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Frank Min (1):
      drm/amdgpu: fix random data corruption for sdma 7

Javier Carrasco (1):
      drm/bridge: tc358767: fix missing of_node_put() in
for_each_endpoint_of_node()

Kenneth Feng (3):
      drm/amd/pm: update the driver-fw interface file for smu v14.0.2/3
      drm/amd/pm: update overdrive function on smu v14.0.2/3
      drm/amd/pm: update deep sleep status on smu v14.0.2/3

Mario Limonciello (2):
      drm/amd: Guard against bad data for ATIF ACPI method
      drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too

Nirmoy Das (2):
      drm/xe/ufence: Prefetch ufence addr to catch bogus address
      drm/xe: Don't restart parallel queues multiple times on GT reset

Shuicheng Lin (2):
      drm/xe: Enlarge the invalidation timeout from 150 to 500
      drm/xe: Handle unreliable MMIO reads during forcewake

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  15 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  13 ++
 .../drm/amd/display/modules/power/power_helpers.c  |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  11 +-
 .../pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h   | 132 +++++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  66 ++++-------
 drivers/gpu/drm/bridge/aux-bridge.c                |   3 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   1 +
 drivers/gpu/drm/i915/Kconfig                       |   3 +-
 drivers/gpu/drm/xe/xe_device.c                     |   2 +-
 drivers/gpu/drm/xe/xe_force_wake.c                 |  12 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  18 +++
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  14 ++-
 drivers/gpu/drm/xe/xe_sync.c                       |   3 +-
 17 files changed, 202 insertions(+), 107 deletions(-)

