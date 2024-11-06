Return-Path: <linux-kernel+bounces-398738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2809BF555
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14CF1C216D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8220A5EF;
	Wed,  6 Nov 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQVQMiPC"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93826208995
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918041; cv=none; b=kbLMdQoCj4b2ztyW3fjg2LNk3tDdC1wgonydisBTfE2Zf9r5cwicJfg9IVTWV1WRr0n2Y6XS5nLdP4FudqSrzyPlxa6k2xPkACGhXqUZWkmPDdPyToNq40JGRs6GLO2MhdculAvH4DVhMkFCEvN+VFO0A998SJ3X/N42QG3Bc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918041; c=relaxed/simple;
	bh=z9YLI3XeypD2JkVURDsXmKAMCA0CwILrHqs40+Csj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPI6Axxs0z/4ds87kL5DNhJcDB1Zbv0FOLSaqq8U51VoR9VWslTdAQQMsW+fyx4Lhohit3f6R55vRedXPxIaei5ICxkPEfc7xcj58N1wnJyj8DO1QVnJNF+SQlM9oMBJWUnQ8mCgdJ/69xfTg2MzMGpYXYYjG08/BdLdlhXx4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQVQMiPC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed49edd41so13501166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918038; x=1731522838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPcfkzQzzHYPVnMWaHpmyomuW/J2G/s5mhha7Kyk8zQ=;
        b=JQVQMiPCOkbmGjtk6p/aLIsSP2U7EwBgo9eNrF+izJDCKfgqVe1RTLCJEsFhMAafV2
         vNF2wMl6eVY7c9gBZU40vVttvjuGOaAZdBSG9Jm7wxOlQJlZGz6lkObXX4M3dSgPBFj5
         /w5RPxd1EqDJ7PWEVUQlshPlLwH2s0cMRBcjVFBtGJVBmFSHxOSGYva8Jkg/4gwZYQv/
         thp4XliwkEPRApdPQItAcl5+4iyCNDGdYMwmhr0V3yMszZoWSOjp8kXbAKvrWnNt1+ES
         +e+6vDVmBNXQBlTlrumn59lnxq3F72qMYD1IxiLAJ87WkB4qsPp+7d6Xf6gLMbayzRXV
         YVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918038; x=1731522838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPcfkzQzzHYPVnMWaHpmyomuW/J2G/s5mhha7Kyk8zQ=;
        b=C4LqS7cvM85DLTaRor05lmgtBNCkSNvIO80OF8boEkmefYAlR5ghG/VWyZLy8KOCMp
         OdwTgUESg2+sQJWHWZNyt/3A0+jU32nGlo2HCn3x4lhGtn6H8i0wP5SvblcDzuDvZ3u8
         gNR9D+00pqq9H8p7fQsXUaJInzRfIj8Y03vcDY8dNd0VTZQFrvh8A28RB6r8XQ29on4O
         thA/RKVXYf0lh2QV84rpQrTZUUU3If7nM65ybwz2DmSwLeQcTbuzyAzxCrVOLsCkk/Ji
         tTvmTaivPPeMInu919KjxpRF8YGdEjGc9j57PPqlAjKT0Psidnw30gUNaYlK52czUWnR
         KuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtDqJncKNjIs+5+/qtv0haXzhF22yhm3zqaTQ2sBzURlY8SAeSFkNmpsw25S2W8RW34o2fZU0pMMRXYSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxebaT37wVoRfhW176oKrGKChGJQEcubS3pHy9RJIjns29+bkie
	FO49XtLV2AjX4b3HaVjc69tGFSFXzoy8fPshf0tEFu/bERSBpnZB
X-Google-Smtp-Source: AGHT+IGeq+rxg4ogSXDYO599VyNKOGALtpa4ihVmhkyLPUdzPJvsEp1uvL0ovpW4CuTtBB+Y2OLq7g==
X-Received: by 2002:a17:907:7f07:b0:a9a:17f5:79a8 with SMTP id a640c23a62f3a-a9de5d6fad3mr4081888666b.13.1730918037785;
        Wed, 06 Nov 2024 10:33:57 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:57 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 06/16] staging: rtl8723bs: Remove unused function Hal_EfusePgPacketWrite
Date: Wed,  6 Nov 2024 19:33:35 +0100
Message-ID: <e2d4cfd440651ed08952afccbb3e927c26927c77.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function pointer Efuse_PgPacketWrite and unused function
Hal_EfusePgPacketWrite.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 30 -------------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 13fe77f84cc9..432c2c0aa259 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1365,35 +1365,6 @@ static u8 hal_EfusePgPacketWriteData(
 	return true;
 }
 
-static s32 Hal_EfusePgPacketWrite(
-	struct adapter *padapter,
-	u8 offset,
-	u8 word_en,
-	u8 *pData,
-	bool bPseudoTest
-)
-{
-	struct pgpkt_struct targetPkt;
-	u16 startAddr = 0;
-	u8 efuseType = EFUSE_WIFI;
-
-	if (!hal_EfusePgCheckAvailableAddr(padapter, efuseType, bPseudoTest))
-		return false;
-
-	hal_EfuseConstructPGPkt(offset, word_en, pData, &targetPkt);
-
-	if (!hal_EfusePartialWriteCheck(padapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
-		return false;
-
-	if (!hal_EfusePgPacketWriteHeader(padapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
-		return false;
-
-	if (!hal_EfusePgPacketWriteData(padapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
-		return false;
-
-	return true;
-}
-
 static bool Hal_EfusePgPacketWrite_BT(
 	struct adapter *padapter,
 	u8 offset,
@@ -1673,7 +1644,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
-	pHalFunc->Efuse_PgPacketWrite = &Hal_EfusePgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &Hal_EfuseWordEnableDataWrite;
 	pHalFunc->Efuse_PgPacketWrite_BT = &Hal_EfusePgPacketWrite_BT;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index c320795f3fd4..34cd13e49d8f 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 	u8 (*Efuse_WordEnableDataWrite)(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
 	bool	(*Efuse_PgPacketWrite_BT)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
-- 
2.43.0


