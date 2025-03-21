Return-Path: <linux-kernel+bounces-570929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F356A6B659
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC204A0A02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD6B21B9F5;
	Fri, 21 Mar 2025 08:50:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E21F03EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547037; cv=none; b=mmvLiOV4Ikfi84ojDJ1Yo+npqvxxS9R8AGmgfdhOdoMJEZ1Qy42vAc/1UhDeM8etLn47/edLyVGq4hIUP1pzZ6ktNHioq7LOgWLv+7kQKFY6Suv8Fo1TtNHU3JbzuVLZvJt3T9J/NOhoCeZifJEkxGsDjauX2d5Qx8nADThePh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547037; c=relaxed/simple;
	bh=YJf7CTJU9cjm7wgH3iWlza8QlTGiJ6PyQ1angbO+zjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9t2A9vfcfL/Ndmkwi1WYEb0+Gmx+s3fU8PO+UBsmOHC3YJoTCH4JpmmpdiCpKTrqcBZh+hGAQoVg1A6mNeQd/P9QpRBHqw++tF0VvLh7pl5HME+gFc4QYmWvoA3sxNB0WBy5o1D7waT3bWH3ki4yxVxRbg0qN2M+ygmhkqbAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY51-0001Lm-HD; Fri, 21 Mar 2025 09:50:15 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY4z-000taK-2D;
	Fri, 21 Mar 2025 09:50:14 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY50-003L3W-06;
	Fri, 21 Mar 2025 09:50:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 21 Mar 2025 09:50:01 +0100
Subject: [PATCH v4 01/10] wifi: mwifiex: deduplicate code in
 mwifiex_cmd_tx_rate_cfg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-mwifiex-cleanup-1-v4-1-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742547013; l=3171;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=YJf7CTJU9cjm7wgH3iWlza8QlTGiJ6PyQ1angbO+zjg=;
 b=rWKONxzgra1MC4oZiWw/vz9HFP1OvOi5j4IA6Gq97+12HhtVYS0Zg1IW4m0EufP8hv1aopQEI
 WisI804tQm9CUgbSmpRGSFpbC8SIvEwoTeCR8i3EX0emmQsWO77Vjgm
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The code block inside the if/else is the same with just using
pbitmap_rates if non NULL or priv->bitmap_rates otherwise. Deduplicate
the code by picking the correct pointer first and then using it
unconditionally.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 43 +++++++++-----------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index e2800a831c8ed..30dd4e58e2b1d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -157,7 +157,7 @@ mwifiex_cmd_802_11_get_log(struct host_cmd_ds_command *cmd)
  */
 static int mwifiex_cmd_tx_rate_cfg(struct mwifiex_private *priv,
 				   struct host_cmd_ds_command *cmd,
-				   u16 cmd_action, u16 *pbitmap_rates)
+				   u16 cmd_action, const u16 *pbitmap_rates)
 {
 	struct host_cmd_ds_tx_rate_cfg *rate_cfg = &cmd->params.tx_rate_cfg;
 	struct mwifiex_rate_scope *rate_scope;
@@ -174,34 +174,19 @@ static int mwifiex_cmd_tx_rate_cfg(struct mwifiex_private *priv,
 	rate_scope->type = cpu_to_le16(TLV_TYPE_RATE_SCOPE);
 	rate_scope->length = cpu_to_le16
 		(sizeof(*rate_scope) - sizeof(struct mwifiex_ie_types_header));
-	if (pbitmap_rates != NULL) {
-		rate_scope->hr_dsss_rate_bitmap = cpu_to_le16(pbitmap_rates[0]);
-		rate_scope->ofdm_rate_bitmap = cpu_to_le16(pbitmap_rates[1]);
-		for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
-			rate_scope->ht_mcs_rate_bitmap[i] =
-				cpu_to_le16(pbitmap_rates[2 + i]);
-		if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15) {
-			for (i = 0;
-			     i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
-			     i++)
-				rate_scope->vht_mcs_rate_bitmap[i] =
-					cpu_to_le16(pbitmap_rates[10 + i]);
-		}
-	} else {
-		rate_scope->hr_dsss_rate_bitmap =
-			cpu_to_le16(priv->bitmap_rates[0]);
-		rate_scope->ofdm_rate_bitmap =
-			cpu_to_le16(priv->bitmap_rates[1]);
-		for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
-			rate_scope->ht_mcs_rate_bitmap[i] =
-				cpu_to_le16(priv->bitmap_rates[2 + i]);
-		if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15) {
-			for (i = 0;
-			     i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
-			     i++)
-				rate_scope->vht_mcs_rate_bitmap[i] =
-					cpu_to_le16(priv->bitmap_rates[10 + i]);
-		}
+	if (!pbitmap_rates)
+		pbitmap_rates = priv->bitmap_rates;
+
+	rate_scope->hr_dsss_rate_bitmap = cpu_to_le16(pbitmap_rates[0]);
+	rate_scope->ofdm_rate_bitmap = cpu_to_le16(pbitmap_rates[1]);
+
+	for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
+		rate_scope->ht_mcs_rate_bitmap[i] = cpu_to_le16(pbitmap_rates[2 + i]);
+
+	if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15) {
+		for (i = 0; i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap); i++)
+			rate_scope->vht_mcs_rate_bitmap[i] =
+				cpu_to_le16(pbitmap_rates[10 + i]);
 	}
 
 	rate_drop = (struct mwifiex_rate_drop_pattern *) ((u8 *) rate_scope +

-- 
2.39.5


