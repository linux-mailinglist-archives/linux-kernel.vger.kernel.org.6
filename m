Return-Path: <linux-kernel+bounces-207666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A1901A61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CC2281955
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2681B948;
	Mon, 10 Jun 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lUZ7QlmM"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A617F6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998541; cv=none; b=YIIEW1GDjP7idJsa8c2gdcG+6QPX9uQpOQ6iofPaS/sxaoC7e6PZn28mBZp/ozhJ1O6AHQw3jvXB3zATlFNPMD7YTxE7nBDRnFTypUkZ3tv7p0DPyExf3pJ64iw7BM5G/XJj2IoOdMMdjSHMC2NflHiyZrCb22UUegUzkLnr6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998541; c=relaxed/simple;
	bh=wGuLcEvBM1TxJVrx7wgm+rJmZyAPeLFY2yA7Snu4PlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX4G3Yoly8WzMv2x9yFON2hpWZ02Sc8fA7lnSEJPi9k5kkwxVl1Aw52d9yTZQPm/qOw4rZeWTKJA7Sh0YMYEbTCn+9tWZ0ZD29Fk0F/b4nWM0rZntkOPVloUXt1ZrNJ9BK3M6aZe5yq6AAGW8s7NZw5+9PxEJ8H2xY/XGSIfXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lUZ7QlmM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so3529355a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998538; x=1718603338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS8+tN2wE0yBpRCgcBNKFr5QsSiOhIdKbcY3TBHOZic=;
        b=lUZ7QlmMSl04GIANHuxC9XPIZ5OpYMvRPsMWi+9mhcB7JaPy9/K8hJZoFRITlzsoN7
         SPIZkCbTd7RPcLHk2nd6onFrAEKtzzmZGEFjgATfvwhaMidLZ+HO32r3bfdn8fOIoPiX
         PvDI9wXEbOdw2DUxGiskLyeR0ne1vTOnycAVFfx40vGjA+t1LA72jD9JuipxiP8w5BaL
         ERrQ6xlobdtAHKRdBl508pLBxmfJgC/oHBECElQv5J+NeyuQ7VMJHdfXf4RwbX5L73oZ
         wwEth7gkBSq/0Mn13N+ObOkMp9GpMnNJj6y+N6qunj1/tpMAhb9fxTseOVg2XpnfQuRi
         cIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998538; x=1718603338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS8+tN2wE0yBpRCgcBNKFr5QsSiOhIdKbcY3TBHOZic=;
        b=EJ6ZJTNK0Apm1aYDb+EvLVYWE5Nb5gdtvV8wPsekc+mLkWKDrgDRNsA3PKBRMfeRAw
         JMw8IuCSyUWWnGOpNtf5hN8geyUBqc6g+mmpLcZ4kwIvSu4B34yOQ/vrZddN+XGSG68m
         zw3tQQI2nxjdChvcL3Cc6bdygPoJDr2g/bWUlo9AhC1ASJV9sqwK7Wcyw94un7YpZYwi
         D5VPA/b3Rg/aBgD97dEsBnAl+jXvC5nF7PH4e+xe/NzvVpLzT8rHkprKu1h6OSd+oQv8
         OS5Wohk6tzNMvIz8xaR4wdvsinu5RUCAnQjvZEpwxEPDtU6pYp+64Y4+dHcTTWV5TefS
         zW8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPyE8Yk2WDceV8peVileR4huJ6QPrsljQZEXycvu4z5I1RACTG/WaxmlEDDNKb9PUds+BUe/acXLuA3Znw/set1KeK3omG/7hoMOmC
X-Gm-Message-State: AOJu0YxPCkrM5A/yp+InMvgLqMdppjUpW4D8mKDGsTEukwzA5w7S9/LC
	HMVcsMA177CUMklcw8/Lg4yHkeW1OF5lOJPu0KHbzTPDBaJpLRNLZ/15w9mtR3M=
X-Google-Smtp-Source: AGHT+IHPeIIVRuksUR2EounPc0w5SxO3M055OQucGnBel37jU/DwJqO16utCbowWjdkxfq9/KnuKAA==
X-Received: by 2002:a05:6a20:1583:b0:1b6:cd8e:4a4 with SMTP id adf61e73a8af0-1b6cd8e087amr3491610637.1.1717998538232;
        Sun, 09 Jun 2024 22:48:58 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:48:57 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/24] Staging: rtl8192e: Rename variable bHwSec
Date: Sun,  9 Jun 2024 22:44:26 -0700
Message-Id: <20240610054449.71316-2-tdavies@darkphysics.net>
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

Rename variable bHwSec to hw_sec
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c   |  4 ++--
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c   | 10 +++++-----
 drivers/staging/rtl8192e/rtllib_crypt_wep.c    |  4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c           |  8 ++++----
 drivers/staging/rtl8192e/rtllib_tx.c           |  6 +++---
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index a0fc33f984e8..27dfa268cd68 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -934,7 +934,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 
 	pdesc->NoEnc = 1;
 	pdesc->SecType = 0x0;
-	if (cb_desc->bHwSec) {
+	if (cb_desc->hw_sec) {
 		static u8 tmp;
 
 		if (!tmp)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 62af48c20229..46bc3561f56f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -105,7 +105,7 @@ struct cb_desc {
 	u8 bCmdOrInit:1;
 	u8 tx_dis_rate_fallback:1;
 	u8 tx_use_drv_assinged_rate:1;
-	u8 bHwSec:1;
+	u8 hw_sec:1;
 
 	u8 nStuckCount;
 
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index cbb8c8dbe9b0..230552dd2b4d 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -182,7 +182,7 @@ static int rtllib_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	*pos++ = key->tx_pn[0];
 
 	hdr = (struct ieee80211_hdr *)skb->data;
-	if (!tcb_desc->bHwSec) {
+	if (!tcb_desc->hw_sec) {
 		struct aead_request *req;
 		struct scatterlist sg[2];
 		u8 *aad = key->tx_aad;
@@ -265,7 +265,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		key->dot11rsna_stats_ccmp_replays++;
 		return -4;
 	}
-	if (!tcb_desc->bHwSec) {
+	if (!tcb_desc->hw_sec) {
 		size_t data_len = skb->len - hdr_len - CCMP_HDR_LEN;
 		struct aead_request *req;
 		struct scatterlist sg[2];
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 0244b524a7d4..a45fcb13bd54 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -268,7 +268,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 
 	hdr = (struct ieee80211_hdr *)skb->data;
 
-	if (!tcb_desc->bHwSec) {
+	if (!tcb_desc->hw_sec) {
 		if (!tkey->tx_phase1_done) {
 			tkip_mixing_phase1(tkey->tx_ttak, tkey->key, hdr->addr2,
 					   tkey->tx_iv32);
@@ -285,7 +285,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	memmove(pos, pos + 8, hdr_len);
 	pos += hdr_len;
 
-	if (tcb_desc->bHwSec) {
+	if (tcb_desc->hw_sec) {
 		*pos++ = Hi8(tkey->tx_iv16);
 		*pos++ = (Hi8(tkey->tx_iv16) | 0x20) & 0x7F;
 		*pos++ = Lo8(tkey->tx_iv16);
@@ -301,7 +301,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	*pos++ = (tkey->tx_iv32 >> 16) & 0xff;
 	*pos++ = (tkey->tx_iv32 >> 24) & 0xff;
 
-	if (!tcb_desc->bHwSec) {
+	if (!tcb_desc->hw_sec) {
 		icv = skb_put(skb, 4);
 		crc = ~crc32_le(~0, pos, len);
 		icv[0] = crc;
@@ -319,7 +319,7 @@ static int rtllib_tkip_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		tkey->tx_iv32++;
 	}
 
-	if (!tcb_desc->bHwSec)
+	if (!tcb_desc->hw_sec)
 		return ret;
 	return 0;
 }
@@ -371,7 +371,7 @@ static int rtllib_tkip_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	iv32 = pos[4] | (pos[5] << 8) | (pos[6] << 16) | (pos[7] << 24);
 	pos += 8;
 
-	if (!tcb_desc->bHwSec || (skb->cb[0] == 1)) {
+	if (!tcb_desc->hw_sec || (skb->cb[0] == 1)) {
 		if ((iv32 < tkey->rx_iv32 ||
 		     (iv32 == tkey->rx_iv32 && iv16 <= tkey->rx_iv16)) &&
 		     tkey->initialized) {
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 21c2b7666d6f..bd732c562b82 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -102,7 +102,7 @@ static int prism2_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	/* Copy rest of the WEP key (the secret part) */
 	memcpy(key + 3, wep->key, wep->key_len);
 
-	if (!tcb_desc->bHwSec) {
+	if (!tcb_desc->hw_sec) {
 		/* Append little-endian CRC32 and encrypt it to produce ICV */
 		crc = ~crc32_le(~0, pos, len);
 		icv = skb_put(skb, 4);
@@ -155,7 +155,7 @@ static int prism2_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	/* Apply RC4 to data and compute CRC32 over decrypted data */
 	plen = skb->len - hdr_len - 8;
 
-	if (!tcb_desc->bHwSec) {
+	if (!tcb_desc->hw_sec) {
 		arc4_setkey(&wep->rx_ctx_arc4, key, klen);
 		arc4_crypt(&wep->rx_ctx_arc4, pos, pos, plen + 4);
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 86b8d342ac80..3bff54efe66e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -282,10 +282,10 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 		struct cb_desc *tcb_desc = (struct cb_desc *)
 						(skb->cb + MAX_DEV_ADDR_SIZE);
 
-		tcb_desc->bHwSec = 1;
+		tcb_desc->hw_sec = 1;
 
 		if (ieee->need_sw_enc)
-			tcb_desc->bHwSec = 0;
+			tcb_desc->hw_sec = 0;
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
@@ -321,10 +321,10 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 		struct cb_desc *tcb_desc = (struct cb_desc *)
 						(skb->cb + MAX_DEV_ADDR_SIZE);
 
-		tcb_desc->bHwSec = 1;
+		tcb_desc->hw_sec = 1;
 
 		if (ieee->need_sw_enc)
-			tcb_desc->bHwSec = 0;
+			tcb_desc->hw_sec = 0;
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index b1bde5c0050a..87d1ff943617 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -751,14 +751,14 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 
 		if (encrypt) {
 			if (ieee->hwsec_active)
-				tcb_desc->bHwSec = 1;
+				tcb_desc->hw_sec = 1;
 			else
-				tcb_desc->bHwSec = 0;
+				tcb_desc->hw_sec = 0;
 			skb_reserve(skb_frag,
 				    crypt->ops->extra_mpdu_prefix_len +
 				    crypt->ops->extra_msdu_prefix_len);
 		} else {
-			tcb_desc->bHwSec = 0;
+			tcb_desc->hw_sec = 0;
 		}
 		frag_hdr = skb_put_data(skb_frag, &header, hdr_len);
 
-- 
2.30.2


