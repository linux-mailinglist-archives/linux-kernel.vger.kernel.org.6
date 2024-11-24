Return-Path: <linux-kernel+bounces-419919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FA9D76FE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749C8B376F9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6E1DFE36;
	Sun, 24 Nov 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY4S4b4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEF199935;
	Sun, 24 Nov 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456087; cv=none; b=NAuuEwPg8kDD6/yWjlQ40vTJp7hJGW5GUzJpnc4vw+D6vdlx+LFQkhsxOCUOwTpRWVXbSVw/F8d3dOrcCxMlsCEvwDKFAVvzkyHMKHuSif1HXePh8TR4FgjMGULHxqGxfSQZr0wVdQoKdy3LHmKFyJ3m/XFx/G05Ru/T9l1YkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456087; c=relaxed/simple;
	bh=InR0voi2++hzu0wbUyBjDfHC1qHj/xA2Wv+oD/HIKkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv/xZYfX3FaJgDiaeDy1QrcMaMegz5ckIZXDOL18/re6Eo45tlTCw7uJtJ7BGVSeDogakgigSD0BSMq3moHjWyyeUkg0J+mT2oRlohX3d4Vb4c+D3vhZsFL641ORnayLSkacHb1eP/hFJOz3qt7QyEU2+0CtT5W0ZNGOinKgrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY4S4b4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5CAC4CECC;
	Sun, 24 Nov 2024 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456087;
	bh=InR0voi2++hzu0wbUyBjDfHC1qHj/xA2Wv+oD/HIKkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sY4S4b4mFoRlmukNMhclwGd/M5hRCvGgcaLuQu6M+rQ04hbJPqSflswxf9i7fL6rd
	 eZ1qTnZO9O+xT6TAMqIVL+1XNzKmMyIAbMEm9Y71N5GYhHvmfCbgfv0JiPSn0U1vu9
	 TQX+0cm2/YjR0D/MxcpIcqPeiWhwiwVbDcv7/L2r5JmbH3bvAwE6rGyvkgdQfKmZhh
	 EkxbewrIe2EBjWWSIUcLr8yl3ww+dd8Zta+m4wGX7se8726PzgUdMx4uCngdrCpVTv
	 UAiO2Pe+ICh/09OT0a/sqi4PDZygcMLu/FS6Qhm37LU3RqlJ/frsLcBlU2HMJid9/1
	 ceARJ7C7+QPow==
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
	mdaenzer@redhat.com,
	Philip.Yang@amd.com,
	shashank.sharma@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	Amaranath.Somalapuram@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 36/61] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Sun, 24 Nov 2024 08:45:11 -0500
Message-ID: <20241124134637.3346391-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 8c3fb1562ffef..6f06183e82b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -794,7 +794,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_dma_addr_array(ttm->sg, gtt->ttm.dma_address,
@@ -802,6 +802,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0


