Return-Path: <linux-kernel+bounces-445908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0E9F1D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727B9188821B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA4188587;
	Sat, 14 Dec 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QcnFypl/"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1217E015;
	Sat, 14 Dec 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164271; cv=none; b=A2+EmLdLT1FDHNOmkrkzZ7bqw0RqNk5ByiHeeNtG7jfHMN7RufYaFOoVuwanzIeKMS3Q6lAN/lN2oXLVUh3T+FffrvXodmZ1opQNhs5uC8sO9zc+Ry7YURzU6/KiHJrmD/p04YNftiWELEWy8cyvXfhzCqWiE+SkzMTENonoMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164271; c=relaxed/simple;
	bh=yztjUXBCdTPkj2Cnqf5RxjLATdfzy7Mio76Oa9RTY6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSP9P8t5TDxDVbwuwW2IoZetBIrAfT0T9ZdtAE0kidxCG9n1H9VdupA/8B3fFD+el0TCJMApoLH+3YoRXfraIGcxeFk/brNEkpeKrr20a4XdlIu7v+XTNq7HCJ21ExcAmryXenrb7zrrdSuNGj0kCL7P60ooK3qkL16+QaOZ69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QcnFypl/; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hnZl0
	kD0NHFixyUuAcDalCU1UJrY0bC/p+e25gYBb4Y=; b=QcnFypl/blmPl1YtE+4QU
	EjNX3Qr1Xa3O0OGDgyBaGRXghC78I25jTp/6J2FjAhRzoWfji2kCnj2f8wtBZUMF
	3fSsuV2VD+k1GallxneZl8/NKUDfk8TOnXKRjV5xWbOsAdKbgdfaEOJO5S7DaJfk
	X6MqomFz3LGamsH006l8/c=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3fwEQP11ntNLtAQ--.5686S8;
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
Subject: [PATCH v6 06/16] drm/rockchip: vop2: Add check for 32 bpp format for rk3588
Date: Sat, 14 Dec 2024 16:17:05 +0800
Message-ID: <20241214081719.3330518-7-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3fwEQP11ntNLtAQ--.5686S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45Xw1rCw4DKF4DXw4xJFb_yoWkCwb_K3
	47Zw13WrZ7CFn8A3W2qa4fGFZFyan29F4rKayvya4rtF1kZ3WvqayIkry7Was8CFW3KFnr
	Cayjqr1rCF13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0zBT5UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQa1XmddM6y0LQAAs4

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


