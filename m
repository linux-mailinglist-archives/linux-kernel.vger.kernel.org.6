Return-Path: <linux-kernel+bounces-519397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF0A39C61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768CD7A155A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD32475D8;
	Tue, 18 Feb 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWwsQ1Nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB622475CE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882529; cv=none; b=GNDxLxAN+8UxvAU8xLk1nhVDeAEIsAT6I9douJXQQT/2rwsLrSHvkMunBNnqDVpEwrH7te9Z6Q5DMXfE1oWrbXSr5kuW7qaHuj5OTubLwSISRHaqSqzwcUSfNh8GCjL9nDxDoxtjnnr4fE1Nbz5foqgY6uuHcZvTsjhSw0adXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882529; c=relaxed/simple;
	bh=53+Jq1bsLhyjJZLdqY5IT9VqwmYxkNtjI8g1D826Ef4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dC47Ggqnmp+K4yVB/l2VsLjxeTzPaqH8Vd8nrVB0wgnvPW2vyMnWIDoVHwSggBlSF+iFhmiFvKqMowZP+njBbTs1YaCha3FcCWJj4lMfZnUrtKOmiPLBWHwrqSH+y0g0IbTOqE9J7i0zdF8LN9nS8nctmrz5oiKQjvo5gJWsN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWwsQ1Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED1AC4CEE9;
	Tue, 18 Feb 2025 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739882529;
	bh=53+Jq1bsLhyjJZLdqY5IT9VqwmYxkNtjI8g1D826Ef4=;
	h=From:To:Cc:Subject:Date:From;
	b=SWwsQ1Nxh3mXXGdYakmphpXJbo2sg6eci213YGVqDhaz5f3lwr+BiZBjxw27oOs4O
	 xOpyMCkw4erAHDEh/a6BUTwgGtvqM9zZznnNuW9wUm1+U6EHVXlA1lamPWAKzUKzRH
	 4HL64AE53ualjtscUe4b5xQHq2I4LGOi+XuC3myGhuClIRkuhkgyNrfNTTfDv4PezN
	 ik+TwkwLr7hQfc81L0vJuaNp+LG0MrbtaN216Pj7zn7DJMRiyUImK3MV782fbsAbM2
	 hA0ISKfNuiNYYyeil9s9CMCdYzVZAn6ajghqRH6Qgu1Mhw2amWpEd4iZ8QXi7c4Ch0
	 s3IxcRfG2bHqA==
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
Subject: [RFC PATCH] drm/sched: Fix preprocessor guard
Date: Tue, 18 Feb 2025 13:41:50 +0100
Message-ID: <20250218124149.118002-2-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing the header guard for gpu_scheduler_trace.h, a typo,
apparently, occurred.

Fix the typo and document the scope of the guard.

Fixes: 353da3c520b4 ("drm/amdgpu: add tracepoint for scheduler (v2)")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
I just discovered this. But I have little understanding of what is going
on in this header in the first place, so I kindly ask for comments on
this entire guard line with its logical or ||

The code hasn't been touched since 2015. So it seems it at least didn't
cause bugs.

P.
---
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index c75302ca3427..f56e77e7f6d0 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -21,7 +21,7 @@
  *
  */
 
-#if !defined(_GPU_SCHED_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_GPU_SCHED_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _GPU_SCHED_TRACE_H_
 
 #include <linux/stringify.h>
@@ -106,7 +106,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 		      __entry->seqno)
 );
 
-#endif
+#endif /* _GPU_SCHED_TRACE_H_ */
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
-- 
2.47.1


