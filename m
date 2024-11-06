Return-Path: <linux-kernel+bounces-398735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCF9BF552
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B949C1C23194
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3D20897A;
	Wed,  6 Nov 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkdZqt4r"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FA206950
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918038; cv=none; b=eSnQFjBgd+LCMIj+Cr4zCj/E4z4z5Nj1OtjP/0WH6AR+vvV3EXmAu6qZBNL5v+I1N5p0jurKmbIv3sNdACwhsFWPYW4EPGyq3us7Yc49gEoyOkX6LzZurnXueMieGTIVqBUkknqvAu8A5w4BspXi/PBAtH5+R8JyJv01gLeqLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918038; c=relaxed/simple;
	bh=28VgR9/mTRGQLnSjlZI5ngaU8OlMSuFsh/ZkPGpnMyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY+SAwIOsgFsnyVB5rLvT7orayOKUQhHObz1n4Ui71cGV6Uh87LSzdx8fg4gwGOksgLIui8Loqh8tnGvYU3DXJxwkGesi9FwjOEgz/8o/JMta0C0sKulB5pOjV6q3SED8M9tC1lo1X+DV4kFoDBzofL4VoNlLHWrbdjRbBO4DHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkdZqt4r; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so11481866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918035; x=1731522835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5VZXsxFcPOb1yWrcWItHRNslTT6cT523l3GGyBmh8g=;
        b=bkdZqt4rUAZ3FV9eOrsHEPsI+gtSYoeggpX27GhCuxHHSxrXXootD8iemJ0jwliYrD
         FX561wuiNpKrdHXxUgy5eFzgGXResYVxa24Ir8N2Z/jfI+QvK++JT53P1CF4eGdsfQlX
         O5qBF6blKyq6rwpA76g8xJlkWLMupSFIUMB1kM+hZ5Q83gP3qFaxhh23nyK5oT8YCis5
         oFIMGqneYuKUdIzulAFmtgS1Imfr+mweSd1OWuc8DMOKHxCjP2IKFPKpAwLeoICfiNL+
         bpRuZX+SF14NNvhLTCqn/s3lKsqZqVrtpClwV9hKYgGhUVhRlXMCahEAunmspT9j5Rhi
         ojfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918035; x=1731522835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5VZXsxFcPOb1yWrcWItHRNslTT6cT523l3GGyBmh8g=;
        b=aKxJxwVsQKdPABN0Xvox569ROXc3v5p09kAWmzjRfsEBEwNrdlYShB8c2q+zalOq2b
         GqMoHpHBOssj7bRl3kE3HLxA4tuhqPfd9Ar7vW49gtDJjn7mLGmf+BtYJ/QEItvKHaHY
         TGcYC2jo6uAsQYcc3afWh71Y45wXMs6oKiXQROzP0lRt/ZLtgUYL73I6QTKA24RsPH7C
         IxTbVT4P4EH0W4bez+XCOPdkMVPPs5pyhrF9jy+9Ul2ukiW2fC7GZAc6x90ngh1eo04X
         o0LtfZX9ZHtiEouUMDjXya0jXbB0BSCUHacjvur1SUaLLcteqbRtu0ETiZboyjDFwuhQ
         Rk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1EZZTYCGl7Wh5C0ehYnPmErj3iQ4g9mTbqZiTrtP41Ph4/d/I3QY1JoK9l8o0IekzYiGB8GDhtG0Padc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkkdkAw/kHxYE2vflB8qZHqGxTl/7ilp9PxgPq+3Uv6pYMMDt
	2zEuoBcyU3Qzcn07mFwBWwZPvkeHB5WI3pD6YAR8U3HXp1caE87r
X-Google-Smtp-Source: AGHT+IGXqmPZ2+2CING4uLm7EgLsGnOQF56/dX+4i7v6qzHEJVRcC0PWMf9VAErLCqidd4w/9YTL7w==
X-Received: by 2002:a17:907:e8d:b0:a99:8178:f7ed with SMTP id a640c23a62f3a-a9de5d6e208mr3874337966b.4.1730918034324;
        Wed, 06 Nov 2024 10:33:54 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:33:54 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 01/16] staging: rtl8723bs: Remove function pointer EFUSEGetEfuseDefinition
Date: Wed,  6 Nov 2024 19:33:30 +0100
Message-ID: <a203a6b2558ea0af5811d8c5841b10b7bbf2e9ff.1730916582.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer EFUSEGetEfuseDefinition and use
Hal_GetEfuseDefinition directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index b6c655e6747e..b8023e9d7631 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -171,7 +171,7 @@ EFUSE_GetEfuseDefinition(
 	bool		bPseudoTest
 	)
 {
-	padapter->HalFunc.EFUSEGetEfuseDefinition(padapter, efuseType, type, pOut, bPseudoTest);
+	Hal_GetEfuseDefinition(padapter, efuseType, type, pOut, bPseudoTest);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 2d2de56d5df7..8a4ebe645786 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -490,7 +490,7 @@ static u8 hal_EfuseSwitchToBank(
 	return bRet;
 }
 
-static void Hal_GetEfuseDefinition(
+void Hal_GetEfuseDefinition(
 	struct adapter *padapter,
 	u8 efuseType,
 	u8 type,
@@ -1745,7 +1745,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
-	pHalFunc->EFUSEGetEfuseDefinition = &Hal_GetEfuseDefinition;
 	pHalFunc->EfuseGetCurrentSize = &Hal_EfuseGetCurrentSize;
 	pHalFunc->Efuse_PgPacketRead = &Hal_EfusePgPacketRead;
 	pHalFunc->Efuse_PgPacketWrite = &Hal_EfusePgPacketWrite;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 2285e82ab7b2..a513721e763b 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
 	u16 (*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 	int	(*Efuse_PgPacketRead)(struct adapter *padapter, u8 offset, u8 *data, bool bPseudoTest);
 	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
@@ -290,4 +289,6 @@ void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
 void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
 void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
 		   u16 _size_byte, u8 *pbuf, bool bPseudoTest);
+void Hal_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type,
+			    void *pOut, bool bPseudoTest);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


