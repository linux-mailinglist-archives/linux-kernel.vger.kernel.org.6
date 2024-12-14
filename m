Return-Path: <linux-kernel+bounces-445904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB999F1D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345C61619BE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CC1925A3;
	Sat, 14 Dec 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZgVrV/Co"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192918C924;
	Sat, 14 Dec 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164174; cv=none; b=ZUCCvbEmIhXQ/W2PbgaXN6cyaatWMKRJJk1GvGCt09H1C88a+ZOJUzNIKcBa8tvp0jXNvIGdt8yJJ1gU3bT2AP/0nVi4BpB0V7kESFidxDgFCNy5yU+oZ01lVJSRA43D+BkeSjIBiBikPsTTVcYgVs/ct1HdBjrltv2TVkqKXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164174; c=relaxed/simple;
	bh=yztjUXBCdTPkj2Cnqf5RxjLATdfzy7Mio76Oa9RTY6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+3F8Idqab+nc2xUuywLAwpnJm/ZQCuKg/rGr4nnXQDVUXUZPHkVc9WdNBX4wjlV1vUTPX3l/Ka5MgPPcRCwR+l1rungWoDNHAH2HRXdAdy469P2FALP45k7SFZW2AFeiaz6nx02PPxSbufAFNoo3BAIm+4fBN8L7b1Auq/omdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZgVrV/Co; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hnZl0
	kD0NHFixyUuAcDalCU1UJrY0bC/p+e25gYBb4Y=; b=ZgVrV/CoIZRLIDk8o4Y7Y
	7Jw/fBZL4LYb/6HsYBzGlVIq6EoRNBdgK05qS722dw4VS1ss2yHOA6J89vO5gvD3
	/J1kEvVjPgK/iBJZZNzbqOoiz6dQwCy+OiopS/i8hiP4mpAwvucEMMrrUOHgzXK1
	vxwZygxlYtgIywvPrKhUs8=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vwGjPl1n3T_wAQ--.16730S8;
	Sat, 14 Dec 2024 16:15:40 +0800 (CST)
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
Subject: [PATCH v6 06/16] drm/rockchip: vop2: Add check for 32 bpp format for rk3588
Date: Sat, 14 Dec 2024 16:15:14 +0800
Message-ID: <20241214081529.3330243-7-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3vwGjPl1n3T_wAQ--.16730S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45Xw1rCw4DKF4DXw4xJFb_yoWkCwb_K3
	47Zw13WrZ7CFn8A3W2qa4fGFZFyan29F4rKayvya4rtF1kZ3WvqayIkry7Was8CFW3KFnr
	Cayjqr1rCF13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wZ23UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQq1XmddM6ytkwAAsT

From: Andy Yan <andy.yan@rock-chips.com>

RK3588 only support DRM_FORMAT_XRGB2101010/XBGR2101010 in afbc mode.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v6:
- Move 32 bpp check to format_mod_supported() hook

Changes in v5:
- Added in V5

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 94f77faf14d1..85d281edfbfe 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -603,6 +603,15 @@ static bool rockchip_vop2_mod_supported(struct drm_plane *plane, u32 format,
 		}
 	}
 
+	if (format == DRM_FORMAT_XRGB2101010 || format == DRM_FORMAT_XBGR2101010) {
+		if (vop2->data->soc_id == 3588) {
+			if (!rockchip_afbc(plane, modifier)) {
+				drm_dbg_kms(vop2->drm, "Only support 32 bpp format with afbc\n");
+				return false;
+			}
+		}
+	}
+
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
-- 
2.34.1


