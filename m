Return-Path: <linux-kernel+bounces-414381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 945CB9D2743
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8822B29228
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C61CC172;
	Tue, 19 Nov 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfxvfXO3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43891C4608
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023792; cv=none; b=dXqDKPZalcySNg4AiH0g5Qg7ytrjzV0+P0+kK/Wmhoe20PK97MOA5Xz3IOQu7q1RJw6GGK/mIQCS76dfLbXe9TvFPb7nwuBlXx8qhEWsUCwN6RRIwZoshvc+pMjMZQ0Ciz3MaM1X4/3AitcmjbiiVxL7dAqjxK/vfNpwgSFVHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023792; c=relaxed/simple;
	bh=mDt7/DI7SnD2Vq9BWXuCIHn8mPomalcrIvTwDKasgJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5thIyGKr6gHea95ILuGspeLTPLwjEkypQl6JhFu0qTDAKKo2bbCWAQlUqy2qA/6YK4+xTcLKxzICKSkNUq1zllV+huJ7EnmST9wdBL8fWv594RJGqR2JtkmufaveY7CgdkmTllRsyHp0tjcy+CJcNOwWJu/cWsAtm52cfOvwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfxvfXO3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732023789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q51vTRwe1t2h/8us2udqsXrhP/lb4ZxAuLJ+o2JuCnQ=;
	b=SfxvfXO3DhA/89Ate6yy3r1QSc3RSeBDK4QAxtT8HAZOTtb/w96N6sBXdm6qbO1xZmhMjs
	NKlQmxgEV+dW9+x3Wpoi/yynKWYGojMWCv8UPIuiK4tMteyN/9CgzPP/qdbZ1Nikh7GKp9
	6oTRpQGnzZPcMcOG5akpSuJM2b8Wpgs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-X3K3yQlwP_qVFkd_0SwhjA-1; Tue, 19 Nov 2024 08:43:08 -0500
X-MC-Unique: X3K3yQlwP_qVFkd_0SwhjA-1
X-Mimecast-MFC-AGG-ID: X3K3yQlwP_qVFkd_0SwhjA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b36d2cdcd8so425273585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732023787; x=1732628587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q51vTRwe1t2h/8us2udqsXrhP/lb4ZxAuLJ+o2JuCnQ=;
        b=oIQUGLNPpj11s9wxk3aErd98oQ9/LB1nMqwzua+X/y7/QA8jgkY3exbSlb3vXasDC0
         Zf/qN8yIhXcHZIkqeYavNlJTBgirmFibGKSfc8I8hWre1qb+rGe9bsnKUA1ouFYiHIQm
         2cu0UfuHMhJBi3DwlHLE8mtMpRi5EPLLQc+EoTIAxEagzDBxe6lw4DxCBta0uhLZxgNH
         Syr1EZz2WayCNNOghwFjpy4T0zhAaOgsRPeItdQDXRL9Jk5vwpfPtb/X4Ssn9+s+C/k4
         39HqnLEggqakZcOL1xuXou+LetL/MK1H2T0tX9mwLcMixlCaDvUNyL/rGFZYw9ReCULq
         580g==
X-Forwarded-Encrypted: i=1; AJvYcCXasmrgNESwAITKKCfzVeNnvi5uZGhILD5yTBb/13snrsw5Z3BstruJV+fWQMxpEs9wsVeHtSukfQrlBcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAMFQgHbRdWT5FRNAUcoE5Mb1IfScQQUxpjXzY28MjY+HF/vU
	T0+aYZE5rl/yhuA2SX4F241JzwlkdQl1ANu5N7sTXEfETLiu8yuVrZ1T6sI1Q5u0wx3gmyXePUH
	PLk2N92dZu0To4jgqsD059dP51Gh9p5OcTxq4v4KC0F+WnMBs/I9LJV/49cePFw==
X-Received: by 2002:a05:620a:f11:b0:7b1:5672:5d46 with SMTP id af79cd13be357-7b3622b885emr2283987885a.15.1732023787611;
        Tue, 19 Nov 2024 05:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZfIvNrBCZLyqiCAUGm0Crgd0KH2cCFSun1bEewMvVzk962S1zp7ip9Q5f7nyKGuQ1YjoP/g==
X-Received: by 2002:a05:620a:f11:b0:7b1:5672:5d46 with SMTP id af79cd13be357-7b3622b885emr2283985185a.15.1732023787295;
        Tue, 19 Nov 2024 05:43:07 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a8aa02fsm92513685a.128.2024.11.19.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:43:07 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/sched: Fix drm_sched_entity_flush() return val
Date: Tue, 19 Nov 2024 14:41:22 +0100
Message-ID: <20241119134122.21950-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The documentation of drm_sched_entity_flush() states that the function
shall - always - return the remaining timeout time in jiffies.

However, that is not what the function actually does; in one of its if
branches it simply returns the unchanged timeout value.

Furthermore, the used function wait_event_timeout() doesn't always
return the remaining timeout time.

Adjust the function so that it actually does what the documentation
states it shall do.

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
@AMD:
You guys are the only ones who use the function's return code, so I
leave it completely up to you to decide what behavior you want.

But we should at least do something, because right now function
documentation and behavior do not match.

P.
---
 drivers/gpu/drm/scheduler/sched_entity.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index a75eede8bf8d..16b172aee453 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -278,7 +278,7 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
  * waiting, removes the entity from the runqueue and returns an error when the
  * process was killed.
  *
- * Returns the remaining time in jiffies left from the input timeout
+ * Returns: 0 if the timeout ellapsed, the remaining time otherwise.
  */
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 {
@@ -294,15 +294,24 @@ long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout)
 	 * The client will not queue more IBs during this fini, consume existing
 	 * queued IBs or discard them on SIGKILL
 	 */
-	if (current->flags & PF_EXITING) {
-		if (timeout)
-			ret = wait_event_timeout(
-					sched->job_scheduled,
-					drm_sched_entity_is_idle(entity),
-					timeout);
+	if (timeout != 0 && (current->flags & PF_EXITING)) {
+		ret = wait_event_timeout(sched->job_scheduled,
+				drm_sched_entity_is_idle(entity),
+				timeout);
+		/*
+		 * wait_event_timeout() returns 1 if it timed out but the
+		 * condition became true on timeout. We only care about whether
+		 * it timed out or not.
+		 */
+		if (ret == 1)
+			ret = 0;
 	} else {
 		wait_event_killable(sched->job_scheduled,
 				    drm_sched_entity_is_idle(entity));
+
+		ret -= (long)get_jiffies_64();
+		if (ret < 0)
+			ret = 0;
 	}
 
 	/* For killed process disable any more IBs enqueue right now */
-- 
2.47.0


