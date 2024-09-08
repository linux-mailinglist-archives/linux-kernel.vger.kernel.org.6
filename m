Return-Path: <linux-kernel+bounces-320279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B133970849
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865C31C214B2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3017624F;
	Sun,  8 Sep 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="m5w1Uc0E"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24739173347
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807370; cv=none; b=DsotRQ1ri0k2rvmaHCc6xMrSsg3iCcnBly05z+YXpJajgffkGusuZk3FznSAL1uw3qluOVkFwNrOLafqVUHoLdBjKgp3TA1yW9lwzmxn613j5OwLZSyh6oikPC2/+ueCQw05b53NfMKC1qIhZnuTGZ6DNUJV/CDe0gD37vzcGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807370; c=relaxed/simple;
	bh=a1deiAozCdmJ4GF9o0XtiEt1ZU8QWLsHqhwArBEVCNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6zLn7x92pQaazB/4s8CNFVHeRuDYQJZFwqDdtrXRrJphAhRCNiPWtXHuZjhsLOaR3J5ofJzeI/UdAEqqAG00+XW6GptOrBwo2mrjj+rBMCI3VH7+xunNHXe64x9tcz3RbF7L7cpnMFaGGVRHoSHk+Qt3fM9MUEeLnv7ZzxVktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=m5w1Uc0E; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725807352; bh=Fen8SXObvKui+EcVpqkgeahn1KAOdYtBUTto1YpsJkY=;
 b=m5w1Uc0EeJDeC8pY9mEZGT+8uLPtvOHjxBvWrFo7oXfen30wNWXyRXtKQ2KTcWdmeFsmPsjbY
 iyKSEUAZkXkU+YOFZkTZzjyJ85ybHQi+pls3GRgyRaEm7S4+TzaPvxIqNG8SzNo9OAd3s4Hd/ql
 v2GXx+LxPcBrdcfOI6Ln1klzhkOGb7LJi1SlQFUv0Ucsgh0YpyhYoZvrcdi06I+FlkAX1qXceKe
 Yz5omvgvyPkBsiFTWP57yurqi3nfRr6j5ERcqpKI2/5rQWMNeEXnqvW1GZDjgAjRF5fnf3RmLNH
 C59wRK93UqFi8h5SnYBvvOuXAPw6ssz3VW3XfyA7pd0g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 7/7] drm/rockchip: Load crtc devices in preferred order
Date: Sun,  8 Sep 2024 14:55:04 +0000
Message-ID: <20240908145511.3331451-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908145511.3331451-1-jonas@kwiboo.se>
References: <20240908145511.3331451-1-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 66ddbaf53c9877b459588f11

On RK3399 the VOPL is loaded before VOPB and get registered as crtc-0.
However, on RK3288 and PX30 VOPB is gets registered as crtc-0 instead of
VOPL.

With VOPL registered as crtc-0 the kernel kms client is not able to
enable 4K display modes for console use on RK3399.

Load VOPB before VOPL to help kernel kms client make use of 4K display
modes for console use on RK3399.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 44d769d9234d..b84451d59187 100644
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
2.46.0


