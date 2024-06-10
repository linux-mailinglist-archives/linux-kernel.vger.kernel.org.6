Return-Path: <linux-kernel+bounces-207674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D296F901A69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AC1B211C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D557888;
	Mon, 10 Jun 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gqtdUCUq"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849894206A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998548; cv=none; b=KPdw/nFA4j3F3yL0zi/ySRl313m8xOqm2R1OgPLCVBPCbR7Q63/NC6mIszLtH3ntgEP528/r2JT5dw7hFvkwmVgraGCEkCY15y8PJsYXhMOOIWjHdSfIS0YsUmjKQtUBkN9ceQkuKvJyIWAnCiKDUB8076sSdUgwSUwiXbe4clA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998548; c=relaxed/simple;
	bh=0GD7G1Vwv7kDlRNA7lR4uSQMswjkLa2vIBVTEak38QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITbpGYdZ+2oJPkgHQZ9SyK2Gean/qAtqIPYtxUsr0cU63GvetFt8oK6NdM2ssrY2OYOMbnNpkOJmJx6jsPm4LM86henl+86N2SPuhWab8PhYJUtfDcOXy4jNGRfkZ8cSLspYh00qXAVffMb8ENjLLBVXemYrECwm77tS2eBctZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gqtdUCUq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07acd3so37199345ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998546; x=1718603346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0nKHmebWMhFegYfeXGZXharf0UnBjbJDtsA11DQNZA=;
        b=gqtdUCUq34uYZETsaTyOku0mZBy5vc/FnUU9eXat0DYN+hLGTXEC0C+YvDfvp26w88
         zlQGFaBb9U8YMTiNdKTlhnOO0r+uCJIuDHjIYZwrSvD0J/hamaN+hMiEx/s2lU4SKY6Z
         VD8fwgh2KW4FT1b5g9b8geywMqMXgusPW8gux05WicY4YXHgB67+G7pBJcs7kDBnHkuS
         sjbqT6EKRFbZUV7fDM+Ndle9hsu8ezz2c1ZII1frg1GngYXwSxrXYMa6YwlF3AT3RUsW
         jLYsCcuzVonMbK5UK7Tu6lvkdAC89sg3ov1UY1/E4O3YwE2/R9s+UHgUaoyJ1rfveDfW
         rpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998546; x=1718603346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0nKHmebWMhFegYfeXGZXharf0UnBjbJDtsA11DQNZA=;
        b=DtCjlkjW1/RlWqtYjXzsEdatc/7OlKal+wB5r+Lpdpa2qApsfTk6fwGhtZtATdClH+
         ajn50qyg9HeJU075u0JLLTXqjIvq2/97Z9U0Ce9h8XjBDnuj70EQNc5zm3/iUfwCYZPg
         IpOrNIA7DbSXG3/kJsIt/jKE/Ep5qz6Hf+ukNHKICAK9HS0T85kusizmF0Y54Ne2Euwn
         RIlole1bZO7pWBtGp/aWoK6dOqEHJzA0yvUyhUE6wJ2CRxtDOiPeRGnLOeDxEJJ55Q2V
         pOORAzzKT9V7LVe/k2ymtWus+YnQFlzfeL7jBuv9ppUjMCy6ai5CDK0bKSxlyanTwo2a
         CbQA==
X-Forwarded-Encrypted: i=1; AJvYcCVz4MQWYI3In0KoLuE4LH6f3YE+SZZ9pEk2ziGy3wYT+xmGPzpYtcIsVHdkdwQKEUIZZt4+sJAvwCaMAU28IQ5T19R8FAboRxEMkQgY
X-Gm-Message-State: AOJu0YxLugA7phOt+6upCUldw6OX3lPWO+bWrhjkLgBbPIKSF3vUfqFA
	HYmh9qMNx4H3/SEtu5OaKRUGSkKQXixERBxlMSgwk0kQNydpMay1mGhbeKI146c=
X-Google-Smtp-Source: AGHT+IE+MWn8AGYk+iDcr6HdHc1cHGYDDZk/KWKWpTgfzPbm4F8zKvYLd5Ab82NnfczA83PqX6I3lg==
X-Received: by 2002:a17:902:ced1:b0:1f6:fbc2:526f with SMTP id d9443c01a7336-1f6fbc254acmr51796665ad.32.1717998545967;
        Sun, 09 Jun 2024 22:49:05 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:05 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/24] Staging: rtl8192e: Rename variable bBroadcast
Date: Sun,  9 Jun 2024 22:44:36 -0700
Message-Id: <20240610054449.71316-12-tdavies@darkphysics.net>
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

Rename variable bBroadcast to broadcast
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7a5accd86809..4bd7a85e2411 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -124,7 +124,7 @@ struct cb_desc {
 	u8 rts_use_short_preamble:1;
 	u8 rts_use_short_gi:1;
 	u8 multicast:1;
-	u8 bBroadcast:1;
+	u8 broadcast:1;
 	u8 drv_agg_enable:1;
 	u8 reserved2:1;
 
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index ca123864e12b..0c58b70ae03f 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -356,7 +356,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 
-	if (tcb_desc->multicast || tcb_desc->bBroadcast)
+	if (tcb_desc->multicast || tcb_desc->broadcast)
 		return;
 
 	if ((tcb_desc->data_rate & 0x80) == 0)
@@ -378,7 +378,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 	tcb_desc->RTSSC				= 0;
 	tcb_desc->rts_bw			= false;
 
-	if (tcb_desc->bBroadcast || tcb_desc->multicast)
+	if (tcb_desc->broadcast || tcb_desc->multicast)
 		return;
 
 	if (is_broadcast_ether_addr(skb->data + 16))
@@ -845,9 +845,9 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			if (is_multicast_ether_addr(header.addr1))
 				tcb_desc->multicast = 1;
 			if (is_broadcast_ether_addr(header.addr1))
-				tcb_desc->bBroadcast = 1;
+				tcb_desc->broadcast = 1;
 			rtllib_txrate_selectmode(ieee, tcb_desc);
-			if (tcb_desc->multicast ||  tcb_desc->bBroadcast)
+			if (tcb_desc->multicast ||  tcb_desc->broadcast)
 				tcb_desc->data_rate = ieee->basic_rate;
 			else
 				tcb_desc->data_rate = rtllib_current_rate(ieee);
-- 
2.30.2


