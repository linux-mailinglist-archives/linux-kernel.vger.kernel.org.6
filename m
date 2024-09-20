Return-Path: <linux-kernel+bounces-334092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF097D286
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAE31F2161F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52737E107;
	Fri, 20 Sep 2024 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TGGmPIpd"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1B7D401;
	Fri, 20 Sep 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820501; cv=none; b=eVvUc5CHk0kTyV+dc5AByU9pUZFzg6bH3p2G7ibzwo1osvbn5hCCsg0dyNJefqq8wCCc4MlTEYqlUzWe4LqMBW1Wqj0GF+7sreD/h2qx3kTsm7J92ulJyKotd6H/f/K424H3tg41/Q6L9rts7Nn7j1jDhx40gUc8EO6h557+324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820501; c=relaxed/simple;
	bh=IadptqnbaT9c2K1pNM/SXaZhFjND1guNP3ocQdMNleU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMdT3962cNj9wsTPlPDh1JiCPpw15SWPdUWpumuUDgYXaX7kfjjXPozWSMqjLbsK/9hZsjipwfirzFbtQA50ujbifk+jI5d93RrGDJjBDuusXIBGr8n6kte6Xq/xOB66GIPLaFd66mhOQeM8bjepextQ1RdT/P/a6lU8il3uDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TGGmPIpd; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0GYSG
	+chUw6Ysv1qyoAIdKhyk6i2g6/WZX6U7MclNH0=; b=TGGmPIpdvvXtsugOEABzZ
	/I8bOStNtgaFjjNuuYCoL2cRqbQXK2SMdQieRctHtlUT+WOIRXHwcNY+m/KYCoFD
	1OvtuQxSm1GCKCg6ZIzEUpzNXk5RSXv2np3aQbdG3bynpnZ8AwLfW6nEsd5XktS7
	a50W+lLehX2fASanH1cXeU=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wDX3_dtMO1mi4uaBQ--.13042S2;
	Fri, 20 Sep 2024 16:21:05 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 04/15] drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
Date: Fri, 20 Sep 2024 16:20:58 +0800
Message-ID: <20240920082100.6683-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3_dtMO1mi4uaBQ--.13042S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rXr13WF4kZr45GFWfKrg_yoWkKFg_G3
	4fWrn3Grn7GFn8Jw1jka1fGFZ2yan2kF18Ga1DtF90yFykA3Wxta4rXryxX34UCF4rAr97
	G3W8Xw1rCrnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8AWrJUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxJgXmbtL08ijAACsY

From: Andy Yan <andy.yan@rock-chips.com>

The alpha setup should start from the second layer, the current calculation
starts incorrectly from the first layer, a negative offset will be obtained
in the following formula:

offset = (mixer_id + zpos - 1) * 0x10

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Derek Foreman <derek.foreman@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index bff190151ae8..c50d93df8404 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2282,6 +2282,12 @@ static void vop2_setup_alpha(struct vop2_video_port *vp)
 		struct vop2_win *win = to_vop2_win(plane);
 		int zpos = plane->state->normalized_zpos;
 
+		/*
+		 * Need to configure alpha from second layer.
+		 */
+		if (zpos == 0)
+			continue;
+
 		if (plane->state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
 			premulti_en = 1;
 		else
-- 
2.34.1


