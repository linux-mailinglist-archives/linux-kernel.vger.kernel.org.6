Return-Path: <linux-kernel+bounces-395932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13E29BC51A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A3BB215F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5CF200132;
	Tue,  5 Nov 2024 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxk+Gl98"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93A1FEFAB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786135; cv=none; b=Hxa7PNkEGoEmdHswcBmEZnWJ0qtrrZLM9W+tP/yIK7uAecCnJpBDsot/gbtSQapSdbZk6KPQaIffDgEGdxZbZ4k0dHT8yNkqjw8Gcn2JdwYg0wWkcSrto8DIYn2GoyFuxVEgeuq07WgLmY+91NQL2UT91zl3dAv1Jq+b3OsEPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786135; c=relaxed/simple;
	bh=TTGVCQGQFr4YXw/oF7vJ03ZJrq7NoK3BksPLgwn8d7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzaEJOH823OvrB8zobMeUQa23Gfr439tfXVhEfVpF4QNlMLribc0OO0arAQ4kYrCQQPxDv6G2ZPtqdmPj9WvXKP0xJijg366iv9wqlLGqQUSIg3gU6ewD04RnR0nHpKDM2h7cbYkTShJ+rHumT9gBdNSdNDkIqKlDdyPpS3aYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxk+Gl98; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cb74434bc5so5916389a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786132; x=1731390932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEmkvwR7yW6qeFeP3oE/KKsUKrsSjbt8xvDhetIbI+I=;
        b=Fxk+Gl986S/ou31XEWQFPFFV024ziT70OZkGA5J3bPKOMQPdB46UZW+Zv9o0FiDKtJ
         d6j98GdrX1KBWe0TW/y7Cipp2hJD60VbFzQa/X1ApzcmJ+wvvbD9AhxmZuOt4VKoeup2
         niCxTnzGDF++nccuDc98Sky0V5hM0blNKmfWb99Unf+6BrW+5r9LBtqXz0hMUUGf+j3J
         gaQSD6Hcljaa/tfXVh8CqVbRdCwqk1X835kIpOSJCA8YVlkfxdwydG34CHhLD4UnS1ha
         31p7yZ/gCIAz6rKnaT8wxjzRJ+YdIOU2OGDH/ei+VcQBhckQHzQYfTKfJ6TU5N+YzDRN
         8hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786132; x=1731390932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEmkvwR7yW6qeFeP3oE/KKsUKrsSjbt8xvDhetIbI+I=;
        b=QCUWfGXESGR/dWQlSfnVlHO7vXE39uoWpFb/XCozaq1XSHJuj5uMr2K31X542cjBbT
         nhsvOb6ycGNDwCEYR62kQD0qjuYGf3C26Og2mYecC6orWBgjC6+vI9ZV3m+abYHXjhdk
         X4F5cPnA19saAkJgFGi7E8D5iA88iN67GfQyPHLI+r7eIddl0D84U0a9rcrGWSYTuFZE
         Ssjt6MrGdVsDx6KRXv/NxieyjKZMhZLg3/XgW3M8/tyuGC3BXa/uh1NIC3+hH+McaokF
         Nrc/dqIhAKQdXtb7rXS94ObzU4nUmtQe8JKH8mJyU8WyKsdBWecpckmbKbozQ5q1FfiD
         xmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmwxIOHwhv210OmUnD3Ir9D1owqzgxvzzQGdl1gKQKYFB+qkNoB7/0Yhd1JmsgXakKkFSOoGXO+f3xXuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVzL8Urwup1oyK4O9yEBvxAAOHNG783XznUkUhVzjHXa5k4p7
	OM/jp02jPzK3e/e0HNiSzHv4sjFBRi9yOo1B10ARoD6HLyUHjGwd
X-Google-Smtp-Source: AGHT+IGF+J4gLfIlwE3tvzL7ikt/ElZeoDGvUzwpQikuyHX6/KURvVRMaGHX2UxDxoQSI9EDaiJuQw==
X-Received: by 2002:a17:906:114e:b0:a9e:93fb:3d5b with SMTP id a640c23a62f3a-a9e93fb3e5fmr620376666b.19.1730786131490;
        Mon, 04 Nov 2024 21:55:31 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:31 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 07/16] staging: rtl8723bs: Remove function pointer SetBeaconRelatedRegistersHandler
Date: Tue,  5 Nov 2024 06:54:54 +0100
Message-ID: <4c5eb3b6e6ad0015c97d89df637253318c18b520.1730749680.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer SetBeaconRelatedRegistersHandler and use
rtl8723b_SetBeaconRelatedRegisters directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 +---
 drivers/staging/rtl8723bs/include/hal_intf.h      | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index f3666b26ffe1..483f0c163bef 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -297,8 +297,7 @@ void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
 
 void beacon_timing_control(struct adapter *padapter)
 {
-	if (padapter->HalFunc.SetBeaconRelatedRegistersHandler)
-		padapter->HalFunc.SetBeaconRelatedRegistersHandler(padapter);
+	rtl8723b_SetBeaconRelatedRegisters(padapter);
 }
 
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 844ef4a80ad0..64eb1786d8db 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1625,7 +1625,7 @@ static void _BeaconFunctionEnable(struct adapter *padapter, u8 Enable, u8 Linked
 	rtw_write8(padapter, REG_RD_CTRL+1, 0x6F);
 }
 
-static void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter)
+void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter)
 {
 	u8 val8;
 	u32 value32;
@@ -1744,8 +1744,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->SetBeaconRelatedRegistersHandler = &rtl8723b_SetBeaconRelatedRegisters;
-
 	pHalFunc->Add_RateATid = &rtl8723b_Add_RateATid;
 
 	pHalFunc->run_thread = &rtl8723b_start_thread;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 1e2bed9ebeef..2df25c1e7b5d 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,8 +164,6 @@ typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 struct hal_ops {
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
-	void (*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
-
 	void (*Add_RateATid)(struct adapter *padapter, u32 bitmap, u8 *arg, u8 rssi_level);
 
 	void (*run_thread)(struct adapter *padapter);
@@ -300,4 +298,5 @@ void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int l
 u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
+void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
 #endif /* __HAL_INTF_H__ */
-- 
2.43.0


