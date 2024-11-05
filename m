Return-Path: <linux-kernel+bounces-395941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C619BC525
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247F41F217F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB2202639;
	Tue,  5 Nov 2024 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhThCpAN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8002003D7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786141; cv=none; b=YjCl94r8jsCG14cHbeGwUaz7koFIeBpDWlPQ4YDSu/+PFqUOVgSedO9GUeDmNsQpa3BdBkAIKrtx5WiaAyV9vNyygTS2kM8qstsW7K4+kF81LGPhqezSdzld54/6ng9hkQG9d+fMxDlueKFINEYtCtlDWbHBJPZbyydnjLpzLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786141; c=relaxed/simple;
	bh=PcmsJXN0QMgmyVreRV96Z0XZnJhTALbi7MKREO5b/dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDTIaOVIqw1UkgLSsTgLucJPjQ15qE4cwgP5G5XimtqRhI/+imagrDFxh9au0QKB7S5arQE/cixDTaZ34u6xD56qbQdh14TRJ3ECWVZNPsdI3MgNp/SvZC7LgiNeG1jorjAwDRXslCSt5BvMyPN8NJjcIho6Ascn6D4jljdGOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhThCpAN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a4031f69fso797934766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786136; x=1731390936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvuMQJX2aiqCaksyW7T4UdubL+MpISHCMIaun7tvg8U=;
        b=OhThCpANAw/p7SvV7pIp0ohOxywtKLfStLsOtU0xdeiQ0m7NxUL2JZBZUYtokEqpKj
         ZWdIkyQlCGN8CVJgbWlol0yS8SY2cMYolD6LXgloDJCa6Au6nfbXVVWLKQ2fWufbke/r
         VCdM40mLV8GpUKKG1f/WlacthD1Lo2fVhkVVrqZYqVCRa/XRHKti1wVouq7pJnjNABje
         fPamSNOS1kiapLVDKT02GD76kQ+0DJFVm2/VD4/jnjVOc3aUzcg2gmWaZ44afF7Ys9cQ
         r5HerZAWV1Roh0g73FLiJYUfc+5r9bS5dI6Zyl21m4eQz9d7eUQDd0VpgA+VnWyI5ECX
         hDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786136; x=1731390936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvuMQJX2aiqCaksyW7T4UdubL+MpISHCMIaun7tvg8U=;
        b=HWt6sHmycyPuhT2bbeSLkOW1AtqaqFzOo1xBEvBo8wfdveUt8F2fAINHxaQEap9Os0
         osw1m8CGWXiiNE7m3JLIoFVnhWEfJWAi+TArw+h29epJQS3QsSN2x6IYq7mkYfWcrC3y
         1WWVtcsNGxxOcagGGK33QbVWx9puh8spFycVeAYfqzGnjFaik9wiPjXXSo8gEIaw/g7P
         iGZuRpy0xOtNVI17EvoZDvm3LCljg+y2r6+CwbkFmK8pHKykShZX4KhGjpbujpAqRGuL
         0/0q5MmYqUf4reWp0uiTFwmMRFYqSllVIonax160eadqnQxK+7KpncWp8D/ZR8SDzTz+
         G4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUPiuwgVjcabYNAnI/QrlhA+9+Ms0/R0Mf1I9wfYIgvA51o58lDn5ohL9XTHs+wFFmvvDyiFwDHIMkB35c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCIIuWJz4Fnk28dOeF9Ll1djgrbyYk3ou5qIsBeuuiLAtKHMM
	J0f0CguD1mXPvJWpYM4wQSEFUu3YRdkduLmU8XZ8ZECjFDMsDdZ7
X-Google-Smtp-Source: AGHT+IGqqiag8wzE2dcO682dhJw8kE28ETTMWcqFjkIy2RKzf0GCSxfDMNm4XcwbGTTUzVe18dlw2g==
X-Received: by 2002:a17:907:6d15:b0:a99:ecaf:4543 with SMTP id a640c23a62f3a-a9de5d8272dmr3630244066b.25.1730786136136;
        Mon, 04 Nov 2024 21:55:36 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:35 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 15/16] staging: rtl8723bs: Remove function pointer EfusePowerSwitch
Date: Tue,  5 Nov 2024 06:55:02 +0100
Message-ID: <0ab31bf7b4562104289d6965eb081aa47e1c3998.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer EfusePowerSwitch and use Hal_EfusePowerSwitch
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c        | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 8b671f8a7965..1dee02ecc396 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -77,7 +77,7 @@ struct adapter *padapter,
 u8 bWrite,
 u8 PwrState)
 {
-	padapter->HalFunc.EfusePowerSwitch(padapter, bWrite, PwrState);
+	Hal_EfusePowerSwitch(padapter, bWrite, PwrState);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 24d722bbc34a..f2c079cebdd4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -602,7 +602,7 @@ static void Hal_GetEfuseDefinition(
 #define EFUSE_ACCESS_ON_8723			0x69	/*  For RTL8723 only. */
 #define REG_EFUSE_ACCESS_8723			0x00CF	/*  Efuse access protection for RTL8723 */
 
-static void Hal_EfusePowerSwitch(
+void Hal_EfusePowerSwitch(
 	struct adapter *padapter, u8 bWrite, u8 PwrState
 )
 {
@@ -1745,7 +1745,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	/*  Efuse related function */
-	pHalFunc->EfusePowerSwitch = &Hal_EfusePowerSwitch;
 	pHalFunc->ReadEFuse = &Hal_ReadEFuse;
 	pHalFunc->EFUSEGetEfuseDefinition = &Hal_GetEfuseDefinition;
 	pHalFunc->EfuseGetCurrentSize = &Hal_EfuseGetCurrentSize;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index ae873147a561..23786701ef9e 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,7 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*EfusePowerSwitch)(struct adapter *padapter, u8 bWrite, u8 PwrState);
 	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest);
 	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
 	u16 (*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
@@ -289,4 +288,5 @@ u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariabl
 u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
+void Hal_EfusePowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


