Return-Path: <linux-kernel+bounces-352146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBEC991AB0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F44B225DD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3C18308D;
	Sat,  5 Oct 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiBW5XFt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22275179967
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728160499; cv=none; b=fovhuPszRtYehmFjJvOKB4h/8aMezOsjnYjDNdQWjd3VNUjY80wCe6RAUJ3Lunq4w2wXd/6t4LLKxwE3/RrPOaww22ZiaqlSBTR7Ywt99oq6QVnLhc0cipxACh+ieooHY7b2dYtW6N0/HJlJ3vbDJPQFZaJ4CIv5+6Z14FAL0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728160499; c=relaxed/simple;
	bh=v/0CCal0XeJHTxlmTvs+auc6waxNoKMfAJtePcsbDrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrBn/rv5jdjMsRHk1DTC+dPV533aM0SKs1NHLVhs0WW504ohOhnzqxvAtdnoz4n0WkhZBOpNZc+TEp7GLIxbi+wMAK5YW/hV3YVWlCAR+t+TYfaaMtVvczcS9rPFUwZWE244cPJ9wRAsN+sHtskP8F6tyraS6V9fnLmyXmBhSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiBW5XFt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb806623eso28061565e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728160495; x=1728765295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylO/EeDKWQv57ntwn5IyR8C+2g+4AGbXBkezjN5eRTg=;
        b=PiBW5XFtOuCKlRDQpRL06cVeeTEDzUnAbhju5EoNB0oCrgSd3PEs/8c5rWlIweUz6W
         vwrVttTp3U9/FC8s34T2bsnFo7EtTzHThtQTCW9XS9hTzKBMl41iM5JxGbtnqKoVa0UJ
         SXLpZYHvdwx9E9AwPi4Uw4HTDFdM1oIu+ShBkDSWmZURLv3Sf/eo1i8kAAOMgG746vdQ
         5qD8mRZ8hiwxtNOaiNbPAh2Res60LO6FrjK+Y4j5STeyWpUrfHjwxduLrUfcfLjc7Wf7
         4o5bf9zy5HNjg3BgakcArdPdmXnzjHb9bQELCRbRkmubaVpuY0AXBeQbsmHYo6q1Z5LF
         8YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728160495; x=1728765295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylO/EeDKWQv57ntwn5IyR8C+2g+4AGbXBkezjN5eRTg=;
        b=bX7hAeaNPdJc5XgNKwV46gk+ZthSXCofT7ic8DumksD3Y+g3ZCHmpeS+ABeU4Zt+z/
         ERxBGB2YNx6bMa4vfuKgbWC6LUAeK/Hm0QE0jJ1lzxxPwFyY2jjjfeYjjX/zlmlhav0u
         rGpSlCLjt/szCuk77cDbBqjXH5To0SBE7/QgnDhhBDW4F2lIDvBdD1XewmIhn3eyAyNH
         UThR36tV4YMfQhZHQjP2LyedUktnrnxznbwgHX3BoXTiMKc8yUQDaZn3h6GlwrMvUPHY
         3ZEixOodt6xj/DispnLPgjKve/HCF2VCP1XyY1zqw3P6LPrXgEiW/CP2um+g6T938sPz
         mNqA==
X-Forwarded-Encrypted: i=1; AJvYcCWRHmH3gT2hI1khq1839bT3cy5hjxeRJg5NrsMExEFEBfIvavjprd+avttPeLG1cYPWdXO4tLwFQhNpFb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxNpgIOP7qxCNNKaROwECPtQqNB/tOyslgkgGEEOny2kMqSg/
	41AxSELIaP2tAikTRl5SNKaZopRJsDcW+cZGw2sGA06qLM93vnLO
X-Google-Smtp-Source: AGHT+IHvJeJsMbNiPNPQjxQo5TSvsoA/+nIbfZH582r6HxcKE+mW9CKhVzuN1faSrVgzZIwzCrLxAg==
X-Received: by 2002:a05:600c:3ca6:b0:42c:c1f6:6ded with SMTP id 5b1f17b1804b1-42f85af8a7amr53617885e9.29.1728160495192;
        Sat, 05 Oct 2024 13:34:55 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85995932sm41824805e9.0.2024.10.05.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:34:54 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 13/15] staging: rtl8723bs: Remove function pointer read_adapter_info
Date: Sat,  5 Oct 2024 22:33:56 +0200
Message-ID: <24eec4df528051fee3cf850308e009f114e14288.1727966761.git.philipp.g.hortmann@gmail.com>
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

Remove function pointer read_adapter_info and use
ReadAdapterInfo8723BS directly to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 3 +--
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 4 +---
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h | 1 +
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index ec95d3ec3170..efc4b44caad3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -14,8 +14,7 @@ void rtw_hal_chip_configure(struct adapter *padapter)
 
 void rtw_hal_read_chip_info(struct adapter *padapter)
 {
-	if (padapter->HalFunc.read_adapter_info)
-		padapter->HalFunc.read_adapter_info(padapter);
+	ReadAdapterInfo8723BS(padapter);
 }
 
 void rtw_hal_read_chip_version(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 6a56a5db5a5f..a6766a98042c 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1132,7 +1132,7 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 	return _SUCCESS;
 }
 
-static void ReadAdapterInfo8723BS(struct adapter *padapter)
+void ReadAdapterInfo8723BS(struct adapter *padapter)
 {
 	/*  Read EEPROM size before call any EEPROM function */
 	padapter->EepromAddressSize = GetEEPROMSize8723B(padapter);
@@ -1259,8 +1259,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 
 	rtl8723b_set_hal_ops(pHalFunc);
 
-	pHalFunc->read_adapter_info = &ReadAdapterInfo8723BS;
-
 	pHalFunc->enable_interrupt = &EnableInterrupt8723BSdio;
 	pHalFunc->disable_interrupt = &DisableInterrupt8723BSdio;
 	pHalFunc->check_ips_status = &CheckIPSStatus;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 1932f93d89c7..ed303a623e1b 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -162,8 +162,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	void (*read_adapter_info)(struct adapter *padapter);
-
 	void (*enable_interrupt)(struct adapter *padapter);
 	void (*disable_interrupt)(struct adapter *padapter);
 	u8 (*check_ips_status)(struct adapter *padapter);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
index dbd051a34d90..783f64de0aec 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
@@ -90,5 +90,6 @@ void rtl8723b_process_phy_info(struct adapter *padapter, void *prframe);
 void rtl8723b_read_chip_version(struct adapter *padapter);
 void rtl8723bs_init_default_value(struct adapter *padapter);
 void rtl8723bs_interface_configure(struct adapter *padapter);
+void ReadAdapterInfo8723BS(struct adapter *padapter);
 
 #endif
-- 
2.43.0


