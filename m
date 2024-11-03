Return-Path: <linux-kernel+bounces-393745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639D9BA4A5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A2B21137
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CC1F5E6;
	Sun,  3 Nov 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcdl7QW0"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834201714D7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621701; cv=none; b=GbOVc7gUuBWRWnRkfmWjlVtD3ikzt1gEe9dA3yPvTJ0SixMu0tbMNvEbW9FwVnCyPMPzr/IXAlyWGz4BWdGe14nkkJaDxYKQfG5HfrWo3PZIVBbdrlk2uXfOZjmWDb6/zmO8Nw88x/I9w0AsBx5hJNAG0dr8Dfe9JbtExcSAD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621701; c=relaxed/simple;
	bh=WvdiGCaxVVUYEgBqSVJnMlolDTeNPErLovjLDKdb43E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj4QmHlGOlEn/4QmKS+5MrB9H5PuN1GIm9aovW5pnvTfo+augaEK+j78jITXbQC62ttOy0mHAnHDM0rQjvb+8XGh1UylAbdYwYnuiS2b8S17e9yyvJSDJKYfPhAIZ7+Ll+0y9td6Op/rYC1yJgt3n2NPQkzcvckintjNjAp31cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcdl7QW0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9aa8895facso561895666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621698; x=1731226498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWg7e149C7FsdITnlVLLumGagoPJ2vVxsltogaRDfow=;
        b=Rcdl7QW0dfFFgFzHi/6PKMoa26DgebdbRHtvtInJXdyOhbuvSjt9k5i5iaz287Grt6
         cKMmRiGwuMMNDaxHqyrCLfCeCwU0O0PzrtmSywA9/6BLOBkzV2zx99brTYVLWEUawxQ7
         fLpkcDeEdMFyiQ/x26NnnR0P0yUqU9vdf7ercCQ2jF6OGmYLfOSKZEMkxdmaqfIEDrUs
         scj+BvW8LqH2LrZ1qHRa6GEkdGqTgKSHloiDacuUnFNxUbnXKU/F3Ac2zDblJ9v2H7Hh
         Dgk7AikHbD7Ur0bhosjQBAReZwMSvZolpbJ+R6mzZxlXFz+0iXL8ly62fWJNWQRFE6WT
         T96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621698; x=1731226498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWg7e149C7FsdITnlVLLumGagoPJ2vVxsltogaRDfow=;
        b=NcmXZlkhGaiS/RJlefZNQV5p7YsrNuRSkfQWVR4GnGGltne210+rgJH6leB+75e0hV
         G6hZlwmZ0NcuJ3VG+00NlEQTeIFBYFWCP/8uGhFatVexjHT3Tmh6vyVLofysid0ALynm
         coFrP1/YJ3lBtEKekqopMM+g1a5zQXSX2sHRZur19epJt21wN4Ts2zpEy2nZ6jYFPPSY
         ILud9/D2RX/qOlPFitPFOrfCUwKccWu7WG3VbBsey1O2xcf3oRhcrfmnCheURfJyu5ei
         UeSKqvhkweiIEZ2hn7CmeJDJ01beuyD3/p9iJH6HhcweHyfF6glG3JrHqvAw2uy7y90z
         K4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPhLBzX3fIuhhjH00VeE8h4F0tvWNwLNJZepl3DUk7IZ7of0edSqTm2E7gzpA7+wtkGeBG0AIwuSYsb/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROiSFO1adDTgw/n3iOK7+dbsoIe/NDtzvOFPuoC6y7VZnBAnL
	GLq3FJ9b1hykfuAsg8ApNajM9F52OUEXhs1OvfATcZeCBeWiblUn
X-Google-Smtp-Source: AGHT+IEuxr1oj7dC/XJZuFzAE/uA20NlwaalxktRYv2bsG3PFA+4Xepe5F/VipkNkkxteyrz4TnHAw==
X-Received: by 2002:a17:906:6a09:b0:a99:ffdb:6fef with SMTP id a640c23a62f3a-a9de61cef8amr3051400266b.46.1730621697851;
        Sun, 03 Nov 2024 01:14:57 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:57 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 10/13] staging: rtl8723bs: Remove function pointer SetHalDefVarHandler
Date: Sun,  3 Nov 2024 09:14:31 +0100
Message-ID: <7a6c87ca6b746392517275eb4f6837c0ccaabff1.1730619982.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
References: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer SetHalDefVarHandler and use SetHalDefVar8723BSDIO
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 4 +---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 5 +----
 drivers/staging/rtl8723bs/include/hal_intf.h | 3 +--
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index e8b31b80917e..d45dfa8e638e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -123,9 +123,7 @@ void rtw_hal_set_hwreg_with_buf(struct adapter *padapter, u8 variable, u8 *pbuf,
 
 u8 rtw_hal_set_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue)
 {
-	if (padapter->HalFunc.SetHalDefVarHandler)
-		return padapter->HalFunc.SetHalDefVarHandler(padapter, eVariable, pValue);
-	return _FAIL;
+	return SetHalDefVar8723BSDIO(padapter, eVariable, pValue);
 }
 
 u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index b1b40f6077fe..ccf1e9727846 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1247,8 +1247,7 @@ u8 GetHalDefVar8723BSDIO(
 /* 	Description: */
 /* 		Change default setting of specified variable. */
 /*  */
-static u8 SetHalDefVar8723BSDIO(struct adapter *Adapter,
-				enum hal_def_variable eVariable, void *pValue)
+u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
 	return SetHalDefVar8723B(Adapter, eVariable, pValue);
 }
@@ -1259,8 +1258,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->SetHalDefVarHandler = &SetHalDefVar8723BSDIO;
-
 	pHalFunc->hal_xmit = &rtl8723bs_hal_xmit;
 	pHalFunc->mgnt_xmit = &rtl8723bs_mgnt_xmit;
 	pHalFunc->hal_xmitframe_enqueue = &rtl8723bs_hal_xmitframe_enqueue;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 19aae9b0d400..b69d201b6826 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -170,8 +170,6 @@ struct hal_ops {
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
-	u8 (*SetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
-
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
 	void (*UpdateRAMaskHandler)(struct adapter *padapter, u32 mac_id, u8 rssi_level);
@@ -316,4 +314,5 @@ void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
 u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
+u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


