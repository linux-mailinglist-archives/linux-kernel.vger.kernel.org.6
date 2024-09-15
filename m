Return-Path: <linux-kernel+bounces-329699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE79794CA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527BF1C20B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED873501;
	Sun, 15 Sep 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERlNHqw0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1011BDCF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382465; cv=none; b=rLYOunIhtns7xz89ywdjVrbp/hqgzQhu6vV03kuIgaIG9bT7v79pAAk9POMUa4hu07WLCyrm3mvmMk1SozcuAWDld6kAT/pUDiOUE9gh9tikytGL1jPcQ4Pl6GPqbCzr6GBaX5/jx0ER8F94apfKlKc/xh436CYJQ2iOvkoHas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382465; c=relaxed/simple;
	bh=x5sCgwLHh1A9huYqe0WPnMubIiLl4YyjkxXVTZFcEcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSkrhSBXzJCny0upCQW2y8G6clxSIrx1PL9iava/EwmIxQmhabipCkln+zwp5U7/PIVgqTaCwKncQcOnCJT+MoBs2weHwU5+uU0tXDRsNu9f4/juVKG7W+rrDBlDVVpuzYIqwjlqh2M82rZGiP/0d+DUEEVUHd3gh1x9+80hEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERlNHqw0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d56155f51so438094666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382462; x=1726987262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJboqtmrxph9K3PVRnau8dONXpRrIv6lutqIff5OCzE=;
        b=ERlNHqw0wnewr3tEVTpV4ygCPLVqc7IzWHISs11NrNXdsOzdc0/9mKP+IsZ36qk3vl
         gl3jEjk+xUBOuhHG5ifq2D0SocXxMlSAlFSwYaPR2D+cpQSUl5vGNP+PxtueZU7ZYMUd
         OP/EYxV+CgcGUfKckZ9R2GnBi1Ov9v3AZgq8rewAzNEa+rC881T1Du8xgiEN569+FAAD
         vwnwdZEKdHpnoQEgxBlSRPGqWGv5BcTZtiYH7WU08X79h4p+VNqTy+tjx7YC71aho8CB
         dC3SS3TjR+YCSGYhmWjVgn817SLRFpZ/SzZ7B/FugmWOUVuY5d3UrSU+4hvd4lZYZcpj
         hc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382462; x=1726987262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJboqtmrxph9K3PVRnau8dONXpRrIv6lutqIff5OCzE=;
        b=EnsFRmiHvDcg2IAPnEwcsksXCj4us0s8ZGJeuc9lhZWFcqw46c1YgaF2teNzKAum78
         7MoSutk1WKb8jOkZkra4qP/VS9dhsfvysJxLred94kKEiRCmrd6TInjXNcc9Zkhzyec6
         Yrq9Vj5MTG43BwXr25gnveyXh+rC8981tKolW0YQo2PIQwByDJsJ6GQpojfL8sa4xbZ5
         U5LpnfQf0uWAHR7J68D5UipF46EoD9r/QfhOyxHIBUfvERZMDlEVHeYlL1Wn4FrWVgMg
         kZxaznZo/7Yr7rXE+9z3MFgC9XoYCkwEH0NLMDv82TUEt3HnoDx2L4NKoEuyOfN4jhs8
         nq/g==
X-Forwarded-Encrypted: i=1; AJvYcCWrOTYg4pm2sCIz3DNdVeXI/H/6V9IYy29dG4GQInJeyXXxtXCDHz07xjTq3thAHvdQDKKdXVheWOB+AAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33tmD+0FFgOubdGGkGoAm833Am15nXxpWZWlTbuQW3jCvLJhf
	CYk8odyAbzu71BCgCVhUYcKeN8j7k+sITCylaOHlaWZpbC3mTuhW
X-Google-Smtp-Source: AGHT+IHbsBoHDxfQcaBt/dZZWTkkFy+yzmgG3vfNRxAFyJj9u2P4jXYlDh4XR3q196DI7ZhpEf2IiQ==
X-Received: by 2002:a17:907:d15:b0:a8b:6ee7:ba22 with SMTP id a640c23a62f3a-a90294ec2abmr1242653766b.39.1726382462111;
        Sat, 14 Sep 2024 23:41:02 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:01 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 08/17] staging: rtl8723bs: Remove unused function PHY_SetBWMode8723B
Date: Sun, 15 Sep 2024 08:38:22 +0200
Message-ID: <4f3a76bce3dc309a179e588d184765e54816d3d9.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function PHY_SetBWMode8723B and belonging unused function
pointer in struct hal_ops set_bwmode_handler.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 11 -----------
 drivers/staging/rtl8723bs/include/hal_intf.h      |  1 -
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h   |  3 ---
 4 files changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 37ebbbf408ec..a44c1dd0f691 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1884,7 +1884,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 
 	pHalFunc->UpdateRAMaskHandler = &UpdateHalRAMask8723B;
 
-	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8723B;
 	pHalFunc->set_channel_handler = &PHY_SwChnl8723B;
 	pHalFunc->set_chnl_bw_handler = &PHY_SetSwChnlBWMode8723B;
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 4ff092b7c9c9..a4ea124eb9ad 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -764,17 +764,6 @@ static void PHY_HandleSwChnlAndSetBW8723B(
 	}
 }
 
-void PHY_SetBWMode8723B(
-	struct adapter *Adapter,
-	enum channel_width Bandwidth, /*  20M or 40M */
-	unsigned char Offset /*  Upper, Lower, or Don't care */
-)
-{
-	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-
-	PHY_HandleSwChnlAndSetBW8723B(Adapter, false, true, pHalData->CurrentChannel, Bandwidth, Offset, Offset, pHalData->CurrentChannel);
-}
-
 /*  Call after initialization */
 void PHY_SwChnl8723B(struct adapter *Adapter, u8 channel)
 {
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index f559a5c1fd16..84da38c55d7e 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -189,7 +189,6 @@ struct hal_ops {
 	void (*enable_interrupt)(struct adapter *padapter);
 	void (*disable_interrupt)(struct adapter *padapter);
 	u8 (*check_ips_status)(struct adapter *padapter);
-	void (*set_bwmode_handler)(struct adapter *padapter, enum channel_width Bandwidth, u8 Offset);
 	void (*set_channel_handler)(struct adapter *padapter, u8 channel);
 	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
 
diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index ea494bcf830b..acf714946365 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -53,9 +53,6 @@ void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
 
 void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
 
-void PHY_SetBWMode8723B(struct adapter *Adapter, enum channel_width Bandwidth,
-			unsigned char Offset);
-
 /*  Call after initialization */
 void PHY_SwChnl8723B(struct adapter *Adapter, u8 channel);
 
-- 
2.43.0


