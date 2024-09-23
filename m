Return-Path: <linux-kernel+bounces-335360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0897E49A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FC728138A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60D8479;
	Mon, 23 Sep 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qkgRhM5d"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6A1103
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054706; cv=none; b=mTQSPWjuPZCyHy52OiiJpPGB7kahiyyLppSMVQD/QxgVdCoMQzZ8UAYggtrl4HnrGgfvRxH/5RTKP2NbYPgxcFInEtNFT2Wj9FZxpLkI6odPmu/Jzv6S9z39uH55P/YNBo0P9WUoQlW+ts8LW+4YlBINjX3zjjZCBuwlM6n1678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054706; c=relaxed/simple;
	bh=DFGtUPCPI3+q1O+VosHFzBUDacm67Kdl0BZaDsz92Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E28IsxRHcXr1MaoOiOOo+5litVWuxPrE5RVm2cAI26GEp5uecWyJUFHmD3g65aBsQzSdJxW7RSKMWw7JFqKIzZTf7eDN+XYBKYpiHM+yVZkxm8tVGwnPwhqEHU9XTf92zaeqjtI43fzrK9siXerAqyJlu2WWP/YdgO/2yMXt/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qkgRhM5d; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Rz0QSDeykvTiESrk8g5g5XNM5hvpuDENvkUjExEkk/Q=; b=qkgRhM5dLdt/tp3U
	X23UPp0rehugemRAc/OZ29/NXSmwNO4rgMZ4P9AgJ/0HeUka/fDv+hK2e6XGIPQOH1UY9uAD5pjwz
	ASCMH6+zsUCEYxSdJ93f7Jb5VNmtCPU8PdK6p5OfwdhqKN2qXJwTByCtBq9hmHO7GsLtH+nC74yGu
	TQ2sZdMYn+vnEXkMc/aNV5HzHX7Iz4L1RmUkGyy4JQp+lZW/od1G8VZLJPl+fxDrJ22N4JdJd62H3
	P+IyaoZy7Otf4TaONUsot1WWluKMGCzVs9+cDIlhz8wmSmC8QrAIdQXx2WGSCU7YEeX65LeWaS1Ld
	pVYufPdpxGAXEuvu5Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ssXoy-006k2k-2f;
	Mon, 23 Sep 2024 01:25:00 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 4/5] drm/amdgpu: Remove unused amdgpu_gfx_bit_to_me_queue
Date: Mon, 23 Sep 2024 02:24:45 +0100
Message-ID: <20240923012446.4965-5-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923012446.4965-1-linux@treblig.org>
References: <20240923012446.4965-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

amdgpu_gfx_bit_to_me_queue has been unused since it was added in
commit 7470bfcf2014 ("drm/amdgpu: add helper function for gfx queue/bitmap
transition")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 83e54697f0ee..0fbb7c7b736d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -87,16 +87,6 @@ int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
 	return bit;
 }
 
-void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
-				int *me, int *pipe, int *queue)
-{
-	*queue = bit % adev->gfx.me.num_queue_per_pipe;
-	*pipe = (bit / adev->gfx.me.num_queue_per_pipe)
-		% adev->gfx.me.num_pipe_per_me;
-	*me = (bit / adev->gfx.me.num_queue_per_pipe)
-		/ adev->gfx.me.num_pipe_per_me;
-}
-
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
 				    int me, int pipe, int queue)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5644e10a86a9..f710178a21bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -540,8 +540,6 @@ bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
 			       int pipe, int queue);
-void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
-				int *me, int *pipe, int *queue);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
-- 
2.46.1


