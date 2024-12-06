Return-Path: <linux-kernel+bounces-435637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32499E7A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5FE281EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329A2040BD;
	Fri,  6 Dec 2024 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IhrRM9sP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66F203D56
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519576; cv=none; b=fnSyDXY8cOsptEZl52TT9A4Qab5QaykdiMsVRZ2WZeqzr0kQe+Ii8DwQCAV76SukTblzMnWvSQeCQSVUZnKM9bQew0F4RwR/DSqTTffal4kQqtlPALdZX+xW5A345M5HRG64SOImItEdEd0st45Vuj5rVflckxNCsGAGc4dGC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519576; c=relaxed/simple;
	bh=d1jdbQJ71S8n0oGkR3Gjtlim5ZIOVr5nH5Pxi+5mFTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QtJcxSY3U66VaM7r4bYrZd3Nou0hG+WEHrqnvsWGYwd3J3PnzUeWiPieL0EpxV7yTF5FrKveNPXwpIW9RTYWZdumG9XiH8K+Vl0HXKao1E49B0E23FJf2BxbZFwh7S/Yu3VVhF96fAtSEAT+2l4hQP98gvPH5X+j2r6HOcn7010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IhrRM9sP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so25817975e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733519572; x=1734124372; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hD0H7H5ubasYxch20ZH+UNijxPFs3rYn7B8AKhEqpU=;
        b=IhrRM9sPcwXLDv1Mm+SrkYHDL+8Htbtgm9O1W/fQcbAE7fLxc90NS9nSRE3J0lOhKv
         YNhtDVTCB2uGl7ymJQQRyoz7+swOnJk7s3DG82bWIN7C7A5YeaAp5KHgEC+tVNUhPgeh
         KAoEGM4TwYOiPFAmf0Xkh6hghRp7bplycWILc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519572; x=1734124372;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hD0H7H5ubasYxch20ZH+UNijxPFs3rYn7B8AKhEqpU=;
        b=s/a1vEyqgWR33PuBD9olhv3lI7PKjrb4HYtayjNUZu85OcurwFgQlA0cBKeO0kArgt
         pBZzIShDRPJvKTmS6nJ8bMFOjEuN1SMZd77OHTJ10fUAPIB0hF2ZyBK/TqBfeiBATmYJ
         jgjECwx4MCO5CJ/QanmItBBZnIWgzqWbPLkuXOxCjH7qLUY99XcXfPCdA3xT4Y9q8FHH
         4Lo3KBfVb5MG44W9SLCPH5xJ/wyrSfP/FNKsZagQTw3FWtGRepYdDzOw05hIp6Zi8RjK
         d/4AYGtq8tyLKd/yfqHTIvcr9NjbMC9esUAWm+Cx2OafDgkO2B+itdL4YFoIA+e05wW+
         K/jA==
X-Forwarded-Encrypted: i=1; AJvYcCV1uKnQ41LC1ICee6wPFenT+rANySYwphjuvcgLkZeshVw/qUAiZorZGlu78lucLE2NoVS/H1W15ENiZgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6S+L6yd8HZ0+SAf1D++HThPYmKEhNH+5q78xhreCiZ+r9y8fj
	Dsegas3brfnqdoGWdXA2nP890lRWv4v0faBrdhkfyBpnYbbLeiZj21zi4mBmDy0=
X-Gm-Gg: ASbGncvAGVIv8KATs3TClWZmkovBO/0V34DNDoKFetMyMJ4p0e1JAtjrIYkWPx5dvmL
	aa+V381g3VO8mgTimkvgw+/GhO3fWlPSWJDAZG6B8X7HApFpmvWrCNbG8rxU7n62KWc0t5dNSvW
	EUBMRYZUUk/OSKZNfhB9NyOn8JfwxGfR2DId4U+r6anfmDOtBZOHU7DTPZERkIl6u9ab0A5c8xC
	nm3x/PtWGTGioxV01QQQygGtQGDw22ccS3D8dtmKi2eomN7m4BaDMW0CmDeMA==
X-Google-Smtp-Source: AGHT+IEQ93E+RW8mzHdK01YjyET1E7wKmoxlgSLee47wINTBPgcsQz5eAWXAjPZrycxULCOMofElNg==
X-Received: by 2002:a05:600c:19cb:b0:431:157a:986e with SMTP id 5b1f17b1804b1-434dded65ccmr36326965e9.20.1733519572503;
        Fri, 06 Dec 2024 13:12:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0cfdsm106786965e9.33.2024.12.06.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:12:51 -0800 (PST)
Date: Fri, 6 Dec 2024 22:12:48 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes
Message-ID: <Z1No0B2ZRO5kq7Yx@phenom.ffwll.local>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 6.11.6-amd64 

Hi Linus,

Due to mailing list unreliability we missed the amdgpu pull, hence part 2
with that now included.

drm-fixes-2024-12-06:
drm fixes for -rc2, part 2

- amdgu: mostly display fixes + jpeg vcn 1.0, sriov, dcn4.0 resume
  firxes
- amdkfd fixes

Cheers, Sima

The following changes since commit 471f3a21addd4e5f170ab1364f11c3e4823e687d:

  Merge tag 'drm-misc-fixes-2024-12-05' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes (2024-12-06 08:40:47 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-12-06

for you to fetch changes up to 1995e7d05062097109ea1807778ff8654c2de7f3:

  Merge tag 'amd-drm-fixes-6.13-2024-12-04' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2024-12-06 21:54:04 +0100)

----------------------------------------------------------------
drm fixes for -rc2, part 2

- amdgu: mostly display fixes + jpeg vcn 1.0, sriov, dcn4.0 resume
  firxes
- amdkfd fixes

----------------------------------------------------------------
Alex Deucher (9):
      drm/amdgpu/jpeg1.0: fix idle work handler
      drm/amdgpu/hdp4.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.2: do a posting read when flushing HDP
      drm/amdgpu/hdp6.0: do a posting read when flushing HDP
      drm/amdgpu/hdp7.0: do a posting read when flushing HDP
      Revert "drm/amd/pm: correct the workload setting"
      drm/amd/pm: fix and simplify workload handling
      drm/amdgpu: rework resume handling for display (v2)

Chris Park (1):
      drm/amd/display: Add hblank borrowing support

David Yat Sin (1):
      drm/amdkfd: hard-code cacheline for gc943,gc944

Dillon Varone (1):
      drm/amd/display: Limit VTotal range to max hw cap minus fp

Lo-an Chen (1):
      drm/amd/display: Correct prefetch calculation

Mario Limonciello (2):
      drm/amd: Sanity check the ACPI EDID
      drm/amd/display: Fix programming backlight on OLED panels

Peterson Guo (1):
      drm/amd/display: Add a left edge pixel if in YCbCr422 or YCbCr420 and odm

Pratap Nirujogi (1):
      drm/amdgpu: Fix ISP hw init issue

Simona Vetter (1):
      Merge tag 'amd-drm-fixes-6.13-2024-12-04' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Sreekant Somasekharan (1):
      drm/amdkfd: add MEC version that supports no PCIe atomics for GFX12

Sung Lee (1):
      drm/amd/display: Add option to retrieve detile buffer size

Yiqing Yao (1):
      drm/amdgpu: fix sriov reinit late orders

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  90 +++++++---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c              |  12 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  18 ++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  42 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h                |   4 +
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |   2 +-
 .../drm/amd/display/dc/dml2/display_mode_core.c    |   1 +
 .../dc/dml2/dml21/dml21_translation_helper.c       |  48 +++++-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   3 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   3 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   3 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |  23 +++
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |   1 +
 .../display/dc/resource/dcn302/dcn302_resource.c   |   1 +
 .../display/dc/resource/dcn303/dcn303_resource.c   |   1 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |   7 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.h |   3 +
 .../display/dc/resource/dcn314/dcn314_resource.c   |   1 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |   1 +
 .../display/dc/resource/dcn316/dcn316_resource.c   |   1 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   2 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |   1 +
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |   2 +
 .../display/dc/resource/dcn351/dcn351_resource.c   |   2 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |   1 +
 .../drm/amd/display/modules/freesync/freesync.c    |  13 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 167 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  17 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 189 ++++++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 182 ++++++++++++--------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 183 ++++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  41 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  43 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 177 ++++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 151 +++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 169 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  33 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   6 +-
 49 files changed, 1062 insertions(+), 646 deletions(-)

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

