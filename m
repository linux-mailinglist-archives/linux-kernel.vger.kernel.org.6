Return-Path: <linux-kernel+bounces-393744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4B9BA4A4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813921F21BF8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F76185955;
	Sun,  3 Nov 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB0EUS93"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6D16A94A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621700; cv=none; b=Kb6zX3Ndcnt6xJxVRF0xpUs/3bAOKrcf/RzaSmh7L/4VhA2FnZR0XNw6amvCx0jGJ486Xv6zcF95vdpX/Z835Z2u9/MSSzscfAx5BnSznuR77KHLgOkhglVfRXEWeJU1oIxNqmn+ru3cdI672FAR9lAHlu5JZgqr59TceEhubGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621700; c=relaxed/simple;
	bh=foianf5GbEjiOynU1NgnOCC5X8SQZgug1oA9qxXf6a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlVMZV5fOViZehffn7dK4atAVAbV5ZJgb0BVFckAlswqZMcXkxcCSULcll6yUSjYne0soxK1tPlGRYia2qeKeVWdyuh+aATJqL6tc8Ek4e7pprrwBBHQRk6tJxqI2e/CUUlSyiaLk8nBEurwG8KepycFtqxLhhbsjXgAmb4rjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB0EUS93; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso1969130a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621697; x=1731226497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gM0cL0DTEnjbvAhRpIiouok/Vzfr6uGqtogpiF0AT4=;
        b=nB0EUS93fDarWhReu0Vznv/TPLuhqrtIaouSxD77GQOY+XuNnjeFh7MMjos3fbuugQ
         jH13uyss+jl/gMnbB+0VlyaodWINWMD8UGifZ97MvvXMtD0aIdC6WphWJPCNab7grHjj
         g4TUQUNYPdYE5lePM0fZjuhQzdTGixSeoB8qJAJ0GLbYA/2tuQa64ywLcXbPKqM5kV9t
         MQ89d1312F1gFDsNPcX2H2mpoATHLSsljW5aHMhkWKJwWdVbvgzqMzZquSDt+oMb4boF
         3Iy6P+Y1DsJXIrn+4e/A6gcY+YjKceYTSa2Js6vVjKq4aXKoAQDL3+xbwOCPvKPGsyWX
         NDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621697; x=1731226497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gM0cL0DTEnjbvAhRpIiouok/Vzfr6uGqtogpiF0AT4=;
        b=r5/YaH5KxLXVXqnB7nRpJAb6mltYwISMtOBImE87QUfUHZ20KSXTLvgTNNYkkKE7lP
         DyazA9LD4F7b427jGDZw1XRmz/tf8Lgxh/3f6bEqF4reeeexV4XizEWlgy7YoY3nB5Lu
         +8HEKgEx9W2+A3go+dlSUrZMZ3eV3G47j1GHMGkxsLJE6z6nX3Gtr/ygfaiJwGqUfQzm
         /FiqdX4DF2cb8uN6cBBMA0zLcdjpevl1XaiD3D9lnDlDMz+6I9r9ktPYxrhBmiCt/eNh
         tDE8qwRIRHhoymoY6+kTIFAYB1eAnjihwdu2434YglgTZL+KK/RQ6HNw60yUFS6n+gfq
         nQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCX9eyC1IlqnHKfBiD2l0dUvXAlHrt9A7XefqDx3n9IOwIgEqdLE0Xnpeb0E4yUKXz5OoGcnvslmoUadsP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8isZ+A3x757c5CQxcl/XcR7oDuP8T8Hs92TMx9hEFkb7zY9/
	PwPWYwzb1gwB790tUdkHKs0d9qUUjxs6rKtgNejjo2Hq3w8IHeemSzra/w==
X-Google-Smtp-Source: AGHT+IE16GFYIvZVlLNKzvZAYIvdHcwYwrO43A1tdLl67+tEtd2/urkRmMiGFvM/dxDBOjZCho5T2g==
X-Received: by 2002:a05:6402:3584:b0:5ce:caa1:ca86 with SMTP id 4fb4d7f45d1cf-5cecaa1cf32mr6005105a12.24.1730621696613;
        Sun, 03 Nov 2024 01:14:56 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:56 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 08/13] staging: rtl8723bs: Remove function pointer SetHwRegHandlerWithBuf
Date: Sun,  3 Nov 2024 09:14:29 +0100
Message-ID: <e8bd652b669961e8dfe331a3a27adca47309960a.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer SetHwRegHandlerWithBuf and use
SetHwRegWithBuf8723B directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index d7b29d08ff15..ec567ae99f10 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -118,8 +118,7 @@ void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val)
 
 void rtw_hal_set_hwreg_with_buf(struct adapter *padapter, u8 variable, u8 *pbuf, int len)
 {
-	if (padapter->HalFunc.SetHwRegHandlerWithBuf)
-		padapter->HalFunc.SetHwRegHandlerWithBuf(padapter, variable, pbuf, len);
+	SetHwRegWithBuf8723B(padapter, variable, pbuf, len);
 }
 
 u8 rtw_hal_set_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index d3f86d811879..beb74a40e91e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1204,7 +1204,7 @@ void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 	}
 }
 
-static void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len)
+void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len)
 {
 	switch (variable) {
 	case HW_VAR_C2H_HANDLE:
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->SetHwRegHandlerWithBuf = &SetHwRegWithBuf8723B;
 	pHalFunc->GetHalDefVarHandler = &GetHalDefVar8723BSDIO;
 	pHalFunc->SetHalDefVarHandler = &SetHalDefVar8723BSDIO;
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index b53804fb186d..d6e8eb95d391 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -170,8 +170,6 @@ struct hal_ops {
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
-	void (*SetHwRegHandlerWithBuf)(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
-
 	u8 (*GetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 	u8 (*SetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 
@@ -317,5 +315,5 @@ s32 rtw_hal_fill_h2c_cmd(struct adapter *, u8 ElementID, u32 CmdLen, u8 *pCmdBuf
 
 void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
-
+void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


