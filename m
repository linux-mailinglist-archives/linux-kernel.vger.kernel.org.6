Return-Path: <linux-kernel+bounces-251927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34A930BB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEAFB225CA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841E13D2A4;
	Sun, 14 Jul 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="duDCEIXY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433C18AED
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990520; cv=none; b=cQpwaY0ZTP//gr82Xe0ZUE0siq3OxuYBHB7Z7suNnpUB4yBIB8g7h/2kQB2sfCYTXcR8nWTrVdgq7j80TeNk+cy+XS91rRcFgFiyHiuLDqyrYAsRFopaxVT3lBAY87yDK6lph7rFoSndtEt9mjcRbh5M6KGuvJ/i2JOMFHZHYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990520; c=relaxed/simple;
	bh=l4xsjIr2yWIZHysqAEzUVid0VQrRTtDHb+yw12BZMEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6gFrWybbHARXL6Lh90F6p9HFlpv1qJHpcSfq+xAlCVL716SY7z0HgTmHKrYQe4rAoAOV/AcljpOhRE+utpgRP95DCOGtgE8G2mdQpRPTdFtmXGHs4gVVg7t6rVuMtf1/lI/5+QWSFlQAgio3d9qWhXwRamM1XJKc+UwBv4psLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=duDCEIXY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720990517;
	bh=l4xsjIr2yWIZHysqAEzUVid0VQrRTtDHb+yw12BZMEA=;
	h=From:To:Cc:Subject:Date:From;
	b=duDCEIXYMlBwWCf8Ry87YZq4udmJPTuQ+8O1DqDCyg7gcD+EfI2PPAgOBEk43cRaE
	 xHXzF6vKQFz8juQdphgoC/rgMJREzSQmO7tnVNxt2LDQs89mNj0k5zsgb6A0fCnZNZ
	 4KBOfK0vR9bhpWXjb3GtaLf9yYRQuscfMgutIQy4Kk6Uiwwtps+n8JOjOuSE0JCAL1
	 l6/FPADPlRD7j1wFBS5GVO6uLKyiD2sBBX8fHWge/6BCTYftZi0nLTWFz1YW5FbVTs
	 vCnPezkFtvRuaaeZnJ50+vwZi004LAV4KcyXTVMGJbS9IFt66KlojViRkVOgmvQVhh
	 pIHmjmrlkBq/g==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 81EA337804CF;
	Sun, 14 Jul 2024 20:55:16 +0000 (UTC)
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
Subject: [PATCH v1] drm/virtio: Add DRM capset definition
Date: Sun, 14 Jul 2024 23:55:02 +0300
Message-ID: <20240714205502.3409718-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define DRM native context capset in the VirtIO-GPU protocol header.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0e21f3998108..bf2c9cabd207 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -311,6 +311,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VIRGL2 2
 /* 3 is reserved for gfxstream */
 #define VIRTIO_GPU_CAPSET_VENUS 4
+#define VIRTIO_GPU_CAPSET_DRM 6
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.45.2


