Return-Path: <linux-kernel+bounces-251925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC367930BAF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764EE281338
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1311420B0;
	Sun, 14 Jul 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jxuj7UD6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0B140E34
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990233; cv=none; b=L3AEk9O7wSFs0QigQL3QoeLI0vLkE9u7bH6B8e+IuZUgZxvbK13idXmIoUqLmyk2eCb1W1r5XAWMftE1h/LFml7RaW91r2o28/Z3BI00qLG3DhgH3kQ8VnE8h7ZGuk/Ji8k+Rp4uO/JasQJiUii6THyKnY5x3Zg51QqmTG3aYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990233; c=relaxed/simple;
	bh=T/Gg5LCdbc3pyngeHeDNyKd9/vkluJt43cQ8abcaNbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnP7V7YbNKZyWtYLAemIZrK9DmIBaZ1JyUbwNOxklx0dqE7hRx2Ye0YjjqxWr4iiSupwGpGU3Rr4ix996GiaJjrGR1/X4lS+9PcCRV9LkGCuT4i2AvuTZqpPMtNAVCJqYfeAbgEsTFh93PFB4Kf3W66l9umuJe3RNPCqnXevoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jxuj7UD6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720990229;
	bh=T/Gg5LCdbc3pyngeHeDNyKd9/vkluJt43cQ8abcaNbY=;
	h=From:To:Cc:Subject:Date:From;
	b=Jxuj7UD6U1Ic+UH0MbQnFiN/Do+ZpQoVvK/xkaeJpjpf+olsolgmPwP9ORCXkQ6Xk
	 lEgHXMR9ESfrIzPCSooaEZXkBmHgr1owxexKGk2Qmt/1mHg/RwfUAI14HqiRpCayvS
	 aJEhRAgfGPexnKzd4AD8nwMl18lj/iCSx99WoNyfJ/lG6ojA2vFW/j8BJIZSdxNfSn
	 9tODopu4QpYp14SJepw5NXe3lxLV8iRSG/pXyxLV6SPrDw7Db/7vI4jnQhhup9SS4M
	 3l8Jl+Mt9Ez+sppk+LT3SMXQmh9QnaxbOcLNdAVgGGStzkSRAtw2PXaFdNNV1HXKhh
	 2Rec9k41Dy8Uw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5FDAA37804CF;
	Sun, 14 Jul 2024 20:50:28 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1] drm/virtio: Fix type of dma-fence context variable
Date: Sun, 14 Jul 2024 23:50:09 +0300
Message-ID: <20240714205009.3408298-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Type of DMA fence context is u64. Fence-waiting code uses u32 for the
context variable, fix it.

Fixes: e4812ab8e6b1 ("drm/virtio: Refactor and optimize job submission code path")
Cc: <stable@vger.kernel.org> # v6.4+
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 1c7c7f61a222..7d34cf83f5f2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -48,7 +48,7 @@ struct virtio_gpu_submit {
 static int virtio_gpu_do_fence_wait(struct virtio_gpu_submit *submit,
 				    struct dma_fence *in_fence)
 {
-	u32 context = submit->fence_ctx + submit->ring_idx;
+	u64 context = submit->fence_ctx + submit->ring_idx;
 
 	if (dma_fence_match_context(in_fence, context))
 		return 0;
-- 
2.45.2


