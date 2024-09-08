Return-Path: <linux-kernel+bounces-320386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF997097F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB191C2173C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51D183CDB;
	Sun,  8 Sep 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="CZloKlLd"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C16188006
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823611; cv=none; b=s9X6SI7+QZNz3+u3QwaXNHhyig2bxI8nIavs44ItGAbhjBXTS7jNaPTc5OACzeW7+2+S2gjh/WHD0aepIuWWb8vyoWj0yhhFXaYZu9CE8Nu6rRcQ3ORoOWCM/OpZafLmljZ+P81YbQ8f0Chcv3jLq8zsJLM+pXneQaMB1fLwB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823611; c=relaxed/simple;
	bh=MBbbnSXdZOhUn3Mse4L+r57MOuPjC5Eyv5DHhhmPN8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhuQnplJT5U6JYDc6xsihrAco8KJy4dUICwDAx+waDM8wgfMq5s8vMzlDTONzQPjKYsvtDu8p0AWgkje13TfjUN4IcC3Y6nAFspnAQozv3raJaz0//QP5Jd6RI/as9NTXPEHRK28X6SA4cNhG5I5mdOooceNiX2bacnleyhy1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=CZloKlLd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso2950035a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823609; x=1726428409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mON3Z21zmcNJw0Qu/8FEVGELLEA3M0aDfstnX5lY/gs=;
        b=CZloKlLdxNQjMzNrZOpkHskLb3wkJf77T1p/V7QqUZ8DBhEMXPIkB4T9EPtwqY+MRg
         9JD2Ui3YuE8fOK9CWZKv30zfvpy7YVegSy6fM1YOc1+kzE57dwQ1mVgPaCxC3Fp18HWj
         WAnU7C//CK4M+30qc8UV0WkaihP7MuvzkN/qoy2/mafLpEEgX8x9BmrBvYSg7Hlum4Yt
         1yGm/FltEJ+cm63kLz+WNes0BmST1rJR36tSR0oTphn2UFAVilHL8qgy0pMXUFnl6/rZ
         IHwG2qXCmn0fAn5hLDFQSdWTw17GFJ8VRwjZLRrxxpqUjAV4tLwVN/u4alp4o3gv+Goy
         qgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823609; x=1726428409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mON3Z21zmcNJw0Qu/8FEVGELLEA3M0aDfstnX5lY/gs=;
        b=CHV6rkmoZThJpl59A0jiO60IWkcK/ZzesBwXfv6Umsm6WpgQSS9MuH0aaIBjmITIXG
         kZ/TfFtKXmeYjn8yuXeyUtYiENBENqTe4Cqab+SbnRnd9rwzeuMZ+SE4eqkp/Vq2T3I/
         b0wPX6Q5F3k1Jly9SwWT/NiCY/qrW309EFObMvQV3eYQm0WYmOxExYJYk1yjUTBnSaCf
         M5vLc5OV6JFAN2tDSNH6g+2oETIZ94GvpFIeCeHtMzACsesbqTcykB+v+N6KJs9jAN6Z
         LjBrnU3to4iUFmnYNG0kUaetaGRxY3rBPeVzrKPQ0RjJUi1q0HQF4JYytCOHNUDmLXO3
         KGPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFTuJFVvitb8s4juCpNVvi8VXaSuEXzipt7FKO3JX2MVpk3a9lbn+fTYBXAEr6YgyeDL7C3kN7KIPQ4Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbq7sImFtor/zEdOHSPBVS6BhdyO6gTx54zOjzJm46S/yEkuQO
	xKTCLGcq4q3JfRFJXJ/5Kpx1iBBU9cMlURXb50jFUxBfQShKCMez9J6h8pM4OUs=
X-Google-Smtp-Source: AGHT+IFESgMCPQX8ayf3dx86Bk87zLc7Y3V/rHMhrJthqHllrR2mLJw/t1HsMRatPWpjBSSJSr2upA==
X-Received: by 2002:a17:903:18a:b0:202:4047:e419 with SMTP id d9443c01a7336-206f051c897mr136127355ad.25.1725823609076;
        Sun, 08 Sep 2024 12:26:49 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:48 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/16] Staging: rtl8192e: Rename variable RxDrvInfoSize
Date: Sun,  8 Sep 2024 12:26:33 -0700
Message-Id: <20240908192633.94144-17-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable RxDrvInfoSize to rx_drv_info_size
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index de0cd40df25f..552fd9b6e3e5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -227,7 +227,7 @@ struct rx_desc {
 	u16			Length:14;
 	u16			CRC32:1;
 	u16			ICV:1;
-	u8			RxDrvInfoSize;
+	u8			rx_drv_info_size;
 	u8			Shift:2;
 	u8			PHYStatus:1;
 	u8			SWDec:1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index d25ac5adfc49..2672b1ddf88e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1493,7 +1493,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 	u8 *tmp_buf;
 	u8 *praddr;
 
-	tmp_buf = skb->data + pstats->RxDrvInfoSize + pstats->rx_buf_shift;
+	tmp_buf = skb->data + pstats->rx_drv_info_size + pstats->rx_buf_shift;
 
 	hdr = (struct ieee80211_hdr_3addr *)tmp_buf;
 	fc = le16_to_cpu(hdr->frame_control);
@@ -1639,7 +1639,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	if (stats->hw_error)
 		return false;
 
-	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
+	stats->rx_drv_info_size = pdesc->rx_drv_info_size;
 	stats->rx_buf_shift = (pdesc->Shift) & 0x03;
 	stats->decrypted = !pdesc->SWDec;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index d43841a9b21b..dc1301f1a0c1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1522,7 +1522,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 				 priv->rxbuffersize, DMA_FROM_DEVICE);
 
 		skb_put(skb, pdesc->Length);
-		skb_reserve(skb, stats.RxDrvInfoSize +
+		skb_reserve(skb, stats.rx_drv_info_size +
 			stats.rx_buf_shift);
 		skb_trim(skb, skb->len - S_CRC_LEN);
 		rtllib_hdr = (struct ieee80211_hdr *)skb->data;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6cd374a9a955..d6615f787d53 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -474,7 +474,7 @@ struct rtllib_rx_stats {
 	u32 time_stamp_low;
 	u32 time_stamp_high;
 
-	u8    RxDrvInfoSize;
+	u8    rx_drv_info_size;
 	u8    rx_buf_shift;
 	bool  bIsAMPDU;
 	bool  bFirstMPDU;
-- 
2.30.2


