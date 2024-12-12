Return-Path: <linux-kernel+bounces-442812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C29EE24B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D0281D56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDAE20E31F;
	Thu, 12 Dec 2024 09:11:14 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1320C01A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994674; cv=none; b=WTtHsDuHmUHXGCk6aYkJC4j5UU2I5F/fLun3pl1WdWQLXp15NbFfUFWGn40TYTd+2/9PY25GMQjXKLfqM16dT0un6MAKjAMmZmuHgxvYUpnqkJaM7iGj6jU+RGHto15FhedPgApj4N76QFhdcx6LEq2R0rRBEkFZv0kbsvz79Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994674; c=relaxed/simple;
	bh=WDwwYJ37rfDfcKE8p30b6KSBblv0uqzeb7SmpZ5Lnl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZd7ClU0OnAHMqEfNW8uR2A2RE2CeQBHTncMJLo/NqBeMv+FJuvRZXL8CwwHZM/VRkI3oE7SUlHq4rV+9+IlmXvE/OKTRCQxB4ROAHnYGXdePqRKTHzTgsa8AuTwNwer6p7HBtTToUU6O1m+NsWmWIL5VhhxekyR+jzypjOKcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a086:deff:83e6:222b])
	by albert.telenet-ops.be with cmsmtp
	id nlB22D0071T2bNC06lB20e; Thu, 12 Dec 2024 10:11:05 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLfDn-000pz0-DP;
	Thu, 12 Dec 2024 10:11:02 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLfDp-00DEhg-UU;
	Thu, 12 Dec 2024 10:11:01 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/rockchip: avoid 64-bit division
Date: Thu, 12 Dec 2024 10:10:59 +0100
Message-Id: <20241212091100.3154773-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Dividing a 64-bit integer prevents building this for 32-bit targets:

ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

As this function is not performance criticial, just Use the div_u64() helper.

Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c796ee4c303a9a9..c8b362cc2b95fd49 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 		 * comment in rk_hdptx_phy_power_on() from
 		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
 		 */
-		phy_set_bus_width(hdmi->phy, rate / 100);
+		phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
 	}
 }
 
-- 
2.34.1


