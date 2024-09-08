Return-Path: <linux-kernel+bounces-320275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389FF970845
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E664B2137C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB61741CB;
	Sun,  8 Sep 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="dDz0Rd+y"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95174171652
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807355; cv=none; b=rgy42X4E2451WHs2YqCkgauIC5El6Xbby6kl0zXAsl/SbVMwpoYDDDc6qpTcFW5N7Rt0TUc2lfqitQjyljK77DChuiowkQlXrMhcyZB+IhxFSYFh7Iw0Q1Oify9yzf7PsBZsAg/ESh2GBNdS5btLIsLHhHwLA0+zOxlIgzCk1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807355; c=relaxed/simple;
	bh=gH17k/hgoxWWnDI+TiP+CAFBgkQO9cbEtxG+mFs9ywY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCPlSUlTIh8aoH+QXPwsb2w6BFUNvORfjkbC8AoHQNVf2Bv/j7HflN89UhVpqRtbcfcAyRA6X/wv8QuIgoY/6tM6UhEpU0ubxaBsnKl8dLOTeoHN7ypZoNdIVikF17f+nhOIeC/jwJgK5HkVBLGCRzsT/IGRyb5lV9L5vxYYBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=dDz0Rd+y; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725807332; bh=s4d/+ThRHSQtfU43RCtR36kOGQZWrroV7EpFOhfrkPA=;
 b=dDz0Rd+ysMJo7E7Mp/8ntt1o7OUMS97maozuVK800alL0C7nalo7oYo02BiBtmFvibztL0h6V
 0esFL6jjvePN3SxQgMjohPvX5NV3d38QJK9IDb1i5UFay1F7LoC6+x+V1BETArYs4QwFf6nyIWD
 jI7G/S2TDMp46puwgyQdgt5YoEOQDJrvVGLifkIOXsbFcZGwwCGSVfzd6FaB18cA/uvmNM/uf44
 A2xHypv3Vitpof6yldLNUz4pzBxitCaky3kOcq1x1LTHKyKf0UTnaAZcC483yTgP26gUqcAFV0Q
 nGJsENbQ/8W/7x4XwcR24/2fHGDKD8sfEHsUqXIkyv9Q==
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
	Jonas Karlman <jonas@kwiboo.se>,
	Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v2 2/7] drm/rockchip: dw_hdmi: Adjust cklvl & txlvl for RF/EMI
Date: Sun,  8 Sep 2024 14:54:59 +0000
Message-ID: <20240908145511.3331451-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ddbadf3c9877b459588e98

From: Yakir Yang <ykk@rock-chips.com>

Dut to the high HDMI signal voltage driver, Mickey have meet
a serious RF/EMI problem, so we decided to reduce HDMI signal
voltage to a proper value.

The default params for phy is cklvl = 20 & txlvl = 13 (RF/EMI failed)
  ck: lvl = 13, term=100, vlo = 2.71, vhi=3.14, vswing = 0.43
  tx: lvl = 20, term=100, vlo = 2.81, vhi=3.16, vswing = 0.35

1. We decided to reduce voltage value to lower, but VSwing still
keep high, RF/EMI have been improved but still failed.
   ck: lvl =  6, term=100, vlo = 2.61, vhi=3.11, vswing = 0.50
   tx: lvl =  6, term=100, vlo = 2.61, vhi=3.11, vswing = 0.50

2. We try to keep voltage value and vswing both lower, then RF/EMI
test all passed  ;)
   ck: lvl = 11, term= 66, vlo = 2.68, vhi=3.09, vswing = 0.40
   tx: lvl = 11, term= 66, vlo = 2.68, vhi=3.09, vswing = 0.40
When we back to run HDMI different test and single-end test, we see
different test passed, but signle-end test failed. The oscilloscope
show that simgle-end clock's VL value is 1.78v (which remind LowLimit
should not lower then 2.6v).

3. That's to say there are some different between PHY document and
measure value. And according to experiment 2 results, we need to
higher clock voltage and lower data voltage, then we can keep RF/EMI
satisfied and single-end & differen test passed.
  ck: lvl =  9, term=100, vlo = 2.65, vhi=3.12, vswing = 0.47
  tx: lvl = 16, term=100, vlo = 2.75, vhi=3.15, vswing = 0.39

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 36cc700766fd..fc5e87285a91 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -202,7 +202,7 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	/*pixelclk   symbol   term   vlev*/
 	{ 74250000,  0x8009, 0x0004, 0x0272},
-	{ 148500000, 0x802b, 0x0004, 0x028d},
+	{ 165000000, 0x802b, 0x0004, 0x0209},
 	{ 297000000, 0x8039, 0x0005, 0x028d},
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
-- 
2.46.0


