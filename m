Return-Path: <linux-kernel+bounces-247343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9194B92CE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4142B281001
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF718FA26;
	Wed, 10 Jul 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RAaMU1DY"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06484E0D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604005; cv=none; b=FvrL9NojxE75h2UNxt9fJFBfpFvB/fNiYw2voST+WfIkDgo4W8LyggS0TRamW0h1L2qw6aIvX35ZT5ckWgxZhWRIoTHAw3jwwiActQ+7POnY+32RcwlwtL+pz1iMNw5vR7404eUZk1/OJDWK+KrKDkVMtqJLwOSSDBpk4QtlttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604005; c=relaxed/simple;
	bh=N+dZVEJ8nJMAFRXQCYmz3Dujgc4/GF2zc1NIyCFnmmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y35i3skWkB1pyri1ULfgqf8521WSzJIi2gnE+AEglMJyeDW/a7mKAh+lwUwWxozWt9Hj30p8okVoeRWedRjzvvQssNrZdEzsbsHhmvoWsnqpr488e1mH8RBJ37GTgHje08IVy41BTUYY9KSU4N2+UCr4gnxf/ePahl4cXS0bX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=RAaMU1DY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9ab8b7cdso784322e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720604001; x=1721208801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTHGZWFFIG2y8znG1jvML///poV3IrhnVzz1kC5uonU=;
        b=RAaMU1DYxFpW2zRlE5w7W+C+/UqEpGSH9cOtRdWVZgc6zye8fn/QrPGJpmL3HgEUKL
         P2hcjvLMXAWmBEhrnWxB9IAvtSs6m/2fYc9cbRX+/AG9D0SAWkkbGZCd6VcC6wOQ5mWm
         jfAULBDrQEQbxYuP1ROSZvHJL+QR2BJsxjDGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604001; x=1721208801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTHGZWFFIG2y8znG1jvML///poV3IrhnVzz1kC5uonU=;
        b=uBZR8Pj+aSqTsWiuqARasrljI75hhwdYVgNIUEkRi9PF26XkfXQkXYPtw8jszEhQFk
         ES4JZWMj/ArLs7cUcGA1uU7m/NH/t7JJNn9lYbx3U4xKIk7c5DXLu64/koGZDqThNe5k
         yQCgfVeQFfLP7Cw6DCJj44YdlCRqUlcMzro1oAvzeYbOr/cunxXgzNiRV1f/ZMfOzP/n
         Jk+cVL+sBxgeRw41PV4+eZv9tE5xBBv+Tf89TjoOsgMGrao8uey7aoYjUH+x7cuXbJJB
         ZWij45TQC80FHHqIDCzjW2lLc+lm7kNxeNrEyv234InYjklv5ntuw1XzUhTUAtcR/Fpt
         +1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVbAnGe0vl37Ty5QlUbjyVx6metXc6oTm74U4PROGwvZPDsgvzBfYWEW5iHOUGYs+dIvReYJln8QHTSVaPalwsP8wfwlbRXrfC9kmtP
X-Gm-Message-State: AOJu0YzarLeuw0ZR7+BQdgBFQtE7XyzE2H007k52nqsk1aEcW5lLjx/a
	Zr68SKJWA4emHzekXjb3YAeGwAFT8xRB0Lpfr8aAZ+sD8MMhvl0BcAwnsg6CAeU=
X-Google-Smtp-Source: AGHT+IE53obXe9iAhMtu+VAErcsSEkowso2ZAWhhq6KbgW5hVFggamUEZCMm4iphO7D+n2JaklYQbA==
X-Received: by 2002:a05:6512:10d2:b0:52e:9b18:9a7f with SMTP id 2adb3069b0e04-52eb9993c36mr3246261e87.2.1720604001546;
        Wed, 10 Jul 2024 02:33:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a27sm73448935e9.23.2024.07.10.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:33:20 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH 1/2] drm: Add might_fault to drm_modeset_lock priming
Date: Wed, 10 Jul 2024 11:31:16 +0200
Message-ID: <20240710093120.732208-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We already teach lockdep that dma_resv nests within drm_modeset_lock,
but there's a lot more: All drm kms ioctl rely on being able to
put/get_user while holding modeset locks, so we really need a
might_fault in there too to complete the picture. Add it.

Motivated by a syzbot report that blew up on bcachefs doing an
unconditional console_lock way deep in the locking hierarchy, and
lockdep only noticing the depency loop in a drm ioctl instead of much
earlier. This annotation will make sure such issues have a much harder
time escaping.

References: https://lore.kernel.org/dri-devel/00000000000073db8b061cd43496@google.com/
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/gpu/drm/drm_mode_config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 568972258222..37d2e0a4ef4b 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -456,6 +456,8 @@ int drmm_mode_config_init(struct drm_device *dev)
 		if (ret == -EDEADLK)
 			ret = drm_modeset_backoff(&modeset_ctx);
 
+		might_fault();
+
 		ww_acquire_init(&resv_ctx, &reservation_ww_class);
 		ret = dma_resv_lock(&resv, &resv_ctx);
 		if (ret == -EDEADLK)
-- 
2.45.2


