Return-Path: <linux-kernel+bounces-553666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F9CA58D27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2027A4402
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DACB221DB7;
	Mon, 10 Mar 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WegW/jIl"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107355234
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592661; cv=none; b=Rrx3uGMQNbIpuQzilxeOLJDTqNrWJ4VTnlJU5GemPeHeNCPPDMfHVftuOSQwzS9/fAdT5VlCC3JpUkVhqQUnSdouK36PnNSKhf5uIPF5mQkhocWw7YJyfeSkVYHp23D6txgdp2OskuZzv5Z3j64tCCFmAbnKsumA7UXdGhPbPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592661; c=relaxed/simple;
	bh=1RWVUaFYe4L1rpxcNRL/MtwgEhMW1QTwtPLAbkWI2Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FKd8L14GW8PR1028w8NTL7I9Dh4rMJ6Z0IFEXSBEMzs/E1iFSduwKJbJFph+qsv8izXv+4VzibFQzdJBhjJlnWbJgoq9UiBLhorTLTMo+KrGpN94DXRsLPFRwclqJiDdQkmIg2tO1IOV5wkPLPvrG2rAAYxfmBxWuxLYuciOuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WegW/jIl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1811962f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741592658; x=1742197458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdzhdiThRJbETPGG8Kzj+Pu9zaED3TFBUkZ2Nnvl2nk=;
        b=WegW/jIlE2e2Tbv1QDYDKnb/2nvPgKBtJA5F383ZFTJfgynfL5VFgw4fzYpLS4aoBu
         3nzaw5BRL/02IoFat700NGgbsZzOobe96WPCIEXxJvQ1mZuQ4IFh5luoW0AnteU94GFR
         ntcZPNiM5XQTGn/lf1s/3OkYWnuvkczzMyFzSj6rQI7UEq/6pKt4yfpjK2KK1N5hfZ5X
         /GG05xHoSI2xhGWnF3PFwIUGChQ2FoXcguty/MFZjHrbXfzRXCNv3Z83ApgRIdH029tD
         xdXF6qyYmCLo8RTRYdZsnJfKP7DODNGouYag9Zr9y2rRgX5VWqp+/gIM99MHvbVMiawR
         ygKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592658; x=1742197458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdzhdiThRJbETPGG8Kzj+Pu9zaED3TFBUkZ2Nnvl2nk=;
        b=wiT54Ysy8AIgAg1cVDAJjfqMq9+nh78FUwEOgPb9E54NOtyocvG9VGy+pniV8UmbRm
         9wffzc5ea1huXibO4g9D/aX4j3r3HTLk8Hl3ZxfkkBU8CxA0oah8/oMPbscKz2m4mRDi
         Ugcc8qKcoeCKZhg4FBM/iRcRZuP7ufUi0a7Q/5pkLfovDPbgLVp/CB9ha5OoDz4cqm0O
         46+pEuK8sraEo5nKa+BxMag6PWc0rpYYAUXPy7PQpm6bSTT9ehPgG0ujNyHdX0kdnpRL
         +mXjb+owqJ8GxCMuqrFOC8dgMcARqwfvC8LhTZKeet5chR1DAQybK3SkiA3+jSvuLrRs
         hh0w==
X-Forwarded-Encrypted: i=1; AJvYcCX6WeuPswpVLXslP0JcEpp3Ll5qsLwzf3uXst6E4SwBkSeS88uOruBjn0PjDYeuIf2MMu822n8tUy9ulWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsox9HJWyxNXJ6poespZl6E5TXHDOgL1eWMJ3wQtG3VIJxl09d
	XO+lAhcOfvWm0Ko0RhSGCQtK1z73H4B784WxSWe5x48ZSwpTRcsD
X-Gm-Gg: ASbGnctFF/1wMlLNFU+qtR+H7Z3MiIFmav7NPVifEhDAJ1eWYRK14RfT4A0iXYe/LS6
	nmP3ZUShhrcfLZhU1TZCvSfiQoRlnB7bcn4xCNy/YaDmCJxIu5A5iuIB9fmDhjFiZfIJxhEd42I
	XVgmKXB43yVfbpqyQ9yoqGub5cWMpUuXIxTam24H1S3xMVA1XpOeBGnl92PBSIq0/2PCJ5fCtQj
	NbwTlq5QubzArsa+H89jr6PlzUgGnjJD6Xi/RrPVJPr1fNNBBRJplktoGLlaXvSD8s9VoCllMWt
	JsbjZj6ioHIK4/w3Mk0J7+uc/Jt3vbYN64ydIa6UV2X/orK0IIoIfStNgev7zbQ35w==
X-Google-Smtp-Source: AGHT+IHebDWlET/u+P6beGzYSGkjHeI8nA0vwv5+V8ZYrg6etAhuOdBDtAlDyZJecmoNUIgXwKvnTw==
X-Received: by 2002:a05:6000:1564:b0:390:f45e:c84a with SMTP id ffacd0b85a97d-39132db77acmr7926279f8f.48.1741592658043;
        Mon, 10 Mar 2025 00:44:18 -0700 (PDT)
Received: from EliteBook.amd.com (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01957csm13963242f8f.47.2025.03.10.00.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:44:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: matthew.brost@intel.com,
	dakr@kernel.org,
	phasta@kernel.org,
	tvrtko.ursulin@igalia.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/sched: revert "drm_sched_job_cleanup(): correct false doc"
Date: Mon, 10 Mar 2025 08:44:14 +0100
Message-Id: <20250310074414.2129157-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 44d2f310f008613c1dbe5e234c2cf2be90cbbfab.

Sorry for the delayed response, I only stumbled over this now while going
over old mails and then re-thinking my reviewed by for this change.

The function drm_sched_job_arm() is indeed the point of no return. The
background is that it is nearly impossible for the driver to correctly
retract the fence and signal it in the order enforced by the dma_fence
framework.

The code in drm_sched_job_cleanup() is for the purpose to cleanup after
the job was armed through drm_sched_job_arm() *and* processed by the
scheduler.

The correct approach for error handling in this situation is to set the
error on the fences and then push to the entity anyway. We can certainly
improve the documentation, but removing the warning is clearly not a good
idea.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 53e6aec37b46..4d4219fbe49d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1015,13 +1015,11 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
  * Cleans up the resources allocated with drm_sched_job_init().
  *
  * Drivers should call this from their error unwind code if @job is aborted
- * before it was submitted to an entity with drm_sched_entity_push_job().
+ * before drm_sched_job_arm() is called.
  *
- * Since calling drm_sched_job_arm() causes the job's fences to be initialized,
- * it is up to the driver to ensure that fences that were exposed to external
- * parties get signaled. drm_sched_job_cleanup() does not ensure this.
- *
- * This function must also be called in &struct drm_sched_backend_ops.free_job
+ * After that point of no return @job is committed to be executed by the
+ * scheduler, and this function should be called from the
+ * &drm_sched_backend_ops.free_job callback.
  */
 void drm_sched_job_cleanup(struct drm_sched_job *job)
 {
@@ -1032,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job *job)
 		/* drm_sched_job_arm() has been called */
 		dma_fence_put(&job->s_fence->finished);
 	} else {
-		/* aborted job before arming */
+		/* aborted job before committing to run it */
 		drm_sched_fence_free(job->s_fence);
 	}
 
-- 
2.34.1


