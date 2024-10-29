Return-Path: <linux-kernel+bounces-386816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF69B4838
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD61628278A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A694205157;
	Tue, 29 Oct 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8ANdNQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473D1DED5A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201094; cv=none; b=VEkn3mCZBbJOamjQondFhaNExWfvQktI87uVlddEVEWHxHZpvKvx1jNhanzx9RyJyQjA8P1JOt2oTCj88Cm2IVWA+AEDxaCS3ncDcijbCIIgZppM3pYXYFChBJnL1E49uDemt/lvT9chqw+VxbeGjCLIW5ocn6Tkw6dqKeN1dZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201094; c=relaxed/simple;
	bh=jIWGiu86I9tdXQhkhV8+srxBOHqcwMnyFOpLP5Qz8dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IHbCoEjQp0jsbya0aZqdf4rkiXLn3ROo7ejZHokJmxbzLg4ERLaoo6JjxYZFbyva6J119lGt7IOWpK52SZBXrJ0SW+KTwD5VJC/XbvCXEawCgqUwVz6cR+Khh72Rvrbjb6Rl1IzCgINz5ymYw7IsuAzeiQt4wqvNfOzyWhuYxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8ANdNQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1AEC4CEE3;
	Tue, 29 Oct 2024 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730201094;
	bh=jIWGiu86I9tdXQhkhV8+srxBOHqcwMnyFOpLP5Qz8dw=;
	h=From:Date:Subject:To:Cc:From;
	b=d8ANdNQd6t/M1XAzOxB96oltciCJj94k6NWJ7cQi8FwGAEUpPDTPrvlZgG3wizdJL
	 1X0OGykFgTLBEurvnlYw+P5gLydUvoHeRh1wC3IcDyJPx6O2m510/chrxrFau13pVx
	 ultLHjcYUsy6XYR2A2Vfx4XRaiDYbqkrU3Qy/QqOWxrgTP+uFUZYEem4XBDsSlniCZ
	 ZdozpNpsqKnH5+oumaRVdnmIExItPz5ptcSb5LPdDUSF6J0Jpdo7fsYP0U5rghXM+S
	 6YWTa07Jg4YwiQ0GrGivE3E7ztPx1HWBzj+l/RBYvGHm3mTtGoQIQC0YHWunQXiKfZ
	 z/z9N/Dt5DMlA==
From: matthias.bgg@kernel.org
Date: Tue, 29 Oct 2024 12:24:29 +0100
Subject: [PATCH v2] drm/v3d: Drop allocation of object without mountpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v3d-v2-1-c0d3dd328d1b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO3FIGcC/1WMQQ6CMBBFr0JmbU07UBFX3oOwQGaASYSa1jQY0
 rtb2bl8P/+9HQJ74QC3YgfPUYK4NQOeChjmfp1YCWUG1FgZjVcVS1KG0FYXpgaphvx8eR5lOyp
 tl3mW8Hb+c0Sj+a3/fjTKqEbXD+bSWqbxPi29PM+DW6BLKX0BORLU45YAAAA=
X-Change-ID: 20241028-v3d-1d2546ed92d7
To: Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>
X-Mailer: b4 0.14.2

From: Matthias Brugger <matthias.bgg@gmail.com>

Function drm_gem_shmem_create_with_mnt() creates an object
without using the mountpoint if gemfs is NULL.

Drop the else branch calling drm_gem_shmem_create().

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes in v2:
- Fix indentation
- Link to v1: https://lore.kernel.org/r/20241028-v3d-v1-1-907bee355edf@gmail.com
---
 drivers/gpu/drm/v3d/v3d_bo.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 7055f7c7bcfe5700aee10b09ecc0005197323b01..73ab7dd31b17b249b7688dcc9833fd161211b6d9 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -157,13 +157,8 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
 	struct v3d_bo *bo;
 	int ret;
 
-	/* Let the user opt out of allocating the BOs with THP */
-	if (v3d->gemfs)
-		shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
-							  v3d->gemfs);
-	else
-		shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
-
+	shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
+						  v3d->gemfs);
 	if (IS_ERR(shmem_obj))
 		return ERR_CAST(shmem_obj);
 	bo = to_v3d_bo(&shmem_obj->base);

---
base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
change-id: 20241028-v3d-1d2546ed92d7

Best regards,
-- 
Matthias Brugger <matthias.bgg@gmail.com>


