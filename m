Return-Path: <linux-kernel+bounces-207671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBEA901A66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B431F218A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA13482D7;
	Mon, 10 Jun 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="k9v8HOa8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B12032D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998546; cv=none; b=Mi4cZsaEJWut+LdMsgFR1dmxt/jSxUDH7B5m/0rSfIfeWH+96kdJulMCTIA2B/ymSkPWTIbSf/zW4hxG+BH4mkube1u7aNJWseyT0A0Xx4pWY5udy5O3czzyRipiklgpZlYPQoN87WRa4ySmE6YNZ7oPKR0tc0Zc0ll2w9QMjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998546; c=relaxed/simple;
	bh=9ezrWzEojwBQEXYTHUn/K2S7rUCtz6F09IAoOdkYusU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l81gYgkoS/dUyXAGnLR8wNnASUtRVI+lbeUGWOYLQARUVSphvtPQMHp+GplaaMkkJw5AZ4TdLK8ngUj5dwvzw3nB8xyysfcU3C79Fd9Hb2iIpxmn57c09Zv8c0jsDtkW2/MABaLQFyGApEn5f5vZWo1HRgEGMAoy/Vhpfu4knuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=k9v8HOa8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f717b3f2d8so2450485ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998543; x=1718603343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lk2mkD39Mo8YtITxE0/jQsIKJ8nqnR0iRRO9PVvlVY=;
        b=k9v8HOa8uNsOyrG3xmBQrKP1kfASIg2fB6ORyBG+KLbynH3DONJTArPVkvbktuNF5q
         jOufLcBGBfaB9WVV72K7rDj67IKkoQK5l14AkIMIlDBeSefltEgsetTDARpOJFf6CnPw
         QP++GHw0hnV4S/gpmxQuMMeDuwyCi7HwS7LXK+41Y2SI4wJNqeWoJ7q40Y2vU2h5f3p0
         gt0atz4fsQSwt9Aky6fP4JerDW7XX+NXWC0Zv28iM4/FEV1DILYqPn1GX56xxcdXdxs5
         CmLfOzFvOjbg5DGiv+6S/GTFgbnun2TH6rHWi/I5QnyFDZGiJI6LHbYAEJgSdyxZFj6e
         TuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998543; x=1718603343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lk2mkD39Mo8YtITxE0/jQsIKJ8nqnR0iRRO9PVvlVY=;
        b=GFZ7JCojyDfiAtoEQWPZccNKNOQgMRyzap8SEGJ5Ky2p8FZ22IDoBZx+mA+qTnbiYi
         OZ0xlBxQCV5+9MqZnFLbN9AqcMvP4xhQ+/xifd6GUDn80RYfFaWXuF2/oAjXlY1/xVby
         1VXTte5D3bAz6Iaak61A391i3a0pPXMG3RiFtEAXRxNGxgyn9y0ldgumP97c+XeyRMFo
         ltbHmAOm/ZI6IpmUMVARxa57+CKlrBexYXWDlYPUp+WrTvYdZVeUJvPpDXN1c72nsUCi
         HLZGPEGDaSJmsCKJmGn1H0xxQyMqTWxxIk5GryZqiZWSrQJeisD8WuVuV0ZWO79lskl3
         dExg==
X-Forwarded-Encrypted: i=1; AJvYcCXtgNq8KQGNn9w4wZgHcuMcz7zuwdGXeUgenUCmXmIgWTsUcrt7e1HNYc9CZy4Utpt+gFdZfxfoaMKhYphaCqxlnC5r11LfYcHwGhac
X-Gm-Message-State: AOJu0YybZd2/mWnHFzcfT0tpb+ae2YKP97ShmjVD4b0y+JeyKsIXMhPZ
	+O/aCA5RctjnCcEmunX9o/dIBPCcLTgDm6Ci2ophLVNTNOfaWglXFsdxl4XO7UI=
X-Google-Smtp-Source: AGHT+IF81VbRcYHeM6763NPd2q8gwSGJtgesW+eAKOUDO8vP8Lq86Pff/cFbzho7h1U1VK3nM3ZTPA==
X-Received: by 2002:a17:902:d4c3:b0:1f6:3a73:1eac with SMTP id d9443c01a7336-1f6d0151b30mr120286635ad.17.1717998542981;
        Sun, 09 Jun 2024 22:49:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:02 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/24] Staging: rtl8192e: Rename variable bCTSEnable
Date: Sun,  9 Jun 2024 22:44:32 -0700
Message-Id: <20240610054449.71316-8-tdavies@darkphysics.net>
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

Rename variable bCTSEnable to cts_enable
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 0263f3d7179c..4117530f19b1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -893,7 +893,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 	}
 
 	pTxFwInfo->RtsEnable =	(cb_desc->rts_enable) ? 1 : 0;
-	pTxFwInfo->CtsEnable = (cb_desc->bCTSEnable) ? 1 : 0;
+	pTxFwInfo->CtsEnable = (cb_desc->cts_enable) ? 1 : 0;
 	pTxFwInfo->RtsSTBC = (cb_desc->bRTSSTBC) ? 1 : 0;
 	pTxFwInfo->RtsHT = (cb_desc->rts_rate & 0x80) ? 1 : 0;
 	pTxFwInfo->RtsRate = _rtl92e_rate_mgn_to_hw(cb_desc->rts_rate);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0131765e451e..2282c709654d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -110,7 +110,7 @@ struct cb_desc {
 	u8 nStuckCount;
 
 	/* Tx Firmware Related flags (10-11)*/
-	u8 bCTSEnable:1;
+	u8 cts_enable:1;
 	u8 rts_enable:1;
 	u8 bUseShortGI:1;
 	u8 bUseShortPreamble:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8c9072538688..c0fe00d0df02 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -374,7 +374,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 
 	tcb_desc->bRTSSTBC			= false;
 	tcb_desc->bRTSUseShortGI		= false;
-	tcb_desc->bCTSEnable			= false;
+	tcb_desc->cts_enable			= false;
 	tcb_desc->RTSSC				= 0;
 	tcb_desc->rts_bw			= false;
 
@@ -390,7 +390,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			tcb_desc->rts_rate = MGN_24M;
 		} else if (ieee->current_network.buseprotection) {
 			tcb_desc->rts_enable = true;
-			tcb_desc->bCTSEnable = true;
+			tcb_desc->cts_enable = true;
 			tcb_desc->rts_rate = MGN_24M;
 		}
 		return;
@@ -400,7 +400,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 
 	while (true) {
 		if (ht_info->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
-			tcb_desc->bCTSEnable	= true;
+			tcb_desc->cts_enable	= true;
 			tcb_desc->rts_rate  =	MGN_24M;
 			tcb_desc->rts_enable = true;
 			break;
@@ -412,7 +412,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		}
 		if (ieee->current_network.buseprotection) {
 			tcb_desc->rts_enable = true;
-			tcb_desc->bCTSEnable = true;
+			tcb_desc->cts_enable = true;
 			tcb_desc->rts_rate = MGN_24M;
 			break;
 		}
@@ -444,7 +444,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	return;
 NO_PROTECTION:
 	tcb_desc->rts_enable	= false;
-	tcb_desc->bCTSEnable	= false;
+	tcb_desc->cts_enable	= false;
 	tcb_desc->rts_rate	= 0;
 	tcb_desc->RTSSC		= 0;
 	tcb_desc->rts_bw	= false;
-- 
2.30.2


