Return-Path: <linux-kernel+bounces-207673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A0901A68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67078B20B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F315405E6;
	Mon, 10 Jun 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gPtm/pFs"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B43CF65
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998547; cv=none; b=eVXt9nsK11FIXHN5d4mmzCfHELY+1f0Lo1JUUQ7rV/iWB9ktLuTZ3DWVVixtLx2hF8MltFQ9quafTeYLlMriUh+fkj7TS84FiTbCyZ3J3RYiPtY0ah67ePs1tOuceHM8yM/liGQwKzWMeZuwE2BUZAe5k6Ar2i8VEd38wVpnkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998547; c=relaxed/simple;
	bh=Q8sycNIBmISu4V8VNPWwVK1OzmjNF6dZvBmnPNg4xwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pn3EXOM28LW8bLGyh2eqBOLg833g1o9rVuJ93+8rsi5pg6K6iFtqGx4nqLG2qz25ajg0SHMNJQKzHfiFM3BnfIaCwkBB2lPCftUIM59PsI4+5mZWXxU8Me113G3Befjw5ouYZFuOdoLaiqgvSsCzNribeyCAwulE+Ji4v1JHvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gPtm/pFs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f61f775738so33755295ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998545; x=1718603345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffNLik5BpVMPcX0GZgSkdJYQV3xGsiuU5zDpo0EWA6Q=;
        b=gPtm/pFsUdNSML7bDiUFjsR8c9GnVtmJg+4PoBIi4iCv8npWgJlUiXjdykPi72Os2N
         GUcexbvQ5pM/6KzcDykssT3Rw/SUPwl0S+YCslZnaKAiD699fpQoUGiFK/uPajoFOvvy
         JkM9KAT/dEi1xxojbhshoSndZsrRhekOUw62ruQ6lOWDS/72U7Jdwhsdk5LpNNtbPTdP
         jk/L8f608cQMQMx3qdqSBjHy9deYJYKUF8pHbJMLoEQQnXFEjUGR4SctcEBJE/3+WSfF
         XPZeP/qEN598XI+co8jggnkt718Yu5m7gxpMKXWDT2FdGBEZg0QFcO227GGhMI7ma5af
         DILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998545; x=1718603345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffNLik5BpVMPcX0GZgSkdJYQV3xGsiuU5zDpo0EWA6Q=;
        b=Fd2igkO0tiBtpiR14KWioJda9ofhFMOMwHbIizMbmM45OoBeYiMNe/2dtWBzEV1tAw
         xVho/+QqUS8Pycl72f28wW6QbtHxVmFCgZhD4Nw7OL95sNItELBrQmiZVewupHb3Q6wC
         av3W0dPO/nw8zu+q4PNyl38M9RTLEG2x7Tufzhe9dXcTs7RB7eM6CMivHcdvT/m+JJng
         3FQAKBuFq4JVzb/i8lbBAEi99UkcesZDGusnNPyajXzECF4OZfJSovsA0rHxtPNrrWSL
         IAqzJeL0dZDhCOED/aPWcdmdPkFRiVpFwlmibMUG+hQWcQGgtH5mYZIwaojXhjTC+exE
         +FFA==
X-Forwarded-Encrypted: i=1; AJvYcCVDVCBiWoQyO8ybvWTk1ZlMK+UoxFZMFLmqt6h+qpV8FE5bYYiY9PUxc1dycUtZftvuA6nTpxN41AT+OMIgZTmeWru53N36V9Jm3C+Q
X-Gm-Message-State: AOJu0Yz/hVpQD3Ch5SyIuPDNFkDaj0NMZv30FE3nV9oUlDbyoIMpw3Fc
	v32u5QKmmwSHWw9I2ZQce82cYp7H0OZ/A76jsiVpHoDtC3rMJAw3o50ruatCbV4=
X-Google-Smtp-Source: AGHT+IFvBvoS/jhXBvQ7ZuGZJx0k572KWDX5cPtXs3TgNg/vmPxGHvNsKYrytxNPlrLEGAvVQ1BqFg==
X-Received: by 2002:a17:902:e751:b0:1f6:7df5:7c07 with SMTP id d9443c01a7336-1f6d0301d47mr96767995ad.39.1717998545292;
        Sun, 09 Jun 2024 22:49:05 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:04 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/24] Staging: rtl8192e: Rename variable bPacketBW
Date: Sun,  9 Jun 2024 22:44:35 -0700
Message-Id: <20240610054449.71316-11-tdavies@darkphysics.net>
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

Rename variable bPacketBW to packet_bw
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index a52db6b1fdb5..8dec4e1b89b8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -903,7 +903,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 			  (cb_desc->rts_use_short_preamble ? 1 : 0) :
 			  (cb_desc->rts_use_short_gi ? 1 : 0);
 	if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20_40) {
-		if (cb_desc->bPacketBW) {
+		if (cb_desc->packet_bw) {
 			pTxFwInfo->TxBandwidth = 1;
 			pTxFwInfo->TxSubCarrier = 0;
 		} else {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d0da16a86633..7a5accd86809 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -120,7 +120,7 @@ struct cb_desc {
 	u8 RTSSC:1;
 
 	u8 rts_bw:1;
-	u8 bPacketBW:1;
+	u8 packet_bw:1;
 	u8 rts_use_short_preamble:1;
 	u8 rts_use_short_gi:1;
 	u8 multicast:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index d9749d2c1668..ca123864e12b 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -351,7 +351,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	tcb_desc->bPacketBW = false;
+	tcb_desc->packet_bw = false;
 
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
@@ -363,7 +363,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 		return;
 	if (ht_info->cur_bw_40mhz && ht_info->cur_tx_bw40mhz &&
 	    !ieee->bandwidth_auto_switch.forced_tx_20mhz)
-		tcb_desc->bPacketBW = true;
+		tcb_desc->packet_bw = true;
 }
 
 static void rtllib_query_protectionmode(struct rtllib_device *ieee,
-- 
2.30.2


