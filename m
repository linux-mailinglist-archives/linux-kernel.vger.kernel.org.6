Return-Path: <linux-kernel+bounces-239791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C1926558
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53264B214FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7ED181328;
	Wed,  3 Jul 2024 15:57:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202413BC0E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022222; cv=none; b=G7sc8vXSnfJdvuBgMy4TjDyClxhfS5QjKxroKNDJPKShszggjo7fs4B+y9aS5AGHmzDEJc8HsoVlUqsUAz5I7+c9YCDAVJyqmO8W/rQ4+GmJ97++7VfZAtz8iHpdAJ9ZCbBQhDfJbnXzn3ZXuTX74kPBhkTEfeeC3m+jULXcov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022222; c=relaxed/simple;
	bh=aFNBCVor2whRfmZyKXtkwJ8FjqCouwMmidktocYI6s8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tea7PgPIBYx0k7Kghk91Mgbhqep2iDz1wPEVFYwqNiLu6Yl1LcwdIDQRXrhQBxilFG8OX8ryvCwhYr3RPL3PavR672DvlgG3cGiFHRItRFmoJkJdxm9TO4L2Nu2ha760gth5+DQYCebNObZ+iuvsEBOXUo+ejcEwfFuLcLjH7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6041367;
	Wed,  3 Jul 2024 08:57:23 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.37.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8C23F766;
	Wed,  3 Jul 2024 08:56:57 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panthor: Record devfreq busy as soon as a job is started
Date: Wed,  3 Jul 2024 16:56:46 +0100
Message-Id: <20240703155646.80928-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a queue is already assigned to the hardware, then a newly submitted
job can start straight away without waiting for the tick. However in
this case the devfreq infrastructure isn't notified that the GPU is
busy. By the time the tick happens the job might well have finished and
no time will be accounted for the GPU being busy.

Fix this by recording the GPU as busy directly in queue_run_job() in the
case where there is a CSG assigned and therefore we just ring the
doorbell.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 951ff7e63ea8..e7afaa1ad8dc 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2942,6 +2942,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 			pm_runtime_get(ptdev->base.dev);
 			sched->pm.has_ref = true;
 		}
+		panthor_devfreq_record_busy(sched->ptdev);
 	}
 
 	/* Update the last fence. */
-- 
2.39.2


