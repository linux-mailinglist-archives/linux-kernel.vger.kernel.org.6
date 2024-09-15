Return-Path: <linux-kernel+bounces-329705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8149794D1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1AE2839F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C8140E38;
	Sun, 15 Sep 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKDNzxH5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472F138490
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382470; cv=none; b=aA/ZTY1m+d8E+8Xi2jxF4VYu/UV9DYBlz6ZF1LgyzrFkdOVm1baPeE6O0HfY1xQD9K3Mh5FfAKhLIaI91qP519xT0PwZ+vY/KUcSElrGhT5PmBXqrXkHcZ3k8/2Urs9NFIHgFLzNORhiD2AxSyvae4XQSK0zbddcLGT1zwHM7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382470; c=relaxed/simple;
	bh=bm+in/bZDdZsW5nXDYNaRP5O//JBB6QrnQLOajvKobg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0M1kJe18LmAw7LJQQNXiBp/24XHYt07Z50oPRCtAI2GXj/kleV6F8oh/hGkLCpAm/a8G516fhQB+TMui4dUDhxYmTWK3JOltnTWPey3+rhC0Q6wC0Bmuwm6YZGPvbqs8OtXBd+8Eah92KTXilA/2bpNTq5EHHz7rqMg3SmB2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKDNzxH5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d446adf6eso310157266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382467; x=1726987267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm+krPeLY9fFAcvaYveFPeUshUV7bz2PqQAG4Jxxyls=;
        b=bKDNzxH5HLSu9eqgYpysxNCJcQ0pClCxiDK2lg4JFICYXxLlwkhFwEivRgqR3x7RfQ
         TCFTvM6X8MmZClz3qg3edFEay0Ti3wy2xOG/j+2pYj8/KCKQET5MvPE45UaA2zUfXAGu
         BFEc0XxLF62cHe26PYLLaaQCmcVO5JBnPMtya5YNK5Ay7E+EB8TkZ+TJag2ZAOGELO56
         inbzqq4jT0UamLR1tNa9sQfK8oNKHr2gN0czVBZ3cucpzZEJXzXduL0dP94u772oRRoa
         TCN+/PNM2XSqJ+HMKAUanhcZxdjxBS11Bm3QTSS5x+om3bPOwLGSVRPT3tWvKzPNd7b9
         zwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382467; x=1726987267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm+krPeLY9fFAcvaYveFPeUshUV7bz2PqQAG4Jxxyls=;
        b=JMoZQ2yZ3uRuxbFWk1EZCwPgRLhLeHvL6i64gIUJaw0KkqSjGSZ/9pAifuKpFGFuqG
         ZU8MGQLgLVIYOBfFxGa/c6RANktwxAP7KtwTLUhlgjqplLfsYQpEn59KtYz9a8Wz+AVz
         cyQfjJ7Uo59oTztiEYjuh/WfcG/P5NsWR7u8z3x/4L4NQkjIDwHkQiYuMDKpdc+U24FC
         rBZJ32+O2g+YvvFYia9pIizE/uhrJ4AlRMiTHeQWb0QNbAzODZrJgGCkAn8xebph68rc
         rJQTj3iApOeReqsmfqFfXLKrDgoCSi+yw4lWUb/hBG9i9aKf6D2h5XQgnMTsQx/udW8K
         tPGw==
X-Forwarded-Encrypted: i=1; AJvYcCXzWsydPahLiHoIcLrspUk/K/+K0GaoXMJug/v3io3oc7W3U6YAnjEiU+5Uaz7ccvvi610ADc5azaATQew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Pngo3D8Wv2YZdGNMuDoWKYQGUI4qPGNO1D4WJhAzESIceQa3
	4XRMZPm17rwniF1K/Ru13LCEQrtzE8JqzjrxkAvGll2uEH62X1nd
X-Google-Smtp-Source: AGHT+IGE5HTMbCYIzpxuBe7fuhRw7NH64mpLb1onb15wZ9MY3bfSQSVV464OieoNFhSmB+8uo2crDA==
X-Received: by 2002:a17:907:97cf:b0:a8a:906d:b485 with SMTP id a640c23a62f3a-a9047cad53cmr717861166b.26.1726382466739;
        Sat, 14 Sep 2024 23:41:06 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:06 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 15/17] staging: rtl8723bs: Remove constant result macro is_primary_adapter
Date: Sun, 15 Sep 2024 08:38:29 +0200
Message-ID: <72673acf8b0ada07530b0cb3705cde4cda5e752b.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove macro is_primary_adapter that returns always true to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 +--
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 ++----
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  3 ---
 drivers/staging/rtl8723bs/hal/hal_com.c       | 21 ++++++++-----------
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 20 +++++++-----------
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  3 +--
 7 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 84ce7307d8f3..a04c66a0e25e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1258,8 +1258,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter)
 
 
 	/* always call rtw_ps_processor() at last one. */
-	if (is_primary_adapter(padapter))
-		rtw_ps_processor(padapter);
+	rtw_ps_processor(padapter);
 }
 
 void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index cbdb134278d3..5ded183aa08c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -911,8 +911,7 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
 	rtw_os_indicate_scan_done(padapter, aborted);
 
-	if (is_primary_adapter(padapter) &&
-	    (!adapter_to_pwrctl(padapter)->bInSuspend) &&
+	if ((!adapter_to_pwrctl(padapter)->bInSuspend) &&
 	    (!check_fwstate(&padapter->mlmepriv,
 			    WIFI_ASOC_STATE|WIFI_UNDER_LINKING))) {
 		rtw_set_ips_deny(padapter, 0);
@@ -1589,8 +1588,7 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 		}
 
 	} else {
-		if (is_primary_adapter(adapter))
-			rtw_dynamic_chk_wk_cmd(adapter);
+		rtw_dynamic_chk_wk_cmd(adapter);
 	}
 
 	/* auto site survey */
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index dbfcbac3d855..6ddd73b9cb29 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -73,9 +73,6 @@ int ips_leave(struct adapter *padapter)
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 	int ret;
 
-	if (!is_primary_adapter(padapter))
-		return _SUCCESS;
-
 	mutex_lock(&pwrpriv->lock);
 	ret = _ips_leave(padapter);
 	mutex_unlock(&pwrpriv->lock);
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 492889c837d9..54d5225564e4 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -13,23 +13,20 @@
 
 u8 rtw_hal_data_init(struct adapter *padapter)
 {
-	if (is_primary_adapter(padapter)) {	/* if (padapter->isprimary) */
-		padapter->hal_data_sz = sizeof(struct hal_com_data);
-		padapter->HalData = vzalloc(padapter->hal_data_sz);
-		if (!padapter->HalData)
-			return _FAIL;
-	}
+	padapter->hal_data_sz = sizeof(struct hal_com_data);
+	padapter->HalData = vzalloc(padapter->hal_data_sz);
+	if (!padapter->HalData)
+		return _FAIL;
+
 	return _SUCCESS;
 }
 
 void rtw_hal_data_deinit(struct adapter *padapter)
 {
-	if (is_primary_adapter(padapter)) {	/* if (padapter->isprimary) */
-		if (padapter->HalData) {
-			vfree(padapter->HalData);
-			padapter->HalData = NULL;
-			padapter->hal_data_sz = 0;
-		}
+	if (padapter->HalData) {
+		vfree(padapter->HalData);
+		padapter->HalData = NULL;
+		padapter->hal_data_sz = 0;
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 0a3900548fd2..d675a5eeaddb 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -27,9 +27,8 @@ void rtw_hal_read_chip_version(struct adapter *padapter)
 
 void rtw_hal_def_value_init(struct adapter *padapter)
 {
-	if (is_primary_adapter(padapter))
-		if (padapter->HalFunc.init_default_value)
-			padapter->HalFunc.init_default_value(padapter);
+	if (padapter->HalFunc.init_default_value)
+		padapter->HalFunc.init_default_value(padapter);
 }
 
 void rtw_hal_free_data(struct adapter *padapter)
@@ -37,24 +36,21 @@ void rtw_hal_free_data(struct adapter *padapter)
 	/* free HAL Data */
 	rtw_hal_data_deinit(padapter);
 
-	if (is_primary_adapter(padapter))
-		if (padapter->HalFunc.free_hal_data)
-			padapter->HalFunc.free_hal_data(padapter);
+	if (padapter->HalFunc.free_hal_data)
+		padapter->HalFunc.free_hal_data(padapter);
 }
 
 void rtw_hal_dm_init(struct adapter *padapter)
 {
-	if (is_primary_adapter(padapter))
-		if (padapter->HalFunc.dm_init)
-			padapter->HalFunc.dm_init(padapter);
+	if (padapter->HalFunc.dm_init)
+		padapter->HalFunc.dm_init(padapter);
 }
 
 void rtw_hal_dm_deinit(struct adapter *padapter)
 {
 	/*  cancel dm  timer */
-	if (is_primary_adapter(padapter))
-		if (padapter->HalFunc.dm_deinit)
-			padapter->HalFunc.dm_deinit(padapter);
+	if (padapter->HalFunc.dm_deinit)
+		padapter->HalFunc.dm_deinit(padapter);
 }
 
 static void rtw_hal_init_opmode(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 0094eed6c32d..2b12a2313707 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -182,7 +182,6 @@ struct registry_priv {
 
 #include <drv_types_sdio.h>
 
-#define is_primary_adapter(adapter) (1)
 #define get_iface_type(adapter) (IFACE_PORT0)
 #define GET_PRIMARY_ADAPTER(padapter) (((struct adapter *)padapter)->dvobj->if1)
 #define GET_IFACE_NUMS(padapter) (((struct adapter *)padapter)->dvobj->iface_nums)
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index fc9b9c5efb50..aa608dee4464 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -633,8 +633,7 @@ void rtw_reset_drv_sw(struct adapter *padapter)
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
 	/* hal_priv */
-	if (is_primary_adapter(padapter))
-		rtw_hal_def_value_init(padapter);
+	rtw_hal_def_value_init(padapter);
 
 	RTW_ENABLE_FUNC(padapter, DF_RX_BIT);
 	RTW_ENABLE_FUNC(padapter, DF_TX_BIT);
-- 
2.43.0


