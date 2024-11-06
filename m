Return-Path: <linux-kernel+bounces-398749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992F9BF560
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EC31F2624A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2426020C46E;
	Wed,  6 Nov 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXokVGQZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7D20BB27
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918047; cv=none; b=Y9TkTtPRGr5OzAkmRW1gX14o+PiVXqnaXA53rQMkhU66ZVrjr6EFOk4O7bkYDsytdczN+j11TsdTHynObfUuITQbGP6UfqsrGBT2z2o9Vtx4LTKHgswBgjgmM8+fj43l/yj9S1UkOVEj9ZyOCrI2NLCwh/1Syst9OmlR0fUB0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918047; c=relaxed/simple;
	bh=ujon/TnIZaIf3M/ZysmN/DYEURTbS8NW77AlIhTm9r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA8u3Xa4KYFe0tMxcozpw1ZRBHQb2cP0vsPXRHyIA5PWAy5Phy82lcv77kP5ikBivwEzobRbRhQcB5tq2lTsQJIIbW8+Vt55xh+Dx7b/wekCnR4qb7eZfmKV0CFGjZSnsBXSA6mIwjx/puPsNBy1f6m9r4O+ENzvfWPLYjuIIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXokVGQZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso7913766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918044; x=1731522844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVry0sRO8ZHXz4GG8DebayIRXDP/gGEhpiGEaTFDJC8=;
        b=BXokVGQZjqoqeGkyirc2InLvxMYX5nTIrN320KSuUQIR5bXcP7O9z+JqNCd3D+d7C5
         Ll3edlFs9nkn6f6C4ODoyaUzMVEVkTopxqaSKkprRsi+ZBHzzjRmX4R5L/zVoD6FkYsK
         QL40HtIooGYSDGXfuZjBVC35hoDkNO0K8504UnlCaagI5taCooA58ZSeYWPmzBX7y4pF
         SnvjP9qxezR+hrFfMZnnC0SAXgr+oGvYe5iq+VwVJNRi34Jhb0KvEB5m5bWwvqA7Bus3
         97pSP3Ir5SfJ2pfsMxPyp5jvk6FLLOm5GaOurZO37ZAqruTBsW0stWKNp1jGCay/mHRR
         kmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918044; x=1731522844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVry0sRO8ZHXz4GG8DebayIRXDP/gGEhpiGEaTFDJC8=;
        b=YwXoD+veHkaO/Lre5Y+WXSeH0Mqx/skVnAaJNzWW0EAxS/DQowB0+eUiYtm7ZZkWNr
         XY64gA7bxPAvY9URRHM2SCTNjIMHKyeeqYNvd4ukzJwfsTTL803+HGeu1zqjq4IM3t7Z
         Kgpidy5Khwr0bSGsnbG2FHpIlswV5QUd89fd8SfQV4q1KQmiZXgEvdfUFs924EQ2PcgV
         wlTrbt2lFOyz4gQYKCP2EzTeNtAuQoRAMgNeyIk/X0b28FxSz8NmBs0mOG+XE+uUCw7a
         6rqhFfwteMFl2aEJNXsHmHkTASVih1U+BDfJtapCkBy7e5z5OmTJfAmfjj/NZahEnkdC
         l09w==
X-Forwarded-Encrypted: i=1; AJvYcCUhbEtjBTNcSunILGlLBI3nj7MH3GJVXc0rG/gj1nSBLP6qHOzGQ286txZS7wmzbjaElisOsILoyj4qQv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dF0MTBAwPT/lv0iQ89XiYBi3P1x60x0N3KA2O0mn5ZQZwvq2
	g5bdfMJe6lQqQJYSWwqvPr9Yt4IoIRW+pwIIKw9cWJqqItT0MOba
X-Google-Smtp-Source: AGHT+IF/t44LVhTPRYiKDhpeI3D/ZhLJn+4riyKlErYne47aNsR6CmzoMCPpHroVqa8wApfjaxsCnA==
X-Received: by 2002:a17:906:f58e:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-a9de61a128amr3808363466b.58.1730918043497;
        Wed, 06 Nov 2024 10:34:03 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:34:03 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 15/16] staging: rtl8723bs: Remove unused function efuse_WordEnableDataRead
Date: Wed,  6 Nov 2024 19:33:44 +0100
Message-ID: <34ae6c921aa8a42407def96360db5b9a7f3dc5b7.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove unused function efuse_WordEnableDataRead to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 41 -------------------
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  1 -
 2 files changed, 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 557f87306141..fcd9ac58b96f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -311,47 +311,6 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 	return bResult;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	efuse_WordEnableDataRead
- *
- * Overview:	Read allowed word in current efuse section data.
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
- * 11/21/2008	MHC		Fix Write bug when we only enable late word.
- *
- *---------------------------------------------------------------------------*/
-void
-efuse_WordEnableDataRead(u8 word_en,
-						u8 *sourdata,
-						u8 *targetdata)
-{
-	if (!(word_en & BIT(0))) {
-		targetdata[0] = sourdata[0];
-		targetdata[1] = sourdata[1];
-	}
-	if (!(word_en & BIT(1))) {
-		targetdata[2] = sourdata[2];
-		targetdata[3] = sourdata[3];
-	}
-	if (!(word_en & BIT(2))) {
-		targetdata[4] = sourdata[4];
-		targetdata[5] = sourdata[5];
-	}
-	if (!(word_en & BIT(3))) {
-		targetdata[6] = sourdata[6];
-		targetdata[7] = sourdata[7];
-	}
-}
-
-
 u8
 Efuse_WordEnableDataWrite(struct adapter *padapter,
 						u16		efuse_addr,
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 546f32dbd33a..5f72be256acf 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -97,7 +97,6 @@ u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudo
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
 
 void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
-void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 u8 Efuse_WordEnableDataWrite(struct adapter *padapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest);
 
 u8 EFUSE_Read1Byte(struct adapter *padapter, u16 Address);
-- 
2.43.0


