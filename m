Return-Path: <linux-kernel+bounces-179436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC678C5FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4331F267EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B2762D2;
	Wed, 15 May 2024 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Z/BY4lV9"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8F7441E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748779; cv=none; b=Iqp+YujIc7PlKMsd/kKrogAbciplp/5GXJ7I11YQR2ITgFQilDDm86eY+cHTp7BnQvpTeUwh2p6MJ7PK49WPyyL4ATjFuVqEVX27Vwt7Rh5B6ziHMKlLSp8zWFW/zNeAqUbvtE/SwMWxHmo6eqTOFxTaO5g49nK6cJp5Xqco9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748779; c=relaxed/simple;
	bh=XXsPi5dRmn4XHjPPdbeSlmCDXN2q2R4ED+MLEPy/IVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+sCqHigeR9O+b9VB5l55ih4BwVXwyhDrCYk9GyitE3gL0JcS8nqihe7mjem0fNoRAc50k2k0No5OphkkXpjk6vI+22140Y+Igp8yLFsU4XSr+PieMmouWSNywtG+OK6MdhwemhPvyh7so16E1t6K9W0iHwMgfa66S5KYawF2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Z/BY4lV9; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c74b27179dso4436545b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748777; x=1716353577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGyMbnHLh+HIIQV9asHl34CUERwsx0z309fdVDbN6EE=;
        b=Z/BY4lV96n7qDrEbz0d8tFD976iqhgdSMSx9RXp5WmI/TCLzVAcDDXqj4ymGnm1lxW
         6Pc5qikrpWQzyFLrvhJb4BCPb4+TpRVOp7NSJaYPsZNfy/NcxZk7GtyQUnIDqAWGDb40
         a6Bl9DyN0mU2OhaZEca3JRi27w9drUuM0UWA8i9y9BI4FEujNSueZ8AqtxmJCHgeJhfN
         PFusOM1W4MCnHuo0CQ0nPFviIZZ16omo1QLxHEtb1uO0WiQZYIlg4esL3pg4l4C4nYGj
         X8RayhfrQ9nLXb6VcG2jQVXmd5qFvLhH1J7OBfIOaRZJbo4jqpXif0MqQ5lHQRd1ieke
         nCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748777; x=1716353577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGyMbnHLh+HIIQV9asHl34CUERwsx0z309fdVDbN6EE=;
        b=BXPoPaEbCtr2Wp8jRR5PPX9W5X7yfYEOpXzUnpGrvDPOptyHG1/skN48FlA8JcvXBY
         XcyVi1b6Apf0uCJtqvHBthbMgV3aoKmONUmGdpASW6M11WOnZkDL6LMZtASWq/v+3kNJ
         KIy1rX2+MY1BMhqcFckkqeO/7axddpMNBXHaZDL05B5rY+tuy4G9NxKlt8DpDBLs6E0s
         uEV5+d3My0bq56NZOu9YPHyA1nGagbw2aGjuH2+bVEpu2XYPpPZwupaFcVqvAkynPwn3
         MZnnm8lBM8LzrZhc9QVP0yIDTjJ8nJ77XcrTQ9aDOhZ0VshR1UV285S0h1xKjqtKgZDa
         S+nw==
X-Forwarded-Encrypted: i=1; AJvYcCXegB+/dX5AeXDn6hqerxuExTdZB1ZJRichQkKKEiW1+OVGNWUF2iw32UN/K+dBQ6GU2FlwMjBohwkX+N1g8N0TToSw6ZFJRQf9Fv+b
X-Gm-Message-State: AOJu0YwzHCEhP5gh6V86SYHA3xnyQwd9GcPnrzxPHtxF94vCjeN04ZYa
	ABCAJWMuHY0EaY0QERLrtCrGt/SF6t181KBIoUJ5MTfqOETCkCEK8l/c/G7u7N8=
X-Google-Smtp-Source: AGHT+IGwCTKH8TDoDAFIxx1Fx7EVIifKHcJUiO505L1nLWfr1gDVqQ9svIPVN4qFWm/xoDiP9Fs/8g==
X-Received: by 2002:a05:6808:1990:b0:3c9:b61d:cdb7 with SMTP id 5614622812f47-3c9b61dcfe6mr4589541b6e.2.1715748775350;
        Tue, 14 May 2024 21:52:55 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:55 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 30/31] Staging: rtl8192e: Rename variable prxbIndicateArray
Date: Tue, 14 May 2024 21:52:27 -0700
Message-Id: <20240515045228.35928-31-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable prxbIndicateArray to prxb_indicate_array
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    |  4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e2695beaf582..62af48c20229 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1409,7 +1409,7 @@ struct rtllib_device {
 	union {
 		struct rtllib_rxb *rfd_array[REORDER_WIN_SIZE];
 		struct rtllib_rxb *stats_IndicateArray[REORDER_WIN_SIZE];
-		struct rtllib_rxb *prxbIndicateArray[REORDER_WIN_SIZE];
+		struct rtllib_rxb *prxb_indicate_array[REORDER_WIN_SIZE];
 		struct {
 			struct sw_chnl_cmd PreCommonCmd[MAX_PRECMD_CNT];
 			struct sw_chnl_cmd PostCommonCmd[MAX_POSTCMD_CNT];
@@ -1803,7 +1803,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_rx_stats *stats);
 
 void rtllib_indicate_packets(struct rtllib_device *ieee,
-			     struct rtllib_rxb **prxbIndicateArray, u8  index);
+			     struct rtllib_rxb **prxb_indicate_array, u8  index);
 #define RT_ASOC_RETRY_LIMIT	5
 u8 mgnt_query_tx_rate_exclude_cck_rates(struct rtllib_device *ieee);
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 89dcbead5e11..43e94af07e99 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -429,14 +429,14 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
 }
 
 void rtllib_indicate_packets(struct rtllib_device *ieee,
-			     struct rtllib_rxb **prxbIndicateArray, u8 index)
+			     struct rtllib_rxb **prxb_indicate_array, u8 index)
 {
 	struct net_device_stats *stats = &ieee->stats;
 	u8 i = 0, j = 0;
 	u16 ethertype;
 
 	for (j = 0; j < index; j++) {
-		struct rtllib_rxb *prxb = prxbIndicateArray[j];
+		struct rtllib_rxb *prxb = prxb_indicate_array[j];
 
 		for (i = 0; i < prxb->nr_subframes; i++) {
 			struct sk_buff *sub_skb = prxb->subframes[i];
@@ -594,7 +594,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev,
 			   "Packets indication! IndicateSeq: %d, NewSeq: %d\n",
 			   ts->rx_indicate_seq, SeqNum);
-		ieee->prxbIndicateArray[0] = prxb;
+		ieee->prxb_indicate_array[0] = prxb;
 		index = 1;
 	} else {
 		/* Current packet is going to be inserted into pending list.*/
@@ -675,7 +675,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) %
 						     4096;
 
-			ieee->prxbIndicateArray[index] = pReorderEntry->prxb;
+			ieee->prxb_indicate_array[index] = pReorderEntry->prxb;
 			netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n",
 				   __func__, pReorderEntry->SeqNum);
 			index++;
@@ -706,7 +706,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 					       flags);
 			return;
 		}
-		rtllib_indicate_packets(ieee, ieee->prxbIndicateArray, index);
+		rtllib_indicate_packets(ieee, ieee->prxb_indicate_array, index);
 		bPktInBuf = false;
 	}
 
-- 
2.30.2


