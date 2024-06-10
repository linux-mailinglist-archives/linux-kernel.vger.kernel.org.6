Return-Path: <linux-kernel+bounces-207668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13C901A64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F4E1F218FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982032771C;
	Mon, 10 Jun 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="UjE8YvEb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE964171C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998543; cv=none; b=auEIv8enWARsAfec2JCEcKpacxzXW29BUd1IhUwpgQRbkH4XlwbT6YqL+zZA0rcSyZL8AJeifork2xsbXtsntl5KXgMk21LVT5dInVlqryN3VeB5yfI9eTsDOzpQMBhDjGDEzuNkdmreJSFrPfdIZ1VKiHD2Xd73DbEahu1Gk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998543; c=relaxed/simple;
	bh=9m9iTcd73yG/t2B/iYEbUvMT1In2wOJerLjH1B4JOWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eunWUKB2PqWAZHxhKwtO5s9ve+O0RWKqLDPeYFJZCQwBm/JFLDNW7dbU1wkhza30TFlM4mUlXeeSYpG+9N1+rdRmq5GBt2TIN4UqC4s8u3CdJPD6M3nPR0fz0c9yuU4Bh5LrlmqrjKSid44nHKdWqi+TkNlAE9uwpdq99JrrJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=UjE8YvEb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f44b441b08so30690975ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998541; x=1718603341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6yjBotdf4gZOJsvp6Qvi5UnTh9sPh+EY8PZx41zH7Q=;
        b=UjE8YvEbl1CWgkTsFnZWktaKOVqCWP1u2lgjwBspoJdlnxz4uHxGp1iUNCCF7Ev+fJ
         7jxaL2hTomJ9jO0YjaL31Xy4Cah3bI45N9eJun9N2PbYObNyePaKmbSEjmFUQ4Lf74Bn
         vh93nvka5y/o+TGs7hfGvlWSDV8sBK6f0CORwnOfZMhd3A0lV1hhhCiJM/R/FzxhXaZk
         QM5Nv/5utrOVhqLT/HHZru8t4PmbltG81IAisOLuP4zTsoZ1R8RWkvu93U99l8IFpygM
         WAoQ0OyYk1iW8P/o7kWjb2g3JAuNHY8LZ8iUwtyn8lrVaIgAsMobjB7GuqYMdHQmQ3EV
         UvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998541; x=1718603341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6yjBotdf4gZOJsvp6Qvi5UnTh9sPh+EY8PZx41zH7Q=;
        b=r3VX16iowCU56oqZJsVHKAJrMmW1V9WOqS45dre2JOh/PlAtQmUdt5ffesW5sicPfa
         MPiGvoHuL0+6C8d4BxSOa/GT26VvZbT1LA97p5T3rpZjTe1wBSQbNjXp2pMi0kt6cK/H
         t43SHiuX8fEkk9c5PPzqrsXReU2uiShQjUDu6WHDTubfqyFXRSUzk4BcbzmAEOCXvCN2
         8zNA+T2WsknsDcWSl/0FaXGAj4iw5y8DqD+gH9HkqJ/jn4I3J2xUYst1B6fURlAYMDED
         pUOZb5o1ZbByPAJoS/dGaFPoXoOxXGdP00kFxTcbE0WtqGE1yAK4mIUDw5JrzBoJgjkY
         4irQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdKm2mnBLAiGPMoOWm8MhitDvI7wMfvFgZTeIPN9nDz0GNcYvqjyI5gnx/j9V3X/hcIRRCciYR9CbuT4ChVEzkZudFj24O9xACoxI3
X-Gm-Message-State: AOJu0YxopQV0NtOue1pATGK9CTOFGKLQo2BC/DkQVx3bV01sKmeuyV+r
	+bmUDKd0OwiHAxIhZEcjpZcSqgP/F5lbj1mg2PcR5/JSeaFYhW3vn4hR/+paMeM=
X-Google-Smtp-Source: AGHT+IEJCOnsUZ5mDJ/dwKhRUZnhjHwooanfXy2sI1itkY7HmSnvBxjHMEJvVDcAfohEpeVXN9GjPA==
X-Received: by 2002:a17:902:d2c4:b0:1f7:1f4d:4652 with SMTP id d9443c01a7336-1f71f4d46b0mr974725ad.25.1717998541236;
        Sun, 09 Jun 2024 22:49:01 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/24] Staging: rtl8192e: Rename variable bRTSEnable
Date: Sun,  9 Jun 2024 22:44:30 -0700
Message-Id: <20240610054449.71316-6-tdavies@darkphysics.net>
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

Rename variable bRTSEnable to rts_enable
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 27dfa268cd68..0263f3d7179c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -892,7 +892,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 		pTxFwInfo->RxAMD = 0;
 	}
 
-	pTxFwInfo->RtsEnable =	(cb_desc->bRTSEnable) ? 1 : 0;
+	pTxFwInfo->RtsEnable =	(cb_desc->rts_enable) ? 1 : 0;
 	pTxFwInfo->CtsEnable = (cb_desc->bCTSEnable) ? 1 : 0;
 	pTxFwInfo->RtsSTBC = (cb_desc->bRTSSTBC) ? 1 : 0;
 	pTxFwInfo->RtsHT = (cb_desc->rts_rate & 0x80) ? 1 : 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6dc641f78202..a305848dabd5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -111,7 +111,7 @@ struct cb_desc {
 
 	/* Tx Firmware Related flags (10-11)*/
 	u8 bCTSEnable:1;
-	u8 bRTSEnable:1;
+	u8 rts_enable:1;
 	u8 bUseShortGI:1;
 	u8 bUseShortPreamble:1;
 	u8 tx_enable_fw_calc_dur:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 83082a990fbd..be8de6703e5d 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -386,10 +386,10 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 
 	if (ieee->mode < WIRELESS_MODE_N_24G) {
 		if (skb->len > ieee->rts) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->rts_rate = MGN_24M;
 		} else if (ieee->current_network.buseprotection) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->bCTSEnable = true;
 			tcb_desc->rts_rate = MGN_24M;
 		}
@@ -402,16 +402,16 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		if (ht_info->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
 			tcb_desc->bCTSEnable	= true;
 			tcb_desc->rts_rate  =	MGN_24M;
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			break;
 		} else if (ht_info->iot_action & (HT_IOT_ACT_FORCED_RTS |
 			   HT_IOT_ACT_PURE_N_MODE)) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->rts_rate  =	MGN_24M;
 			break;
 		}
 		if (ieee->current_network.buseprotection) {
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			tcb_desc->bCTSEnable = true;
 			tcb_desc->rts_rate = MGN_24M;
 			break;
@@ -423,18 +423,18 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 						      ht_op_mode == 3)) ||
 			     (!ht_info->cur_bw_40mhz && ht_op_mode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
-				tcb_desc->bRTSEnable = true;
+				tcb_desc->rts_enable = true;
 				break;
 			}
 		}
 		if (skb->len > ieee->rts) {
 			tcb_desc->rts_rate = MGN_24M;
-			tcb_desc->bRTSEnable = true;
+			tcb_desc->rts_enable = true;
 			break;
 		}
 		if (tcb_desc->ampdu_enable) {
 			tcb_desc->rts_rate = MGN_24M;
-			tcb_desc->bRTSEnable = false;
+			tcb_desc->rts_enable = false;
 			break;
 		}
 		goto NO_PROTECTION;
@@ -443,7 +443,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		tcb_desc->bUseShortPreamble = true;
 	return;
 NO_PROTECTION:
-	tcb_desc->bRTSEnable	= false;
+	tcb_desc->rts_enable	= false;
 	tcb_desc->bCTSEnable	= false;
 	tcb_desc->rts_rate	= 0;
 	tcb_desc->RTSSC		= 0;
-- 
2.30.2


