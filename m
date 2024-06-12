Return-Path: <linux-kernel+bounces-210869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E140690498C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA4B230AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1C5A11D;
	Wed, 12 Jun 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="G5lcZRzj"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DB20DF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162564; cv=none; b=Qla4v0XHqjWU1FiT1iB+baPL7IjX/akz0YBJK2k53TIyAQXLyK9l39akxrSSAvAaJuY0WFSOfYsdCHPteuNpUN2WlMF24Q2yqR2LYgoMz8VrZg32b8A2DIr9CIkwgyzabjEhq/G12EtX538a2ubfQIzK52nhVxT7INrl31H0w0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162564; c=relaxed/simple;
	bh=QbUBSmjsgcQ+yp9vq20Gros3Iliy6wnVzFRdga3AKA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFZlL41WxEz2iWHETOnxxUEznuAN8A2rsxF1rBJmrbIDE5AhnsPYghklwGLxD/LVcF9rW+uovnBXqHicI2ksLLg+WkmNmz0ItE8MjFlCf4P07PrIcLLrtFztrXpZZMbfiNqBFInj4Xv43DYZLAiI3Uqbmxvk+1o3HkevDrDbTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=G5lcZRzj; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7eb75c0d0a7so130381839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162562; x=1718767362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8sMnW0eAHI5c5WMUrja3LieEYZJVOVr7MzsVIly6Xw=;
        b=G5lcZRzj/m8y4hOw1iGlSs4N2PPJlD9xpAzlrUxIzN5W1kcjANnv0oktDtbVZoWXJi
         SZPoch4tPy/pmFwsw2Ruy7bVknXLbrryyhsf+GA36MmoTYo6MU2rRPtGWFlSqyY+x3in
         0VsI1qdDJlnd03zZ+4/Mcq3/qTuauocU9S6aswOBPGD1zg/Ix8sO2fDQj1Xksdf0bcy8
         IOCuuystleBdMKjSWExMCA3nZO8dgCg+uyETP7Cia6wiMKy6Z2cRLiCG33fXfadN8VJN
         QBqyJYLZ8uTNbWzTtXIppFsBpU9RXI4S/mA9wns0/H+OyCC9KinZAepR1Vr1tu1SDAoK
         fmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162562; x=1718767362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8sMnW0eAHI5c5WMUrja3LieEYZJVOVr7MzsVIly6Xw=;
        b=nkkuCCeT4aumCsOmzQVQwzY4tOuoHuDbrIkzjTnEBQ+0Vhsv+RFw/X+xtfv58mAsNt
         hdHLZJVHp+DkZ6F1rU3Lv/S0ebQyeIUcJza42x6SZ3wooMVuRnoz485MTDGx2JgjKjwZ
         EPSpSzMr77l1ncY3uMmIDZDc5HS06mmYgcYZLIWvlJJtq3b73iIJeXz9cW7gC9vHBmeC
         9CtypTT7BA1UiO7spN3sp772kckTsRmQCyI1LNt2kxz4wfQ2e2/Ha8JAUqmF4hQjVrS+
         xf8QulNfwL2/JfcsKwmpUFUP6+NcUuvaxbG2/ImbM2qEh0IM9Z/3ZaIurLdvJTyRa4H2
         pz/w==
X-Forwarded-Encrypted: i=1; AJvYcCVJyGjoP/1vMawtSOM9SKXmrf87E0wouUJ7WxhzjnNxSoQVIMlbIKgUCjwyKmjJf2wmL8kdaUcTilvctTYHvTmAArbsbZI1kOIS2Y8v
X-Gm-Message-State: AOJu0YxIpXDVLrtYMt0X81z6SIiUBbKfiWvNyjO3PhTfk2GcdqdMH24T
	owkG6j7F3GyV3Yg0bTbX3dCxTn4J0Ex4fovoOAnqjboybk3dBbX3qOJFX78S7e0=
X-Google-Smtp-Source: AGHT+IF3I99/RtSbV0Y2cndGX1Hmd3671JjmeV4fsfA2l42oyupsJUr/uEOXN4rZkhrE4xj0rJEwOQ==
X-Received: by 2002:a05:6e02:2185:b0:374:9a3f:d197 with SMTP id e9e14a558f8ab-375cd1062c8mr7052755ab.15.1718162562053;
        Tue, 11 Jun 2024 20:22:42 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:41 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 11/24] Staging: rtl8192e: Rename variable bBroadcast
Date: Tue, 11 Jun 2024 20:22:17 -0700
Message-Id: <20240612032230.9738-12-tdavies@darkphysics.net>
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

Rename variable bBroadcast to broadcast
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1f4c1f1f0274..812aeabb4a52 100644
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
index a3c211c1b0fa..1ea7157127f6 100644
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


