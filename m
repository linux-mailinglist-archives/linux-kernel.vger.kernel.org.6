Return-Path: <linux-kernel+bounces-386802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C29B480D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D8F1C26895
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59D20495C;
	Tue, 29 Oct 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kuKiZAgZ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2C2038B2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200397; cv=none; b=Haj40+C0HG/O4ygvL1PuUAAdQ3XsH2RIgDKSb5g2l5Zw38LI4+NK7xVbncTS8nc495m9sRyh5ofGDHJ1qTXWtJZo9UHPolm5IxFdD0CbkIcJgMUCFx1Z7SgyAUD1Bgwj1gTrj+am/t+61l7S8OuBrSn4bR2uGL5HHnoZ+mXt9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200397; c=relaxed/simple;
	bh=z2WWDLA9+/P7St6pxbSgfCvDAmm6/I51/u7qsYfzEZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEAH6QLvdb1nKTotDD7Wle1/cPCn68WiojopxxTP4xA5B98B5e5rrYk6SzBEhUCwbZyTInqq2jvbxBzpA/8WraxPW9CnVj6wJqSxz6qbGFwyLn1nzLf5lm9WncEVjewb4DIBqWLlsQQflfN4Bt9wYZY5gI/IUxi8kvNMQUZjeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kuKiZAgZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-210e5369b7dso14990805ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730200395; x=1730805195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0505nJjQERl8lxM/9PvfVg4f+qO1mzi84QJZy2KWoxQ=;
        b=kuKiZAgZZV/T/SVKiiyfyz36/LMoBBp2TuBEr1dSMvIWvvOic+ZR7ztAV7otqrJImU
         xRcSn2pdWIwYXPxo0yapkYoCBLA8d7BiwtHZAjZVlskcgDyMGq9Do2IUzLLRKEfYCoKG
         ESFaISnkJqHLAmYtUvEiYi5usjOTiNSZNbVIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730200395; x=1730805195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0505nJjQERl8lxM/9PvfVg4f+qO1mzi84QJZy2KWoxQ=;
        b=Atw2TUwoMrtdnxSqC3vUsLqQrNI2GK6Veyk9SpjQloIYmPwBdwZ55OIVZbgcaRgjj5
         Aa3RjG+/5FS8a7NGN9sNBW1vVy6FD4MgTOGREUdEcTc8BF0mpRC7Lf3rgacpZDdYhNb/
         EBcnKaE78w5npvp578dyrWFEFVRSXUE/HYVn3SHYf70n5RJ/6IWnLhc+iVla4nONA+L6
         nSwhiS1NLTzOj6CvNf03ZVazzAnQoNMf6uxe7TTp9Qhb7yWywaBimw6k6HYqwy0lCiM5
         GEAjGw7zVdnLab4JW0LzmbYEwF310hOD9HNccPe1iIzgLWv97vCHmMeYVHXl5He2Y2hB
         VQCw==
X-Forwarded-Encrypted: i=1; AJvYcCX+lgf4CaJumYivSU/mzrEuyhtiKOwJT32pTKlkGq30YLe75k6dqDkP3GXjXqMxB0uGvFsaclsXBf5jTvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAS/yeivBkNqtnBsgbgidFlAQ9dFk2bHHXjX2R/TRV/sjNt6jI
	o3oqtmbQXj9Qx0Yzj4p87vNmpmkWRkReOt2QP0ul3zVC5OvcQa8Iy9NCs9qizw==
X-Google-Smtp-Source: AGHT+IGrd9l1GlM2L8PMQ11t9vsR3WqEyNxK+9h4vC9b0I7xJAWHJVP8EBwRriK40RxJRSAsNNrEQQ==
X-Received: by 2002:a17:90a:68ce:b0:2e2:a8dd:9bb5 with SMTP id 98e67ed59e1d1-2e8f105e834mr12056484a91.12.1730200395327;
        Tue, 29 Oct 2024 04:13:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1fef:f494:7cba:476])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572e69sm9280776a91.16.2024.10.29.04.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:13:14 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH] drm/mediatek: Drop dependency on ARM
Date: Tue, 29 Oct 2024 19:13:07 +0800
Message-ID: <20241029111309.737263-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent attempt to make the MediaTek DRM driver build for non-ARM
compile tests made the driver unbuildable for arm64 platforms. Since
this is used on both ARM and arm64 platforms, just drop the dependency
on ARM.

Fixes: d2db0b8fd70b ("drm/mediatek: Allow build with COMPILE_TEST=y")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
It looks like the culprit commit was merged through the drm-misc tree.
So please merge this on top ASAP.

 drivers/gpu/drm/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 2e0e7c4079b6..f496e6cfdfe0 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -2,7 +2,7 @@
 config DRM_MEDIATEK
 	tristate "DRM Support for Mediatek SoCs"
 	depends on DRM
-	depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on HAVE_ARM_SMCCC || COMPILE_TEST
 	depends on OF
-- 
2.47.0.163.g1226f6d8fa-goog


