Return-Path: <linux-kernel+bounces-331297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252197AB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E36B28BE36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130615AACA;
	Tue, 17 Sep 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="aeCK9q6i"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA31531DB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551125; cv=none; b=mjny1KE80RHnomwU1KxoNlqPjjvSHKZyLTyancyPiPhuVxfMoA5su0qBwAkG+HMY+v3wKB9HxHGl+wzaczUHKeBhLk2KUt/zJaojg7g8nqNjq7En7BExkKDIY/Z1T1CunPFzu5XuVdE1mJ8lAQKlOXzMKb7Whu/5UJ7iG6kyxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551125; c=relaxed/simple;
	bh=Uo6WuL25MMLjivW5vo5RhhYC1vhyvzMtpyxTXfSsK2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLuNDo3kpkHcaMkzTkz80Q1ypd1nqx34+Mtw8wynMIR5g1rmHv5xlLYEAAeeG9TiZXrElj0tlI1hOcqBs6RIHf5oxZdwWsJOXOq4XG1T5rhFgY1Jigb96ct50m5fykVa7PIKud1nPTi2VtdgqqaBABumAcN7QgbHN09Gc48TghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=aeCK9q6i; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206b9455460so39834755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551123; x=1727155923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YSnWD5yZrBHR1oCufU8J5mydWGTq5g5s/eKz55Tg6E=;
        b=aeCK9q6iEAMHKDW27Z5eSy2yJtFvp07v0mSFvCbbPBUwS3ZZE74QcMBL0nJUSko1Cm
         d+sXJNjuQdQB+eF2lhU0rlSKtmA8d0enaZxuLG3fE9bm3qM6URZBDgpqZIidhCNwZZ/L
         +noa/id7Q5gvC3W69SwpdzJj3Y/jgRE6ByjCBODE6k5UOkeMwsSyOP6fp7StgjIx3tZl
         9huVOMgyFEA/1KhopEsfCw9zj/sGiQrVKCKcqtlfPsOg84nUSV5m4eTysJerdMbX5sEw
         gqlxDa75z4z5yobIMsbBnhCLi/A9eB1sEEqbpe9P/KJSNbsAmWyKDuuQqeFWC/yAZVHu
         zXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551123; x=1727155923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YSnWD5yZrBHR1oCufU8J5mydWGTq5g5s/eKz55Tg6E=;
        b=aioxytHVFUcq+QJWIFhD2fk9RbIvHGj22Op51T7hoJospPj3C6470nNDgMa1QMlAKy
         eJtVjDNLHleU89UFpJFivD8Yd0fVLstRIewq+3b2qsGMJ5Eh5jmXv/PU9iK0ttB8HmCe
         F+oDP69lHaL4GNpNWteg/hQyHtNUVEmUNc7Aod7p/uIleEBVioGcO8ot+9AylTg9a2m8
         hYQehv6YC7GXcjuMS+NJr+hS7R0As6ynTdxHw2Y9hwtKpbgt4+Uc2DXu6a+LWuMJVnBs
         rCAmk8fjVtt8PYj8OcE/tC5LDe0B+7Uf1rWnEKU1mwMS1VZB/o4Z9NXiyxCn2XQ+G/li
         KsHA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUDvP22pUAzPBaopPLDMMdhKRM/qjl53KDqXcW9VwF1zgEJmA2VyKppiHZIZeKLlK2/I7ABN9Ml1UprA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOI6beu7FiBoVL+k1vA9jgu4h0TgUGOzSBWTxJnePHslipFxa4
	menYqdcFDAMTntgRIAxw3uks4rNoE2UMq98t8lev+BiWjdwG3mTbDqfz1ND3hSmt8bR8QtbfXM9
	A
X-Google-Smtp-Source: AGHT+IFFrlWGY9a1utCnaH2Uv9do7wUI3ZntHgsek+0Mqfp/OZJlTdaoFeuckOpOYkQ22G47EJWfHw==
X-Received: by 2002:a17:903:1cf:b0:204:e471:8f06 with SMTP id d9443c01a7336-2074c65aa70mr328457905ad.17.1726551122827;
        Mon, 16 Sep 2024 22:32:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:02 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/18] Staging: rtl8192e: Rename variable bPacketBeacon
Date: Mon, 16 Sep 2024 22:31:44 -0700
Message-Id: <20240917053152.575553-11-tdavies@darkphysics.net>
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

Rename variable bPacketBeacon to packet_beacon
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 18 +++++++++---------
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 87a370a4b2db..75ca921c8aff 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1152,7 +1152,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 				      struct rtllib_rx_stats *precord_stats,
 				      bool bpacket_match_bssid,
 				      bool bpacket_toself,
-				      bool bPacketBeacon,
+				      bool packet_beacon,
 				      bool bToSelfBA)
 {
 	struct phy_sts_ofdm_819xpci *pofdm_buf;
@@ -1174,7 +1174,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 				    bpacket_match_bssid;
 	pstats->packet_to_self = precord_stats->packet_to_self = bpacket_toself;
 	pstats->is_cck = precord_stats->is_cck = is_cck_rate;
-	pstats->bPacketBeacon = precord_stats->bPacketBeacon = bPacketBeacon;
+	pstats->packet_beacon = precord_stats->packet_beacon = packet_beacon;
 	pstats->bToSelfBA = precord_stats->bToSelfBA = bToSelfBA;
 	if (check_reg824 == 0) {
 		reg824_bit9 = rtl92e_get_bb_reg(priv->rtllib->dev,
@@ -1396,7 +1396,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		}
 	}
 
-	if (prev_st->bPacketBeacon) {
+	if (prev_st->packet_beacon) {
 		if (slide_beacon_adc_pwdb_statistics++ >=
 		    PHY_Beacon_RSSI_SLID_WIN_MAX) {
 			slide_beacon_adc_pwdb_statistics =
@@ -1416,7 +1416,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		if (prev_st->RxPWDBAll >= 3)
 			prev_st->RxPWDBAll -= 3;
 	}
-	if (prev_st->packet_to_self || prev_st->bPacketBeacon ||
+	if (prev_st->packet_to_self || prev_st->packet_beacon ||
 	    prev_st->bToSelfBA) {
 		if (priv->undecorated_smoothed_pwdb < 0)
 			priv->undecorated_smoothed_pwdb = prev_st->RxPWDBAll;
@@ -1437,7 +1437,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	}
 
 	if (prev_st->signal_quality != 0) {
-		if (prev_st->packet_to_self || prev_st->bPacketBeacon ||
+		if (prev_st->packet_to_self || prev_st->packet_beacon ||
 		    prev_st->bToSelfBA) {
 			if (slide_evm_statistics++ >= PHY_RSSI_SLID_WIN_MAX) {
 				slide_evm_statistics = PHY_RSSI_SLID_WIN_MAX;
@@ -1459,7 +1459,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		}
 
 		if (prev_st->packet_to_self ||
-		    prev_st->bPacketBeacon ||
+		    prev_st->packet_beacon ||
 		    prev_st->bToSelfBA) {
 			for (ij = 0; ij < 2; ij++) {
 				if (prev_st->RxMIMOSignalQuality[ij] != -1) {
@@ -1485,7 +1485,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	bool bpacket_match_bssid, bpacket_toself;
-	bool bPacketBeacon = false;
+	bool packet_beacon = false;
 	struct ieee80211_hdr_3addr *hdr;
 	bool bToSelfBA = false;
 	static struct rtllib_rx_stats  previous_stats;
@@ -1510,11 +1510,11 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
 	if (ieee80211_is_beacon(hdr->frame_control))
-		bPacketBeacon = true;
+		packet_beacon = true;
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
 				  &previous_stats, bpacket_match_bssid,
-				  bpacket_toself, bPacketBeacon, bToSelfBA);
+				  bpacket_toself, packet_beacon, bToSelfBA);
 	rtl92e_copy_mpdu_stats(pstats, &previous_stats);
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ca8f39f8e9ea..b0f01d940efa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -485,7 +485,7 @@ struct rtllib_rx_stats {
 	bool  bPacketMatchBSSID;
 	bool  is_cck;
 	bool  packet_to_self;
-	bool   bPacketBeacon;
+	bool   packet_beacon;
 	bool   bToSelfBA;
 };
 
-- 
2.30.2


