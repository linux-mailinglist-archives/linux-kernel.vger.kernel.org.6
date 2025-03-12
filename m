Return-Path: <linux-kernel+bounces-558594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E951A5E851
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A250617C3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFFE1F1906;
	Wed, 12 Mar 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVEHSrdp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F11F1515
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821803; cv=none; b=TUs1FJquvlQqM1KLQxHUKlk3KgUhnb9jPOcV1PH3FspltEip/WdE3ueWYSng4XsPhXvcfLUKxqKlr0T+a/62EWSrlncuNMEN6tftiBPhZlEzmWslaRfPdYXMcYaF5vq4THXePX8z4a9cwdlEsErT0Q3LHS7JoiO3pzopukJvGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821803; c=relaxed/simple;
	bh=AlMyTKDEpt5SFnEfiL/4Y+fTEsmXPpNzUT5Ac4vNIlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W28ReNLdAKKfIiL7SGmvAgcOItIvIv53f8+dxtXLpX8Rjfc7azBieaLqagk2yBiiqSjDtiQXcfGYN+Ha/kYkMJLVy+3/vSZ7ANgvK4/ZW018U3GSv92HHtMHPSdobdRjUL5oy1DmuiB18e7JzeCmCFMqnDHT1GYAbuoyVvXvf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVEHSrdp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso700734a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741821800; x=1742426600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5XiRjmmSEl/27WyQtk9B76hARduq1iukuO2DeaA0TI=;
        b=XVEHSrdpGmngGZCI/mAg9qlNLLeouVxhA7is0W/xB56GsG+/4ImJsTDm5tFAwy015H
         4nNRLSzweF5C3LrsOZSfYFlKkQejkbdNSsnvEgAulNL21aIHX6uiRQCj2KPUa4CeLa8K
         6UU/F+z5bymQkfqPqXRl5Igt7NcEGesniPF6lzUphjRjWh1YWqQaTona9AgnVA4qRdK7
         pC3Qdwbxfhy1p43Kddbdi2YzWOVOHRWskGskGZyleO8OQrYq4D4Z8o6UWkbY8nmD+BEv
         enis7xbKNZLdTIgK0DnCX4TM9cvupHYiZemEulY9wKDGXZsvrQDUbOUIF8/9dcqqmUiT
         /gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741821800; x=1742426600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5XiRjmmSEl/27WyQtk9B76hARduq1iukuO2DeaA0TI=;
        b=jiFXOJsRvQkF4iR1SK68lWheb/zXNjbKi4pVUrBsmO3NXT/LAn7gI7gTjjQPXURRCd
         QfNZUcuXHcc6pZJtSfWG6kF6PSaHGyHrSW7ARn9UChRWCjsmn5T0aCFY5sAz/H6fgcaM
         DnfpMmNQ2Fu79otw6+57ILl0QRTy5eXLWPlzDZQCu71pGlnQnlXrHKUEisao/hK8dBiT
         7rWjs1gMrNe83Wx3IQBnBtPtEKTaEpAW2f9Wv5yygSCh+a+msgZm9vsAtUINtQsIb0F1
         nTRW8YdMvoOLfZxREaJxBDnIj+E7KnZx2y86M2R72+cX16SngLIzNlTfJQFE+fIUsqL0
         oupw==
X-Forwarded-Encrypted: i=1; AJvYcCUSnHnnoU95DkCx+QDDGuu+RuYkjVpE925Anm8BH/Xvoq9KVLvVW8KBtj2w7kDtySNFlC3y0RiSwwVQ7pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtQg27x4wNnFdsxszzNCL8Ik5Li4e1SBqGIetfArh9wt75XLZ
	7GdUszVDSaUDj8POcW0lt9n29KFya2ZydwdO/wrflt+EFfpzipfS
X-Gm-Gg: ASbGncsn+gBRjnqDQSFUYcqaCnE+uS3XoVmwxgbXvJLx9WpZQb+KoyA/P+LYdPX15q8
	yHY5oxGzk0bpI8dOyb6juThOH7BlFCQ9m2EmuP/USCjCysmD+2KhlC8Hd9HewI1MsY3/2RI3dav
	zp3ehdYdAmNDAcq4Se5LBtqVuEYLeGymKHgF1p9aDcdA88p/6gcyZYOfBkeZbSd9wXks2E+eCac
	IEC0NVmd3v4fCJJ3yfwmI2IJWKO2SDHnhumeWHnfkZv+TVsSfF3cv+WpvypftXZ5Q8wgSRN3btA
	8QrHgphER0pvT69WOwIoVGh1rCAFTktDGr8Lk/iEbbTs3WDQgT4pjklCV+8nzeXcr46g0Nw0HaR
	7RD3TfGxLiNbpISYrnBgI0cm3yZshAIiaqnyjvoWbQw==
X-Google-Smtp-Source: AGHT+IGHCuvkKN2Hnl4IIftTv7iSM7L6WhcdJmI8aN2Zt/SmXrCXjIxp9Wwtgzg+MHajHiqjVl+fZA==
X-Received: by 2002:a05:6402:d08:b0:5e6:60da:dc45 with SMTP id 4fb4d7f45d1cf-5e75f987950mr11542688a12.31.1741821800333;
        Wed, 12 Mar 2025 16:23:20 -0700 (PDT)
Received: from localhost.localdomain (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe223sm26732a12.70.2025.03.12.16.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:23:20 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	=?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] drm/panfrost:
Date: Thu, 13 Mar 2025 00:23:17 +0100
Message-ID: <20250312232319.25712-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allwinner H616 has a dedicated power domain for its Mali G31.

Currently after probe, the GPU is put in runtime suspend which 
disable the power domain.
On first usage of GPU, the power domain enable hangs the system.

This series adds the necessary calls to enable the clocks and
deasserting the reset line after the power domain enabling and
asserting the reset line and disabling the clocks prior to the
power domain disabling.

This allows to use the Mali GPU on all Allwinner H616
boards and devices.

Philippe Simons (2):
  drm/panfrost: Add PM runtime flags
  drm/panfrost: add h616 compatible string

 drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h |  4 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  8 +++++
 3 files changed, 49 insertions(+)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
prerequisite-patch-id: eb8a11e2b24bb282970d8b8528834dea7ee392cc
-- 
2.48.1


