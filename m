Return-Path: <linux-kernel+bounces-398740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B179BF557
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56841F26137
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92D20ADCD;
	Wed,  6 Nov 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK86PWZc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E5209689
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918042; cv=none; b=ZGS/3O1f+CkmH4RhUBtllOhnvVPvSItwAQ+w4gsqJ2+UtIgQarTIERsFnZ4rjrD5oBlQdOmBjGB2HsE/+bnNCShjqi1AIWDfRp81LXddRtTw/cIAQdbJU963sTv4QBABhVvbjrKCGykTmue8QU+YEMpx+LAmPrpuIld3Y0Mbt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918042; c=relaxed/simple;
	bh=KfmJMPUsphqIRh7b0IAgOalfl+iFBdDUBMD/8jenYxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzvRwNqGPV8n8kB28Wp3xEL+Sf63IrA94Xhz9aunvrs2oZYsY9Xagh1J4wKexXtj3aoFvPZ49zZUTmqxSFNcpO6s5R/6sX4DWmERyHDI6He7fjWBqn9m4rSzIxl5RWEYqacKoy0u70sFMROaAVfnEk2UFM+9mRZKZKFpr59WhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK86PWZc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso65886a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918038; x=1731522838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+BamNq9Ka/vNcjcRd0qfZ5Er2QEzGn5caaTQCnbdDU=;
        b=UK86PWZcpGOBdHQMlI5vzN8uKhptiJNzCPGdl8Io8elub7TrY6k5TO/rtIINBwej2m
         A40v5RKNwHM+9Q61ssI6mrDS8tpl59DBSQA/cezRi3HsMSGAZQBLMc9lbOXvK9A/3NYC
         f6o4xUKyBAf5gAG15Sxzzuqdk1O0MbuOYEF1OGL6j9BPs9gAarSMCOe0ddAZYWqRjsVq
         xNRg426lPyaSOaktm9GCSQYvrL/jARDvMS0naueFNgC0jltm9PvaIT8Q/ysmVzIUbSt3
         x9Lc+Y6dicN59oaeHcJcUXGKz47ww5I5p/qiP4qQpqAZrbXbZECZdPulNKoML2//UbFw
         mwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918038; x=1731522838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+BamNq9Ka/vNcjcRd0qfZ5Er2QEzGn5caaTQCnbdDU=;
        b=cJmUusmzIH1idBAmgBIlIdH3O+ujKJu3U10k0OO7CcyZh2H3wxt3lUy2dVsHOMo2dI
         e6Z2++WK5gHVgxGtpK3iv690AWm7DAH/S/qIGxsRs+ouTQWcVAgI2+E1Dg0KYuCwzxDX
         FO/GEL95pD8IVZlcm69KQ+nW033yu4K2fgTcHGTBAp5fhY8K01zTOADJkOeiRQahHLgm
         HyRxHeDeDnd+2LRFWojzq5w5wkX2WNVGAPX/AlQFZSxD4nhofugFD/YoWUnZfaTIUH2b
         0SpSQX9a0WXjwGSprs/RPcG3AZXriiJafbtfno1lkysdj4FA+EGgG4e9W04LBqmi5HcW
         qe1w==
X-Forwarded-Encrypted: i=1; AJvYcCVQJPKNvsrZYDABPQeTybRgArUa3vyVM65lkwsOeEKHPBbhDJEhRyyi4+vVfLvTdzXRVdbDUSAJanY8x3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRRxtveXRPGx+mLc2N0dJthNmQHDdpYDb0+QeDnrOsVob7x05
	JJpr6rpSBoAHzt/ihmmLyRqFGYVaGMrpeXDvDOZtxgWjFbu25Pwg
X-Google-Smtp-Source: AGHT+IFiOWsnaFQPqNjtsLxnwyXMF5A+F68kG7RMtDz44fbvdi0yYFlh7V52DNVEms8teFIuXfKXmQ==
X-Received: by 2002:a17:906:dc92:b0:a99:f0f4:463d with SMTP id a640c23a62f3a-a9e3a5a5083mr2500921966b.26.1730918038427;
        Wed, 06 Nov 2024 10:33:58 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:58 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 07/16] staging: rtl8723bs: Remove unused function Hal_EfusePgPacketWrite_BT
Date: Wed,  6 Nov 2024 19:33:36 +0100
Message-ID: <d7f6a44ef5e2e9b17d3cc14cd346aff8220a9373.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function pointer Efuse_PgPacketWrite_BT and unused function
Hal_EfusePgPacketWrite_BT.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 30 -------------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 432c2c0aa259..fa6fbf0ddc23 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1365,35 +1365,6 @@ static u8 hal_EfusePgPacketWriteData(
 	return true;
 }
 
-static bool Hal_EfusePgPacketWrite_BT(
-	struct adapter *padapter,
-	u8 offset,
-	u8 word_en,
-	u8 *pData,
-	bool bPseudoTest
-)
-{
-	struct pgpkt_struct targetPkt;
-	u16 startAddr = 0;
-	u8 efuseType = EFUSE_BT;
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
 static struct hal_version ReadChipVersion8723B(struct adapter *padapter)
 {
 	u32 value32;
@@ -1645,7 +1616,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
 	pHalFunc->Efuse_WordEnableDataWrite = &Hal_EfuseWordEnableDataWrite;
-	pHalFunc->Efuse_PgPacketWrite_BT = &Hal_EfusePgPacketWrite_BT;
 
 	pHalFunc->SetHalODMVarHandler = &rtl8723b_SetHalODMVar;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 34cd13e49d8f..282e141616b0 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -165,7 +165,6 @@ struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
 	u8 (*Efuse_WordEnableDataWrite)(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
-	bool	(*Efuse_PgPacketWrite_BT)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
 	s32 (*xmit_thread_handler)(struct adapter *padapter);
 	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
-- 
2.43.0


