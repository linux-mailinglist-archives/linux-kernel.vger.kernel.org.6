Return-Path: <linux-kernel+bounces-320374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4DF970973
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2E1C20A96
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5617BB17;
	Sun,  8 Sep 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="U1wshDkC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537E17839E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823602; cv=none; b=BbP4dFmMhPe2HS2XKu4I+/eU6tT82n6OLH4GX2tkO9X9vjbKmU1AAO2dIIXfNdS7Ha0hhfmMa+Y2G/0+tfTghlNF1W9Oz7r+bRzbHY942mJTGoFtQBx8STJvQ3GzJjBo58Ag4vtSO6IoNrf8bwes2coe7wfiRXljlf2b9Di9ZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823602; c=relaxed/simple;
	bh=nnxSeJG1du5Z643YEwdX5f5Vtc1/2IdyblEz7jkp4yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Enps81W7Zpugs/HNVPo5O0rTrAoYG4/UIAW4VnYbSceBcU/HMfFafsT9mpCYaxpOmNsfLefnd0r9fBJ4WS3bVJhyKuw/BvlY2K/L0RSQdjLNx3pv/SMueFx1+GNMZvEEN5n40CzF7lnAHSPkoC0JYFuQYb+dvEBTIN4CWI5V9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=U1wshDkC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20543fdb7acso25379925ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823599; x=1726428399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KFmE8ZulfeBSFNzpno4ob0I7YnPxB69tGPDL4yyv3E=;
        b=U1wshDkC0oumaURVKLje5B6MSX7o5caWlKqeZ6XQKQleffGbl16oy1NHPMmiZAF1/I
         Ng2T6sWW6byw4P16AsUHP5ZO/mUw7Y0hIvG8Hc3XN6wU7VTgpJXLS0Q4LBRdRZsj92PL
         cF3U1QLAcO9zQbj7BHYaSQNP6wjO7QfDZZ8GRSl3jl/F62cm7CY/RudqF1OIyje78eM2
         aC/3k9qox9SKEPzxo0OWSxK7gUIKTTwX09Zx5RLo2VT7KgyMFRpXWwKJ2YDqLBbaaPW9
         DM5C80H4Fy0uQVmVIjPcNp1ClvsBN4335m1WPn1DXT2BOvd0NN2vsNhZj/mZeNPrrSsQ
         tfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823599; x=1726428399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KFmE8ZulfeBSFNzpno4ob0I7YnPxB69tGPDL4yyv3E=;
        b=w7MpClfdvUfzvdEn2yAvbG4bnTYn7KkBC2YnKXg99ywKfnqIEGE3KIjbsEHaiiK5Ci
         bySHszKJwmv/hgyq2sCZnU9/o6rijsFekSb8y6DBM2Z0jtxuKUNoqIiTeMTYpikbdNTe
         QBp9Yln1K588fc/drJwIpAQi7F2PbKhpclyXDgw+V7igcEsmI9sRedZmAW5ej0/myW2F
         o7bS945PI9n8K3aj7xjZY9tKPbzHnSwJQnYlO9Vjculkpo8/ldXsx+Qkbs3h7NnfUGDJ
         u1c20t9s3jQojgt1lJ6+nk5sQzV2nxmeJUbYWbtkQDuSICbSaxrAyrkTenOq9u5Svu6W
         5jFg==
X-Forwarded-Encrypted: i=1; AJvYcCWICgNMc9iP1VrYejvYtAZ9EijfTw4VixSbFoM3OKNY7uLagLzys0RU4yvY+89AhnZvsOMtBdSEb9TKOek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9wRb1/JSHsrHJ3kiCgJmZ0Bvvw4mh15YWXH4BxBK70QKAcUZ
	h8DQPGLkWV/QTzAWIQGOrjdeGeM9CDcrzvD/JMkDR4ciqCdvyOO3ZEh2sBJjBnM=
X-Google-Smtp-Source: AGHT+IFvS1aEBHwmx8e4GGbJhqwm4CP0mEI0CwkXQ6mMnwELs5iJUf/tFOkWbnuJ9pDWYSn3VV8rag==
X-Received: by 2002:a17:902:dacc:b0:206:8c4a:7bbb with SMTP id d9443c01a7336-206f065bddbmr87077335ad.58.1725823598394;
        Sun, 08 Sep 2024 12:26:38 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:37 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/16] Staging: rtl8192e: Rename variable SeqNum
Date: Sun,  8 Sep 2024 12:26:19 -0700
Message-Id: <20240908192633.94144-3-tdavies@darkphysics.net>
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

Rename variable SeqNum to seq_num
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 16 ++---
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 78 +++++++++++------------
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index abdae7e36588..18b717a7409c 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -27,22 +27,22 @@ static void RxPktPendingTimeout(struct timer_list *t)
 					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, list);
 			if (index == 0)
-				ts->rx_indicate_seq = reorder_entry->SeqNum;
+				ts->rx_indicate_seq = reorder_entry->seq_num;
 
-			if (SN_LESS(reorder_entry->SeqNum,
+			if (SN_LESS(reorder_entry->seq_num,
 				    ts->rx_indicate_seq) ||
-			    SN_EQUAL(reorder_entry->SeqNum,
+			    SN_EQUAL(reorder_entry->seq_num,
 				     ts->rx_indicate_seq)) {
 				list_del_init(&reorder_entry->list);
 
-				if (SN_EQUAL(reorder_entry->SeqNum,
+				if (SN_EQUAL(reorder_entry->seq_num,
 				    ts->rx_indicate_seq))
 					ts->rx_indicate_seq =
 					      (ts->rx_indicate_seq + 1) % 4096;
 
 				netdev_dbg(ieee->dev,
-					   "%s(): Indicate SeqNum: %d\n",
-					   __func__, reorder_entry->SeqNum);
+					   "%s(): Indicate seq_num: %d\n",
+					   __func__, reorder_entry->seq_num);
 				ieee->stats_IndicateArray[index] =
 							 reorder_entry->prxb;
 				index++;
@@ -336,8 +336,8 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 			pRxReorderEntry = (struct rx_reorder_entry *)
 					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, list);
-			netdev_dbg(ieee->dev,  "%s(): Delete SeqNum %d!\n",
-				   __func__, pRxReorderEntry->SeqNum);
+			netdev_dbg(ieee->dev,  "%s(): Delete seq_num %d!\n",
+				   __func__, pRxReorderEntry->seq_num);
 			list_del_init(&pRxReorderEntry->list);
 			{
 				int i = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4762cb52261a..b033e8345b0a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1015,7 +1015,7 @@ struct bandwidth_autoswitch {
 #define REORDER_ENTRY_NUM	128
 struct rx_reorder_entry {
 	struct list_head	list;
-	u16			SeqNum;
+	u16			seq_num;
 	struct rtllib_rxb *prxb;
 };
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index cba4b244f808..86beac9dd3a5 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -408,13 +408,13 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
 	struct list_head *list = &ts->rx_pending_pkt_list;
 
 	while (list->next != &ts->rx_pending_pkt_list) {
-		if (SN_LESS(reorder_entry->SeqNum, ((struct rx_reorder_entry *)
+		if (SN_LESS(reorder_entry->seq_num, ((struct rx_reorder_entry *)
 		    list_entry(list->next, struct rx_reorder_entry,
-		    list))->SeqNum))
+		    list))->seq_num))
 			list = list->next;
-		else if (SN_EQUAL(reorder_entry->SeqNum,
+		else if (SN_EQUAL(reorder_entry->seq_num,
 			((struct rx_reorder_entry *)list_entry(list->next,
-			struct rx_reorder_entry, list))->SeqNum))
+			struct rx_reorder_entry, list))->seq_num))
 			return false;
 		else
 			break;
@@ -504,8 +504,8 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 		pRxReorderEntry = (struct rx_reorder_entry *)
 				  list_entry(ts->rx_pending_pkt_list.prev,
 					     struct rx_reorder_entry, list);
-		netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n", __func__,
-			   pRxReorderEntry->SeqNum);
+		netdev_dbg(ieee->dev, "%s(): Indicate seq_num %d!\n", __func__,
+			   pRxReorderEntry->seq_num);
 		list_del_init(&pRxReorderEntry->list);
 
 		ieee->rfd_array[rfd_cnt] = pRxReorderEntry->prxb;
@@ -521,7 +521,7 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 
 static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				       struct rtllib_rxb *prxb,
-				       struct rx_ts_record *ts, u16 SeqNum)
+				       struct rx_ts_record *ts, u16 seq_num)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *reorder_entry = NULL;
@@ -533,20 +533,20 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 
 	netdev_dbg(ieee->dev,
 		   "%s(): Seq is %d, ts->rx_indicate_seq is %d, win_size is %d\n",
-		   __func__, SeqNum, ts->rx_indicate_seq, win_size);
+		   __func__, seq_num, ts->rx_indicate_seq, win_size);
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 
 	win_end = (ts->rx_indicate_seq + win_size - 1) % 4096;
 	/* Rx Reorder initialize condition.*/
 	if (ts->rx_indicate_seq == 0xffff)
-		ts->rx_indicate_seq = SeqNum;
+		ts->rx_indicate_seq = seq_num;
 
-	/* Drop out the packet which SeqNum is smaller than WinStart */
-	if (SN_LESS(SeqNum, ts->rx_indicate_seq)) {
+	/* Drop out the packet which seq_num is smaller than WinStart */
+	if (SN_LESS(seq_num, ts->rx_indicate_seq)) {
 		netdev_dbg(ieee->dev,
 			   "Packet Drop! IndicateSeq: %d, NewSeq: %d\n",
-			   ts->rx_indicate_seq, SeqNum);
+			   ts->rx_indicate_seq, seq_num);
 		ht_info->rx_reorder_drop_counter++;
 		{
 			int i;
@@ -561,38 +561,38 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	}
 
 	/* Sliding window manipulation. Conditions includes:
-	 * 1. Incoming SeqNum is equal to WinStart =>Window shift 1
-	 * 2. Incoming SeqNum is larger than the win_end => Window shift N
+	 * 1. Incoming seq_num is equal to WinStart =>Window shift 1
+	 * 2. Incoming seq_num is larger than the win_end => Window shift N
 	 */
-	if (SN_EQUAL(SeqNum, ts->rx_indicate_seq)) {
+	if (SN_EQUAL(seq_num, ts->rx_indicate_seq)) {
 		ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) % 4096;
 		match_win_start = true;
-	} else if (SN_LESS(win_end, SeqNum)) {
-		if (SeqNum >= (win_size - 1))
-			ts->rx_indicate_seq = SeqNum + 1 - win_size;
+	} else if (SN_LESS(win_end, seq_num)) {
+		if (seq_num >= (win_size - 1))
+			ts->rx_indicate_seq = seq_num + 1 - win_size;
 		else
 			ts->rx_indicate_seq = 4095 -
-					     (win_size - (SeqNum + 1)) + 1;
+					     (win_size - (seq_num + 1)) + 1;
 		netdev_dbg(ieee->dev,
 			   "Window Shift! IndicateSeq: %d, NewSeq: %d\n",
-			   ts->rx_indicate_seq, SeqNum);
+			   ts->rx_indicate_seq, seq_num);
 	}
 
 	/* Indication process.
 	 * After Packet dropping and Sliding Window shifting as above, we can
-	 * now just indicate the packets with the SeqNum smaller than latest
+	 * now just indicate the packets with the seq_num smaller than latest
 	 * WinStart and struct buffer other packets.
 	 *
 	 * For Rx Reorder condition:
-	 * 1. All packets with SeqNum smaller than WinStart => Indicate
-	 * 2. All packets with SeqNum larger than or equal to
+	 * 1. All packets with seq_num smaller than WinStart => Indicate
+	 * 2. All packets with seq_num larger than or equal to
 	 *	 WinStart => Buffer it.
 	 */
 	if (match_win_start) {
 		/* Current packet is going to be indicated.*/
 		netdev_dbg(ieee->dev,
 			   "Packets indication! IndicateSeq: %d, NewSeq: %d\n",
-			   ts->rx_indicate_seq, SeqNum);
+			   ts->rx_indicate_seq, seq_num);
 		ieee->prxb_indicate_array[0] = prxb;
 		index = 1;
 	} else {
@@ -606,7 +606,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 			/* Make a reorder entry and insert
 			 * into a the packet list.
 			 */
-			reorder_entry->SeqNum = SeqNum;
+			reorder_entry->seq_num = seq_num;
 			reorder_entry->prxb = prxb;
 
 			if (!add_reorder_entry(ts, reorder_entry)) {
@@ -615,7 +615,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				netdev_dbg(ieee->dev,
 					   "%s(): Duplicate packet is dropped. IndicateSeq: %d, NewSeq: %d\n",
 					   __func__, ts->rx_indicate_seq,
-					   SeqNum);
+					   seq_num);
 				list_add_tail(&reorder_entry->list,
 					      &ieee->RxReorder_Unused_List);
 
@@ -626,7 +626,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 			} else {
 				netdev_dbg(ieee->dev,
 					   "Pkt insert into struct buffer. IndicateSeq: %d, NewSeq: %d\n",
-					   ts->rx_indicate_seq, SeqNum);
+					   ts->rx_indicate_seq, seq_num);
 			}
 		} else {
 			/* Packets are dropped if there are not enough reorder
@@ -657,8 +657,8 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 					list_entry(ts->rx_pending_pkt_list.prev,
 						   struct rx_reorder_entry,
 						   list);
-		if (SN_LESS(reorder_entry->SeqNum, ts->rx_indicate_seq) ||
-		    SN_EQUAL(reorder_entry->SeqNum, ts->rx_indicate_seq)) {
+		if (SN_LESS(reorder_entry->seq_num, ts->rx_indicate_seq) ||
+		    SN_EQUAL(reorder_entry->seq_num, ts->rx_indicate_seq)) {
 			/* This protect struct buffer from overflow. */
 			if (index >= REORDER_WIN_SIZE) {
 				netdev_err(ieee->dev,
@@ -670,13 +670,13 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 
 			list_del_init(&reorder_entry->list);
 
-			if (SN_EQUAL(reorder_entry->SeqNum, ts->rx_indicate_seq))
+			if (SN_EQUAL(reorder_entry->seq_num, ts->rx_indicate_seq))
 				ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) %
 						     4096;
 
 			ieee->prxb_indicate_array[index] = reorder_entry->prxb;
-			netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n",
-				   __func__, reorder_entry->SeqNum);
+			netdev_dbg(ieee->dev, "%s(): Indicate seq_num %d!\n",
+				   __func__, reorder_entry->seq_num);
 			index++;
 
 			list_add_tail(&reorder_entry->list,
@@ -731,10 +731,10 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	bool		is_aggregate_frame = false;
 	u16		subframe_len;
 	u8		pad_len = 0;
-	u16		SeqNum = 0;
+	u16		seq_num = 0;
 	struct sk_buff *sub_skb;
 	/* just for debug purpose */
-	SeqNum = WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
+	seq_num = WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
 	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
 	   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
 		is_aggregate_frame = true;
@@ -796,8 +796,8 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 				    "nRemain_Length is %d and subframe_len is : %d\n",
 				    skb->len, subframe_len);
 			netdev_info(ieee->dev,
-				    "The Packet SeqNum is %d\n",
-				    SeqNum);
+				    "The Packet seq_num is %d\n",
+				    seq_num);
 			return 0;
 		}
 
@@ -1227,7 +1227,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 	struct lib80211_crypt_data *crypt = NULL;
 	struct rtllib_rxb *rxb = NULL;
 	struct rx_ts_record *ts = NULL;
-	u16 fc, sc, SeqNum = 0;
+	u16 fc, sc, seq_num = 0;
 	u8 type, stype, multicast = 0, unicast = 0, nr_subframes = 0, TID = 0;
 	u8 dst[ETH_ALEN];
 	u8 src[ETH_ALEN];
@@ -1321,7 +1321,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 	if (ieee->current_network.qos_data.active && is_qos_data_frame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1)) {
 		TID = frame_qos_tid(skb->data);
-		SeqNum = WLAN_GET_SEQ_SEQ(sc);
+		seq_num = WLAN_GET_SEQ_SEQ(sc);
 		rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
 		      RX_DIR, true);
 		if (TID != 0 && TID != 3)
@@ -1362,7 +1362,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 	if (!ieee->ht_info->cur_rx_reorder_enable || !ts)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
-		rx_reorder_indicate_packet(ieee, rxb, ts, SeqNum);
+		rx_reorder_indicate_packet(ieee, rxb, ts, seq_num);
 
 	dev_kfree_skb(skb);
 
-- 
2.30.2


