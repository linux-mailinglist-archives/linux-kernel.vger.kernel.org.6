Return-Path: <linux-kernel+bounces-184454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA7E8CA6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B07BB20B16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BD7D3E4;
	Tue, 21 May 2024 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MLnOiWxZ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830E78276
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261467; cv=none; b=Gm7scbLxgU3Ibt8Wh9/Wutl2FV3O8YOtVBTNrB31nBgIJrqQIqK8zDqENNmxnrA7HfOWYZkX9tKPJO6OXjm6ktWnY8G57ebM1rR/90eFhu1N9orukZd84K75iF9jxAFpBg0fOpWHnA7bBwxdE0WPPaI2qklRgrWXQdHH+krD3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261467; c=relaxed/simple;
	bh=jnf7MKlRaQOkFyg85H4qHW1UXLeXYlD7mIZgc/DHAnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhjrbXiob6p/iz9XOG6tL51FMkgsAjSk+9NsRG2/DuFLOF9qlOtuMysucce58NOv1rNp+OKPkqM+R9Yetnj0MORNkT0BSEf7qsabsH+BwrKhatYF/3bOTsw8NDqFyfZx19E8vbgelAHKwLun6IsQ4q5UAru/s8PnYQOuETDqZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MLnOiWxZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec92e355bfso107915915ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261465; x=1716866265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHovnZHgvjy0PmQut0EmLQXHHNUr2jbMi7LfsvmK2ps=;
        b=MLnOiWxZM9b0IaYOdIVPLjzWNw5goVaF9guw6jAS96M23Iz47QvWHpmMFF805Nzu2O
         nkZdpQq9wzdu9PjE1kx/ctQ+4hyzmSccyFMjpEMaxERD+HKjbZApCWSqUHwSQshJq7NF
         1yEzDtA7u1yr4rbiDZVuWlT7E4yFDZ6EnPDdO1VHPYmQ7qgxEwHCQPLEEpGvoERG036P
         UuRvoEwDWZv/+C6bR1qrreais0UtLVBbun1rwdwZrsHbKQsdgIEDD2eXOnVQzpZ8D63l
         Hoek448hMxpnth31urtqwNuPaEyRwcU7DMD3iwFNTRJIIFkaHNfnBbhQazC2sxA4232B
         r6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261465; x=1716866265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHovnZHgvjy0PmQut0EmLQXHHNUr2jbMi7LfsvmK2ps=;
        b=tph0HrO/epzXEo2HG5YCibPIM6CS3BJezJrzEd7frxtXdyKV+2AcWvIo73/xcN2iwl
         jXtl0xZa9trZkUgcWC2z6Bi4KWGYxdK6+LBIFRClQNTW2qUIHuL85nyYyBct2UKsQJZl
         yBxwyDYrcr0pAtym8Dwhq+aqBkwrvARSIIPLyYWA3NfLKCTx5WlU5COAWgRZdWFvMmgx
         2ivriKRaHWEExfyqPOfuPDbN4KmxaEJcPJR1wUoty+Cmz+ldcNU6ef6d+ntlYz30R9Vf
         Jzv1XRRog2lysr8MjMgCJGSbg6lwgwrxZgOXOewkUZntWUc7g2qgV0O3zgo3sdVWDl3g
         FY9g==
X-Forwarded-Encrypted: i=1; AJvYcCVNOMsD3aOshdTDk5qOtHuW6Yip06d/yTyNU6ragjrmpisgJo3tRk3us3NpfCwMHtDtlwZE3tr7luwqS3/DSGpxN7SmvFyHtva0AN8+
X-Gm-Message-State: AOJu0YzSuJGdGYGeuIxfTRhMgsZ297kvgHBJ7ZKmZ94sr3/hvSVWLJmE
	rT+riaKmmJ8qSC9PijQUIQbzxpgqrVPnOQQOWaEIRaGPyCfE3miyaE7TBiSJxwo=
X-Google-Smtp-Source: AGHT+IF3ubzY7qKH1CfCRDojxg6HqGjBneJOGGVIGZ0wbgdyAYQpkqHlmaQqQFVPekMQDSBuQfG82w==
X-Received: by 2002:a05:6a20:9782:b0:1af:ab0b:1c08 with SMTP id adf61e73a8af0-1afde1b6f80mr30327709637.46.1716261464802;
        Mon, 20 May 2024 20:17:44 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:44 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 30/31] Staging: rtl8192e: Rename variable prxbIndicateArray
Date: Mon, 20 May 2024 20:17:17 -0700
Message-Id: <20240521031718.17852-31-tdavies@darkphysics.net>
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

Rename variable prxbIndicateArray to prxb_indicate_array
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    |  4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e2695beaf582..62af48c20229 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1409,7 +1409,7 @@ struct rtllib_device {
 	union {
 		struct rtllib_rxb *rfd_array[REORDER_WIN_SIZE];
 		struct rtllib_rxb *stats_IndicateArray[REORDER_WIN_SIZE];
-		struct rtllib_rxb *prxbIndicateArray[REORDER_WIN_SIZE];
+		struct rtllib_rxb *prxb_indicate_array[REORDER_WIN_SIZE];
 		struct {
 			struct sw_chnl_cmd PreCommonCmd[MAX_PRECMD_CNT];
 			struct sw_chnl_cmd PostCommonCmd[MAX_POSTCMD_CNT];
@@ -1803,7 +1803,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_rx_stats *stats);
 
 void rtllib_indicate_packets(struct rtllib_device *ieee,
-			     struct rtllib_rxb **prxbIndicateArray, u8  index);
+			     struct rtllib_rxb **prxb_indicate_array, u8  index);
 #define RT_ASOC_RETRY_LIMIT	5
 u8 mgnt_query_tx_rate_exclude_cck_rates(struct rtllib_device *ieee);
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 124fa5d54a23..0cbd130e946a 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -429,14 +429,14 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
 }
 
 void rtllib_indicate_packets(struct rtllib_device *ieee,
-			     struct rtllib_rxb **prxbIndicateArray, u8 index)
+			     struct rtllib_rxb **prxb_indicate_array, u8 index)
 {
 	struct net_device_stats *stats = &ieee->stats;
 	u8 i = 0, j = 0;
 	u16 ethertype;
 
 	for (j = 0; j < index; j++) {
-		struct rtllib_rxb *prxb = prxbIndicateArray[j];
+		struct rtllib_rxb *prxb = prxb_indicate_array[j];
 
 		for (i = 0; i < prxb->nr_subframes; i++) {
 			struct sk_buff *sub_skb = prxb->subframes[i];
@@ -594,7 +594,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev,
 			   "Packets indication! IndicateSeq: %d, NewSeq: %d\n",
 			   ts->rx_indicate_seq, SeqNum);
-		ieee->prxbIndicateArray[0] = prxb;
+		ieee->prxb_indicate_array[0] = prxb;
 		index = 1;
 	} else {
 		/* Current packet is going to be inserted into pending list.*/
@@ -675,7 +675,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) %
 						     4096;
 
-			ieee->prxbIndicateArray[index] = pReorderEntry->prxb;
+			ieee->prxb_indicate_array[index] = pReorderEntry->prxb;
 			netdev_dbg(ieee->dev, "%s(): Indicate SeqNum %d!\n",
 				   __func__, pReorderEntry->SeqNum);
 			index++;
@@ -706,7 +706,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 					       flags);
 			return;
 		}
-		rtllib_indicate_packets(ieee, ieee->prxbIndicateArray, index);
+		rtllib_indicate_packets(ieee, ieee->prxb_indicate_array, index);
 		bPktInBuf = false;
 	}
 
-- 
2.30.2


