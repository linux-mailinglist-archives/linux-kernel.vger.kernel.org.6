Return-Path: <linux-kernel+bounces-398744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81489BF55B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B401C236CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AD20BB2F;
	Wed,  6 Nov 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8+OWhC6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7320968E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918044; cv=none; b=oetHSX4kHHns3boq33KpPjhfks3UjW8LhRmPtfJemH0AzGaVG+BHS6GxYLpqCTrjSV5FyNYnputTfjPFrq7h0MQr63cq0KEFZm6KI3tDRNuN2YMUAq1QVgjKCGPtyx9n6hpaJdR0tiiHOjAGmGqSRzghkslpvWlUmHK+yHwSEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918044; c=relaxed/simple;
	bh=nF94VgLpUJkeXFfnuNcEv8uL/brBOQzMzSl3+POAVoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlEEf07Wy4d1xCvKXB4DrqsbBstS1CZ8v6gRSuNJ2nvmSFkFkitnQPn3BDnr7O+ySGAsEV5iO6XaeiZq8w8Ds4KwXy0G2uV9vZ3TuXN4ivm2HAmTe+MPQrAcNTcFjuew6y4w93lP+gUcknqTC9+PcyAYuVDMIaVdPg6xwJUAo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8+OWhC6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso6936266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918040; x=1731522840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxTMhtxD7KHJNhiedBrkjQNv34RfpyOuX9BscP+yR9I=;
        b=b8+OWhC6xp3SwO5ePGcGq7xIfFltCw9By8CRs+GUjeCCX/uptPyHkB8rtagVgGgxdR
         QOBFi+L70hb1HuwfKXl8ctqCKODP8CtVOi35Ls9b2RchaJdCLOvphM1Aah6M1NjtIX7+
         l5EVjyd0DY5o0NTfawjpai2abymk2tgrWLfI3Rmy7CToCt3nO//Yr3NyPHv0U00iX7ue
         t2VhZjsBanCqwzqMoMLWIuBWAoIFNbkuZH281iP/W0KL3IUKbdI8KNoXCnOKATIwC9pX
         ZieLYYIMT9ElSfk7VbdXoM0mTJDT1c3S5OTm77yePFdth0sCWGHdAR1Z2Ad0xTEveknM
         eaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918040; x=1731522840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxTMhtxD7KHJNhiedBrkjQNv34RfpyOuX9BscP+yR9I=;
        b=IiYOAaYfzPW/a7RsBtmRf153Ox192g8m1JbQKZOgxleyN7EysvlYXUDpV9fUMLXM+G
         0Wg4WT1aCEvS7MQG/K7W9Fkk/JYOtILLTFtR7IVxtefNBrQbqLkvqlPwDotJQjIB4ZZX
         dALqOQgd5yMZftjjGffOQbx/fu3/BupX0DvPABb+MMXc9DMemgETyKSbcQMwwc5ieztI
         aVBS2X3oSHvpVHhDk7p2ltn9rCRJNVv9YyClx+PNs6pPHjP30WpVdfpPRDZN/iRfOI70
         SKwHnvIFXTCDPOfPgmEqrLd7MSTFHkiWsYiXka8iysofQPFDfTIjRkdTb1bsAfj2p/3A
         G3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV6VtQKqc/6e6hv9C8PCew6Hvc0pJBW17vaaJY71b3piIO8nvMfIN/6iMszLo8PP1egBEtQ/XELEGGZrOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15hcE6YOp137P3dPnr2uQb7VI0UVpWnFOfo5F+uCYAZcSvyPK
	x+XzVnu3xa/Tw5JwJJyC86G2CW4zYqpTP/wUvhkGB1JanNtAyTPOliinBw==
X-Google-Smtp-Source: AGHT+IG4D3Pg2rvxEKMlZdbcO93uhIf8XDnsy8btxlafqxtMtVdfbKqk/kFGUBXh0eouAf1zjigCug==
X-Received: by 2002:a17:906:bc07:b0:a9e:b287:2808 with SMTP id a640c23a62f3a-a9eb2875ef0mr681262666b.6.1730918040238;
        Wed, 06 Nov 2024 10:34:00 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:59 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 10/16] staging: rtl8723bs: Remove unused function hal_EfusePartialWriteCheck
Date: Wed,  6 Nov 2024 19:33:39 +0100
Message-ID: <12274cb129683493e7406cdc19402d05d5f2ed07.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function hal_EfusePartialWriteCheck to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 58 -------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 155987c417b4..ceb234cdbd74 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1182,64 +1182,6 @@ static void hal_EfuseConstructPGPkt(
 	pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
 }
 
-static u8 hal_EfusePartialWriteCheck(
-	struct adapter *padapter,
-	u8 efuseType,
-	u16 *pAddr,
-	struct pgpkt_struct *pTargetPkt,
-	u8 bPseudoTest
-)
-{
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	struct efuse_hal *pEfuseHal = &pHalData->EfuseHal;
-	u8 bRet = false;
-	u16 startAddr = 0, efuse_max_available_len = 0, efuse_max = 0;
-	u8 efuse_data = 0;
-
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_max_available_len, bPseudoTest);
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_EFUSE_CONTENT_LEN_BANK, &efuse_max, bPseudoTest);
-
-	if (efuseType == EFUSE_WIFI) {
-		if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-			startAddr = (u16)pEfuseHal->fakeEfuseUsedBytes;
-#else
-			startAddr = (u16)fakeEfuseUsedBytes;
-#endif
-		} else
-			rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);
-	} else {
-		if (bPseudoTest) {
-#ifdef HAL_EFUSE_MEMORY
-			startAddr = (u16)pEfuseHal->fakeBTEfuseUsedBytes;
-#else
-			startAddr = (u16)fakeBTEfuseUsedBytes;
-#endif
-		} else
-			rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BT_BYTES, (u8 *)&startAddr);
-	}
-	startAddr %= efuse_max;
-
-	while (1) {
-		if (startAddr >= efuse_max_available_len) {
-			bRet = false;
-			break;
-		}
-
-		if (efuse_OneByteRead(padapter, startAddr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
-			bRet = false;
-			break;
-		} else {
-			/*  not used header, 0xff */
-			*pAddr = startAddr;
-			bRet = true;
-			break;
-		}
-	}
-
-	return bRet;
-}
-
 static u8 hal_EfusePgPacketWrite1ByteHeader(
 	struct adapter *padapter,
 	u8 efuseType,
-- 
2.43.0


