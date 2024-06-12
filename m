Return-Path: <linux-kernel+bounces-210883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E990499D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D524728376B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A684E07;
	Wed, 12 Jun 2024 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="dCkE886t"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD183A14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162576; cv=none; b=h/dOeUpQsKx1jI/ykAxtbvFFczWDB/ec0bvAvjFIGlHF0477c/gkdXWEEMEyO0tfFHceyqRFVCj28HAv3v7l0qCM7VXNkWJEU5MOI7sqQNC8sJJto2QCco5JRPTVjySuTXkg4YiJ8yqIYlZt8VhocUfkKrRozDqf0YcDNj5CaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162576; c=relaxed/simple;
	bh=5lYQdNuUHz8/GTVUO7BqqszIM5H7aPs0vexG3JfhGeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p53Se5yaf7O9CFMIPtE6vxlNZLb6ixUBiCenq2k5UTc0ay30niTmE7hHoWf0bZlUBOg7qjHHhh2LpycgtjLRIM0ZVrrOgDS7fSSvGlgOnhcS5QUJBVNEOZM/jSyP4T2S03Ivts8RaJp6HBLY4ASRYNoQxW+wB90yEJWMrH9gsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=dCkE886t; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b53bb4bebaso3403939eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162573; x=1718767373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmqxGFNhFO/LKAwg0O4NLTkC1jcwbpMGmNWI2cJ3ekw=;
        b=dCkE886tqYHws3YHq4mgxho04rI5/kIJI+zzl/cxnolBESoAgYudrTJYV2Ojtb85oE
         vdTRzXDPbFtHIuc7RIkfQQZjckIQnxeDBwB/ZcobyNmU1P7qVwowMCs14w5lDQV2XARD
         kK7uViO4P5lNkIiiUtVt9N+ENWjZRrAnCp5iK2JgtI2ZDTX3MF5QMsIitz0Mt7IwfOmS
         hF9h3pqJc+ddbxpo92FmwDBT2bQfMDTTBQSOK+e8wqj5s3OnF4kljTVdKqrlNP+sIrsn
         /VEy5DUDdfUuj9bGBTmNcSKL0FOG4WS+VATKxIiuAAD2ezMiGkBPoJ/tWBzU+158lZeN
         mDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162573; x=1718767373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmqxGFNhFO/LKAwg0O4NLTkC1jcwbpMGmNWI2cJ3ekw=;
        b=bZPRQeXW2aAYjqIoF7YW6T49j4pC7xPJ4Ty4ho383rvxDVfHi7nmefZa2qjCfXnTLJ
         Tte3PbZTqjcgVASXveitj4XNVkIHG9SdD8XQq7LJ+JEh05axDJrygT4j+bzFDnizzVue
         LFWe/T9Ms87KsFK0xWkBaAPRO1NCShcBI+Q/Q7fNx7PzqRF2k44UwOuGf9ktBo2oSqV7
         0YDFr3OvnFoqe9V3UAteMO3+2SPLmGYYBI2DhzTCXbHZPRjac+RiVqzXTD1Gsi+ZR8jX
         NjCHHKnjP61QlhyWaL0rlHZv2iuIwfO1nZn44EFbgpt5uIGFsdcVdUQUPVfPTLj0oNPY
         zbAw==
X-Forwarded-Encrypted: i=1; AJvYcCVeBzj2mPZnY5tOW9b1uMcw0f0HmuW8lAiYKnRGx4e9fHskSKA/ysn2RmEX7CwxAY2m8yIFo0vXn1yhGPQRDZk/0cvySuZHLHRAqz6G
X-Gm-Message-State: AOJu0YyaJ6eE1Wm8fBQOO+aJ1g+kinVA4X+GvZJWf/QUaZhnGTlliJPB
	e/Pl0NSCB7qcxDY0MHh4dE/SYcxTRjFG0H3waziXH0++AmhO3tA0PN640VZsXxE=
X-Google-Smtp-Source: AGHT+IETnZqpy9qMIhAYwfn4Ereu8xqT/+82iztRkoZQbUm5OxrUwKu7I9DdD4Qh3UC2mkNl37aCLw==
X-Received: by 2002:a05:6359:1a94:b0:19f:6aab:1af6 with SMTP id e5c5f4694b2df-19f6aab1c6dmr44896855d.5.1718162573092;
        Tue, 11 Jun 2024 20:22:53 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:52 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 24/24] Staging: rtl8192e: Fix alignment to match open parenthesis in rtllib_rx.c
Date: Tue, 11 Jun 2024 20:22:30 -0700
Message-Id: <20240612032230.9738-25-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spaces and tabs to fix warning: Alignment should match open
parenthesis.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update subject prefix with 'Staging: rtl8192e:'
 drivers/staging/rtl8192e/rtllib_rx.c | 37 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 3bff54efe66e..84ca5d769b7e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -55,7 +55,7 @@ static inline void rtllib_monitor_rx(struct rtllib_device *ieee,
 /* Called only as a tasklet (software IRQ) */
 static struct rtllib_frag_entry *
 rtllib_frag_cache_find(struct rtllib_device *ieee, unsigned int seq,
-			  unsigned int frag, u8 tid, u8 *src, u8 *dst)
+		       unsigned int frag, u8 tid, u8 *src, u8 *dst)
 {
 	struct rtllib_frag_entry *entry;
 	int i;
@@ -84,7 +84,7 @@ rtllib_frag_cache_find(struct rtllib_device *ieee, unsigned int seq,
 /* Called only as a tasklet (software IRQ) */
 static struct sk_buff *
 rtllib_frag_cache_get(struct rtllib_device *ieee,
-			 struct ieee80211_hdr *hdr)
+		      struct ieee80211_hdr *hdr)
 {
 	struct sk_buff *skb = NULL;
 	u16 fc = le16_to_cpu(hdr->frame_control);
@@ -143,7 +143,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 		 * should have already been received
 		 */
 		entry = rtllib_frag_cache_find(ieee, seq, frag, tid, hdr->addr2,
-						  hdr->addr1);
+					       hdr->addr1);
 		if (entry) {
 			entry->last_frag = frag;
 			skb = entry->skb;
@@ -155,7 +155,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 
 /* Called only as a tasklet (software IRQ) */
 static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
-					   struct ieee80211_hdr *hdr)
+					struct ieee80211_hdr *hdr)
 {
 	u16 fc = le16_to_cpu(hdr->frame_control);
 	u16 sc = le16_to_cpu(hdr->seq_ctrl);
@@ -181,7 +181,7 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 	}
 
 	entry = rtllib_frag_cache_find(ieee, seq, -1, tid, hdr->addr2,
-					  hdr->addr1);
+				       hdr->addr1);
 
 	if (!entry) {
 		netdev_dbg(ieee->dev,
@@ -202,8 +202,7 @@ static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
  */
 static inline int
 rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
-			struct rtllib_rx_stats *rx_stats, u16 type,
-			u16 stype)
+		     struct rtllib_rx_stats *rx_stats, u16 type, u16 stype)
 {
 	/* On the struct stats definition there is written that
 	 * this is not mandatory.... but seems that the probe
@@ -228,7 +227,7 @@ rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
 
 /* Called by rtllib_rx_frame_decrypt */
 static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
-				    struct sk_buff *skb, size_t hdrlen)
+				 struct sk_buff *skb, size_t hdrlen)
 {
 	struct net_device *dev = ieee->dev;
 	u16 fc, ethertype;
@@ -346,7 +345,7 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 /* this function is stolen from ipw2200 driver*/
 #define IEEE_PACKET_RETRY_TIME (5 * HZ)
 static int is_duplicate_packet(struct rtllib_device *ieee,
-				      struct ieee80211_hdr *header)
+			       struct ieee80211_hdr *header)
 {
 	u16 fc = le16_to_cpu(header->frame_control);
 	u16 sc = le16_to_cpu(header->seq_ctrl);
@@ -404,7 +403,7 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 }
 
 static bool add_reorder_entry(struct rx_ts_record *ts,
-			    struct rx_reorder_entry *pReorderEntry)
+			      struct rx_reorder_entry *pReorderEntry)
 {
 	struct list_head *list = &ts->rx_pending_pkt_list;
 
@@ -521,8 +520,8 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 }
 
 static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
-				    struct rtllib_rxb *prxb,
-				    struct rx_ts_record *ts, u16 SeqNum)
+				       struct rtllib_rxb *prxb,
+				       struct rx_ts_record *ts, u16 SeqNum)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *pReorderEntry = NULL;
@@ -1911,7 +1910,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 		switch (info_element->id) {
 		case MFIE_TYPE_SSID:
 			if (rtllib_is_empty_essid(info_element->data,
-						     info_element->len)) {
+						  info_element->len)) {
 				network->flags |= NETWORK_EMPTY_ESSID;
 				break;
 			}
@@ -2190,10 +2189,10 @@ static inline int rtllib_network_init(
 	network->wzc_ie_len = 0;
 
 	if (rtllib_parse_info_param(ieee,
-			beacon->info_element,
-			(stats->len - sizeof(*beacon)),
-			network,
-			stats))
+				    beacon->info_element,
+				    (stats->len - sizeof(*beacon)),
+				    network,
+				    stats))
 		return 1;
 
 	network->mode = 0;
@@ -2559,7 +2558,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 			schedule_work(&ieee->ps_task);
 	} else if (ieee80211_is_probe_resp(header->frame_control)) {
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
-		rtllib_process_probe_response(ieee,
-			      (struct rtllib_probe_response *)header, stats);
+		rtllib_process_probe_response(ieee, (struct rtllib_probe_response *)header,
+					      stats);
 	}
 }
-- 
2.30.2


