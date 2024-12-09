Return-Path: <linux-kernel+bounces-437498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CC9E9414
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469B4283D85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300192236EF;
	Mon,  9 Dec 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZOuhLhj5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E568221D9F;
	Mon,  9 Dec 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747435; cv=none; b=ulRv7f4RRmal63Y0TnW/pyRHgmhtQZTa3m5flZ1i02tbTgjM3t3WvFQFcGxgz3m+XPXQORE1opXUU1TZiFhXkx7/yRe1aZwSEEaMr4gpvTFytNsngUre2O5SYOuB8W61kl7DBUJoAbkmk+WoZGQb6M0mM9/uGoNhV3VD7ki8nhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747435; c=relaxed/simple;
	bh=X8nBBUiyo+lWSMjv7XRP+BVs3EOS8Db37V/115Hl9DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJJkDFAjjwmEGc/6pVOHlEW9IKi2vr8HHqzTP4d8sCcXU6LwV7Hz81KYqMxSE/+J+VQCPviZZ78EmMNa1xT4YwqzwAh4TWGyIgIsuaB3iKLlo4rqLv75HOHD8qU080+BqYiDXJvcSdAIur7MBY56SdkPaS9/U79X7x1Jw8WJN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZOuhLhj5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=N2nQW
	BQmIKoC4QJEfJ78OOQrAzQPhXGv/+rsDTlwFiI=; b=ZOuhLhj5ZKetAookr9rZa
	1+4eMaLfDAo+pBgOFnAcMoGz9FVPTBskmTqiA250e3M9uLLCUouj0umzJ/sxhOyT
	pmkvxfmn7Ldi9UXvkjzyqUx7XTqB5QajIVxMC02KuvNxQi32KuDpAx4Upq8t2ByB
	yqWcxEuHPUqAk/7V+jfe4k=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Woe44lZnubZICA--.5849S11;
	Mon, 09 Dec 2024 20:29:57 +0800 (CST)
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
Subject: [PATCH v5 06/18] drm/rockchip: vop2: Setup delay cycle for Esmart2/3
Date: Mon,  9 Dec 2024 20:29:19 +0800
Message-ID: <20241209122943.2781431-10-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209122943.2781431-1-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3Woe44lZnubZICA--.5849S11
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy8AFW3ZFW3uw48GF4xXrb_yoWkGwc_Ka
	y7WF98GF1kuFn0q3WUCayfGrW2k3Z29F4I9FyDtF98ZF93A3sYya4Iyr1UXF15CF4fCF1v
	93W0q3W3CF13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ahF3UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g6wXmdW3S-w5QABsl

From: Andy Yan <andy.yan@rock-chips.com>

Each layer needs to set the correct delay cycle to display properly
without unexpected offset on screen.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 8b9ca046eeeb..d7ddeec27c7d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2703,9 +2703,11 @@ static void vop2_setup_dly_for_windows(struct vop2 *vop2)
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


