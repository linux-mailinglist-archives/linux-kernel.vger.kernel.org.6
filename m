Return-Path: <linux-kernel+bounces-184444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F68CA6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29643280D94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2947603A;
	Tue, 21 May 2024 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="GlPa6h0m"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AF73539
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261459; cv=none; b=KGE4pLcqWZ00LmTjsSaEmhVENOHssAr6nx8TNWGjzg5VAKdJq55hXDOawCYuQ6ejDKBw0pUjvtHWBrKwU5+w5LX+r1tA1/Ngh87B8QP7n4KzlMM9wWNuHV/jxRVZZ0i8vuyu6x2XckTUCv0BDUaUIqAQenilG+sO7eVxbjWsHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261459; c=relaxed/simple;
	bh=O1x9lXALRfV3PEXYjxpd9ysMagtz9IVgfLsMeVEQ/yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jrg11zzeHpJYIw98wHJBcJbaBAdM1RHuFYPfs2+0Ck3uB0rNlWFRM9IFJzpGfwNC01UltGdxqMVRi2qE+FB8b3ArP9WLaTQIgj3kbc3cZwUCg8/a93rN92w03hYshdlInV//fLZejryh2sJA6EBClFaMbEXvPakW0A956wRU9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=GlPa6h0m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee38966529so24149375ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261458; x=1716866258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fdeEpEPtpWbE5Mh9fqJmFvRworqsEQTxGybJaCMPRk=;
        b=GlPa6h0mP+AW3aywezI+gwc4M4G/gp1RRjYk6gHzreyZjY4QB8yw66QQV4Bjm9y6dQ
         So2OJ+nPOZD4F/1J3sDddLO+orVA50cWoXz9t1L2Ivh+MNbTaFSzoMs+sQiR1JB///E4
         yXR0oai9NM+mtlmOQ+Qz1B0nHsCXG03srXhok7jV6N0+6OncRG+GKj79A5xpJiN7ofhd
         EuzLr85y6dbcP+QqZYRTx8e+Ozhlck8gXkc7zBBZaNGbD8NRf6hKO6AmRYHgFob7V7ZF
         WC0BqyfWqTrjBDUVL+7Y8WVJB5Dlr3dw1DFXvgRYCLb1odQPX+wPRr7VNfOD845LxIr1
         LgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261458; x=1716866258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fdeEpEPtpWbE5Mh9fqJmFvRworqsEQTxGybJaCMPRk=;
        b=MlqvWRHDJnvwp/anliYX290RM4VSPPjeBjCq6QjQGbOxFF94oRvLW17bnUDHWeXp9w
         2Iopj5zf6ZXnmMf5G+v4kUwguK2qA7q/vT4j4h69h4/diDZ0nJ6rA1GxFO08wTpUaqmj
         u0c0z2g0oVyD3iuskPP9dCw3qDkan3hjgUpAcwM/YP+3kMKB3eowxWRiHXzU9MhwjjpV
         gRNQXw1UHSFHr6VCXofw1uAb007ekW2TCsuUmYvEwmbydaPZGxhI9a3g8w3xsP2Ei9G2
         yGJuvfUpZVHYpAB7WxfFK5VSCDXCR1n39IB6zOvQslSyNFJX6KkACaHlazzA1RFwcI10
         +tbg==
X-Forwarded-Encrypted: i=1; AJvYcCWlbwup1I7bq1NwSLPjltk7JCfx3IweaUak1LVZi7Kn/z38cFonTRuBVRP7caJ7QqyKHPl4Stw8+GYAbofhEGYoUahxM1xwE0Z227OZ
X-Gm-Message-State: AOJu0Ywr3o1ws6kUrSwZgaHo1zi+0vAGvVNeiUCeZVOvwT9X9uFVL6W2
	ghzfZwUh6IRmfXc++R+Ivi4Bb5vj7G7xcClzAH1OpgmgJEzCFEmU5Df2jbF5PNTeUhHR2GpeU0Z
	T
X-Google-Smtp-Source: AGHT+IHLUgFiZc3Qe3eYozL7kHO2osGBiNgXlRXygRH9TaPBs9Sb/E5DEHR2GAEbHm1R06IhTO9DZA==
X-Received: by 2002:a17:903:2448:b0:1f2:feb4:84f3 with SMTP id d9443c01a7336-1f2feb48734mr60320535ad.1.1716261457837;
        Mon, 20 May 2024 20:17:37 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:37 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 21/31] Staging: rtl8192e: Rename variable WinSize
Date: Mon, 20 May 2024 20:17:08 -0700
Message-Id: <20240521031718.17852-22-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable WinSize to win_size
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ab2aa1a86c51..50687f3dce47 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -526,19 +526,19 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *pReorderEntry = NULL;
-	u8 WinSize = ht_info->rx_reorder_win_size;
+	u8 win_size = ht_info->rx_reorder_win_size;
 	u16 win_end = 0;
 	u8 index = 0;
 	bool bMatchWinStart = false, bPktInBuf = false;
 	unsigned long flags;
 
 	netdev_dbg(ieee->dev,
-		   "%s(): Seq is %d, ts->rx_indicate_seq is %d, WinSize is %d\n",
-		   __func__, SeqNum, ts->rx_indicate_seq, WinSize);
+		   "%s(): Seq is %d, ts->rx_indicate_seq is %d, win_size is %d\n",
+		   __func__, SeqNum, ts->rx_indicate_seq, win_size);
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 
-	win_end = (ts->rx_indicate_seq + WinSize - 1) % 4096;
+	win_end = (ts->rx_indicate_seq + win_size - 1) % 4096;
 	/* Rx Reorder initialize condition.*/
 	if (ts->rx_indicate_seq == 0xffff)
 		ts->rx_indicate_seq = SeqNum;
@@ -569,11 +569,11 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 		ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) % 4096;
 		bMatchWinStart = true;
 	} else if (SN_LESS(win_end, SeqNum)) {
-		if (SeqNum >= (WinSize - 1))
-			ts->rx_indicate_seq = SeqNum + 1 - WinSize;
+		if (SeqNum >= (win_size - 1))
+			ts->rx_indicate_seq = SeqNum + 1 - win_size;
 		else
 			ts->rx_indicate_seq = 4095 -
-					     (WinSize - (SeqNum + 1)) + 1;
+					     (win_size - (SeqNum + 1)) + 1;
 		netdev_dbg(ieee->dev,
 			   "Window Shift! IndicateSeq: %d, NewSeq: %d\n",
 			   ts->rx_indicate_seq, SeqNum);
-- 
2.30.2


