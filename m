Return-Path: <linux-kernel+bounces-227466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF19151A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7B71F2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDEC19B58E;
	Mon, 24 Jun 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRpD1Vl0"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9013C3CD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241956; cv=none; b=sQR80t/pgDsEX9DngAJ1G8FdrWOmpM9Ub/2EvIaDUYfn8LZvekIyN5tFuAn4bRDK+A/MpJ//6gWijMtE0ey33hUbXcFArvq9TVn6Le2DD4kk2CdqZBf0ME2iv4zsqktPH1F3Ip2ZQRBPoItEBrsbqqKVRlkxpOOZ+wpYKJwNR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241956; c=relaxed/simple;
	bh=Oy8b7DQM3L5FUcDpijV37Yo9Cn03WaVo/xs4vXVyAmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9iTYQz4df4aJiRqY/vfD74USTapWMMnJWtXExFxZNbJL1TwWKnSpp+citaD4OsrMxF/cGPr00jSdFuX2J4wLlvkqvR8XM4WmbnrjNdRqAONTTlkS3TkEflxrBujmy11mWndKvH0KzT/KDOX8Qi47Z62DGAWupJn73kaa1C0nuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRpD1Vl0; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b51ae173ceso16383246d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719241953; x=1719846753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKUVei0D2VbiVNvKS5RQUkYlhAuK8XSzTDtmkdar2R4=;
        b=jRpD1Vl0nU9No5hjdOLUXRNhv/NqNkNKhvSQPSarRaXHXq29YAiW6fbo4zm+DPhug4
         FXCN11kcCZrFtwJYiEZQs5cja8hWl7tsa9PcAp+Q8qRARRcGsDslRIbn6FgZHz4A3xsK
         Df3ic1XAe7wVBZ4LVOqsvfFM+YrP9U/zcDKqUrb10cesDWwr+fvw0LQ9yfaAYfSnI1VF
         nKM2HsRtmafQp7rRtbWUge5wQzDvD5+Nc7n5hAEPST26Vg5nhJOYbaBWHbKIEuMLrWq4
         kF9OfPGF8OnsGmIYnCSH4RenpknJyeCFMurccuFn/OmtCPZVEBDVkPgS3Bfd1UoIgrnx
         //mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241953; x=1719846753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKUVei0D2VbiVNvKS5RQUkYlhAuK8XSzTDtmkdar2R4=;
        b=sJ+GCRym6MLkEh8jK0M0e3Y2Glh1rxTvtc0fkQHsrKLJOk7+r1qkTu3Eqwwbav7c3S
         rrQyeoBCpWAeFWLF6X4aANbZwhmJKwJG1T7p7DhD0/ohpNyupop4nurZr1PTI4YfwPT6
         gcoWrvU7qnXlKcu5mMxkPQEJyhNCV1jcJS4fec4skOD9wQirqDr6LcxTVHCkucglQf80
         Q41BenKVCpuXlBZ4jbJB2HmfTBEJu/Hhul6ev2Fkgvg7SDe803ManNlOh7K17moB36Q5
         cL7rPKH59ZiBydKwPo4+PLFj9Vg8KoN6scfqkWbicEgPNfWLYN6Ef/BTLZUIOeboqh77
         QFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUU0rQEc2h15GeZM/DsS6IUBeK5AWq6Qbi5IgM6w+y4gweojKSxKAAI2J31/lRf1dHXw986O88QBEhWd56LMK7epi6qQgxum/avG4vh
X-Gm-Message-State: AOJu0YzsIEUR9jwg9GhECWdh114NhrfdU4BfHCTrvV+/abMUsDFH1AG1
	Cy/1oa1MDesfpAn6XK9lMkbDPPx6r98cyUQGvP7zRhv6XWPvhMcg
X-Google-Smtp-Source: AGHT+IGQkLZoZU22jL6ZeSbVX7Xh7HWjFnFtXQdEPeoe2xF6REBHYTUlxsEawbuUOvN4TCk0URPZbw==
X-Received: by 2002:a05:6214:19e8:b0:6b4:ffc9:1e9e with SMTP id 6a1803df08f44-6b53bbbe20dmr60711066d6.3.1719241953657;
        Mon, 24 Jun 2024 08:12:33 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b529eb3decsm27243976d6.12.2024.06.24.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:12:33 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Wu Hoi Pok <wuhoipok@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] drm/radeon: remove load callback
Date: Mon, 24 Jun 2024 11:10:44 -0400
Message-ID: <20240624151122.23724-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes between v1 and v3:

1. add "ddev->dev_private = rdev;"
2. include a cover letter

Wu Hoi Pok (7):
  drm/radeon: remove load callback
  drm/radeon: rdev->ddev to rdev_to_drm(rdev) 1
  drm/radeon: rdev->ddev to rdev_to_drm(rdev) 2
  drm/radeon: rdev->ddev to rdev_to_drm(rdev) 3
  drm/radeon: rdev->ddev to rdev_to_drm(rdev) 4
  drm/radeon: rdev->ddev to rdev_to_drm(rdev) 5
  drm/radeon: rdev->ddev to rdev_to_drm(rdev) 6

 drivers/gpu/drm/radeon/atombios_encoders.c |  2 +-
 drivers/gpu/drm/radeon/cik.c               | 14 ++--
 drivers/gpu/drm/radeon/dce6_afmt.c         |  2 +-
 drivers/gpu/drm/radeon/evergreen.c         | 12 ++--
 drivers/gpu/drm/radeon/ni.c                |  2 +-
 drivers/gpu/drm/radeon/r100.c              | 24 +++----
 drivers/gpu/drm/radeon/r300.c              |  6 +-
 drivers/gpu/drm/radeon/r420.c              |  6 +-
 drivers/gpu/drm/radeon/r520.c              |  2 +-
 drivers/gpu/drm/radeon/r600.c              | 12 ++--
 drivers/gpu/drm/radeon/r600_cs.c           |  2 +-
 drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
 drivers/gpu/drm/radeon/r600_hdmi.c         |  2 +-
 drivers/gpu/drm/radeon/radeon.h            | 11 +++-
 drivers/gpu/drm/radeon/radeon_acpi.c       | 10 +--
 drivers/gpu/drm/radeon/radeon_agp.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c   |  2 +-
 drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
 drivers/gpu/drm/radeon/radeon_combios.c    | 12 ++--
 drivers/gpu/drm/radeon/radeon_device.c     | 19 ++----
 drivers/gpu/drm/radeon/radeon_display.c    | 74 +++++++++++-----------
 drivers/gpu/drm/radeon/radeon_drv.c        | 27 +++++---
 drivers/gpu/drm/radeon/radeon_drv.h        |  1 -
 drivers/gpu/drm/radeon/radeon_fbdev.c      | 26 ++++----
 drivers/gpu/drm/radeon/radeon_fence.c      |  8 +--
 drivers/gpu/drm/radeon/radeon_gem.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_i2c.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_ib.c         |  2 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c    | 12 ++--
 drivers/gpu/drm/radeon/radeon_kms.c        | 18 ++----
 drivers/gpu/drm/radeon/radeon_object.c     |  2 +-
 drivers/gpu/drm/radeon/radeon_pm.c         | 20 +++---
 drivers/gpu/drm/radeon/radeon_ring.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c        |  6 +-
 drivers/gpu/drm/radeon/rs400.c             |  6 +-
 drivers/gpu/drm/radeon/rs600.c             | 14 ++--
 drivers/gpu/drm/radeon/rs690.c             |  2 +-
 drivers/gpu/drm/radeon/rv515.c             |  4 +-
 drivers/gpu/drm/radeon/rv770.c             |  2 +-
 drivers/gpu/drm/radeon/si.c                |  4 +-
 40 files changed, 193 insertions(+), 191 deletions(-)

-- 
2.45.2


