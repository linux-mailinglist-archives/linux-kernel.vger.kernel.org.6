Return-Path: <linux-kernel+bounces-331290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC897AB04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8681C24CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F92313698F;
	Tue, 17 Sep 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lQwWlPo5"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845834964E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551119; cv=none; b=IM2lLnRemzqANWOB3tniKqdllvJGd2gRC355+9aEPHh8NXYFFJsl/iEASFY1FIowaMnmUJTGCQkU37kazm2js4cqTC6XIdny+1sWN/9dlP6GUmn+qqHB29Jdj8jHidntEPgkMjR7Dada3Sv84iepABboalRI5r3vIQU1s7DCXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551119; c=relaxed/simple;
	bh=x9/n3nUCuDoppKmd1upL/WLC6npkIViQv5mk7pLbQAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3tRfNvYBi00EcaiHRRuZ3N/FbzrCNANs40xAyElYdSumMX6uBEOlzRZnBrUUUpjLdUGsYIaAIxTO8AyoVwqEkr2aVtjKNutrIX5opHf/5qxBGIc9AF2oQc8MByuEUqTm/P2DF1pzzf77Q0iwbNhdAH+ZMJw7xH/SdQOq2icQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lQwWlPo5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso4575969a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551118; x=1727155918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScgoUvC5TGwexehGv5u/sh0ZN6ENbtB+PiBjom74qIg=;
        b=lQwWlPo5X7b1zJMjJK44ibXxEwOUuZIo8dy2/GjU2GnSLWQfDBxiX/tRdGnjQfNOQ7
         iM7uWHlAAR4Nf7z+/2XAwjvji062kdnykvetgzJpzPECHlTulFFfpnrOB/iWh0kuBjlT
         iV8dQzK+dsL448MMW0niQmPkCg+/kjRAsXvj6DeyQ7auoUQ1Li7samb55Z8v4q+r7avr
         EvMGVZNPGdy6uVIvNQQ8KNi0GGIA/S/T/9g9sla8LQhRNB+rxMLuwXrrYlZ2bBV1df8j
         zV3LO6cfP/AbUG69EYIcbtbE7hg15ypAcNdLvit6p1UyblmRJe1Hl3tmgChXQcSZy1oB
         zw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551118; x=1727155918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScgoUvC5TGwexehGv5u/sh0ZN6ENbtB+PiBjom74qIg=;
        b=CyKNl8oJ/OM6G9l401y/xE5HNX7YgqqA9W6dWWhyhmsOufbGOmJmJLY/tkGysLIvXv
         2s77KZpudLQT80pZ+m7uwHTyBSFTqKv9+Uhs0FC0QRs3EIOYPHJP1zlTuQsYmkdI3GIm
         Yn/efrPFVnDI0AqTSy2EZ5DUuDYJZpnnZewkjCtKmopDlHjTHBP4MtzaCOZpLJRVFsij
         feRfTEwtWmgIJDjC3LiRY/jHiqkiIlMATJlxPjMFtihuYLSSCaHudlDbZQv+j1G0MN4h
         4kMX+i6dTTJT9OxIDZz/7LHVjtQac++0FTbK4AQt3TLdhTv1/O80O7w2BBNk1/ELcr0D
         QUUA==
X-Forwarded-Encrypted: i=1; AJvYcCWI+u9ge6EsTgrLbh3tfy3pu6G1pb2eNo+de1qcc9jVEhKJ46uBqXzTg7Mc7RPj4MC0zGOOZlTqRj/gdFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFkgkmgBYuMYr72Iphewm/CM728L1nNAOo3lF7Uf6f28pJCMJ
	FQcacFlQMK1TlkrwHb5I4WRge51kLkii15B+IdSrn6Mt50vvO/0+dowJ4WCau38=
X-Google-Smtp-Source: AGHT+IFhwkuE2gp/Xsh6U54/TyXvwq6IFCnAFivkMg9hatItSagsZLB4FFEoK2OGhjzy+qXHwAIy7A==
X-Received: by 2002:a05:6a20:a9a0:b0:1d2:e78d:2147 with SMTP id adf61e73a8af0-1d2e78d227emr643812637.6.1726551117803;
        Mon, 16 Sep 2024 22:31:57 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:57 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/18] Staging: rtl8192e: Rename variable bCRC
Date: Mon, 16 Sep 2024 22:31:37 -0700
Message-Id: <20240917053152.575553-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bCRC to crc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 2000289720b3..8d645d3296d2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1506,7 +1506,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 				  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 :
 				  (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 :
 				  hdr->addr3) &&
-		 (!pstats->hw_error) && (!pstats->bCRC) && (!pstats->bICV));
+		 (!pstats->hw_error) && (!pstats->crc) && (!pstats->bICV));
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
 	if (ieee80211_is_beacon(hdr->frame_control))
@@ -1525,7 +1525,7 @@ static void _rtl92e_update_received_rate_histogram_stats(struct net_device *dev,
 	u32 rcvType = 1;
 	u32 rate_index;
 
-	if (pstats->bCRC)
+	if (pstats->crc)
 		rcvType = 2;
 	else if (pstats->bICV)
 		rcvType = 3;
@@ -1629,7 +1629,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	struct rx_fwinfo *pDrvInfo = NULL;
 
 	stats->bICV = pdesc->ICV;
-	stats->bCRC = pdesc->CRC32;
+	stats->crc = pdesc->CRC32;
 	stats->hw_error = pdesc->CRC32 | pdesc->ICV;
 
 	stats->Length = pdesc->Length;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 08eaa98c0a1a..5bb928d9cd12 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -468,7 +468,7 @@ struct rtllib_rx_stats {
 	s32 RecvSignalPower;
 	u8  signal_strength;
 	u16 hw_error:1;
-	u16 bCRC:1;
+	u16 crc:1;
 	u16 bICV:1;
 	u16 decrypted:1;
 	u32 time_stamp_low;
-- 
2.30.2


