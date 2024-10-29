Return-Path: <linux-kernel+bounces-386637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC29B4633
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005B71F2389C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C0205ABF;
	Tue, 29 Oct 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JHYa7XiV"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF616204098;
	Tue, 29 Oct 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195761; cv=none; b=hZNG4kYKe4ANVXSKCTBSOJb+c2QPQTiBHctmIn4bNfNZ9M0yUy8CkaU/I3AvNFzVjSUSLw3s+Z07v3/BVvI6iFaGxVx86HaMfdkiBmrBRRxLL7sboLKGJoGACq9aB20m3Ayw7ChlMdtgok5UmgTI+aOMmN1uR6pY0wwgl3/C8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195761; c=relaxed/simple;
	bh=CFj+xhZokaKOBhRPhMpPog1nHJOHHR0mYd2KvuPOUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6KsWLjabelNxTMgQeQrfkjusRLLJsGBWuueOo+flTf+cSdgiQuvb4u8nUicSYWtGKE8Gfl8zZNcrGuF7nmqpIgkmIBCYY2St/etiG51GgtrK3vixQ5L2LoLL4oqocMDAUON/NBe4ClWUYxSxckcqTRhKNUzz2dLCujc/1B6Ti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JHYa7XiV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=p037w
	Wfo3tumQW4UJk0pIjLuOAeGXDeRm1d46l7m6Po=; b=JHYa7XiVo9rSbEFimBhY1
	jYdf3N78yn/ZbFl3OoB6lSu+fqnmC7m84VPbV8FPMvp9vBbwtBc7dRxOYacnkhDr
	GaKFPcnIKEZGUrejbLosBaZO81QCJxzzVzcS2XOzrzBETd9BRaDSEKpTGG0qbJEq
	zNprCi8QeN711By1faogPo=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nxoCsSBn8+3dEA--.3291S11;
	Tue, 29 Oct 2024 17:55:28 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v4 09/14] drm/rockchip: vop2: Introduce vop hardware version
Date: Tue, 29 Oct 2024 17:55:02 +0800
Message-ID: <20241029095513.391006-10-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029095513.391006-1-andyshrk@163.com>
References: <20241029095513.391006-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nxoCsSBn8+3dEA--.3291S11
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xry3ZFWkurWfuFWrtr43Wrg_yoW7CFW3pF
	W7AFWYqrWxGa12gws7Xay3ZF4aywn7AayxGanrGw13tasxKr9rG3Z0qF1ayFs0qFnFkr42
	krs7A34UWF42yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF38nUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx6HXmcgqJmkJQAAsD

From: Andy Yan <andy.yan@rock-chips.com>

There is a version number hardcoded in the VOP VERSION_INFO
register, and the version number increments sequentially based
on the production order of the SOC.

So using this version number to distinguish different VOP features
will simplify the code.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>

---

(no changes since v3)

Changes in v3:
- Add comments for why we should treat rk3566 with special care.
- Add hardware version check

Changes in v2:
- Introduce vop hardware version

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 17 ++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 11 +++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 6a7982ad35509..b4964c70149f9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -354,7 +354,7 @@ static bool vop2_output_uv_swap(u32 bus_format, u32 output_mode)
 
 static bool vop2_output_rg_swap(struct vop2 *vop2, u32 bus_format)
 {
-	if (vop2->data->soc_id == 3588) {
+	if (vop2->version == VOP_VERSION_RK3588) {
 		if (bus_format == MEDIA_BUS_FMT_YUV8_1X24 ||
 		    bus_format == MEDIA_BUS_FMT_YUV10_1X30)
 			return true;
@@ -798,6 +798,7 @@ static void rk3588_vop2_power_domain_enable_all(struct vop2 *vop2)
 static void vop2_enable(struct vop2 *vop2)
 {
 	int ret;
+	u32 version;
 
 	ret = pm_runtime_resume_and_get(vop2->dev);
 	if (ret < 0) {
@@ -817,10 +818,19 @@ static void vop2_enable(struct vop2 *vop2)
 		return;
 	}
 
+	version = vop2_readl(vop2, RK3568_VERSION_INFO);
+	if (version != vop2->version) {
+		drm_err(vop2->drm, "Hardware version(0x%08x) mismatch\n", version);
+		return;
+	}
+	/*
+	 * rk3566 share the same vop version with rk3568, so
+	 * wen need to use soc_id for identification here.
+	 */
 	if (vop2->data->soc_id == 3566)
 		vop2_writel(vop2, RK3568_OTP_WIN_EN, 1);
 
-	if (vop2->data->soc_id == 3588)
+	if (vop2->version == VOP_VERSION_RK3588)
 		rk3588_vop2_power_domain_enable_all(vop2);
 
 	vop2_writel(vop2, RK3568_REG_CFG_DONE, RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN);
@@ -1231,7 +1241,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		 * this bit is gating disable, we should write 1 to
 		 * disable gating when enable afbc.
 		 */
-		if (vop2->data->soc_id == 3566 || vop2->data->soc_id == 3568)
+		if (vop2->version == VOP_VERSION_RK3568)
 			vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 0);
 		else
 			vop2_win_write(win, VOP2_WIN_AFBC_AUTO_GATING_EN, 1);
@@ -2320,6 +2330,7 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 	vop2->dev = dev;
 	vop2->data = vop2_data;
 	vop2->ops = vop2_data->ops;
+	vop2->version = vop2_data->version;
 	vop2->drm = drm;
 
 	dev_set_drvdata(dev, vop2);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 9b269f6e576e8..871d9bcd1d80e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -13,6 +13,15 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
 
+#define VOP2_VERSION(major, minor, build)	((major) << 24 | (minor) << 16 | (build))
+
+/* The new SOC VOP version is bigger than the old */
+#define VOP_VERSION_RK3568	VOP2_VERSION(0x40, 0x15, 0x8023)
+#define VOP_VERSION_RK3588	VOP2_VERSION(0x40, 0x17, 0x6786)
+#define VOP_VERSION_RK3528	VOP2_VERSION(0x50, 0x17, 0x1263)
+#define VOP_VERSION_RK3562	VOP2_VERSION(0x50, 0x17, 0x4350)
+#define VOP_VERSION_RK3576	VOP2_VERSION(0x50, 0x19, 0x9765)
+
 #define VOP2_VP_FEATURE_OUTPUT_10BIT        BIT(0)
 
 #define VOP2_FEATURE_HAS_SYS_GRF	BIT(0)
@@ -235,6 +244,7 @@ struct vop2_ops {
 struct vop2_data {
 	u8 nr_vps;
 	u64 feature;
+	u32 version;
 	const struct vop2_ops *ops;
 	const struct vop2_win_data *win;
 	const struct vop2_video_port_data *vp;
@@ -252,6 +262,7 @@ struct vop2_data {
 };
 
 struct vop2 {
+	u32 version;
 	struct device *dev;
 	struct drm_device *drm;
 	struct vop2_video_port vps[ROCKCHIP_MAX_CRTC];
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 8473dc9c232c1..efd704464fabf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1593,6 +1593,7 @@ static const struct vop2_ops rk3588_vop_ops = {
 };
 
 static const struct vop2_data rk3566_vop = {
+	.version = VOP_VERSION_RK3568,
 	.feature = VOP2_FEATURE_HAS_SYS_GRF,
 	.nr_vps = 3,
 	.max_input = { 4096, 2304 },
@@ -1611,6 +1612,7 @@ static const struct vop2_data rk3566_vop = {
 };
 
 static const struct vop2_data rk3568_vop = {
+	.version = VOP_VERSION_RK3568,
 	.feature = VOP2_FEATURE_HAS_SYS_GRF,
 	.nr_vps = 3,
 	.max_input = { 4096, 2304 },
@@ -1629,6 +1631,7 @@ static const struct vop2_data rk3568_vop = {
 };
 
 static const struct vop2_data rk3588_vop = {
+	.version = VOP_VERSION_RK3588,
 	.feature = VOP2_FEATURE_HAS_SYS_GRF | VOP2_FEATURE_HAS_VO1_GRF |
 		   VOP2_FEATURE_HAS_VOP_GRF | VOP2_FEATURE_HAS_SYS_PMU,
 	.nr_vps = 4,
-- 
2.34.1


