Return-Path: <linux-kernel+bounces-331300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE297AB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CCE28137D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E31607B7;
	Tue, 17 Sep 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Zid9J+nB"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E7158A2E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551127; cv=none; b=CJuBRu4bf3uo3Ixu6vVZoFe7nujJAgY1boH3XX/kkpiSas5zx+TzjbIAyTljSlwbTyXmr/FyqOAsbAPf9lk6kphGsu2iI7Uq7a5SUm7mZxJkbt32EAZzj1VucDLQejaE9+2NEwTBOFuqQ50OUNuNmaILiYZA9jKWCCvKxuC8wOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551127; c=relaxed/simple;
	bh=XMcaFax5C+HYiiHLiFOpXerrieIXgXMuHY19OMOdfUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikNSBjvrKZI0MqfUDfV94V15TWV/cwg5dgjPmag8G+Hd8Y7SqVdTJ2Z+8MkDnQJtPzcv+ITfNB6PwN0900hNpjKKg1/6+YPCMqHd2rLtjlkeGeA6tUXSVJ7I3IQid9NsYv+ESGW/gQzHQALI+TqMmNmMVH25h5+7S/tSXo31Kbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Zid9J+nB; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e039889ca0so2957023b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551125; x=1727155925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg3zx6b6YOG9l6VSYiIDTP4MSlvWxjTjdd2LPfzyLWY=;
        b=Zid9J+nBPsO9JkmMJSlegGeYaCelnL+nX3lRkC0wAiEuArurpOoRVY0hcXbv7N3SC6
         f7JMHfwbh/b7eZqkmV4ptbQ0uSsj+8vNVjyr7xKLZQ+i2kCSv+jeJV38F+HJbLRjvGR0
         mAW0cEV0L1D0tFxFpmdZa4SYLKm0yGh7uUdIZg48cK9BxZhpUUI9rohwKYbrTcNHuPKC
         4W1bTODuGB+07NwA8fOQt8fqsHM9Sk8H3jz3ay6gBVMvdUufQyH7jLnzOyVkUlUGikJB
         OVmhGVWuy9XGn25G/KVtbPAorb1c9bd89hpO7S8N4UqLOcYvNGlYrx32+w/MlRYvx1Qg
         XTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551125; x=1727155925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg3zx6b6YOG9l6VSYiIDTP4MSlvWxjTjdd2LPfzyLWY=;
        b=dvU/8ebhmQL1JkuvqXJopFxUk1jzL3ANK1jLZ/JNycChAtpfyXiO2i1NBJGzJp6HWx
         BS2wxjva6JPRU1q+6tw/csM0Epc50YO8TTP3Lj+OCLmNqwNxi+E3Ak4KvQk+t/l7JIsD
         wOLlU5BZIFLjjWft3kXmJxXN8S887GToLownEetU9ZSpNO52d3OnL5kPWsYsbAL//zSd
         2DHR7XMU2iQ+kFyaH9rJLH8DmW+C1AhvQN8das5WAtlu+Vg1xqlUgUjC0zpiEWxwoms4
         eMAaiwoVM5jvQQlmIenykqM3Mw+DQg2pPUm7xertXjF5FwKu02jFZ1g1R+oK1fWYATfh
         lipg==
X-Forwarded-Encrypted: i=1; AJvYcCU3W+WJ9MF2KRMFJPkdeD6zRKRaurzN4JWK6kVYKOfn5wyexZ1QC7FZsonr465x7YHoGbJ5c03f3KmxNRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUa/me+7IHOBi8bTJjJFZwHM7vqcXtJjcJjVy8HVW5qQRKk9mG
	yZjsTZji8SSjr3O6FqmLKW84aYDiL+G4fmvIpjk6Snxvrx7pcBi8r7vwfKEaI0A=
X-Google-Smtp-Source: AGHT+IHshQPSO9l9chCWXDqW7bFfP3ctcewyS6xrXxc3f4sDjsojmRNSeiqrerOHNWExZQMPHMpZog==
X-Received: by 2002:a05:6808:1791:b0:3e0:467e:f189 with SMTP id 5614622812f47-3e071aab6afmr12609123b6e.24.1726551125121;
        Mon, 16 Sep 2024 22:32:05 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:04 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/18] Staging: rtl8192e: Rename variable bToSelfBA
Date: Mon, 16 Sep 2024 22:31:47 -0700
Message-Id: <20240917053152.575553-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bToSelfBA to to_self_ba
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 16 ++++++++--------
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 873c749250ae..2e3e8c57d6f0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1153,7 +1153,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 				      bool bpacket_match_bssid,
 				      bool bpacket_toself,
 				      bool packet_beacon,
-				      bool bToSelfBA)
+				      bool to_self_ba)
 {
 	struct phy_sts_ofdm_819xpci *pofdm_buf;
 	struct phy_sts_cck_819xpci *pcck_buf;
@@ -1175,7 +1175,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 	pstats->packet_to_self = precord_stats->packet_to_self = bpacket_toself;
 	pstats->is_cck = precord_stats->is_cck = is_cck_rate;
 	pstats->packet_beacon = precord_stats->packet_beacon = packet_beacon;
-	pstats->bToSelfBA = precord_stats->bToSelfBA = bToSelfBA;
+	pstats->to_self_ba = precord_stats->to_self_ba = to_self_ba;
 	if (check_reg824 == 0) {
 		reg824_bit9 = rtl92e_get_bb_reg(priv->rtllib->dev,
 						rFPGA0_XA_HSSIParameter2,
@@ -1363,7 +1363,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	priv->stats.signal_strength = rtl92e_translate_to_dbm(priv, tmp_val);
 	curr_st->rssi = priv->stats.signal_strength;
 	if (!prev_st->packet_match_bssid) {
-		if (!prev_st->bToSelfBA)
+		if (!prev_st->to_self_ba)
 			return;
 	}
 
@@ -1417,7 +1417,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 			prev_st->RxPWDBAll -= 3;
 	}
 	if (prev_st->packet_to_self || prev_st->packet_beacon ||
-	    prev_st->bToSelfBA) {
+	    prev_st->to_self_ba) {
 		if (priv->undecorated_smoothed_pwdb < 0)
 			priv->undecorated_smoothed_pwdb = prev_st->RxPWDBAll;
 		if (prev_st->RxPWDBAll > (u32)priv->undecorated_smoothed_pwdb) {
@@ -1438,7 +1438,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 
 	if (prev_st->signal_quality != 0) {
 		if (prev_st->packet_to_self || prev_st->packet_beacon ||
-		    prev_st->bToSelfBA) {
+		    prev_st->to_self_ba) {
 			if (slide_evm_statistics++ >= PHY_RSSI_SLID_WIN_MAX) {
 				slide_evm_statistics = PHY_RSSI_SLID_WIN_MAX;
 				last_evm =
@@ -1460,7 +1460,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 
 		if (prev_st->packet_to_self ||
 		    prev_st->packet_beacon ||
-		    prev_st->bToSelfBA) {
+		    prev_st->to_self_ba) {
 			for (ij = 0; ij < 2; ij++) {
 				if (prev_st->RxMIMOSignalQuality[ij] != -1) {
 					if (priv->stats.rx_evm_percentage[ij] == 0)
@@ -1487,7 +1487,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	bool bpacket_match_bssid, bpacket_toself;
 	bool packet_beacon = false;
 	struct ieee80211_hdr_3addr *hdr;
-	bool bToSelfBA = false;
+	bool to_self_ba = false;
 	static struct rtllib_rx_stats  previous_stats;
 	u16 fc, type;
 	u8 *tmp_buf;
@@ -1514,7 +1514,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
 				  &previous_stats, bpacket_match_bssid,
-				  bpacket_toself, packet_beacon, bToSelfBA);
+				  bpacket_toself, packet_beacon, to_self_ba);
 	rtl92e_copy_mpdu_stats(pstats, &previous_stats);
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4055c3044fe9..315a75739e44 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -486,7 +486,7 @@ struct rtllib_rx_stats {
 	bool  is_cck;
 	bool  packet_to_self;
 	bool   packet_beacon;
-	bool   bToSelfBA;
+	bool   to_self_ba;
 };
 
 /* IEEE 802.11 requires that STA supports concurrent reception of at least
-- 
2.30.2


