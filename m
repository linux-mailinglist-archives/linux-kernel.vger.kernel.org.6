Return-Path: <linux-kernel+bounces-548305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7DBA54329
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD9018943B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F11A2C25;
	Thu,  6 Mar 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FalPWDW5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494819DF4D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244436; cv=none; b=r2l8F9+hg+ovSCFHY2Ao6NJE098YJMqw9YRCz9hwOafCyNfzC/qzPRtYmq4Yqm//th3nqIsk7KK8YL52k5bZobx0PLxWFXir/1NxM5i8AX+mLTAYimmwR7vseSuihzjK/Qx62XF6YzU1LpmmPXFqOkYttJlXLNZnsUwD757Gqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244436; c=relaxed/simple;
	bh=wVFY0ejm8U767DjREKaeg/ViSBaZfgmcxmWlOJII5AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFIG32tqopWR2EapSCftm82Qsw7hgjUyU7lp0rd13swtKxRA+rEaJdS0z/Et29THCeuskw3QVGdiwd8UFQTMoWBPNXdaIaZii0XrgssEXZJsxfiOtZ+SaWgG8rT3DwdWTTh3QM/BMASjJ3v+R87koYFK7B5rx6Ta6f7Pr29qDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FalPWDW5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=r1mvt
	tKmdlTjRafAKsHmhCEZ5T95Om0QyJBHPC6if+o=; b=FalPWDW582aligSeJEfAG
	Oz7pbNRCnY6FUKb5mA9MLzgBXqEGm5oRtgNAMLE76osO/UiFQsVFfknfoE7jof4n
	TQU3m/UScnP2Xo91U81YzeHosLi7Wc8CDt9B+1gVarjhYPJKbbo/QUgBom/poZOw
	pV4twSAAkiT5FP7MiqAz5M=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA33j_pR8lnNEKOPw--.129S2;
	Thu, 06 Mar 2025 14:59:57 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: vkoul@kernel.org
Cc: heiko@sntech.de,
	kishon@kernel.org,
	sebastian.reichel@collabora.com,
	yubing.zhang@rock-chips.com,
	dmitry.baryshkov@linaro.org,
	frank.wang@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] phy: rockchip: usbdp: Check these parameters only when the corresponding set flags are set
Date: Thu,  6 Mar 2025 14:59:51 +0800
Message-ID: <20250306065952.485809-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA33j_pR8lnNEKOPw--.129S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1DJFyUtryfWF45ZF1fZwb_yoW5XrW3p3
	y5JF4Dtr1UGw13Wa9xtr1kCFn8J3Z7ta17JrWakaySqw13A3yrZF929ryfAr4fGr97ZF1f
	uFW3Ga45CF4DZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFzuAUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBoIXmfJRa42mQAAsO

From: Andy Yan <andy.yan@rock-chips.com>

According documentation of phy_configure_opts_dp, at the configure
stage, we should only verify/configure the link_rate when set_rate
flag is set, the same applies to lanes and voltage.

So we do it as the documentation says, also record the link rate
and lanes in phy internal for set_voltate stage.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/phy/rockchip/phy-rockchip-usbdp.c | 63 +++++++++++------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index c04cf64f8a35..d1bbdf382aa2 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -187,6 +187,8 @@ struct rk_udphy {
 	u32 dp_aux_din_sel;
 	bool dp_sink_hpd_sel;
 	bool dp_sink_hpd_cfg;
+	unsigned int link_rate;
+	unsigned int lanes;
 	u8 bw;
 	int id;
 
@@ -1102,42 +1104,39 @@ static int rk_udphy_dp_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static int rk_udphy_dp_phy_verify_link_rate(unsigned int link_rate)
-{
-	switch (link_rate) {
-	case 1620:
-	case 2700:
-	case 5400:
-	case 8100:
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int rk_udphy_dp_phy_verify_config(struct rk_udphy *udphy,
 					 struct phy_configure_opts_dp *dp)
 {
-	int i, ret;
+	int i;
 
-	/* If changing link rate was required, verify it's supported. */
-	ret = rk_udphy_dp_phy_verify_link_rate(dp->link_rate);
-	if (ret)
-		return ret;
+	/* Verify link rate. */
+	if (dp->set_rate) {
+		switch (dp->link_rate) {
+		case 1620:
+		case 2700:
+		case 5400:
+		case 8100:
+			udphy->link_rate = dp->link_rate;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
 
 	/* Verify lane count. */
-	switch (dp->lanes) {
-	case 1:
-	case 2:
-	case 4:
-		/* valid lane count. */
-		break;
+	if (dp->set_lanes) {
+		switch (dp->lanes) {
+		case 1:
+		case 2:
+		case 4:
+			/* valid lane count. */
+			udphy->lanes = dp->lanes;
+			break;
 
-	default:
-		return -EINVAL;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	/*
@@ -1146,7 +1145,7 @@ static int rk_udphy_dp_phy_verify_config(struct rk_udphy *udphy,
 	 */
 	if (dp->set_voltages) {
 		/* Lane count verified previously. */
-		for (i = 0; i < dp->lanes; i++) {
+		for (i = 0; i < udphy->lanes; i++) {
 			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
 				return -EINVAL;
 
@@ -1243,9 +1242,9 @@ static int rk_udphy_dp_phy_configure(struct phy *phy,
 	}
 
 	if (dp->set_voltages) {
-		for (i = 0; i < dp->lanes; i++) {
+		for (i = 0; i < udphy->lanes; i++) {
 			lane = udphy->dp_lane_sel[i];
-			switch (dp->link_rate) {
+			switch (udphy->link_rate) {
 			case 1620:
 			case 2700:
 				regmap_update_bits(udphy->pma_regmap,
-- 
2.34.1


