Return-Path: <linux-kernel+bounces-395930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E609BC517
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C42B281BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAC20011D;
	Tue,  5 Nov 2024 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGAl1u9N"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00181FE117
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786135; cv=none; b=bObd6VzsVlMnhSYopRWEVv9J+eFGmntvrGJp8E81uawqWgaUV1NvznDP6kmK+ntTc67OEVNglWN43w0yo8LbUuiqYQHatDbRTxu1zNr2C4trtk20siAoysBionFvmvC8X2MA8oZFyyOc0nZgo2HqiSBoxY5Lf9H2zIqlyKph5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786135; c=relaxed/simple;
	bh=5ubW2P8nj31L3YwYGLfQkrwdfjsuU/5UNoEnXJk5TcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ1ILAle8h9yLX/V1V63aS0s3B2DB0pFC4vBvpPZbyYKqHIu93Q4qwtEwoAEbrKI8O05Fva76mzyee2xv7VpxR55xKezcnPRv2K7fko7dFt64oD9MxE/FLYDsn8Z5J2t1BwPxKFMLwftAOA0aEW8CWRUpYfN4GkSGzu97dQ6ipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGAl1u9N; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9acafdb745so867523466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786131; x=1731390931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVw8pc8RwLb6Pyd+jaXfJi+tviZifucpMgcZ8jtEoBw=;
        b=FGAl1u9NAZXsIQ6TgjAX8qv6mg6V3ugicLKp466T92/0c6WF8h5MiYv9ZqBzf0+SlD
         0EH6//faUlicr1k5R+L3Foa65hR1MrRfmKFbjvSlftIRBB6/Uf4O1Htbq5D5oUQ6VqUQ
         Kkbyx/UINSK3d1J4AdhO0nVDktSqLp/HSRZYJOpNmmlxLSZ0tVJAdOADc7hIZR+sAsRr
         xPk1lpRcVKlXWLa+W99Yrm9+r9AaWPWRYrX6YP2WfJkeVqcnKVbN+nphip9J/9Rjq52f
         jAZTYdSz1qDyUrgbkMj+3iyATyIgVad6Apt0WbBMeUXUGMNLzyPMfEF2hUG4R+f6LQfK
         8+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786131; x=1731390931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVw8pc8RwLb6Pyd+jaXfJi+tviZifucpMgcZ8jtEoBw=;
        b=GehRN4sCWx/SECw+CPI/HzuJkFOc3nAXMvTofoKl1KSjyYsYxRIGu+ElB3bJXjy60l
         Dc5jka8krvVi/qMFx5JV6Rg4KcKbQDm9t5pks8g98x48EEhnN/w0AfQzhXKFj+XrWe+b
         lx0jZyjECEmboW4Ju00oOulRTTgtsiuUQmgzbDJeKKzxQ6yigJYJSxZ9zvRzKY/4k9fK
         SmS96Su1EGllz3EkQytzEFrfDwQU3uyEn42XKbPuIFIX5oGMJzfh1nazMFAJalWni8SN
         Fej+vIKg44UOvK1OisTcA4hC2fRbOOQ2Ny84bAtQxAi+jO3HrW8N5lmh3Mt2bITCM6za
         ddng==
X-Forwarded-Encrypted: i=1; AJvYcCWl1SxHKDvilKd8gWnehtS/1kMJQA5F6HH8wz1dbBM6iNfAGynZeLLhX2PSL8MTCfbfjcaGbnH35aF2T/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyerc+OI9G9t8zZQxlPoxpzY/GmOEvYnRigLCmzPNCmZ/RYP3li
	1wZJg+ldtq2hk9MyGf+4uqjdvL/Abul7UkmSRn94Y6oU+sOyu0GY
X-Google-Smtp-Source: AGHT+IG8V8sNLLQdRs5cgx9f3X8DQT4oTzIIiDgCyDmgVhtu7NXy/zBTmrQLJ+4zUanOtciXpKOyAw==
X-Received: by 2002:a17:907:608b:b0:a9e:b28c:29be with SMTP id a640c23a62f3a-a9eb28c348bmr157920466b.33.1730786130944;
        Mon, 04 Nov 2024 21:55:30 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:30 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 06/16] staging: rtl8723bs: Remove function pointer hal_dm_watchdog_in_lps
Date: Tue,  5 Nov 2024 06:54:53 +0100
Message-ID: <313978b8c0f331200c1a8dc3382b01088930c0e8.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer hal_dm_watchdog_in_lps and use
rtl8723b_HalDmWatchDog_in_LPS directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 ---
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index af72e0fe6fc0..f3666b26ffe1 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -291,8 +291,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
 {
 	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
-		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
-			padapter->HalFunc.hal_dm_watchdog_in_lps(padapter); /* this function caller is in interrupt context */
+		rtl8723b_HalDmWatchDog_in_LPS(padapter); /* this function caller is in interrupt context */
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ff899a066b33..844ef4a80ad0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1744,9 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->hal_dm_watchdog_in_lps = &rtl8723b_HalDmWatchDog_in_LPS;
-
-
 	pHalFunc->SetBeaconRelatedRegistersHandler = &rtl8723b_SetBeaconRelatedRegisters;
 
 	pHalFunc->Add_RateATid = &rtl8723b_Add_RateATid;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 311a97c31518..1e2bed9ebeef 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*hal_dm_watchdog_in_lps)(struct adapter *padapter);
-
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
 	void (*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
-- 
2.43.0


