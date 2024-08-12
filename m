Return-Path: <linux-kernel+bounces-282473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9C094E47D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52894B20529
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006E4D8CB;
	Mon, 12 Aug 2024 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BRrH/ZSJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD571200A0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426618; cv=none; b=Rf8w8HhGVW90MwmpquQQJbelwH91Dz12nZCziX2Gp4N7ML8lJCBTXjhqCsIqrzTxG/OVP7nW4uRHpbok1FVPBgvW2fSfwgo31BiLlK/Itg9pXn5eHkNtYYQnHm1Qgk07CMI9RhZnVb6zg3YQCQ/1aqi4IWHhj2GAhC0gfnccQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426618; c=relaxed/simple;
	bh=04yFoPijqrDz9urRG1Ayj+mvRBPdpsRTHeacBiCuaoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c5W41F6p63fH/xvvP7ku0q0IiI0tnAaf9COnY1n1xwRY4nVLH1nIqmslrDhp+QfXdmGZuihhi/Cy/77snFoMGiLkor0rTWOnswjtKggryleg+fz61ztoz1JiwMmZ6NckM1dEYBzDui9BrClAAb4+/uzykGfZh0gaJh/65t/7dbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BRrH/ZSJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd90c2fc68so25638685ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1723426614; x=1724031414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64D2428cbRfebktVpMJBEPRgQBO5r6MLybajTnMBw58=;
        b=BRrH/ZSJPQPN5rQfwvscUA0sHMNa3FPbMjBo72FsDmI5hS1zA1vnwfJci27h3CT813
         HFQDI4Ejte3fpKdNsZ6eogm0aQ9NhJ2FSZOT1d/4GR59QwIGGokzU+orsSV/bC9zGItx
         T017/VRucdPqaI+vekTWXmYyVeAmfIh4peCvsZ2Jk3725pvSkYRT6UnIV6A85M+J0cmx
         CVncaqbdxy+Nrl7nSlJ3P/6VFvNfmyjJY5FKJFAWXW7j1CA7HQRAUu5VwEn9Eg6gPkK3
         XdWAD9AHA4olMuDDdpvhqtwfCIvoTtOwZX1bn22j7pJbSuQdMTZIuSpQVKaSbJiBla/g
         IqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723426614; x=1724031414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64D2428cbRfebktVpMJBEPRgQBO5r6MLybajTnMBw58=;
        b=tbCxbql+dnnIucX4rL8ChP8e0OHugH3RxtycRyzBh1PryBRd5Xg7Os6VODLjPzw5kO
         BScmBqzSDxzbYHKTo9QYoB7zQ1ObaU7Me11BzqJm3uHx+0Zfft06v+y9/pVyhLWJXFaZ
         W6h4Ip39YA/40N6BkEib+zArVjm7kBl2mVwuezYp+xPkt4HFJpQHYQexu8Jbim5zBVLf
         TCvgUylWudDbX/+NLaWsyopGbWegJAyFkq52r+Fhxir1iau2x9WrIPag1b4ivhvb289P
         jg19VfOV0BAWZUE8l3I00JuZcBaHtEazLbHjS+9ThWmdkPE6pSEoBis6tunO978XBYDM
         BTnA==
X-Forwarded-Encrypted: i=1; AJvYcCVp7Xlyf7/fs9oltcD9ejEke9pxF2mOycepMKIW+0FPc2296q1hCD3wpxD/cs6ZaNCeDWCxPvMdsqykqEvPe70TdbQN7ovCCUDvmR/h
X-Gm-Message-State: AOJu0YzImrgk3YKMWdVEd6UeiNeYnT+i+AVES1HGwjZlBDJx7MxL3C1f
	LcrYTOBMu+DspbaSRgn9JuOUhOwl/0b03Faj09CCAHpBikV4t2Ix/0IG1Hj4Pf0=
X-Google-Smtp-Source: AGHT+IFp+H1zPnrqeYHUYvBm2T2dzS46WIk2T5VoZVCJ7vauhRRsaiH0dgN+Qv2KDltNXzPByqhgsw==
X-Received: by 2002:a17:903:2288:b0:1fb:67e0:2e0a with SMTP id d9443c01a7336-200ae5d7771mr64457715ad.48.1723426613925;
        Sun, 11 Aug 2024 18:36:53 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb442besm27386925ad.290.2024.08.11.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:36:53 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH] Staging: rtl8192e: Rename variable nSubframe_Length
Date: Sun, 11 Aug 2024 18:36:50 -0700
Message-Id: <20240812013650.199675-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable nSubframe_Length to subframe_len
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 69ad74314260..94dbdaf8da82 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -729,7 +729,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	u16		llc_offset = sizeof(struct ieee80211_hdr_3addr);
 	bool		is_aggregate_frame = false;
-	u16		nSubframe_Length;
+	u16		subframe_len;
 	u8		pad_len = 0;
 	u16		seq_num = 0;
 	struct sk_buff *sub_skb;
@@ -781,20 +781,20 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	memcpy(rxb->dst, dst, ETH_ALEN);
 	while (skb->len > ETHERNET_HEADER_SIZE) {
 		/* Offset 12 denote 2 mac address */
-		nSubframe_Length = *((u16 *)(skb->data + 12));
-		nSubframe_Length = (nSubframe_Length >> 8) +
-				   (nSubframe_Length << 8);
+		subframe_len = *((u16 *)(skb->data + 12));
+		subframe_len = (subframe_len >> 8) +
+				   (subframe_len << 8);
 
-		if (skb->len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+		if (skb->len < (ETHERNET_HEADER_SIZE + subframe_len)) {
 			netdev_info(ieee->dev,
 				    "%s: A-MSDU parse error!! pRfd->nTotalSubframe : %d\n",
 				    __func__, rxb->nr_subframes);
 			netdev_info(ieee->dev,
 				    "%s: A-MSDU parse error!! Subframe Length: %d\n",
-				    __func__, nSubframe_Length);
+				    __func__, subframe_len);
 			netdev_info(ieee->dev,
-				    "nRemain_Length is %d and nSubframe_Length is : %d\n",
-				    skb->len, nSubframe_Length);
+				    "nRemain_Length is %d and subframe_len is : %d\n",
+				    skb->len, subframe_len);
 			netdev_info(ieee->dev,
 				    "The Packet seq_num is %d\n",
 				    seq_num);
@@ -813,11 +813,11 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 		 */
 
 		/* Allocate new skb for releasing to upper layer */
-		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
+		sub_skb = dev_alloc_skb(subframe_len + 12);
 		if (!sub_skb)
 			return 0;
 		skb_reserve(sub_skb, 12);
-		skb_put_data(sub_skb, skb->data, nSubframe_Length);
+		skb_put_data(sub_skb, skb->data, subframe_len);
 
 		sub_skb->dev = ieee->dev;
 		rxb->subframes[rxb->nr_subframes++] = sub_skb;
@@ -826,10 +826,10 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 				   "ParseSubframe(): Too many Subframes! Packets dropped!\n");
 			break;
 		}
-		skb_pull(skb, nSubframe_Length);
+		skb_pull(skb, subframe_len);
 
 		if (skb->len != 0) {
-			pad_len = 4 - ((nSubframe_Length +
+			pad_len = 4 - ((subframe_len +
 					  ETHERNET_HEADER_SIZE) % 4);
 			if (pad_len == 4)
 				pad_len = 0;
-- 
2.30.2


