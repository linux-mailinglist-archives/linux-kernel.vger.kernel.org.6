Return-Path: <linux-kernel+bounces-207672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B15901A67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FCF1F21B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901774D8BB;
	Mon, 10 Jun 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="B5oP98ch"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE893771C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998546; cv=none; b=e+tK4x1N6N4CThuBC7E3j+jgx62g1TFMg5jVbomf6E5BY0n+u6/SszJcGGWHX/ERnDtdWh+L3hSjUHMmU24e7cd0x6FpuoD2F1e6Om6qcRZYBG9BR/iVc4H+ME74OgvTova0WTEQZvf7qdYRkbN/gOoqBo5HPcJHStYFqxFa1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998546; c=relaxed/simple;
	bh=LXSQLtGdpztQ5NZQkUH3nDahG9HFPpGPtqGERo1j2tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URqibDgJ+EzKxGqgAN/Dgo2YFIbl4mbLkzcuLAVXneJU1vOxkLAXzGXq1FuCPVN4HtgBhvQt0rCs6iPV06V0pEcMrVULxdD+sjnmXiXfrVhlbGsbe3/xVHTGMcK82dLqQVBiss7RruwWcQ2F0jwW56OJVAhSqqmbX1IWBZifNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=B5oP98ch; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so7827185ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998544; x=1718603344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqxgjv78E9jKa0Z4QIgk8ZdfneN3AnYIge0hwsXYnyk=;
        b=B5oP98chBGVAWn5MEsmN/mLDcGG/FJ7j3EZLYbX0INB/hmtHDxUvNrcxo0tys99YMO
         f21/WNRrxV7LepVPDHqltMc4im1kIqJBdKqbaUuRn5+TUDO5Wxv+LPHEjGOor991BUym
         fzSWKeeNp+R53qEfLlcjZezRjwhMvQohnqDFQNR49yElPkdFYwL7Hkyj0AAiRKKBWYSF
         Ke271oDKh/m8cqubYY7uH5t/vhYhOhSjgaNs+y8MOAzUjFQs1is2DC+4KvzXTvWW7yY2
         wiNWRlBtse9OuKqzMb5r9Y0pzF/fSQmnW9BLjGJN3VLYKLU4XAWQVnQ7W12womR8Ctoc
         fq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998544; x=1718603344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqxgjv78E9jKa0Z4QIgk8ZdfneN3AnYIge0hwsXYnyk=;
        b=nhLLCYYoQXzfoTtSV2GFMgw6eztIAp+IXG/d8xSgFVOXJi25Fb6EHeABQOr3bFsQW7
         F/k/IGiNirdDX+HVFpTdaQ9H4WjC+f3JHohaySE4/ckPRl8Z/P6LUuC9O2+Eb7BE00S9
         FNAbsDloKd2Zxfc3iSvFp+UC2PjmrccJoq4GsoCxN9JXZBIbhx52QWbk51M8HfDHjujb
         BApO7oBkzs4DdtDLdrL264KSKBaaLeGfx9t/A0afC16D51no3oZf3MaO7mcgWAyXPhni
         z9xIN8RfJGBMO6VHp7FwIEv7nNPyb2sFdOJCPAHLh+g2cB1ypraxB+G/6nlkGfjhxV0c
         hsKg==
X-Forwarded-Encrypted: i=1; AJvYcCXdSs/QVU8smI0Bu6TE6UWE+p1nUns2LRIRpIxck7prjJJBvu7ZtBlEbAVFgAoWPuENTKNRczlJ4Wy1M/Ids4nT+jon10VkeHhEIB4S
X-Gm-Message-State: AOJu0Yz3lmOobw9CJ80WtMNz7nmCwuvaxhWfeRjkayKDQ4kS1isHhBNP
	3RZ/y262RzxV3xucqr7dvvNTOAl/qHh72jNyw811m9HAEA+dkcfm2qBFy8DokLI=
X-Google-Smtp-Source: AGHT+IElA0F+bHa14Wf0wCkBWA0BAvSmBkVIJNgh3l+MgkwnENYO4o14WCXklwcKklOrO3D1PH8cow==
X-Received: by 2002:a17:903:1cf:b0:1f6:6a94:76be with SMTP id d9443c01a7336-1f6d0377644mr107595415ad.46.1717998544631;
        Sun, 09 Jun 2024 22:49:04 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:04 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/24] Staging: rtl8192e: Rename variable bforced_tx20Mhz
Date: Sun,  9 Jun 2024 22:44:34 -0700
Message-Id: <20240610054449.71316-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bforced_tx20Mhz to forced_tx_20mhz
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h          | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5392d2daf870..7d5046b58cd1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -377,7 +377,7 @@ static void _rtl92e_dm_init_bandwidth_autoswitch(struct net_device *dev)
 
 	priv->rtllib->bandwidth_auto_switch.threshold_20Mhzto40Mhz = BW_AUTO_SWITCH_LOW_HIGH;
 	priv->rtllib->bandwidth_auto_switch.threshold_40Mhzto20Mhz = BW_AUTO_SWITCH_HIGH_LOW;
-	priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz = false;
+	priv->rtllib->bandwidth_auto_switch.forced_tx_20mhz = false;
 	priv->rtllib->bandwidth_auto_switch.bautoswitch_enable = false;
 }
 
@@ -388,14 +388,14 @@ static void _rtl92e_dm_bandwidth_autoswitch(struct net_device *dev)
 	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20 ||
 	    !priv->rtllib->bandwidth_auto_switch.bautoswitch_enable)
 		return;
-	if (!priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz) {
+	if (!priv->rtllib->bandwidth_auto_switch.forced_tx_20mhz) {
 		if (priv->undecorated_smoothed_pwdb <=
 		    priv->rtllib->bandwidth_auto_switch.threshold_40Mhzto20Mhz)
-			priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz = true;
+			priv->rtllib->bandwidth_auto_switch.forced_tx_20mhz = true;
 	} else {
 		if (priv->undecorated_smoothed_pwdb >=
 		    priv->rtllib->bandwidth_auto_switch.threshold_20Mhzto40Mhz)
-			priv->rtllib->bandwidth_auto_switch.bforced_tx20Mhz = false;
+			priv->rtllib->bandwidth_auto_switch.forced_tx_20mhz = false;
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bd18d866ce22..d0da16a86633 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1018,7 +1018,7 @@ struct tx_pending {
 struct bandwidth_autoswitch {
 	long threshold_20Mhzto40Mhz;
 	long	threshold_40Mhzto20Mhz;
-	bool bforced_tx20Mhz;
+	bool forced_tx_20mhz;
 	bool bautoswitch_enable;
 };
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index d376c35a5ad7..d9749d2c1668 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -362,7 +362,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
 	if (ht_info->cur_bw_40mhz && ht_info->cur_tx_bw40mhz &&
-	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
+	    !ieee->bandwidth_auto_switch.forced_tx_20mhz)
 		tcb_desc->bPacketBW = true;
 }
 
-- 
2.30.2


