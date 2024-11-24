Return-Path: <linux-kernel+bounces-419721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013049D7638
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E205AB2729E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D131AF0D1;
	Sun, 24 Nov 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPpWuRCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972F1AF0CA;
	Sun, 24 Nov 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455410; cv=none; b=rNSasWhGsvuMQBThD6iNd9ExOnYMu8L80za/vhbrGIve1ISGGTmKO/6SwsLMyxq6IcrrqKGUwnPwTI97oIo4Q6sqO9lRa7NkXaDEe+NPvAwD2c/R6TjLGRlZYATFLz8FohE4F+hTgBRD/x5HlzpAER0+rCUa2GwMIFGmrywUIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455410; c=relaxed/simple;
	bh=2Kl0frRTSpeSxs8adDTnrwdbyKJvtH2WS6/Cb/idmxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rfeh9p7SUo3QHfGnijPusk7Eh2gpLQkEt5Pn+d4Ck823AMMoEAGK1God6FWlYE8VBu0OiFWBELf1/yFqTKLS30PGNxioIeq7Qj4bCwtIjmk4TeloVsncR3ee5fBI8jHuJmiB1XELbSa+qJSkh7sKIfP7W+WD8V/6qk5qygct12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPpWuRCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D44C4CED1;
	Sun, 24 Nov 2024 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455410;
	bh=2Kl0frRTSpeSxs8adDTnrwdbyKJvtH2WS6/Cb/idmxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPpWuRCsj9XW3OSn/hKRgozWcMAvnLRJ19k6EOirIpuqshE87mwZxe2uUF8m9B2kY
	 KQ6fs8OCSARZ4MIA7hWs11pymkXTXh9ubUaeMVI+AE1sP5ElHHjyNUtLZ48Rk9GZcS
	 +sIaYiBERHNHA+heni45u60nXCq5pz1WRAitny/JpIt09UbPkN0V/QbU6ZyymqTzsw
	 9677Dg8qtA026HhdAJBil3GnscndRVGzaPWavz+XKiym96nel5pHuBrZpD1PuQJKmm
	 ezMQJHM1klO45ICh3otXVesD0tygoWOQpvVSHBghJHE2wet9QNA0rrMJ6446BzuYEw
	 WRIBZFGPP0HLQ==
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
	Hawking.Zhang@amd.com,
	Philip.Yang@amd.com,
	shashank.sharma@amd.com,
	mdaenzer@redhat.com,
	Arunpravin.PaneerSelvam@amd.com,
	Amaranath.Somalapuram@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 064/107] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Sun, 24 Nov 2024 08:29:24 -0500
Message-ID: <20241124133301.3341829-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 74adb983ab03e..0637414fc70e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -812,7 +812,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -820,6 +820,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0


