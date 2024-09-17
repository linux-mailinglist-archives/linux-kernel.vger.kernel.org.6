Return-Path: <linux-kernel+bounces-331302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6F97AB11
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B861C27721
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8F165F0C;
	Tue, 17 Sep 2024 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fueiyA6+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFC15AAD6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551129; cv=none; b=XG0tYEpqACBZRuAcPuyE459SgRF6cGxcmV/rgLTiOuhPOqvKFut3g8aceX5SUU/jI/0LKF1b+x5c23t9/gwWrt+QKxr3b6rX8SrFa2/qBuuRiFgZzFAWJjsMSZbu8V8ZmY/K3akTyoHyvprslF7tUzANShbefQai1BhthDF0vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551129; c=relaxed/simple;
	bh=q+xOEKWsHd2GnzwxhTD1fpiaTHmugckiXD5ETn3XgWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDsN08LldCH/VnZigibD5F+oYiwMpZDOrDOvmyCRlXRD1wqZAIEn71ZKbNqq0pbVKgXYwRvwE1fns8SkG802VzGzTOrwxu7rR4eJN8ej5TTveh5uTvo8MQmSwchtxfjpZ2b7YzVKlh2fq0Leaod+eJUF9pnFpWR6ziilJDe0lNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=fueiyA6+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d606726cso3475595b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551126; x=1727155926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRrw5+oANKkULNvvGuleCSc1g2ZOyWkjgPNrOQZeAG4=;
        b=fueiyA6+l/pH9wA+VIr/PJ9Qu8UzFyqzQ3cyFPPzqN0mc6wWaGSyx6W4vb0xVk4cBR
         nMJpEQ1tEUOv5hlTlVouExPFCE3TMcXs/sGECDJZCgtd2/KbIeDkNZarocp9J7aNPZUK
         +20FBG0bPNVHrr2E1GedSbtFez+Bc/9sPPi+rm8akVx2hZg+bINIfqQV93NT/Kv1EJXX
         HTbqxbgzBPKtF+neT8hOynWWlupLpK6l0Zjg8ZPkGuPvtDSgr42mAT3BrTUSZpIWPlSP
         ycpNZQ2zbndmK6cHdN7a7eDA56Hrje1lRQXaU4veSLIJuo6wX2mMpL8bNBMceflK/KzZ
         y4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551126; x=1727155926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRrw5+oANKkULNvvGuleCSc1g2ZOyWkjgPNrOQZeAG4=;
        b=WNCD+8pvEbOlpiUMoILzfhowJd84QIwqAkOBo/jZ4ICx8HZr/7V09fhBlK4jYFbLN+
         /xrOtb5owiWP56uAdJSm9h+BUfFpUlzq8rhStekOyUOKkZz76D7pmBhPG1P40PqvPJ5c
         qu6bF8UGcWjv5iB6igSTqfsVx7Pl9Ak4N3DHoT3IR/RjNzY3Qf05BT2QTb87GGU7RutZ
         E5bcd1gsx8dsm1MCsGtelf4MnuC5UtS3WofjZ15bjdsygYJEny5ae0pSv4g82yHkiVRO
         +PlsxOPiXPGuMx3/KlSXB7LlyYUFG9ivv+2JcYRcEun/re/QgVvzbxFgr0m7L7qHdP9O
         WJMA==
X-Forwarded-Encrypted: i=1; AJvYcCWyz4YcO4RoqDfDCfqBOz7SjNKIL2Y8I6+pUnYntPupNIItZxrDkWS93tVWqQnvgrIKjFZH7nCFedJocHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPJ/MW4STWvD8gwk51N7C2gpvwRNMrXunX1QvSs98xO7msdBd
	6H9SpxJgMTnyIzwliKWxr2tgcWhkdquaLQ+Q+M3HDb+IMX0hh6mCbii+BVcHD+s=
X-Google-Smtp-Source: AGHT+IHyDu7EuUO7j+l9ZJc3NSt+VsHIp0EO//b6IiME0O7rD9sow6TqP9CxLW5YxEC1y5REHUmcxw==
X-Received: by 2002:a05:6a20:8428:b0:1cf:ff65:3680 with SMTP id adf61e73a8af0-1cfff653b08mr27355421637.6.1726551125720;
        Mon, 16 Sep 2024 22:32:05 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:05 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/18] Staging: rtl8192e: Rename variable Tx_TS_Admit_List
Date: Mon, 16 Sep 2024 22:31:48 -0700
Message-Id: <20240917053152.575553-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Tx_TS_Admit_List to tx_ts_admit_list
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 10 +++++-----
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index efadb2b778b1..e87d2926f47c 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -124,7 +124,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 	struct rx_reorder_entry *pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
 
-	INIT_LIST_HEAD(&ieee->Tx_TS_Admit_List);
+	INIT_LIST_HEAD(&ieee->tx_ts_admit_list);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Unused_List);
 
@@ -189,7 +189,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 	}
 
 	if (tx_rx_select == TX_DIR)
-		psearch_list = &ieee->Tx_TS_Admit_List;
+		psearch_list = &ieee->tx_ts_admit_list;
 	else
 		psearch_list = &ieee->Rx_TS_Admit_List;
 
@@ -279,7 +279,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 				(&ieee->Rx_TS_Unused_List);
 
 	pAddmitList = (tx_rx_select == TX_DIR) ?
-				(&ieee->Tx_TS_Admit_List) :
+				(&ieee->tx_ts_admit_list) :
 				(&ieee->Rx_TS_Admit_List);
 
 	Dir = ((tx_rx_select == TX_DIR) ? DIR_UP : DIR_DOWN);
@@ -374,7 +374,7 @@ void remove_peer_ts(struct rtllib_device *ieee, u8 *addr)
 		}
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->tx_ts_admit_list, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			netdev_info(ieee->dev,
 				    "====>remove Tx_TS_admin_list\n");
@@ -412,7 +412,7 @@ void remove_all_ts(struct rtllib_device *ieee)
 		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->tx_ts_admit_list, list) {
 		RemoveTsEntry(ieee, ts, TX_DIR);
 		list_del_init(&ts->list);
 		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 315a75739e44..3544054b78fc 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1194,7 +1194,7 @@ struct rtllib_device {
 	u8	tx_enable_fw_calc_dur;
 	atomic_t	atm_swbw;
 
-	struct list_head		Tx_TS_Admit_List;
+	struct list_head		tx_ts_admit_list;
 	struct list_head		Tx_TS_Pending_List;
 	struct list_head		Tx_TS_Unused_List;
 	struct tx_ts_record tx_ts_records[TOTAL_TS_NUM];
-- 
2.30.2


