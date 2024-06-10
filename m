Return-Path: <linux-kernel+bounces-207676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A5901A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3640F2817D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F706BFCA;
	Mon, 10 Jun 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="R1hqmnyl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABF4D9EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998549; cv=none; b=iQ5TXso/OrTWEwySBxMrKiwP/xKBQsMYHfTdt5TurZl4guGHQaJXVOq3W0R1PlEj/1SS2AW6onIouZXllffPKfwRiDwNfdzD+w1aZw7QbpLyA5GjjwkDbhjHyFJgQaa4WxWyf8mlqp4jX2X3BDb73aZi8KRqj+kfj1jt68fvUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998549; c=relaxed/simple;
	bh=ZP570iFe50eXL+fB0Yj50oZJlOy1CttuSa3FHHvYE8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVEXn+olBsWzrhyUCuHU5eS154pIUKbc8YktiqZiW6noGUQq59qwbuyLJDf37xrwZ96PQv2M1RmnhBsZojAUfPswAIablWZjIfRVv5kJ0oKDAAnqw50c+FoosLGf/RnMlmahCweHWu85CeB2etnt6ZjqRcmcn+XelDh/PdHTQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=R1hqmnyl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6f1677b26so9133265ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998547; x=1718603347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj03Lghk7aCi7Z3Zu4OYL3dwtA/ZrHc3Wn8tP+DcNp0=;
        b=R1hqmnylqItexpI8NHp2UevRptvvOe9Y0FA4pNdJWJBqnVuo1DQ2AVbW5KUwaQ4rRc
         ALrPtx3SO8NZJxFPmr1Gzrpl5g9vurAvXXkh83lve0T4z65Rsmf1NALw/REb92NX5B9a
         xH6+vV2quHU9+r2dffRF4w6zZvEdZUYS9jvCefc73gEPaTw6FM0n3wqbo6tFL7HL1Jhj
         vTQOMbX3A48cjFfpsE4qNv3I6K1wyxm6zkthO/2epxb0DhW7+IsMHs9rbjT6S08NFhQZ
         G6LTNUCnt8YGjSZk0qMy+gjm6Ezjm5IX6mUFLHU7lSSy6UScQpdcT/Z4qoQiyiyRjLl/
         Y5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998547; x=1718603347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj03Lghk7aCi7Z3Zu4OYL3dwtA/ZrHc3Wn8tP+DcNp0=;
        b=VooWkn6uOyXWBVApwjz+ryiRfbr1QIxz2rSPXWKvvpn+fgRtyYn03qNvDnNTsLMnA7
         gWtexiBO6DCNmwcYO+D5DRuKlHIryNeTEu81BV5qCDqsayBUajAJavUZNW94NmnyFv8r
         xiXOaMt+lSB5eWN7tf4QnqGIDjeeYuX/yS1llVnDmdMNwWDTfAN2nJG5wsX4eGBN3JLo
         J07sysnTRG4vKfw6oQb4Iz58XRhI0ZBYLtxYuI9EbMUvW80fAoWow5i6i8aBGUARneGU
         iwEYBbxJO6Fe9bgFQzNOL2lxgGvPViNLJeM0taKtRYBsNznhFvgqW1d3otZzMp3O4Wdg
         OR8w==
X-Forwarded-Encrypted: i=1; AJvYcCWf8sbVmJXsJ+jSEzMDb1DdaZV9MkS+X7LeQzTKNirOcP9Db5GdMLSNshhXNDG0BDgwQZgNybZwcbMHwkHeo0ay4J3if/QpahmmcvIT
X-Gm-Message-State: AOJu0YxT5w89elPth4ouCbT16Xjzbc4aZZv6e6Zk+FbXUbbtmvPvWDgQ
	FxkhIodZ3aEI1FO58nukH6ajBj7t0xhakprZ+L+g+oJ4PL6RSB1icuzNu6lTgd0=
X-Google-Smtp-Source: AGHT+IEdIFrUi1SB4KfUecvJof2mg/nNWUE4C84XnTKIMNmv4LnAeg4dzy2jRLqRbO4Qu3APpCNCng==
X-Received: by 2002:a17:902:c944:b0:1f6:838f:c710 with SMTP id d9443c01a7336-1f6b8eaabb8mr157632805ad.17.1717998547184;
        Sun, 09 Jun 2024 22:49:07 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:06 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/24] Staging: rtl8192e: Rename variable bUseShortGI
Date: Sun,  9 Jun 2024 22:44:38 -0700
Message-Id: <20240610054449.71316-14-tdavies@darkphysics.net>
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

Rename variable bUseShortGI to use_short_gi
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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
index 4abd01ff3d21..33bb1cbb525a 100644
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
index bb8ffedaf9f3..56510365f1a9 100644
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


