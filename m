Return-Path: <linux-kernel+bounces-210874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897DF904994
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F051F24780
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619F7EF0C;
	Wed, 12 Jun 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="H3dFIRgE"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47C6F077
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162568; cv=none; b=JGKqpkTug5zEfNp1nw/Yp8mtuYNvXPmUgATTjLB3Pq19r3oYRxpMuVj/kIuT7A27Pz+BTBcVOLm9o0tDE4FQb07gwDL5RjJ7Q7632v84O9Ct0lDJlghfyin/iIUnQK2ktnEFd5OvcDY22akxnxb/5ohseyqD58O/kYi9neFf2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162568; c=relaxed/simple;
	bh=ntP5CddFKzxSIvMkfKkjwYRPCYeJfHWhrugRVal2F7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zk6K1WxENoMWqVDv9CRD96k36XtWe2zYcAZY9mmNfUi7iUArnzIXJzSGjxyuONHV6WPhy22/qvi0RYZziOh/oRBJJJDe+r2wLe6sp7lh8G7GfMjtA7pL3gt6w0csaDgbYMCyJvIIRP69pv1tYFqst3/xDJPNskyx3fGkULYuYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=H3dFIRgE; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5baf982f56dso1714077eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162566; x=1718767366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCKBtGjcOvea+CqwVQjR7UgfHciXiKLeVB+o0+sSG38=;
        b=H3dFIRgEOCPv+BExN29HbuIbFL2rXcjd75OAH9KEdSMqnU83YrKvY59JQ8NkXBQ0zZ
         y3GIK1xU2FlWY2hCcQZmBrtCZ0iUl70f2QY6jwdaOI8DVs3JALX+ZjitUxZx2etvtgNa
         ju0rOlZVZYqZ3qg+To3LGAuvAbE9+M5+SpFqrfbqqROuxqEchtFY15oUOkQTeyFBdPWK
         cIFriZC9ghaLJx7GakWMO7PdPhluh40GZ8BSR47LvLWeaMy7cCS4KQhvEPcl1kmF0zHU
         CJP9XkF2ajggyCFKHK5VZ7XGb5yj6t3+MlzexZJA67YXGFIzXVEppXN9vZXNXj1vuLce
         ZV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162566; x=1718767366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCKBtGjcOvea+CqwVQjR7UgfHciXiKLeVB+o0+sSG38=;
        b=gYowIVdxZBgbnd7ygtcfk7Xk6uRGe/F7Kkv1s1gqYwOyu0IJY1s8zHLQQk6E6rDBwf
         Gsyv/Go9V5jPLrfLga0B5SqQXhSosd95AtCw8eiq725e2dgDmzTGAC0dTSK51et9BfDO
         hRsTy0PQh9cAAxBBe68lKyOqItOmPZVhv1/epNj4GNzNQTUV1V2Q7Jh1Bezgm8Jaax4R
         vaMeHYAp3Rc3VsqNL4NmewCIt1+ozR0Fgc3cs+VipwTAGLE2+FR3BXj4Jl5/uscbDJFX
         j0xNouZsvFk8ap1xKCN5L+uBVr50oTD2CDV15e2HJ2CIA0OXXKrUclLm3zRwJfoWyKGc
         iaMg==
X-Forwarded-Encrypted: i=1; AJvYcCVzO0Jnn1PhIQ/3wj1UYmFgeXuwsLXkw8rmJ3y2IHnYCVUtbFY09LU0SMTnWglejj+y7AuKMrDNoczqMk++C6r4E/QBvKAXEGSw1Z8L
X-Gm-Message-State: AOJu0YzN+7Mtsoo/jLT2/VcV0FRRNZYEx7NBYVaB44X1O5cmteUlmpzK
	6V0f+/dah7sKj0gMJP1Q/EZf6YM9in27cTmWZcgROIWoV9TBfWZwhOd+dTpQeaM=
X-Google-Smtp-Source: AGHT+IEq2ayhxxtHGON6heGtAGEhhMCRP+iqH2sPnHGV3IfxIOg0c3o/rSjd+rEweEURdDIj0r7y5w==
X-Received: by 2002:a05:6358:914c:b0:19f:1e0c:e1a3 with SMTP id e5c5f4694b2df-19f69d7b6dbmr94139655d.22.1718162565777;
        Tue, 11 Jun 2024 20:22:45 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:44 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 15/24] Staging: rtl8192e: Fix alignment to match open parenthesis
Date: Tue, 11 Jun 2024 20:22:21 -0700
Message-Id: <20240612032230.9738-16-tdavies@darkphysics.net>
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

Added tabs and spaces to fix warning:
Alignment should match open parenthesis

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib_tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 6514d53c9679..24ae90915b10 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -290,7 +290,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 		return;
 	if (ht_info->current_ampdu_enable) {
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), hdr->addr1,
-			   skb->priority, TX_DIR, true)) {
+				   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
 			return;
 		}
@@ -420,7 +420,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			u8 ht_op_mode = ht_info->current_op_mode;
 
 			if ((ht_info->cur_bw_40mhz && (ht_op_mode == 2 ||
-						      ht_op_mode == 3)) ||
+						       ht_op_mode == 3)) ||
 			     (!ht_info->cur_bw_40mhz && ht_op_mode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->rts_enable = true;
@@ -476,7 +476,7 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 		struct tx_ts_record *ts = NULL;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), dst,
-			   skb->priority, TX_DIR, true))
+				   skb->priority, TX_DIR, true))
 			return 0;
 		seqnum = ts->tx_cur_seq;
 		ts->tx_cur_seq = (ts->tx_cur_seq + 1) % 4096;
@@ -548,8 +548,8 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	 * creating it...
 	 */
 	if (!(ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE) ||
-	   ((!ieee->softmac_data_hard_start_xmit &&
-	   (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)))) {
+	    ((!ieee->softmac_data_hard_start_xmit &&
+	     (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)))) {
 		netdev_warn(ieee->dev, "No xmit handler.\n");
 		goto success;
 	}
-- 
2.30.2


