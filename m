Return-Path: <linux-kernel+bounces-331301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5397AB10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA761F21896
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72579165EE6;
	Tue, 17 Sep 2024 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BawVYuXI"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1ED15B560
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551128; cv=none; b=McH7mQLYmje+ZIewhE4MnRA5vNAQMpVKSa5yXJ10oAQO95pW5353uV0Kq9R5vowPf26g0n6DPYcvC7LJSGopGMgEXKj0wjrU2hqnkT64f4IPACX88wjAhNAUc4kj9tcccXp4z9Zwn0iyvPFMJe6pTXFcVrUge/F6VlgPV8NW3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551128; c=relaxed/simple;
	bh=vgE8gng8p5gjnoJi7u04bQWwGLfibxjizyrtPFsAySo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqQ5v+3G42dZFM6BmmHd/Ub9HJ7AhQ8XDgsqb62FvcudEOLpPiZBeZFsoYPQtMDQpJVF1IdF9SVyseMBarfIur5kfLPMnJCf2fEcRkuY9rAk0I+voGajCtQVSmVruYt4Rc1KQhlOtBG3zNaQq8bvZ7P+RPDEo4ilddyd2Vn/wQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BawVYuXI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7193010d386so3388897b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551126; x=1727155926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUc8RkI1FPSHCZ6I8f+u2bX+PWnQZjFpuKFwB7QBvYw=;
        b=BawVYuXIIyN9FHElGvnfYakUaTwyry+Dh5y5JNAS2Lue1h9fDJSherXvpU2hmfl762
         5Bcgg7b+cgEtGCu2ijOVnC3mWqu/zALKPyh+lp822IoiK/6HFQRLBHKRsNMLI/LveCWt
         LZtyU8HeOPvboEu1Kz8ylO5jpIBbtSjX1PTOc06UYL6CSA+ftbdX1ejK9Kh/E7nGLyns
         ULYUbz9bqS1DNGH2zxFlQTh+9zxCtAKRh/NINUoG17TMHNg3PppkzVimeoDHLVJdjxsj
         UaR7p/fZFAR6nhAUamH70GNj8lbfAhMvI2QmeqIqbUgmZwDrimOpKUFBIP7gXoiTPdU5
         rM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551126; x=1727155926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUc8RkI1FPSHCZ6I8f+u2bX+PWnQZjFpuKFwB7QBvYw=;
        b=Mfj6CUNAY+SYOZIypDR/f6IwUWSknQidbP+z9HifvZQ2hIv9XRBPyZ0FuoWpvJgfvN
         FNgh8/Y5y8qmw1sEB4I0NBxSWAPAaIJKAcYysMrOmrRLpWcj27f7YwD25om927SG5xwR
         L5oodABaDjj8LWSnEV40i/n9GEkjo84w1zKaX0sq+/WW5VZi2gGO6r2rUv0qoaWbfLSk
         paI6uZ/Fbaf1YzK8VxIVDA9X1XwulWNStni9cGerRMnCIXmt0n8Q2p93TqcronoODZTY
         ibk6A7ULHHZc4X62yhvzd/jNUkTjB3h7lJ7+xtpb5ek25HF2Z3X8pomtDKTj5QYhqhkw
         S6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUUFPC6X6zvlKUrXdyccCmmgCXm02aJf/m7KwOVydCkou5P/OOX8/X3ZnjjlSdUVEiVpYwVFLJKJujnkzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhiVDNxYZDL+V+F93Tv+VAx7Kf5L2oqdDXHzEWxxYvXiA3l1D
	a6pCDVzneDBR7FMtfhev1jQbhNPS22vzyEGNYsAYPdIsaR6SF3eviAMUWpRtdZs=
X-Google-Smtp-Source: AGHT+IHoaqWaQ+deAiUVjkPdOieSjbc4vo8dgefLXeDO11W1V5KwLZxOksMjYxWEhWY+eBmAeZEmJg==
X-Received: by 2002:a05:6a21:2d8c:b0:1cf:374f:40c9 with SMTP id adf61e73a8af0-1d112e8737emr24378350637.38.1726551126429;
        Mon, 16 Sep 2024 22:32:06 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:06 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 15/18] Staging: rtl8192e: Rename variable Tx_TS_Pending_List
Date: Mon, 16 Sep 2024 22:31:49 -0700
Message-Id: <20240917053152.575553-16-tdavies@darkphysics.net>
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

Rename variable Tx_TS_Pending_List to tx_ts_pending_list
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index e87d2926f47c..0b906d618a90 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -125,7 +125,7 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 	u8				count = 0;
 
 	INIT_LIST_HEAD(&ieee->tx_ts_admit_list);
-	INIT_LIST_HEAD(&ieee->Tx_TS_Pending_List);
+	INIT_LIST_HEAD(&ieee->tx_ts_pending_list);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Unused_List);
 
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
@@ -366,7 +366,7 @@ void remove_peer_ts(struct rtllib_device *ieee, u8 *addr)
 
 	netdev_info(ieee->dev, "===========>%s, %pM\n", __func__, addr);
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->tx_ts_pending_list, list) {
 		if (memcmp(ts->addr, addr, 6) == 0) {
 			RemoveTsEntry(ieee, ts, TX_DIR);
 			list_del_init(&ts->list);
@@ -406,7 +406,7 @@ void remove_all_ts(struct rtllib_device *ieee)
 {
 	struct ts_common_info *ts, *pTmpTS;
 
-	list_for_each_entry_safe(ts, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
+	list_for_each_entry_safe(ts, pTmpTS, &ieee->tx_ts_pending_list, list) {
 		RemoveTsEntry(ieee, ts, TX_DIR);
 		list_del_init(&ts->list);
 		list_add_tail(&ts->list, &ieee->Tx_TS_Unused_List);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3544054b78fc..ff6b59874fed 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1195,7 +1195,7 @@ struct rtllib_device {
 	atomic_t	atm_swbw;
 
 	struct list_head		tx_ts_admit_list;
-	struct list_head		Tx_TS_Pending_List;
+	struct list_head		tx_ts_pending_list;
 	struct list_head		Tx_TS_Unused_List;
 	struct tx_ts_record tx_ts_records[TOTAL_TS_NUM];
 	struct list_head		Rx_TS_Admit_List;
-- 
2.30.2


