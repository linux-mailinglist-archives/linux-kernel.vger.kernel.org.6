Return-Path: <linux-kernel+bounces-320375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A62970974
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4911F2126C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7B17BEAC;
	Sun,  8 Sep 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NGHNqJvR"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0617A586
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823602; cv=none; b=Cf2YRjwCntDwB3KAaJD9fOVHw3KqHwMWXKXehlgBV5pRNKiU0bD75ZxdxCHKEGQAhhR0YdhmRVsGYa7+u6kwRVi8p/AeIeFPMbMBsCFY0j52JDV5TG+M8KjAoD5wh1TjYkxrlo/B4fSesgPin/XDA23IakcLg9AmmLDN/x4e8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823602; c=relaxed/simple;
	bh=0Osi9Yn1SgzAZQTXb4Yn4PxeMRBsG64qXNCZzkLmdgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiVxTbVW28iT+HL+GiqXjmMZHS8fH/4mI1zuWqf8Y9cyjnPe+vlW/fYp9rHYbHiBb3ZYIc42h7Qj6G1pofSpDKKVWZrXjBY4lMWJucERq7nO8FBr8KXVRHO8AwBf9a+VqKGoB2oIVRejZaIiIKYUIOGe+ImF4B49Nzr5M2gba2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=NGHNqJvR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2289832a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823600; x=1726428400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWBGCmSM+rSBL4Vikquo8FMOlw1JZM7mKto3SCU6yFA=;
        b=NGHNqJvRbZyvB1Fv4nbFQR+EoODTJxERkqF1C8hngCYcHQ8C2d9MyjEAfF5Huoa/gV
         3MrlVva2T8aA9AFWEOwAwo0gEn2eNasGRS/b8HjSjsryAy0ObVeydOD3/4AAX3YmQtom
         n1EhBzYNtC8h2VMufpiMfr7HKUvgg6eHEmnwz0QfupncsKiAoeyYT1CzWDYsixXmxJEw
         kUSpKa8cp9HFvuvMvT+TNj1T/3tW8U7oA1O3ETn4cyTqwPrCt/5W6LI1RZbcyIPVpi3y
         NtBGJq6Yy+oc7sLeYI694bcn8twhk5zTEYi3ijeLfG8uwHPk3qCB2fU9QC+GDZxHklbX
         7MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823600; x=1726428400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWBGCmSM+rSBL4Vikquo8FMOlw1JZM7mKto3SCU6yFA=;
        b=FGXO5jCk3oWHmQTsewEKvR1j7ONNNarwBdT8buAiFBs2ZDjYk8xBV9mTtpFaf2TA4n
         dbUNGnTubriinokl7GCmlNORSFsyAlutBF4kf7ZsprK9g+DuDeQRqs40YtmBdWQXz2r1
         KK3gRn6+p3qWCmAnV3eVYQBVdnpY+bNcbot0SFDp7eyz1xjk4FRwLFo9PvMyzaQYY0U2
         awE3rNJrYPMzCrsJucN60Sg3cHutAW14Lom4BrwP4Qviqijr08oiH4sX7f5UAhUxRkYt
         QhVYasep1uyj3yIG537kAx12LQeNj/YoUQUjCvCRzrW6WIKtj9YUqsVfKc/5bwzwYlcB
         7qVw==
X-Forwarded-Encrypted: i=1; AJvYcCUiEIOVDn6VDUf/7umNw7n8du4JGzfJ32nbx69VskqYGKyZBuBmMFNCbcE2jLhPUoroTMHUdrL/86Z5sAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2LsdxlDfBhOeEpKXOrr0wFdYNt6VNQXkJPn/81+b2yFHsh0m
	YFRHmysGPGou6WhpcKB4BW8G2njv3zSEamghAhYVITeq1rtoKaCw7i2RMPXhz7M=
X-Google-Smtp-Source: AGHT+IHN8SVFJ3fukm2YkQUPrYgt/gYprUUlJtojprTR0QqIUOSgiZFTaLNtsj0rYmL3PlOGexyGZQ==
X-Received: by 2002:a17:902:f711:b0:202:5255:357b with SMTP id d9443c01a7336-206f0612f17mr137706165ad.41.1725823600548;
        Sun, 08 Sep 2024 12:26:40 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:40 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/16] Staging: rtl8192e: Rename variable bPacketToSelf
Date: Sun,  8 Sep 2024 12:26:22 -0700
Message-Id: <20240908192633.94144-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bPacketToSelf to packet_to_self
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index a8bb2d3f7e9d..078e36962197 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1172,7 +1172,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 	memset(precord_stats, 0, sizeof(struct rtllib_rx_stats));
 	pstats->bPacketMatchBSSID = precord_stats->bPacketMatchBSSID =
 				    bpacket_match_bssid;
-	pstats->bPacketToSelf = precord_stats->bPacketToSelf = bpacket_toself;
+	pstats->packet_to_self = precord_stats->packet_to_self = bpacket_toself;
 	pstats->bIsCCK = precord_stats->bIsCCK = is_cck_rate;
 	pstats->bPacketBeacon = precord_stats->bPacketBeacon = bPacketBeacon;
 	pstats->bToSelfBA = precord_stats->bToSelfBA = bToSelfBA;
@@ -1370,7 +1370,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	if (!bcheck)
 		return;
 
-	if (!prev_st->bIsCCK && prev_st->bPacketToSelf) {
+	if (!prev_st->bIsCCK && prev_st->packet_to_self) {
 		for (rfpath = RF90_PATH_A; rfpath < priv->num_total_rf_path; rfpath++) {
 			if (priv->stats.rx_rssi_percentage[rfpath] == 0) {
 				priv->stats.rx_rssi_percentage[rfpath] =
@@ -1416,7 +1416,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		if (prev_st->RxPWDBAll >= 3)
 			prev_st->RxPWDBAll -= 3;
 	}
-	if (prev_st->bPacketToSelf || prev_st->bPacketBeacon ||
+	if (prev_st->packet_to_self || prev_st->bPacketBeacon ||
 	    prev_st->bToSelfBA) {
 		if (priv->undecorated_smoothed_pwdb < 0)
 			priv->undecorated_smoothed_pwdb = prev_st->RxPWDBAll;
@@ -1437,7 +1437,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	}
 
 	if (prev_st->SignalQuality != 0) {
-		if (prev_st->bPacketToSelf || prev_st->bPacketBeacon ||
+		if (prev_st->packet_to_self || prev_st->bPacketBeacon ||
 		    prev_st->bToSelfBA) {
 			if (slide_evm_statistics++ >= PHY_RSSI_SLID_WIN_MAX) {
 				slide_evm_statistics = PHY_RSSI_SLID_WIN_MAX;
@@ -1458,7 +1458,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 			priv->stats.last_signal_strength_inpercent = tmp_val;
 		}
 
-		if (prev_st->bPacketToSelf ||
+		if (prev_st->packet_to_self ||
 		    prev_st->bPacketBeacon ||
 		    prev_st->bToSelfBA) {
 			for (ij = 0; ij < 2; ij++) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 95e1c81bf132..f444e85a6264 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -484,7 +484,7 @@ struct rtllib_rx_stats {
 	s8    RxMIMOSignalQuality[2];
 	bool  bPacketMatchBSSID;
 	bool  bIsCCK;
-	bool  bPacketToSelf;
+	bool  packet_to_self;
 	bool   bPacketBeacon;
 	bool   bToSelfBA;
 };
-- 
2.30.2


