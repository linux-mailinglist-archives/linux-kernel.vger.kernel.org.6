Return-Path: <linux-kernel+bounces-329701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327489794CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573721C20DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267512EBE1;
	Sun, 15 Sep 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY2bcVIX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335281B969
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382467; cv=none; b=PHmNENB/CrfXRhetfR84uX4mxK+3JeKj9R4o372sce9uwLklax1CdPC/AMkPHGInY9WcnG6v8AuRtMa90V0rkVoDPcEIHmoQMHEvwCfeYOU7nlPZculuFq8wm1Smg4ZyP1SOT/I2TaWFDozRkRPYdOlSaHlOi03JLnjmtv6Bqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382467; c=relaxed/simple;
	bh=a5crjG6Jddq5TLGHeq1dA3OJ6KtrrV01yt8198+rP3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvs8W5BPNzv0J+U80PYHCCGW1RYTMIL0qDdx6I+taVzRfdU2/aR0cak7oqmuDxjad8Fdi6OP3XdiwETMPxWhw8+CSj+LhLLpu31j8ee9MWtshCDr30We1CD7lY+fgCSaZkAvBNekUb5IPAewWuWY3EEz0Az0eDui3xPJ/JIGKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY2bcVIX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c42c3aac99so964261a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382463; x=1726987263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCKQznBlAnQUXLCvKwjvLEzsYMysS1pH5alHdQhZ4ts=;
        b=YY2bcVIX/HN/TRCitmpbf/5rouastpc0HgRvf35cyEj7gTwAWKSFuUOVNR0SWjB+wT
         Pd+nXffO+etgmW7Z7ltK8tWUIodqXfPyekV983RrIVLxkYxo3jH9SW7KjxZcLUpGwaUC
         0p3QOAd3C3Bcw1KODPYIV4bNLUnqEctJz9tmccFXE60SddXjPL6vMdcyZdDuu8H6IZw7
         PMqI4EYlvgMcvS1VuuOFmZ/myfqlsuBIm2QDKOB6g365y4imvCipgafFMih1SfS8Hh6+
         bT/5ehYqsWBDezA/Ne/9FDtr2DdZQgaiby0zcuDjTNOZJC1jdx2+xC7f0TazF89/3CeV
         ql9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382463; x=1726987263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCKQznBlAnQUXLCvKwjvLEzsYMysS1pH5alHdQhZ4ts=;
        b=CLDTqeXJ5YjP4kQYjC1Nucot6xYg7GBlW/FwXxHs2K/3ff4Erhckl9LeUo/6WKa1M5
         p+KuGZgvd26OwoxO72FnqAbrB+fnk20MQdWmFffRXRWYAev3PJx/pgezU88YcnexHy4A
         iHoHi04fffzpw6y04CLITeL8U9TjNz2KJx+q8yyIDmo6PyVUbDg5hSA1zGZAJoYsxeEB
         RlGt//VA0wZBabGx5t0nmdsfyr2AI1LFSqKfYs/h2HtQPrN20V7uPCh++zeKzek27e4Q
         LdWHSTrVvlXAfTk463HfCi2SVJilP3T7BXgC8kXSCBz/KodlQNpvCW+s16NL74ZJUZ8F
         jAMw==
X-Forwarded-Encrypted: i=1; AJvYcCVvcU0Sf6sRLxx4D+Ox3ilr9yWcUWLdzliS7E1AmsdRCSs8hPIKw00rBUg+rx4RuYg6DQ5K7+JEt7gETNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxES6A5dWImxo3QDLdbVKmnnmArUhlNZ8aYXxQbwNkZAqdKlMyN
	BzF9M1UCae6+jwuz1tmu8tDpsibVtHVhJRmwHV8kt00yQt+BR2wV
X-Google-Smtp-Source: AGHT+IH3Qo3qoVwhy6W6PMQl3cATDFIfgQ+BNIpVB4bG98+aLYnxMKvbrqDUl6pSFw5dnIXDX+YVaw==
X-Received: by 2002:a05:6402:3596:b0:5c4:2e8e:782f with SMTP id 4fb4d7f45d1cf-5c42e8e99f6mr6524506a12.17.1726382463481;
        Sat, 14 Sep 2024 23:41:03 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:03 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 10/17] staging: rtl8723bs: Remove unused function Hal_BT_EfusePowerSwitch
Date: Sun, 15 Sep 2024 08:38:24 +0200
Message-ID: <2768736f969eaf935df1492ffd5afd98b05db11e.1726339782.git.philipp.g.hortmann@gmail.com>
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

Remove unused function Hal_BT_EfusePowerSwitch and belonging unused
function pointer in struct hal_ops BTEfusePowerSwitch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 40 -------------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 2 files changed, 41 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ea0a9849d28b..4c6d9f1fa895 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -604,45 +604,6 @@ static void Hal_GetEfuseDefinition(
 #define EFUSE_ACCESS_ON_8723			0x69	/*  For RTL8723 only. */
 #define REG_EFUSE_ACCESS_8723			0x00CF	/*  Efuse access protection for RTL8723 */
 
-/*  */
-static void Hal_BT_EfusePowerSwitch(
-	struct adapter *padapter, u8 bWrite, u8 PwrState
-)
-{
-	u8 tempval;
-	if (PwrState) {
-		/*  enable BT power cut */
-		/*  0x6A[14] = 1 */
-		tempval = rtw_read8(padapter, 0x6B);
-		tempval |= BIT(6);
-		rtw_write8(padapter, 0x6B, tempval);
-
-		/*  Attention!! Between 0x6A[14] and 0x6A[15] setting need 100us delay */
-		/*  So don't write 0x6A[14]= 1 and 0x6A[15]= 0 together! */
-		msleep(1);
-		/*  disable BT output isolation */
-		/*  0x6A[15] = 0 */
-		tempval = rtw_read8(padapter, 0x6B);
-		tempval &= ~BIT(7);
-		rtw_write8(padapter, 0x6B, tempval);
-	} else {
-		/*  enable BT output isolation */
-		/*  0x6A[15] = 1 */
-		tempval = rtw_read8(padapter, 0x6B);
-		tempval |= BIT(7);
-		rtw_write8(padapter, 0x6B, tempval);
-
-		/*  Attention!! Between 0x6A[14] and 0x6A[15] setting need 100us delay */
-		/*  So don't write 0x6A[14]= 1 and 0x6A[15]= 0 together! */
-
-		/*  disable BT power cut */
-		/*  0x6A[14] = 1 */
-		tempval = rtw_read8(padapter, 0x6B);
-		tempval &= ~BIT(6);
-		rtw_write8(padapter, 0x6B, tempval);
-	}
-
-}
 static void Hal_EfusePowerSwitch(
 	struct adapter *padapter, u8 bWrite, u8 PwrState
 )
@@ -1906,7 +1867,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &PHY_SetRFReg_8723B;
 
 	/*  Efuse related function */
-	pHalFunc->BTEfusePowerSwitch = &Hal_BT_EfusePowerSwitch;
 	pHalFunc->EfusePowerSwitch = &Hal_EfusePowerSwitch;
 	pHalFunc->ReadEFuse = &Hal_ReadEFuse;
 	pHalFunc->EFUSEGetEfuseDefinition = &Hal_GetEfuseDefinition;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index be52288a2f1a..d41f458d117e 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -230,7 +230,6 @@ struct hal_ops {
 	void (*write_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask, u32 Data);
 
 	void (*EfusePowerSwitch)(struct adapter *padapter, u8 bWrite, u8 PwrState);
-	void (*BTEfusePowerSwitch)(struct adapter *padapter, u8 bWrite, u8 PwrState);
 	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
 	u16 (*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
-- 
2.43.0


