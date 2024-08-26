Return-Path: <linux-kernel+bounces-301193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C555995ED83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708F01F20B67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E614535F;
	Mon, 26 Aug 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRltdSYB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18C6F067
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665178; cv=none; b=UYl1R3JsmNIXuOBBLQ6CueX9nBUC7T+Waw4wRqgSAYkYQCHOrhnI05iBzB7r1UEuvMQ6P0NFD50ikPZZDas6GkC4MBdvehk9NSRh9IQKjXnpCG7cv862Biy5F5YCg3nuvRf+rUnF1oXiO6NS5K9ST/HuBLE4Elm5OYat5mYWRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665178; c=relaxed/simple;
	bh=ft6LsLne56w9OUyhQdZIgKtlluOayeFwkkxmZXyd9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYq8kXJV/tLjRrflLHWiY8VfP67tWMBFcAL+iR7QVaiw+LNuqcL+JIFwJuNlAiiuiV2g5p7tBXcxYmqRBttD0D33dCINk5cha7ugG8qLca/L7vQsjH5YNcucun/oI0T0Y6YtufZw5ZojwkQhs04ITr1ySvLWKp+xuu8WIp4IltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRltdSYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724665176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uR899B065jOcrVl9yza1zNeFHvJl6+GeFio7R8TZkKQ=;
	b=iRltdSYBmDeCiZmDEH08AwEHG5YC3dG97EXO06ud2piLQhu5ERMFt82hzbb3uGzDbuzRuw
	mT8qeQaUTWvDHXUjRlwi+k5zHESt/LgUK80IOTS/xz1vJkYgavI7vM4olgIFIaAKAcUHb+
	Nclf2e7zC1LKCoOMT5p/Fj+7e4gngOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-bDc3oLkbPdyJTCKQ4Ebz1g-1; Mon, 26 Aug 2024 05:39:31 -0400
X-MC-Unique: bDc3oLkbPdyJTCKQ4Ebz1g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3719cee43abso2216245f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724665170; x=1725269970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR899B065jOcrVl9yza1zNeFHvJl6+GeFio7R8TZkKQ=;
        b=ge8YHzhY8tqALDNcLIYBwJ5JBZPftJL3i4gIqCBCIYXnGQpPs6NC2zDPI5yj+jKe5N
         7pU7u+/8dVvDGLw8OAs8ArbM92un+ybmUDbcBNA+txF+KoULzHD6M2toj6J3kkm0Qubi
         x+XAoZ3AySwMjcqZ2cEUjug7q3pHq54E/9aRymN9nrYuc9U0WN6omhz0Og+JPNfyQ721
         zT6WW+iLA/0Ct5Q1jajy9Hp68Q2o9JuH1w0gGxLBckaIOsAFACKCZiCLVbKHqkINOmVr
         4OShwFUW6TzAQ3g5+o3E0wECodjJG5LMZPtGwrhcjGjNv5x79HIcNE5GQUx1B3acy6yq
         MN1g==
X-Forwarded-Encrypted: i=1; AJvYcCVxWKaLToXgQOSVB0cS/TG9TkMShZLxDDQUhsQXuF0zc/3TxBJIweYpY0bQx27R0V8bieOESnZq6e/qMS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoU07ppOOhm73Ue9tRVSuDX6atK8SilBKVghEfUyUM4wQB4a8U
	6wtcRymKagpijl6E8aImVt/c2cn8YfdT+p2zLGqt846N/tj1/fHwjEygzKWAOuENW8ijlEN3d1e
	+XYkarjGPVB9aYFbq2BHi18NqrGvtG9KdbZbVmJl5/qnGbaYtOjAEiFUZ7WL9+g==
X-Received: by 2002:adf:e8cc:0:b0:371:8a74:4170 with SMTP id ffacd0b85a97d-3731185f71amr6097338f8f.24.1724665170104;
        Mon, 26 Aug 2024 02:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcbKAtoD3Ot+SkhpRiDC9RWG4/j7MciBN+TRfrGtd6WnJLCGaP/EhauZN9tDTwxvdNwj1msw==
X-Received: by 2002:adf:e8cc:0:b0:371:8a74:4170 with SMTP id ffacd0b85a97d-3731185f71amr6097316f8f.24.1724665169545;
        Mon, 26 Aug 2024 02:39:29 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5180106sm150418705e9.41.2024.08.26.02.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 02:39:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/sched: Document drm_sched_job_arm()'s effect on fences
Date: Mon, 26 Aug 2024 11:39:17 +0200
Message-ID: <20240826093916.29065-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU Scheduler's job initialization is split into two steps,
drm_sched_job_init() and drm_sched_job_arm(). One reason for this is
that actually arming a job results in the job's fences getting
initialized (armed).

Currently, the documentation does not explicitly state what
drm_sched_job_arm() does in this regard and which rules the API-User has
to follow once the function has been called.

Add a section to drm_sched_job_arm()'s docstring which details the
function's consequences regarding the job's fences.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..e563eff4887c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -831,6 +831,12 @@ EXPORT_SYMBOL(drm_sched_job_init);
  * Refer to drm_sched_entity_push_job() documentation for locking
  * considerations.
  *
+ * drm_sched_job_cleanup() can be used to disarm the job again - but only
+ * _before_ the job's fences have been published. Once a drm_sched_fence was
+ * published, the associated job needs to be submitted to and processed by the
+ * scheduler to avoid potential deadlocks on the DMA fences encapsulated by
+ * drm_sched_fence.
+ *
  * This can only be called if drm_sched_job_init() succeeded.
  */
 void drm_sched_job_arm(struct drm_sched_job *job)
-- 
2.46.0


