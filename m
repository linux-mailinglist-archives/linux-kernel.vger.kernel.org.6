Return-Path: <linux-kernel+bounces-179421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9958C5FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0230A1F23EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66259B78;
	Wed, 15 May 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="grJNDEJd"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80B4F608
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748767; cv=none; b=YpPOnU/tF47bjatLC42U04zXE9/D0yriwUGyb53+BLxhassk9rOus1zN2TF0yiC66yXp7Mli3k99M38gcR5a716ClEgipg5eANvmGxaqw8hVK9ZWjKfVZfHDHd5a1RX8YybipTsb51T0aLus0tPkQO7y8EK2VqRUa2i7cQWzaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748767; c=relaxed/simple;
	bh=ew7QTjnBQLH0PTpIA8W7zoW+lQRRUkKEJUaHs9Sl+38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VG1UFpEon1MQcDTtpelfCzUpB8LUxdUNBOGeOSPghWLZpMcnn4DFsH/z+Mr3XyGeyr1Oi4O2KXqaFDdQkWGSBHt1ufchwCFtFYFbsxgNH/CQH9TGhpxsGmoPZRyvb6D96g9qYsJ3nZ5c4JKKV7+O9vJM42iMx3b4GJilgqH1eAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=grJNDEJd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f4603237e0so4475954b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748766; x=1716353566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEx6vAr52pGxysjGe3jw5iXqLZA63B3Rf1CnGustKUE=;
        b=grJNDEJdPYY8keTzTaIU+evAYEZyXQdK4aOjGtVJtvQ1BlZjvf8NNfD7DHLuxBn5QT
         6By7cEuNkopaWdt7BnIQD+u60QqNRQODjPqYKuoE+eOC3g1sBQqquP9getohWBp8ZasL
         bHEMARTsJqH70FBT67rKASFFue8tGlHJsyyA6Z+8XYxJNPtaFodgzFLr2vUTkMmvlO1K
         fhY2JT4ytbtWUbFVirmNufUp0zWUpuRXnv/eaiQmZrddsaRg+MWZBr/PQKr1OIa7zDRp
         NXsn5CG2631Gq3QF+ePsDmILMH58OmyCSSBEcYGilrRfds0iFWrKBJskhy3fpnLrajSP
         ZXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748766; x=1716353566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEx6vAr52pGxysjGe3jw5iXqLZA63B3Rf1CnGustKUE=;
        b=t4KLkQA+1MoTc16zBY8SyX4ainHsR2M925psgDfSGVdNNqCrl/02qC+Rhl9yEega5V
         a+rpoOQAzOXE/B65NmDgCqH0z8A5uFqgzRplvQP4lx7sGixMKEETvkiJsraFwV7hD6/b
         kE49RJlS83CzBwDnKESXtnw0sfbOLW5mzvnK2P0HwEZ33Ws5TvQdvF5+3jubYuTVhOB8
         gIT2GlddCLhptxtP5NMxhAkjQx5xyMT8U6RpFqH4IaHDALJ3OGCFYgv1tU3ss/FUak6q
         7Tb6cHN/+woE5KwNltWdz7rDEcRPTy9sN+0IMrxsN/BChg6gESE6AFhfL2X2SZrpmcW6
         uaQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZzhtRozuPhi6aZSyU6Wk2nizD8Z7nIjWnUiKut0/qCcpuMsasFCshEwBEJOng72QnXzav82luXBZfn2qGx9t+0k+ZVhghYkEsvtXG
X-Gm-Message-State: AOJu0Ywxn7xHszFPQE3G+mZktt8YbgtIUg/7oXHujzZ9V71RoppojaCh
	uAgap4yCXSybmXcRhgf+F6OmYDRdYvEP/q2I/I5sUXOzSt3OpajUCUbPUrknw8g=
X-Google-Smtp-Source: AGHT+IEU3v7pENlKhFG6PdHM+Xs0TQ2WLZQ8Zb7U6UcQlLVQL8MHf7S6XzWlBzqSwaDRgqPpu67fmg==
X-Received: by 2002:a05:6a00:4613:b0:6ed:41f4:1886 with SMTP id d2e1a72fcca58-6f4df3db383mr25644408b3a.8.1715748765879;
        Tue, 14 May 2024 21:52:45 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:45 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/31] Staging: rtl8192e: Rename variable pList
Date: Tue, 14 May 2024 21:52:13 -0700
Message-Id: <20240515045228.35928-17-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pList to plist
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 30bd6f49e915..fb679229f173 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -406,24 +406,24 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 static bool add_reorder_entry(struct rx_ts_record *ts,
 			    struct rx_reorder_entry *pReorderEntry)
 {
-	struct list_head *pList = &ts->rx_pending_pkt_list;
+	struct list_head *plist = &ts->rx_pending_pkt_list;
 
-	while (pList->next != &ts->rx_pending_pkt_list) {
+	while (plist->next != &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
-		    list_entry(pList->next, struct rx_reorder_entry,
+		    list_entry(plist->next, struct rx_reorder_entry,
 		    list))->SeqNum))
-			pList = pList->next;
+			plist = plist->next;
 		else if (SN_EQUAL(pReorderEntry->SeqNum,
-			((struct rx_reorder_entry *)list_entry(pList->next,
+			((struct rx_reorder_entry *)list_entry(plist->next,
 			struct rx_reorder_entry, list))->SeqNum))
 			return false;
 		else
 			break;
 	}
-	pReorderEntry->list.next = pList->next;
+	pReorderEntry->list.next = plist->next;
 	pReorderEntry->list.next->prev = &pReorderEntry->list;
-	pReorderEntry->list.prev = pList;
-	pList->next = &pReorderEntry->list;
+	pReorderEntry->list.prev = plist;
+	plist->next = &pReorderEntry->list;
 
 	return true;
 }
-- 
2.30.2


