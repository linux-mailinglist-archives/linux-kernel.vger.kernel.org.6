Return-Path: <linux-kernel+bounces-445897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D039F1D47
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958561887673
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7991714B4;
	Sat, 14 Dec 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BS/5ATpR"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9AF383;
	Sat, 14 Dec 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164169; cv=none; b=QlPxweDiEmO0CtkZBeD79N5QU9xowo8dorKW0OJtZwG+GE1ItYyEYR6Dv/w94ECGkBkrFTX5btsWoRZmRHtWqBiEcKl8iWa4152zKFy/wnB7su4c7Ix+ffhB+Sz47VRXTKsyLbfZ5UfAIGY/7kJMv3A1Jw7w9OhTMoB8sdWeO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164169; c=relaxed/simple;
	bh=7hEsaCq02T7B9DHIwNoycirFiZW5Z5mlQYwOER58ICc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItyY0iIrUkFwWsyHN0AIlyP85D89Pj+lKw9EsEba/kd+nfxH0IU9NNSVMeF/oA54FRAa4QzuXP3duRJ2qE6YxBiW7Qd8as8/iMrec9OkItpM2XvhQM7UR3J9JGAe+tkJSCXh+gpqALd1k02gBuTIYdNk+xnNgRIb8NPzvWR2mc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BS/5ATpR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=j+qcT
	Ukc/BnBCDtZ2o87bQo2kXQ62aGX4577Kc8A3m8=; b=BS/5ATpR7cL4kqJYq0t04
	DEr+7rdVHzzzeDhI88YGop6Q+in2N3FJktzb94DLQf7dgAtnrGkZP3Ud92Yn+X67
	BzdXwcOHSB6bE1kdgarW4fwrI7VO9mrLODn2tmTrCD6K4TM3obXrkFilh3RXWl/q
	3Rxn6qgbK4s7LjcxF4Ki10=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vwGjPl1n3T_wAQ--.16730S7;
	Sat, 14 Dec 2024 16:15:39 +0800 (CST)
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
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v6 05/16] drm/rockchip: vop2: Check linear format for Cluster windows on rk3566/8
Date: Sat, 14 Dec 2024 16:15:13 +0800
Message-ID: <20241214081529.3330243-6-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214081529.3330243-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
 <20241214081529.3330243-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwGjPl1n3T_wAQ--.16730S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xKF1UZr1DWFW8Aw18Zrb_yoWktrX_Ca
	4xXw13Wrs7KFn8X3W29ayfWrZFyan29F48tF48ta4ktF1Dua97t3sayFW7Gas8CFWfGFnr
	ua4UXF10kF9xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wZ23UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxW1XmddNBynnQABsk

From: Andy Yan <andy.yan@rock-chips.com>

The Cluster windows on rk3566/8 only support afbc mode.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v6:
- Move the linear check to format_mod_supported() hook

Changes in v5:
- Added in V5

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index f143df2b13a1..94f77faf14d1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -593,6 +593,16 @@ static bool rockchip_vop2_mod_supported(struct drm_plane *plane, u32 format,
 	if (modifier == DRM_FORMAT_MOD_INVALID)
 		return false;
 
+	if (vop2->data->soc_id == 3568 || vop2->data->soc_id == 3566) {
+		if (vop2_cluster_window(win)) {
+			if (modifier == DRM_FORMAT_MOD_LINEAR) {
+				drm_dbg_kms(vop2->drm,
+					    "Cluster window only support format with afbc\n");
+				return false;
+			}
+		}
+	}
+
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
-- 
2.34.1


