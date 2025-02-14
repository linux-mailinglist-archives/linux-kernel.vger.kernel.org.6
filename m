Return-Path: <linux-kernel+bounces-515155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E0A360F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E8C1608F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275126657D;
	Fri, 14 Feb 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lAhHOeks"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808E25A63D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545543; cv=none; b=Lgthak1AL9gQSie6A3JyXun5vIWx1exwMqeUebocFMlXEiL0tA5dXQVVjSDIdnGidmLy2iekpxw81gfbonCG4k1xJ1g8opKqKnf2UmNlk7MB+ZHOvhTu1KTAwjnD5MTK6SIH7JjsB4B2GIfozg7oJTuVRtfZRV74LFbA+jYZOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545543; c=relaxed/simple;
	bh=FvXY0J6HFmz+F4kGGhdiUtByaCV/93S7mXHV8f989j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azrbUH6PVMh5ZFmZktTI9NtqkOrcqyLl4yaMHzJSynwi31NmQ0g6uPPzC8BM9WYqXmwA5YzKjGwwBC4rPa1Vdijp/xaLZA/seTuEBB74BYya4PMmQ2PlPT78cHjKHFwC7l4q590YD+BQRzDkd4wI93A3YpySBTAdmZ+HkZZRZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lAhHOeks; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7c14b880dso73565466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1739545539; x=1740150339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jC9QV0bJcgZgqHHH3SUMbf/vptPD4PQ0vRL1kkv5HIw=;
        b=lAhHOeksAotTY7BZ+9HNMkCvrxASeGTLQulgd6SrlEyYhNZcom1u1A5cCXlo/Tf+9j
         9Yo1o7X3xBMO+7JOMPVSTUllnS3Sd6xdlpWycmb2YVfrjn8DM/P48iHmfJq2m279DxpQ
         QYltdIjnNNA11bPxFfwuYUdrkeOnxT2TkjT7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545539; x=1740150339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC9QV0bJcgZgqHHH3SUMbf/vptPD4PQ0vRL1kkv5HIw=;
        b=fM9TMvyV4sKd07We0b2PvfEWWqe1aCzh9pcRHiTEN/uYbh21/01d609Y1jpUvjhBFr
         IqHZb3daBSnAlPuZh77tCZjlPdNezVAkrVDa7ZpzgdRU+7N45J7LNTX5BCfpHX6YMHrc
         of57QnFQ88AaC5GOGQoJDqJyVmjiK6UXTQII7IdsXS+A31XW3M55G+u+63pTFfFKcc2+
         Rh4cEUqmZ8asSHNXqIwW9WK4+Fbh3Ibv4STfvuBGT/OqKrECwBBP3WI3ZBzf3IHLiVmF
         c8+G+sbZmGt4ivHFoGt3UWq6NDh+WXU8tTaaTRrhVCZZ37nhcJdInh1vOBvIxmhvhhhV
         KNmw==
X-Gm-Message-State: AOJu0YxHZspwZM0jQxSmN2rJaLg0GSinoI4rAbblwqDMyiwc60SlYOvh
	FTQcePL1xn60K93Sj0o9vsIui8AsyeY+t08p0tA8EE+qCTskzJZW1EWPY5JVgNhCGtBz46ywqd0
	K
X-Gm-Gg: ASbGnctSVzVLzNgL0xwdVBySwgOJrztCV/viqwrhTuZ7ikYyJfXFTWI5NFNZ/aVcPj6
	GGv8aZyjLyr5TVegrAa3ZhTWJhT2yNVGQSfL63dEegb5SKQe8t0fvLuU+ubUF54abtnOyiAHJwq
	Wv/5oQjZBayIx4acUOhq5fTPS96jOWZCbbem/lOID72gaS2xvHFgSIP29K01aN6/IxIat4gUq5A
	R43ByBJaV5lnNeM/h/8Ok84mqk1hIFzrMa06+BL8Ccc0Qeo/t+TX2q4FExToUjdJX04MYP5cBJI
	n1IoAOhrshXUqJ3CUfY0Gs/e92IJEdBZfmiOTYD/B4zd7eNubHHR6Aqr
X-Google-Smtp-Source: AGHT+IFZ+c7+go5Wo3r0b5Kv+36ob4O06Y3nn1YLZvsFSFjUvUi9yBoXLR53Qg4HfytiBB896uYB9A==
X-Received: by 2002:a17:907:2cc5:b0:ab7:d179:24a2 with SMTP id a640c23a62f3a-ab7f37149dbmr1273515166b.1.1739545530075;
        Fri, 14 Feb 2025 07:05:30 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([176.201.8.20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dedddd5b82sm1421906a12.30.2025.02.14.07.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:05:29 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Maxime Ripard <mripard@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Stefan Agner <stefan@agner.ch>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v3] drm/mxsfb: Remove generic DRM drivers in probe function
Date: Fri, 14 Feb 2025 16:05:19 +0100
Message-ID: <20250214150525.1505210-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use aperture helpers to remove all generic graphics drivers before
loading mxsfb. Makes mxsfb compatible with simpledrm.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

---

Changes in v3:
- Add 'Reviewed-by' of  Thomas Zimmermann

Changes in v2:
- Use aperture_remove_all_conflicting_devices() instead of
  drm_aperture_remove_framebuffers().

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 59020862cf65..e5eb644b54ae 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  */
 
+#include <linux/aperture.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
@@ -361,6 +362,15 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free;
 
+	/*
+	 * Remove early framebuffers (ie. simplefb). The framebuffer can be
+	 * located anywhere in RAM
+	 */
+	ret = aperture_remove_all_conflicting_devices(mxsfb_driver.name);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't kick out existing framebuffers\n");
+
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto err_unload;
-- 
2.43.0


