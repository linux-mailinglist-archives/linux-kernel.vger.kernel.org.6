Return-Path: <linux-kernel+bounces-215952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D2C909929
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E271F220DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7955A4FD;
	Sat, 15 Jun 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="NjhRFKrE"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5994F201
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471173; cv=none; b=NAr+EDmdmJQuIZOEFRaE0zKFvcaWIdljpoGNSUKWId8F2t35MN/ftNe2ejoGxdoAWx0pdwXIC+Nibzr++gYZgBYO6YcuSSZRy3NMXRXOVFMJjUQUpI/AP/OReRZ0BFz406k9DpdwR2fQ2WEtxTCefporf0RpvUyS0TTlKk3jCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471173; c=relaxed/simple;
	bh=zbuHRSuS2dS2iGQRzL5qQ83saXthoLBY5XNb3GofkuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpAhasvYfCnLnB2cMS5pfBeo/kVfKrliFoZzhB5my5Ng0+dk8oQCyVZJaIXoXJzLYcG9BoDVBgL4r4+c4AtDhU04I64eUkhvBelcG/tQRsSkixkAHR/2m9hcoo56pAVPiFQ568Ap+vk+3yeNyNva6gIsTmpNiGQbGlEZVs2NH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=NjhRFKrE; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471132; bh=FiHAdD/4nULeLzfayWHOZuJzCk9s4sL6Pdbfulf5fI0=;
 b=NjhRFKrEMl9zC2rzupvfY6t99XoPXqQ1GD6FVUWVCd+5VSANEHJ8WBJYFeBMbeanIuJtm7jx+
 ayai/hvSnJRVDBgWyOhKArTaZTmaKSxBXqHM+XjkyOT46xFLFVdcH7URFo0VIb4M9YDBh3DNwO9
 AsWS9YDYj3nglZ/7VHrizinPa1XO+QevQAd6W3Pde5ykY5G3b81SwDSz1DhJPwgb8yeXU4a16pt
 PxPltbVjJqc+6a1jRsQXLtIrwIokxoFMqYISn41JU03bfc+9QVTfMk6iqbRuTiz7xseSliAEZgB
 nTIiayMpsvPztzb4ccd/TYRRmoVgt+XyYA+87mXnD8nQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 13/13] drm/rockchip: Load crtc devices in preferred order
Date: Sat, 15 Jun 2024 17:04:04 +0000
Message-ID: <20240615170417.3134517-14-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 666dc9d424e0254b398040bd

On RK3399 the VOPL loaded before VOPB and gets registered as crtc-0.
However, on RK3288 and PX30 VOPB is gets registered as crtc-0 instead of
VOPL.

With VOPL registered as crtc-0 the kernel kms client is not able to
enable 4K display modes for console use on RK3399.

Load VOPB before VOPL to help kernel kms client make use of 4K display
modes for console use on RK3399.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ab55d7132550..6492f3caf017 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -354,11 +354,34 @@ static void rockchip_drm_match_remove(struct device *dev)
 		device_link_del(link);
 }
 
+/* list of preferred vop devices */
+static const char *const rockchip_drm_match_preferred[] = {
+	"rockchip,rk3399-vop-big",
+	NULL,
+};
+
 static struct component_match *rockchip_drm_match_add(struct device *dev)
 {
 	struct component_match *match = NULL;
+	struct device_node *port;
 	int i;
 
+	/* add preferred vop device match before adding driver device matches */
+	for (i = 0; ; i++) {
+		port = of_parse_phandle(dev->of_node, "ports", i);
+		if (!port)
+			break;
+
+		if (of_device_is_available(port->parent) &&
+		    of_device_compatible_match(port->parent,
+					       rockchip_drm_match_preferred))
+			drm_of_component_match_add(dev, &match,
+						   component_compare_of,
+						   port->parent);
+
+		of_node_put(port);
+	}
+
 	for (i = 0; i < num_rockchip_sub_drivers; i++) {
 		struct platform_driver *drv = rockchip_sub_drivers[i];
 		struct device *p = NULL, *d;
-- 
2.45.2


