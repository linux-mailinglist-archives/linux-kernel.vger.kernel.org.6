Return-Path: <linux-kernel+bounces-437497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C49E9411
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4437128349A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28F228CA4;
	Mon,  9 Dec 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XfSU5RuH"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854E2248B5;
	Mon,  9 Dec 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747434; cv=none; b=IVR7cNdpbe8AWqKVivQJQMapHn14CcrWx0QVN3vMRPV/MXOykh55BTIsOt1F9YTTmqn8F3ZuJSo3qMSAyvyTP1MhPHv1FgzebpnQHBUXMTaz5vH94GeEkkOm2Yh4cfcnGEnuNTzN/ai/ZI7bNA24cwYqqmuzkV+0OWdOJVGvWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747434; c=relaxed/simple;
	bh=ywPR1NUEeV0z7eEsID+uFh6IyaQVCORElJpN6rIjXro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBwQDQCaFbuXeygRkXjV6jVmjApuMa7WsIzY3H1fFTyW6QW3k8nAls0rxt14tvDj2BwmM/My5J4CtdQXHAaZq5fflcV8srHVfIQtZDq0lGf+LXE+Lx5uymjd8Z8DcmPV7ikgEh4Rqp1BAtAPsXShNEDt25FMN9fVXGUiv/I9uww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XfSU5RuH; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=MGdvk
	GNZld4yvK8e5s5pV6ih+BuB38oQNY+g+kTfmVU=; b=XfSU5RuHoD9uEW/h7VWFl
	OQtYB5jtRexvxYSynS6kNwOwVlRqKxnrsZKPGGx5w7RfLC0d9fltq62JSd1ZjIUM
	HYbN3qK0n64cwEjgcEsLr4IAS72ymvTIySP/UFBv+8+Zep6Z2a1tC/TZF41hHX4V
	9CCX2+pUsyD8nQqUyB3iwU=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Woe44lZnubZICA--.5849S6;
	Mon, 09 Dec 2024 20:29:53 +0800 (CST)
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
Subject: [PATCH] drm/rockchip: vop2: Setup delay cycle for Esmart2/3
Date: Mon,  9 Dec 2024 20:29:14 +0800
Message-ID: <20241209122943.2781431-5-andyshrk@163.com>
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
X-CM-TRANSID:PCgvCgD3Woe44lZnubZICA--.5849S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy8AFW3ZFW3uw48GF4xXrb_yoWkJrX_Ka
	y7Wr98GFs7uFn8X3WUCrWfGrWjk3ZF9F4IvFWUtF98ZFn3A34Fya4Iyr1UXF15CF4fGF1I
	ga48X3W3CF13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0a0PDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwKwXmdW3sepewAAsl

From: Andy Yan <andy.yan@rock-chips.com>

Each layer needs to set the correct delay cycle to display properly
without unexpected offset on screen.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index c3a572b1c8704..7dc8be7d61184 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2526,9 +2526,11 @@ static void vop2_setup_dly_for_windows(struct vop2 *vop2)
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


