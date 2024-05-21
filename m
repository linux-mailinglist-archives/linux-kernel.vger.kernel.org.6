Return-Path: <linux-kernel+bounces-184455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5818CA6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07885B22E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2657E0E8;
	Tue, 21 May 2024 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DPd2D1gn"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AEE7C085
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261467; cv=none; b=Law9euvQCwHmjYyNeTyzse+6OkXFbH2kQmbf/T4vuZvtcmNoUGkr5svgTFAo4Q/WORurgGRPn/qu23YHcbrAp6Fex36PoXG60EpO0fq3a/5SBi37EFF7UCrKJS1rKJ/kqKAqGMX6PyrXil61ybD3yt0m6kJDI05iTwTgqMAKp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261467; c=relaxed/simple;
	bh=Trj0gkPStjUwWgwQ7VdoJPBVTbXISJFT9NGpxdHYZrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXTFjzRAIOJh4vvdTVf3pMiZZAtA5eH7lrZrnZXTsQXfEcBVI3S+9JH98YW3yinLCmJ71hn+jZaMJMx9HzhDY9AR93SemmLcf/IgY40RZqI8IsV+62OKmvHIxPnqdW7/ZsbJdkgI2QbVCn3Q5URS5k8CZLs5NBvDxflCzKhYcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DPd2D1gn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f0937479f8so92000285ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261465; x=1716866265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQtEWcQTCYMN0RrUCy15v6k/lfOYvsIzszQIWWjwSE8=;
        b=DPd2D1gnVVE36DLLno5xuVUOeLP0wL+hD3BQlZBGnNEkMxwY/Zr82HD60XVyu/BiF1
         17wbAydgsEcQ00UESXtESS+pkiISbuaPN6ZhtplDQx8wbZOQey4nz1/pGa9yhjGw4DAy
         12SkR5TudckPsEUg6GSIR9Luuf1HHeknw6fQnvBdhqgGH/l2HKWURkoHO05K6tIdFusR
         lAqDkLSdaHdJ0jvFO7w9R7AYahiQrU187pU2V1tmmJyCN5VhcfelZXmJhJ8yBCY0UYRT
         oTqC78OwVFMuMPim8rpxx3ETTC2oESBUqeVd7Ts1q951a7KMmwPx/NERMUEEJsfPQlGQ
         0BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261465; x=1716866265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQtEWcQTCYMN0RrUCy15v6k/lfOYvsIzszQIWWjwSE8=;
        b=qeHfwn28PhhM+luY7VwLDJpDgGUIjg283+5VUzeWVSvVDNkT+6ZF/We+qT1UIw4E9l
         Kkxk2rTz11jZM5Ce9bTmAfHxIRNKoO1ZVGK3qkXXMPgDHZBqmbq6OBPsbunM9LoOrHcv
         Yocp3D/c2CLZ/3CPr70sfhuCgvIthwoSQKXyOooSK35m55QqEVCl3dDAdup5UJuTAGFK
         ER3QlM+8LaVH2WATtSDMPoSpbXWzSezO5ziYpeE+XdilkXQC9nH5Bd+FhDGYB03ORf1Y
         isVYUF2jYCLqL35FhRDrXcvnsn8YzrgJm73MOTOJFwBBp8Ry5ilwSjXhzC+l3ndYfOOi
         krYA==
X-Forwarded-Encrypted: i=1; AJvYcCXjh8mgFjhULQ1t4v9bckZftNJBgJQZ9Za1qLM5d66arcF720fST48nvIHD1N0HPtuqzCwpDRgOykgCXcf1/zFqTVJ/6W6qGLqe35U+
X-Gm-Message-State: AOJu0Yw949rz274/Tgi6/P46V1T+r53Xx6h1brjwE33hX7kAAfYYce4C
	Q7N0gHWFmRYiFaDJinfRQ23kNpnDeTqlHYaS9chZpx9f/J1Z4lS5rDUfechvN8M=
X-Google-Smtp-Source: AGHT+IHOuwo6ZIL4x8jeMcBOU5YI71QsKPDHL54tfoEZOOXfEd25pV2b8Cm0INEu2TrdltsLLVz4fQ==
X-Received: by 2002:a17:902:db0a:b0:1eb:75de:2a5b with SMTP id d9443c01a7336-1ef4405977fmr395700305ad.62.1716261465523;
        Mon, 20 May 2024 20:17:45 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:45 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 31/31] Staging: rtl8192e: Rename variable bPktInBuf
Date: Mon, 20 May 2024 20:17:18 -0700
Message-Id: <20240521031718.17852-32-tdavies@darkphysics.net>
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

Rename variable bPktInBuf to pkt_in_buf
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  8 ++++----
 drivers/staging/rtl8192e/rtllib_rx.c      | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 9903fe3f3c77..7cdeca7ed8c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -18,7 +18,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 	unsigned long flags = 0;
 	u8 index = 0;
-	bool bPktInBuf = false;
+	bool pkt_in_buf = false;
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 	if (ts->rx_timeout_indicate_seq != 0xffff) {
@@ -50,7 +50,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 				list_add_tail(&pReorderEntry->list,
 					      &ieee->RxReorder_Unused_List);
 			} else {
-				bPktInBuf = true;
+				pkt_in_buf = true;
 				break;
 			}
 		}
@@ -68,10 +68,10 @@ static void RxPktPendingTimeout(struct timer_list *t)
 			return;
 		}
 		rtllib_indicate_packets(ieee, ieee->stats_IndicateArray, index);
-		bPktInBuf = false;
+		pkt_in_buf = false;
 	}
 
-	if (bPktInBuf && (ts->rx_timeout_indicate_seq == 0xffff)) {
+	if (pkt_in_buf && (ts->rx_timeout_indicate_seq == 0xffff)) {
 		ts->rx_timeout_indicate_seq = ts->rx_indicate_seq;
 		mod_timer(&ts->rx_pkt_pending_timer,  jiffies +
 			  msecs_to_jiffies(ieee->ht_info->rx_reorder_pending_time)
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 0cbd130e946a..86b8d342ac80 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -529,7 +529,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	u8 win_size = ht_info->rx_reorder_win_size;
 	u16 win_end = 0;
 	u8 index = 0;
-	bool match_win_start = false, bPktInBuf = false;
+	bool match_win_start = false, pkt_in_buf = false;
 	unsigned long flags;
 
 	netdev_dbg(ieee->dev,
@@ -665,7 +665,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				netdev_err(ieee->dev,
 					   "%s(): Buffer overflow!\n",
 					   __func__);
-				bPktInBuf = true;
+				pkt_in_buf = true;
 				break;
 			}
 
@@ -683,7 +683,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 			list_add_tail(&pReorderEntry->list,
 				      &ieee->RxReorder_Unused_List);
 		} else {
-			bPktInBuf = true;
+			pkt_in_buf = true;
 			break;
 		}
 	}
@@ -707,10 +707,10 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 			return;
 		}
 		rtllib_indicate_packets(ieee, ieee->prxb_indicate_array, index);
-		bPktInBuf = false;
+		pkt_in_buf = false;
 	}
 
-	if (bPktInBuf && ts->rx_timeout_indicate_seq == 0xffff) {
+	if (pkt_in_buf && ts->rx_timeout_indicate_seq == 0xffff) {
 		netdev_dbg(ieee->dev, "%s(): SET rx timeout timer\n", __func__);
 		ts->rx_timeout_indicate_seq = ts->rx_indicate_seq;
 		spin_unlock_irqrestore(&ieee->reorder_spinlock, flags);
-- 
2.30.2


