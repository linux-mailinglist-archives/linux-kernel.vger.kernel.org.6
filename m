Return-Path: <linux-kernel+bounces-302807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C768D960395
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9D2846F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7B187FFC;
	Tue, 27 Aug 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEfarp0N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323F17CA02
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744768; cv=none; b=M4y2qMDdByhdVjWTyPKvOTwZHvKogiPCHqG7Aq6eFs1nyqdcGg7AtLsntTpCTmy8mVYoG+W0YwrjRJ0eTNe1ckzEl1xE2OvujG+BW47BaPEiCg0cEakCEKX2pnQ1Dv9YV3XCxAUK4iT4oOWy/bFq/cpxLYgL0i12PKOPGsbLwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744768; c=relaxed/simple;
	bh=Hs1dg5pWD3I295WazAy7VaA30zGQGLIk8UmdYXw78Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAfJwQHB1U3KFQRrjNkAFIHJVFTieDSX1umkB25zTFa+OkSo4DJ+Qf2GI0lgVZbVjVIEgCrgjBOaq9l1hVFHs+dnHHseda9sQ9hVz9qy5y5UvgwibiBNbvrDhTBpLCMAnQYWf+2Q1aggJS6MuO2x6qnJg0J/23y8S6kSEM3iKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEfarp0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724744765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCIJZLOyjsTHc0FIhkASd9ONi97hrv0PKkErCwe7I28=;
	b=cEfarp0NqFa29GNsV/MPGeHN4BRuLvwCzPl3JOOJ9bpBJtqS9vI+2f9u+sL+t5XfHriY4M
	UUS7uXKZRFPDEj8hv7ZG58uWUwGxyWiV/A/Nx79tRMZ5hzwxC0moOK1fYNV3DboHPoUBrt
	3zepomTH2W+hDZWSht1YXvOv/HFBN4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-QTViIdjmNL2AQwbGmkV6jQ-1; Tue, 27 Aug 2024 03:46:03 -0400
X-MC-Unique: QTViIdjmNL2AQwbGmkV6jQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so49506585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744762; x=1725349562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCIJZLOyjsTHc0FIhkASd9ONi97hrv0PKkErCwe7I28=;
        b=Rfn8stW9O7BJe8KJiEg3d/X63TjEWJl9Y+4F9nmJvnIZhBqwU+lnY+a4woIgQwMeHY
         DQhCxtRHaiGz6MqysQNiYFTfmeRbn6VKKWuodLG+v3gvx9sr5wRXDwO+WeVg4H+/tIvg
         NyqAoOu7yKl+jRdd8QCxcbMhoGyPk0VP2xYJsWmpnD5m10/tgfahcw8GoDkfbNQRA5rz
         /fhi/5rb8L/3LxD6KCMjGiq2XuNrtWNuxlh3mUXXf0NiSGMNgJhXw/sTKKpjK9EBz+iJ
         F1JOsV8Is4BdZGTYaEKHuQB9wBsXngR8590JKc6N4OWA8RbNN5XSWmd18EBJNGMYYvlo
         NNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGet6cKJ8IdkFcvN0aWOFRJgC7SXkmE8tRvYj0gKr6Af7DIz28uZh3a6dGue/Ko4VIckdWe+JkreFkAuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKDbKa3KddPNrYrcPl7OT3RqYfVFY2f3vREHWGu2ZayYcB69w
	2azfecRfcFOAqOqzA10icNOXbVoE31Fvhvw86UEUQXiDsnggYFxk623ArYGHThhXnRkXLOtalG0
	7cZbfZNH06AKUDecRzRoTowygM4IfPzi/3cQJ0JSubTJQQ7uMUgvdCTcd0Qaeyw==
X-Received: by 2002:a05:600c:35d0:b0:428:1799:35e3 with SMTP id 5b1f17b1804b1-42b9ade4cdfmr11440895e9.21.1724744761785;
        Tue, 27 Aug 2024 00:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGik2Opx3PDeJb8i8wW51P+RCvHvq1UmLg7w5MEaT370ExIUUEkmFSlpr26Nf6rxq8yfswqKg==
X-Received: by 2002:a05:600c:35d0:b0:428:1799:35e3 with SMTP id 5b1f17b1804b1-42b9ade4cdfmr11440615e9.21.1724744761183;
        Tue, 27 Aug 2024 00:46:01 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b95c1eef6sm51299435e9.8.2024.08.27.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 00:46:00 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/sched: Fix UB pointer dereference
Date: Tue, 27 Aug 2024 09:45:22 +0200
Message-ID: <20240827074521.12828-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drm_sched_job_init(), commit 56e449603f0a ("drm/sched: Convert the
GPU scheduler to variable number of run-queues") implemented a call to
drm_err(), which uses the job's scheduler pointer as a parameter.
job->sched, however, is not yet valid as it gets set by
drm_sched_job_arm(), which is always called after drm_sched_job_init().

Since the scheduler code has no control over how the API-User has
allocated or set 'job', the pointer's dereference is undefined behavior.

Fix the UB by replacing drm_err() with pr_err().

Cc: <stable@vger.kernel.org>	# 6.7+
Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Closes: https://lore.kernel.org/lkml/20231108022716.15250-1-dakr@redhat.com/
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..356c30fa24a8 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -797,7 +797,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		 * or worse--a blank screen--leave a trail in the
 		 * logs, so this can be debugged easier.
 		 */
-		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
+		pr_err("*ERROR* %s: entity has no rq!\n", __func__);
 		return -ENOENT;
 	}
 
-- 
2.46.0


