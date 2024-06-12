Return-Path: <linux-kernel+bounces-210870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65F90498D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD9B282B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC35B68F;
	Wed, 12 Jun 2024 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jvNdzKDV"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F347A4C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162564; cv=none; b=leaRekdCZ5ZD3tfLi+4iVN6jXX7vFLqCtaXmAMfVKGApusacP8yPxK690TCJW2+HwsY0JR11tBYGHHx1ycjIAxQSRDT+2OtaItpntnapCB8D/Y3BTde4nRQ0/W3nBym/mR/log64MObSbEUm7PDFyQB2NdpClk5Uf7RjFtzNOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162564; c=relaxed/simple;
	bh=yEvhe5zcXooYHpUfZbWvNC4CUpB1uvDEagS/CWcMKl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbKXY6qBSvWHAqmKnm5Tmt+FRtD9oioUlPleqZd01FSHYIOhSL1O2mpiPWF3OnsRiSxJpWSQ6s3OokbDyyHPwPIDyAtHb6+wv4WxM5YUaSfU7357mRJYZ/xnlCcgiO8T1V2ushwZknqtgx0R2eVUpIjCVysharquRRFPL5j9fKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jvNdzKDV; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5bad217c51aso2198341eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162561; x=1718767361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAXnGG9HDug0Dq5esLT95FpBApufxXlkCmYmEp4KdDM=;
        b=jvNdzKDVf2lP2tZ2feJdK6+N8DIR8hdcd7WzDX319rWUbea3OA/SxbOECFRMMzj/U+
         IA8jSbllkr5TpjvBkXUi+gamJ9DFSxbDOlDmiFc3K35j+pUY8TKGuIzMTdBeyPrZIMyD
         UHzq1mAMfjXQ7zxdKgDvrqdjkV9xDkRTo6B+ZYHfmKM/LupmUxZuj0lwIqJJJoEa2AIa
         sndExMKGfnMgEJ9WtZ06aMfP1FnhiaUfxACV+tRNCkWwNPR+yBJQXK5XhIUQ1onLppbW
         dwYa5H4AZrMOzaS7EqkIS4PvYtKgrV9HEfZ8YuPBg2Mh97S+Dk17MTu8FGFabCQmny90
         n5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162561; x=1718767361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAXnGG9HDug0Dq5esLT95FpBApufxXlkCmYmEp4KdDM=;
        b=WCIZ7hUPpGJS5LfASaaC8C6CXdHzBx5XJk/eLIDPGxTt8mrLOvUrwvSOZiq9U7LQwV
         tH+0ZBf1WQKJiWq5imqZYugPw5i+4g2y/B0QoH1Y6O+t9qY6UEnuZ+cRiqZg3a/B2w0l
         Q0pg9GOhgDcvjDK8l8Ld8YZMxtzW5Y+EOKm07KO79CUymib25a9ticy3mMxelm66gt2W
         d9HMex/E3xSxVKPXPax908kVwGuyCn19PjtSprnsTqpj+3+fAiDa2fO4RS2rV7RYvQgO
         bhZ8T4EyNDrPgNT6KvO5iy+SOZoOE1uaoUyQdDW2r2YuVFPE1dOhRL34Ly+Ly/junjdV
         kyKw==
X-Forwarded-Encrypted: i=1; AJvYcCXFypJVjI3n0uHgbtcqJI2Qu8HI87AEXIqIIMw+6t/p1qdQs/1VNFfX8RzalWF5NR1E7Pf6I7ED6V3/BRekDMjxgG6EhT9vXZkK6Cei
X-Gm-Message-State: AOJu0YwuQwp+eTd/QKCw2N9tAqf2j2AlwoUbzw+Djq2owR85tTglIxlC
	moh8ymDne2gkR42Aw44fKzjyAH3k+muCYlgCFoPG/LzTNnmU4sacyThPg8CsDFg=
X-Google-Smtp-Source: AGHT+IGNzkXfTLzUyM1dxjmWpxPlb3gEuzHU+oLu8U1CS3fxRl2I8x9VOX7JJKwBxiufWm2+wJgIgQ==
X-Received: by 2002:a05:6359:4c86:b0:19f:2c7e:a226 with SMTP id e5c5f4694b2df-19f69cf9c16mr96921355d.5.1718162561096;
        Tue, 11 Jun 2024 20:22:41 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:40 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 10/24] Staging: rtl8192e: Rename variable bPacketBW
Date: Tue, 11 Jun 2024 20:22:16 -0700
Message-Id: <20240612032230.9738-11-tdavies@darkphysics.net>
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

Rename variable bPacketBW to packet_bw
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
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
index ab52fd66c705..1f4c1f1f0274 100644
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
index ba76d2fcc750..a3c211c1b0fa 100644
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
 	    !ieee->bandwidth_auto_switch.forced_tx_20MHz)
-		tcb_desc->bPacketBW = true;
+		tcb_desc->packet_bw = true;
 }
 
 static void rtllib_query_protectionmode(struct rtllib_device *ieee,
-- 
2.30.2


