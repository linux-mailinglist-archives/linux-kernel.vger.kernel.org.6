Return-Path: <linux-kernel+bounces-398736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2019BF553
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A3283974
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEA36D;
	Wed,  6 Nov 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJlLfm7y"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020B208217
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918038; cv=none; b=Ocuygf0AHaqOmcmCCpGfsWrbswyGjt16ua4ANxqrQCfPf6H7HB1ooBUK1GF+mytVhKRF2q6LiguIoOk/pJZL1PxNENlTfsG2A3/cSluW/a0wbMr0rGBKFjEI066R6ehQrukBouoswWBjqfMlfL02Odhbwm3dDD5Nd9/bDNsl43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918038; c=relaxed/simple;
	bh=RzrCb4oLv8h3AO7d/rVCLj5+SSzNgJU8ETF9pQE696o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTp5KOVgRCwekWyHIbHmi/7ALk64X8m2VZnFE8fRD1HYKfNS6Aikb68+fK8DfcYMt1B4JRk65FK3LUfEpxZ1o4aHC53vNH240cHIq7dZ0fuOo8KiJjheqHd939V0PmMRZpbgTZc+MxgUqR94RqNMVkFyI7PiddtLAS4bcnIex0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJlLfm7y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d495d217bso59424f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918035; x=1731522835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M96Aa4rJwMo6paaVcv0s1fOlpDPMBLDVDsMC1t1/MHI=;
        b=DJlLfm7yLONS1vB9HqfJO7hcLiQQPRZLxjMXU8BjW43pEYfe0W1TUE/rAiWZlAFCEv
         id/3Lpt+iR1DKQswHVqGfYbcJFxgSpTYUl2Qii3XDiZjvYywOcBb/0tX/0oF6sFTIdqq
         Mvhmv9+4klCJhZdzZ9Q/eBrOTB+iHCdThNBRjDKyeT5bnPf/yXzMgLNkLrxN36LrXDPG
         BX35DqrfHADAd3wk++B02QspeaA9y3VPl9riV8bieD1F8OoPeI+JP+S4b2xLz215eoYq
         TuFVqth9jg66K5rEobGzVpM6zzxQNxyvQost9AaJ2F6nBw3X54zQT+eUrocZAR4yKTTM
         ptHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918035; x=1731522835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M96Aa4rJwMo6paaVcv0s1fOlpDPMBLDVDsMC1t1/MHI=;
        b=fd6iHryNqBiW4YGBrKfcTlPemxAewuTycYTAdkSzCumaiSfsVsWVesC3hsjQPTeAQI
         qRoJHO4nJK9S/iHfmQU0E/L5Z18LvHyL3DRgzNpbdX8xy0YCLZI/gS9RS2ybb2XPpBM6
         AJ4rID4ukrF0AE96LYG62rZrHNcPMveCwWA4lMyKtofo+qJ4qARVBDmx3MuN+ntK2jIK
         H91+nUk2zhUZLDq/s4oFhqIWjbQjmSuUjptDLyCaP6k3BVn0NpBrci//rLYM1oYEFivN
         leoEpTuEkf7xJQfTQJJfC+8m4JDt2tgmg19Ja5gnesm/X3itgeVEd3HgxW9HEhfhxwnq
         beAg==
X-Forwarded-Encrypted: i=1; AJvYcCVjX9aosEqogd65R5GjHcyPfQ+IDUYnYxL0EhbG4OBNM5CqNslbI0l/KNPl99kjxazRwLhvkxKbZwUkGfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr23JkUtJ37ghd9GISOFimb/c1oit5xu+WZX2JazeQPmZFVIk9
	lrSkJCkExWUh9v4oP/EZRRxiKBGs+fqTBso2rWtFvcFRI5fdvNDN
X-Google-Smtp-Source: AGHT+IG14Jj5KqrtGGo+MHdpACTy1Bt7UgJyxc82bZwyzAoEpicNPaixsF8bjZgR16rx+1bBcJdujg==
X-Received: by 2002:a05:6000:2c3:b0:37d:4eeb:7366 with SMTP id ffacd0b85a97d-381c7a461e4mr25482073f8f.4.1730918035009;
        Wed, 06 Nov 2024 10:33:55 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:54 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 02/16] staging: rtl8723bs: Remove function pointer EfuseGetCurrentSize
Date: Wed,  6 Nov 2024 19:33:31 +0100
Message-ID: <58a991eeda12ccb69fe8b81ef1bb2fe3c5aa364b.1730916582.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
References: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer EfuseGetCurrentSize and use
Hal_EfuseGetCurrentSize directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index b8023e9d7631..8e6c294c168e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -102,8 +102,7 @@ Efuse_GetCurrentSize(
 	u8	efuseType,
 	bool		bPseudoTest)
 {
-	return padapter->HalFunc.EfuseGetCurrentSize(padapter, efuseType,
-						     bPseudoTest);
+	return Hal_EfuseGetCurrentSize(padapter, efuseType, bPseudoTest);
 }
 
 /*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 8a4ebe645786..11969a90a5e5 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1072,7 +1072,7 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	return retU2;
 }
 
-static u16 Hal_EfuseGetCurrentSize(
+u16 Hal_EfuseGetCurrentSize(
 	struct adapter *padapter, u8 efuseType, bool bPseudoTest
 )
 {
@@ -1745,7 +1745,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
-	pHalFunc->EfuseGetCurrentSize = &Hal_EfuseGetCurrentSize;
 	pHalFunc->Efuse_PgPacketRead = &Hal_EfusePgPacketRead;
 	pHalFunc->Efuse_PgPacketWrite = &Hal_EfusePgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &Hal_EfuseWordEnableDataWrite;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index a513721e763b..48305cbf9929 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	u16 (*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 	int	(*Efuse_PgPacketRead)(struct adapter *padapter, u8 offset, u8 *data, bool bPseudoTest);
 	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 	u8 (*Efuse_WordEnableDataWrite)(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
@@ -291,4 +290,5 @@ void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
 			    void *pOut, bool bPseudoTest);
+u16 Hal_EfuseGetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


