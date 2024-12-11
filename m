Return-Path: <linux-kernel+bounces-442358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397239EDBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC761638D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D11F37CF;
	Wed, 11 Dec 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhsVgqCg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F661F2C5C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960100; cv=none; b=pbOe7IKzObAMVGKCVbKhc1wpqsro8vg6a1+N2oR3Ydux8M77SYx8Vzn/pg6a2ALvXZO4TWONtPQ94WtkSfkclH2HXjJtYfBVBz3LOXictnEEJl6wkl4wOB2i6YDawOV+HvbVJVvXpvuvZYIBTb/YImebJ6NKn/jxVnPImHA3c4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960100; c=relaxed/simple;
	bh=0tYBGPrDD1XhMtaBGIcX/OQAESdzttopXuhi4GQAfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2+amK0Oo0p6CS/HTjP54/wP9byRpugMxz76bk1ldewtbEG1CNyL14Kv0WHMjvPN0fyQNfGpLkFFHkW14XxSeNrBQdD3TV2X81CF9zLeIKNgmqfDEAP1/ShxKZTykLqoXXTlEaoxMw7LwbW0WEYekcMT2x/0ptnHBghsgnGK4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhsVgqCg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so6518846a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733960098; x=1734564898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mkwrs9HgD1HUPiHXsB7Q16YHuZ/QtErSbW5RB/eh+U=;
        b=hhsVgqCgDsb3KvVhGmMwr0pJ2oVyjw16j3q09fWDEFEqHzD+ajd8inF0l1LtP4xX+3
         V/2OKxhn/i594mcIpH5OnFw+lDrHwUFicGUedcoSlwpk53wRdP2MFGuDczFzNZlrcPLh
         90UyQYNLMCFfGTKCWn2XOBIDFDktpAydfP3yb1HpI95XqoJyOoXO+3t1BQ/+8DLjFjqR
         7FT8LPzUnpj1zqsipNv+0WvF4KKKpWRzjx6oWbPbZMTEJL64f6iDzuZUL5SqmRHhfFnV
         TgO+ha+bCA//UMy6QAvCoV7SZjyQdTwIj6nOlhTsziDdDiPwDWmMdMG1ZqUjnMmqS8wg
         sqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960098; x=1734564898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mkwrs9HgD1HUPiHXsB7Q16YHuZ/QtErSbW5RB/eh+U=;
        b=h2aZf8GXBL1RJXc4lS6LdTTubLOMSxd6u4jDkJTe6Td5qZEPdWss5RIfjIwG95HsXZ
         0h3GHPWU80jarK5B5D1IWE1SshRI9UOer84DGS3v5luUvqJ//hib0niRrs91m/66QfTu
         xhRaQe0MumxIkzODjPCJ+UcrB407fcnPM0ICBJw6uXtUJ2jIonFCLNIHIh5URZ/AawsR
         bbdmSOk+R4kSpAAh0XU12hGXeLSaSYnHUqeRZjnwVjVMLg8TwDvlRmaM3HmTauTka1lK
         3F26EzGG+MI6DLxmc0LIcYuJ19vJ+l8S8tCL6bcONTQApem4/YWWrpdbAxFXjWRuhf9J
         HgEw==
X-Forwarded-Encrypted: i=1; AJvYcCXSHfM1ayo0/gwXFgN9cE5N4jkc6G532ZNsQ/J6FHUBfCvHzg1S9NNrerDFzvBkIWYKb6ZNNUwAF0DrDxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/DzO4QsEgJlsCFIyMq3m35enwE97vIZaSoK2qSppJ3YBFgge9
	Im1vy+INJOpIYhCoLYQM41F4ztmiMugBxkKQElWK38HFJBpHCXVu43VltXfZ
X-Gm-Gg: ASbGnct4GCTED3iNzW9R47th08NYH7ce0gCSzK2D4zyhhQi/6TPmTZU6PkfDEGW+zt8
	JkaXn7q7R6iQkLSroNsF3U411yQtvkWDaCtI7uTTbq5QVRV14eZZmkoVEvPf2thp0aCGPBzyx90
	FL9oFFvmQi77hLJpAGe9jBYn21VXjzXojmXpYE9yMrfES+DnNX844honyThYvuf5btuR4uWk0c2
	xlGJvTJnFkLXUIMfdlE7QRsUGmH7OQEfM9CiNyIgjLR69LQxcaTgNCM3R1eXxvxpNOxaiY1afvL
	wQ==
X-Google-Smtp-Source: AGHT+IGAKGsBrI1bhx5kJrTiPMGcnbGJ8LtKwlK5tWL3AmZ5jZQsjS5FL+5h4bFS0Nw8QX0PYyFE5Q==
X-Received: by 2002:a17:90b:2dc7:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-2f13925b1a7mr2877599a91.8.1733960097853;
        Wed, 11 Dec 2024 15:34:57 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8a933fdbsm9229485a91.41.2024.12.11.15.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:34:57 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] staging: rtl8723bs: delete DBG_RX_SIGNAL_DISPLAY_RAW_DATA ifdef code
Date: Wed, 11 Dec 2024 20:26:39 -0300
Message-ID: <20241211233415.37702-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>
References: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove code depending on cflag since it's not compiling
and there is no reference for it's usage;

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c       | 53 -------------------
 .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  4 --
 drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 18 -------
 4 files changed, 80 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 95fb38283c58..1803c0cd3a7e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -683,12 +683,6 @@ u8 SetHalDefVar(
 
 	switch (variable) {
 	case HAL_DEF_DBG_RX_INFO_DUMP:
-
-		if (odm->bLinked) {
-			#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-			rtw_dump_raw_rssi_info(adapter);
-			#endif
-		}
 		break;
 	case HW_DEF_ODM_DBG_FLAG:
 		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_COMP, *((u64 *)value));
@@ -879,53 +873,6 @@ void rtw_hal_check_rxfifo_full(struct adapter *adapter)
 	}
 }
 
-#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-void rtw_dump_raw_rssi_info(struct adapter *padapter)
-{
-	u8 isCCKrate, rf_path;
-	struct hal_com_data *pHalData =  GET_HAL_DATA(padapter);
-	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
-
-	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
-
-	if (isCCKrate)
-		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
-
-	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		if (!isCCKrate) {
-			netdev_dbg(padapter->pnetdev, ", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
-				   psample_pkt_rssi->ofdm_pwr[rf_path],
-				   psample_pkt_rssi->ofdm_snr[rf_path]);
-		}
-	}
-}
-
-void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
-{
-	u8 isCCKrate, rf_path;
-	struct hal_com_data *pHalData =  GET_HAL_DATA(padapter);
-	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
-
-	struct odm_phy_info *pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
-	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
-
-	psample_pkt_rssi->data_rate = pattrib->data_rate;
-	isCCKrate = pattrib->data_rate <= DESC_RATE11M;
-
-	psample_pkt_rssi->pwdball = pPhyInfo->rx_pwd_ba11;
-	psample_pkt_rssi->pwr_all = pPhyInfo->recv_signal_power;
-
-	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		psample_pkt_rssi->mimo_signal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
-		psample_pkt_rssi->mimo_signal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
-		if (!isCCKrate) {
-			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
-			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
-		}
-	}
-}
-#endif
-
 static u32 Array_kfreemap[] = {
 	0xf8, 0xe,
 	0xf6, 0xc,
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
index 717faebf8aca..db3d7d72bffa 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
@@ -67,8 +67,4 @@ void rtl8723b_process_phy_info(struct adapter *padapter, void *prframe)
 	/*  Check EVM */
 	/*  */
 	process_link_qual(padapter,  precvframe);
-	#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-	rtw_store_phy_info(padapter, prframe);
-	#endif
-
 }
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 4db93484725f..258a74076dd9 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -149,11 +149,6 @@ bool eqNByte(u8 *str1, u8 *str2, u32 num);
 
 bool GetU1ByteIntegerFromStringInDecimal(char *str, u8 *in);
 
-#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe);
-void rtw_dump_raw_rssi_info(struct adapter *padapter);
-#endif
-
 #define		HWSET_MAX_SIZE			512
 
 void rtw_bb_rf_gain_offset(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 18dd1464e0c2..aa9f9d5ecd01 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -89,21 +89,6 @@ struct phy_info {
 	u8 btCoexPwrAdjust;
 };
 
-#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-struct rx_raw_rssi {
-	u8 data_rate;
-	u8 pwdball;
-	s8 pwr_all;
-
-	u8 mimo_signal_strength[4];/*  in 0~100 index */
-	u8 mimo_signal_quality[4];
-
-	s8 ofdm_pwr[4];
-	u8 ofdm_snr[4];
-
-};
-#endif
-
 struct rx_pkt_attrib	{
 	u16 pkt_len;
 	u8 physt;
@@ -221,9 +206,6 @@ struct recv_priv {
 	u8 signal_strength;
 	u8 signal_qual;
 	s8 rssi;	/* translate_percentage_to_dbm(ptarget_wlan->network.PhyInfo.SignalStrength); */
-	#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-	struct rx_raw_rssi raw_rssi_info;
-	#endif
 	/* s8 rxpwdb; */
 	s16 noise;
 	/* int RxSNRdB[2]; */
-- 
2.47.0


