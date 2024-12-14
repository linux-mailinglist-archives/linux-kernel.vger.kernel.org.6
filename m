Return-Path: <linux-kernel+bounces-445903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF589F1D56
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B643C161A19
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E018FC86;
	Sat, 14 Dec 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d+iNIYVF"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E91898FC;
	Sat, 14 Dec 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164173; cv=none; b=Q5bLnG+r1kbbWA/Lm87ZAXaRvEv7Ftd4t7LWdQoBwQ0TX88Dy4/+qrZioDnVt6oz5hKCQGidNk+d1hA2LOWJZL5uDlNkhpVQeBI4JF+rt6byQpRCFLVaGEE08xEUArn8LqTopXSYDQpdV3rMMIF8pIJiH6Ijf9RkfAxELNmuFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164173; c=relaxed/simple;
	bh=TDZVst93HW3Axin+EiY6SBIjZpf/mWnON2EuEjPJ+bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7rM9nInciIgaWZqWj5slPD4q9Uvhhhx7FHk4G5vSEdDgUsn+bZCSvw0tSkrZqNtSxaxagGg1Ae8HP3Eynj0SYzrzY6vi5c3dqNpvd0fAW8Fg22jiCCnbmeHqM8R1Cm06hHcE24JzFJFY056XYPxei4Vxe+UOLVUkAibLvj05tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d+iNIYVF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=GjbI9
	yjF/1xFO2NMYGYkxuegaOWhKvddjGaj/Tq3Puk=; b=d+iNIYVFiFVsv+lMoM6zh
	zWoZlIEABvWFVJOBPN0BA3isNPDga/qJBP6jihsqGV0chja2dxLYgRi+i8qsNo/o
	9gEkPjYTk1pkFGuwBs7tzGHwZ5beVEF9koI5ZDN7DPdNSq3WLbjB5a9FWEW+FHpd
	oQaULREDo+l3supBZHT8Fo=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vwGjPl1n3T_wAQ--.16730S6;
	Sat, 14 Dec 2024 16:15:38 +0800 (CST)
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
Subject: [PATCH v6 04/16] drm/rockchip: vop2: Setup delay cycle for Esmart2/3
Date: Sat, 14 Dec 2024 16:15:12 +0800
Message-ID: <20241214081529.3330243-5-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3vwGjPl1n3T_wAQ--.16730S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy8AFW3ZF4UXFy7uF17KFg_yoWkurb_Ka
	y7WFn8GF4kuFn8X3WUCFWfGrW2g3ZF9F4IyFyDtF98ZF93A3sYya4Syr1UXF15CF4fJr1v
	93W8WFnxCr13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wZ23UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxW1XmddNBynnQAAsl

From: Andy Yan <andy.yan@rock-chips.com>

Each layer needs to set the correct delay cycle to display properly
without unexpected offset on screen.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Derek Foreman <derek.foreman@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 0723a7606cb1..f143df2b13a1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2704,9 +2704,11 @@ static void vop2_setup_dly_for_windows(struct vop2 *vop2)
 			sdly |= FIELD_PREP(RK3568_SMART_DLY_NUM__ESMART1, dly);
 			break;
 		case ROCKCHIP_VOP2_SMART0:
+		case ROCKCHIP_VOP2_ESMART2:
 			sdly |= FIELD_PREP(RK3568_SMART_DLY_NUM__SMART0, dly);
 			break;
 		case ROCKCHIP_VOP2_SMART1:
+		case ROCKCHIP_VOP2_ESMART3:
 			sdly |= FIELD_PREP(RK3568_SMART_DLY_NUM__SMART1, dly);
 			break;
 		}
-- 
2.34.1


