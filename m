Return-Path: <linux-kernel+bounces-210872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5BB90498F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33F11C2380C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0C6F2F2;
	Wed, 12 Jun 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="an1DW/ln"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B3282F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162565; cv=none; b=cX3lGDc0EXAE8pQuRGEiNqRdFzdGGPj70I6uSzWofbljZUUex+amdl6Xbqafm/mYgHQUh5zbyCKeO8P/uPt0IS0EtZW0Q0EoUWPLy8T3uuqvdXz+gNOT0xn6GXgsv39UPM/FngyaSKvX5JSGjSEsJkIKB1+KWSONN82Vu6Q+i1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162565; c=relaxed/simple;
	bh=d/GLHSk4K2U7JU80kpJxoLSuODyAXPIsWBntT7Ha3+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDuQZGlO6y+8XH4Wkg50ICipzy3mJ5hPAksnW/NWiINBb/wuAMPPviIxLko9eK2rfmIdP3lWxWIZu7iE2AySBNf23VQkV3nIa+aGZ/kAC6JI4x3g2sFiHHp1+AMzjTbHIIaPFJxx9HnAWsaKWYJHR/vighNUcT8IGdPMA2Pdg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=an1DW/ln; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f855b2499cso3397461a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162563; x=1718767363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8iTeXIWdySRsFuZkHSgHpEI9lD6ZbZRxodFJ0iQZsg=;
        b=an1DW/ln6LTQSSwA0KJtzrBQ2O4r9xTjSq5g2BwM8naop5MC2WSX8AT/T1DGkOUCtz
         JbCbKA8WWR9mDmJxme3oPSvVBLzLsZ1EMcfzdy6F8Mm4lXEY4X2CwMQYgWginndvUQtf
         wOxXjUsyo5KAH6M6i+Wz1sD7Yu52Wk88tNfodOo0nUkxc6weorSpmFtE2lP4KODwFC5E
         mQ2sNQImTbNIreHG5jPr0dfGg3NO+3VBDCKio33SPXtLkt03FwV2XTZceryVV1PKxODa
         IZdyyQpW4rlUPCvJ2+/9vCz6izJ2LWHyTdUFgiSsxGoL0QZsbGO3dbboxL3SRt2RGROI
         Z6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162563; x=1718767363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8iTeXIWdySRsFuZkHSgHpEI9lD6ZbZRxodFJ0iQZsg=;
        b=lvqChs7ov7qspudOL34a1CJMIarEOMt8df5LM8KbWGlDV+VWuRF7j+QZOmaYCsb8eB
         bWCPxOUmqGTPThRVV7XKm9uPAmp787QdpeFAQBZN4M4N1lVJ3X0tSpLKzW6DPQdjdJbM
         4jzGMZY3DbZOhjveyfaatqyP1Q09xRoC4Z3bYQkyrf2tT+YevGUwZ5fsKOzS8StSkDkE
         Hx1KTH14QgpLSVVde5ja3ZKWXoU/A1HR6QknyOeXfN1D9keVt9fbSyhapRquJsGUku9y
         1/xuTsLEqmZgTbjofOPufVyzu9N6p+BV16QzMArs8vFYKJBb5XXTu3S+Fi+mEQXElJZ6
         A0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrjdIx53I/MGMYgCzGGlVnBDZ7kJ3ojBV7UWUQ0DEy77pcdNr7dSGdo6bnQcCYJY/hsCOn68r1SU2dkN/pVCfRTETctFZV6Xv0tAIz
X-Gm-Message-State: AOJu0YypL0iddHKrCA/OWpbjDuLsx0xLRLZ7BBt35676PkkzKUAlbL37
	GIY1llWTqFzRDtaNyJQ974Ww5+ekV9D+kn2OZPuI1Wuxi9CcikzZKfGoDp5UYNQ=
X-Google-Smtp-Source: AGHT+IGgZ8FKR+wy88PA9JF/snS/F09xgEthe5Q+Zz4XhVS7QFzZGoEv67GT4nT2eqA2TFV+R1wNlA==
X-Received: by 2002:a05:6830:22e4:b0:6f0:cdca:5619 with SMTP id 46e09a7af769-6fa1c444f2cmr559524a34.37.1718162563538;
        Tue, 11 Jun 2024 20:22:43 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:43 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 13/24] Staging: rtl8192e: Rename variable bUseShortGI
Date: Tue, 11 Jun 2024 20:22:19 -0700
Message-Id: <20240612032230.9738-14-tdavies@darkphysics.net>
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

Rename variable bUseShortGI to use_short_gi
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8dec4e1b89b8..f38d172ddb4b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -859,7 +859,7 @@ static u8 _rtl92e_query_is_short(u8 TxHT, u8 TxRate, struct cb_desc *tcb_desc)
 {
 	u8   tmp_Short;
 
-	tmp_Short = (TxHT == 1) ? ((tcb_desc->bUseShortGI) ? 1 : 0) :
+	tmp_Short = (TxHT == 1) ? ((tcb_desc->use_short_gi) ? 1 : 0) :
 			((tcb_desc->bUseShortPreamble) ? 1 : 0);
 	if (TxHT == 1 && TxRate != DESC90_RATEMCS15)
 		tmp_Short = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b48d9d416ead..54cf5ee628f0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -112,7 +112,7 @@ struct cb_desc {
 	/* Tx Firmware Related flags (10-11)*/
 	u8 cts_enable:1;
 	u8 rts_enable:1;
-	u8 bUseShortGI:1;
+	u8 use_short_gi:1;
 	u8 bUseShortPreamble:1;
 	u8 tx_enable_fw_calc_dur:1;
 	u8 ampdu_enable:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index b5eb3968581d..d46963fe9bbc 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -335,15 +335,15 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	tcb_desc->bUseShortGI		= false;
+	tcb_desc->use_short_gi		= false;
 
 	if (!ht_info->current_ht_support || !ht_info->enable_ht)
 		return;
 
 	if (ht_info->cur_bw_40mhz && ht_info->cur_short_gi_40mhz)
-		tcb_desc->bUseShortGI = true;
+		tcb_desc->use_short_gi = true;
 	else if (!ht_info->cur_bw_40mhz && ht_info->cur_short_gi_20mhz)
-		tcb_desc->bUseShortGI = true;
+		tcb_desc->use_short_gi = true;
 }
 
 static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
-- 
2.30.2


