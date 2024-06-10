Return-Path: <linux-kernel+bounces-207678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4954901A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E7F1F22095
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E76F319;
	Mon, 10 Jun 2024 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jsvcyUeH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09227558B7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998550; cv=none; b=E6tdpDIBSCEP17zuUSzFxmkutV/DNv7Zm4wv6q/40wR9vIYwqm8e3LR6AJxLQ2UL83o/XTbuW4a4MsY64ibdh9zmATiXluSO3xNYtZvAjQK31i4S4k6JxFfR6i5YciwGRxmWX5tR+G49o4s8dUJEPUxkshtZEyf5b6Rw3YwMQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998550; c=relaxed/simple;
	bh=jUsOBVvjpdN3rPTiiI+7juYCKgxR7k7mTfEHMy9DHGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTMI+SZ9hhQOfuWF+QZKGXO/FQVAGsyzQqRK45WgA0PGov9YQfTNJkFMyOZpbv35X9gcqpsa0kz+MVbhGqXgvbo0AbPV41fVO1bQ7w4oXH/KlKpADuJjWOXUYQb8+QT0UwYlAP1VqEepJOHf+M33jVTW8IKIzdgNQjK5rT7fE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jsvcyUeH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70436ac872aso747359b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998548; x=1718603348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og+3qSLwnDyl77cuuZuCfLwj0nCBz/c/by/cBANoQ84=;
        b=jsvcyUeHDjCNjKw7C24uX06jKrE97/qVMgB5/VYze3rrVOrznGskPuDcEvYa5SkjUs
         GpwvnL24qRE1KqqqSDskiJXxO0DQb3474wP0lHCMbhLL0cnXf/clmIAmlFFY7Ut/tOS9
         Eblmhas+nL0VGCRqwWoHSAWNkiovy6rwyFiZ3ciLCTuwgk08QLZ8yqOqxp1pnjjj1FlK
         O+Hod3zun7TvPc07KXbEh06JQsok4tHGmSCkwwQJw9/C2GKAfk2TJzTFEoMzTdAkJEVu
         +qhdIHb+UxgYmFzanIlQoooyHRy72jOQeDrFthiha2qMPdIS67b8gLr7oMLEtYMMJbmC
         dtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998548; x=1718603348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og+3qSLwnDyl77cuuZuCfLwj0nCBz/c/by/cBANoQ84=;
        b=gqADkrLdUF1qQPc+GhdHTWStI52OwbkjFbQDZUzFQ3kNAtyye0oPUHlWyRZAJddSux
         9sAJBKgQaxR33cMJKCtnUlxcmPkG4tFDMVWk9p4wqM2DbBQFUX7DC+8OL6pKmfIwrtWl
         aff7QppHLVD7yE9eOjkeme4Qot6d2B5Kk2d0NIwfjjS2A7AREd/AtDgwzcmG0sjyLydo
         RHffqA52imzfbluM3mU8M4uuW+7FRY/tZfr6bzX5Iznlfw+wUrG4YEDZSxEuDVuT54NL
         qU/DAhVEXIGr76Z6L0It6rvq6OD/M1nnyTaSHfo8q1frSAJ6Q4HAsELoR9j28gI6E3Rt
         S5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTvGejWBSaxu7842aBuASTizpatDdQFZsFtSRonAKnT0sFzMz8KirRB/7fJHTWRECxmdkKxfQz3fk0tedz2PZ3YcweJ/vh6w1eTqVe
X-Gm-Message-State: AOJu0YxbChghMFXpie/K1hj5sKr4KV9IGSvRNCKY/7yGoyVDxnf/NNzn
	3wmAf6o+pPtdd9trlVrncIAuKEdvraYhqEwvH3K+AYFwUedIHcSWDmFXKVXSMec=
X-Google-Smtp-Source: AGHT+IE2CCHwa8n7OUmP/aiNwlIFB9vrHHL4L9WeXHa3QTMhQ3vs5tafZcaVre7RIyk41/e1O1jGWg==
X-Received: by 2002:a05:6a20:a124:b0:1b5:d10a:1b70 with SMTP id adf61e73a8af0-1b5d10a1f56mr5828674637.11.1717998548545;
        Sun, 09 Jun 2024 22:49:08 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:08 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/24] Staging: rtl8192e: Fix spaces/tab alignment to match open parenthesis
Date: Sun,  9 Jun 2024 22:44:40 -0700
Message-Id: <20240610054449.71316-16-tdavies@darkphysics.net>
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

Added tabs and spaces to fix warning:
Alignment should match open parenthesis

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 369fd26180fa..c46bd0ea061e 100644
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


