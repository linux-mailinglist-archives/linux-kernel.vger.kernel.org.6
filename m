Return-Path: <linux-kernel+bounces-435777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27E9E7C2E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E776169979
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350D204576;
	Fri,  6 Dec 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6sf8AJw"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA113D516
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526107; cv=none; b=nDtwJlEDElBTWiiicvcXFqflerKti9Igc1Dfl/Lzy/oYk6/Q3eXeeBuW8Yw40zhpfkG7gKvjS24OtpUufKYdE8EG30NLtpXa+9lT9K0krPD6/ohTlfi2rs1dmzFqpxcph9LjIxEK8CiVdupq+DOp7Bne4HenlCPARoDOg8IvMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526107; c=relaxed/simple;
	bh=KdWA7i+pICC2SxhfDBFFNP2MZIDE1rAJghqLCl+c+b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsA0FHJi6uivZMWlljZgZR8l4OnXktRGDFKiNAKEEKvNFOzh5qvCzpYq3mmkJAvRoAjrnbwmVeNzy32nzUIHwOR6kms6+RscQxJWRKYx6rbAdDG2U7CsLaehrBGxLoaKsmtHjJurykPXe5oW+r5+PfHL0nvQ22RQgFYD2ZsPX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6sf8AJw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f383c5bfso2327138b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733526105; x=1734130905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OuXghRj8qiQDSADsJfHL9Jz7MCOAtxqNjyRb0+NVT4=;
        b=V6sf8AJwNAUbLBnIX8E4AFD0my45YDH9uNq0Yi0Hig+ihaCLw8/aO6fynsXRJz4v3Z
         mosFi4fm35qE+dX1IGrxBNAeK3s/ENPVRsarG9d4tgU95o2YPWSluLQq18vSJqixCgkb
         RYegqSYu8qNxOiA3gnhtWf2wOgHrkC1S9LkZOQeKZnU86FrOy+CtHVvso6cz/phpM8rK
         XMvZjlBuk5h+qfWLMrtClQd2jwC/lbNcCcqgacs9/63miHZ4Fyfd3UKUNcIIZqBYvAhx
         Y16SMRvac1rfCPLsdZsGTUm6n765z8KLi0YFyhWwks6w5lbPOyac2EbbObfTpy22GJcJ
         pBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733526105; x=1734130905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OuXghRj8qiQDSADsJfHL9Jz7MCOAtxqNjyRb0+NVT4=;
        b=jVKJgqFUdgTlJ58hewce0tejU8GCQerGga8OdXBROSou1cD0Cnex8QV/3gE3IpnR4n
         F8KFCHG13x9axxzsoUIu+CIp4uIw7TI1hfErGdMjRGmD6XcR3MD2Eu8D7Nnz8l6TqZPM
         xz7UfobDI1sOd+ba8do7yZa8Bp9tOsp/s/lxQ6s61NUkkcSKLngM1DGOqoxFj0AZrby9
         I6qxbwewCUz6KmKT0nRtdsYbDcM26xoD0FciEUel78N0JsXVnmClfM4Uy8gXwo61R9gY
         hW9fp4vACbhMU30G32gYvwIBWmBKpXN5ZlPqM/g1VSViOThzWOFUIf9y43jiUZrhlFq9
         Nybg==
X-Forwarded-Encrypted: i=1; AJvYcCW1YrgQ4GEKrdHizjbsK3AA/RvF+jQvRY1C6xazAitvLqIzSl+GukQXSqQluFgaNFL/NQ2N4UukeIacwv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCTHPlq6reoKzcJ3jcA2Mihtmm/GZJQkrav8czKoWzdFcfsH4
	GutHO2nHMgSwSBgziD3kfVDUAsWmE+JnzA++CnS4hQB4mmhUH6cP
X-Gm-Gg: ASbGnctbWGqqLzR2+EJpnjEsLWWAj2fVREM6EGPnDBlQr4u+b/DUVOFDtBAdtca6Mhv
	9aoG0Z10tiI+uqfrlqy1DTH4NRX+UGwEbkI9g0NVlkuNG3sJRrr5wLzid8Tf5pDRb/Rp8TsKLeM
	pvukl589Nlfz2JyMO17BWT55z/vE6nH0kpFGMLynEm5NOXjDN8UXOJsAJ8LExGsQg0H7czzq1nd
	yT2zaNjFsSFddRIO6iwGanx7IZ7dhgatEs8X/vZAlTtBotD0biYkhL8I3mCr9Uk6pZRwZGNYA==
X-Google-Smtp-Source: AGHT+IEVzM5o9LLQou5RZJ6vrQeUqpCMldFlQk9pV37bee0Qj4YKaqsXbTZhCNvqazVf96XTIar9eA==
X-Received: by 2002:a05:6a00:22d2:b0:725:451a:425e with SMTP id d2e1a72fcca58-725b81043e7mr9024086b3a.8.1733526104511;
        Fri, 06 Dec 2024 15:01:44 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5ae3sm3561517b3a.25.2024.12.06.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 15:01:44 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8723bs: remove code depending on cflag
Date: Fri,  6 Dec 2024 19:53:15 -0300
Message-ID: <20241206230110.11893-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove code that is depending on DBG_RX_SIGNAL_DISPLAY_RAW_DATA cflag
since it's not compiling and there is no reference for it's usage;

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
The previous version suggested to fix the tiny error over the cflag usage.
Greg pointed at [1] that is not common to build using cflags. Since there
is no reference about this debug usage flag, I'm removing all the code depending on it.
Tks and regards.

[1] https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#med5299468bc43fa89d18892d6d869a93d6138475
---
Changelog
v3: remove code as suggested;
v2: https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#mf22f30a9c689bd793988d7e7a58c0b119206116c
v1: https://lore.kernel.org/linux-staging/2024112500-authentic-primarily-b5da@gregkh/T/#mea4fba3775a1015f345dfe322854c55db0cddf43
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  1 -
 drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------------
 .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  4 --
 drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 18 ------
 5 files changed, 83 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 317f3db19397..952ce6dd5af9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4959,7 +4959,6 @@ void _linked_info_dump(struct adapter *padapter)
 					rtw_hal_get_def_var(padapter, HW_DEF_RA_INFO_DUMP, &i);
 			}
 		}
-		rtw_hal_set_def_var(padapter, HAL_DEF_DBG_RX_INFO_DUMP, NULL);
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 95fb38283c58..b41ec89932af 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -682,14 +682,6 @@ u8 SetHalDefVar(
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
-	case HAL_DEF_DBG_RX_INFO_DUMP:
-
-		if (odm->bLinked) {
-			#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
-			rtw_dump_raw_rssi_info(adapter);
-			#endif
-		}
-		break;
 	case HW_DEF_ODM_DBG_FLAG:
 		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_COMP, *((u64 *)value));
 		break;
@@ -879,53 +871,6 @@ void rtw_hal_check_rxfifo_full(struct adapter *adapter)
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


