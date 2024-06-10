Return-Path: <linux-kernel+bounces-207682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DE901A71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FEE1C2153A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC27581A;
	Mon, 10 Jun 2024 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Ap+ZR1Jc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7E73189
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998553; cv=none; b=K2NvWRANK3g9N9eMBHbgGp8+W3Se+sIcLTRJlaVOxR8EF7dryOsFb+jLJryggM+OBGcQaG+EIxuUYgu/xTltfJX7ltXJqbl6waVplx0ONjeORxFpOeU+tabKz1jxk4WZ1xwJaSPukKCvGVnwhWuRkh1ybbvAeMQj9Rm0LJReQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998553; c=relaxed/simple;
	bh=ve3KFxH+K9wQH/GyIYM4nHXWzVnbDUe10k+8QftzC+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0Mt5hBbXjV5rccI7zC6Bre+TTaLSY0GC/GZGPMVIiEwfTyTX7VNfoFlRCvtVzOn9AGhIoN0t7n8ImEIWxQO3GcGRxbC/hZloQuOE6YozoRGood+XBkvwWnPC2HEifBC/GMTDS3oef7tLGSHohADU3n0nKj5R/jyjIypMCiQ3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Ap+ZR1Jc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70599522368so298799b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998551; x=1718603351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKMOHjX0dBFGTbHN1lyyqgytPIEy01BtwR9BPVPAbQg=;
        b=Ap+ZR1Jc0PMG/eBeGltlZJEy3wrj5tSOs4WHCsELN+NgMVS81GMSpvjWyqRThqkZ26
         cEE9I9qwHrIN2yQ41ALpLethsJQ3F+Jy+3Dxw4PqhUSH3KvSzu0VxSzcE/1lAg6y+hWA
         hnZZewo9RKKbbZ/c4ihiasDGzEn0+Kiy3wIjtlZ5uI6fgusnAVl2wbi6SV5kvWXQmQWJ
         XTaGuahudmMDrxuYONBpgDTCX+NoO7fQ88JoHjPprbX6SYjZx6+Kw/T08+BFUn+bfELC
         FNuE7Uwt1vqZVzWppAisnkhmic40SAbp6mZIYqKh9OLaJh1mS+Q0zsCuzC3846835t7I
         CiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998551; x=1718603351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKMOHjX0dBFGTbHN1lyyqgytPIEy01BtwR9BPVPAbQg=;
        b=Wi4WU49XxCkkLsNyHIuRqjBxuKRKoo1Y4diU+A1RTu/d8ZWKwhyyqA/jA9uhfKPYk1
         1xIP5VLnGB8sXtHu/yPou49rU+WIlzRUWzW/Ebwoey36YrY0MQZEEqHaYEF2yoP0eD55
         UymVPwaD+i1fgjodfclGee3XytGLo7by9x3mz/smLhZaLrAhtH6IPFdoBj136Ep8AaEW
         qOJCAZF9cV7S0ur4OnIv+Klq9MxMgDgDFRdlLRvKHepniA1dOTAyhycYY+m+h78eT/7N
         hx72fVZa4nyq1pEiR4g6h+vyMwuZEKYQEm7CC7J3sIdW6fvdCVishZKoNhJBpCm1RQ4W
         uxxw==
X-Forwarded-Encrypted: i=1; AJvYcCXfRGxLuzpYXmCmNr+YKtbmrLVxhn5jUj8Zn3Ao7rfhfX68ZM5GPUjhdtZtDsu5UUpdRVvIE1ZnoCbiNLw7AOU1zKluojKhDsRqxS5g
X-Gm-Message-State: AOJu0YzoWziCB8P30y34+/r3IdnPt5VH0dOxp13OcN/tLsIXgXHALJwh
	eYpmxYciO8l1Ig6/S3TFTSBODrJSuOw7EeTv2g9+dJ+A4uMj9FA6ikicM73wGXUbKUpXuy2HHOm
	3QZk=
X-Google-Smtp-Source: AGHT+IFdJkBBbrTjtUiZ45juFBZV8I1iEU2B9aJnyUWuXWICiASrR3IGShacvrduuXuODFCa5b3DkQ==
X-Received: by 2002:a05:6a20:6a2c:b0:1af:cecb:b64a with SMTP id adf61e73a8af0-1b2f969ed90mr7481115637.9.1717998551011;
        Sun, 09 Jun 2024 22:49:11 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:10 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 19/24] Staging: rtl8192e: Rename variable bUseShortPreamble
Date: Sun,  9 Jun 2024 22:44:44 -0700
Message-Id: <20240610054449.71316-20-tdavies@darkphysics.net>
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

Rename variable bUseShortPreamble to use_short_preamble
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f38d172ddb4b..46e42fad5834 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -860,7 +860,7 @@ static u8 _rtl92e_query_is_short(u8 TxHT, u8 TxRate, struct cb_desc *tcb_desc)
 	u8   tmp_Short;
 
 	tmp_Short = (TxHT == 1) ? ((tcb_desc->use_short_gi) ? 1 : 0) :
-			((tcb_desc->bUseShortPreamble) ? 1 : 0);
+			((tcb_desc->use_short_preamble) ? 1 : 0);
 	if (TxHT == 1 && TxRate != DESC90_RATEMCS15)
 		tmp_Short = 0;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0029e4ab4394..7c010534af52 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -113,7 +113,7 @@ struct cb_desc {
 	u8 cts_enable:1;
 	u8 rts_enable:1;
 	u8 use_short_gi:1;
-	u8 bUseShortPreamble:1;
+	u8 use_short_preamble:1;
 	u8 tx_enable_fw_calc_dur:1;
 	u8 ampdu_enable:1;
 	u8 bRTSSTBC:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 183a3897687e..f6525256298a 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -322,12 +322,12 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 					   struct cb_desc *tcb_desc)
 {
-	tcb_desc->bUseShortPreamble = false;
+	tcb_desc->use_short_preamble = false;
 	if (tcb_desc->data_rate == 2)
 		return;
 	else if (ieee->current_network.capability &
 		 WLAN_CAPABILITY_SHORT_PREAMBLE)
-		tcb_desc->bUseShortPreamble = true;
+		tcb_desc->use_short_preamble = true;
 }
 
 static void rtllib_query_ht_cap_short_gi(struct rtllib_device *ieee,
@@ -440,7 +440,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		goto NO_PROTECTION;
 	}
 	if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
-		tcb_desc->bUseShortPreamble = true;
+		tcb_desc->use_short_preamble = true;
 	return;
 NO_PROTECTION:
 	tcb_desc->rts_enable	= false;
-- 
2.30.2


