Return-Path: <linux-kernel+bounces-523581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F58A3D8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEFF7A553B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B65223;
	Thu, 20 Feb 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eedjjoeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E591F3D2C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050909; cv=none; b=jeSRaMIa5lWuZlIsbkh/2Yfw8jx2jxciscTLQ6suSZJVeeWOaNuhlCnTk/1/bK+LMftcjuT7WtpLDQzRLFcuFj3XZI0CpgNrm0/TBVvczWdvOHxfzWURSFSAkFXzVSZ6nKVw8haM5KfNKry36M0A5nPzTg3NcbzO88PJyV629M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050909; c=relaxed/simple;
	bh=WfPMRPu5h33yO/ZOjwVBBS1RB5ho4n5GU11BEOfYUvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQZnX1EDZ2+YUznPakfmP5T/ezESOT2rPUC+Pp1FIzi1MbQ1onq5KK/z260J5+ab96hri5urfZfy62H2Px8HzxHF1r0SEzTAuEYNWQWDpRkk5FYhR+ef3Vlrpjk26h/KVilYq3JOoFe7SxI6evDna+vWWnvmnkRDA9xKpX63ltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eedjjoeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4F1C4CEDD;
	Thu, 20 Feb 2025 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050908;
	bh=WfPMRPu5h33yO/ZOjwVBBS1RB5ho4n5GU11BEOfYUvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eedjjoeYuAp3/ryigJRwHUbmbYdv9K1V/wYIF7ctNP6IeRtyXojMNWlCY9RMrARPF
	 QjOUw5MeiWZ/R9qTTL0FlNngwT5VJI5niN4Q58gYTEwx5g228C72dYhTl4upTfFbjJ
	 Fx8Spnr0sTZD6bCfXSekE2Gjwj5vq6UYIbyQ3/SeJiyhX4sMceoJcU7HlG0N1GZnHN
	 CLVwSOPdrzYhKPWBd6dvfAbZtmdDDjqjrnUY9NPyjghHc++3FLuArvMOsRN8dEyyfL
	 d57O3YM0CQCtv0HlB5Md4QSvfdJHc4j4kqVWmszeuOh+yUI04RmzylbuxEGTrWQ9Fx
	 qwpcd/dadm5mQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] drm/sched: Adjust outdated docu for run_job()
Date: Thu, 20 Feb 2025 12:28:13 +0100
Message-ID: <20250220112813.87992-4-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220112813.87992-2-phasta@kernel.org>
References: <20250220112813.87992-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for drm_sched_backend_ops.run_job() mentions a certain
function called drm_sched_job_recovery(). This function does not exist.
What's actually meant is drm_sched_resubmit_jobs(), which is by now also
deprecated.

Remove the mention of the removed function.

Discourage the behavior of drm_sched_backend_ops.run_job() being called
multiple times for the same job.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 916279b5aa00..29e5bda91806 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -421,20 +421,27 @@ struct drm_sched_backend_ops {
 
 	/**
 	 * @run_job: Called to execute the job once all of the dependencies
-	 * have been resolved. This may be called multiple times, if
-	 * timedout_job() has happened and drm_sched_job_recovery() decides to
-	 * try it again.
+	 * have been resolved.
+	 *
+	 * The deprecated drm_sched_resubmit_jobs() (called from
+	 * drm_sched_backend_ops.timedout_job()) can invoke this again with the
+	 * same parameters. Using this is discouraged because it, presumably,
+	 * violates dma_fence rules.
+	 *
+	 * TODO: Document which fence rules above.
 	 *
 	 * @sched_job: the job to run
 	 *
-	 * Returns: dma_fence the driver must signal once the hardware has
-	 *	completed the job ("hardware fence").
-	 *
 	 * Note that the scheduler expects to 'inherit' its own reference to
 	 * this fence from the callback. It does not invoke an extra
 	 * dma_fence_get() on it. Consequently, this callback must take a
 	 * reference for the scheduler, and additional ones for the driver's
 	 * respective needs.
+	 *
+	 * Return:
+	 * * On success: dma_fence the driver must signal once the hardware has
+	 * completed the job ("hardware fence").
+	 * * On failure: NULL or an ERR_PTR.
 	 */
 	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
 
-- 
2.47.1


