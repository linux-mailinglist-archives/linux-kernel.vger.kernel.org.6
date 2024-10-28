Return-Path: <linux-kernel+bounces-385177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F193C9B337D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F27C1C215F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1CA1DD89F;
	Mon, 28 Oct 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxXeHwfp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7D1DD550
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125665; cv=none; b=VLA39xf3hseS0uTqzlQLzJys51JuNGMiWSbOKXfMCue4udwbv3WifRasY2t5ludaTjHpRHYyPXXld2lth5Jz8MYk07xi/GeTO00l0iqJLHU7HElIa6mJn0231ZoJqimdll/E2T3+ghCKr5dL77xSsSrUB3emEIdel3HXnrbWi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125665; c=relaxed/simple;
	bh=vPRVwLhHIwRTOejlqCZqrFuY/KffhaL7NLIdYAyf3m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kuht3P/lQn+xuK6U0EesIlnVHLSq6Isq+3IOfVa2bYJsiWoekdyXreyGd2hB2wA6dZfVUj+ENyANrf+j5xr1Yirkl0UW0QuWkesSp4m242qgVmtpQrGdUjf9zoCBMFB1ivOtDkaGhpZSDT5006uHFPxQ6akjUv5hGZIBXjqOTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxXeHwfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3EDC4CEE7;
	Mon, 28 Oct 2024 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125665;
	bh=vPRVwLhHIwRTOejlqCZqrFuY/KffhaL7NLIdYAyf3m4=;
	h=From:Date:Subject:To:Cc:From;
	b=ZxXeHwfpkEGot1NTvz1trp6my64HDIMQFFaqjCuVGji/g6tG6PmILdyd6HpB89UJc
	 PnRbozbTtT64jypjblP+tbMYWZGM/mls4ceozq3uyXVDGSaKKNeB5w/ctsd3yJ62zu
	 /0jzPvRw1qmUwXIcYpjtInHZdgtCKwlBuEaBTh+y0O7wN0uvhYdq5N6Jqy1zjXDkWe
	 B7wrTeTwPvpCmgwjJZJqtOzTevqGPUZOjPfr8GUt5MdJjgZOA+Wvr00tH8aHrIP+zm
	 NqMsR+TMmVCva9tyo6RJAOlYoc4NI16QTbim4NmdhQWKOAjU2biToMCc9mDybCC+tT
	 l7yk5WEkXjORw==
From: matthias.bgg@kernel.org
Date: Mon, 28 Oct 2024 15:27:17 +0100
Subject: [PATCH] drm/v3d: Drop allocation of object without mountpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-v3d-v1-1-907bee355edf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAESfH2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyML3TLjFF3DFCNTE7PUFEujFHMloMqCotS0zAqwKdGxtbUAJ+CpslU
 AAAA=
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
 drivers/gpu/drm/v3d/v3d_bo.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 7055f7c7bcfe5700aee10b09ecc0005197323b01..f6df9e0947b6ee06043cdbb42c4f98a71bdeba4d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -157,13 +157,8 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
 	struct v3d_bo *bo;
 	int ret;
 
-	/* Let the user opt out of allocating the BOs with THP */
-	if (v3d->gemfs)
-		shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
+	shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
 							  v3d->gemfs);
-	else
-		shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
-
 	if (IS_ERR(shmem_obj))
 		return ERR_CAST(shmem_obj);
 	bo = to_v3d_bo(&shmem_obj->base);

---
base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
change-id: 20241028-v3d-1d2546ed92d7

Best regards,
-- 
Matthias Brugger <matthias.bgg@gmail.com>


