Return-Path: <linux-kernel+bounces-398750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2929BF561
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122011F2616C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDF320C49D;
	Wed,  6 Nov 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INcE3Mus"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77D20BB4E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918048; cv=none; b=aBtigcH3OF3vXgWo5okTYt69yntGMrPWABMNHSjDxEeAXME7OPah+B65m0FQ10LrKD6dmzNuFB5MSIGT9Kir+yt573f/4qBAM0qGyaDQCz38qTjWGH6gmMYHsvJJDRC98I1SSOMynnaQzqJVENerO1qwfI9pH/BDcOLZwtgQIw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918048; c=relaxed/simple;
	bh=IpCwHFvHWB+SD+q5t4kipYkhT8ePEI9get/CWHBF4bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zvl5rzcs1ryQePcW+5uQm0VueTS5ePqqN/vpChcfmyWXg8rRQaVxz2PPwB51Kv0ZTp+9790P10rEzWwKj94YZi5ceCjnUonQhYMw2em+V1TbeI+jLQMmtNgtpdMLZ8RFBVOoCxyRlPtIG7LBTdnbLXuteMUJe2J9iIQx2xyo8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INcE3Mus; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99cc265e0aso7173666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918044; x=1731522844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1eOJY0eG7JqZEoh7Tdg13wcvziWr11zSxZYpyAV4F4=;
        b=INcE3Muss2ppNzL+/BBWaFjRaUBAmwcuEn96XeY22n+UqLNmkH+VDsMeRErB8ZcVzb
         7C3x12OS4V/bnb4jajKIlj9NG3rTxBkTuPwOncNjjnR0hBUZGbpQNSpuBzAkDAUM7Nnu
         pzm7axo1PpEFu8dbiBqhJRjjgqPSHVxogP88odVirArA6O1dyIrEnKhjuKtqhLM96xCB
         C9B+hTy4bvjTlzmjeTrWdH9ABYzpIwLKuj595Iru0NPzbMbZ7MIvM4mGdpHAmvRfCqD+
         DnxsK44cbAfqX7VM63Q3H2bJQLnpontkRg6PFqDMUETIcubTmmZLWb1GWIBI/k96a1yY
         gw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918044; x=1731522844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1eOJY0eG7JqZEoh7Tdg13wcvziWr11zSxZYpyAV4F4=;
        b=Pb8Th52gQr23m1ZMfe/O/C6uChMgVJ15FiBfAY9wK2CTcknYoA/KX8xXMu4jPHcOjJ
         Dhap6jK9Yizpj6uNqMGYlA3zdjmEmv3eesPbhyhFtcDFc9aDIenhl1FsuJG8grUcoYyN
         9rrR2JnXT4LfOM3cmYW8bb8r6EvUbdtITgrovcR5sfjxEzZUlsdiGVIOPPGyO/nx4WzQ
         v9UdK+o1aKFZgeanNVDBFggmiMKuyY9358WKsxgHQCI1RHgvge5pd/Vh0enzomE8/Cu8
         gOpa4GD2+57RSi8ApDrLZeYXvyO6T6KwCfx+dnzSlJr2w8rJW81tzTS/J4SDHk+jdOoM
         k5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUmOlkDIduoYy+KPGUXq6U7pVC3pMLasoPVMpYrbpJOy8hA3FlEPmk+e8K7jnPyjjp3IfjBGU3G8sBqdjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAK5T9Bn31IcLxVM7PeiBaC/w0q2vZGXGJlbWu/ljkDPqzLs3F
	noHvaf5DT2R/7oB9HtrAUu4gG8f6beC9hw9d5tIICiVa2eY+pa/22+0bfQ==
X-Google-Smtp-Source: AGHT+IHUzxOH6GOnntZOQ1br9NTnROwPUrcqBcX4UJSACwGyMDoF2IPXfgk/bCk8lXpR8GaC2HjNtA==
X-Received: by 2002:a17:907:9815:b0:a99:e326:53f2 with SMTP id a640c23a62f3a-a9de5f67a62mr3580583566b.28.1730918044153;
        Wed, 06 Nov 2024 10:34:04 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:34:03 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 16/16] staging: rtl8723bs: Remove unused function Efuse_GetCurrentSize
Date: Wed,  6 Nov 2024 19:33:45 +0100
Message-ID: <d1b8cb38670b99a75b0e916adde389ed13c15935.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function Efuse_GetCurrentSize to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 25 -------------------
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index fcd9ac58b96f..7a74b011dedc 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -80,31 +80,6 @@ u8 PwrState)
 	Hal_EfusePowerSwitch(padapter, bWrite, PwrState);
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	Efuse_GetCurrentSize
- *
- * Overview:	Get current efuse size!!!
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/16/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-u16
-Efuse_GetCurrentSize(
-	struct adapter *padapter,
-	u8	efuseType,
-	bool		bPseudoTest)
-{
-	return Hal_EfuseGetCurrentSize(padapter, efuseType, bPseudoTest);
-}
-
 /*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
 u8
 Efuse_CalculateWordCnts(u8 word_en)
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 5f72be256acf..d6ea8a4a856f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -90,7 +90,6 @@ extern u8 fakeBTEfuseInitMap[];
 extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
-u16 Efuse_GetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void EFUSE_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
 u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudoTest);
-- 
2.43.0


