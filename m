Return-Path: <linux-kernel+bounces-320381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F097097A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B6A2812A9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786B186E25;
	Sun,  8 Sep 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JcuMu43G"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB717DE36
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823607; cv=none; b=LszHomsVTHjGVTgY+4zPcUVMx/4WZMzuS7Ht6Vn7Lui6JxmS1Y6MnMgYyl0hTsECdBlZn+d8mE/PynEXfDHM658M9LBweuE8esaFL3oLNq9oy9fVCGNxIVlKmlUZEa0Sy8efXN/4M8Q/a/ZMdGCQ9bZ+5508+5PT4NgwXNenNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823607; c=relaxed/simple;
	bh=LTYeFszybk7UogGptFrkCYxtXAHySb6fBAYEP3TvpU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uP1VIAKi0zjQlAxt/b3KVHXxEwCQDYFrHBAxg29TCClVOoJCrE2Xc02O75JEmUon1eAvaVm21gUtCfrlFb7njexg9j77od4immLusa5oUbuWmhhmmhJ6itF8Yp5+k5KiBRIKyo+u6u/xi+B/FTsrr567szEr9mIS3uqbStmq3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JcuMu43G; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551eeba95so32319315ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823605; x=1726428405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CokQS4kXNUYPMSO/bhNH26UTp/Z0p345ebJ88SlkfZg=;
        b=JcuMu43GS8JbnAoviWAgJ+UXn0yREiEuO1fO+jmdyAJab48xf7qJcUjK3Hm8VCTnBI
         ZjmVvGUdh4nInrxU3HKe924fiDgOIw+w2QJR7HZp4zU+9ldMBFRYKKnnYOqZfQzGzicl
         i+Ph9RHqek+qnujEM1KEcjKnWUZryC4brx7ohxdXeRygtveZdFI2s9Ug788HxWApJrli
         Cj04v9ZspKofyjx7EkBV79YX6E/yCRqhdcbZTlh3a6p83gj2ntiPsMfFT96wgm4DGFKq
         SitmOBSaBVeV3GEWvI1RiyDK3edfalyMJJLXEH/CpE4/hqMwL2SWODaQCQdYkplv5azQ
         6FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823605; x=1726428405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CokQS4kXNUYPMSO/bhNH26UTp/Z0p345ebJ88SlkfZg=;
        b=ZyRG31s/diyvHUAUQqRxasBvWvM17sCQfh5EMnTAfJ8FA8KnEQnJpaWEGyVP+8+uT5
         4u3JmpXa4xPHdZEGNYFSnSxvd7I9B1/er177Tc8IIIXAPL9VZVxtCZEcMTFKuJxUZJb/
         fl7qJJDOhiinBUTfmIVnR1fBVkq2nor0Vv7Yvzm2v27LOEhqk/QNgJI4cQ3lqtfuBIVD
         TkNDArg/A/T+YVkRP2eeC79708vzPocJcSBHJjWT/+4tshP+d4XKvueiYwo8+WV5Q0XO
         O8Yrei+w8XUN8s2ezzmLqPPEPO/PCfk9nu4rdxa1nK5nF78TV9xwnvpCg1elbYcJkpqi
         wMag==
X-Forwarded-Encrypted: i=1; AJvYcCVauKgDD4sbnk+WGRivSVUAiXDaakAOCwULg+AT47jRnQdr4f1Y8u+FqgTzT1x6FtdygTKGCX2BdVo0gPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlprVzJSOQx8Hrhy00CI/QdIq86X/6mKLuCA4OKswlyfYHND1
	TXad5IjkpnoclqR2+PQtaufBa6t8PhNVQuuoflVrsc/B574FdIDnU1z+2Tb5D2I=
X-Google-Smtp-Source: AGHT+IG2dsp94gPihKGFg5H5haq3c+EPQj+JUdDhx0pe14/DtjqT3zFZ1C+fHjy51BvMA1Shdl5g6g==
X-Received: by 2002:a17:903:2412:b0:202:4b99:fd27 with SMTP id d9443c01a7336-206f0620834mr84000685ad.51.1725823605335;
        Sun, 08 Sep 2024 12:26:45 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:44 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/16] Staging: rtl8192e: Rename variable SignalQuality
Date: Sun,  8 Sep 2024 12:26:28 -0700
Message-Id: <20240908192633.94144-12-tdavies@darkphysics.net>
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

Rename variable SignalQuality to signal_quality
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 078e36962197..eab6bbf9f3bf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1264,8 +1264,8 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 				else
 					sq = ((64 - sq) * 100) / 44;
 			}
-			pstats->SignalQuality = sq;
-			precord_stats->SignalQuality = sq;
+			pstats->signal_quality = sq;
+			precord_stats->signal_quality = sq;
 			pstats->RxMIMOSignalQuality[0] = sq;
 			precord_stats->RxMIMOSignalQuality[0] = sq;
 			pstats->RxMIMOSignalQuality[1] = -1;
@@ -1309,8 +1309,8 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 			evm = rtl92e_evm_db_to_percent(rx_evmX);
 			if (bpacket_match_bssid) {
 				if (i == 0) {
-					pstats->SignalQuality = evm & 0xff;
-					precord_stats->SignalQuality = evm & 0xff;
+					pstats->signal_quality = evm & 0xff;
+					precord_stats->signal_quality = evm & 0xff;
 				}
 				pstats->RxMIMOSignalQuality[i] = evm & 0xff;
 				precord_stats->RxMIMOSignalQuality[i] = evm & 0xff;
@@ -1436,7 +1436,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		rtl92e_update_rx_statistics(priv, prev_st);
 	}
 
-	if (prev_st->SignalQuality != 0) {
+	if (prev_st->signal_quality != 0) {
 		if (prev_st->packet_to_self || prev_st->bPacketBeacon ||
 		    prev_st->bToSelfBA) {
 			if (slide_evm_statistics++ >= PHY_RSSI_SLID_WIN_MAX) {
@@ -1446,10 +1446,10 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 				priv->stats.slide_evm_total -= last_evm;
 			}
 
-			priv->stats.slide_evm_total += prev_st->SignalQuality;
+			priv->stats.slide_evm_total += prev_st->signal_quality;
 
 			priv->stats.slide_evm[slide_evm_index++] =
-						 prev_st->SignalQuality;
+						 prev_st->signal_quality;
 			if (slide_evm_index >= PHY_RSSI_SLID_WIN_MAX)
 				slide_evm_index = 0;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b599309b70ff..76792268629d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -464,7 +464,7 @@ struct rtllib_rx_stats {
 	u8  mask;
 	u16 len;
 	u16 Length;
-	u8  SignalQuality;
+	u8  signal_quality;
 	s32 RecvSignalPower;
 	u8  signal_strength;
 	u16 hw_error:1;
-- 
2.30.2


