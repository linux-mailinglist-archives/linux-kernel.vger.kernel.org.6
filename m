Return-Path: <linux-kernel+bounces-347774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3F98DE76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B81B2D92A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384710E9;
	Wed,  2 Oct 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ocvcwL7L"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034191D042F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881613; cv=none; b=GRWqI+/0Y4c0FHdEfg5MxwcDJTyo0SPGkqJ4lEnIBsTHeHPVeyg3H8ljQJu0obEa6tGTswvhTnojw5zbQVPxunogwg8w0Yct8f1isthotZDjZwLuwjaeIWF/pMJT4Q8Lvp5h7jYI9I/NtxSRQDvSeSoOIiL0i9vG10+Ui9YBQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881613; c=relaxed/simple;
	bh=FqTHeo4RZSP7NMH/J8HOiI6VTuja4/awL59LaUZM97k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LmZGz6sHZpxGHtStP6lTE1OuM8idLVTHdXUd7mCgz4FpwxGDxiD8xvg8L15eUJ+nb9pJtcrJGUKIVk6t7GItIm9hw3eK5gEpZH6zlzbywJuoyuzvdDc52cEKDaw+NtlCkfrkdwdwYByV27a9e5kR7c/xksUXxAWifiN8KAaIS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ocvcwL7L; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb2191107so56546835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1727881609; x=1728486409; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41nRm36lyuHt6KF1YfA/9/W9a7bZ2YHsKcddXplTBL4=;
        b=ocvcwL7Lxdcpy35LrRQiZQJ48QbFqJHy2oFZlFQXAxVhhMON0V+J6PkRPiQBTagkz2
         vWkiM9c7rW8wilmYqSv2AwkVyBrX1F00Q8xoRb5O03jr4EBAmyVKiaHyKLq5IChCSfSt
         8O4p5co3I6NmqwK4pmAAhu3c5uUluf2M+n3mc97zH8qdixw6tmU6B88FMHnFyhSzRlnu
         3iJ0++6sgij1FPzDaaUeydLyFT0eSQOLuCAaOoJnTlF4ueA037egfXzRRiY9JSBi+VXo
         nf4Epgpnjq+qOY8hsHQPj9brPiNJuAXWh48G6SZkI2aghp0IHRyuMTmk5fXzkDOmRsMJ
         vB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881609; x=1728486409;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nRm36lyuHt6KF1YfA/9/W9a7bZ2YHsKcddXplTBL4=;
        b=PMXNY1yOa8OptbzZTx8orXLwFzOo5MmzstI86JtaY+THIa28Z9vmANA3otDbcYDA1P
         4YEZRVGpxk0qjf04R1JygNpv2g675OzRr0rIn1j7JBPx3QCPk2iw8jRaDgd1HOUFWlS4
         rBrkWZph5OZ4WEi2023d49OjbNSqLdyiXtLY1U2DAxqE6ISxSXUTEd7KBbC6ZGmLzIOS
         RuHJVzbdR7bjxwah2xqCAZJUyPdem7/cIx74699Pwb/PM055a36pRxvTFEg9mtRtzdpQ
         nPL9Fun0H3d1PamsP81Kn7e4jer96kDyir3+uE+dvDScwvKpnYsR4UykhUg0AylMZ0cj
         I96A==
X-Forwarded-Encrypted: i=1; AJvYcCUkiqSW70bZV6elfYGfsuBOEupwAlZ+aCodqGgxkLybvNp0940hrrjzQAjryGDJ8wC6KMDYep7jJYm5P7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/4yaI9AL5/lhHarsuEcd3XQpq5ISCUhgF5EZdowio/aU878G
	Q6HCkzFmCURnXYVeq9m5o9U6XtQAwNC6e/qeu+Hxikola8bOvtARf/h3kGuQPS4=
X-Google-Smtp-Source: AGHT+IF71RqA4NOc6VzRPxiHsdLPYy5sAvEvkNLIBeF+tbvu8AmidAXt6YoGr9HXHEWuwjGMwmfNEA==
X-Received: by 2002:a05:600c:1d20:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f777b6d00mr25845175e9.10.1727881609131;
        Wed, 02 Oct 2024 08:06:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ec0a44sm20794485e9.17.2024.10.02.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:06:48 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 0/2] drm: Fix up and error handling after fbdev changes
Date: Wed, 02 Oct 2024 16:06:18 +0100
Message-Id: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGph/WYC/x2MQQqAIBAAvxJ7TtDFg/WVCElday8WChKIf086z
 sBMg0KZqcA6NchUufCdBqh5An8d6STBYTCgRK2kRFG9ttEFqjbyK6L2xim1oPEBRvNkGvr/bXv
 vH+usGTJfAAAA
To: Maxime Ripard <mripard@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

I was trying dri-misc-next on Pi4 and getting a NULL deref as vc4
started. The cause was having missed adding DRM_FBDEV_DMA_DRIVER_OPS
to the 2711 struct drm_driver, but also showed up that the handling
in drm_fb_helper_single_fb_probe could fail to call any fbdev_probe
function, and hence the NULL deref.

These two patches fix up vc4, but also throw an error if neither
driver->fbdev_probe nor funcs->fb_probe are defined.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
Dave Stevenson (2):
      drm/vc4: Run default client setup for all variants.
      drm/fbdev: Ensure that one of the probe functions is defined

 drivers/gpu/drm/drm_fb_helper.c | 2 ++
 drivers/gpu/drm/vc4/vc4_drv.c   | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: 86fdd6b9b1e98cfd26249505e8ce72f4fc0de37f
change-id: 20241002-vc4_fbdev_fix-f4c8b11928cd

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


