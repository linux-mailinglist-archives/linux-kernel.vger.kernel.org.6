Return-Path: <linux-kernel+bounces-226569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DA914074
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A65C1F2326C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417674A31;
	Mon, 24 Jun 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V5g7F1yN"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AC8F6B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719195767; cv=none; b=Gcl53KJfkqiFlFB7sgLA3q7oUHZTl5crJ0ht1kDoAXNq17O7/WFJ7PUnPR/8wd+ijgWFojEbKtHrkrrFxYopZZVi+MQ007PFs0RppMtiS9om37DRs49iVSYQthsiWfUS7c+yKT2LkXl/XXApS5H09mYnmLaLGh2kz3iDAn/QrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719195767; c=relaxed/simple;
	bh=6YzOxnilk0PuhAwWxxsUzEExKINASZnAV6ozh9w/Mco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0Pdo4DKYDQRU5HS8b15WaPPjGD4f7VvUSi8cmQ5feYdQHmzltqlXfnmJv0ti1kChhy4XDNFTbEZgqvQzJcDf/8Dw5GhFFqzgyqGPySvRDI0ThP1oG4zMdUBdeCmB7YArRdbIYb1+1gVNRFZyJ2QWaWUVxKKxT6BaDqFoowX9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V5g7F1yN; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719195756; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4oEKDf6ktKNvNm2YhLgJ2R/X0teHz21rhJGCnMtpSVo=;
	b=V5g7F1yNeV15jSjRPEoaUld2zKeulaCaf7Lu7iaSgOcSo8p3Jl17yctn6SycMov8UEUbXa3eZF6N2tNErV6Y2eS1jNfAhrfufAXsjbuzTMToQO814h+ExWe6k2ir/5kWhfZ/8gKxbH8K9jar9SGC6NfhJr5kbQyN8sfiKK7LdeA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W90xIIb_1719195747;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W90xIIb_1719195747)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 10:22:35 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Remove unused function reverse_planes_order
Date: Mon, 24 Jun 2024 10:22:25 +0800
Message-Id: <20240624022225.28655-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the amdgpu_dm.c file, but not called
anywhere, so delete the unused function.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:371:20: warning: unused function 'reverse_planes_order'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9402
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b86b30eddc4..1e0e33b565f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -368,15 +368,6 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 		return false;
 }
 
-static inline void reverse_planes_order(struct dc_surface_update *array_of_surface_update,
-					int planes_count)
-{
-	int i, j;
-
-	for (i = 0, j = planes_count - 1; i < j; i++, j--)
-		swap(array_of_surface_update[i], array_of_surface_update[j]);
-}
-
 /*
  * DC will program planes with their z-order determined by their ordering
  * in the dc_surface_updates array. This comparator is used to sort them
-- 
2.20.1.7.g153144c


