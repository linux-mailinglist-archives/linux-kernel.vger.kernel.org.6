Return-Path: <linux-kernel+bounces-419973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE199D744E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D62C068FF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EEE1E1C10;
	Sun, 24 Nov 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/cgKAJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB51B2186;
	Sun, 24 Nov 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456253; cv=none; b=ThP+maXcuQGg/sSfSjkPKMPnT703aQdzRiOcgSDyT2RcdZrrmtZywpAH1t0q/eRTjEzOx8upqPnUsu/q/u2RRvtB3If+JOSofJOY3PGaX2ZZIZsHViWV8C492Ru27LIVqeSl2kz1MA8LTFJSm5m7Xo61B7wayTvySUbSVHDyXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456253; c=relaxed/simple;
	bh=QXpIFoOYPXnJFfvMVOnUy/Y6CB1RJZItjRXAW+vjCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwX1lPNoLq555VPWKTFDrfyqrcFk+mZZJAPN3parpll8PfgCJTAcDHAndJBfxrtKtDgSATyZure4DztEHeI8WaISTnxrmkfphYfFfJwNc2PzM8zt8o7eG6VdJiOFJezJPi4hoGOzkyhIeFEYiF7wf/iDVjmyd/iotZzmjS3B0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/cgKAJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F6C4CECC;
	Sun, 24 Nov 2024 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456253;
	bh=QXpIFoOYPXnJFfvMVOnUy/Y6CB1RJZItjRXAW+vjCmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/cgKAJ2GKxcY7QhFQxC5gbupak1XqjL5ZMk61JuzK03bN+RG0ZUa3F5Yt1lvneMc
	 CVJ0gMGdCHEXCkO001vu8iKt5LpkAyo0Y7ZwsUgXr464QTklpXafF96PBGs8YcOGxT
	 BnMqOtjcMpWnGWdsjyv8mC+Q/ZUr8HGY0X8gIfFa1+Mtrck92FMuEEM93n33ugI/mf
	 CIwO4TDjjoMlQ5LMo55zB0VcakWNqCppjyk4zi/F+tCSO5QgsNqeI3bUUEhsVOEM3w
	 MzThUDCaQo72x3tm/m1VFA0/FruaMlBLFEl3r2n26cICOHa1Y+/+vn/yCASr6hfTfx
	 19VJcNqrfj0XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lang Yu <lang.yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Frank.Min@amd.com,
	Likun.Gao@amd.com,
	mdaenzer@redhat.com,
	Philip.Yang@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	Amaranath.Somalapuram@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 29/48] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Sun, 24 Nov 2024 08:48:52 -0500
Message-ID: <20241124134950.3348099-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Lang Yu <lang.yu@amd.com>

[ Upstream commit 46186667f98fb7158c98f4ff5da62c427761ffcd ]

Free sg table when dma_map_sgtable() failed to avoid memory leak.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7afefaa374276..2b15d938c779f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -776,7 +776,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -784,6 +784,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0


