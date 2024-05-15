Return-Path: <linux-kernel+bounces-179434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4AC8C5FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752EB1F264E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0447580C;
	Wed, 15 May 2024 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gFwJvBud"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672F6E617
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748778; cv=none; b=Y4a2RR8zWzGaAZBpZoWGX4cVnX+sJOOftcYFzNrAiu66t23Na4ztNxWYGxv4jBmWc6Kc2YLN5MuhRkFQoEn3NySGE00EboOGE+iw/KxnSToOgG5xHro7kba4tNFJsqaDYsBYDPsAM64gZrPnzBMe7rBdQWqCN7XNCUpLWFCf/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748778; c=relaxed/simple;
	bh=x+7th958K+EtaVZNAuZ4f3J4B8F0FKqpXqhitiQlKQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blZrFaVCPvdmlXikmjCtyz7aHqI07deyOIx8FjKoF04zolyrKgok6ww2zPK+XgLPIDCC28W/1QGfTfJa9oETOaNOGXPYVBkKDEh+IOLNH65wUEPef+Xyk419LMrdHXBhSjC57HaQhlY65YvQub9d/9IayVcCThlylRae0A7aV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gFwJvBud; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9995562a0so2831250b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748775; x=1716353575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5tTRlvba6F46bSw0/iKQNOrZ3zzLqHwL6ZR5s0u92w=;
        b=gFwJvBud17XRfgk+BLZeJA3VIx8iE6DD6FKK3LMNFHrodTKObiXPF19DKMHS5lOmPB
         qNs8+5gRYIThs3SoVepQ1WgAAzJSbreSHrqKZT+1ATfQYttbLqbXD8tAG7wNSX0Y88P2
         PkOzlF6AZIrM7mxcWDEaUQCS6p93FdPHhdS2bR92KlHTTY3m0MaUemPPPFAVRCMvc5BP
         +Nb5t7CxVcTD/ddz3/KBDlNZm7xb0zueL4x/Q41G3svp939n0zjFuFhezvFftTLFzWyL
         h7a4Ds+ZYvg9BVJ7gIOHZZAAKtPkwSJ5myDKgjdYfwoZdTq8YOAvDCcLB8HOMerJikHg
         ctNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748775; x=1716353575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5tTRlvba6F46bSw0/iKQNOrZ3zzLqHwL6ZR5s0u92w=;
        b=ABsM7anJotny6u3VvQshKuX/3t5D+cnVz0vTRvY1ZS35qWA9KRpFLoJ5H6jroKJHdX
         Vys31hCMqhWJqbFkFaODbuzdfe6/7Bs786dVX9HnMNOTpCg20h24ZLbaaKEpnQl5EbKD
         JH4n0oZ5MwuDAIt4WQdQQwwdLAiIE2i+nH6wg0u22XgRBTmsaEr+bZEjq/SYg7seczTn
         Gophy7gVXbESH8KSG1xM4eT1rK5I1D2QLVuTMI41vE67PLMtuOgGXH5SOR+zrbPv+pxv
         GfDdhU9J4p+RWgVs2Hv2iwFNf6Yjp3CDKfSmIiSYzhty2PENQIbpQnafgxyiTWCcXGg8
         8LBA==
X-Forwarded-Encrypted: i=1; AJvYcCUd5qLcBxya50kTbOW4XA05Vi1nRihhXWWj4tja7BP6HSPGZMKKOOYLBRv42Fhdtvma4ljevfr/2IrdydPRfxcy4LHQ420FmoMMZ2tb
X-Gm-Message-State: AOJu0Ywe2e+Dt5QxCdWRZ3NiCI4kwF1HfvPpbsV/n27SydUfC6Py5QTY
	kCqqgO1hk2qPvMxgkHXnzS/1w6v2aOBMMRciidhNqsqK5zHgfvk7lw/M4Bc1Oh0=
X-Google-Smtp-Source: AGHT+IHYqmmOj/jm6/YE87uOWnTTJmdQU5S5Y09QrP2XqrtjcVjmfsAKRuT5+JOGOfU1YuvVdxDGCA==
X-Received: by 2002:aca:2806:0:b0:3c9:66f2:69c0 with SMTP id 5614622812f47-3c9971d9509mr14382791b6e.55.1715748774095;
        Tue, 14 May 2024 21:52:54 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:53 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 28/31] Staging: rtl8192e: Rename variable IsQoSDataFrame
Date: Tue, 14 May 2024 21:52:25 -0700
Message-Id: <20240515045228.35928-29-tdavies@darkphysics.net>
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

Rename variable IsQoSDataFrame to is_qos_data_frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 9b0a981f6f22..36a734ded7dc 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -625,7 +625,7 @@ EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 {
 	if (ieee->ht_info->current_ht_support) {
-		if ((IsQoSDataFrame(pFrame) && frame_order(pFrame)) == 1) {
+		if ((is_qos_data_frame(pFrame) && frame_order(pFrame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
 		}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ca69bb0965ba..e2695beaf582 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -340,7 +340,7 @@ enum rt_op_mode {
 #define	FC_QOS_BIT					BIT(7)
 #define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
 #define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
-#define IsQoSDataFrame(pframe)			\
+#define is_qos_data_frame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
 #define frame_order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index fe72149aa81c..976e8b4da1d4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1322,7 +1322,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 
 	/* Get TS for Rx Reorder  */
 	hdr = (struct ieee80211_hdr *)skb->data;
-	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
+	if (ieee->current_network.qos_data.active && is_qos_data_frame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1)) {
 		TID = frame_qos_tid(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1aeb207a3fee..b1bde5c0050a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -275,7 +275,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
-	if (!IsQoSDataFrame(skb->data))
+	if (!is_qos_data_frame(skb->data))
 		return;
 	if (is_multicast_ether_addr(hdr->addr1))
 		return;
@@ -472,7 +472,7 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	if (is_multicast_ether_addr(dst))
 		return 0;
-	if (IsQoSDataFrame(skb->data)) {
+	if (is_qos_data_frame(skb->data)) {
 		struct tx_ts_record *ts = NULL;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), dst,
-- 
2.30.2


