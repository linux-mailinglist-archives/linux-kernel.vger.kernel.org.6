Return-Path: <linux-kernel+bounces-448528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01B9F4152
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489B11886988
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C138136353;
	Tue, 17 Dec 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZsUhBtV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F54A23
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407378; cv=none; b=sRk5Nx+KtVWVs9euwZdqkKChUJQ7Lu6wLtGnIwKfAIkxV419Z3iCR+703OYdtWEUwfEXFFMFnx765ypYbxMU1urvccAFW4/QZ8Y18hErhn91NtIaOp4wkpnFbL0s6Q0DPjgvemebik+clLsQeZF6HVQFC7FHqMvFq/6uOVgCIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407378; c=relaxed/simple;
	bh=S9m4I7Y72fRnZkqseWk/7SquxQxDAjMpCLVy9dSSVYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQbvl1MJEAqaga/CNyaAWWauH2dl+l/HYycFzx8Q7oAZ1j/gnwP1VLWvbtiCIa618kcwjMOBv9npbFVjIeUPEfmyB810Qe8wtracFqdBzo0xfltMDft2JJlBMTvEChA04RqgGKEpa2o+i5jWIDZ/ZYqtuvo4lRZuCOtf4baGxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZsUhBtV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728f337a921so5000509b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734407376; x=1735012176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHwC4IkPFLFA2YJtjf56D7Njy3q+au/+C2ewipT8jCg=;
        b=BZsUhBtV0K+AosPQGdZquJlX2RZCkg1xyXp4z+qrgwj1k1h5ga1QXkGiis+6i/phSU
         adgM1SIKAH9wQHm4ozBs5CqcGtrR/bd++O7C/uP3hoCI1gbMGWMxQkjO02m7o8w4quk+
         FIDJeMt+4Ixp6MKNmn4GwWbmW8PIEjUiN/NCPA758McFMz9hMN3IDIXdjVLpyJOH3BXv
         FgcWeIy0irN5tAopZ1RJazo4iRKdIXvuuKrZDdLjnNPqmiCzJWX+NSgn4wv8Ta4myX+k
         FW/9rFpViPfngGbP6Ahdw/3fBapjbC090DSBlAihUTPWLw0e19Y+q4Gx1wV0oaZ64bqS
         KpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734407376; x=1735012176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHwC4IkPFLFA2YJtjf56D7Njy3q+au/+C2ewipT8jCg=;
        b=kBEz0arGS5XreCUAuotF1kdg6k9QUFTVTufqiN01R4HuIAypQbMTV8/fd4ORQ8lQcF
         7j3T12N3jcordx9zUcr6hmNuL1/LwiBuXkNnDmKmPtFv2eNmxFX+tvLw7TihGJd1/SZh
         G/yRTzAvZkQbfHeRa7RRssRpYPc1hkOCD/uK3Ry1WueVtt6tek1yaQXwvW0HcgPAe+Lk
         Ez2oJUKiCkzI7v+xuFcYLbxDcuFRywb1oCAw7h55fu0aXsQlRLM8ggUCFjUlcLAoe2bj
         DU0wWIRAvgV6VyLeEypXo39uB6Way7psg2lOXd9hw9Knqd/EPZmTHPVCTOaPv6kGBqTB
         t5fw==
X-Gm-Message-State: AOJu0YxtlfYHdfU1rhQYWKLRvToKnFVH5DLMGHYZC2o64xM72YqpTB/u
	+X3z3HUujnNnHI5gCNrI2ISm5Bw6NOoUDzOxYNItKwvlRTdNzUZ1
X-Gm-Gg: ASbGncvMwyOAaApnqUFyt4hUHaqBm2j1MOMzUA6KK0We6wKldRm6CNeu2dG3lbENdnW
	GnVbrqGAfbuXrLKYD2Ti4ibMNJINi4hwcGViUV3a54mjuiwsaycO9Fv7qE9r3tVobgz52M+zbLm
	TUG9kZ7QO1gaxRvBW4D3HWvDU8EwDgQqHIJ4BlFQgPg39bnuRUtOEgT4VZ/EFWhD2e89XUPtNUa
	B1nk0mzZiLR0cZrh8AEPsPE+rSmFdKEcFWOPThZrnhrpyeF/8DhmmwF
X-Google-Smtp-Source: AGHT+IHkkzjFKa6T6f5I8fUnkhuTZkEfCbz+YwkuYZkslBD8aDyAlmi470dueY0lmNQx6ueoNLQUHg==
X-Received: by 2002:a05:6a00:1492:b0:725:f376:f4ff with SMTP id d2e1a72fcca58-7290c199ad6mr20130974b3a.13.1734407376470;
        Mon, 16 Dec 2024 19:49:36 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad9d2sm5565617b3a.157.2024.12.16.19.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 19:49:35 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1FE3241F555A; Tue, 17 Dec 2024 10:49:32 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/sched: Separate drm_sched_fini() driver checklist
Date: Tue, 17 Dec 2024 10:49:15 +0700
Message-ID: <20241217034915.62594-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=bagasdotme@gmail.com; h=from:subject; bh=S9m4I7Y72fRnZkqseWk/7SquxQxDAjMpCLVy9dSSVYY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOkJXyRmLludN01tOjfvzE3tDUFCvjYKyx9c87jxWOXF9 XvXZ68P7yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEHksy/GbZvbb+uJ3tWxbl mPD/lzap1D2zuTF94YZ9n/vqWYtMZjkw/OHe/WKJ+2nLain5+9wsvwOnr2RLk3ihpH/z/han1fZ qgSwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit baf4afc5831438 ("drm/sched: Improve teardown documentation")
documents drm_sched_fini() with a post-function call checklist for
drivers. The checklist triggers htmldocs warning (but renders correctly
in htmldocs output):

Documentation/gpu/drm-mm:571: ./drivers/gpu/drm/scheduler/sched_main.c:1359: ERROR: Unexpected indentation.

Separate the checklist from preceding paragraph by a blank line to fix
the warning. While at it, also end the aforementioned paragraph by a
colon.

Fixes: baf4afc58314 ("drm/sched: Improve teardown documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20241108175655.6d3fcfb7@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7ce25281c74ce5..57da84908752c6 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1355,7 +1355,8 @@ EXPORT_SYMBOL(drm_sched_init);
  * drm_sched_backend_ops.run_job(). Consequently, drm_sched_backend_ops.free_job()
  * will not be called for all jobs still in drm_gpu_scheduler.pending_list.
  * There is no solution for this currently. Thus, it is up to the driver to make
- * sure that
+ * sure that:
+ *
  *  a) drm_sched_fini() is only called after for all submitted jobs
  *     drm_sched_backend_ops.free_job() has been called or that
  *  b) the jobs for which drm_sched_backend_ops.free_job() has not been called

base-commit: d172ea67dbeec5c90f72752c91d202d5718e3754
-- 
An old man doll... just what I always wanted! - Clara


