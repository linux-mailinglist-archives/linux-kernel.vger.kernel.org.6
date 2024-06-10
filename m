Return-Path: <linux-kernel+bounces-207687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78129901A76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D6A1F22DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC887AE5D;
	Mon, 10 Jun 2024 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jqdECGfy"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA78770E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998556; cv=none; b=CMkrgzd/mXAPApCEN/VX+0I5udO15d1likgvGKsZqdnioVeRi/CLBPBvDZUY5Obg6kMkgpyYHDZ810VByl0fek3ipDHDrlP3CLIsXEq1h+Y4HXrW3ICg26UQuZ6wFRW1cSTIkbPpGn0aa1hg1VhU7oXFEM8bOkA+744I75xLPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998556; c=relaxed/simple;
	bh=Ub3Lz0kq9cHw6ETMzkkSWol05hUKiUw5VODOBEyT3U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTlzIBD4WPT9/cndG7qON8fBPorFu7VgG+sAZRArDNBmZSIZ98kjMTRHkcgSKW8bBx7zWfNqUkfnVLrJeg0Rc1OrfeuiblpbA+NyaVXSL0S8qVepKbNk7XAgfZYNEPAsljZYHnDKI4nVx10TwIrc5uCNOp1rsSoG1aIUqsT3T+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jqdECGfy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e5fd488d9fso1581988a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998554; x=1718603354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qwAwpwAO53f9qqkevNifntO2vA4QwFToDUZm0Cm1rw=;
        b=jqdECGfybB65MgaRi05TqpCBPod7EQ7K5VoUbFeC6BVVkEjqZWtYte+qLSmzs7gwGv
         74bb87kAwAWLa9KtivIjJutIz7jC7jUEcSRxNyjN5Cwhskd+smXfLwKylYkTJ0R0Kz2r
         eocGx2ciWaF3H4ngt3l27Ok3LtCo+Z/lEaxYFbxiRxEzwkys3s36iA9HPJmmQceT9h1Q
         iTe6dCd+R5I1eJyuRZw50hjRnes7pR9cFNxvL4sgqAbGwtF/hhTysO5A2nLg1gEXjT7e
         7MRE9PDX5wUVAe0TF7kqgvKsGmV8YRdzM6o2A8tzAlHbuUHHUadtG9geWmZ73Pch4GoC
         qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998554; x=1718603354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qwAwpwAO53f9qqkevNifntO2vA4QwFToDUZm0Cm1rw=;
        b=ZAZL+3pevS+7kg0BJU672ujb6HSFrOJ0FJfGraJQOD5F+i7YXfBV1E5MBAehtANmbv
         JN+CPNsZp0VJTUaefEXni6OVzcR6lsHYQBlYo91aQP17DyBEFpRHR4/SlR67537Z1eI9
         ZO/KYoYcF1JlcW/tUA4Sqx6u5DA3cnVALiyGHzd5cxeZ35Airm9zGwLaSqzO5Te4Z86u
         xjiKzGd1oYGiIydevvWZBITVDLPG6Ax31xX+lb6XsAsVW4VaNoPS3GAa0HNaAa4QDBEn
         mGpsiJoQNWtyBUfqoOLhNsX07pl/V5l1HrVQEj2pe+RotAgUZC4kdaewrwkt87pm90X9
         QNig==
X-Forwarded-Encrypted: i=1; AJvYcCUCT2c1no6HzmwweaJ7dMdNTygu4kJOoKDrPwsGdGJvHPa92sgglPhJ57AE8G2O8JvG3b9L0LdrXYC5p01HBf1m+9TlYXIc0TeRf3pX
X-Gm-Message-State: AOJu0YyvZPuhNQ7xbzKX2mSSZBauADFiH7s3tUQjP36IfbRixSZ+6Gkn
	1KmT3rU25mIsCoyWVM+cSf3AzIW9Rw8XQe3jo+7/uzqES3rt4CiXNUUKR+TnvdM=
X-Google-Smtp-Source: AGHT+IEUw/U3OnyhXA7ievG+0D9kzPU25F5Qw1FTMYAMu+V5k7NBOPn2j3m23QPFcoHAwSMih4rZqA==
X-Received: by 2002:a17:902:c085:b0:1f6:828e:869b with SMTP id d9443c01a7336-1f6d036a7dcmr88522475ad.53.1717998554393;
        Sun, 09 Jun 2024 22:49:14 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:14 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 24/24] Fix space/tab alignment to match open parenthesis in rtllib_rx.c
Date: Sun,  9 Jun 2024 22:44:49 -0700
Message-Id: <20240610054449.71316-25-tdavies@darkphysics.net>
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

Add spaces and tabs to fix warning: Alignment should match open
parenthesis.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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


