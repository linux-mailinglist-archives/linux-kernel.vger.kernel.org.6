Return-Path: <linux-kernel+bounces-184452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB48CA6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D7D1C20ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405827C080;
	Tue, 21 May 2024 03:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="GDtwBcK+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EF77F2F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261465; cv=none; b=sg0/zLaJQAbnUp/+C/ZqP1yROonN/vSqYlMdhMStA7SVgEPNMoS5R4BnjCkscbZd0AvCQPre0Is7THxCBNl6NR5lipgf5x7pe3lSWNHsduHtarpwG2RAIDKq4OBOJrj/2ih02ckFNIz+tK/dgYUbaCu3G3ikAzjm+OsfQKIYwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261465; c=relaxed/simple;
	bh=WpyAz4wfmdfSZALVu3DB4xV0NpQuAtGDfjdRDPjwzzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJ2AW0GDAPXwro3yk2Qazg64Ir/hewEKGi6b1R6on1bD97UNGITitBvf6cJsQ1cG0NbmNsXCqAhI0m1gexKtFt8mspyGahAdSrMgXI4a9z5slNlmJ8ZTYkyRf1TLJ/UFbsrkzrkUtAKN2sG3kPVuHGpSzGeJ2Txetl3opZiFCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=GDtwBcK+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ed0abbf706so26890575ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261463; x=1716866263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yp9yXgV9Klh/+mkE2OY5ZmNDFLPm1WNDo65CGEwjjY=;
        b=GDtwBcK+n4BjNYqKW7Vgfl6ZrJbMsyRxmk3DQmFxCyivdxDdPXa5sZsNpReYTaZ8p/
         G02jpr8xI1m2SCGajmGOiLIwe3YaIc/9CSe3yqI0xjggmsIoRJzR9v5XB+aCoCOnBOws
         73n5HRd1FNTuFr/PrtCvaNs1lJUpuQzwWS2Si+5GNLECakmHfS5n66X8d/M+PQ3FUbUs
         rmQ10LrcqqQ+kflQwOjrcYZN8p0j+vB33CC9rgIYyvgqQxQ2snjBRtYQr+PV4wo2feuo
         RITTM7bzAYQBRbqw3jGWevNUEfoAZRC3qEIqHRFhlMsSVVgup0PLtVQI8NAyhtQnBQfy
         Wr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261463; x=1716866263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yp9yXgV9Klh/+mkE2OY5ZmNDFLPm1WNDo65CGEwjjY=;
        b=O1akir5YsjJqo7r7HDtwRQd7LT6zrnFM313i9sTt3Rs7wwaOyh2g82dRLVPDy0HqEm
         MXQdTrvRZCQ6kU2X9rCXoU29bS+8RYtxqF8FMqUQ4mTmWefBxOIhcGDJkbzNMpfzxlxZ
         H9CgZkZD+M7d7RGMSbCNCo3YYJRJgJZQj2sOUFDHm+LkUlaIH3RPrFSZhFa7M4/Ah1Kr
         Hds9ea+LXb6DWxTauZ3jEpDG7n+Vd0iIuXWj34hJJ3FrbRdfKC37uE+gKMdEgicet0+5
         MNb0/ltZZ9QjiGrVmHegxFtAo6Z3UyGmpXSkt8dRFHDVyE8E59U6q1YAbYcweoYr0f9D
         ELBg==
X-Forwarded-Encrypted: i=1; AJvYcCXLMw1zorlRmsECJcshr6dCt35eNyvS74WMZWQ8xn8aUgfH2pqgOqcX62zGV8LYaNUhBUAXHlhBXqQy/7c/2NLQSDOsxGJ2bMafifJa
X-Gm-Message-State: AOJu0YxL++1lgPvklOMze2wJTT3QWICsUB7FQ8mNqqox8TOl6Qk6jsfU
	SMvdTcTQAWgwduVX7cEY/gBDhLa0Bqw6ImA7OR+0v8BePkkE+Vb/W0pgzBEQ4GnWYMio2Ff2tbp
	y
X-Google-Smtp-Source: AGHT+IHs6mSWS6UdBkpPE/OJN4puMJl+wlxrOdvXDxZwnag1VOT2ZFK/LfZ1pCZ+djJMxnGbyCbwNA==
X-Received: by 2002:a17:902:c942:b0:1f2:f3dc:43ee with SMTP id d9443c01a7336-1f2f3dc4ddbmr85796915ad.3.1716261463134;
        Mon, 20 May 2024 20:17:43 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:42 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 28/31] Staging: rtl8192e: Rename variable IsQoSDataFrame
Date: Mon, 20 May 2024 20:17:15 -0700
Message-Id: <20240521031718.17852-29-tdavies@darkphysics.net>
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

Rename variable IsQoSDataFrame to is_qos_data_frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 9b0a981f6f22..36a734ded7dc 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -625,7 +625,7 @@ EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame)
 {
 	if (ieee->ht_info->current_ht_support) {
-		if ((IsQoSDataFrame(pFrame) && frame_order(pFrame)) == 1) {
+		if ((is_qos_data_frame(pFrame) && frame_order(pFrame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
 		}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ca69bb0965ba..e2695beaf582 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -340,7 +340,7 @@ enum rt_op_mode {
 #define	FC_QOS_BIT					BIT(7)
 #define is_data_frame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
 #define	is_legacy_data_frame(pdu)	(is_data_frame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
-#define IsQoSDataFrame(pframe)			\
+#define is_qos_data_frame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
 #define frame_order(pframe)     (*(u16 *)pframe&IEEE80211_FCTL_ORDER)
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 3e8ee1335c24..4d4a4a830470 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1319,7 +1319,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 
 	/* Get TS for Rx Reorder  */
 	hdr = (struct ieee80211_hdr *)skb->data;
-	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
+	if (ieee->current_network.qos_data.active && is_qos_data_frame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1)) {
 		TID = frame_qos_tid(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 1aeb207a3fee..b1bde5c0050a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -275,7 +275,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
-	if (!IsQoSDataFrame(skb->data))
+	if (!is_qos_data_frame(skb->data))
 		return;
 	if (is_multicast_ether_addr(hdr->addr1))
 		return;
@@ -472,7 +472,7 @@ static u16 rtllib_query_seqnum(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	if (is_multicast_ether_addr(dst))
 		return 0;
-	if (IsQoSDataFrame(skb->data)) {
+	if (is_qos_data_frame(skb->data)) {
 		struct tx_ts_record *ts = NULL;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&ts), dst,
-- 
2.30.2


