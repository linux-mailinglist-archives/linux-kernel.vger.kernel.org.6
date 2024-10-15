Return-Path: <linux-kernel+bounces-364981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9F99DBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F9F1F238EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7CC168483;
	Tue, 15 Oct 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCZQNoJF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4135165F01
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956872; cv=none; b=ABZCXCGkM8diURlRfSqaLQLGEG5nZLOzwMWvX5wnPnuwm6/98p04PkY+ot/1HUR/eOTOp7NB3ZetH84LBoGLHBeWRf5FwZjwy8D6/kbi7vTXHelVP0HUocILF487QS2KUIqKq2rscupM22n3NMzzOlfD1vB1yw6sOHkYz+sszTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956872; c=relaxed/simple;
	bh=N5KvQyAWasw2pHtA50YzKW1XZmGuj+tV+JDsgre7160=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abIA58uPwrrpZdvOD7r+eell609MmzWDa/W5cBGWkYOtJFvPHvDxE26pgjSrJJewAmXTka5IKG7O7xOD7sgh1cN+iV+73M2yy/ekoWscX89PrhtXml6h0KHzpd/7N2kJ0hbmw+lABkslAJMtL/14heGps6HBfH2fMWRV8FgNSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCZQNoJF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c805a0753so39609655ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956870; x=1729561670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU/+PDQEVns2ZoSRDquh2VHXFYZzqQ8KNkMRDlpc89g=;
        b=CCZQNoJFJz0F7P7juxnSJWjTqDLxmn8l6wPzGSGaLePygIAbaa2RIcygioS+t41Z76
         CWILJQy3Wvj+2KvkT3QLXt6xaBWG4mjEjq8H2Ybj7HdAd5QR+Wm3FY4DAhnhYsd5N8a0
         FSOTOm7msQQXRVnEvIOZVvSUFdm0392uuWQbAy6vAmQTC8T+txGqTm8+vym4P6zJGzf5
         9wIgPMWkEArkVWcW79YsBy2rUJF6HEOGcWzYIACvPz1UD9MYPRUikNrgLyKZGzpMzCRB
         nsJ3RusJ9I4HpIM5T5SJnJSpNTXv+3JY+yePVpqb0tgmUuoYL+W08sqMdo2VqgNmTtF+
         azMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956870; x=1729561670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU/+PDQEVns2ZoSRDquh2VHXFYZzqQ8KNkMRDlpc89g=;
        b=G/TlaoXmjjOwbRwhJeYCNWHiN1C2ESW7fkQ2ol6T3xt/jzlqC6279vZydmZYpEo9e8
         Q8VIKQQgxZr2pQ4CaBR6e5JOPBiKBMwcHTSdTNsTy8iQSea4VMcD5B9PBgeFpwjQatnd
         FPWt+l3ikyZj5s52YzfOBKzUJZtEyosWyEcmb/hGFsluFX4YlzJ/iOuZc69kcA5Yw9ua
         h8faepEdzOpedh2w9qvNUHOEQqqYSbFxnlEshvNOGFHwQSauC743Hn9TMPAh3Snr8Ukd
         icFaqsR8mOCKIFWMyBDnubY5xDwWN2LlsuzlcDqIFYnqDtkaf5VdPH6STbcB+b21oEv2
         OabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnEdjr9ZnScwa4Yd+E4r0NMmtn1/EWt4Lr1LBK2tT7OuYHjwWYgkLzYMGhu9NcFfLIld7e15dlJ2L0LoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2VZy/ilSkbOIG+Y3Wna39hpYuisg82JEyVgo8Z/vcmptcaik
	wudw9Hpfwzt0j0xAIGovSztgEzKbo8OvIGLnSN43d5jDTdAO/HBR
X-Google-Smtp-Source: AGHT+IFhn1nqUQMa0NBua1Qu1EX3Ct5NxTLCuaW8EaPCYEgH/5N7WIi9EvNzDgvtUfk/+tmzO9irmw==
X-Received: by 2002:a17:902:f543:b0:20c:c01d:54a8 with SMTP id d9443c01a7336-20cc01d5d28mr112046805ad.16.1728956870050;
        Mon, 14 Oct 2024 18:47:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4e84:7ad0:3bea:5c55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036251sm1863615ad.172.2024.10.14.18.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:47:49 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: remove unused debug statements
Date: Mon, 14 Oct 2024 22:47:38 -0300
Message-Id: <20241015014738.41685-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015014738.41685-1-rodrigo.gobbi.7@gmail.com>
References: <20241015014738.41685-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove both commented printk() and commented DEBUG_ERR()
statements around the driver.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c         |  1 -
 drivers/staging/rtl8723bs/hal/odm.c             |  4 ----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c   |  2 --
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c   | 12 +-----------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c  | 17 ++---------------
 5 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 484e0b4e489f..5994e574ae99 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -883,7 +883,6 @@ void rtw_hal_check_rxfifo_full(struct adapter *adapter)
 	int save_cnt = false;
 
 	/* switch counter to RX fifo */
-	/* printk("8723b or 8192e , MAC_667 set 0xf0\n"); */
 	rtw_write8(adapter, REG_RXERR_RPT+3, rtw_read8(adapter, REG_RXERR_RPT+3)|0xf0);
 	save_cnt = true;
 	/* todo: other chips */
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index ea3b4cd32360..2cec8d8aeaef 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -433,7 +433,6 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 				continue;
 
 			if (true == ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level)) {
-				/* printk("RSSI:%d, RSSI_LEVEL:%d\n", pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level); */
 				rtw_hal_update_ra_mask(pstat, pstat->rssi_level);
 			}
 
@@ -512,7 +511,6 @@ bool ODM_RAStateCheck(
 		RATRState = DM_RATR_STA_MIDDLE;
 	else
 		RATRState = DM_RATR_STA_LOW;
-	/* printk("==>%s, RATRState:0x%02x , RSSI:%d\n", __func__, RATRState, RSSI); */
 
 	if (*pRATRState != RATRState || bForceUpdate) {
 		*pRATRState = RATRState;
@@ -593,8 +591,6 @@ static void odm_RSSIMonitorCheckCE(struct dm_odm_t *pDM_Odm)
 			}
 		}
 
-		/* printk("%s ==> sta_cnt(%d)\n", __func__, sta_cnt); */
-
 		for (i = 0; i < sta_cnt; i++) {
 			if (PWDB_rssi[i] != (0)) {
 				if (pHalData->fw_ractrl == true)/*  Report every sta's RSSI to FW */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index b9c6cd1f80d6..1b1929061083 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -53,8 +53,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	u8 *bufferPtr = buffer;
 	u32 i = 0, offset = 0;
 
-/* 	printk("====>%s %d\n", __func__, __LINE__); */
-
 	/* 3 Phase #1 */
 	blockCount_p1 = buffSize / blockSize_p1;
 	remainSize_p1 = buffSize % blockSize_p1;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index b63a74e669bc..c053ee9c1361 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -581,7 +581,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
-				/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 				/* set mic key */
 				memcpy(txkey, &(param->u.crypt.key[16]), 8);
 				memcpy(rxkey, &(param->u.crypt.key[24]), 8);
@@ -626,7 +625,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 					psta->dot118021XPrivacy = _TKIP_;
 
-					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
 					memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
 					memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
@@ -657,7 +655,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
-					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
 					memcpy(txkey, &(param->u.crypt.key[16]), 8);
 					memcpy(rxkey, &(param->u.crypt.key[24]), 8);
@@ -785,7 +782,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
-						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
 						memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
 						memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
 
@@ -806,10 +802,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					} else if (strcmp(param->u.crypt.alg, "BIP") == 0) {
 						/* save the IGTK key, length 16 bytes */
 						memcpy(padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-						/*
-						for (no = 0;no<16;no++)
-							printk(" %02x ", padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey[no]);
-						*/
 						padapter->securitypriv.dot11wBIPKeyid = param->u.crypt.idx;
 						padapter->securitypriv.binstallBIPkey = true;
 					}
@@ -817,9 +809,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (!pbcmc_sta) {
-				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
-			} else {
+			if (pbcmc_sta) {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					pbcmc_sta->ieee8021x_blocked = false;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index a9e481e182ad..793b051536f3 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -138,9 +138,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) { /* sta mode */
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (!psta) {
-				/* DEBUG_ERR(("Set wpa_set_encryption: Obtain Sta_info fail\n")); */
-			} else {
+			if (psta) {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					psta->ieee8021x_blocked = false;
@@ -154,7 +152,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
-						/* DEBUG_ERR(("\nset key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
 						memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
 						memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
 
@@ -177,13 +174,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 						rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1, true);
 					} else if (strcmp(param->u.crypt.alg, "BIP") == 0) {
-						/* printk("BIP key_len =%d , index =%d @@@@@@@@@@@@@@@@@@\n", param->u.crypt.key_len, param->u.crypt.idx); */
 						/* save the IGTK key, length 16 bytes */
 						memcpy(padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-						/*printk("IGTK key below:\n");
-						for (no = 0;no<16;no++)
-							printk(" %02x ", padapter->securitypriv.dot11wBIPKey[param->u.crypt.idx].skey[no]);
-						printk("\n");*/
 						padapter->securitypriv.dot11wBIPKeyid = param->u.crypt.idx;
 						padapter->securitypriv.binstallBIPkey = true;
 					}
@@ -191,9 +183,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			}
 
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
-			if (!pbcmc_sta) {
-				/* DEBUG_ERR(("Set OID_802_11_ADD_KEY: bcmc stainfo is null\n")); */
-			} else {
+			if (pbcmc_sta) {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					pbcmc_sta->ieee8021x_blocked = false;
@@ -629,7 +619,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
-				/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 				/* set mic key */
 				memcpy(txkey, &param->u.crypt.key[16], 8);
 				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
@@ -674,7 +663,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 					psta->dot118021XPrivacy = _TKIP_;
 
-					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
 					memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
 					memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
@@ -703,7 +691,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 					memcpy(grpkey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
-					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
 					/* set mic key */
 					memcpy(txkey, &param->u.crypt.key[16], 8);
 					memcpy(rxkey, &param->u.crypt.key[24], 8);
-- 
2.34.1


