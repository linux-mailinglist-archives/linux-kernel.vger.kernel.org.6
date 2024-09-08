Return-Path: <linux-kernel+bounces-320372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E5970971
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF918281B2D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474F17A5BE;
	Sun,  8 Sep 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="B2HBznQW"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022031779AE
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823601; cv=none; b=rxRFr5gM7z4+5LoSDqPMXNuH6pflLbxokGJnFUvh1MiN7twD/k1Id/wfchgFEvQH60iVgi6nhOe21DPR2a87XseWCwRM8Vu3U7ky5MDmU+DWp+/ZFVcvtE/SEdKcdKucj6n5Mo6uTPa5GvQwg/LyOMzo8kaJ+faqKpKFbykuH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823601; c=relaxed/simple;
	bh=xScMRekyrWd3mUiQ7E0L3/MfqmlH5JFDA/Bn1zYmYeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABUo+pIM4E8okqbeHNs5acWgjhVwjZIh5fMXJ0CTDJS8h/zBiCXq0fHxd4XgpFWwLa1KLasU+vtEvnbSL3L7GbbYZ3UniuxMmRs3Bt+5gUI0WUhbgTs6YYKU3pjeCUdxMu6UbtYMiFEHLkzOw34Mc9usIvnLqjCVx+ZBm9fA+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=B2HBznQW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20551eeba95so32318935ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823597; x=1726428397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwXZUX4Z+vcVxrrhy8ieqDIViAshGkVvuwYrqufxEM4=;
        b=B2HBznQWyz8ueMNeFcHTmZ+k+fHlcegA5fCewRcbQRNEU/eJ/UDc9z0t9GOPua7y/c
         oK/exqWa4Ba153+xw9GCCrNqFbkPMuMFbJQgeuhoXCxsmCL1gmt9AUYb/jvsXXyHob4s
         3YpWudRQqrYkCI0X+vB4fIQ649/gxMLIfFaiC/fSRT2wr/3Pw42//Y4adtPl2XBTbVEZ
         Fh4GUazCMu3l/ZAgwnx83jyElyQgF34gidugfdM3y2qjpVZ0NQ2SfHOXxrBubM/KR28O
         c1s96p9s4hoi0KSCzV9jAbuCs9nLj4xnIp5nmAhcFEf/Z6DGcTCYG9qJS5fowgdrmxH5
         vmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823597; x=1726428397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwXZUX4Z+vcVxrrhy8ieqDIViAshGkVvuwYrqufxEM4=;
        b=AVE4t7VO6dsBdfTx/bpSLYbdrPMtTX1oslD1AcZ1z6+P86M4/GygGJ1ewyYA2h1bFD
         I/HCipMoSg9m7YZTey5tvOCUOYgygVY/DcgQYkieRnOHhaRHxToKFteXwz0kCyIp+xAk
         bqT+LQPjzaAcBNhyOScxUts+F34kMnXfhgJKfgixjbROL8rm70gVsh1ZXsoylPC1HYpY
         2NJOHHvYNjeOzRMbXHyHlUE4i7JZ7sM6SfzFUh3S1bYD2stlnOHS0QRuXRyfdxYDn0KY
         8qBdyLAHwW9yjIng/47DdpSPpXwV+bM93iWBb1t8b4f/XIWwz62PE2brqbMNBkGuClWL
         bExw==
X-Forwarded-Encrypted: i=1; AJvYcCW6XTid2vGzItVvFWXESKwZ/q9lFk0jtZBxB4SzxKMjRc/QcxJbZqeJwJHGmC4JKUlvgVNe9gDZtKm3WsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifkVuDMvdF8eFnf3tgH/datJ0Ig6l95D5bP4cySv5R6yGY2C7
	0rZesZOXrBE2M3YOC+ljhpFG1jXU6ZnVJWrxpvwo26i5+Wf5R1FU9FBYXbjhAtc=
X-Google-Smtp-Source: AGHT+IFqoRo27AOGROybqNX+oapincC/8GNKCPEbxqvSBUXbpCpbzrJ22xGg5K4nn2C0xHkwKlFINQ==
X-Received: by 2002:a17:902:ce81:b0:1fb:1afb:b864 with SMTP id d9443c01a7336-206f049d07amr77361585ad.5.1725823597113;
        Sun, 08 Sep 2024 12:26:37 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:36 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/16] Staging: rtl8192e: Rename variable pReorderEntry
Date: Sun,  8 Sep 2024 12:26:18 -0700
Message-Id: <20240908192633.94144-2-tdavies@darkphysics.net>
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

Rename variable pReorderEntry to reorder_entry
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 20 +++++------
 drivers/staging/rtl8192e/rtllib_rx.c      | 44 +++++++++++------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ed6a488bc7ac..abdae7e36588 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -14,7 +14,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	struct rtllib_device *ieee = container_of(ts, struct rtllib_device,
 						  rx_ts_records[ts->num]);
 
-	struct rx_reorder_entry *pReorderEntry = NULL;
+	struct rx_reorder_entry *reorder_entry = NULL;
 
 	unsigned long flags = 0;
 	u8 index = 0;
@@ -23,31 +23,31 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 	if (ts->rx_timeout_indicate_seq != 0xffff) {
 		while (!list_empty(&ts->rx_pending_pkt_list)) {
-			pReorderEntry = (struct rx_reorder_entry *)
+			reorder_entry = (struct rx_reorder_entry *)
 					list_entry(ts->rx_pending_pkt_list.prev,
 					struct rx_reorder_entry, list);
 			if (index == 0)
-				ts->rx_indicate_seq = pReorderEntry->SeqNum;
+				ts->rx_indicate_seq = reorder_entry->SeqNum;
 
-			if (SN_LESS(pReorderEntry->SeqNum,
+			if (SN_LESS(reorder_entry->SeqNum,
 				    ts->rx_indicate_seq) ||
-			    SN_EQUAL(pReorderEntry->SeqNum,
+			    SN_EQUAL(reorder_entry->SeqNum,
 				     ts->rx_indicate_seq)) {
-				list_del_init(&pReorderEntry->list);
+				list_del_init(&reorder_entry->list);
 
-				if (SN_EQUAL(pReorderEntry->SeqNum,
+				if (SN_EQUAL(reorder_entry->SeqNum,
 				    ts->rx_indicate_seq))
 					ts->rx_indicate_seq =
 					      (ts->rx_indicate_seq + 1) % 4096;
 
 				netdev_dbg(ieee->dev,
 					   "%s(): Indicate SeqNum: %d\n",
-					   __func__, pReorderEntry->SeqNum);
+					   __func__, reorder_entry->SeqNum);
 				ieee->stats_IndicateArray[index] =
-							 pReorderEntry->prxb;
+							 reorder_entry->prxb;
 				index++;
 
-				list_add_tail(&pReorderEntry->list,
+				list_add_tail(&reorder_entry->list,
 					      &ieee->RxReorder_Unused_List);
 			} else {
 				pkt_in_buf = true;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d7d59761e0f4..cba4b244f808 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -403,26 +403,26 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 }
 
 static bool add_reorder_entry(struct rx_ts_record *ts,
-			      struct rx_reorder_entry *pReorderEntry)
+			      struct rx_reorder_entry *reorder_entry)
 {
 	struct list_head *list = &ts->rx_pending_pkt_list;
 
 	while (list->next != &ts->rx_pending_pkt_list) {
-		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
+		if (SN_LESS(reorder_entry->SeqNum, ((struct rx_reorder_entry *)
 		    list_entry(list->next, struct rx_reorder_entry,
 		    list))->SeqNum))
 			list = list->next;
-		else if (SN_EQUAL(pReorderEntry->SeqNum,
+		else if (SN_EQUAL(reorder_entry->SeqNum,
 			((struct rx_reorder_entry *)list_entry(list->next,
 			struct rx_reorder_entry, list))->SeqNum))
 			return false;
 		else
 			break;
 	}
-	pReorderEntry->list.next = list->next;
-	pReorderEntry->list.next->prev = &pReorderEntry->list;
-	pReorderEntry->list.prev = list;
-	list->next = &pReorderEntry->list;
+	reorder_entry->list.next = list->next;
+	reorder_entry->list.next->prev = &reorder_entry->list;
+	reorder_entry->list.prev = list;
+	list->next = &reorder_entry->list;
 
 	return true;
 }
@@ -524,7 +524,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				       struct rx_ts_record *ts, u16 SeqNum)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
-	struct rx_reorder_entry *pReorderEntry = NULL;
+	struct rx_reorder_entry *reorder_entry = NULL;
 	u8 win_size = ht_info->rx_reorder_win_size;
 	u16 win_end = 0;
 	u8 index = 0;
@@ -598,25 +598,25 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	} else {
 		/* Current packet is going to be inserted into pending list.*/
 		if (!list_empty(&ieee->RxReorder_Unused_List)) {
-			pReorderEntry = (struct rx_reorder_entry *)
+			reorder_entry = (struct rx_reorder_entry *)
 					list_entry(ieee->RxReorder_Unused_List.next,
 					struct rx_reorder_entry, list);
-			list_del_init(&pReorderEntry->list);
+			list_del_init(&reorder_entry->list);
 
 			/* Make a reorder entry and insert
 			 * into a the packet list.
 			 */
-			pReorderEntry->SeqNum = SeqNum;
-			pReorderEntry->prxb = prxb;
+			reorder_entry->SeqNum = SeqNum;
+			reorder_entry->prxb = prxb;
 
-			if (!add_reorder_entry(ts, pReorderEntry)) {
+			if (!add_reorder_entry(ts, reorder_entry)) {
 				int i;
 
 				netdev_dbg(ieee->dev,
 					   "%s(): Duplicate packet is dropped. IndicateSeq: %d, NewSeq: %d\n",
 					   __func__, ts->rx_indicate_seq,
 					   SeqNum);
-				list_add_tail(&pReorderEntry->list,
+				list_add_tail(&reorder_entry->list,
 					      &ieee->RxReorder_Unused_List);
 
 				for (i = 0; i < prxb->nr_subframes; i++)
@@ -653,12 +653,12 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev, "%s(): start RREORDER indicate\n",
 			   __func__);
 
-		pReorderEntry = (struct rx_reorder_entry *)
+		reorder_entry = (struct rx_reorder_entry *)
 					list_entry(ts->rx_pending_pkt_list.prev,
 						   struct rx_reorder_entry,
 						   list);
-		if (SN_LESS(pReorderEntry->SeqNum, ts->rx_indicate_seq) ||
-		    SN_EQUAL(pReorderEntry->SeqNum, ts->rx_indicate_seq)) {
+		if (SN_LESS(reorder_entry->SeqNum, ts->rx_indicate_seq) ||
+		    SN_EQUAL(reorder_entry->SeqNum, ts->rx_indicate_seq)) {
 			/* This protect struct buffer from overflow. */
 			if (index >= REORDER_WIN_SIZE) {
 				netdev_err(ieee->dev,
@@ -668,18 +668,18 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				break;
 			}
 
-			list_del_init(&pReorderEntry->list);
+			list_del_init(&reorder_entry->list);
 
-			if (SN_EQUAL(pReorderEntry->SeqNum, ts->rx_indicate_seq))
+			if (SN_EQUAL(reorder_entry->SeqNum, ts->rx_indicate_seq))
 				ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) %
 						     4096;
 
-			ieee->prxb_indicate_array[index] = pReorderEntry->prxb;
+			ieee->prxb_indicate_array[index] = reorder_entry->prxb;
 			netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n",
-				   __func__, pReorderEntry->SeqNum);
+				   __func__, reorder_entry->SeqNum);
 			index++;
 
-			list_add_tail(&pReorderEntry->list,
+			list_add_tail(&reorder_entry->list,
 				      &ieee->RxReorder_Unused_List);
 		} else {
 			pkt_in_buf = true;
-- 
2.30.2


