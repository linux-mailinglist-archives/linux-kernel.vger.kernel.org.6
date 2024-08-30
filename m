Return-Path: <linux-kernel+bounces-307930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07D965513
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171BF1F2183D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980514C59B;
	Fri, 30 Aug 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mUplYA/8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F799135417
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983516; cv=none; b=csl4JirBrYLUPvgMDMbgoEmOoxoQOdQUtEKUN2IiVZh3/2FUTt+mcGUDbbQ6v/Z7EzUF5xkSLsTla5Wl5ktqejaKhcngchgEIVVnjTgRIwTWQJiMI0O3ATchmx9T1/wo+/AGBPqIjjrkBo+3e3mdRoSgnG6imz5RYpkbT+h0g8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983516; c=relaxed/simple;
	bh=RbULwptBNsQzLDugQEUPGZRs+tEtmEkTlsEW1ExqCd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tn+noX5wja7QRqfl8lBvqglBcDj8uwotzKJ0bEd6u6KXoZaAvFKsyn7BYPWfGKcXAJWVH6MehKvhnBXpbVnS10ztorx5ZnAZSjeW0y0EdPchu4GsZ8F05dF4TI+qfK5Wzuoex0zZMFjJa4WrHa5Aw4qohZsOpY/6OP5G70guiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=mUplYA/8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fba05363so11815005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724983514; x=1725588314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsD9LbYpzmdL2ZeNCROIWLwhmARjVZHTeH3nqMJ/Ph0=;
        b=mUplYA/8LE+/0gNjuon7dUSqhK5kKfl+yynvwGObX7NTzGXkcZmMJVEvHiIIxI0qAB
         SbQXFHzWZeIWxRFolGeUkBGamxvAHK/L+Ro5/ii/ZWShLqkiKSUHLcZJxm4M0XYvvJrn
         63jJAM2xxawcnHE+okcnxNpGnbiwYWSK9tLt1djGOkLs5N4OhbqSDdHOMSJbyhldz9E9
         vEC9Cip0/gUNkD8rqDQ4SJo84O54D7sFFJ7sNJdZDOohj6toes55rLKqQ+LHrQVyy5hw
         M6AWh7cVbroSddF1lI3Y+6dlDiY+RujqaBerRpiI47uRDAcUbcO37fW9eAvkWCYbUmut
         6A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983514; x=1725588314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsD9LbYpzmdL2ZeNCROIWLwhmARjVZHTeH3nqMJ/Ph0=;
        b=pcpSZN9CcQ5VxqFbCkSwRDiFDlqU9OFT2CZCqhn/ZjddwlcKmWqKmnw+7Q1qdVSZKe
         6Im8Pn0UpgEK9iHoXkoAPouyZxq7cnTuJJckXSs439QrkVVhf5TR0ydFTegB3lQKCtwi
         A6RAQkp2/CzeE3A45WqdQa/8SKatIBIxNi/o1bYbmOG4NfOM6auGxuthtwM7eYB18OQ5
         5AlSHJFvmn8x32KYa60oAxJmhGBr0sLxqS9FlhlsVAtOj6XPU8zzjb41QG2Gz2aHn720
         UeldQ3O9hZuVfIyVYYH9jvn2VIC0NegjuHR0C3wN+XAe21NuuK1zvrOu/fwRDjUrriKC
         07yg==
X-Forwarded-Encrypted: i=1; AJvYcCU4DIu6fYX1o8YPtHBV78vvHH6PSXpJ4csK2p2nycAND97giAyB+iCraTHduNgC8GNiNW1m0Sbt7+36KsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJkXj0GHFbC95v5aAfOkKItz2T9lwj5S4PqHJZqMcNnKUXxo0
	cfa2I8YXzOr49BGBdp5D8tEVHOnuFiEHY6ojXoN+iIgn9KhC8X+p9tqf9QASLTs=
X-Google-Smtp-Source: AGHT+IEbrhKrkG/YPfdNtcnK7FFbWYMk2XQ5TxnLnCiZ/69HTpUofKUKGToIshgEqOGqJ9UraCWlfw==
X-Received: by 2002:a17:902:cece:b0:1fc:6901:9c35 with SMTP id d9443c01a7336-2050c23ca2amr57985555ad.20.1724983513650;
        Thu, 29 Aug 2024 19:05:13 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534444sm17643255ad.147.2024.08.29.19.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:05:13 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 3/3] Staging: rtl8192e: Add spaces around operators.
Date: Thu, 29 Aug 2024 19:05:08 -0700
Message-Id: <20240830020508.532945-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240830020508.532945-1-tdavies@darkphysics.net>
References: <20240830020508.532945-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spaces around arithmetic and bitwise operators to improve
readability of the code.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 62 +++++++++++++++----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 76f53b797644..17a6fb565c9d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -339,12 +339,12 @@ enum rt_op_mode {
 
 #define	FC_QOS_BIT					BIT(7)
 #define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
-#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
+#define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0] & FC_QOS_BIT)))
 #define is_qos_data_frame(pframe)			\
-	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
-	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
-#define frame_order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
-#define SN_LESS(a, b)		(((a-b)&0x800) != 0)
+	((*(u16 *)pframe & (IEEE80211_STYPE_QOS_DATA | RTLLIB_FTYPE_DATA)) ==	\
+	(IEEE80211_STYPE_QOS_DATA | RTLLIB_FTYPE_DATA))
+#define frame_order(pframe)     (*(u16 *)pframe & IEEE80211_FCTL_ORDER)
+#define SN_LESS(a, b)		(((a - b) & 0x800) != 0)
 #define SN_EQUAL(a, b)	(a == b)
 #define MAX_DEV_ADDR_SIZE 8
 
@@ -414,13 +414,13 @@ enum _REG_PREAMBLE_MODE {
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
 #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
 
-#define RTLLIB_STATMASK_SIGNAL (1<<0)
-#define RTLLIB_STATMASK_RSSI (1<<1)
-#define RTLLIB_STATMASK_NOISE (1<<2)
+#define RTLLIB_STATMASK_SIGNAL (1 << 0)
+#define RTLLIB_STATMASK_RSSI (1 << 1)
+#define RTLLIB_STATMASK_NOISE (1 << 2)
 #define RTLLIB_STATMASK_WEMASK 0x7
 
-#define RTLLIB_CCK_MODULATION    (1<<0)
-#define RTLLIB_OFDM_MODULATION   (1<<1)
+#define RTLLIB_CCK_MODULATION    (1 << 0)
+#define RTLLIB_OFDM_MODULATION   (1 << 1)
 
 #define RTLLIB_CCK_RATE_LEN		4
 #define RTLLIB_CCK_RATE_1MB			0x02
@@ -507,11 +507,11 @@ struct rtllib_frag_entry {
 
 struct rtllib_device;
 
-#define SEC_ACTIVE_KEY    (1<<4)
-#define SEC_AUTH_MODE     (1<<5)
-#define SEC_UNICAST_GROUP (1<<6)
-#define SEC_LEVEL	 (1<<7)
-#define SEC_ENABLED       (1<<8)
+#define SEC_ACTIVE_KEY    (1 << 4)
+#define SEC_AUTH_MODE     (1 << 5)
+#define SEC_UNICAST_GROUP (1 << 6)
+#define SEC_LEVEL	 (1 << 7)
+#define SEC_ENABLED       (1 << 8)
 
 #define SEC_LEVEL_0      0 /* None */
 #define SEC_LEVEL_1      1 /* WEP 40 and 104 bit */
@@ -696,17 +696,17 @@ union frameqos {
 #define MAX_WPA_IE_LEN 64
 #define MAX_WZC_IE_LEN 256
 
-#define NETWORK_EMPTY_ESSID (1<<0)
-#define NETWORK_HAS_OFDM    (1<<1)
-#define NETWORK_HAS_CCK     (1<<2)
+#define NETWORK_EMPTY_ESSID (1 << 0)
+#define NETWORK_HAS_OFDM    (1 << 1)
+#define NETWORK_HAS_CCK     (1 << 2)
 
 /* QoS structure */
-#define NETWORK_HAS_QOS_PARAMETERS      (1<<3)
-#define NETWORK_HAS_QOS_INFORMATION     (1<<4)
+#define NETWORK_HAS_QOS_PARAMETERS      (1 << 3)
+#define NETWORK_HAS_QOS_INFORMATION     (1 << 4)
 #define NETWORK_HAS_QOS_MASK	    (NETWORK_HAS_QOS_PARAMETERS | \
 					 NETWORK_HAS_QOS_INFORMATION)
 /* 802.11h */
-#define NETWORK_HAS_ERP_VALUE	   (1<<10)
+#define NETWORK_HAS_ERP_VALUE	   (1 << 10)
 
 #define QOS_QUEUE_NUM		   4
 #define QOS_OUI_LEN		     3
@@ -996,8 +996,8 @@ enum rtl_link_state {
 #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
 #define DEFAULT_FTS 2346
 
-#define CFG_RTLLIB_RESERVE_FCS (1<<0)
-#define CFG_RTLLIB_COMPUTE_FCS (1<<1)
+#define CFG_RTLLIB_RESERVE_FCS (1 << 0)
+#define CFG_RTLLIB_COMPUTE_FCS (1 << 1)
 
 struct tx_pending {
 	int frag;
@@ -1288,7 +1288,7 @@ struct rtllib_device {
 	u16 scan_watch_dog;
 
 	/* map of allowed channels. 0 is dummy */
-	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
+	u8 active_channel_map[MAX_CHANNEL_NUMBER + 1];
 
 	int rate;       /* current rate */
 	int basic_rate;
@@ -1486,32 +1486,32 @@ struct rtllib_device {
 /* Uses the channel change callback directly
  * instead of [start/stop] scan callbacks
  */
-#define IEEE_SOFTMAC_SCAN (1<<2)
+#define IEEE_SOFTMAC_SCAN (1 << 2)
 
 /* Perform authentication and association handshake */
-#define IEEE_SOFTMAC_ASSOCIATE (1<<3)
+#define IEEE_SOFTMAC_ASSOCIATE (1 << 3)
 
 /* Generate probe requests */
-#define IEEE_SOFTMAC_PROBERQ (1<<4)
+#define IEEE_SOFTMAC_PROBERQ (1 << 4)
 
 /* Generate response to probe requests */
-#define IEEE_SOFTMAC_PROBERS (1<<5)
+#define IEEE_SOFTMAC_PROBERS (1 << 5)
 
 /* The ieee802.11 stack will manage the netif queue
  * wake/stop for the driver, taking care of 802.11
  * fragmentation. See softmac.c for details.
  */
-#define IEEE_SOFTMAC_TX_QUEUE (1<<7)
+#define IEEE_SOFTMAC_TX_QUEUE (1 << 7)
 
 /* Uses only the softmac_data_hard_start_xmit
  * even for TX management frames.
  */
-#define IEEE_SOFTMAC_SINGLE_QUEUE (1<<8)
+#define IEEE_SOFTMAC_SINGLE_QUEUE (1 << 8)
 
 /* Generate beacons.  The stack will enqueue beacons
  * to the card
  */
-#define IEEE_SOFTMAC_BEACONS (1<<6)
+#define IEEE_SOFTMAC_BEACONS (1 << 6)
 
 static inline void *rtllib_priv(struct net_device *dev)
 {
-- 
2.30.2


