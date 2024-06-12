Return-Path: <linux-kernel+bounces-212316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09820905E69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F00A1C223BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977112C484;
	Wed, 12 Jun 2024 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zec0UYnO"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB99129E86
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231087; cv=none; b=AqUCbNa9RXETmWsM3Fu9TkMwbC6D8Cyqc8mpmqK5ABuJv6JLd8/jPUYJ7BhAMP4iLXDH9a/wyqMBPfwIhnXRNEYgfMvS2de1/hYhC57pysgeHJwqVrG/zbGwxyEhB2ZY9h5h3+M5Ng+plAboB5fnTX8vrqQf1PXV5/wHsxZJKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231087; c=relaxed/simple;
	bh=MzY9RSGkVht2aXs2PA/k/TDRM4oP57qTRFAWTRHZiAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8TnE7pToXfJvgTuzAxmbehIg/PjxmUcJXCKrIJOsaJSoh52b75uTVwGGTpomM/P5Lcmg08vOPH6klEJ/lNyLniWsUfpetr4WWcVqm0rsbhut05a1F19nH3EyAS8ntkcQItu6PZM+EGCGAYMKnFYur4CsMbIZkisz3pXsmEhdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zec0UYnO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c1ab9e17f6so257914a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718231085; x=1718835885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoxHQFAxTEKhFcdkzLVS9yQebfe3JVmywDzGyzZKvTc=;
        b=Zec0UYnO5BkYSIvg4uS/B/X9eGKwOXDuGsWyK+yjuuJNOb9Z8Qk5fLwxk60lu1cChs
         BigKjMpyD8mWXN5RqVWNw0VDYHq8pY0Xk7sI+cZGFF43YTMGEjf1b4KtASUYpguB/8ni
         P29v8sdU4rZaTtwaXqJUIpLxySc94l6iDI/ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231085; x=1718835885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoxHQFAxTEKhFcdkzLVS9yQebfe3JVmywDzGyzZKvTc=;
        b=AuN0ypD7SKC4cdG/pDPJVI5rzLJfTrRnNavyICIt360pldR+dmmlU8Y9a9k9Qs+x5Q
         Z6vZzG5PVcVWwhyqVw6B4413zNsjMAWYcZ+aec+Aqx3WzeOM9DpoI1QSzFmIfenFhUry
         cbMiJjpTs6vf+ZK99mVeq6rlg09SxDT6ViFxpL9RCVafb3tCxQbeoeqo/VZKPSEGgZE3
         vw1tOHw+oW4Mk3cyGT3D5mugLNoNl9Yr+qc8jDi7Ht0A3ovp6dfBxM86cs+KTSAxwrJI
         JbpHAqO6eOLxDz1L77p7qebXvS+nzy+FV4frVWh8Hr3MpETMf/6IsLYFFBniOaXVCm0D
         1XDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh3wG8gHmupKzR8QD6uiVRFMzGBLlBwOAOQ4uEo53KekvKbF6rpDwPfSTDgBh9U/prkaTSs3pjzqtWZQgJU1SfhPiRM6tmuBOq65G3
X-Gm-Message-State: AOJu0YzY5wyFDg6Q3opmvvKhlwqWOXJHCBastlhPGYAhla2MZqEmXD10
	92MQ+3xsmbeD63MDCX87RH0I31CTJCwah77UAgDyqMQtNvp8Ntgr/9f2bAql5gpizONv+3bSuNk
	=
X-Google-Smtp-Source: AGHT+IGoKR+i8ngPgUDnHIH0M19hh39IIq/3uUrBXIU2bl3u/ZzKf7epk3yumtBMdDz0FOKiHNHMNA==
X-Received: by 2002:a17:90b:17ce:b0:2c4:aa69:c4bc with SMTP id 98e67ed59e1d1-2c4aa69c57bmr2820224a91.19.1718231085222;
        Wed, 12 Jun 2024 15:24:45 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:2816:6a42:9074:18cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f30acda9sm87914105ad.198.2024.06.12.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 15:24:43 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Edmund Dea <edmund.j.dea@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] drm/kmb: Call drm_atomic_helper_shutdown() at shutdown time
Date: Wed, 12 Jun 2024 15:23:41 -0700
Message-ID: <20240612152336.v2.1.I20cb02bafa7c2368e4bd579df0716eb62a3a21bf@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240612222435.3188234-1-dianders@chromium.org>
References: <20240612222435.3188234-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

(no changes since v1)

 drivers/gpu/drm/kmb/kmb_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 169b83987ce2..73d82b4d33e7 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -475,6 +475,11 @@ static void kmb_remove(struct platform_device *pdev)
 	drm_atomic_helper_shutdown(drm);
 }
 
+static void kmb_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
 static int kmb_probe(struct platform_device *pdev)
 {
 	struct device *dev = get_device(&pdev->dev);
@@ -621,6 +626,7 @@ static SIMPLE_DEV_PM_OPS(kmb_pm_ops, kmb_pm_suspend, kmb_pm_resume);
 static struct platform_driver kmb_platform_driver = {
 	.probe = kmb_probe,
 	.remove_new = kmb_remove,
+	.shutdown = kmb_shutdown,
 	.driver = {
 		.name = "kmb-drm",
 		.pm = &kmb_pm_ops,
-- 
2.45.2.505.gda0bf45e8d-goog


