Return-Path: <linux-kernel+bounces-276416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E36949358
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B616D28899C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E420FA81;
	Tue,  6 Aug 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iyg4Zv/8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938B1C37B4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955149; cv=none; b=QkenhodLdkWelT5WHdXXohOz90XXSYgaAlveceu2dMzyjc5lxQSPd/H5fQCdJ7G7nrKKGYFILXy+fs86xvpMQdGNvNWpVnLSMJAG9aqaO1i/u3uWzeL9SEgVH4Dk9CHsbzaQNP9N73Cv3LjXyDJr6epRWwg3MdtK90Dhvvj4+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955149; c=relaxed/simple;
	bh=srFjmoCW8jTlyInp9UplGmWoqXhJLQewnxeMLrhOf+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFuLIJt/noWoUWEmjNPM418n6PRS/pQmqAQvZL+EDitQBlFgM7LK2Y5qTpN80LHDsRK9cxSb/S3UHWmDopwx23XmBBNbrMsV3nPF1EwGBQ6tqZ8eIbohRx1YELBT0FfjR13VQdibwgRv/xMEMTEeD1SEFgF6eR4f9vplwzq9G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iyg4Zv/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722955146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CC3DtKRmGhH5AipOFzN3At/MyjZL4PoYSf7Q164ZoF4=;
	b=Iyg4Zv/8CyjHQ+WUjJyeXU/f45vwj4S/Jc6U+tUy4L5RwRyhH5q2yJtZHDo3G+FTzByYld
	/Uakvxkm+MINHYTWHk26aQTYzLmumHwDA2LOSgyZJQ9yj3pqynXZiISEBTJnvRQkTeQou1
	8e8VikaGsFQHJXnUnA3XUXBT59leC1M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-1N9slsJqM1ufPLzbtjPY8A-1; Tue, 06 Aug 2024 10:39:04 -0400
X-MC-Unique: 1N9slsJqM1ufPLzbtjPY8A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee88b1c3e9so788121fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955143; x=1723559943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CC3DtKRmGhH5AipOFzN3At/MyjZL4PoYSf7Q164ZoF4=;
        b=WGBKS8hef4bs6GvfflrpxVI5SNj/ujwp7sE5nAoCeN6l7jueUrshq4e8KsoxE3fdIe
         WcrgUIa4mTOaHar2IIALQ3XKXME5uFB7TZTStpD6Yj7FT3YaZSafKAfIz8z29FXQfE4X
         b+VUWxQ94NZnGGlt5sqBVdYT/hj82iRDE1H5KQTlOv4/JxMpHGbY7goKKvwG20codPfF
         gRYMGUpnWVTvVai1/j9FzwfelSCj1dFquXR1WWLTYjvTi2E5Rs9L/bCaTcZDypIem27S
         78hJBaF5GnHohxwFwrGHcL0zWqP1PVSwZdFfC0IUzQOA9mEuMctL++fBJRIbJJ8K513h
         8SKw==
X-Forwarded-Encrypted: i=1; AJvYcCUVfSVu5luK8OXxfVuc1cRMz+CYncAujIRzTCciZVT1LuHP4JfBM9zz4tdIA3AydkEfNB5YDRAB+jWUnelZZXAd6x0b5tr1FrqMN3nP
X-Gm-Message-State: AOJu0YweaCTerqQTexksrL1sGvRC/QeZZU12nsk5BEJFnlrNwKgbEW5C
	5liOKHdD9ywQXQXXV5pmIMvmXDFwQt/Cv2tc/yArj7dkaYNm5A5J1uTuowmlPfU9jdn4V7B1mm8
	3MMw1nOuRWVuCrjMGd3tXBrRQ0KOe1S86A8f8x+7q4nu9LMmIfkzKoeomWixgwQ==
X-Received: by 2002:a05:651c:210f:b0:2f1:5c3d:d12d with SMTP id 38308e7fff4ca-2f15c3dd22amr70169501fa.0.1722955142758;
        Tue, 06 Aug 2024 07:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5jPI0DyawGRqcu7Ni4RByPLJdoSZNjigyyhoympR0yL332lXRzkYzFAnZqne8pTm24btWHA==
X-Received: by 2002:a05:651c:210f:b0:2f1:5c3d:d12d with SMTP id 38308e7fff4ca-2f15c3dd22amr70169271fa.0.1722955142133;
        Tue, 06 Aug 2024 07:39:02 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d165b009a97301f486032f8.dip.versatel-1u1.de. [2001:16b8:2d16:5b00:9a97:301f:4860:32f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e08012d7sm214285905e9.22.2024.08.06.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:39:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Tue,  6 Aug 2024 16:38:55 +0200
Message-ID: <20240806143855.29789-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_init() has no control over how users allocate struct
drm_sched_job. Unfortunately, the function can also not set some struct
members such as job->sched.

This could theoretically lead to UB by users dereferencing the struct's
pointer members too early.

It is easier to debug such issues if these pointers are initialized to
NULL, so dereferencing them causes a NULL pointer exception.
Accordingly, drm_sched_entity_init() does precisely that and initializes
its struct with memset().

Initialize parameter "job" to 0 in drm_sched_job_init().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Hi all,
I did some experiments with the scheduler recently and am trying to make
the documentation and bits of the code more bullet proof.

I tested the performance of v6.11-rc2 with and without this memset() by
creating 1e6 jobs and found no performance regression.

Cheers,
P.
---
 drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 76969f9c59c2..1498ee3cbf39 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -936,6 +936,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		return -EINVAL;
 	}
 
+	/*
+	 * We don't know for sure how the user has allocated. Thus, zero the
+	 * struct so that unallowed (i.e., too early) usage of pointers that
+	 * this function does not set is guaranteed to lead to a NULL pointer
+	 * exception instead of UB.
+	 */
+	memset(job, 0, sizeof(*job));
+
 	job->entity = entity;
 	job->credits = credits;
 	job->s_fence = drm_sched_fence_alloc(entity, owner);
-- 
2.45.2


