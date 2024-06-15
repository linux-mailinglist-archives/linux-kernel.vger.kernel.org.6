Return-Path: <linux-kernel+bounces-215945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F6909921
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB1B2186D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4161FF5;
	Sat, 15 Jun 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wdYarLR/"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC661FEB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471118; cv=none; b=uWEthlkR2v+83/KKFrz8h1NaSkmJlw77Rt0v402TuMTRA6vkIkRKxasJ5BN1PTnnqRZbdkC9mPmmt3H0OxHgWhG4FOLNgMaNZiRTg+t0iBm8NfgJH0FvF8eyyh+PVxnjkLPFJcB949mjAHkuqIzuv/gGxRe+1QUUn01UE+QlpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471118; c=relaxed/simple;
	bh=nUWmK9jo9TaVCd8XeMC8Yeb9xKqgXJMpMMgClmKfj4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZMJvX2gPS0p2Zu6dbKXVTm/MnuvSyXpsInjLFL8CwqZJXo3VEK8TvcOT5nWOU2I66tTe049DtqUXh8yobw6bRuHz8zHMzBbjEfWHK4ltxz7YwtA47fWwjoVHSnXacYgPBkjJyjQy2YIiCrfT12z0KT1YGhuoHiUbM3xHPp0Fbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wdYarLR/; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471083; bh=HhA0TE6TtiMIUmeRX5oAVj2VQq5qfAon5bzRoNsK6Uc=;
 b=wdYarLR/xIMt+/TaQZFCWEdXALELm6MV2s2u+EWpEMMYvDj2VK2kd1QKKGTgOfRiQT92XLsDW
 oylGQlRaANeRA8uBiltNN0CRgVFK+wYlv+ulZTFnWmzV5r71bUa8aAshX+ojkicqonSDLe1wQgL
 +i/JsLSFnYKPnJ02B5FBApjKRsbQNQqrwxSAQOWHQ5yjWWn1zlJauJqUZY9pJzlDYBQ/9rHljAO
 Km/cIijyfgu/RwrZEJCIYoUBWCQ7iv3uZF+daT2CMwdfdE2OqYWCTEA6BXtpa4Wc3sWc+Pa225q
 AtwzvKflKMg1enlR/haeY1/HWXlmQMQZjV6hY2/qhnBg==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Mark Yao <markyao0591@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 03/13] drm/rockchip: vop: Allow 4096px width scaling
Date: Sat, 15 Jun 2024 17:03:54 +0000
Message-ID: <20240615170417.3134517-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 666dc9a524e0254b39804005

From: Alex Bee <knaerzche@gmail.com>

There is no reason to limit VOP scaling to 3840px width, the limit of
RK3288, when there are newer VOP versions that support 4096px width.

Change to enforce a maximum of 4096px width plane scaling, the maximum
supported output width of the VOP versions supported by this driver.

Fixes: 4c156c21c794 ("drm/rockchip: vop: support plane scale")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a13473b2d54c..4a9c6ea7f15d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -396,8 +396,8 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	if (info->is_yuv)
 		is_yuv = true;
 
-	if (dst_w > 3840) {
-		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
+	if (dst_w > 4096) {
+		DRM_DEV_ERROR(vop->dev, "Maximum dst width (4096) exceeded\n");
 		return;
 	}
 
-- 
2.45.2


