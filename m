Return-Path: <linux-kernel+bounces-393743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC0E9BA4A3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9252A1C213D2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99C16D4E5;
	Sun,  3 Nov 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9jw99Ga"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4140165F04
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621699; cv=none; b=NV5gD8HuBaEMVF66mZhbYxK2R6ujvOgm/P8DbouJvvYM7mtDDmNu/h1oRE/vs7F7kLFH6YonBXiYzFAocSvBKa/wirKkJQxxF1zCv9xXK1Ve0406ZvbaXnq9W/VuMRUAxWddKWYOZu3gDdU6lLYIyEFYjw9p80oKxn+niKiJiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621699; c=relaxed/simple;
	bh=JwNgZndBBybwNcb1/UDOUG8ljerV5WFPQzgfwNxTMOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRqkPMRLATsk/o+0vCQHCKWyHL4EcdQa6M1KQyR6zAT/Xa5rZglwHVznkgAuLeqqgmBgTHlzODSwaRGqj9cisUWIOA5EANFxr07BxMCORBvHnjMbDc0HNrsuD6Zgq6awCuCLhrZAOwfYuAMEycGtDULcBxQa2Vw5c/wYX5dvsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9jw99Ga; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so3764198a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621696; x=1731226496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kki66qAN31IwWCYVmn/Vdq65sFoOxq/7bNbZORHqbvk=;
        b=E9jw99Gab34ROn4lpWL8lH/OOCywtH7U8ZGo5JdPI/LJy2qpvLchACrzZ8NJG9BCT7
         oOmbuYyFZIpBfYGfGMTQLJOOnK/Qz0WdXV62EknZVM86kZ+MI+13iNKqRXvg07Dccevn
         rpfHCvywmzD5D7CquSyrHCuzp9zxlMbh5rhBLzzNu5U/7dZAe0cICfkS3PyOARoYgxm+
         VihAhjvYXJF0P1WiI8GVNUp2h9uistjqmTA7tvdNACqSqBEoCK2YVvdMf+LIiLjls3Hs
         OTSJkrmpXB5oSTRcz31yPj3mn0wr6OPjBksYSC5W4yx8BJ8tcM8M2oqc5OSy0VJOVnqn
         FMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621696; x=1731226496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kki66qAN31IwWCYVmn/Vdq65sFoOxq/7bNbZORHqbvk=;
        b=kK4iKJXHtFHVCX8Dmin5q9vWFgFk3gmogSj3rdscUfsa5dfLHciOZuTqOQcQTqvh01
         Ol6JWgRn31l54BphSRHDipSEwZO9sOrXwxa6ObVUapZFhK2zGOHPxZsiUnk5btl0GLcP
         b4vWv64vlZlrQbbOBPshoCAY9rU1LdvPb5D6UW6gO5uMK/s3vsYnX1jlC3YXqtuLAzH1
         ATThnk+IwRU2NDibYAkr+6/S+/6rokp3Nzz7m3D6Cl/o5hJFdgPQGurom+EQWbf7AU0P
         x1fhTS+ycB1MdlfUMBtqcv6VEBCFIYtBC7IIpXx1BRLk50tWCsZDwtmzON1ltzPW5QlC
         GJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDTA7MC5kYp+SbX1oXSpv+m1b0KewEyxyFqnDwAZeFo7bExjdzoI0v0dhuDxwEj5YEsx0M4EfU9RhiL4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4fZsyDfZBcMKd36qkFeRcWh36mWviY4Ndz4ZOonGrSLAQtPZ
	+rpoQqBn438F/0ZACDDtC+WM2u9FZt7oFackH7dD0etM70klKqkF
X-Google-Smtp-Source: AGHT+IEutGTvnHY4bCjiFrE4H1xZ8yIGb4jNQJJNNuTsKy4xB1VWWw5eqMeYKupDc6meov/4Mz4/TQ==
X-Received: by 2002:a05:6402:3202:b0:5c4:14fe:971e with SMTP id 4fb4d7f45d1cf-5cbbf920567mr20974555a12.23.1730621695976;
        Sun, 03 Nov 2024 01:14:55 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:55 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 07/13] staging: rtl8723bs: Remove function pointer GetHwRegHandler
Date: Sun,  3 Nov 2024 09:14:28 +0100
Message-ID: <ace0c1f47d27d536083787a1334bf6cfafb18c03.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer GetHwRegHandler and use GetHwReg8723BS directly
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 756d6ed9232d..d7b29d08ff15 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -113,8 +113,7 @@ void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val)
 
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val)
 {
-	if (padapter->HalFunc.GetHwRegHandler)
-		padapter->HalFunc.GetHwRegHandler(padapter, variable, val);
+	GetHwReg8723BS(padapter, variable, val);
 }
 
 void rtw_hal_set_hwreg_with_buf(struct adapter *padapter, u8 variable, u8 *pbuf, int len)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 6333a0d23d43..d3f86d811879 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1185,7 +1185,7 @@ void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
  * If variable not handled here,
  * some variables will be processed in GetHwReg8723B()
  */
-static void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
+void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 {
 	switch (variable) {
 	case HW_VAR_CPWM:
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->GetHwRegHandler = &GetHwReg8723BS;
 	pHalFunc->SetHwRegHandlerWithBuf = &SetHwRegWithBuf8723B;
 	pHalFunc->GetHalDefVarHandler = &GetHalDefVar8723BSDIO;
 	pHalFunc->SetHalDefVarHandler = &SetHalDefVar8723BSDIO;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 439639f6616c..b53804fb186d 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -170,8 +170,6 @@ struct hal_ops {
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
-	void (*GetHwRegHandler)(struct adapter *padapter, u8 variable, u8 *val);
-
 	void (*SetHwRegHandlerWithBuf)(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
 
 	u8 (*GetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
@@ -318,5 +316,6 @@ s32 rtw_hal_macid_wakeup(struct adapter *padapter, u32 macid);
 s32 rtw_hal_fill_h2c_cmd(struct adapter *, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer);
 
 void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
+void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


