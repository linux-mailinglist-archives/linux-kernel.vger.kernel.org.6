Return-Path: <linux-kernel+bounces-320371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C04970970
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F030281A7C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3117A5B5;
	Sun,  8 Sep 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RlaLCNxZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA948177991
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823601; cv=none; b=XVy7gkfuzs59auVY9bm+jZAp+3GNafrX2qtBrjhNFNrebL+oe9wzVaCGJuUQ5EVAaD5Lhb9usDnx3EUsly352zsDofEgpKLVTfGt7cLzWIBQ/s0VGqTVzslTm3r2hLDKIB0oVb4sYXoXiNfvLnfavNRWJXcQ63dTCTKAJucHOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823601; c=relaxed/simple;
	bh=zbNIVZ0EAkXjfEs2RH4lfSau8YChUlUuLtWGlnaS4k8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMHcxO/M21jABRY3AwrMXoWwCPPCRT+CChS3SuFbO36oAxZuvTd24jJjYzUsYRzGVQoTyf4f8mJgChiHtw6ou9iWd/b7pbVE16VTHcqICKGrWjzA0rPdCrMP6AGxZrnww30jsO1a8wKfanrBeuBRqoEiknpuERtU8rtnGtdDk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RlaLCNxZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2055136b612so42597575ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823599; x=1726428399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwzpOQ/aAEGoHuaN2ZwbC1rSJVDkP7/Zcai6c3SwE5E=;
        b=RlaLCNxZbgPPv/WrpqcEBV9ckc/hIXi4WQ0B8EIWKncj34PY0D3z5sAgEUtkf85vol
         kKk4KjRT0V7r42mOFOq6kdDY/o+M4Z17CIWeOOU55ZxXnyFeMUhKBXMWRyHqPtKgrr+f
         DuyG8aY/8OTE7LMP5LXVOc/qp+3Un/MGJmxzKeVkT24q9pnzhoNnTUbBi0hhvxuWPmt5
         uocvabRhCz6zoQ3PRguFts+p/fVNtfNPT5P63vGwSSzeZ0neYRzp8Ci1tEeUmoVjgjy6
         ZA6FuRRj68GKx4bWzR789M9Yo2vxZMVtLvqUxKyB3vfVqPOInExcAK1lUfQ/Ja3gzTuk
         nlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823599; x=1726428399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwzpOQ/aAEGoHuaN2ZwbC1rSJVDkP7/Zcai6c3SwE5E=;
        b=WCAhv9UpBaYKySYkb0n38oVDToD8Sfw1nJ4H4KQ2vb9YYdfUhF7h9Yb4OBjpm9QyXO
         k6iXl+6ClG701cXaKT0Gj1Yp0HWstV63YUMe2dze5y/Ye6lXtybdKX1CJAsQXJEIM4xv
         FB3EJuln43jIWxC04BiNBqv755MO9VyYOcRVhQh5yJ6crBAU4F4iP5Oq0nylMFVC89wN
         yiFNeXbzNZQfYeWpy/0GAJlC91PsV/keWDyeA4AS7wzQBTWspqALtfkqwxwOBTOzFDXo
         e2nf+/wN0WPN0xFUC5XPIbPUmZ8VGaqug1I4UJGYoAw0qgGchJvMXPp65PZtEwC5QZt3
         CBDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlVpF5i5vesSOp0Ba37AHCV43I8HsXoklH0fZbsOq04Fp6oVGxrvM0OX9UvJCdM/TgqqnO5ycHsRaXih4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygREVKsvGct3dT0dsYj8wTg7Io37OaqTKoJ4sMDLf98bD9zP8S
	Ro873TG2/5+Wf7NsgYSJvYudIQ1UN7Pnw0CQBD1JEd1E7CUPJRnqKeDjT3GgAhz9BtSI3lwNLYT
	/fwk=
X-Google-Smtp-Source: AGHT+IG8TETov1t4f/DlwsU0CtYcnIJ0Wy1ttjyQCelK2ApFt+/VfhEz16eA0j6St9aZ1UIi7e2t6Q==
X-Received: by 2002:a17:902:ea01:b0:206:cfb3:7232 with SMTP id d9443c01a7336-206f05e7eafmr145690675ad.48.1725823599059;
        Sun, 08 Sep 2024 12:26:39 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:38 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/16] Staging: rtl8192e: Rename variable SignalStrength
Date: Sun,  8 Sep 2024 12:26:20 -0700
Message-Id: <20240908192633.94144-4-tdavies@darkphysics.net>
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

Rename variable SignalStrength to signal_strength
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h              | 4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c           | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f5a46754d65f..a8bb2d3f7e9d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1319,12 +1319,12 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 	}
 
 	if (is_cck_rate) {
-		pstats->SignalStrength = precord_stats->SignalStrength =
+		pstats->signal_strength = precord_stats->signal_strength =
 					 _rtl92e_signal_scale_mapping(priv, (long)pwdb_all);
 
 	} else {
 		if (rf_rx_num != 0)
-			pstats->SignalStrength = precord_stats->SignalStrength =
+			pstats->signal_strength = precord_stats->signal_strength =
 					 _rtl92e_signal_scale_mapping(priv,
 					 (long)(total_rssi /= rf_rx_num));
 	}
@@ -1352,10 +1352,10 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		last_rssi = priv->stats.slide_signal_strength[slide_rssi_index];
 		priv->stats.slide_rssi_total -= last_rssi;
 	}
-	priv->stats.slide_rssi_total += prev_st->SignalStrength;
+	priv->stats.slide_rssi_total += prev_st->signal_strength;
 
 	priv->stats.slide_signal_strength[slide_rssi_index++] =
-					 prev_st->SignalStrength;
+					 prev_st->signal_strength;
 	if (slide_rssi_index >= PHY_RSSI_SLID_WIN_MAX)
 		slide_rssi_index = 0;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b033e8345b0a..9f812cedd1b3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -466,7 +466,7 @@ struct rtllib_rx_stats {
 	u16 Length;
 	u8  SignalQuality;
 	s32 RecvSignalPower;
-	u8  SignalStrength;
+	u8  signal_strength;
 	u16 hw_error:1;
 	u16 bCRC:1;
 	u16 bICV:1;
@@ -951,7 +951,7 @@ struct rtllib_network {
 	bool unknown_cap_exist;
 	bool	berp_info_valid;
 	bool buseprotection;
-	u8 SignalStrength;
+	u8 signal_strength;
 	u8 RSSI;
 	struct list_head list;
 };
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 86beac9dd3a5..8fe224a83dd6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2177,8 +2177,8 @@ static inline int rtllib_network_init(
 	network->marvell_cap_exist = false;
 	network->airgo_cap_exist = false;
 	network->turbo_enable = 0;
-	network->SignalStrength = stats->SignalStrength;
-	network->RSSI = stats->SignalStrength;
+	network->signal_strength = stats->signal_strength;
+	network->RSSI = stats->signal_strength;
 	network->country_ie_len = 0;
 	memset(network->country_ie_buf, 0, MAX_IE_LEN);
 	ht_initialize_bss_desc(&network->bssht);
@@ -2215,7 +2215,7 @@ static inline int rtllib_network_init(
 	}
 	if (rtllib_is_empty_essid(network->ssid, network->ssid_len))
 		network->flags |= NETWORK_EMPTY_ESSID;
-	stats->signal = 30 + (stats->SignalStrength * 70) / 100;
+	stats->signal = 30 + (stats->signal_strength * 70) / 100;
 	stats->noise = rtllib_translate_todbm((u8)(100 - stats->signal)) - 25;
 
 	memcpy(&network->stats, stats, sizeof(network->stats));
@@ -2334,7 +2334,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	   src->wmm_param[3].ac_aci_acm_aifsn)
 		memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
 
-	dst->SignalStrength = src->SignalStrength;
+	dst->signal_strength = src->signal_strength;
 	dst->RSSI = src->RSSI;
 	dst->turbo_enable = src->turbo_enable;
 
-- 
2.30.2


