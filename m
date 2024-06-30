Return-Path: <linux-kernel+bounces-235284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF191D2F1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4205B281291
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88415278E;
	Sun, 30 Jun 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnRRbNch"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44312F5B3
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766833; cv=none; b=mfSa5XRu2Zuukno2HTkbiMsvRORFBYVc8tkdo0TA5lhSB5NMVx9ACOLIK3hyyWUAx+IsiAyCyKXuTLze3eltwGY9hZwV5mzXccLAqBuquwTyqxfbpj7LIi46KNTXzivgINOYBogoEzXMRBRIw0JvmSTEJbR5VUM+R84mbSePGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766833; c=relaxed/simple;
	bh=+xeMsIVqntr6HGOzbQMMMZq4BWWdy4//htPjAUdPcx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBIiEXHNtzvqpk+M68F2oMefYKDXix+2ISSVB7fsduA9/a96OV5OCEX0wv1MbW66Bz2rX8SqTT29M9kfvb6ih12GoZ5NKew3faGvkD7Okyu83EdGoUslcmsfpmkqr64pFggGMQuCTmZNydrEDa+hoOTcSdlOj8lhzShsmyl3y2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnRRbNch; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79c10f03a94so186377285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719766829; x=1720371629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhZDIO5zwyKjVc4uVRuo8HZwK5NnMF2vQ+RShUGl63Q=;
        b=LnRRbNchyYDHH2l6k4pAXxZ7IoQERUzY/ZexBHeAWNvuh7PZJ/ESFN7tFNVGi9wcgx
         OkrWu0CaR5/Pdifnr3X6CxkqUCAX7NgoHGddVf7mX/aQF/gXo8ojFNIGm+uqhcsUkufz
         bWGoHyyhnEohbtJlaP4uELXxOvJRwUslyAKDKONkTiBpu2qTS8BKiwXdGZbkx0zmCZYI
         +5aYZc67VXgifOXSJR+7v9U6K01qIlibWhmw8SqeLJVGv4UVNdzTijvs17mSc61SA5MX
         fk6slwOPaE/4tn+rgGxAt0weKPHVX6KPdYAsRO6Dxk/NZMcnTp/DJ736Qk9i3mbRtW4P
         oZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766829; x=1720371629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhZDIO5zwyKjVc4uVRuo8HZwK5NnMF2vQ+RShUGl63Q=;
        b=mVtmJyQBHLdC/VX/oQVBKdQJcg51sp2ZTF/AL37nAOn86JACVwZYjvRXAGdl++Rx/j
         cvdxOOCGbSsjp4V9SDyOlg4WR8rcaaSgTAx0z+KPzllPhBig6HwmtnueB7ILG1/DT6v0
         PciySe/VWcDl6qULyjIjDRloGOBdxCYaDxidzL9IsTama/qU/PRdDKavVkm6FqJBxLe+
         lyRcAtzb6WwJ676zq8e4s5h15Zqf7cKws/lpHfU/iKEa2Fr4tmuPAlKe1vz1HVVqJ7TV
         pAqpJscY1qUA46VmfOXdBZoj+041J5r4Cne0ZmjW8l9Hagg41uXzmIlij4XjDEC4XXWJ
         miKg==
X-Forwarded-Encrypted: i=1; AJvYcCVOtBTiXyiKHPGcrJ8x5iJbXcxp5U4WAg1/Rvfy1FBVe0y2qlmVNjGMnfBZbxsrQF+H31Wo5VgvrxyCe7PL/Dwz5Gy5KXTFd34NtowF
X-Gm-Message-State: AOJu0YzAxOf8hAnpkg1q8pJS8cQo4QaZTB0o4TMLR8RYqvJfmmt1nOLS
	YAFBr4J1323xBDSJ4OPChxYS7dZHyahbao/9mz1GFKJ++d1cQzDn
X-Google-Smtp-Source: AGHT+IEQWZf8Yo6gbgwJLFPggay24R6Ukeci/k2IqD6vqXm8jI2MY9xxuql7xgKaTohH6ACn4xBJfw==
X-Received: by 2002:a05:620a:2a06:b0:79c:11e5:52d0 with SMTP id af79cd13be357-79d7b796fa4mr645307985a.18.1719766829645;
        Sun, 30 Jun 2024 10:00:29 -0700 (PDT)
Received: from localhost.localdomain ([142.198.217.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295f5esm263431785a.56.2024.06.30.10.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:00:29 -0700 (PDT)
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
Subject: [PATCH v3 0/6] drm/radeon: remove load callback & drm_dev_alloc
Date: Sun, 30 Jun 2024 12:59:16 -0400
Message-ID: <20240630165949.117634-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.load and drm_dev_alloc are deprecated. These patch series aims to
remove them.

v3: Both v1 and v2 sucks. v3 improves greatly on readability.

Wu Hoi Pok (6):
  drm/radeon: change variable name "dev" to "ddev" for consistency
  drm/radeon: remove load callback from kms_driver
  drm/radeon: use variable flags as parameter
  drm/radeon: add helper rdev_to_drm(rdev)
  drm/radeon: change rdev->ddev to rdev_to_drm(rdev)
  drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc

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
 drivers/gpu/drm/radeon/radeon.h            |  7 +-
 drivers/gpu/drm/radeon/radeon_acpi.c       | 10 +--
 drivers/gpu/drm/radeon/radeon_agp.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c   |  2 +-
 drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
 drivers/gpu/drm/radeon/radeon_combios.c    | 12 ++--
 drivers/gpu/drm/radeon/radeon_device.c     | 13 ++--
 drivers/gpu/drm/radeon/radeon_display.c    | 74 +++++++++++-----------
 drivers/gpu/drm/radeon/radeon_drv.c        | 27 +++++---
 drivers/gpu/drm/radeon/radeon_fbdev.c      | 26 ++++----
 drivers/gpu/drm/radeon/radeon_fence.c      |  8 +--
 drivers/gpu/drm/radeon/radeon_gem.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_i2c.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_ib.c         |  2 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c    | 12 ++--
 drivers/gpu/drm/radeon/radeon_kms.c        |  8 +--
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
 39 files changed, 184 insertions(+), 179 deletions(-)

-- 
2.45.2


