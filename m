Return-Path: <linux-kernel+bounces-395942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99309BC526
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DFC281E68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B03202F69;
	Tue,  5 Nov 2024 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReVE2gNX"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363F2003DE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786141; cv=none; b=ngttuNpztd2sTkXEI4c21PFiDQeYs3eImdgZvprCP43BS4pAJbMSDLTKMz6ZLfvINgM2B5hLmSyIqNffbfJyklJ4pm0O5xOtlyZ81NSxHUPw6XImTHIyA6bMdTmqfd7AvdpjOXhFBqyCP355CfMxsFv7s1qcWtRtbmq2tNFQsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786141; c=relaxed/simple;
	bh=WPq8qkWAjEeyhL651g/gx0ZCAZJ5T20+vC4lFpVBkAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6tav+C1oI8dgASYUjWJMD06UmDpswVMPDb1hNn6sQQ+2UsHIkVHIMVSjL9vjlLL7/xnu0s5u6fYjMUcXtEti8DHDlsTF8l+BzajufZWEPAwkhh1ckFFVjEFoDthItNUIOFGnold4sTWGx82G1QVJRCwa40/2KUAa1e/Di2tfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReVE2gNX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0f198d38so851201166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786137; x=1731390937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqM06z+njLF7FAtLYNvhAE64PBnYV16u4ZqhF1r1t3g=;
        b=ReVE2gNXC8LUrdbAB4kfIm4WLyVCP3s3QF3dNc+5zbkZIzJM+Yr9Ls14P9bUmM2+YA
         W4FZOH0vLR1ajDbqc9c+1PEFR+LZdQQVjIKjOgKGbKXt+KQsd0bpoX4Or8ZGAjoyuUaw
         BK12XFPaeIaL5KF54u+cOcRhpltgfCg1qrFg8uCH4tuluQpWNuX4t2/L1MnYzLH7yzgg
         3yWurP03Ek8o/21OWTdczU3CPglB098PhXgcfADnmSD2a3L7jC+9z4R8CI6DfpGN90El
         0GKJik2/HN+hPH5D7U/fIF4WmCHQtVyZPBd9A96zay0VrxMyPp5hjcKZzQe7GxVkbyeh
         tb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786137; x=1731390937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqM06z+njLF7FAtLYNvhAE64PBnYV16u4ZqhF1r1t3g=;
        b=ba1x/DcSMWpOGkUP5ELahX9/EmceauLAuRI0A3xjlxq6u6PWoA+4C+beIfJxTp9N98
         pTeKTrEI74buHyExmLqzwFfp0GMic9tXkQxM8HZ+zX0qFyJvZsGCA+518hAX5SAwEqqT
         i1LsYaG68M/6CU2JdwqnPdVJvsT0EXguX8IsYXWgb6v+bjXqofnOTyRPsfKt8WHtsh+W
         7z6fOze9uZNNHnVdjs/ZJ13hv0SlhO1L8n0ARv1vmz8Z9GJxCV6QrxkDKmgyfZSgmABr
         Z/XSMUKSmOdcsbmPQ/Uzz9k0wVMMPUDVPzRptfrolOX8uxWdYZN3Bii8VuBLaSPxViXa
         JiLA==
X-Forwarded-Encrypted: i=1; AJvYcCVquIjizKRdm9GtKc+Q/73Kq+s1cjaRWH3SOOIBZkq/ZxByhrQSbiOsYhwQUJPtscnrK3Et76utNfhgq3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5yDz2w0ralpQTyhXcMtfKRa5vIWlgIGGo492rQ2aSpSOpQSj
	frmPVOHLm+5FvwHctopkqd7mPq8GDd3ktC0pKyCSZR+iiM8EbC+xcCuWTQ==
X-Google-Smtp-Source: AGHT+IFzwXympF+JOibyojurFfcbVMwrGzz1dED57CQe91tFRPmXumRPRTNTwts9jUYaudoUrQduDA==
X-Received: by 2002:a17:907:7250:b0:a99:33db:2035 with SMTP id a640c23a62f3a-a9e654d5e6emr1508894466b.26.1730786136709;
        Mon, 04 Nov 2024 21:55:36 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:36 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 16/16] staging: rtl8723bs: Remove function pointer ReadEFuse
Date: Tue,  5 Nov 2024 06:55:03 +0100
Message-ID: <92e249af89320d37a211397da7ccf82878359c60.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
References: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer ReadEFuse and use Hal_ReadEFuse directly to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 1dee02ecc396..b6c655e6747e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -159,7 +159,7 @@ efuse_ReadEFuse(
 bool	bPseudoTest
 	)
 {
-	Adapter->HalFunc.ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+	Hal_ReadEFuse(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
 }
 
 void
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index f2c079cebdd4..2d2de56d5df7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -887,7 +887,7 @@ static void hal_ReadEFuse_BT(
 	kfree(efuseTbl);
 }
 
-static void Hal_ReadEFuse(
+void Hal_ReadEFuse(
 	struct adapter *padapter,
 	u8 efuseType,
 	u16 _offset,
@@ -1745,7 +1745,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
-	pHalFunc->ReadEFuse = &Hal_ReadEFuse;
 	pHalFunc->EFUSEGetEfuseDefinition = &Hal_GetEfuseDefinition;
 	pHalFunc->EfuseGetCurrentSize = &Hal_EfuseGetCurrentSize;
 	pHalFunc->Efuse_PgPacketRead = &Hal_EfusePgPacketRead;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 23786701ef9e..2285e82ab7b2 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
 	u16 (*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 	int	(*Efuse_PgPacketRead)(struct adapter *padapter, u8 offset, u8 *data, bool bPseudoTest);
@@ -289,4 +288,6 @@ u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariabl
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
 void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
+void Hal_ReadEFuse(struct adapter *padapter, u8 efuseType, u16 _offset,
+		   u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


