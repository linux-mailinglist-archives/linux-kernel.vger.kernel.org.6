Return-Path: <linux-kernel+bounces-440305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E030F9EBB86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801571889D44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CE231CB1;
	Tue, 10 Dec 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8pQBkhl"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720F230266
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864904; cv=none; b=RtfdHKCJ60gjvvBlNNJE69K8Ja8V//Q8GCr8aLWnbJMZssT0Pg0oEE3xz+uP7kXhJSvv5jsr/bAYZj1oqCx3lueM9oRXhq1pKW9Q03vSrOXf19M71D2ztvQj87pnZgx92RF4IOgf8O7a2xBQitMW6nmSJ6bwB4ZfcHYw9QFfa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864904; c=relaxed/simple;
	bh=0tYBGPrDD1XhMtaBGIcX/OQAESdzttopXuhi4GQAfdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fc51W5ixdGTcKT7kCPILzINA3l4FNzwFRbR29VXWd3Nng7ruWWkCGHhOIeRSZLjguhuu1zhTqhzPyrt7kAZm0H0/JmoL3M+ilz2pKiFO54NIL8FxmrxemJGKY6poT1QUxOrPltuPeGLM0YNBdJlAWyzvWrFKQrIsBsi5N34KPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8pQBkhl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so3257429a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864902; x=1734469702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mkwrs9HgD1HUPiHXsB7Q16YHuZ/QtErSbW5RB/eh+U=;
        b=V8pQBkhlhRToT7wp8U7ByXxWWJCGv5d1tUP0YNqIOkDktlth6pofxWEoJ2u71OXRHk
         SwRBW6orJuorAMGkJQKE+/L/NPcvRKqqvO13AEt1CnRTY+oZ+bWm2JwTqa4blbDmbYgj
         CXg4Le7RZxRK5HocFRlSjpTHvuzmE0u3tivdPRlQp5Dtz/4N9cQsglMxkgofTQ5H0qt1
         g0tpJWKEN6Z6VOcf4urZQ1vPaJaLpU6IMm1Sj1FJeDzS4ycbEsXCGoOeOu5tSOWGnAE2
         aBDxCuycAo3ePiTSwDvhJaQ56KIlvOm90kMQ1j82jrUo0uR7opNgFfQDtDo37qvSiK2i
         1iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864902; x=1734469702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mkwrs9HgD1HUPiHXsB7Q16YHuZ/QtErSbW5RB/eh+U=;
        b=nJzqrSISZcIsOvH7L22nL/0sA2BHLLTyHBDvE/8MND1u7qMNfrzK1DlWGAnLxruB8k
         yMc1WSTwp7FS/GSJuQGeMDrd6N0ny01vcmaBt5z7n4vk+S4ct5Xde3+flLT7uZBYXaAx
         FIeSH03nkoLuRkygCj2jaBKCAWjm0JyEM+uEFv3JdJ2t/J8CyvbgjzxkrLyKfRsrRIxZ
         1t2m3uHqiMyruH2nrsCHZZTxJ3Obos7EUNsPP9GorztwVHDl2yLT1maAcyooMvHDuH7f
         jZgR93A+K9lPcRcN2o/lG7kb1vurj56rwtVCY2/8skSRGI0MmjwMadLA/S8c0LdIa+8u
         Sv+A==
X-Forwarded-Encrypted: i=1; AJvYcCVujl8flKVxjAhED6330mk95FTqpwWMf2bRtVdG2QtzozD1uivjxeGowxFxEvbwipU6538SPwVrI2hwkSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZ4J5pK7awQZStmBfI+P7nNdIqqXfWFKENxfUm0zzjlue5eFW
	nFcDSh2AKRzRFEzj6jr/HQ2AINm/MgwNaGtTiVi62SxZ8zB8jpqD
X-Gm-Gg: ASbGncsP0cskH7cbctSt0c05Uef4xypCBowCT0phPCBW1PZxbxnGEjhcAsL5USXUjNx
	O0ySYArRbDJZBZQmP6KkFOzMSKuwBC+VQqz+amRl7HPOV7DdCBcxRYKtFfpffMotKZcVtBVJ1qX
	9SiD2cGZLFqqKRrPuwmH6Qc9ba0nW4MHC1dGg76KyhVLvf3k3NKnoki9D7YkEWmrxDMfzLyv0jm
	1sHaLvE3/GbwQo4M2TpEN3QRjIDp173waWo3g2A5cHrQZ6lTb/91fsYScWwuGxh4K2dwkQBSSBd
	uQ==
X-Google-Smtp-Source: AGHT+IGhnkHQMhkwvAQ0cwUekcrEGQSa5voTLpUa6xqcQOFJkFRm8LyjloVz0Q0by4q5iJtm2/ItmA==
X-Received: by 2002:a17:90b:4c8a:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2f127fc6f1dmr665534a91.13.1733864902143;
        Tue, 10 Dec 2024 13:08:22 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700979fsm13385731a91.18.2024.12.10.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:08:21 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] staging: rtl8723bs: delete DBG_RX_SIGNAL_DISPLAY_RAW_DATA ifdef code
Date: Tue, 10 Dec 2024 17:48:18 -0300
Message-ID: <20241210210741.17101-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
References: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
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


