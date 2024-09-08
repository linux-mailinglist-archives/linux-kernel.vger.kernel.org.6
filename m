Return-Path: <linux-kernel+bounces-320378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4825E970977
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7471A1C2137C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D1181329;
	Sun,  8 Sep 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Jt202Uic"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AE17BB3F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823605; cv=none; b=A+H8YhAEACp0WwfABIJDQkIc1ukIVWPboPUoZqDlGHUr1Rslzop3Wo8QX+bJPCl8jq6D3wuwPpAJ26z5q8wWLBwaIBnUYK84xiwbMA/1QK8k1ke8FxsEXKIx/5wPhywACqaxSobZVQWKn8+bJGGgCfTzssWwnakIowp7U6rILd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823605; c=relaxed/simple;
	bh=oSGIlgcB5bk+3npew6/oY4O3djXBrXcqVa3FtH6ssNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBm5s84SziqeefWXFIDb1PMKhUUI4/zAQFOPlUlCgRCIToUfJruBUZUAIlMe19p980rNvkhd4NyQ/xusZrMTk8iW9uLhAoujkP1Y9aSDryIX/L0acxuYMyUf6Q96PcR1Gd+ApU4bKB1XZCdneseJUw3PDECPT8kkkd6mP65Y/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Jt202Uic; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2856169a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823603; x=1726428403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pbiBs+OMZdnPenhE+VdtplWlVCSPQUlYP7gfJvkFEk=;
        b=Jt202Uic/G15aUkKDYu9nM1QgG+eBSkxJEYlbM1TAnDv0F9umPmOD3ksyg4qMhLpAC
         GZ9WVdRluxvGLdRPibxCrJnF2JsTgMpe395H46qgXh0oCXFKTUQj6WsrXzlhycSxtZyI
         edyRiqIYSNyUeT3jjwbnuwjEqubbMCCE4a+Eafz17/fsXrSz7bRCjflTRtw8/LNGHsq9
         tXExs73hG34nDNIOkiJCrNNrZlherf6ynYs8Au0LmcDpwRJQekOwOAPzUYDZhrZxjkUB
         k3fE7lsIhBRDbor1cCGHxAq+5iAIBl8B3YrfkcDMtRJmDDz5o/W/WfPh8NKW/VAZ3Re5
         fCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823603; x=1726428403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pbiBs+OMZdnPenhE+VdtplWlVCSPQUlYP7gfJvkFEk=;
        b=NXd83xcwLOgwT+fw4q3PFMpPRma27oXWiHVbuO8RIZ9KIqyKk01vP7p0McGjqYr77B
         +5NGtDgf8UKv/yaF4Qjpif2yVkVeihRI8VtRhhKw1syqmwufHlFOC3Q01DY5DH8ckZWJ
         Q2MNyyVS9Gue6Yf4bSjh7LljDvbkuRTCCNCC3RxhOJsp3dkHqgTmERrqqF2cDJYroIVk
         Vx8ZqbHys7GNPH0Zve1azETzLgPafSuhH2jbtjYDOo4b+ftX65zN0iX7HSnq+AZ/gr3L
         RNXGayhQOzRpFqItivO0vWTYoIorRICXL0PfQ9Xbwuixuj7gOU4Sn71xbGd9qZpNZ3uN
         Vw7w==
X-Forwarded-Encrypted: i=1; AJvYcCWY40IF/iWG4JNsh7Z4YiTzl2vrvAs7qMNCIRjFqvTjjrC68Sa6qDGpBqmUZvPVymN7DbpXq8fcdik54DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeI8NK1OGsxqGPtcZY+pTtEpyhT1Ozkq9X1nzvVADo3HMRfAfF
	91A0zxi2ZiKSEFVCmbcL6Yg6lnimcLsJ44Hcj07/0OhhlY6Rg1/+68jVNPougoA1iSybEiqUSrx
	iOeo=
X-Google-Smtp-Source: AGHT+IEfiqlAgyYC3n/LMWnEE7mW3A8pj0k79UjUYmC0ClBY3O71MuUBybCEb6fRCI5pgMLH6QL/Ag==
X-Received: by 2002:a17:902:e952:b0:205:56e8:4a3f with SMTP id d9443c01a7336-206f0624654mr74639885ad.61.1725823603009;
        Sun, 08 Sep 2024 12:26:43 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:42 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/16] Staging: rtl8192e: Rename variable ScanOperationBackupHandler
Date: Sun,  8 Sep 2024 12:26:25 -0700
Message-Id: <20240908192633.94144-9-tdavies@darkphysics.net>
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

Rename variable ScanOperationBackupHandler to
scan_operation_backup_handler to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 744588a27302..a5980253183e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -665,7 +665,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->init_gain_handler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
 	priv->rtllib->rtllib_ips_leave = rtl92e_rtllib_ips_leave;
-	priv->rtllib->ScanOperationBackupHandler = rtl92e_scan_op_backup;
+	priv->rtllib->scan_operation_backup_handler = rtl92e_scan_op_backup;
 }
 
 static void _rtl92e_init_priv_variable(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index a054592a7364..fe3a42a4fcd5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -288,11 +288,11 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		if (priv->rtllib->rf_power_state != rf_off) {
 			priv->rtllib->actscanning = true;
 
-			ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
+			ieee->scan_operation_backup_handler(ieee->dev, SCAN_OPT_BACKUP);
 
 			rtllib_start_scan_syncro(priv->rtllib);
 
-			ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
+			ieee->scan_operation_backup_handler(ieee->dev, SCAN_OPT_RESTORE);
 		}
 		ret = 0;
 	} else {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d63044607fb5..ee5de93a90c1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1461,7 +1461,7 @@ struct rtllib_device {
 	bool (*get_half_nmode_support_by_aps_handler)(struct net_device *dev);
 	u8   (*rtllib_ap_sec_type)(struct rtllib_device *ieee);
 	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
-	void (*ScanOperationBackupHandler)(struct net_device *dev,
+	void (*scan_operation_backup_handler)(struct net_device *dev,
 					   u8 Operation);
 	void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 11542aea4a20..c59686d68a33 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -314,7 +314,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 	/* wait for ps packet to be kicked out successfully */
 	msleep(50);
 
-	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
+	ieee->scan_operation_backup_handler(ieee->dev, SCAN_OPT_BACKUP);
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht &&
 	    ieee->ht_info->cur_bw_40mhz) {
@@ -339,7 +339,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 		ieee->set_chan(ieee->dev, chan);
 	}
 
-	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
+	ieee->scan_operation_backup_handler(ieee->dev, SCAN_OPT_RESTORE);
 
 	ieee->link_state = MAC80211_LINKED;
 	ieee->link_change(ieee->dev);
-- 
2.30.2


