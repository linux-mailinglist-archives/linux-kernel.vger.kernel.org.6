Return-Path: <linux-kernel+bounces-331303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A897AB12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0267E1F2119C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC4165F1F;
	Tue, 17 Sep 2024 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="A0osqlIx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451A15B57D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551129; cv=none; b=HgawxSMqGlCM8NtTesvxSfDUQ3bELOCG4S8pZHQMgFHuQArflrXV+/W0QQ2XesE3IGrH9rthn86EcyILYRUYbVZ3hCkBM0E54NeFUcN1WIWl5VihcY/ukncsD24QecwVwU3ak9Ktg+8s+LfIAjdcsq14xEjkY4P026dbhVfprYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551129; c=relaxed/simple;
	bh=FsvVG7s50X+ytswfAcPQQ1Q+R0b3F3TkCKt25TGq3/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMhjDQ26AfppGv7m9lIO2R5H+18tl+qBv0iUfCMkrG9wmIpBELo6O1a8hrtkl/Oaq8UgyR4IAHtkCmnzgjid8DuZUKEsUm/g1CZJlZbpFWpDqoMqMluzTevU0lZ9YS9Goiq2fInRKnF/0Fe9iBjCIQT/zrNI/ROG7p4I4v+9Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=A0osqlIx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206aee40676so30139315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551127; x=1727155927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i9Xtd5Jmry75nRJO1mTVFWPGfZ1jgJ3uQyB9QmMbQg=;
        b=A0osqlIxxu2JBqL4sb5160I8TmRnTrmRVPsf5tfEB5lNFZAQiEsTlnMlj3Cb1eU2Dj
         Fy//B6xSaZNulj2paCpeXgOpmFTrT9UiJGRriH499CfjJCnNwEmm2ZMFPgXt2oqTJASp
         HJEhxjZeEhnZVOQeD5QqoXEcxw//msuGU2bdwi5ETBnXfAlzatb5UFsgF3/YJYbr7HZ0
         qQ8/61XH+qaFMW3LGTsSxoi5hhsKFEeArDG1Mi6de1SLfXyG+0H3YjasFGALhdOuZmub
         b8RIbNYAqu3WJPmuMgzeABq1V0hAegp/jCowmDjgydb/x+E1g5sZxx6Tv99ivJOtxiuO
         nRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551127; x=1727155927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6i9Xtd5Jmry75nRJO1mTVFWPGfZ1jgJ3uQyB9QmMbQg=;
        b=fcP3CgQ1qUwetlb5BO7E8P8VEXv/C07aKPxG1WK9fphRGXWBJt70NMv2x8HA5i8c/f
         vZlthl6W1tWR+STtTqeAfwUSJ5d+D4cZjnOdheRuV86KOj6F2CvG9BHijKNFG0UOlu1H
         SeyTZprpbeklMcYZnGL/lCP5QcaGyJMrt+61XjQgFK2uHt6nbqWu3ZkrMza0tedoaZQj
         2r88ZXbnpNmzzslx09+uTWpWc5bf7UNCfONivhzgU6vTdUYaZP3W8bxZLDxpaCRibbYL
         qsTbMdVPkQ0JfUnCMxVohjmPz21IMptoUsUB82lCnwaSo7gcs89sXLu7fXmxBZckEBll
         pJRw==
X-Forwarded-Encrypted: i=1; AJvYcCWVOYEqYZKKonI+pa+nOnXIhhAx1rU1oHzdbBguTCRubHVpuke4EOQy4lVZMJ/DTLLJjy6gxZ/tbjN38U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiu7mUHJ0ffb8qWcFPdfP0duIOdagYkRQgsUck7eIoZZpsmx4Y
	bBAVc//p6eLoHMjmczaevW3EanaOn0sLUmomDo3+PJbk/zqEDX4KIYNqKKO89Jc=
X-Google-Smtp-Source: AGHT+IEVl9XCVV/EDxTzSGvNLFsw2+ukL89kw5qYphDBjuaGpF/3AbmLYRhpfYB/A/kvDncLmc1dmQ==
X-Received: by 2002:a17:902:da86:b0:207:6e51:41af with SMTP id d9443c01a7336-20782be4b5cmr211092595ad.43.1726551127106;
        Mon, 16 Sep 2024 22:32:07 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:06 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/18] Staging: rtl8192e: Rename variable Tx_TS_Unused_List
Date: Mon, 16 Sep 2024 22:31:50 -0700
Message-Id: <20240917053152.575553-17-tdavies@darkphysics.net>
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

Rename variable Tx_TS_Unused_List to tx_ts_unused_list
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 0b906d618a90..ecbe3bd67a0c 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -126,7 +126,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 
 	INIT_LIST_HEAD(&ieee->tx_ts_admit_list);
 	INIT_LIST_HEAD(&ieee->tx_ts_pending_list);
-	INIT_LIST_HEAD(&ieee->Tx_TS_Unused_List);
+	INIT_LIST_HEAD(&ieee->tx_ts_unused_list);
 
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pTxTS->num = count;
@@ -139,7 +139,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 
 		ResetTxTsEntry(pTxTS);
 		list_add_tail(&pTxTS->ts_common_info.list,
-				&ieee->Tx_TS_Unused_List);
+				&ieee->tx_ts_unused_list);
 		pTxTS++;
 	}
 
@@ -275,7 +275,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	}
 
 	pUnusedList = (tx_rx_select == TX_DIR) ?
-				(&ieee->Tx_TS_Unused_List) :
+				(&ieee->tx_ts_unused_list) :
 				(&ieee->Rx_TS_Unused_List);
 
 	pAddmitList = (tx_rx_select == TX_DIR) ?
@@ -370,7 +370,7 @@ void remove_peer_ts(struct rtllib_device *ieee, u8 *addr)
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, ts, TX_DIR);
 			list_del_init(&ts->list);
-			list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
+			list_add_tail(&ts->list, &ieee->tx_ts_unused_list);
 		}
 	}
 
@@ -380,7 +380,7 @@ void remove_peer_ts(struct rtllib_device *ieee, u8 *addr)
 				    "====>remove Tx_TS_admin_list\n");
 			RemoveTsEntry(ieee, ts, TX_DIR);
 			list_del_init(&ts->list);
-			list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
+			list_add_tail(&ts->list, &ieee->tx_ts_unused_list);
 		}
 	}
 
@@ -409,13 +409,13 @@ void remove_all_ts(struct rtllib_device *ieee)
 	list_for_each_entry_safe(ts, pTmpTS, &ieee->tx_ts_pending_list, list) {
 		RemoveTsEntry(ieee, ts, TX_DIR);
 		list_del_init(&ts->list);
-		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
+		list_add_tail(&ts->list, &ieee->tx_ts_unused_list);
 	}
 
 	list_for_each_entry_safe(ts, pTmpTS, &ieee->tx_ts_admit_list, list) {
 		RemoveTsEntry(ieee, ts, TX_DIR);
 		list_del_init(&ts->list);
-		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
+		list_add_tail(&ts->list, &ieee->tx_ts_unused_list);
 	}
 
 	list_for_each_entry_safe(ts, pTmpTS, &ieee->rx_ts_pending_list, list) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ff6b59874fed..074cd837c708 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1196,7 +1196,7 @@ struct rtllib_device {
 
 	struct list_head		tx_ts_admit_list;
 	struct list_head		tx_ts_pending_list;
-	struct list_head		Tx_TS_Unused_List;
+	struct list_head		tx_ts_unused_list;
 	struct tx_ts_record tx_ts_records[TOTAL_TS_NUM];
 	struct list_head		Rx_TS_Admit_List;
 	struct list_head		rx_ts_pending_list;
-- 
2.30.2


