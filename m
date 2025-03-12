Return-Path: <linux-kernel+bounces-557356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668AA5D7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF483AC72D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8E22E40A;
	Wed, 12 Mar 2025 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HPbzTlQg"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0093595E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766521; cv=none; b=gMPafYnK6bouDk1gaoG3uV+xYQ184tOVH6zrf8Ieg/ume+6IT9xPD7VJKbI6qxK54IFPltlfFMDHa89eMtK2hshVd7JRRBdj+qh5YepQyNlK0XICsargI2sSxv45hxmkZct/wvpoCWkZhudYZ8bAZQECjCOdG/vT6kA8TpbgqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766521; c=relaxed/simple;
	bh=W9ervlCwe7OgcuPAIH32zT5xurAdtHI7r9eObaBpcQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQfzdG8XmY39W2U7XfVXy3kUty2tZ+Pi6EgKZQ4wejHqL10JNWa9znkAgB9l8Lh+G3bOLOgr7Qi5W9rOXuhDWFcQ97o7jejbFjw0tE9Q/d9KvN+g2y4TCXvhkKkdBz8N0AodMiaxo8g9ezdxv2WjpOvW546oN/nCYcRSLKMCA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HPbzTlQg; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=4QvIQ
	XwRafvQ580MV0Rsrv/OXQwP41zDVRl4xERsjyo=; b=HPbzTlQgCtphrtXf8ZtoJ
	xVfmywixzn63XAIArXBq8H31CcgyJHueheoDC/3zC4mleJXlgT+6eXoVxr3ZiIGd
	BQsjsPIc5HGMOt5lpgB9jL+vGxuDT7Dc3ueHRqfwZ7wzo7u8HWKxLkpHvjLdW6pj
	PmFpSkKVcKWPzITq8y7NUI=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3RA0rP9FnyOpJSA--.4036S2;
	Wed, 12 Mar 2025 16:00:47 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: vkoul@kernel.org
Cc: heiko@sntech.de,
	kishon@kernel.org,
	sebastian.reichel@collabora.com,
	yubing.zhang@rock-chips.com,
	dmitry.baryshkov@linaro.org,
	lumag@kernel.org,
	frank.wang@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2] phy: rockchip: usbdp: Only verify link rates/lanes/voltage when the corresponding set flags are set
Date: Wed, 12 Mar 2025 16:00:07 +0800
Message-ID: <20250312080041.524546-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3RA0rP9FnyOpJSA--.4036S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1DJFyUtr4fXFWrCr1ftFb_yoWrAr48pa
	y5KFs8Gr15KFnxWay5tr1kCFn8Gan2qa1xJrWakayrX3W5A3yrZF97ury3Ar4rGr97AFWS
	yFWftFy5CF4DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwTmfUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBEOXmfRN93ULAAAsN

From: Andy Yan <andy.yan@rock-chips.com>

According documentation of phy_configure_opts_dp, at the configure
stage, link rates should only be verify/configure when set_rate
flag is set, the same applies to lanes and voltage.

So do it as the documentation says.
Because voltage setting depends on the lanes, link rates set
previously, so record the link rates and lanes at it's verify stage.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- Make each check of link_rates/lanes/voltages helper functions
- Refactor commit message

 drivers/phy/rockchip/phy-rockchip-usbdp.c | 87 ++++++++++++++---------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index c04cf64f8a35..fff04e0fbd80 100644
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
 
@@ -1102,15 +1104,19 @@ static int rk_udphy_dp_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static int rk_udphy_dp_phy_verify_link_rate(unsigned int link_rate)
+/*
+ * Verify link rate
+ */
+static int rk_udphy_dp_phy_verify_link_rate(struct rk_udphy *udphy,
+					    struct phy_configure_opts_dp *dp)
 {
-	switch (link_rate) {
+	switch (dp->link_rate) {
 	case 1620:
 	case 2700:
 	case 5400:
 	case 8100:
+		udphy->link_rate = dp->link_rate;
 		break;
-
 	default:
 		return -EINVAL;
 	}
@@ -1118,45 +1124,44 @@ static int rk_udphy_dp_phy_verify_link_rate(unsigned int link_rate)
 	return 0;
 }
 
-static int rk_udphy_dp_phy_verify_config(struct rk_udphy *udphy,
-					 struct phy_configure_opts_dp *dp)
+static int rk_udphy_dp_phy_verify_lanes(struct rk_udphy *udphy,
+					struct phy_configure_opts_dp *dp)
 {
-	int i, ret;
-
-	/* If changing link rate was required, verify it's supported. */
-	ret = rk_udphy_dp_phy_verify_link_rate(dp->link_rate);
-	if (ret)
-		return ret;
-
-	/* Verify lane count. */
 	switch (dp->lanes) {
 	case 1:
 	case 2:
 	case 4:
 		/* valid lane count. */
+		udphy->lanes = dp->lanes;
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	/*
-	 * If changing voltages is required, check swing and pre-emphasis
-	 * levels, per-lane.
-	 */
-	if (dp->set_voltages) {
-		/* Lane count verified previously. */
-		for (i = 0; i < dp->lanes; i++) {
-			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
-				return -EINVAL;
+	return 0;
+}
 
-			/*
-			 * Sum of voltage swing and pre-emphasis levels cannot
-			 * exceed 3.
-			 */
-			if (dp->voltage[i] + dp->pre[i] > 3)
-				return -EINVAL;
-		}
+/*
+ * If changing voltages is required, check swing and pre-emphasis
+ * levels, per-lane.
+ */
+static int rk_udphy_dp_phy_verify_voltages(struct rk_udphy *udphy,
+					   struct phy_configure_opts_dp *dp)
+{
+	int i;
+
+	/* Lane count verified previously. */
+	for (i = 0; i < udphy->lanes; i++) {
+		if (dp->voltage[i] > 3 || dp->pre[i] > 3)
+			return -EINVAL;
+
+		/*
+		 * Sum of voltage swing and pre-emphasis levels cannot
+		 * exceed 3.
+		 */
+		if (dp->voltage[i] + dp->pre[i] > 3)
+			return -EINVAL;
 	}
 
 	return 0;
@@ -1196,9 +1201,23 @@ static int rk_udphy_dp_phy_configure(struct phy *phy,
 	u32 i, val, lane;
 	int ret;
 
-	ret = rk_udphy_dp_phy_verify_config(udphy, dp);
-	if (ret)
-		return ret;
+	if (dp->set_rate) {
+		ret = rk_udphy_dp_phy_verify_link_rate(udphy, dp);
+		if (ret)
+			return ret;
+	}
+
+	if (dp->set_lanes) {
+		ret = rk_udphy_dp_phy_verify_lanes(udphy, dp);
+		if (ret)
+			return ret;
+	}
+
+	if (dp->set_voltages) {
+		ret = rk_udphy_dp_phy_verify_voltages(udphy, dp);
+		if (ret)
+			return ret;
+	}
 
 	if (dp->set_rate) {
 		regmap_update_bits(udphy->pma_regmap, CMN_DP_RSTN_OFFSET,
@@ -1243,9 +1262,9 @@ static int rk_udphy_dp_phy_configure(struct phy *phy,
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


