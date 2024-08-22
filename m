Return-Path: <linux-kernel+bounces-296301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17ED95A8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0239F1C2137F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DF63A9;
	Thu, 22 Aug 2024 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvD0RlNH"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9764405
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286460; cv=none; b=ROsKG5yBMcWIsklcD2PH6GDTFU0XoHmJmCfO73F95F4oqbRSxYzVHKGfHsf7c6RdGo+m7DrLkVZTP0WItYlYCmVTVdTG2KYHDE2UMf76W7LN1DPNwt4tKk7hv+zqNogMKezcyiGTuFolLfZ/u6vRgVOiTsI6/vDOS1Z7Cj11Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286460; c=relaxed/simple;
	bh=2LX/K8CY2AbfGo3cY0PsvK8XB6qi10XqO1W22X7aOpc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gX00Gd3EPr625LkfHcfrED1nO7TPO9M0qWTNbuYIEe+cxlP3MF5wfG+rqp/9MOxGEGbr7hw2/0AhpbChg5h2wYUm8d94GiLCYBTaQ2LILPFd9Rbm3e7nqEZd13GnKnKb7W0bOwPILAGfeFEIrwBCjqTg1Xd/bJPkvT17MrFRcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvD0RlNH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71423704ef3so214229b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286458; x=1724891258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VvazKeNS87POsZjbzgnWrQjc2jlgCDlAmlWZn8lGc8=;
        b=ZvD0RlNHsWB9Z/HDpiYKTJ3Hkfq7r0IXubVOrrXQQd36SOdEgNmMPQtXqI2B0U2zfF
         Pq1Rv2VAeS0mKtqmRdja6qWgJg7iWDR8KlWMgr+0XLIsuioYu8BX+wdkyFGs90zgtAiY
         2Xni77x48q103SIjefIFnbek+8IHxCX7vV5MDaw5XTNMB1CF1OpLVsXdWLmyNSAWWnjE
         9I+5GR/Fmmdfiocc+1Xp205KeEv6cxROFNAKqIjnjKUchtYrdTvHECuhNKsp0T9IVF3x
         4Eu6ykvn++zuxb3BbjufhYGH2CRc+UBBiI5x5CwOF7I6d8Kkpy4Do9zdZLjUoW+T/tgj
         pjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286458; x=1724891258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VvazKeNS87POsZjbzgnWrQjc2jlgCDlAmlWZn8lGc8=;
        b=urnP2Nn77UAsur2MdEhYCw53+Ap7EvE2UD8r7zJ/0hddA/O0YfiWtFOPveF1gSjraG
         vwdoG/GDrnAnYalVzTLR8BoUVuib/91X7dvG8t+tH4yRd/LTSyfJyB7fwefhwyz6jOmJ
         pJtvSECmoxfg6my/lMREWiMuO9xlFszAp6PcyfVPqXfZD9WWsEaQc/DYOi2MQiuXSNlP
         28q9VtcGjKpL8SVhTqz3kpV0PCErobaNpAQPTW0mscp9tBZriHxbkBRNsVKajVuzPa+q
         tPOwng+KJZayNNfKh6LdZl0beOv2w3yvd5gt9WmQO9mqPY+vsckCWzN+6k4W+2Wam9SY
         P0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXMZE5NCBPWZ5jyZkVRBxF77BqdE99REYashcTsOgcQ1ZXe7zyLS5bALXMFKNut+zeQVhc26KO54nhI1HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGilWR63vTxhwUFc+mFL+XoXCkZtMl1rsHaOaT7P3TuFzwAnqv
	43nVQEIZ7onMsokk3JdzdL3/K2aIHsX6R0wXfrPjOt6vq5UM/9QQTMHdV8iX
X-Google-Smtp-Source: AGHT+IGaGGsV7BXmQQJULorN9P/rSXT1FSVvbtxDUj38t4SlU6FZ57Yf3OdCTam3xiTdAEQznR+Jvg==
X-Received: by 2002:a05:6a21:2d0a:b0:1c4:9cec:ea0a with SMTP id adf61e73a8af0-1caeb3055camr284724637.37.1724286458175;
        Wed, 21 Aug 2024 17:27:38 -0700 (PDT)
Received: from fedora.unicamp.br ([2801:8a:c811:1:c43d:98d0:4d68:4b77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342555eesm236661b3a.56.2024.08.21.17.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:27:37 -0700 (PDT)
From: Gustavo Montenari Pechta <mrpechta@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix camel case
Date: Wed, 21 Aug 2024 21:27:30 -0300
Message-ID: <20240822002733.27609-1-mrpechta@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix camel case on variable name to match style convention

Signed-off-by: Gustavo Montenari Pechta <mrpechta@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 6ef38f4ca17c..14e50acb40b5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -240,7 +240,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	const u8 bMac_Tmp_Addr[ETH_ALEN] = {0x00, 0xe0, 0x4c, 0x00, 0x00, 0x01};
 	u8 tempval;
 	u8 ICVer8192, ICVer8256;
-	u16 i, usValue, IC_Version;
+	u16 i, us_value, IC_Version;
 	u16 EEPROMId;
 
 	EEPROMId = rtl92e_eeprom_read(dev, 0);
@@ -256,12 +256,12 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_vid = rtl92e_eeprom_read(dev, EEPROM_VID >> 1);
 		priv->eeprom_did = rtl92e_eeprom_read(dev, EEPROM_DID >> 1);
 
-		usValue = rtl92e_eeprom_read(dev,
+		us_value = rtl92e_eeprom_read(dev,
 					     (EEPROM_Customer_ID >> 1)) >> 8;
-		priv->eeprom_customer_id = usValue & 0xff;
-		usValue = rtl92e_eeprom_read(dev,
+		priv->eeprom_customer_id = us_value & 0xff;
+		us_value = rtl92e_eeprom_read(dev,
 					     EEPROM_ICVersion_ChannelPlan >> 1);
-		IC_Version = (usValue & 0xff00) >> 8;
+		IC_Version = (us_value & 0xff00) >> 8;
 
 		ICVer8192 = IC_Version & 0xf;
 		ICVer8256 = (IC_Version & 0xf0) >> 4;
@@ -288,9 +288,9 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		u8 addr[ETH_ALEN];
 
 		for (i = 0; i < 6; i += 2) {
-			usValue = rtl92e_eeprom_read(dev,
+			us_value = rtl92e_eeprom_read(dev,
 				 (EEPROM_NODE_ADDRESS_BYTE_0 + i) >> 1);
-			*(u16 *)(&addr[i]) = usValue;
+			*(u16 *)(&addr[i]) = us_value;
 		}
 		eth_hw_addr_set(dev, addr);
 	} else {
@@ -321,10 +321,10 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		if (priv->epromtype == EEPROM_93C46) {
 			if (!priv->autoload_fail_flag) {
-				usValue = rtl92e_eeprom_read(dev,
+				us_value = rtl92e_eeprom_read(dev,
 					  EEPROM_TxPwDiff_CrystalCap >> 1);
-				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
-				priv->eeprom_crystal_cap = (usValue & 0xf000)
+				priv->eeprom_ant_pwr_diff = us_value & 0x0fff;
+				priv->eeprom_crystal_cap = (us_value & 0xf000)
 							 >> 12;
 			} else {
 				priv->eeprom_ant_pwr_diff =
@@ -335,20 +335,20 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 			for (i = 0; i < 14; i += 2) {
 				if (!priv->autoload_fail_flag)
-					usValue = rtl92e_eeprom_read(dev,
+					us_value = rtl92e_eeprom_read(dev,
 						  (EEPROM_TxPwIndex_CCK + i) >> 1);
 				else
-					usValue = EEPROM_Default_TxPower;
+					us_value = EEPROM_Default_TxPower;
 				*((u16 *)(&priv->eeprom_tx_pwr_level_cck[i])) =
-								 usValue;
+								 us_value;
 			}
 			for (i = 0; i < 14; i += 2) {
 				if (!priv->autoload_fail_flag)
-					usValue = rtl92e_eeprom_read(dev,
+					us_value = rtl92e_eeprom_read(dev,
 						(EEPROM_TxPwIndex_OFDM_24G + i) >> 1);
 				else
-					usValue = EEPROM_Default_TxPower;
-				*((u16 *)(&priv->eeprom_tx_pwr_level_ofdm24g[i])) = usValue;
+					us_value = EEPROM_Default_TxPower;
+				*((u16 *)(&priv->eeprom_tx_pwr_level_ofdm24g[i])) = us_value;
 			}
 		}
 		if (priv->epromtype == EEPROM_93C46) {
-- 
2.46.0


