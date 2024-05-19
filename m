Return-Path: <linux-kernel+bounces-183158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C38C955A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF91C208D6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94F45BE4;
	Sun, 19 May 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKowqIjP"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBC1DFCB
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137737; cv=none; b=M1crnlUKMkvS9ijNgJ7e0XailwYGCJaW7O6kBQJR7c0JUatBendWhT6yMO89rFuVu7uMGS7kzIpnQ/WyeJXDqfoKFelB5WViRJPU7Q9VPps3gIUq34m6SHFZTYk5Ltm2WDRm1itsdDA+1F7K/K32XxEXo8tEfvWtpktOz1l1g2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137737; c=relaxed/simple;
	bh=2tOtaCRxRph0PTMDHLzelUUn+onpkPRFXw3ZipPu0ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZb1NwItOOBpR3MFVyjX/tEu+UfcVghPeOPguSc5g2vsWWSe+wlyK1ueRzs4JEf1TzUK6MhBn//F4T1IJooMs52IYOadk2KND5q8T72XO+7Ed3M+xNG5mFfhplli+jEEA4Ip6bFtmng86bkbGuzHL93yyN3pKrYL93o7GR8slhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKowqIjP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: l.stach@pengutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716137734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJoc0KMwzsmIaav0VlUAEml/vTeXcEP0ggNixh3RBXA=;
	b=OKowqIjPtjotymtjYZy07VzQRnpNqCA8o/6QsYXk+fkQ8Aff1w7nxIkroJYKrny+HzJlNB
	v4+yKyxxwgNPfbOlcD4PLpPUJwB2S2UAGDGxaDwFFaBjeySfQz/tnhdI39MqGvl7wRqWxW
	JTQx+S+Qmxg7Hz7h6L3eTppRXyRB2M0=
X-Envelope-To: linux+etnaviv@armlinux.org.uk
X-Envelope-To: christian.gmeiner@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: etnaviv@lists.freedesktop.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	linux-kernel@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v14 5/8] drm/etnaviv: Add support for cached coherent caching mode
Date: Mon, 20 May 2024 00:53:18 +0800
Message-Id: <20240519165321.2123356-6-sui.jingfeng@linux.dev>
In-Reply-To: <20240519165321.2123356-1-sui.jingfeng@linux.dev>
References: <20240519165321.2123356-1-sui.jingfeng@linux.dev>
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
snooping CPU's cache. When hit the peripheral devices will access data
directly from CPU's cache. This means that device drivers do not need to
maintain the coherency issue between a processor and peripheral I/O for
the cached buffers. Hence, it dosen't need us to sync manually on the
software side, which is useful to avoid some overheads, especially for
userspace, but userspace is not known yet.

Probe the hardware maintained cached coherent support of the host platform
with the dev_is_dma_coherent() function, and store the result in struct
etnaviv_drm_private. As this is a platform implementation-defined hardware
feature and again is meant to be shared by all GPU cores. And expose it
via etnaviv parameter mechanism to let userspace know.

Please note that write-combine mapping out of scope of the discussion
and therefore is not being addressed.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 3 +++
 drivers/gpu/drm/etnaviv/etnaviv_drv.h | 9 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++++
 include/uapi/drm/etnaviv_drm.h        | 1 +
 4 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index e3eb31ba9a2b..986fd68b489a 100644
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
index 1f9b50b5a6aa..4b59fdb457b7 100644
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
index 02d7efdc82c0..aa15682f94db 100644
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
2.34.1


