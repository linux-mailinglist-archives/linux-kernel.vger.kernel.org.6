Return-Path: <linux-kernel+bounces-393747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA669BA4A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CEB281959
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37636189B9F;
	Sun,  3 Nov 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWWRB5oE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E299158DC0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621702; cv=none; b=Eh9GYiaCG6cKdP8LEJESZ3v1+eEo16VWOyaLRi6DWYPvaXHGu4WjuEVrJcJcsVg3rPf0qJOqrzTx4A0V4O/T/hJwL63KLJ9yf7HedFHapL6knrllkyfehWgF5muFp8t5oTvZCvgjmDQm10148+Jl3TgpHtJuPqxHow7gisEIh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621702; c=relaxed/simple;
	bh=iQqcpC8l3446T4k+RFti+09L/H09762bBP37GsGZh6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsaX2uer0Vkz1PYfWfy7o2fSxmKhQUHCMAds/81AvOIRWJIDSZblEF2KxggiFwb4Ipi8EI7eFJlBzHf0Xz2qaK3Eiznkpkd3TX/P3NNdALX1O09iWAK3AtF0zrVXEM6Kwc8OgAjrq5tB2vmh8ue1lrh8xGevrXYENiE+o1QbsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWWRB5oE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso1314007a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621698; x=1731226498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMZjBc+r0kNLu2PVzUZXnU+/3Ibb4mXMOKZIEO1uavY=;
        b=XWWRB5oERFzStEUjd0NIQNOnS2dfziVw6Q+y8XOb99u/9dIZuAzcSGd04G0Wr6tmH7
         bSo3MJkcrDu67YQWmdQJQL3qQEfiEHHkYL5s8n56xSVDWbwYQuP+6KR3pJGV3l959wva
         ZiFpyyCjTAgc5CgS4AhpdCwgi/RCxPgJ5v1LTy/+eLk9Zocehqoiu1XrmopyZLo0JU54
         2R9usHnzzL8Jcsev0KphnJm3ExFvgRH0FVk6AoVfoeDOqYj4qbiB+Cj/YSWZ0/KEUXdX
         TEVUuqUGI3FbZNmSS+qwhaBf0o9eE0d6dC1SrmBKsELpKq7R6Cjb4lIoT30itHj6yWfW
         7RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621698; x=1731226498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMZjBc+r0kNLu2PVzUZXnU+/3Ibb4mXMOKZIEO1uavY=;
        b=ftTqEtu9x345cZuNywZ9l0PvU0wTklSs1XWC72X7z3POx+XabSEvF1IhJhd/arntFz
         l07VQVPyNCr/gFNIL/o8D5wznL+4jmRTpZxep1CZzZPswNlR5APaMk3izbRL2LtsQcT8
         ln4xfBxkP5AEA1THrx01qy0kKJ8n++dLjGwFswBRgZppTQULfzd7pK5V7Vv00qWVlutu
         NZ5yEXi+XY0lzws7SfsPh6s/iG1oDoLQACJcqLG0oB9hhDtTm/XLyjBJVSBxIkljjy7u
         de704gLS8WT9BieOFQ6v4M43TZEaXuK3whq75cPF2RraegAehAOp+2q2Ucboci/Zmvv4
         dlkg==
X-Forwarded-Encrypted: i=1; AJvYcCUjufUJr/aTOSXR6UyYCXxTzUnfUpevkqpSSWN52oTe03EKbtZzpaLZ7x2EQg4OmGBEP/QVBp2uwfkM4ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXVzqG21nqVXEOjhXfLCOnfKQFXW0VRUBeebqr6+7ki9Cbm1Y
	MYVjJgbU2XBEPRyavKK1FLDRNq443wwdWuYR1O2sLMFXeKbC1AsJ
X-Google-Smtp-Source: AGHT+IGBy5duJ5lWb9Veb++sGyBb25th7PMvpJRjzpYSIRWDR/8RFcPdBnPT+/FIEiMz7zIosTuNDw==
X-Received: by 2002:a05:6402:518a:b0:5c9:76ca:705b with SMTP id 4fb4d7f45d1cf-5cd54afde73mr12042972a12.34.1730621697209;
        Sun, 03 Nov 2024 01:14:57 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:56 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 09/13] staging: rtl8723bs: Remove function pointer GetHalDefVarHandler
Date: Sun,  3 Nov 2024 09:14:30 +0100
Message-ID: <fc3d7390305b474e7149c087ad6e065d883e8447.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer GetHalDefVarHandler and use GetHalDefVar8723BSDIO
directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 4 +---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 3 +--
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index ec567ae99f10..e8b31b80917e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -130,9 +130,7 @@ u8 rtw_hal_set_def_var(struct adapter *padapter, enum hal_def_variable eVariable
 
 u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue)
 {
-	if (padapter->HalFunc.GetHalDefVarHandler)
-		return padapter->HalFunc.GetHalDefVarHandler(padapter, eVariable, pValue);
-	return _FAIL;
+	return GetHalDefVar8723BSDIO(padapter, eVariable, pValue);
 }
 
 void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index beb74a40e91e..b1b40f6077fe 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1219,7 +1219,7 @@ void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int l
 /* 	Description: */
 /* 		Query setting of specified variable. */
 /*  */
-static u8 GetHalDefVar8723BSDIO(
+u8 GetHalDefVar8723BSDIO(
 	struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue
 )
 {
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->GetHalDefVarHandler = &GetHalDefVar8723BSDIO;
 	pHalFunc->SetHalDefVarHandler = &SetHalDefVar8723BSDIO;
 
 	pHalFunc->hal_xmit = &rtl8723bs_hal_xmit;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index d6e8eb95d391..19aae9b0d400 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -170,7 +170,6 @@ struct hal_ops {
 	void (*hal_dm_watchdog)(struct adapter *padapter);
 	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
 
-	u8 (*GetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 	u8 (*SetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
@@ -316,4 +315,5 @@ s32 rtw_hal_fill_h2c_cmd(struct adapter *, u8 ElementID, u32 CmdLen, u8 *pCmdBuf
 void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
+u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


