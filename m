Return-Path: <linux-kernel+bounces-393741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D99BA4A1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835D9281856
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55080170A31;
	Sun,  3 Nov 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN8UVv2+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD61632C9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621698; cv=none; b=qzL6Ce43RQppRfq20/aLFnuVNlEwnxEomY/Irre/mdN8/Y4lkTBFYG54DNp9qgcmbnV58lDoMXMa4xRDjm6t20CK4XMobwVhTJjCZgfiCr3eHanROCX2JK9ceBZo7vlrmdrWkHltlk6qR58IH3nzeryojMijeNwflqqMWi/Qnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621698; c=relaxed/simple;
	bh=TXNUYX1G4d7X/z31PaSM8Wlw23ty1yqTqroUAgdDSDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv47g0xOxQhneZZ50JIj9zo1d79v+87dtS5KdEi31LW0c8G+XZaZ463EQzLfBqOdrLf2oWG2/tA3SUprp7G0pQn3rwdNgHkir9dCwJ4I2fDcWPPEaZV8G9H20zKLAB1xXblE+PLqFMlsysTQyrmQO+oRpULAZw7jpz7+BdBi54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN8UVv2+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso4340502a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621695; x=1731226495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhludfnkOdE6Bkm5V0G70lBT/zEk61Bs7bh9/fZXf1g=;
        b=DN8UVv2+hSVd3AFRyvItOAB6C8FZhW0aDRjozMCfBK39rSsLcswb+caVVbebajqTDJ
         0Q0NQgzLMDX/SBAAitQjP3oCZ4/1i8UlhBXZ7dBc9e9Ea3s06hiAXvUxsIy1dkq91SDR
         GRSZ30cdAgVQu2t54lp5lQKpSdJkABt29QIXTBQkoavPxcBGTjf5Q7Wgh+2NxCPWo0j4
         8n3kWQSqZ44xHZN0PEk3o+7E/EH6VYqMDxDHq1C9C1wt/k8JGJtzsWPLoaZiSQ2hzSF1
         e1B3GEs7ORVwjPx9fAEfL9GGl16Z8yFctbSLWcuLnLz24FdGWh4wW5y71wP76UsgE2JC
         E+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621695; x=1731226495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhludfnkOdE6Bkm5V0G70lBT/zEk61Bs7bh9/fZXf1g=;
        b=pYSOjKPtTxvH3AT4WGBb/g/F1KijlNfqIAVaeqVnNY4toK4bycRGbj4JD6L4kwdgS3
         TJFobSRUW0TJDqbI/bdINv8JpFZAxPh6R2aT5tSrhgsY+bHxUaQODEhUUg44o9tdJxsU
         4iKupZZxN9aAJyCJYJ9wkxB9rthOPwpTOIIx7gpTwuR0z+ZugC43pVXr2+RNoiUX2dr+
         KAEaip160LnBkl+tP8hyskRzQNWHri32F2/mZPCD3gEYm7hEUXUxA8RKClMrxzwjk+v/
         44hvMsNydJcX8I2tli9yY0Pb23zDLOBTqlM1uK8hB1tYmZg+77ggstJwsE/5BOCqNPTs
         pxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtk1e6toAL4a4slXWCsCQ5YZsqShpETyVr3+ieBzIV2OH1KPMIDN89mEGpJiMEYhIcYurt/NqCjPjYzp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokSQbUpHw/0XswXUm6Kkhd9Rvt0AgU7dcsv2k4nQt2H7zVA1Q
	Crq0N5ZkZVoEVMdGkoqe5Jadz8cTkmzN26DaFF3KfMKoo+zShX3x
X-Google-Smtp-Source: AGHT+IF8rnO8fnO6ZDQKo2UpprEIvwcqWdLz4SsAM0c0LR/KMS1faKOQaWR/OqQWTObMB70VSR/+qA==
X-Received: by 2002:a05:6402:5109:b0:5ce:d264:3b75 with SMTP id 4fb4d7f45d1cf-5ced2643bbcmr1666147a12.1.1730621694716;
        Sun, 03 Nov 2024 01:14:54 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:54 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 05/13] staging: rtl8723bs: Remove function pointer check_ips_status
Date: Sun,  3 Nov 2024 09:14:26 +0100
Message-ID: <afcfbc2381d02a9f63a6ccc7acf4f31a24547488.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer check_ips_status and use CheckIPSStatus directly
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 7 +------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 11d75b1b1ea9..44fab4eecb5e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -156,12 +156,7 @@ void rtw_hal_disable_interrupt(struct adapter *padapter)
 
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
 {
-	u8 val = false;
-
-	if (padapter->HalFunc.check_ips_status)
-		val = padapter->HalFunc.check_ips_status(padapter);
-
-	return val;
+	return CheckIPSStatus(padapter);
 }
 
 s32	rtw_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a64b28bee019..1211b7b440cf 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->check_ips_status = &CheckIPSStatus;
 	pHalFunc->SetHwRegHandler = &SetHwReg8723BS;
 	pHalFunc->GetHwRegHandler = &GetHwReg8723BS;
 	pHalFunc->SetHwRegHandlerWithBuf = &SetHwRegWithBuf8723B;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 5b52b0fd95f0..e6f4c398f35f 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	u8 (*check_ips_status)(struct adapter *padapter);
 	void (*set_channel_handler)(struct adapter *padapter, u8 channel);
 	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
 
-- 
2.43.0


