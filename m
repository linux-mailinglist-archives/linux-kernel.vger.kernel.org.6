Return-Path: <linux-kernel+bounces-393749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A29BA4AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6361C2091E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089F18A6CC;
	Sun,  3 Nov 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miLRTZ5c"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0481865E7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621703; cv=none; b=AydAd+qfWd68GmMafQHN1GaIS7ePp21Tm6Yeu7K/Mym7q9mV/D4Ix6n6wM92bVMY22KwG9LMrmQrMVlx3NYOWYb5r+g44VHobAOcPWbjLxQeOjKMtIikuvGLH1L71n6maRhTCI/pNxhSel8JmPVT/2DW4QTBXBAahXvSLJH5uvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621703; c=relaxed/simple;
	bh=jkK8jOTPw4ceO2WyllAi7vTxuRvpVOG1mCqa8/gQJ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kL8rEm02/jqceShimTUYLvCBW7wDMrKzmTqRzx38DOiUEr8PxqEO5CQ4upw+eotKY5EsAZfO8IenFry+zzPmoWdP5fgYGdQslyjQ4TC3c3Zp6bhP8jcPrB1RX/3JsR05aXIuQdsvsIMVSw4sA6cDTwhdXQ9hBmGoUz2wcIHai4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miLRTZ5c; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so247183066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621700; x=1731226500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKAdswjmHcute+NZI8i4OymPZIsBGcO1QIhXFS046nc=;
        b=miLRTZ5cyUqlzLuxG2ovPH5FAS2oGNjFmjJxi84ISuQzD1dKtmSpnha/xEDaLALzAr
         OupkNa4t6rc+n2xSBtaVCx3HNnzH0HixW/2PF7fKU3IhEef4tOj2HZAuxuluZ4RxCll4
         k6gf3w9fFuTNWHjA92AF6G+krxSW5ohx7yBU45VbTN1HD27C4HlHFm0NeCX1bvXBfxeD
         HBQdWu/QJ1AzOUqTp/CipNlfcEWAv6YjoqiiJjaYggCJPjs3PCJkv6alzXAEBqlsc67i
         yauOGAHbyqimysbLN5roNZjJTFfSGEN6HJ79tccV/DkPWxX4P+d+j6ZC58FsxJLM1uCL
         2XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621700; x=1731226500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKAdswjmHcute+NZI8i4OymPZIsBGcO1QIhXFS046nc=;
        b=dJm3r85Wh52pLcFUKsUuV4CQ5glPRjw5oIn8ltI443ngJ5asmHkgz8bb62BG5kLlR4
         uojaens1yxkBQ6/jPE3VKisoadn4PqHXnzPHU1LI1dATtETFh2pGdkSJWqETZglaQqEZ
         54x4ziUPNwmYFdD4d4D32mkjijGdqiQxrAuTMlmsAklnVcb9IikSXc2q4GDUDOnhrBpO
         NbBjWnwAr5CHPf+PUo8SJz5Gy2I5EPsHTLUKFZ/5/WUns+VePisYYXsiU2IdSAuhmBZr
         qmbyY1RavM5d8B1c0kc2DAzH5IrKCxnNYf5A0o7V7yG79brldDykU3yq89FLCzMZCLpA
         ya3g==
X-Forwarded-Encrypted: i=1; AJvYcCUEiK/spiQUeo9+4ipUAC2b05OSAuVxf7/DdDv2FGtF+EjwjXXHtwS/K+kIMkgFmRWhWRG9pJ7tK/Nt3M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EXplrF3lCgw6Ct9eGuYgXZx1eds2vMcj8C8jfLNJwt4erDxR
	nthGpRbWOYRZcMim+lNUAKeKxGFag4TIBPIInuOJ2ISFACuFdAHee9R8Fg==
X-Google-Smtp-Source: AGHT+IHAGZc+jJdciJW90mbaXsaA9+aX6wbsgFfRGCPVMrIq5s9KIscNPootxVjfas+RADlB9Bsh9Q==
X-Received: by 2002:a05:6402:5c9:b0:5ca:efe:10de with SMTP id 4fb4d7f45d1cf-5ceb9382a40mr10610643a12.30.1730621699641;
        Sun, 03 Nov 2024 01:14:59 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:59 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 13/13] staging: rtl8723bs: Remove function pointer hal_xmitframe_enqueue
Date: Sun,  3 Nov 2024 09:14:34 +0100
Message-ID: <aef8fb63ed9944dde468fe1a69e5a9c700a4f627.1730619982.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer hal_xmitframe_enqueue and use
rtl8723bs_hal_xmitframe_enqueue directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c     | 5 +----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h | 2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 7462b10fdc94..8b924961789e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -154,10 +154,7 @@ u8 rtw_hal_check_ips_status(struct adapter *padapter)
 
 s32	rtw_hal_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-	if (padapter->HalFunc.hal_xmitframe_enqueue)
-		return padapter->HalFunc.hal_xmitframe_enqueue(padapter, pxmitframe);
-
-	return false;
+	return rtl8723bs_hal_xmitframe_enqueue(padapter, pxmitframe);
 }
 
 s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 20dbaa995498..af9a2b068796 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1258,5 +1258,4 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->hal_xmitframe_enqueue = &rtl8723bs_hal_xmitframe_enqueue;
 }
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 697e22d1e535..7050520224ff 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -180,8 +180,6 @@ struct hal_ops {
 	void (*run_thread)(struct adapter *padapter);
 	void (*cancel_thread)(struct adapter *padapter);
 
-	s32	(*hal_xmitframe_enqueue)(struct adapter *padapter, struct xmit_frame *pxmitframe);
-
 	u32 (*read_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask);
 	void (*write_bbreg)(struct adapter *padapter, u32 RegAddr, u32 BitMask, u32 Data);
 	u32 (*read_rfreg)(struct adapter *padapter, u8 eRFPath, u32 RegAddr, u32 BitMask);
-- 
2.43.0


