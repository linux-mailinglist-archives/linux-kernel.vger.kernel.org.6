Return-Path: <linux-kernel+bounces-398742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EF9BF55A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD301F261E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7420B202;
	Wed,  6 Nov 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2CJ3opi"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F820969C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918043; cv=none; b=Gn/8wgF6BcuuXgoFKrxcMGQW093+QDZXQkABTU4aEzurtwmYrFHTCtcbBPbGDv8v+wdmFGtyrZS29vO2TIjSesMWDv7oL99wxkcGt8Cx5f3j1d//SK9c+K6Jxk83AT6FQjM54JONIa1ixyp9kGPMqCq8l0Ylna8WKuj6M1qg0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918043; c=relaxed/simple;
	bh=IJ9mErZ+wjZe0e8iHAOjHtSpQtOzNRQC61CyRrvR6jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O08mcbijxdpTOC++k2KUvI6uYFBlX7nTMbToCKkUqYWuCEM2cIIcC7sKcM4UqdKXaT7hZaJH30hhrgt1ydJnry7JMpvQEp3bl/CsnHjiFeBSJ0w9twpDHyTtJr3sHSrg2c6J1wakzbkMFu37DiCHEGfdM7GPynJzMyRLetIvi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2CJ3opi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99eb8b607aso7649666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918039; x=1731522839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5u87ZDZXHLhJLgQfuKPLFTHmzXxPMt5bGm3IUjt/TE=;
        b=L2CJ3opi1oUvjO51fVQCeWmU0Zlvy4lWgsMDtlsoEKhyle9TGGDL/XVxkm9EuzgQwr
         mMKNapW9gYF1e7Dg9JQw/Olf0abJGFq0ruLJg4bDP+CwJyX/ZeSgSKLaOaoc6vLV3O1Z
         EzLOmcNl+zoFh/5Yi67dW0qCZtf/4vdmR9cx+aK80HYLZYvXnh9m1Ifllf3eKxhdzbfO
         4ZuuN5H9/fO+dfZ+wKiakE9OiMhx87O2/kTGqTzw7BBoQd5oSKsMZUbhY0tMrNf4nkAX
         +TwQB1as8OThJk+O9zqgwahBZcoutQi2QvTlE5UMfy/FdCN9aHTjzuBkkPF8Rh8L9Vhg
         nwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918039; x=1731522839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5u87ZDZXHLhJLgQfuKPLFTHmzXxPMt5bGm3IUjt/TE=;
        b=DK37sjexmvtExTE7tKP7+pv8/K1nycuC2Dd+xDrB2LKiDi77gdPFACsqan4hahdHBy
         7gUnjkfgtg7BQ2hFMnnXzFvySK8FHu3z0e+Za5wrNybWwuhg0pKmfiGAzPyv9UKyHWH+
         sGjCkt93LNF8ggkSmh2KP/T28RDjBHORP3CQyA0JyS1fiCPhrWitJtRD68acJNK7jIlk
         9alZ8X4u1KhwL2GHrLHvZhXqRdL8JrfGn+dT33J0O15smfegbiiBhXstnIStQa0H6sPg
         2/6nqeM1eCsC9QHUHDGf/fyxYqOTO5O2xjJAcysNJDPw2jdI1oGRgZkZ8ce+7KYm3+Xo
         de1g==
X-Forwarded-Encrypted: i=1; AJvYcCUIS6BJHO8YCjBBAt21GGDoes/27kr2NIF9fYF4x1NFALni4k8Xz1lQOSpzKitMG8K3FrmaA+Z8dXLzrYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4I58I8TFwn7kxAkTpCkNtTU2d/a3UdR0lrX5mAdYBNL131gRK
	pdgBAuHehWOWI07Fj13FKqBTNCVVPjzxeOQ1thpjY99lc8D9aNkw
X-Google-Smtp-Source: AGHT+IHYy2VySTnPh8gxEKmv6duxrP601dNn8Ig2ukpuelHF7dc3COAkuPS7xj8/7c0/8R0Na+qHdA==
X-Received: by 2002:a17:907:7d8d:b0:a9a:1e4d:856d with SMTP id a640c23a62f3a-a9de5edb084mr4099385166b.22.1730918036582;
        Wed, 06 Nov 2024 10:33:56 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:56 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 04/16] staging: rtl8723bs: Remove unused function Hal_EfusePgPacketRead
Date: Wed,  6 Nov 2024 19:33:33 +0100
Message-ID: <920a7fdca106fc21e845f9ceba3f38bcfa9fa547.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function pointer Efuse_PgPacketRead and unused function
Hal_EfusePgPacketRead.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 73 -------------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 2 files changed, 74 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 11969a90a5e5..13fe77f84cc9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1151,78 +1151,6 @@ static u8 Hal_EfuseWordEnableDataWrite(
 	return badworden;
 }
 
-static s32 Hal_EfusePgPacketRead(
-	struct adapter *padapter,
-	u8 offset,
-	u8 *data,
-	bool bPseudoTest
-)
-{
-	u8 efuse_data, word_cnts = 0;
-	u16 efuse_addr = 0;
-	u8 hoffset = 0, hworden = 0;
-	u8 i;
-	u8 max_section = 0;
-	s32	ret;
-
-
-	if (!data)
-		return false;
-
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, &max_section, bPseudoTest);
-	if (offset > max_section)
-		return false;
-
-	memset(data, 0xFF, PGPKT_DATA_SIZE);
-	ret = true;
-
-	/*  */
-	/*  <Roger_TODO> Efuse has been pre-programmed dummy 5Bytes at the end of Efuse by CP. */
-	/*  Skip dummy parts to prevent unexpected data read from Efuse. */
-	/*  By pass right now. 2009.02.19. */
-	/*  */
-	while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-		if (efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest) == false) {
-			ret = false;
-			break;
-		}
-
-		if (efuse_data == 0xFF)
-			break;
-
-		if (EXT_HEADER(efuse_data)) {
-			hoffset = GET_HDR_OFFSET_2_0(efuse_data);
-			efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
-			if (ALL_WORDS_DISABLED(efuse_data))
-				continue;
-
-			hoffset |= ((efuse_data & 0xF0) >> 1);
-			hworden = efuse_data & 0x0F;
-		} else {
-			hoffset = (efuse_data>>4) & 0x0F;
-			hworden =  efuse_data & 0x0F;
-		}
-
-		if (hoffset == offset) {
-			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
-				/*  Check word enable condition in the section */
-				if (!(hworden & (0x01<<i))) {
-					efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
-					data[i*2] = efuse_data;
-
-					efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
-					data[(i*2)+1] = efuse_data;
-				}
-			}
-		} else {
-			word_cnts = Efuse_CalculateWordCnts(hworden);
-			efuse_addr += word_cnts*2;
-		}
-	}
-
-	return ret;
-}
-
 static u8 hal_EfusePgCheckAvailableAddr(
 	struct adapter *padapter, u8 efuseType, u8 bPseudoTest
 )
@@ -1745,7 +1673,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
-	pHalFunc->Efuse_PgPacketRead = &Hal_EfusePgPacketRead;
 	pHalFunc->Efuse_PgPacketWrite = &Hal_EfusePgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &Hal_EfuseWordEnableDataWrite;
 	pHalFunc->Efuse_PgPacketWrite_BT = &Hal_EfusePgPacketWrite_BT;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 48305cbf9929..c320795f3fd4 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	int	(*Efuse_PgPacketRead)(struct adapter *padapter, u8 offset, u8 *data, bool bPseudoTest);
 	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 	u8 (*Efuse_WordEnableDataWrite)(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
 	bool	(*Efuse_PgPacketWrite_BT)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
-- 
2.43.0


