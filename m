Return-Path: <linux-kernel+bounces-352148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702B991AB2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62531F22334
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBC184118;
	Sat,  5 Oct 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hChwPrAB"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585E17BB3A
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160499; cv=none; b=EidPeCc0dx77ntsSUERw+sQWmVBzy6r9D4kRbjFWHHyOBkOaKhKcU6ipxoi7nF7WHTHwNxP0CzEXfxACu7VqBem9TAKLeYCwar3K9Y9agQ8ivtWYNEqTEnnF8sKXDRMRUwBSceOezEsZoyIhU1pTkwoUVdBjgUsyF4ZfTuqIdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160499; c=relaxed/simple;
	bh=1NPyRFoXYsmzQmVr+4N2D8CkoGezEPggmbkJKOyKrvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA9JSIcNJuiRKcJG8vtaDw5CX+/AkBZERideo2Qj+9nXjkZNlzY0naRxwXJZ4Po7JLQ1YWLtjBm+P+ALsK9ECihIaxtTxLbp0txmhYQwx9ZTIUh73jWbPu0mo2dwInN2bkx+N5IC80yeOhdeJ9xDfV+HJ/Do6oL9rfweM5KFAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hChwPrAB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so2171412f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160496; x=1728765296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAmU5PIwu+h3iMbfgPqTdmPj591zU2oyZRmEuHd0hfo=;
        b=hChwPrABUlSgQN1bhKyekSwhJHqxNl5gYwKmwpxb3mh1YzhIlVHrH+fVHP0itGoKSK
         Xa1YZ46rEcVM35gxaB+9NCIaqc9Y5vULgYQY3JG2IgJXHzTjq4XBjiD3rmUNnrmiyHrX
         F58puFzDI/Mi1PEMmF9MFZWowaOLxQDiZ1RJec48exfQv/eqgLMTD9ODkSOXMMk2uQ6V
         hyKHMiShYjyBKFLBbQY0b6+M8HM0GdGUyeQoQrOZnZj5jB4eHCrw4sa1HO03PD2aCNtb
         AQogMD3mhhvpAOdyqVAHN8bC6cLEhoATIY4prh7jL/EahCgZvdN2/WsFZDYLxHtWCAtR
         nGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160496; x=1728765296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAmU5PIwu+h3iMbfgPqTdmPj591zU2oyZRmEuHd0hfo=;
        b=jvWJSNON5R13uxh73DyYo+WmCD4OdwXAxU75yvcA4Ja1aG14Sbq3FesgdtP/bb0m+O
         KpHEys/bZPhim85HFQssSoiBjYcZxRl9mYhh6US18HXJDKKM4yicc9ym/13WQT1tmgX/
         SMSX8HBB2gS1CaLQ828OGypGdm64peGtetRsTfoU6pL5XfM7p43cKibzrvVj1vI69YSY
         IeDQk15snaXiHUpvAfg39ThEmaMCHp2yj2zlZNipfowh75ZkKXs41mnZxhul88U9+Cik
         wkX4wMktDsRY6oW+74AinO7ntTdAUvbSom2wqYQB1hhHmh7D+RSwSYCOeso04gypZwlF
         uu0A==
X-Forwarded-Encrypted: i=1; AJvYcCXQdtrNoDWsL3E8nfr8Ug0Pm9aOrNff3wXzKNwO0QmGOnP9NXDjNbc/f788Jh94itcAFVNCyp5qGvP7TZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWCmqqXVnhb70ejRDG2g/YmF2/5n4VULWuikYQmmedeALqD9q
	nxJv+pmGud7od/Gyn26rSE/eJ0XUddWmZ42T1steBCJqKIdGj8Lq
X-Google-Smtp-Source: AGHT+IE3u2d/XA/BRxCRMYITyUm7hpGLoxbouAX4SbeqDTeKf+IbH0rR2gGGhqLu/isVMKOYqvE4vQ==
X-Received: by 2002:adf:8b16:0:b0:374:c69b:5a16 with SMTP id ffacd0b85a97d-37d0e8de89dmr3949246f8f.50.1728160496269;
        Sat, 05 Oct 2024 13:34:56 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:56 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 15/15] staging: rtl8723bs: Remove function pointer disable_interrupt
Date: Sat,  5 Oct 2024 22:33:58 +0200
Message-ID: <fee97dadc88bbdaebd82c99d0b6106d58315bd85.1727966761.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
References: <cover.1727966761.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer disable_interrupt and use
DisableInterrupt8723BSdio directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 716eefdf8ce2..11d75b1b1ea9 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -151,8 +151,7 @@ void rtw_hal_enable_interrupt(struct adapter *padapter)
 
 void rtw_hal_disable_interrupt(struct adapter *padapter)
 {
-	if (padapter->HalFunc.disable_interrupt)
-		padapter->HalFunc.disable_interrupt(padapter);
+	DisableInterrupt8723BSdio(padapter);
 }
 
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 91aac5d1c23e..a64b28bee019 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1259,7 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->disable_interrupt = &DisableInterrupt8723BSdio;
 	pHalFunc->check_ips_status = &CheckIPSStatus;
 	pHalFunc->SetHwRegHandler = &SetHwReg8723BS;
 	pHalFunc->GetHwRegHandler = &GetHwReg8723BS;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 3b35bc30ae37..5b52b0fd95f0 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,7 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*disable_interrupt)(struct adapter *padapter);
 	u8 (*check_ips_status)(struct adapter *padapter);
 	void (*set_channel_handler)(struct adapter *padapter, u8 channel);
 	void (*set_chnl_bw_handler)(struct adapter *padapter, u8 channel, enum channel_width Bandwidth, u8 Offset40, u8 Offset80);
-- 
2.43.0


