Return-Path: <linux-kernel+bounces-569476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1529A6A380
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037B119C14B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F2223300;
	Thu, 20 Mar 2025 10:22:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EB215783
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466168; cv=none; b=rXvHnjAOMN0NpfUmtyNYZtSYzQfXvDgmHUjuCO+Ntk8U7q0tYa8RdWZ0j/Zt26q/9iANfQTTmNbaEx0IcdKPyUXoqM5u1RzjeWbry5yoYuqX6ChJUBNSHX6ltourWRl6N3o2vmiCMIfgJRqKILnN78bE2cq03AkvqRvRH4oZT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466168; c=relaxed/simple;
	bh=BsmGfVImH6VmbiWg9CYuWRiKEpSKEg4JkR4i2MKy3Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bARA9KXYTWGtCWTRYvGf4cOS+0RMIdvBjC80WPJFEXar40xjcx4CC/Hqdqfjy+U8hh2wrXxa+aT3fU5e3UyuK/3deoq2ti54rn3BHAL1Bq/jmfN3Me3ywEGbbpRvIPldqWDxLtzkzk1AqW34tkQMZ2JKi6Nqcnuqg+OVckj6GfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZJM6z17t1ztR9V;
	Thu, 20 Mar 2025 18:21:15 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D68E01800E5;
	Thu, 20 Mar 2025 18:22:42 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 20 Mar 2025 18:22:41 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 drm-dp 1/9] drm/hisilicon/hibmc: Restructuring the header dp_reg.h
Date: Thu, 20 Mar 2025 18:14:47 +0800
Message-ID: <20250320101455.2538835-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250320101455.2538835-1-shiyongbang@huawei.com>
References: <20250320101455.2538835-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: Baihan Li <libaihan@huawei.com>

Move the macros below their corresponding registers to make
them more obvious.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
ChangeLog:
v2 -> v3:
  - restructuring the header dp_reg.h, suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h | 98 +++++++++++++--------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index 4a515c726d52..dc2bd3f80b70 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -5,72 +5,94 @@
 #define DP_REG_H
 
 #define HIBMC_DP_AUX_CMD_ADDR			0x50
+
 #define HIBMC_DP_AUX_WR_DATA0			0x54
 #define HIBMC_DP_AUX_WR_DATA1			0x58
 #define HIBMC_DP_AUX_WR_DATA2			0x5c
 #define HIBMC_DP_AUX_WR_DATA3			0x60
 #define HIBMC_DP_AUX_RD_DATA0			0x64
+
 #define HIBMC_DP_AUX_REQ			0x74
+#define HIBMC_DP_CFG_AUX_REQ			BIT(0)
+#define HIBMC_DP_CFG_AUX_SYNC_LEN_SEL		BIT(1)
+#define HIBMC_DP_CFG_AUX_TIMER_TIMEOUT		BIT(2)
+#define HIBMC_DP_CFG_AUX_MIN_PULSE_NUM		GENMASK(13, 9)
+
 #define HIBMC_DP_AUX_STATUS			0x78
+#define HIBMC_DP_CFG_AUX_TIMEOUT		BIT(0)
+#define HIBMC_DP_CFG_AUX_STATUS			GENMASK(11, 4)
+#define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
+#define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
+
 #define HIBMC_DP_PHYIF_CTRL0			0xa0
+#define HIBMC_DP_CFG_SCRAMBLE_EN		BIT(0)
+#define HIBMC_DP_CFG_PAT_SEL			GENMASK(7, 4)
+#define HIBMC_DP_CFG_LANE_DATA_EN		GENMASK(11, 8)
+
 #define HIBMC_DP_VIDEO_CTRL			0x100
+#define HIBMC_DP_CFG_STREAM_RGB_ENABLE		BIT(1)
+#define HIBMC_DP_CFG_STREAM_VIDEO_MAPPING	GENMASK(5, 2)
+#define HIBMC_DP_CFG_STREAM_FRAME_MODE		BIT(6)
+#define HIBMC_DP_CFG_STREAM_HSYNC_POLARITY	BIT(7)
+#define HIBMC_DP_CFG_STREAM_VSYNC_POLARITY	BIT(8)
+
 #define HIBMC_DP_VIDEO_CONFIG0			0x104
+#define HIBMC_DP_CFG_STREAM_HACTIVE		GENMASK(31, 16)
+#define HIBMC_DP_CFG_STREAM_HBLANK		GENMASK(15, 0)
+
 #define HIBMC_DP_VIDEO_CONFIG1			0x108
+#define HIBMC_DP_CFG_STREAM_VACTIVE		GENMASK(31, 16)
+#define HIBMC_DP_CFG_STREAM_VBLANK		GENMASK(15, 0)
+
 #define HIBMC_DP_VIDEO_CONFIG2			0x10c
+#define HIBMC_DP_CFG_STREAM_HSYNC_WIDTH		GENMASK(15, 0)
+
 #define HIBMC_DP_VIDEO_CONFIG3			0x110
+#define HIBMC_DP_CFG_STREAM_VSYNC_WIDTH		GENMASK(15, 0)
+#define HIBMC_DP_CFG_STREAM_VFRONT_PORCH	GENMASK(31, 16)
+
 #define HIBMC_DP_VIDEO_PACKET			0x114
+#define HIBMC_DP_CFG_STREAM_TU_SYMBOL_SIZE	GENMASK(5, 0)
+#define HIBMC_DP_CFG_STREAM_TU_SYMBOL_FRAC_SIZE	GENMASK(9, 6)
+
 #define HIBMC_DP_VIDEO_MSA0			0x118
+#define HIBMC_DP_CFG_STREAM_VSTART		GENMASK(31, 16)
+#define HIBMC_DP_CFG_STREAM_HSTART		GENMASK(15, 0)
+
 #define HIBMC_DP_VIDEO_MSA1			0x11c
 #define HIBMC_DP_VIDEO_MSA2			0x120
+
 #define HIBMC_DP_VIDEO_HORIZONTAL_SIZE		0X124
+#define HIBMC_DP_CFG_STREAM_HTOTAL_SIZE		GENMASK(31, 16)
+#define HIBMC_DP_CFG_STREAM_HBLANK_SIZE		GENMASK(15, 0)
+
 #define HIBMC_DP_TIMING_GEN_CONFIG0		0x26c
+#define HIBMC_DP_CFG_TIMING_GEN0_HACTIVE	GENMASK(31, 16)
+#define HIBMC_DP_CFG_TIMING_GEN0_HBLANK		GENMASK(15, 0)
+
 #define HIBMC_DP_TIMING_GEN_CONFIG2		0x274
+#define HIBMC_DP_CFG_TIMING_GEN0_VACTIVE	GENMASK(31, 16)
+#define HIBMC_DP_CFG_TIMING_GEN0_VBLANK		GENMASK(15, 0)
+
 #define HIBMC_DP_TIMING_GEN_CONFIG3		0x278
+#define HIBMC_DP_CFG_TIMING_GEN0_VFRONT_PORCH	GENMASK(31, 16)
+
 #define HIBMC_DP_HDCP_CFG			0x600
+
 #define HIBMC_DP_DPTX_RST_CTRL			0x700
+#define HIBMC_DP_CFG_AUX_RST_N			BIT(4)
+
 #define HIBMC_DP_DPTX_CLK_CTRL			0x704
+
 #define HIBMC_DP_DPTX_GCTL0			0x708
+#define HIBMC_DP_CFG_PHY_LANE_NUM		GENMASK(2, 1)
+
 #define HIBMC_DP_INTR_ENABLE			0x720
 #define HIBMC_DP_INTR_ORIGINAL_STATUS		0x728
-#define HIBMC_DP_TIMING_MODEL_CTRL		0x884
-#define HIBMC_DP_TIMING_SYNC_CTRL		0xFF0
 
-#define HIBMC_DP_CFG_AUX_SYNC_LEN_SEL		BIT(1)
-#define HIBMC_DP_CFG_AUX_TIMER_TIMEOUT		BIT(2)
-#define HIBMC_DP_CFG_STREAM_FRAME_MODE		BIT(6)
-#define HIBMC_DP_CFG_AUX_MIN_PULSE_NUM		GENMASK(13, 9)
-#define HIBMC_DP_CFG_LANE_DATA_EN		GENMASK(11, 8)
-#define HIBMC_DP_CFG_PHY_LANE_NUM		GENMASK(2, 1)
-#define HIBMC_DP_CFG_AUX_REQ			BIT(0)
-#define HIBMC_DP_CFG_AUX_RST_N			BIT(4)
-#define HIBMC_DP_CFG_AUX_TIMEOUT		BIT(0)
-#define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
-#define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
-#define HIBMC_DP_CFG_AUX_STATUS			GENMASK(11, 4)
-#define HIBMC_DP_CFG_SCRAMBLE_EN		BIT(0)
-#define HIBMC_DP_CFG_PAT_SEL			GENMASK(7, 4)
-#define HIBMC_DP_CFG_TIMING_GEN0_HACTIVE	GENMASK(31, 16)
-#define HIBMC_DP_CFG_TIMING_GEN0_HBLANK		GENMASK(15, 0)
-#define HIBMC_DP_CFG_TIMING_GEN0_VACTIVE	GENMASK(31, 16)
-#define HIBMC_DP_CFG_TIMING_GEN0_VBLANK		GENMASK(15, 0)
-#define HIBMC_DP_CFG_TIMING_GEN0_VFRONT_PORCH	GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_HACTIVE		GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_HBLANK		GENMASK(15, 0)
-#define HIBMC_DP_CFG_STREAM_HSYNC_WIDTH		GENMASK(15, 0)
-#define HIBMC_DP_CFG_STREAM_VACTIVE		GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_VBLANK		GENMASK(15, 0)
-#define HIBMC_DP_CFG_STREAM_VFRONT_PORCH	GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_VSYNC_WIDTH		GENMASK(15, 0)
-#define HIBMC_DP_CFG_STREAM_VSTART		GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_HSTART		GENMASK(15, 0)
-#define HIBMC_DP_CFG_STREAM_VSYNC_POLARITY	BIT(8)
-#define HIBMC_DP_CFG_STREAM_HSYNC_POLARITY	BIT(7)
-#define HIBMC_DP_CFG_STREAM_RGB_ENABLE		BIT(1)
-#define HIBMC_DP_CFG_STREAM_VIDEO_MAPPING	GENMASK(5, 2)
+#define HIBMC_DP_TIMING_MODEL_CTRL		0x884
 #define HIBMC_DP_CFG_PIXEL_NUM_TIMING_MODE_SEL1	GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_TU_SYMBOL_SIZE	GENMASK(5, 0)
-#define HIBMC_DP_CFG_STREAM_TU_SYMBOL_FRAC_SIZE	GENMASK(9, 6)
-#define HIBMC_DP_CFG_STREAM_HTOTAL_SIZE		GENMASK(31, 16)
-#define HIBMC_DP_CFG_STREAM_HBLANK_SIZE		GENMASK(15, 0)
+
+#define HIBMC_DP_TIMING_SYNC_CTRL		0xFF0
 
 #endif
-- 
2.33.0


