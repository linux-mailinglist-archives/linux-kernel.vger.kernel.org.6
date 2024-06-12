Return-Path: <linux-kernel+bounces-212327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA392905E86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460CA2817AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58230129E94;
	Wed, 12 Jun 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfkHK+Ch"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52484D11
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231329; cv=none; b=jM34jtIIylp0jlj/KB1M9bVF9VlDjU/w9c1TBZYYvhAtFYTFzGqWW5Ic+FL5O0Jssd6zNZyafdnIKvH8DIsls7kFQwGlk2TexWztqz6K1XwF/iB8Lsb2Bfpj34Yx2ViD5Y1XINdbMAliFJZNJ2JD0DcYMl4hENKDbV9kodxGk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231329; c=relaxed/simple;
	bh=0YYBkjwBMNK9jlWYzSWYFWWhvwfI5jrnzT5YzQooxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxAZqRUB06NbjDrZhJpuMGxLkk7CT/z1VlSeXh6/R6nUPVDJVXgCSRyZEnX6qSIPpo/KsRKx6/5HdWl13oTLWJYI9WimSxdKUVz7AJeN0ER6/QBERv4weT2DHb3pLf2yewQ9/yImkmwWMGMdO/KqqC7fByaaCYE9sE3PGZO1J1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gfkHK+Ch; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9a1so240504a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231327; x=1718836127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlLfBbnX9FblBpW76gVStblANR7z9T1g0t5a6w4/nbU=;
        b=gfkHK+ChkSFh+w/NVzSJJsuTIMrRcp/tKjaMKQciHGSPZTSKHm9kkkN4oS8mUlftDU
         rHFBs54t4sO4htN/cEEBqRYs9aJijgUnE8Z3yU3ik9zEoJa7v7IQUy/DTgBXDDTiKZa7
         pbZ/Ej/owDBNt2fYjo1tCKY/LErTho2b0e1lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231327; x=1718836127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlLfBbnX9FblBpW76gVStblANR7z9T1g0t5a6w4/nbU=;
        b=YIRunZ8H4lN8uiEFuYqYv6U2TO9O69w+RoINfpxl41DH8rMDEUunOlHJgWFkZdivGN
         v58yjqgvcUl36vI1x8shUZP5GeagiJMzeBZvWF4waKagalmyA36PNCxOxgN8/JIWA1Gl
         1V6Me0s4ApPZU1GWp1evNGSO3aPqhKeAtii2ZsONiIH2klSYPhP32u373gSp0ewRpAfr
         5zQsn8BqaDQSGoNKL3lNFVLItiV8bMI+fhkFUsr4QsIhEdXMKKXttPcj8j0+BY3TVHzA
         HEj/C1b8YXrPfGt5cp3HiM3QkqZeGqVItnIDpv+MBK6lEuNFvIWjvalKk3QKlj3hmwwD
         nnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBFCyjhiYozwDauL/bbAtY2XV88hjaZRMjObUEbwB1FCE845hjWoXDrcIc2TdfM0Pp0epFd4umpT26XHgCnUqvBkPXFpStT6Ig6ZVa
X-Gm-Message-State: AOJu0Yz56SvtgctOsWND4MFi6W1BNrtTZDNtHtJwgymKDctqixC5Icwg
	TsGICcFFj6bgpoM2ol9FecGjougicn47fBe9g0AWQBJpFx92SCLfnsAD6NGwTw==
X-Google-Smtp-Source: AGHT+IHPZkmR/uiNsfI6yDfoiz6DjupPzvyE09FKeunOtYBdIdMpSm5jxkYUgJB/lptf93zhOTJSfQ==
X-Received: by 2002:a17:90b:4ad2:b0:2c4:ab32:b723 with SMTP id 98e67ed59e1d1-2c4ab32b8c3mr2926957a91.29.1718231327185;
        Wed, 12 Jun 2024 15:28:47 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f336d172sm87788575ad.247.2024.06.12.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:28:46 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Candice Li <candice.li@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Le Ma <le.ma@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Victor Lu <victorchengchi.lu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at shutdown time
Date: Wed, 12 Jun 2024 15:28:04 -0700
Message-ID: <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

...and further, I'd say that this patch is more of a plea for help
than a patch I think is actually right. I'm _fairly_ certain that
drm/amdgpu needs this call at shutdown time but the logic is a bit
hard for me to follow. I'd appreciate if anyone who actually knows
what this should look like could illuminate me, or perhaps even just
post a patch themselves!

(no changes since v1)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f87d53e183c3..c202a1d5ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1197,6 +1197,7 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
 int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags);
 void amdgpu_device_fini_hw(struct amdgpu_device *adev);
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
 void amdgpu_device_fini_sw(struct amdgpu_device *adev);
 
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 861ccff78af9..a8c4b8412e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4531,6 +4531,16 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 }
 
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev)
+{
+	if (adev->mode_info.mode_config_initialized) {
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
+			drm_helper_force_disable_all(adev_to_drm(adev));
+		else
+			drm_atomic_helper_shutdown(adev_to_drm(adev));
+	}
+}
+
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int idx;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f430..b34bf9259d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2409,6 +2409,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_device_shutdown_hw(adev);
+
 	if (amdgpu_ras_intr_triggered())
 		return;
 
-- 
2.45.2.505.gda0bf45e8d-goog


