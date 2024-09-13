Return-Path: <linux-kernel+bounces-328589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7797863D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4082827E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598F824A0;
	Fri, 13 Sep 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nikTIQO0"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715081AC1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246412; cv=none; b=vB1gb18qSQt2WPxYXrGG8yEDZsguF8GhVzv7akIjjWpm/oagfZPRRZxL4Pra4rXenlGOg14CBoMpwoNiPOr52we8gBAt1omND0LH6PiuPdlKAZqKf+QiQXIPi0Z4wYK1aw71H/Ok5/2bHWUEZIs5x3citc/jL1EuaBKB7/dQZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246412; c=relaxed/simple;
	bh=bCIsYgwRb2M4qAJXUixFsi60+ShX4ky302YS5MN4nks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZeXseNi/0WB3zUGtxcpSItyMaw2yXHUlI5adTuV6T4OMcH8b0jIC7Te5B1s8GFmb+kXC3LQ0iFI3PI316yTPv6W6Sb7TbcX7pV2eAoK/bufB/zouJU9P2wWyKBMA+QDg8yzuIOTuAtwHMd5mS9rnEzKhVpQgBrHGghwg1c5sYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nikTIQO0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7191ee537cbso1805473b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726246410; x=1726851210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRpY/CVpMYAkC/cmsUyFHgCRongi0M1NU9h2RBhRUd4=;
        b=nikTIQO06mEwdR8UGgMj0zUuJzeB1S6FyT31+F0loW7qLUx/QQpzXbvFQjLBu7LV6/
         T03HXD/xfYzGkgPcwIEJ5N8jxjq7lr1HVGgFoJqCABnUhQQiSFp2BJF4jtbsjy5Bj0x6
         mA4I92hadVOrXpwM0fs8jsdxp560JwzPtmlbGB91Z9rR8CK5ISddUYVDywwv1iJp101q
         u6kOqcaA/wV2dZiKMzrPMr4iA4pX6iEjk7IRg5SgLLtEY5QNuLUJt4DByDVQ5rwFxZCo
         MVSjvlykFUySEPliN6ZPxWpZu/BOqXtI+lwKgb+Y+Q7jJac5/zqVTt+604iQuJWA1/Fs
         MoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246410; x=1726851210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRpY/CVpMYAkC/cmsUyFHgCRongi0M1NU9h2RBhRUd4=;
        b=wXKvhAaTBgLvg5tu3dxyoYdGPc6a8/v7i0KYzKWcXjDjh77FzYnCxXYQJU9bdo6jYE
         88FAbD/soiVTYst9v6sJd2qTRZJB/8VazcoQ/xS/IzoN2Feu7J+DNDl1/yII/WlTmOhb
         rVogbc41kyDhKEIplmgPGo9gmtj5v3jZKaiHAE4ErB2YY8j2NOVz6JA4nn1oakqeKS2/
         LQrgzD2SV9ZCeOKHLo3/snZUKlvkPF+5V5O0u+EN5qxQ95mRXwu3K3GZ0vHzLT/edd70
         e9aQtoaSjoZ+HRJS28mL0b2yk7amCH6yUqO0o2aYKX4L1avzxmoI/mBGUYUombhYYyxG
         AHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYnGkyMHMccUkMd6fvnWfQrLd8fj4BJiQjKsMk6U/OhHWn09noi2D1Qp2+XGxAHri7HKHu//zUT4oey40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6hCCMIH77c8rpiXe0c1a1NV9dlndd8dvXG/269nA3aayf6wey
	GSkjvVxqKP+6IMq//AIaKGeO63sYuCyy5ZYkS3cnorvDrMQxiJcijm12zg==
X-Google-Smtp-Source: AGHT+IGTpWeAJiptrTee9xaItPApwu1R5b8PiG62o5nmp4riaQE4k+sNYOGCJP4vR1hs7n/+rBdjoQ==
X-Received: by 2002:a05:6a20:5296:b0:1d0:3a28:d2a7 with SMTP id adf61e73a8af0-1d03a28d33bmr6257690637.41.1726246409439;
        Fri, 13 Sep 2024 09:53:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc9c7csm6291139b3a.43.2024.09.13.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:53:28 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
	Asahi Lina <lina@asahilina.net>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/sched: Fix dynamic job-flow control race
Date: Fri, 13 Sep 2024 09:53:25 -0700
Message-ID: <20240913165326.8856-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609

The whole premise of lockless access to a single-producer-single-
consumer queue is that there is just a single producer and single
consumer.  That means we can't call drm_sched_can_queue() (which is
about queueing more work to the hw, not to the spsc queue) from
anywhere other than the consumer (wq).

This call in the producer is just an optimization to avoid scheduling
the consuming worker if it cannot yet queue more work to the hw.  It
is safe to drop this optimization to avoid the race condition.

Suggested-by: Asahi Lina <lina@asahilina.net>
Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index ab53ab486fe6..1af1dbe757d5 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
 		      struct drm_sched_entity *entity)
 {
-	if (drm_sched_can_queue(sched, entity))
-		drm_sched_run_job_queue(sched);
+	drm_sched_run_job_queue(sched);
 }
 
 /**
-- 
2.46.0


