Return-Path: <linux-kernel+bounces-320107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A51970645
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3B31F22165
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF514D2A4;
	Sun,  8 Sep 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sLuJ4FwA"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D7153BF9
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788700; cv=none; b=nIPNKioSEDGPkmLQwO8oz+7KRsbbEXU11SNP4Zxou4jGq519QJdMmyR1xoA2bxwAdWx13EmXvKQSk+ETwnBuQE6+xpKKkIFVdA2K80rpJOb/v7AI8bidtuQHLZctW0vA5BRRsL7+y8iBJ7mdHn3jF1oPMiUUbp66A8TaKW+zCKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788700; c=relaxed/simple;
	bh=bjbz3dqtENBUFgZMlsBV8tV/J9grmvaz9GmX2AYbnkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In8MqB1K4Gp/iwDhFuKc5uSqLCeERQNCsynqUyzzbC9tl5D0lRMmnb0PYY4fdnF6mkchxOdRWl3+7eeZ2J7xduNFuUkf6zhnXJBOFHKkOsebCTB7KUJNIEczVn8tmhloqg7W/RECyorj440HyU8xkoZ1JOuRmrQC+3I9I6Rsinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sLuJ4FwA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39adqGGC3e2Pv/tZE+pzQWRwMFjN4uRm877+Emztr/o=;
	b=sLuJ4FwAmg+yPZ4oY2ShaFtmz5W5L2GAqdv1dqyLOJ0ecbbqkHp4w6DPW0n8ZyTNCWvuYN
	vtndJmifNfANx1R5AuDmR0GGwIEJXCsHD/pvgbQjsV8MtiMOZqyuDCRKMO2fu8llyAhl4A
	f+ppnpgsAuwfuMamlPUtu8Ga5kkqyvA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 12/19] drm/etnaviv: Add support for cached coherent caching mode
Date: Sun,  8 Sep 2024 17:43:50 +0800
Message-ID: <20240908094357.291862-13-sui.jingfeng@linux.dev>
In-Reply-To: <20240908094357.291862-1-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Many modern CPUs and/or platforms choose to define their peripheral devices
as cached coherent by default, to be specific, the PCH is capable of
snooping CPU's cache. When hit, the peripheral devices will access data
directly from CPU's cache. This means that device drivers do not need to
maintain the coherency issue between a processor and peripheral I/O for
the cached buffers. Hence, it dosen't need us to sync manually on the
software side, which is useful to avoid some overheads, especially for
userspace, but userspace is not known this yet.

Probe the hardware maintained cached coherent support with the
dev_is_dma_coherent() function, and store the result in the
etnaviv_drm_private structure. Since this is a host and/or platform
implementation-defined hardware feature, and is again meant to be shared
by all GPU cores. The probe function can be extended in the future if it
not reflect the hardware perfectly.

Expose it via etnaviv parameter mechanism to let userspace know.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 3 +++
 drivers/gpu/drm/etnaviv/etnaviv_drv.h | 9 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++++
 include/uapi/drm/etnaviv_drm.h        | 1 +
 4 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 32ec1b5452ba..18686b573d77 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -5,6 +5,7 @@
 
 #include <linux/component.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -57,6 +58,8 @@ static int etnaviv_private_init(struct device *dev,
 		return -ENOMEM;
 	}
 
+	priv->cached_coherent = dev_is_dma_coherent(dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index e2a991160cb3..02d706b34752 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -46,6 +46,15 @@ struct etnaviv_drm_private {
 	struct xarray active_contexts;
 	u32 next_context_id;
 
+	/*
+	 * If true, the cached mapping is consistent for all CPU cores and
+	 * peripheral bus masters in the system. It means that both of the
+	 * CPU and GPU will see the same data if the buffer being accessed
+	 * is cached. And the coherency is guaranteed by the host platform
+	 * specific hardwares.
+	 */
+	bool cached_coherent;
+
 	/* list of GEM objects: */
 	struct mutex gem_lock;
 	struct list_head gem_list;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 0c8e394b569c..89fb36aee779 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -164,6 +164,10 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
 		*value = gpu->identity.eco_id;
 		break;
 
+	case ETNAVIV_PARAM_CACHED_COHERENT:
+		*value = priv->cached_coherent;
+		break;
+
 	default:
 		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
 		return -EINVAL;
diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_drm.h
index af024d90453d..61eaa8cd0f5e 100644
--- a/include/uapi/drm/etnaviv_drm.h
+++ b/include/uapi/drm/etnaviv_drm.h
@@ -77,6 +77,7 @@ struct drm_etnaviv_timespec {
 #define ETNAVIV_PARAM_GPU_PRODUCT_ID                0x1c
 #define ETNAVIV_PARAM_GPU_CUSTOMER_ID               0x1d
 #define ETNAVIV_PARAM_GPU_ECO_ID                    0x1e
+#define ETNAVIV_PARAM_CACHED_COHERENT               0x1f
 
 #define ETNA_MAX_PIPES 4
 
-- 
2.43.0


