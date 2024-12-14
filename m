Return-Path: <linux-kernel+bounces-445916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF09F1D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3383188CF4B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB531ACDE8;
	Sat, 14 Dec 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bOHD6Tlu"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB987191F60;
	Sat, 14 Dec 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164277; cv=none; b=DXY1zUKPwNaKBUXH027Iij8JnPhGbivhl52GJkQoM17I1cEasM9f6CGNobn3PZJE6iheBE+eJSq7ToklivyQhVEpVYVmpHhPgny7QENQ5lMgpW2ldlDyGcnbpFxLm9RIveM5Qz3cdsJO8KUNiINwiQolHXVpQ9IMdfxJbleNJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164277; c=relaxed/simple;
	bh=7hEsaCq02T7B9DHIwNoycirFiZW5Z5mlQYwOER58ICc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCT34H2tyA2OS2U/9F61vvkyrwMjO0hPcd9mXWbfVaJaNrRYO9+YQeCCpw5IfuGx4OaflD9mZwIt75vOG5/pO6mqb41s3qoD6gKFy7iERkkghQvovVslF8kXujmplGgpVdohhxog1TuN3iJqBtBtRLkxhq5lkqu9Zki4fUoYzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bOHD6Tlu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=j+qcT
	Ukc/BnBCDtZ2o87bQo2kXQ62aGX4577Kc8A3m8=; b=bOHD6TluSv5XLxdFMmY9e
	ROE+72f3EtMYJVAdo+Pl9CDv7eFLSKx7zDw25D7M2lggc1FMWgzJZ9FyL9uW8lZY
	Gbopi4e83WE6jir+5L1nB6+IK3ekZQvYCNOVBK4YrIjwc2XTn1JrDmSztJyLbhYg
	eOO1BhwnGA5+litDaF2Jo0=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3fwEQP11ntNLtAQ--.5686S7;
	Sat, 14 Dec 2024 16:17:29 +0800 (CST)
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
Date: Sat, 14 Dec 2024 16:17:04 +0800
Message-ID: <20241214081719.3330518-6-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214081719.3330518-1-andyshrk@163.com>
References: <20241214081719.3330518-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwEQP11ntNLtAQ--.5686S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xKF1UZr1DWFW8Aw18Zrb_yoWktrX_Ca
	4xXw13Wrs7KFn8X3W29ayfWrZFyan29F48tF48ta4ktF1Dua97t3sayFW7Gas8CFWfGFnr
	ua4UXF10kF9xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0zBT5UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hS1XmddMGznwAAAss

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


