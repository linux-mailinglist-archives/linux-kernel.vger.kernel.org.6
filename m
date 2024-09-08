Return-Path: <linux-kernel+bounces-320384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6F97097D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75421C21400
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8918891B;
	Sun,  8 Sep 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RMLnW/aA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF5186E4B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823609; cv=none; b=dDWOo8ZJ0Y3MkZLoDAY02LkYajv3vBQIP+05c0Kaaw7NXPR+ppC/E5ug9jRedO8z384oGbdi57AGdEx8D02Zl6FqE9SN0l8ShBVfYjRGAH6g4LbeKgLMLXi8wpm5pznMHfMNpCz3actewzxZbTQZTOOooLEvo1hF8QAaOYjkoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823609; c=relaxed/simple;
	bh=Zqbwng7d7h0S8knzbUlqjwzbO3ykL8Eo3fydFeADDEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnsDCGQo9WOiHGtQ7LMZecRwv36jkLdYhqcfU3wwJzzqlYF7JN174DxlQ/vjQjHE6Kjw36PfmLvetBxhn/zg3jSx9Puom+hTxQJKZPSfeQkNt1okDVoM5ITd4dk8R+mQmaocBh6catIvpUFVwl2eFvxNhn6u0V/WwElBINF+GXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RMLnW/aA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-205909afad3so36245205ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823607; x=1726428407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDbUHTQNvzkg+oP3apbjo+jZaKg79sPfnGmQtUM6Ar8=;
        b=RMLnW/aAyDaSZST+9qjYljiCOsUDATViTt0F/57Gw+aqMkrMuG3WXQ8KQfOlBDPI4L
         4x7WEh3frkCq3ZIdOKuFdmd7FWJziwHEO5fe9RfjHnKRuhHsO43Po+fyY2LIZga4ccdZ
         ftetx8PvMh1Yg8eKa6/EszWxn6gaixqKWnVx+wKh5vIQn9YCk4ddGRzTTmkeju0ywQFM
         51h8E8ap3mFdY9ysRQfBFEdzGHTLc9tK6oMhn9sMzxHhm4y/Preg8GWSiThon6bAWOLg
         Q7FC0R/1YJ7NRHumKi7tHOI4CbZMcorcTlyd9ryNwv4MWwW9Z6zF31nMq5/yr13CLEdl
         u3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823607; x=1726428407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDbUHTQNvzkg+oP3apbjo+jZaKg79sPfnGmQtUM6Ar8=;
        b=X/vGxFHzfvCd6MYqBTlbx8Zbbi8r56dkrX5NCtQvo904lKJdOoV2sM2b6B6KVaDS6X
         URtrvUAWPmE+1Q46DejibDEu8AOoXAZ1zdcFtd7kJa00L24gf7adC1K0IwgUsqKuLpWx
         UUNvlRBFNmMs2PRbyPgHfl2haR/sCMJSfGuoI1hyVhKvq2Vp/AL/qbB/tSYNbo2SVkgH
         dN8MEGabH8H4Ath/xQ64UkTpC29h3oaHgRMoMMUbXcheWaQ5uu6ZV7ulCRYYKeFnocJT
         m7IGdXOKXgrGlymrJlGNGg+h4US+KHPExNuswfF1PRIV+i3/J7INJmoKcyZMdkwpo7c8
         Bwww==
X-Forwarded-Encrypted: i=1; AJvYcCWHylnIv1Gxob/bMlEuV2carGGZeUXH/mFurDu94tpXs6GOx8qb/FetzUnzPCxoVSdoE2MGBFIoIbjV+mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoU9SXtYu6UJZBbjE/OEoW8A8DVJ357/XystDBM9mYdyObnidg
	dFjMTQzrU6hWEq7E9ksM6tyNNq9ekCTB/xQnAmbrXYUJs2y6qT0jeqO9696Smt0=
X-Google-Smtp-Source: AGHT+IGByVUqHkABLGee6fEJ4eJSe1A9yIRg1vpq8Lj59i+jhoVTBdkFOKVH0lIAJOQDwqW91cIitw==
X-Received: by 2002:a17:903:943:b0:206:cc29:e4f7 with SMTP id d9443c01a7336-2070a5789d4mr76933035ad.34.1725823607589;
        Sun, 08 Sep 2024 12:26:47 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:47 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/16] Staging: rtl8192e: Rename variable bAddNewTs
Date: Sun,  8 Sep 2024 12:26:31 -0700
Message-Id: <20240908192633.94144-15-tdavies@darkphysics.net>
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

Rename variable bAddNewTs to add_new_ts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 18b717a7409c..89092cd434de 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -225,7 +225,7 @@ static void MakeTSEntry(struct ts_common_info *ts_common_info, u8 *addr,
 }
 
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
-	   u8 *addr, u8 TID, enum tr_select tx_rx_select, bool bAddNewTs)
+	   u8 *addr, u8 TID, enum tr_select tx_rx_select, bool add_new_ts)
 {
 	u8	UP = 0;
 	struct qos_tsinfo tspec;
@@ -269,7 +269,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	if (*ppTS)
 		return true;
 
-	if (!bAddNewTs) {
+	if (!add_new_ts) {
 		netdev_dbg(ieee->dev, "add new TS failed(tid:%d)\n", UP);
 		return false;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 540ab4e34e70..d8155ea3a002 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1757,7 +1757,7 @@ void rtllib_tx_ba_inact_timeout(struct timer_list *t);
 void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *ba);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
-	   u8 TID, enum tr_select tx_rx_select, bool bAddNewTs);
+	   u8 TID, enum tr_select tx_rx_select, bool add_new_ts);
 void rtllib_ts_init(struct rtllib_device *ieee);
 void rtllib_ts_start_add_ba_process(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
-- 
2.30.2


